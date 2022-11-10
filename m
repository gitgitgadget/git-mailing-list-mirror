Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADABC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiKJCXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiKJCWw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:22:52 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46961FFBB
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:22:51 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id o13so389274ilq.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V6jDTA/UqcFWUJikm+SxAZkwS1zki5IVGSkacbHSHIM=;
        b=gAvpfEdbZyYjuUG8anRMXSOyV7jwrbPq9X/B606FLwzSXO/AZgl29guCcKQMBhqIa3
         vhLFG7KBIZYCSvQU8mxa1oxyBxFD4FPF4yhAepIq17ev4W8CUdQOm1M7sFz2HX1n5Der
         wigJrHksLA34TYtvW6pdzEH0kuvw0i24w5soA9+CZVpuffcnUEV+A+TPQB1ZkzhbWgkH
         9c79KtuysEnnrIyJoCV5tIk2GFEAugjHWU0gloyQ6L62KamMTLyLnKqdIT2pvB6cxode
         diol4wvEDr64/mZhG/GHeLR9+2LuotK3cHM2EzoeNl2HscdXIXtfcSI4MGh6h0EKOphA
         ieTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6jDTA/UqcFWUJikm+SxAZkwS1zki5IVGSkacbHSHIM=;
        b=d/g2janDH3MbGueXmLU0+ELcSm6bKN5mBMUAryRT5IeMr5JGAxqc1LfVcKZ17iGviW
         gQHLZGBMN2+ZT9xXHF43Fu1Cqrj5rBd1jxLDBKUh++MvSjWumgk27y/wcl4xCWo1t/IB
         clkPi9e2Nsyap75ibFivwrxikAgLYfc0Ri0mWWrXnRV9I1KJW3Vnnca6+Oei8lPG4vkb
         pCRHUpCnwwzXun33BTvqTvpRXpjR5L9S7Vn+K2r7FckUbBpcQ5zJqkMmWpKtX0+EWKxz
         j8Lh+5wjtTd20UOrTIRgXijE7Ipxlza2cD76pEHHAUqVI8Q5Zy0VUxSMLAzt09L0qdJb
         6ewA==
X-Gm-Message-State: ACrzQf3OaWqz197nB37/mucZ6SahQRvhifGPfbGn9YxfeP5jHcZu1oDV
        zpPhH3SWIEuaFZZyEdyPj12Jhg==
X-Google-Smtp-Source: AMsMyM4Gezrsbwla9zf+uMBUqs+g7zrHbukckW4T4q1k+O7F0pF2BKUqGcrHaAP590hAaKt/V52Cnw==
X-Received: by 2002:a92:6c12:0:b0:300:d335:8d7e with SMTP id h18-20020a926c12000000b00300d3358d7emr20221486ilc.304.1668046971025;
        Wed, 09 Nov 2022 18:22:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w24-20020a05663800d800b003734c4d01d2sm5327872jao.61.2022.11.09.18.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:22:50 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:22:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <git@dinwoodie.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: fix cygwin build failure
Message-ID: <Y2xgef6IvBHnnfE/@nand.local>
References: <0dec6e1e-207c-be13-ae95-294d9b1e8831@ramsayjones.plus.com>
 <Y2wwfQWrs+KYpWNv@nand.local>
 <221110.868rkjpty3.gmgdl@evledraar.gmail.com>
 <Y2xf7HbAdqXOmgR3@nand.local>
 <Y2xgI30EFZisqpRG@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2xgI30EFZisqpRG@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 09:21:23PM -0500, Taylor Blau wrote:
> On Wed, Nov 09, 2022 at 09:20:28PM -0500, Taylor Blau wrote:
> > Yes, 'ab/remove--super-prefix' is only in seen for now.
>
> Oops, I clearly meant 'ab/make-bin-wrappers' here. Sorry about that.

...Double oops. Now that I think about it, my notes show that we were
planning on dropping this topic per the discussion beginning at [1].

If that's not the case and you were planning on resending this topic,
then incorporating these changes in would be appreciated. If not, I
think we can drop both of these.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Y2rPrNz6BD6DlRcO@nand.local/
