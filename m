Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66EEC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE4520776
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RWHTj0s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437423AbgE1XRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:17:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58829 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437326AbgE1XRa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:17:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DC585A7C5;
        Thu, 28 May 2020 19:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b6lhAs7fZwj1k6Yx0Z919CyPamA=; b=RWHTj0
        s1k7s9H29ermmFUlp7Fm5G5Sf2oEwfiRX3WzEMksyLIkUPQh+gq+oAYZZEAQe0X9
        HJKWVL/3K6mTeRRcSYmRr0UWmtGtxPFxN3YvJAgPlEYSdi+j0drSa/JSJE2Mua/W
        ScWuzYTAxOAMb+1NM+Ym3v/nlP1Md+JHn+re8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dmVpnaV2Zkr+fIVnJO3kzVb3Da0oS6hr
        nm7OiHSw/M9zgpfPwwu6hmqK8llIcAyPh0+ah9zY6j8Lt5oTfiTd11lQdYgH/ooP
        4cIOz+P2tiNkHc1siYqgOQd8j3Z55G1HgP2YmhUcFhltrjs7qfjyZJgcZNW9kJ3/
        WQ66F5MAX6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73E5B5A7C4;
        Thu, 28 May 2020 19:17:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF12B5A7C2;
        Thu, 28 May 2020 19:17:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Steven Willis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Steven Willis <onlynone@gmail.com>
Subject: Re: [PATCH] doc: ls-tree paths do not support wildcards
References: <pull.796.git.git.1590700996483.gitgitgadget@gmail.com>
        <20200528215107.GA1265681@coredump.intra.peff.net>
        <xmqqy2pb1z0x.fsf@gitster.c.googlers.com>
        <20200528230454.GA1267915@coredump.intra.peff.net>
Date:   Thu, 28 May 2020 16:17:27 -0700
In-Reply-To: <20200528230454.GA1267915@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 28 May 2020 19:04:54 -0400")
Message-ID: <xmqqk10v1wfs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65B7F0C6-A139-11EA-A002-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 28, 2020 at 03:21:34PM -0700, Junio C Hamano wrote:
>
>> >   1. Deprecate the current behavior in the documentation and release
>> >      notes, encouraging people who want literal matching to use
>> >      --literal-pathspecs or the ":(literal)" magic. AFAICT we've
>> >      supported these since at least 2013 for this command, so it should
>> >      be safe to use unconditionally.
>> >
>> >   2. Add a new option, "--use-pathspecs" or similar, that switches the
>> >      matching code to use match_pathspec(). That lets people use the new
>> >      feature immediately if they want to.
>> >
>> >   3. When --use-pathspecs is not in use, warn to stderr about any
>> >      wildcard characters in the input. That reinforces the deprecation
>> >      notice in (1) and is likely to get more people's attention.
>> 
>> Hmph, if we are serious about deprecation and migration, I would
>> image that in stage #1, we should do this check already.  When
>> "--literal-pathspecs" is NOT in use, if a pathspec would change its
>> meaning if not taken literally (e.g. has glob letters, begins with
>> :-magic introducer, etc.), we warn and do so from the very beginning
>> of the migration process.
>
> Yeah, sorry, I meant these three steps to all happen at once.
>
> Technically we don't need step (2) in there for the deprecation, but I
> think it lets people adjust to the new world order as their solution to
> avoid the warning (though I guess literal-pathspecs would also prevent
> the warning; we wouldn't be looking for "*" in the input so much as
> checking whether the parsed pathspec contains a wildcard).

I do agree that letting early adopters experiemtn is a great and
necessary step.  And I think I misread the condition you wrote in
your 3.; I do agree that we should warn when --use-pathspecs is not
in use, but if --literal-pathspecs is in use, then the user wants
to match literally even when the pattern has globs and :-magic
introducer sequence, so we shouldn't warn.

Thanks.
