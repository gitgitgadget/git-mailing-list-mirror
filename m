Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF6C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10DB20730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 17:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uut9gOk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgD1ROM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgD1ROM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 13:14:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B348C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 10:14:12 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h12so1299370pjz.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AeDdcKqiDRQjHNmaZoE84fLRJqMwIpPE4Dga4Frz9U0=;
        b=Uut9gOk4Fn9NHvL/aflSe5xhjcS/LLp9otaAkdrebDf+0tSB3EGfQBNF0DBAp5SVL9
         4RXgMkoq2PhPyPBKpgUrqW9thAPPPwI7c0asDjuQDyy91LCExIcQya2eAQdj11Z/yRIC
         aQkHHw69TWn1E8U1rM3hvrgLSys7vK5uKA1gNtPa5/1Yd5omibaCi7nZIb+bdguWm6LG
         Aei3hP26tX17Hh+HbaJ5WN8wLKBephXjQTqbwN14/+yHQJyTglaDTSOBazTf/4KPidqf
         cj36JfiIkpmYHyE6JUTy2rlWQ5zmLvf8nfMOXNC6iiMw5vB0XUM+6LMF6FhvcfR7c9eR
         0KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AeDdcKqiDRQjHNmaZoE84fLRJqMwIpPE4Dga4Frz9U0=;
        b=G5kwUQAQ1kh1FxV+jAKl+Z3GD9p+zMmtW9GW6nl0bilfk2HdXX9LA5MOmanBXO3Ha0
         niH3lAh1vumyXylwoiN6XnvHBeDh5CfBMQn9ZweGbyub4G0eDAaoelFF/XnKGIfwnoRv
         uk+0GfUwJY56Aq/WJ4qVNa/8QWUo9PP8afnoCaG//wwsROsny98gxjk4f+qXLQnnkUf+
         55MhNx9iEO/JkK7qTvdkTpTibcs9yybO4xbuS/M3H890YkNlo5Xur5KFj7nFfuUS0W+m
         SIc+YqxkoU0yUM85Gzikg4H2lxfWqAMRGzvSjwsRsJYnH84v6BEbAomwXScaSqxaWG2j
         8NRw==
X-Gm-Message-State: AGi0PuagnSPZZgcYVTA71H325AnAtXhp+3WP2GRwBt+1B/+ql5bB0yyx
        Nz73AF36RfOXLdF4AAtRP7I=
X-Google-Smtp-Source: APiQypIOMirZdrhftA00Q2W/BWrmjyNkj+QresFv4oLfFpEG+X89M16h7NsOkMvAQcNFAZwZt7KirQ==
X-Received: by 2002:a17:90a:37c4:: with SMTP id v62mr6032678pjb.177.1588094051881;
        Tue, 28 Apr 2020 10:14:11 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n34sm8971353pgl.43.2020.04.28.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:14:11 -0700 (PDT)
Date:   Tue, 28 Apr 2020 10:14:08 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Dirk <dirk@ed4u.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 3/4] git-credential-store: fix (WIP)
Message-ID: <20200428171408.GB56126@Carlos-MBP>
References: <20200428104858.28573-1-carenas@gmail.com>
 <20200428105254.28658-1-carenas@gmail.com>
 <20200428105254.28658-3-carenas@gmail.com>
 <CAPig+cTjZQ7csu78jFx-w1SfewptTrOeR68aEwst7F2qvowR4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTjZQ7csu78jFx-w1SfewptTrOeR68aEwst7F2qvowR4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 12:11:20PM -0400, Eric Sunshine wrote:
> On Tue, Apr 28, 2020 at 6:53 AM Carlo Marcelo Arenas Belón
> <carenas@gmail.com> wrote:
> > From: Jonathan Nieder <jrnieder@gmail.com>
> > Subject: git-credential-store: fix (WIP)
> 
> Um, what? Did you forget to squash this into the previous patch?

no; was documenting his proposal from 20200428052510.GA201501@google.com[1]
with the hope (unsuccesfully) to save everyone time and easy testing by
having a series ready to apply.

> > Helped-by: Carlo Marcelo Arenas Belon <carenas@gmail.com>
> 
> No sign-off? (Jonathan's)

really my fault, but was expected as documented in:

  https://lore.kernel.org/git/20200428112518.GA15981@Carlos-MBP/

sorry for the confussion and thanks for your review

Carlo

[1] https://lore.kernel.org/git/20200428052510.GA201501@google.com/
