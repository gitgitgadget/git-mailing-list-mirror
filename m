Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74CA11F404
	for <e@80x24.org>; Wed, 29 Aug 2018 12:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeH2Qvr (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 12:51:47 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42693 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbeH2Qvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 12:51:47 -0400
Received: by mail-qk0-f196.google.com with SMTP id g13-v6so3231731qki.9
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=NREsrJPobsiZFmAsxiMF1wOGK4rdPy9GW/KREEhk3Lk=;
        b=WeBcbVPlfU1F8l5eyKovZWSsHFxAQYBZGsV3fuuFoYBncqBZORXMRSnooG3ISA0+9R
         Yl+Tofuz/2bTLga9s0RUC3kF2zrsDTezEg7UW/Wpmk4xCe5If/5fiDETs88THmPYFyRj
         zeQYfW2FG9KnZ/VTVVLn8VFUEt3IvAWpVh9duEmZFOiC7M5K8Spvxa6OqB7hG3rgQhUt
         dYM79jfZzQZdE3TUs7mLpXmGxSGp3p1JrvBS02djtKNp2t13pMyYlNtn/5nSgYTQOiU1
         R6Av9Xwf5l7UsA1OrSy7HQkRKh7vwGOC6uFeBLrCaXfUZx/W1WOZIFjRJgAfrj1PFHb1
         OSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NREsrJPobsiZFmAsxiMF1wOGK4rdPy9GW/KREEhk3Lk=;
        b=AuwQEfrnA4HG4bJJR4UmzHtnhE76SEjuDmLKoazVuuEsja5AOkUitZrAlPxi6imrXW
         lYjfo8pdNzMVo388tjJ0gTGLwqu2FORnEJNHBm77O0sApVdXWK6CFPF/TOSh4H9EBciA
         dhjj0u2pIfGL8JrJnHn11uxiAS0JoWrfnv4rV0NMgBLEcmwkPE8sQFeayevc1eWNYEhS
         dd7GXGp3ypif60Al4iauF5KkNBJLSxdYXzznPzSoJtaYkZUQe0QrYBdCxrs1bhnpKkqB
         NgwS2LytYi240U5+chgrHSjezKDGjNjq47ev0BFFV+Wbrtv0AEeLnsY7LBXq0yZXJgaX
         1EIQ==
X-Gm-Message-State: APzg51DcykgK6fIFcMSqeIYsGD7UAmHNIZFGjGP2ynvbQWZ5Iivzf57e
        VB8/iWwM0XMoU/04KV8/A9ObO+fg39U=
X-Google-Smtp-Source: ANB0VdaqYI6NuH+kMtwt6WYaVjpVZ+SaZSM2IBvLOXde9mjfuMguRtnOShK1pDhmgjUdrFyZfXxBcw==
X-Received: by 2002:a37:7707:: with SMTP id s7-v6mr6215115qkc.308.1535547297827;
        Wed, 29 Aug 2018 05:54:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f86b:1660:ae35:a1de? ([2001:4898:8010:0:e1a1:1660:ae35:a1de])
        by smtp.gmail.com with ESMTPSA id g13-v6sm2144859qkm.11.2018.08.29.05.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 05:54:57 -0700 (PDT)
Subject: Re: [RFC PATCH 09/12] Add a base implementation of SHA-256 support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20180829005857.980820-1-sandals@crustytoothpaste.net>
 <20180829005857.980820-10-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7b1aac2e-b768-cfec-2dfe-61f63066ae1a@gmail.com>
Date:   Wed, 29 Aug 2018 08:54:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180829005857.980820-10-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 8:58 PM, brian m. carlson wrote:
> SHA-256 is somewhat slower to compute than SHA-1 in software.  However,
> since our default SHA-1 implementation is collision-detecting, a
> reasonable cryptographic library implementation of SHA-256 will actually
> be faster than SHA-256.

Nit: do you mean "faster than SHA-1DC"?

