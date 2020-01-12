Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D171BC33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C019214D8
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 21:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OLx9JL1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgALVMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 16:12:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51929 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbgALVMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 16:12:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF31DA1D27;
        Sun, 12 Jan 2020 16:12:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Xo7AzKZRt6zIeyJKuhtRpKhArE=; b=OLx9JL
        1urQbQRKs6WxNXMn9+4wKiTa3s5u2AhGvR66kq/mR+kFAOPhivl4pUswVbN5lVZN
        RVc25lykpB/t5Atpe+TVM0+nUSdYtI4nzvPVWvMdgOwLC/KaInzdCeUEZDqAhoXX
        mDvaaMTg6MZu/qaTF6wJ/Z6lMDuKQYp36CKY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uJAES3dQC3q/sDPXuVslmJ8txFX8Vh6S
        dbgKunj9zWA6N7MSaL4Q+UqTXACNhiJzZCBqpW8mpbT9f3Z814sU4hn+nzcD8KYs
        5gOQP8Lb+0cPEUjrzpA2gjeWSJ3rnHDg2D0QdoCppVeFOHpq5xruiPVrdvSN8mQP
        /h4BTcrMyDU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E79B5A1D24;
        Sun, 12 Jan 2020 16:12:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17E42A1D23;
        Sun, 12 Jan 2020 16:12:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problems with ra/rebase-i-more-options - should we revert it?
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
        <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
Date:   Sun, 12 Jan 2020 13:12:08 -0800
In-Reply-To: <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com> (Phillip Wood's
        message of "Sun, 12 Jan 2020 17:31:13 +0000")
Message-ID: <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32B6BEFC-3580-11EA-9550-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 12/01/2020 16:12, Phillip Wood wrote:
>> I'm concerned that there are some bugs in this series and think
>> it may be best to revert it before releasing 2.25.0.

Let's do that.

>> Jonathan
>> Nieder posted a bug report on Friday [1] which I think is caused
>> by this series. While trying to reproduce Jonathan's bug I came
>> up with the test below which fails, but not in the same way.
>
> Doh I forgot to add --committer-date-is-author-date to the rebase
> command line in that test. It passes with that added - how
> embarrassing. However it does appear that it prefixes the date in
> GIT_COMMITTER_DATE with @@ rather than @.
>
> start of the epoch and fails to parse it. The fix for the @@ is
> quite simple, the date we read from the author script already has
> an @ so we don't need to add another.

Yes, that sounds like a minimum and straightforward fix.

In any case, the tip of 'master' (hence the one that would become
the final) is simpler to remedy by just reverting the merge, but
there are a handful of in-flight topics that may have been queued by
forking 'master' after the problematic merge was made (iow, anything
after the fifth batch for this cycle), which I'd have to be a bit
careful when I merge them down, lest they attempt to pull in the bad
topic again.  But that will be something we need to worry about
after the release, not before the final.

Thanks.


[Footnote]

*1* The list of still-in-flight topics that may be contaminated with
    the merge of ra/rebase-i-more-options into 'master' are:

    am/test-pathspec-f-f-error-cases
    am/update-pathspec-f-f-tests
    bc/hash-independent-tests-part-7
    dl/merge-autostash
    ds/graph-horizontal-edges
    en/rebase-backend
    es/bugreport
    es/pathspec-f-f-grep
    hi/gpg-mintrustlevel
    hw/advice-add-nothing
    jn/promote-proto2-to-default
    jn/test-lint-one-shot-export-to-shell-function
    kw/fsmonitor-watchman-racefix
    sg/completion-worktree
    yz/p4-py3

I probably may requeue them by rebasing on top of 2.25 once the
release is done.
