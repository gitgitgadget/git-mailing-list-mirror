Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDC281F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbeDFFIy (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:08:54 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:45969 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbeDFFIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:08:52 -0400
Received: by mail-pl0-f42.google.com with SMTP id v18-v6so20011563ply.12
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mc2JpZIwrz2QvbYTAM+GAGmUcP7icda/B5vjZlO9/Ok=;
        b=JmWeHG78UEl/A3x1fx6Srsso2WgQer3tFcZrv4GLe3K4FASUH/ZabuH4ePz6403ByQ
         9s/Rol1MiYAUVtzajzTHYEA+a0F3IjnCMw0Bu3nm+GODuFax/1e/nNcBp2daqVs8clv/
         tMn51wYTbkpqx1Siq7qm8oeedgEFfrq5LiuHwzxHHUKkJAhrT5l5EqDjuzEWbY+JsBm1
         1y2F0IPG+MQXzbxPUu+1Z141+IldRVH1RJGMhrqB0tRYTy6g95kteCLwZ9iAaKMLYLzq
         WVCiFbXUPGBDfxKMaU0i31o3yUD4FtSeWWVD4VjfFjTOqyHIdheB9gJ8/SPn6ezAxFvZ
         dt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mc2JpZIwrz2QvbYTAM+GAGmUcP7icda/B5vjZlO9/Ok=;
        b=jGRErC3pMrskmfoLIGfInKm+1mIfmIKEPckXB2XRsS3L83iDJC6HGLulk2Z6T74VQP
         sDYfluWg9alQooGr5FmB/RdPpHrOjYyciko5KhehLvT+EU23VSYtW9AcOzzIDTrZsEHx
         JVgCquascdmGL7fRa7hIciroqj6W6BdtbnPXcZMuiAI/VloWUvG3hlqX4UkUvPqZgeSj
         glqsyKWVfJVZhEC6Viuf/6IzA2KzBW4entDQStojB+z2jp1y2gOwrcz8dCxGdlTL9ks5
         Eobk55PWupqGJNB5m8ZeNKlFNm+iXFtwIbMz1Ju0N0Lq9IyN1B5Ws7YUpDQ9kjUX+hWd
         Ouhw==
X-Gm-Message-State: AElRT7FAofmtKSOd1ZVKnXP9WrSYxBpNQfVd3MuOkmAmL0Kb+Qvf4t+3
        lAmnRVO9eu/a2CfUXliyuwF6Xw==
X-Google-Smtp-Source: AIpwx48Lg0pZqyaajrBBNGFAcm0bdiDpd5ZPZsQtjMesjnZCnjXf2dwwZANrb11kRXD6mrCPSSbiYw==
X-Received: by 2002:a17:902:8212:: with SMTP id x18-v6mr26475679pln.372.1522991331163;
        Thu, 05 Apr 2018 22:08:51 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id c186sm11509759pfb.40.2018.04.05.22.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:08:48 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:08:47 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180406050847.GA52220@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522893363.git.me@ttaylorr.com>
 <20180405020238.GD8879@syl.local>
 <20180405221201.GA29929@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405221201.GA29929@sigill.intra.peff.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:12:02PM -0400, Jeff King wrote:
> On Wed, Apr 04, 2018 at 07:02:38PM -0700, Taylor Blau wrote:
>
> > +test_expect_success '--no-type unsets type specifiers' '
> > +	echo "10" > expect &&
> > +	git config --type=bool --no-type core.number >actual &&
> > +	test_cmp expect actual
> > +'
>
> Actually, one minor nit (not worth a re-roll, but Junio may want to mark
> it up): drop the space in "> expect".

I'm re-rolling for some of the other review this round picked up, so
I've included this in the forthcoming v5.

Thanks,
Taylor
