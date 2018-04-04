Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BC71F404
	for <e@80x24.org>; Wed,  4 Apr 2018 19:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeDDTpe (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 15:45:34 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:44825 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeDDTpd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 15:45:33 -0400
Received: by mail-qt0-f178.google.com with SMTP id j26so24400218qtl.11
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XQTCXGhAwkejdb34VOC0MbDPrdAV7P2BkgFynDLLHGM=;
        b=DstsNsNndIE8y8Tn8Gc5hJ0rGhnntebCk3iVaFhonjB8JTcYmuFn4qI3RnBlGLLxtY
         g4YmkvRNvBUZ/sknCcIhrk3O+P/mXnh7B/KWK2XWNVK0/ewtEdmuv0HMUfmAQ6R1STOg
         tRL3XeK8A0WC7rsBDf6ngN/A0br1NguGLowjZjgwmbep8UlhT3XhKyABi1/q2EJzbvLF
         PfjElWP+3w3PEmqS3TG9+AxDQrLtI28cjRWOCdMYo+ifA6t73VC4g+i8sjyk71fXnHvh
         xoihzStGUyEUQu/ZAPzRibdcec1Q/RcB2BpRyCNGj48tlgmw2TaGD1vqBlX0rWaZ889I
         4JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XQTCXGhAwkejdb34VOC0MbDPrdAV7P2BkgFynDLLHGM=;
        b=UL/6XNuC+7nGbYPO6wiAWTXI5ez4uBAS9DylHCAbXASjndg3HGNwz4h3Ja4Ak6lF5U
         gB2Mh58jxUtxQU4LgtdKFYI4ZT0O+YHe7yrPGOtJz6IF+K5V2rwQ97MELCCqXDGKqUW5
         pmmrmwM86sFhR79qQSAX1sbn7SIiy+q1IHbRrJWb4F5BnSsitLJTgrSwWha+dRF4N6su
         YSoW5F3qkOSFDHNKLYv76mLpF9J8QAJL82ElF/9Y7KtZZ5mPmSXNgWk4hEf9+1+ixC45
         ikqY7NgeGMttv6lD5o7LG4YZEY+gNVbfHC77d/NCDU1iZ5yMOV3JPAKMDQ8TWWIKqkds
         MwzA==
X-Gm-Message-State: ALQs6tB5AAopcILBumUaK2GL1Xlv21VH1HEB8mC4vCBGHhrQMvFRrjSM
        HnIqN9Ged8ie5SJ5Ot7gGIY=
X-Google-Smtp-Source: AIpwx4/auRkoirJe7ik6IZmKWWsmaIDRdQkSaYKWzt6WCK9xHmeduZ6l3fG6kEErD3ya13ukiEcoqg==
X-Received: by 10.200.5.70 with SMTP id c6mr28430212qth.323.1522871132400;
        Wed, 04 Apr 2018 12:45:32 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id k188sm4185290qkf.94.2018.04.04.12.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 12:45:31 -0700 (PDT)
Subject: Re: [PATCH 7/6] ref-filter: use generation number for --contains
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@gmail.com, larsxschneider@gmail.com,
        bmwill@google.com
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404182242.GA9055@sigill.intra.peff.net>
 <1cc07683-8d2e-e9fa-ffee-2663057704be@gmail.com>
 <20180404191657.GA13543@sigill.intra.peff.net>
 <fcded90f-cb12-dafd-f21a-18ea67e99406@gmail.com>
 <20180404194248.GA14055@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a830161-ece7-44ba-e9f2-11073bd23802@gmail.com>
Date:   Wed, 4 Apr 2018 15:45:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404194248.GA14055@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2018 3:42 PM, Jeff King wrote:
> On Wed, Apr 04, 2018 at 03:22:01PM -0400, Derrick Stolee wrote:
>
>> That is the idea. I should make this clearer in all of my commit messages.
> Yes, please. :) And maybe in the documentation of the file format, if
> it's not there (I didn't check). It's a very useful property, and we
> want to make sure people making use of the graph know they can depend on
> it.

For v2, I'll expand on the roles of _UNDEF and _NONE in the discussion 
of generation numbers in Documentation/technical/commit-graph.txt (the 
design doc instead of the file format).

Thanks,
-Stolee
