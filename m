Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903DB1F464
	for <e@80x24.org>; Wed, 25 Sep 2019 13:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406494AbfIYNaR (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 09:30:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35056 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406487AbfIYNaR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 09:30:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so5253554qkf.2
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q6iTGABW0d4lNw52tryhTAP8TZ0F7QBksIuxh1lAfV0=;
        b=umuG8nmmANSIfLomGOvJr80y558uQdRhiQ9h/hkRv1vgOnaHrYiW8qjIg/6SwGB/pu
         EyHjuveDDgCrU6ppoPEx9hGIxS1ZS0JhyrSa/n6eK4sSmlkQDjdzbI4sicvCZrH0A3Bd
         CC+eu3wBNrNiabHMd7C0THjBbvZCH3l9bJJC3faGi8+VP1aqhd3iFZb04c62mv2KFbiG
         FTTzqGzGQWVuYj0eRk1rhoXEBWU5/SPaZVwB2TT/v9XYtdDX3TIyY/h0F7p99REewKXJ
         kfy43Mh37Bh3VAoQVkkAjkJrcC/MWM6r0xa8ioW8kvwGNYimp2Fe36P7YBFCd9J36z8o
         D0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q6iTGABW0d4lNw52tryhTAP8TZ0F7QBksIuxh1lAfV0=;
        b=qkK2HurjT9LVVBKAPfOBc8Ng73nPDYRhtjv5mswelEfDRuP9yhr8CBEujgTdlGlkic
         ygfJ2g2nN1nSkXBhUbuqFL/oTZmTNhAPmm2WYF0lXgmEzD2zOwlD0Q3b41D2rC3F9mjm
         nYzKh6GCAImMNEmwr45rj75Ig+EmykcAVg1u+lsyh8T4QRsTmG16J/qwjBW8ojepCXPL
         P+q8uzS7vMMI9QcGwS/NAM3p9FXjucINtmITwLPKnKUQRIHMKdhzXvBm7SyQ0y6DfaUL
         batssURa9hOHBrFaCbd6uTqALMCnYkP7HtnCGXXTG68Q98Y0rjRxqniF+O3vh2djJ576
         pXBw==
X-Gm-Message-State: APjAAAXOhAOX6kJEjXY0pSc3rm/J053u1Imo7fEmmV3tl239RkNaUdG/
        a59+fq7K3ZJvALGvOHQikVWm3dUEy58=
X-Google-Smtp-Source: APXvYqxSXl6AQ4EV29QYw53skcrUHJvob5ir318XplJcQkQ34JmHNglQAgaEIB1DJERHSbIwzmGpWg==
X-Received: by 2002:a37:dcc1:: with SMTP id v184mr3645716qki.258.1569418216175;
        Wed, 25 Sep 2019 06:30:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1010:fdf6:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id n4sm3109014qkc.61.2019.09.25.06.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 06:30:15 -0700 (PDT)
Subject: Re: [PATCH v2 00/19] hashmap bug/safety/ease-of-use fixes
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d16b22c9-c437-0947-fb5a-9421f987a1f1@gmail.com>
Date:   Wed, 25 Sep 2019 09:30:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-1-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> Patches 1-11 are largely unchanged from the original series with the
> exception of 2, which is new and posted at:
> 
> 	https://public-inbox.org/git/20190908074953.kux7zz4y7iolqko4@whir/
> 
> 12-17 take further steps to get us away from hashmap_entry being
> the first element, but they're also a bit ugly because __typeof__
> isn't portable
> 
> 18-19 finally brings me to the APIs I want to expose without
> relying on __typeof :)

I like this series a lot. The goal is very noble. As one who
recently interacted with the hashmap API for the first time,
I would have preferred working with the new API.

I do wonder about it conflicting with my sparse-checkout changes,
which create a lot of new callers to the API. I suspect that your
change will be easier to merge quickly and I will want to rebase
on top. Perhaps Junio could chime in with his preferred integration
plan?

As for review, I have mostly minor comments. There appears to be
consistent whitespace issues in hashmap.c and hashmap.h, but maybe
I'm reading them incorrectly.

Also, consider merging patches 10 & 11 as 11 seems to undo the work
in patch 10.

Thanks,
-Stolee

