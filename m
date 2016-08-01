Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B46A1F955
	for <e@80x24.org>; Mon,  1 Aug 2016 08:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbcHAI6U (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 04:58:20 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37726 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcHAI6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 04:58:18 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so233607171wmg.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 01:57:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=t7VjgCVwEyzHxC2c8BldwhaNSPfPlZpGku6Fldw8sDs=;
        b=ys6FPHRiDtDRaadoBuZNNNurrDriwgxydsXRNGXCJbB12uOCS00AakCNLlz8pHyZjI
         8gyO66N+01PS8DxxJZdJqvrrBoOt8hcCGUA2SpjNflT2tGd4TWXOxRFz1C9dpzC4ZL99
         U1bIg9FL7iK0hGiEjtxASkeS3S1OZj20zcBgqbsPQ/RwVVZYr5JSTjVy/+AWf4zTFlI4
         73FTY5o+6nAIcifopKWR1d5YOVGcpBTUARqcjCQY2wcZyIBrzVDVESZst3Kvdv38pcy1
         mknc6eg9BH5jcNnfuprdDbV7J4WHz8TQFe6wksC1LAFhBACiItJZpeBGGM7EXkqbkVBH
         PhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=t7VjgCVwEyzHxC2c8BldwhaNSPfPlZpGku6Fldw8sDs=;
        b=jQgXHiqmNZzQyNbW2wAexbHaU6WnI+en5d2TjpRSNFJNnkv/9uzSo2inbt3j4z0dUZ
         msUzdrBF3pROarkxTyWezqUlXw4t4iLt/H6ZJ1M5CiH+N2zav3MUp7HEezO8sS0q8QJj
         md/HPM47xew/0zTl8AlZk34cFW2ZXeDBnJNejuegiKzZ2GWL+MvAb3LB57oxaQGparu7
         nVwfWfp8MpK7YPko6+QPPNW2prwWW9++M1/paHmwkQ3xrEIyHn8G1cJ++pvv39NFEPXS
         Uvv22+oJ+JWvDn52G1fTfUpgUhekKYAHxbd3QhYKBuzJIFEP4oFk3YTIz4Yd9g3a3s7T
         mj2A==
X-Gm-Message-State: AEkoousqoWMvk2SAv8Y2hIxHMfU//R0NfBeTcyLOiTZ9/HAp6gf1Sop9Ao+qih3sdm/NgQ==
X-Received: by 10.194.149.113 with SMTP id tz17mr56060671wjb.64.1470041843708;
        Mon, 01 Aug 2016 01:57:23 -0700 (PDT)
Received: from [192.168.1.26] (afq96.neoplus.adsl.tpnet.pl. [83.25.146.96])
        by smtp.googlemail.com with ESMTPSA id yt6sm29448690wjc.23.2016.08.01.01.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Aug 2016 01:57:22 -0700 (PDT)
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
To:	Eric Wong <e@80x24.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
References: <20160801010557.22191-1-e@80x24.org>
 <20160801010557.22191-2-e@80x24.org>
 <20160801014303.x5j3dqumcmrkyc76@vauxhall.crustytoothpaste.net>
 <20160801070037.GA18261@starla>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d4dc2061-afb0-baa3-f54d-bccfdf7658a5@gmail.com>
Date:	Mon, 1 Aug 2016 10:57:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160801070037.GA18261@starla>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 01.08.2016 o 09:00, Eric Wong pisze:
> "brian m. carlson" <sandals@crustytoothpaste.net> wrote:
>> On Mon, Aug 01, 2016 at 01:05:56AM +0000, Eric Wong wrote:
>>> +		while (*cp && *cp == ' ')
>>> +			cp++;
>>
>> So it looks like this function splits on spaces but doesn't provide any
>> escaping mechanism.  Is there any case in which we want to accept
>> environment variables containing whitespace?  I ask this as someone that
>> has EDITOR set to "gvim -f" on occasion and seeing how tools sometimes
>> handle that poorly.

This is to handle environment variables holding program options,
which are usually (but possibly not often) using single character
options bundled together, that is, not using spaces.

Moreover, it is about holding program options to pager.

> 
> Yes, it's only split on spaces right now.  While I don't think
> there's any current case where spaces would be useful/desirable;
> I suppose a 3rd patch in this series could add support for using
> split_cmdline (from alias.c)...

Is there any pager that needs spaces in options-set environment
variable?  Does MORE allow option bundling?

-- 
Jakub Narębski

