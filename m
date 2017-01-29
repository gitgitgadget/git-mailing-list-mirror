Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577451F437
	for <e@80x24.org>; Sun, 29 Jan 2017 03:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdA2Dvv (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 22:51:51 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35461 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750856AbdA2Dvv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 22:51:51 -0500
Received: by mail-pf0-f177.google.com with SMTP id f144so82390416pfa.2
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 19:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T70fIRWyH8zgYm5yZev7ca7Psx4Hn/rM1kOQQEOaY2g=;
        b=GbV8Oc7QZ8EVFCtSv495cOMY30Vr+gy0AJH1lFLHGuEnKgTE6tPbrePACm9DjtpLP8
         U9P3FTw9rjL+gSazZYXx6vGVnFXC2UBmB2x2gnmT0A29Z5r5jc+5TtfrgV+MygYtpd6u
         J7R2KowAW2j0sNmYCP/PyO2ozb8daTuikdb4tS0Z7R04+XEYEvwmtV3Nlq+9g3jdy/mm
         TD18faYF8R6lz3zK4P0eLceVE9wmJ7+tJpaI2h2pRMmLYlD0pCGwlly7ZVaiAbqTm/tx
         F/MMxKPf806Wm083cdWipNcDy44MPcE13QRMSpOw8x9daouRCo7kIo2zSyg/0hFEP8LN
         lkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T70fIRWyH8zgYm5yZev7ca7Psx4Hn/rM1kOQQEOaY2g=;
        b=WSxkKU3rj6qb2Tmj63k7vezZ01MWmHdNam5D8+iOHNsG++yRVe4SmKtlY3tJ9f8kLu
         Scb6B/lSwYQACz8kUmDlGdqTjpcRXrxQpQEnt0FfX0nCtCPCHPkDxvWOgj+pDg/PEIdl
         h7UtLvtyYWQD62Cf2Xe1TWBmv8F3HTebe/YkKRdcDlI4nV9R8wwOSKJ8taIyOcxfQFKl
         8J3oOVRM1mUevjiidcKeTjkwGX/e25ThOR/qjfA92Z6+o7RuLUffC7rr0tm93zvN5zoK
         Kn9cQfltNQ+T8QUhwJMLO97Rpgfv0hzvKPlS/17xtdJ7BsgPX4hGsMa7ejQp/7YCwAHU
         XzJg==
X-Gm-Message-State: AIkVDXJDX5+VBB6Poxvh1Q0d34q49GiPBQFXuZesPssSV5SREVhwo/p5qdYo/mSE10YBb4iI
X-Received: by 10.98.1.213 with SMTP id 204mr16595977pfb.61.1485657871041;
        Sat, 28 Jan 2017 18:44:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:8d83:4e90:8a1c:1097])
        by smtp.gmail.com with ESMTPSA id 66sm21731580pgg.47.2017.01.28.18.44.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 28 Jan 2017 18:44:29 -0800 (PST)
Date:   Sat, 28 Jan 2017 18:44:28 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 16/27] attr: convert git_all_attrs() to use "struct
 attr_check"
Message-ID: <20170129024428.GA80687@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
 <20170128020207.179015-17-bmwill@google.com>
 <CAGZ79kax8Q6bD1Xm-kGAK=yTG6TYWcR3SCOjN9BeX9rzwkyaig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kax8Q6bD1Xm-kGAK=yTG6TYWcR3SCOjN9BeX9rzwkyaig@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/28, Stefan Beller wrote:
> 
> This being moved down to below (being review churn) sounds like a
> rebase mistake. ;)
> 

Yep, thanks for catching that.  I'll need to fix that up.

-- 
Brandon Williams
