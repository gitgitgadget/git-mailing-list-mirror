Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082F62018E
	for <e@80x24.org>; Fri,  5 Aug 2016 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758809AbcHERuu (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 13:50:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759856AbcHERur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 13:50:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D66F30078;
	Fri,  5 Aug 2016 13:50:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTn2aKuxK3hdUxoSGDK2Ta2VaNw=; b=QxGfe/
	t3Zm6W3jV73Lnaq236IGudt+TmbmtjiCUw/iboKH/oPz2e1DRt8mN9A3kaX38Dsr
	9aEGD9wQWONk1wl8u1iKnIaQ/OQv33hYWe+lv52Xtrin69NIxxhvyNFo5v1rla6r
	nm3Lqp6KExjMGk6/7uvQm7Jrq67H4sw2EfC9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IcF58Gv0OSPOoEpbrMjYn0eFg+s392TS
	ryZ/hDSfKmg3jzDuHLlLA6OYMlDurFVobPyAeHE1oxoZmefpNGZjB6LNV9Drm3OF
	aeI4n8sp5/fE8xxT2Jlf5unayhse2UbivFV8v6hX9GOgX9/0JP7E3M2a1glWclBI
	2xxpcm2aSEI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 55C2730077;
	Fri,  5 Aug 2016 13:50:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B97F330075;
	Fri,  5 Aug 2016 13:50:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 7/8] git-status.txt: describe --porcelain=v2 format
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
	<1470147137-17498-8-git-send-email-git@jeffhostetler.com>
Date:	Fri, 05 Aug 2016 10:50:42 -0700
In-Reply-To: <1470147137-17498-8-git-send-email-git@jeffhostetler.com> (Jeff
	Hostetler's message of "Tue, 2 Aug 2016 10:12:16 -0400")
Message-ID: <xmqq60rfxfyl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22454ED6-5B35-11E6-AC55-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> +Porcelain Format Version 2
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Version 2 format adds more detailed information about the state of
> +the worktree and changed items.  Version 2 also defines an extensible
> +set of easy to parse optional headers.
> +
> +Header lines start with "#" and are added in response to specific
> +command line arguments.  Parsers should ignore headers they
> +don't recognize.
> +
> +### Branch Headers
> +
> +If `--branch` is given, a series of header lines are printed with
> +information about the current branch.
> +
> +    Line                                     Notes
> +    ------------------------------------------------------------
> +    # branch.oid <commit> | (initial)        Current commit.
> +    # branch.head <branch> | (detached)      Current branch.

In an earlier review I made a noise about "branch.head", but reading
this together with others in a context, "branch.head" is good and I
do not see a need to bikeshed it into "branch.name".

> +    # branch.upstream <upstream_branch>      If upstream is set.
> +    # branch.ab +<ahead> -<behind>           If upstream is set and
> +                                             the commit is present.
> +    ------------------------------------------------------------
> +
> +### Changed Tracked Entries
> +
> +Following the headers, a series of lines are printed for tracked
> +entries.  One of three different line formats may be used to describe
> +an entry depending on the type of change.  Tracked entries are printed
> +in an undefined order; parsers should allow for a mixture of the 3
> +line types in any order.
> +
> +Ordinary changed entries have the following format:
> +
> +    1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
> +
> +Renamed or copied entries have the following format:
> +
> +    2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><nr> <path><sep><pathSrc>
> +
> +    Field       Meaning
> +    --------------------------------------------------------
> +    <XY>        A 2 character field containing the staged and
> +                unstaged XY values described in the short format,
> +                with unchanged indicated by a "." rather than
> +                a space.
> +    <sub>       A 4 character field describing the submodule state.
> +                "N..." when the entry is not a submodule.
> +                "S<c><m><u>" when the entry is a submodule.
> +                <c> is "C" if the commit changed; otherwise ".".
> +                <m> is "M" if it has tracked changes; otherwise ".".
> +                <u> is "U" if there are untracked changes; otherwise ".".
> +    <mH>        The 6 character octal file mode in the HEAD.

We do want "octal" to be spelled out, but I doubt that we want to
guarantee to the reading scripts that this will always be 6
characters.

> +    <mI>        The octal file mode in the index.
> +    <mW>        The octal file mode in the worktree.
> +    <hH>        The SHA1 value in the HEAD.
> +    <hI>        The SHA1 value in the index.

Please avoid inventing a word "SHA1 value" that does not appear in
Documentation/glossary-content.txt; s/SHA1 value/object name/g.
This comment applies to the desciption for "U" lines below, too.

> +    <X><nr>     The rename or copied percentage score. For example "R100"
> +                or "C75".

Documentation/diff-format.txt seems to call this differently.

	The rename or copy "score" number, e.g. "R100", "C75".

perhaps?

> +    <path>      The current pathname.

Unless you are talking about "2" line, saying "current" is somewhat
weird.  I _think_ <path> is the name in the index and in the working
tree, as opposed to the original path in the HEAD, but the
distinction does not matter for "1" or "U" lines.

As this table is meant to be shared between "1" and "2", perhaps

	<path>     The pathname.  In a renamed/copied entry, this
		   is the path in the index and in the working tree.
	<origPath> The pathname in the commit at HEAD.  This is only
                   present in a renamed/copied entry, and tells
                   where the renamed/copied contents came from.

or something like that may clarify it a bit better.  Then in the
table for "U" lines, we can just say "The pathname".

> +    <sep>       When the `-z` option is used, the 2 pathnames are separated
> +                with a NUL (ASCII 0x00) byte; otherwise, a tab (ASCII 0x09)
> +                byte separates them.
> +    <pathSrc>   The original path. This is only present when the entry
> +                has been renamed or copied.

If it is explained as "the original path", wouldn't it be easier to
read if it were called "<origPath>" instead of "<pathSrc>"?

> +When the `-z` option is given, pathnames are printed as is and
> +without any quoting and lines are terminated with a NUL (ASCII 0x00)
> +byte.
> +
> +Otherwise, all pathnames will be "C-quoted" if they contain any tab,
> +linefeed, double quote, or backslash characters. In C-quoting, these
> +characters will be replaced with the corresponding C-style escape
> +sequences and the resulting pathname will be double quoted.

Looks good.

I think I saw "C-Quoted" elsewhere (perhaps in a in-code comment),
which should be spelled consistently i.e. "C-quoted".

Thanks.
