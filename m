Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A32C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD43610CF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244212AbhJ0VLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:11:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64562 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbhJ0VLt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:11:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B030EB353;
        Wed, 27 Oct 2021 17:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yyx8YzyXPPVEkJAR+M7juXEmlpy27fzq8pNb9F
        +nNwQ=; b=ondAqagLVCV5A6gEfTmjZIci3U3jAJfLCOMmDF8ccquwvyJJwtqlID
        LwNJkfJtUn20qGyiRpDmVJR1TB3zOOY+cQRiLwlqaIshOzlx+Q89BIqCynhQBlel
        XWXq4v6KPj6ujrn9z92BM/y81Tlb3GoTGZVk/bcLiaM5ArxBpjyLY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7273AEB352;
        Wed, 27 Oct 2021 17:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D17F1EB350;
        Wed, 27 Oct 2021 17:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 0/2] tmp-objdir: fix regressions in
 core.fsyncobjectfiles=batch
References: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2110271439120.56@tvgsbejvaqbjf.bet>
Date:   Wed, 27 Oct 2021 14:09:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2110271439120.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 27 Oct 2021 14:44:00 +0200 (CEST)")
Message-ID: <xmqqo87auqda.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28982BE8-376A-11EC-ADE5-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Neeraj Singh (2):
>>   fixup! tmp-objdir: new API for creating temporary writable databases
>>   fixup! tmp-objdir: new API for creating temporary writable databases
>
> Thank you for the fast work on the fixes!
>
> I applied both patches to the PR branch and pushed; Let's see how the CI
> over at https://github.com/git-for-windows/git/pull/3492 pans out.
>
> Please note the original patch made it into `next` already (and is hence
> subject to follow-up patches rather than being rewritten).
>
> Therefore, you may need to reword the commit messages so that they stand
> on their own, as follow-up commits.
>
> And alternative would be to ask Junio to kick the topic out of `next` and
> back to `seen`, in which case you will probably be asked to submit a new
> iteration of the original patch.

Yeah, none of the above is attractive this late in the cycle X-<.

It probalby is best to queue the "fixup!" commits as they are on top
of ns/tmp-objdir, merge the result to two topics that depend on
ns/tmp-objdir, and keep them without merging them down, until the
release.  When it is time to rewind 'next' after the release, it
would be a good chance to get rid of these "oops, earlier we screwed
up" commits by redoing the tmp-objdir (and rebasing the other two
topics on top).

