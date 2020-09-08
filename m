Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8191DC2BC11
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B8E2076C
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sy3Ov8Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbgIHTHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgIHTHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:07:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68779C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:07:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so177968qkf.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FlPJCFMhrS8hrEWKbYXFk5mZSfQ6tpHGU73+Pq8hVqI=;
        b=sy3Ov8XmuftzhTXPyGLeezR9bQfRvWMXL/XIRkwHRdjBsEMGb/2Jo36AZ5a1CxLMBP
         6YxM4yRrFd2FAcf3H+ZJGcdp1qgq9GivOlenWluY8yE3yitm1xGYvsRilYOm6yGWQhQf
         +NYUwRm1ZhN0v5UngV4RdNkp03VJ2RtlYKQBSGkhTe1t9L4QEVP/uEHIIu6tHOnnkC8n
         ZMpScnjlodRFPbY0We6FY18hjI+kbCGbdIdfOD+bCX62KpPqh5nN0eC1cs+PG1rLniQ2
         H+Z5UJLQVkaVWdLiSibl5QR3QVNwBITwr+4qNfmxXiexDcXQrf80EgdGgkCAvoJ0jbe5
         OPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FlPJCFMhrS8hrEWKbYXFk5mZSfQ6tpHGU73+Pq8hVqI=;
        b=pEUxJD4NNUUz0PJAvL87Z5HGzTpREwLrpSJ8yFyx/xgo3kvph3hOs/l6tpAue7eTG8
         5MfhAgvCWtyiCR9la3tSZRRPo+oi+gXJf7G6cPzqoQB5edpywmsMCj8ZKoYRrbCPBF/W
         Obces0hwNyumV7vrncIItf8tVTFXn304Atbv0ojLRSDy5OKjta1TEr85m3i5V+ljNNsD
         1vQfIE5AASm1y4pjZCo5IZzMq1HzEAsONOAozlOuVz32AbGeLTemEcK5nToXLEALfZfQ
         78rmO7cwhusUakOidYSWQ0ShOuYqZd2GVTZfvn8fK03U+hQsd91ttfR7crEggblL+p3H
         c5vg==
X-Gm-Message-State: AOAM531mSHwTlonRRC0IWuMdZPawVUmTdH0PHhBKNO+qaml9YHV6nFO3
        93pm3hOkikxGBlt66qCF3uXbK/rc84B/1w==
X-Google-Smtp-Source: ABdhPJxXOdH/69pY77zqkVglYfl9RpckdoMDPa1NrlitcIp58gFvsXUNm/CZ4wmsunomWquVGyNZaw==
X-Received: by 2002:a05:620a:64b:: with SMTP id a11mr21332qka.313.1599592055369;
        Tue, 08 Sep 2020 12:07:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:84a2:b0cb:7621:10c7? ([2600:1700:e72:80a0:84a2:b0cb:7621:10c7])
        by smtp.gmail.com with ESMTPSA id 64sm126662qko.117.2020.09.08.12.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 12:07:34 -0700 (PDT)
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>, whydoubt@gmail.com,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20200907171639.766547-1-eantoranz@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
Date:   Tue, 8 Sep 2020 15:07:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200907171639.766547-1-eantoranz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2020 1:16 PM, Edmundo Carmona Antoranz wrote:
> ---

Please include sign-off. I saw you reported your intention there
in another message, but it's probably best to just send it again.

This message could also mention 14438c4 (introduce hasheq() and
oideq(), 2018-08-28) which introduced oideq().

This use of !oidcmp() was introduced by 0906ac2b (blame: use
changed-path Bloom filters, 2020-04-16). My bad. There is no
good reason to introduce this use since it is well after the
oideq() method was introduced.

> @@ -1353,8 +1353,8 @@ static struct blame_origin *find_origin(struct repository *r,
>  	else {
>  		int compute_diff = 1;
>  		if (origin->commit->parents &&
> -		    !oidcmp(&parent->object.oid,
> -			    &origin->commit->parents->item->object.oid))
> +		    oideq(&parent->object.oid,
> +			  &origin->commit->parents->item->object.oid))
>  			compute_diff = maybe_changed_path(r, origin, bd);

The code itself looks correct.

Thanks,
-Stolee
