Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5739EC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1AE22522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 18:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JHA1exjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAUSLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:11:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64320 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUSLh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 13:11:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4248A57034;
        Tue, 21 Jan 2020 13:11:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oCGNQtwjfodyc+O87XGIiXiWulY=; b=JHA1ex
        jW2s2hGBQd8QksRe2DB0rsERJMQQZKbrf6AC8x4Psm7MiGORDSki1H/WZTod3lj9
        oaDDyH4B+uRrG83FiKyJOyk8tDRU/8UwLH8Va166A3T2Hz79uMuQZBZWNm/XgMdK
        lkYek8Pup/FfQJh3eTVmxL9QLCRiT2O4D8b9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hkvDQW9VysOuAeudzfBt6VgrQItKqH3u
        fluQN9siiNKX8LMLKvIihgUebAWuNvj2YrauY3m+zGyjYn3azSLpS210JT45/LVa
        sdJLuMXbMzko49Ogbeo5OU02EjwpeyXVftCoeniRx/UrcProuy9/t23ozRwn1SWH
        GYKfTXcSbUI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 37FE257033;
        Tue, 21 Jan 2020 13:11:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 842CC57030;
        Tue, 21 Jan 2020 13:11:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Facing error in git-imap-send while compiling Git
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
        <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com>
        <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
        <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
        <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet>
        <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
Date:   Tue, 21 Jan 2020 10:11:33 -0800
In-Reply-To: <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
        (Nirmal Khedkar's message of "Tue, 21 Jan 2020 17:20:28 +0530")
Message-ID: <xmqqa76gbrxm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75578CD2-3C79-11EA-ABA8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nirmal Khedkar <nirmalhk7@gmail.com> writes:

> the same errors. Here's my diff, in case I have been making mistakes
> all along.
>
>
> ---
> diff --git a/imap-send.c b/imap-send.c
> index 6c54d8c29d..73ed3bc287 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -42,6 +42,12 @@ typedef void *SSL;
>  #define USE_CURL_DEFAULT 0
>  #endif
>
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L
> +    #define OPENSSL_sk_num(x) sk_GENERAL_NAME_num(x)
> +    #define OPENSSL_sk_value(x,y) sk_GENERAL_NAME_value((x),(y))
> +    #define OPENSSL_sk_pop_free(x,y) sk_GENERAL_NAME_pop_free((x),(y))
> +#endif
> +
>  static int verbosity;
>  static int use_curl = USE_CURL_DEFAULT;
>
> @@ -59,6 +65,8 @@ static struct option imap_send_options[] = {
>  #define DRV_BOX_BAD     -2
>  #define DRV_STORE_BAD   -3
> ---

If the above is the whole change, then I do not think it would
work.  In the thread I referred you to, I was responding to a patch
that has repetitive 

	+#if OPENSSL_VERSION_NUMBER < 0x10100000L
		call_this_original_function();
	+#else
	+	call_this_new_function();
	+#endif

and I was merely suggesting to reduce the patch noise by #define'ing
a compatibility macro to allow us use new names in the code regardless
of the version (i.e. OPENSSL_sk_*() may not be available in older
version, which used to call them sk_*()---the solution is to pretend
we have OPENSSL_sk_*() by defining them in terms of sk_*() we do have).

There was a hunk (or perhaps two) in the patch I was responding to
that is different from the mere function renaming.  That part is not
there in the above patch you pasted, and needs to be kept, I think.

