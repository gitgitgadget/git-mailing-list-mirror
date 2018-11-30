Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B044211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 02:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeK3NYU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 08:24:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53174 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3NYU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 08:24:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7CC1110CB3;
        Thu, 29 Nov 2018 21:16:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cVJTAKYO5p8m
        4uuj1hvQOTLhSfc=; b=yM9nj9Zm6AZf8xzByftH/QqVsQxT0pUZUmoqI7BiYg/p
        zQ1ARP7N/BtojiROfdxJDjC2ershdq1iKGgS39Me26VPXrIQ/rapPedxObP6mQBA
        0iACPxoE0Y3R6TzzRCAReahHqHDIQKUTAHpFeu2RwJmLGec4qzy6zYH8+I6G3Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=f9t1y/
        psW9lE1qETiCsT1HLSGyAcgKfW4TQMwsvT3+yVPq2G+mZIVCR10mF0j2PZGb/Ood
        FM0kURxzVlbs3MSjA5OWj/HfOL/ExDAIeNKcOMYqREpa5wS2Lc5zG60aV9FY2W+G
        wyGBC6eW/kfzUQsBOM3H5Suaj2Xp18sM09s30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E06CA110CB1;
        Thu, 29 Nov 2018 21:16:40 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D261110CB0;
        Thu, 29 Nov 2018 21:16:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sbeller@google.com,
        t.gummerer@gmail.com, sxenos@google.com
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
Date:   Fri, 30 Nov 2018 11:16:39 +0900
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 29 Nov 2018 22:58:35 +0100")
Message-ID: <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F90FC5A8-F445-11E8-A822-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> 'git switch-branch'
>
> - implicit detaching is rejected. If you need to detach, you need to
>   give --detach. Or stick to 'git checkout'.

OK.  Is "auto-vivify the named branch based on a remote-tracking"
also rejected, as it is a confusing behaviour that is a too subtle
and implicit, just like the detaching head is, and require --guess
or sticking to 'git checkout'?  I think it should.

> - -b/-B is renamed to -c/-C with long option names

I did not expect that these two are the only options that would be
out of place with the command name split, but presumably you looked
at all options for both of the two new commands to see if they made
sense in the new context?

> 'git restore-files'
>
> - takes a ref from --from argument, not as a free ref. As a result,
>   '--' is no longer needed. All non-option arguments are pathspec

OK.  That does make things easier to teach, as there is no need for
disambiguation.

> - pathspec is mandatory, you can't do "git restore-files" without any
>   pathspec.
>
> - I just remember -p which is allowed to take no pathspec :( I'll fix
>   it later.

Or leave it out of restore-files as a more advanced feature (just
like detaching with HEAD^0 is left out of switch-branch) that the
user can stick to 'git checkout' to use.

> - Two more fancy features (the "git checkout --index" being the
>   default mode and the backup log for accidental overwrites) are of
>   course still missing. But they are coming.

I am unsure about the wisdom of calling it "--index", though.

The "--index" option is "the command can work only on the index, or
only on the working tree files, or on both the index and the working
tree files, and this option tells it to work in the 'both the index
and the working tree files' mode", but when "restore-files" touches
paths, it always modifies both the index and the working tree, so
the "--index" option does not capture the differences well in this
context [*1*].  As I saw this was described as "not using the usual
'overlay' semantics [*2*]", perhaps --overlay/--no-overlay option
that defaults to --no-overlay is easier to explain.

    side note 1.  I think the original mention of "--index" came in
    the context of contrasting "git reset" with "git checkout".
    "git reset (--hard|--mixed) -- <pathspec>" (that does not move
    HEAD), which does not but perhaps should exist, is very much
    like "git checkout -- <pathspec>", and if "reset" were written
    after the "--index/--cached" convention was established, "reset
    --hard" would have called "reset --index" while "reset --mixed"
    would have been "reset --cached" (i.e. only work on the index
    and not on the working tree).  And "reset --index <directory>"
    would have worked by removing paths in <directory> that are not
    in the HEAD and updating paths in <directory> that are in the
    HEAD, i.e. identical to the non overlay behaviour proposed for
    the "git checkout" command.  So calling the non overlay mode
    "--index" makes sense in the context of discussing "git reset",
    and not in the context of "git checkout".

    side note 2.  "git checkout <tree-ish> <pathspec>" grabs entries
    from the <tree-ish> that patch <pathspec> and adds them to the
    index and checks them out to the working tree.  If the original
    index has entries that match <pathspec> but do not appear in
    <tree-ish>, they are left in the result.  That is "overlaying
    what was taken from the <tree-ish> on top of what is in the
    index".

Having said all that, I will not be looking at the series until 2.20
final.  And I hope more people do the same to concentrate on helping
us prevent the last minute glitch slipping in the final release.

Thanks.
