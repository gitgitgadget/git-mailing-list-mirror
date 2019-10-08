Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7F81F4BE
	for <e@80x24.org>; Tue,  8 Oct 2019 13:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJHN7j (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 09:59:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39515 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJHN7j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 09:59:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so16827136qki.6
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q0zIWTLXwcOnrYY6JaAiJgmzDy6+VJi8Yz7tWDYRMtU=;
        b=pk5SQ1YXTz3fWp76bl7HFHvPIFOIRDp89on6eA+aTSnTbga5IA7QLQPEk50lxEGhXU
         6YwUjUbMeU7IT0U6fOQfB49Ha4wLB34oOO15X8PEjmZJJuSltC5b/IoOaqBumLX3lNvj
         7YCzaET7g+GRzmPdGW09ZxrX/ksoWBZtNuYg6k/IuegFtmgJsXYYsIYRAZJEygFKevNy
         uqyquR8ksB8HB/HvZr5OnnQKHo7upXyQSH6oOjL+ENyADZyneYIRfYhw1C7iC023l/yS
         wIbNcIpzioKi9Nt0CSha7l03UwW+WgborzZIwZrkmjEf41gBPZWKPl+Sh3EOCjtJ7hwc
         DeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q0zIWTLXwcOnrYY6JaAiJgmzDy6+VJi8Yz7tWDYRMtU=;
        b=iIpAlLV7p0GqOcIAOdEZOsYARMfjbm6WyEvqZXkyzVdNQUlFxCzx6yMWhFFTx0pa2Y
         lAHyxS6gqsjsiuf/b371rQnoSWBqLQMb9SVTSsRvSbRab83xvTj34+JY5HJp/Tr3UtLE
         t8CXUSUyWouAg7Wa96PEl0j+ATJ/wipA10opToFEkqWavhx35rTHq/O6K4BqKaSrXqne
         1Mxxik2XHWyf+QnCaXj804A5SPXKZlieVaSKeohLWdLLJe4AOgNpINzYV8cw2Uqy/fOT
         v2krd1FJI503DmdjgTh+4X+HRujWNWGEjLq8g1tdsrX6Di1jBIMflgvMlbdkZTTThRdL
         AMeg==
X-Gm-Message-State: APjAAAWsCZUyxpP6fIvu/MeIGk+xjJapUA0fVOVLjj9KiLs5vj31/Nad
        jZ+vU616dtDSlToXL+jTtmo=
X-Google-Smtp-Source: APXvYqyDqcwiLwuR2gZY31oC0kvxR6fVXYLAiYsAdBFidk8bOkL/0spWhRklOTiTAbL7fGDsz5rytw==
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr29506297qkk.353.1570543178203;
        Tue, 08 Oct 2019 06:59:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1012:7abc:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id c131sm10226689qke.24.2019.10.08.06.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:59:37 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] hashmap bug/safety/ease-of-use fixes
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20191006233043.3516-1-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b4e667d3-89ee-7f0f-55a5-10926d615ace@gmail.com>
Date:   Tue, 8 Oct 2019 09:59:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191006233043.3516-1-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2019 7:30 PM, Eric Wong wrote:
> v3 changes:
> - use __typeof__ to avoid invalid clang warning on uninitialized var
> - formatting fixes recommended by Stolee
> - add Reviewed-by for Stolee
> - add patch 20 to update docs to drop first member requirement
> 
> Range-diff against v2:

I scanned the range-diff (and patch 20) and think this series is in good shape.
My Reviewed-by stands.

Thanks,
-Stolee

