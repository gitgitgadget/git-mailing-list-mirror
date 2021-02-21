Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6F7C433E0
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 07:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A9764E57
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBUHGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 02:06:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60503 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhBUHGH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 02:06:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4FA711EC9D;
        Sun, 21 Feb 2021 02:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nTQ4B3dilrapQxcNZd7VcC+MOTM=; b=UBkJa8
        7CtXVe0Xr3Rciti1bYjYh7/HgqiKFihL976uT8okG8tuMoYpKRm7IdpWi+iZMx82
        neOG55/9KnBFKcvIbyXE3yO4a+CaqsP8XqJhDK0LcNqqcRbNMQDPJuAgCaAiXDxH
        CE4V6Oti/9bPwSf8epBB2fwDJ2P8OCCLXWo7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NDit0khK9H9E5jmDdIAO6OF5I42RscZf
        geg0TWQZJtaDgwvbdt/kA/RJNtmJIyYVRJhgQ1soVQVvrl1vMoA8OhCvZU3pJhET
        yVOxBg2MUMTXQVYv7TVoRSgGkkwd8TZz1b/4EZo4c0r69awCVCXnQRxc1ToyyWlg
        gjJxnijS98k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91B8C11EC9C;
        Sun, 21 Feb 2021 02:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C6B0C11EC9B;
        Sun, 21 Feb 2021 02:05:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210217072904.16257-1-charvi077@gmail.com>
        <20210217073725.16656-1-charvi077@gmail.com>
        <20210217073725.16656-2-charvi077@gmail.com>
        <xmqq35xulbj0.fsf@gitster.g>
        <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
        <xmqqpn0xfal8.fsf@gitster.g>
        <CAPSFM5eJNUdzy0CA1GNjNkqL_a7ivM8qydxvHf3208nznkG9KQ@mail.gmail.com>
        <xmqq4ki7bf9y.fsf@gitster.g>
        <CAPSFM5cRq9OfxypwTAsv3OFpTPM88e4_agTmFEGbaVyLi6Qbig@mail.gmail.com>
Date:   Sat, 20 Feb 2021 23:05:20 -0800
In-Reply-To: <CAPSFM5cRq9OfxypwTAsv3OFpTPM88e4_agTmFEGbaVyLi6Qbig@mail.gmail.com>
        (Charvi Mendiratta's message of "Sun, 21 Feb 2021 12:05:29 +0530")
Message-ID: <xmqqtuq599zj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29BB8ECC-7413-11EB-8229-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Thanks a lot for explaining each perspective in detail. So, now if we
> use `-m` as an option to write side-note then `--squash` is already
> available and for fixing the commit message opening the editor is a
> must expected option. So shall we remove the `-m` option compatibility
> if `amend`/ `reword` suboptions are passed to `git commit --fixup` ?

FWIW, I do not have a strong opposition against -m/-F that is not
rejected when --fixup=amend is in use.  It is OK for Git to accept
useless combinations of options that do not help end-users.  A
combination that is not useful will be left unused, which is not a
great loss.  So, if it is more work to make the code notice when
these options are given in useless combinations and stop with an
error message than just accepting and doing useless thing, I am OK
if we left them as they are.

I was just hoping that letting "-m <message>" and "--fixup=amend"
used at the same time would support a great use case, and because I
didn't think of any, I asked the person who allowed the combination
(that is you) what the intended use cases are.  Actively supporting
a combination because it gives users great value is more satisfying
than just leaving useless combination to exist only because it does
not actively hurt.  When users say "The command can take these two
options at the same time, but I cannot figure out what good the
combination is for. It feels utterly useless to use them together"
it also is much easier to answer them if we can say "because by
using these two together, you can do this great thing" instead of
having to say "we do not think it makes much sense to use these two
options together."

Thanks.
