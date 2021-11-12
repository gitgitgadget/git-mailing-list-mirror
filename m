Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21582C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 04:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A4260D43
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 04:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhKLEcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 23:32:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52891 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKLEcy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 23:32:54 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6860D16AD7A;
        Thu, 11 Nov 2021 23:30:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2PicbigIwEmWwC6RMeRbAS4uJB0+r7ab+yBCmI
        /3+hQ=; b=vB275Pq28QjVVZQLBLJ5nQYzKhO0CwhhfUibqlskqa3BzEnYhEWxcE
        ljHUKRaejk/4LLCInWfJKgf9p/hUafn57jUlgDCq0aidAYO/r7pkRXNXUdI7t70G
        pTDJpMenF3R9aNucIX0+4OWd+i2VLMEGyDkeQe+BYPF1eFHMJBHaE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5502C16AD79;
        Thu, 11 Nov 2021 23:30:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7989916AD74;
        Thu, 11 Nov 2021 23:30:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Li <teddy.litheodore@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug report
References: <CAHPjYFyzPpUmfoCbvaVg25ZbhkHU8QtxHBmAh2gdT++Xr38HcQ@mail.gmail.com>
Date:   Thu, 11 Nov 2021 20:29:59 -0800
In-Reply-To: <CAHPjYFyzPpUmfoCbvaVg25ZbhkHU8QtxHBmAh2gdT++Xr38HcQ@mail.gmail.com>
        (Theodore Li's message of "Thu, 11 Nov 2021 23:22:32 -0500")
Message-ID: <xmqq8rxuj8s8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33727682-4371-11EC-8BBE-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Li <teddy.litheodore@gmail.com> writes:

> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> After cloning a remote repository with the --no-checkout option and
> executing git sparse-checkout init, the bug occurs with any
> sparse-checkout command with the /* pattern (i.e. git sparse-checkout
> set /*).
>
> What did you expect to happen? (Expected behavior)
> The contents of .git/info/sparse-checkout and the output of git
> sparse-checkout list should be '/*'
>
> What happened instead? (Actual behavior)
> Instead, the output is the contents of the user's local root directory
> (i.e. /bin, /boot, /cdrom, etc.).

A blind guess, as I do not use sparse patterns, but perhaps you did
not quote the "/*' pattern, i.e. you typed

    $ git sparse-checkout set /*

where you would have got a better behaviour if you typed

    $ git sparse-checkout set "/*"

?
