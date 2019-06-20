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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6792D1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 12:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfFTMju (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 08:39:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35442 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfFTMju (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 08:39:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so3046833qto.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=crOp2QPIf44RdNylu0Zx5nfwgz7yfPrjWcBNUJqBxz4=;
        b=Otceo7BetFotLBGPZ48X3WLc1TsJ5bDA7TUMWVLu2dk0D3158AZtPyrn2j3+HLsfPj
         kguyrLOyeOS0urVMXJVF+IM4CNmtvoG9TiT75gLdokECfjQ88sPkpcUCKHoBDPvSw9a0
         yTR3uNmBoPlULQueR+416LSg4zjAiTJEDx4rl/6ynBcR6nrMAV3sBiKZYQO4kzANJjGL
         5GLXjUMNmAEV52P1oUMTTVnUfXDui04lYSfhi/C3SLeQG3JZuYR2s35G39OryWvCq1HZ
         TAehpTrOnIF71fGkiqKXO3h3jUXCpqDVfmDe8yFDJQiWdt9Zmxx6jYimswXjW57LvpEt
         jjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crOp2QPIf44RdNylu0Zx5nfwgz7yfPrjWcBNUJqBxz4=;
        b=NJGq2rWgFcLMEImlMPEDVuUDTbVQCqsnZt4LCGIqt5EEtjY2t8F/vlp5QrcBwg7xuj
         FBoG2KBsbzjg0tsw5K5S3unL0qubLWhwJdmiHBrtX++ezoSWRXLBorMJ0rs2gFIku1qc
         K1dJWFsHYCOx2ks4HtvuCpdb5Orvg2gNdOW4c4+j+sCnAiBT8Tp6RbsOLdeXG177Rkt1
         shUbMrtiSTJQFfDbn6Z/OfX0dGtY4Qgtu+W3mnH19FqUBuM5v3bwFSxU/25PFy/Vi7iS
         6hRDVVGLl3YuKdvBqzivGD8OU899eTfVOuEv5+jlziMdXKJYkk4YUBmLbBOklwjyhjtn
         9dIg==
X-Gm-Message-State: APjAAAU48BCjLpwfbb0N/XSNB9on74iQ0uwJ2JvIMi/ZRqOJ6gFqeFu5
        URUj7Lm1pKGGonOk0UAlK4dlq09O
X-Google-Smtp-Source: APXvYqy79Bkj7PL8seqwjYyl8LMQJ65ugfRbFQlWMlZ7heJMuc6B3ps1sMfY+eDhcgAuCgguknh49A==
X-Received: by 2002:a0c:87ec:: with SMTP id 41mr28129758qvk.196.1561034389252;
        Thu, 20 Jun 2019 05:39:49 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a934:2ce3:312e:b671? ([2001:4898:a800:1010:5a6a:2ce3:312e:b671])
        by smtp.gmail.com with ESMTPSA id y16sm10103225qkf.93.2019.06.20.05.39.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:39:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] sha1-file: use OBJECT_INFO_NO_FETCH_IF_MISSING
To:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20190620083026.14524-1-chriscool@tuxfamily.org>
 <20190620083026.14524-3-chriscool@tuxfamily.org>
 <20190620085009.GC3952@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d88ac28b-638b-89c0-2bfb-634a0bb6ca4c@gmail.com>
Date:   Thu, 20 Jun 2019 08:39:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190620085009.GC3952@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2019 4:50 AM, Jeff King wrote:
> On Thu, Jun 20, 2019 at 10:30:26AM +0200, Christian Couder wrote:
> 
>> Currently the OBJECT_INFO_FOR_PREFETCH flag is used to check
>> if we should fetch objects from promisor remotes when we
>> haven't found them elsewhere.
>>
>> Now that OBJECT_INFO_NO_FETCH_IF_MISSING exists, let's use
>> it instead to be more correct in case this new flag is ever
>> used without OBJECT_INFO_QUICK.
> 
> I said earlier that this one would need to be tweaked for the new
> upstream name. But actually, I think it is not necessary after Stolee's
> patch.

Yes, I believe that 31f5256c82  does an equivalent thing to the
combination of these patches.

Thanks,
-Stolee

