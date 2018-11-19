Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF98E1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 20:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbeKTHD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 02:03:29 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:43821 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbeKTHD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 02:03:29 -0500
Received: by mail-qk1-f169.google.com with SMTP id r71so50911212qkr.10
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Nc63T806Sb2nzH5edepiYrAf4e8cpP8AJUihA964FTg=;
        b=OTooaBVIEDtAq5Z6Bb72IK26VURJp+s1jPYACTUJlJ1vSoGcenSsJ8m0NTrslmDUl0
         BpET+LbRcNXYAYkdxiAd46nmyi1FZtl9iDOpihS0ewtEKbLGNKX5PsQUXa2PkLNGBBD+
         WGEeDJdNPPO7wepJimHK01TUxny5WF+z9/KbhOD7lT2DaUpJUlAHWhWVApnh/jnUl0wz
         PPm4VWvpF5qA5DDLdLVD8wKt8Onkt6NdEiYY5/f4fM/IFu/IKpvCZzc/Sfh81nIz9Kkq
         xi+xo5Uk+axRMuKEFK/Lu5WknuNrJa+YZYDiX5Kdu0ab9xvI3LAGKU8ju/x6OZhUoPc/
         LmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nc63T806Sb2nzH5edepiYrAf4e8cpP8AJUihA964FTg=;
        b=KUhMZ2NZYHqh58bdsti4owjnLQGk0GHIp33dDGtN+34AQBK2QSSHb1oaZtDTQZ7OmL
         9I9oLKfHtGmapuTypcwv2LdsUzxTMcbdFrFF1gxnUPS1XjlwZxo/FQ5Ay3iF0SshS22U
         lgl0NFlURzTvB/zWe5X24ESybqhVsiBzz8tJlw8mU6NvPFZEaXw296aE5ekoqM/DRskQ
         fHLcfQVf629KHmDkfHop9aWXCvG7MYnyDyN4in5fJNR7sUA1KI44/UGGxeHHnGaIhEgg
         2JXTVPL7nI3wVwnrYWrwz28JgT5pAwzu85QGSYvkGDcJoYB9pqUaW/Z/EZecjBkyM4Ws
         xkvg==
X-Gm-Message-State: AGRZ1gKHS1v2SbRsTYi44gP79agkLMS2j2Yw2D2SmbfQ+BTZTuixZ+IS
        g4dS+lri+A5jfJ5rQRFHyeM=
X-Google-Smtp-Source: AJdET5ex0CeCNrAvjkmxOOqngKmI+ruEO/dRBfJkWnkZ2sCd473dbytj5HKJ42Y5LDUF1rfxxCqoBw==
X-Received: by 2002:a0c:9384:: with SMTP id f4mr23394384qvf.239.1542659888468;
        Mon, 19 Nov 2018 12:38:08 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9842:9c91:9414:a691? ([2001:4898:8010:0:8178:9c91:9414:a691])
        by smtp.gmail.com with ESMTPSA id 7sm8101772qka.38.2018.11.19.12.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 12:38:07 -0800 (PST)
Subject: Re: [PATCH] commit-graph: split up close_reachable() progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20181119160207.GU30222@szeder.dev>
 <20181119202300.18670-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d7b3ca40-1f23-7264-4fd5-890abe908c2c@gmail.com>
Date:   Mon, 19 Nov 2018 15:38:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181119202300.18670-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2018 3:23 PM, Ævar Arnfjörð Bjarmason wrote:
> +	if (report_progress)
> +		progress = start_delayed_progress(
> +			_("Expanding reachable commits in commit graph"), j = 0);

This should be the only one that shows up in all but the very largest of 
repositories.

LGTM.

Thanks,
-Stolee
