Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B860C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E12620867
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL3BWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 20:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3BWK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 20:22:10 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE732C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:21:29 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x13so14069223oto.8
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g/6BM7kV+jOXgoQp1LbVDHVqXiR1fnQ3XAD7t+9W6oI=;
        b=B4797iLF+Pje/zBcsC2cMdUMlcIL8wZhIFJ8OPSp33gbqEx1lGAH+vqZYWmDrH2Tn7
         PMJujdm8uBF7f6QRTP72v6znmqTG3oQpiYZp0HlkCOaZfqVe3mV3jFojfvpj7BuCaivS
         T7XsXXHhuOSQkSTDKqXMntitHaBPWCsrSsb+GxrT8h13D7Jr9uqZ+7j0askpaAkYFxQe
         Gr00PbqKTKLeDeR7/7VOi44WYNdohnBQKh6hZvI597ZmhJtAkbG3Vd4SAIn3Ff8HPrxr
         4xkeU2sz/sBsws7tOvLTYKtMgVLlV8M0UoHzkjL5PythTslQQKNaHH8gmlDtAyXdP4nt
         E/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g/6BM7kV+jOXgoQp1LbVDHVqXiR1fnQ3XAD7t+9W6oI=;
        b=HrV86aoUMIgxLR73YcRtj9gJ5witpMKhrDutlFevsaefdVsKPOzP2lrfdmSLaExD5y
         MEUPYM8/StH4pO008oGeb3S9Zc1qjoLIQ/HgtAtUMat6EExtTzPqBPRWOWJ5RIxeT3oR
         a/QrxmOg0Se7Yudhlyzc4qfMQ4WBMDowW0uC8B5IOhswNcKqqfuan1XoV54lRDjv1Qf+
         WvB3dASrjo48R52niJ5c9Eshr2Q4F62FntfufCqDD+P1AsiZ8GlMm8vuFp+uYsRx/rnC
         T20Lsk8i9Gj+mdeqQ/TnB2oAcN33LA78+R607fV6KnwASQ5pi193aPOph9gh+VOMZ8op
         PNiQ==
X-Gm-Message-State: AOAM5320ZMnpB6Ji9JM3OD25SD9LViOf89rJ97QsMO51pDGrMbnlxrZ3
        gcgIF5MvQIVNFlKwTpA5y8i1xGGio8o=
X-Google-Smtp-Source: ABdhPJw6zpc3B1YAy2U8/90jwJJj0bfwRmT2l9eoz8vFIosHHHuFoVhVV1vDtgGz92nSMANBVej/6w==
X-Received: by 2002:a9d:2c63:: with SMTP id f90mr38016459otb.325.1609291288993;
        Tue, 29 Dec 2020 17:21:28 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id v4sm10182642otk.50.2020.12.29.17.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 17:21:28 -0800 (PST)
Subject: Re: [PATCH 3/4] sha1-lookup: rename `sha1_pos()` as `hash_pos()`
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1609282997.git.martin.agren@gmail.com>
 <8d3b123633d37218587bb2e71232631dea420156.1609282997.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4f719985-a1cb-b9ab-74aa-d8e305a8f7e6@gmail.com>
Date:   Tue, 29 Dec 2020 20:21:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <8d3b123633d37218587bb2e71232631dea420156.1609282997.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2020 6:52 PM, Martin Ågren wrote:
> Rename this function to reflect that we're not just able to handle SHA-1
> these days. There are a few instances of "sha1" left in sha1-lookup.[ch]
> after this, but those will be addressed in the next commit.
...
> @@ -74,7 +74,7 @@ int sha1_pos(const unsigned char *hash, void *table, size_t nr,
>  			if (lov != hiv) {
>  				/*
>  				 * At this point miv could be equal
> -				 * to hiv (but sha1 could still be higher);
> +				 * to hiv (but hash could still be higher);

Thanks for catching this comment, too!

-Stolee

