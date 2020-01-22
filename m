Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6048CC2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 19:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158B624655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 19:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wwe1yWxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAVTUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:20:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56586 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAVTUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 14:20:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CCD739F54;
        Wed, 22 Jan 2020 14:20:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yIbHwKk+53M+S59p/MugTeF+fOM=; b=Wwe1yW
        xVS+Pk0Hd19RXPVkyQ30X2Ju4zbsV6XG5ewo7bzUwu/26V7v1LlmE2AJLXLQVCAK
        dbJSzajj7lN8GNdGYXPF7v0dZUH5sM9nZr/y+Y3lBDd6mpiCzX/iaDesTtr4BjQ1
        rs0ZQKo+ulYWTgRSjdUtYdc0BjHILtSvdA2ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBN1g9HrAkp7svr6uB6CEumXQf/K/krt
        vdwU7oljKqaDTUqCtAO77JAN5z0X7b9aWiOnXYeZHqUoetUIc7KeajwFEVu0J81B
        f9i0TTo9I7RovnoRKWq2UlD/sNaNQ5wPrF4haS/Aau33PvS4xcGbwTZCaqX+981T
        TmlEz0W5hxU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8402239F53;
        Wed, 22 Jan 2020 14:20:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D652539F52;
        Wed, 22 Jan 2020 14:20:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Nirmal Khedkar <nirmalhk7@gmail.com>, git@vger.kernel.org
Subject: Re: Facing error in git-imap-send while compiling Git
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
        <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com>
        <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
        <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet>
        <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001212144560.46@tvgsbejvaqbjf.bet>
Date:   Wed, 22 Jan 2020 11:20:26 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001212144560.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 21 Jan 2020 22:09:07 +0100 (CET)")
Message-ID: <xmqqmuaf70xx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F6A0374-3D4C-11EA-BB05-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> From my limited knowledge of OpenSSL libraries, I think the error has
>> more to do with 'SSL_library_init()' , which appears like a
>> constructor to the OpenSSL library. I found these emails regarding
>> "if" cases around this function. Please check out these patches:
>> 1. Rosen Penev:
>> https://lore.kernel.org/git/20181227023548.396-1-rosenp@gmail.com/
>
> I remember that one. And I agreed with Junio that the documentation
> suggests that the call is _optional_, while the patch suggests that it
> would be _incorrect_ instead.
>
> And looking at
> https://www.openssl.org/docs/man1.1.1/man3/SSL_library_init.html suggests
> to me that it is still supported.
>
> Having said that, if I look at the headers installed for `libssl-dev`
> version `1.1.1-1ubuntu2.1~18.04.5` in my Ubuntu installation, I see that
> `/usr/include/openssl/ssl.h` defines that symbol as:
>
> 	#  define SSL_library_init() OPENSSL_init_ssl(0, NULL)
>
> but _only_:
>
> 	# if OPENSSL_API_COMPAT < 0x10100000L
>
> So maybe that disagrees with the documentation that says that
> SSL_library_init() is optional?
>
> The curious thing is that `OPENSSL_API_COMPAT` is not even defined
> anywhere. So maybe it _is_ the right thing to also `#define
> SSL_library_init() (void)` in the diff you listed above?
>
> _Maybe_ guarded within `#ifndef SSL_library_init ... #endif` guards?
>
>> 2. eroen: https://lore.kernel.org/git/20170112104219.563497-1-git-scm@occam.eroen.eu/
>
> That sounds like a good suggestion, too.
>
>> Are the fixes made in these patches relevant here. Please let me know
>> if I'm going wrong.
>
> Yes, both threads are relevant, and if you can reconcile them into a patch
> that makes Git compile with OpenSSL v1.1.1, I will try my best to review
> them (Cc: me, just in case).

I agree with the above reasoning and the suggestion given by Bates in
https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@nottheoilrig.com/
sounds like a reasonable one.

Thanks for digging and double-checking these two previous efforts,
and giving another round of thoughts on them.  




