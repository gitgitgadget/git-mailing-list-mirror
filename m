Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24528C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 22:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0758861378
	for <git@archiver.kernel.org>; Mon, 24 May 2021 22:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhEXWp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhEXWp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 18:45:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C3C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 15:44:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o27so28601327qkj.9
        for <git@vger.kernel.org>; Mon, 24 May 2021 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z1XYwEI0lPchwMbqb4cP5bOasnl8qDQI8CBw3IhNzpE=;
        b=JMuFBzs9k+Xw0lsVY2TGywtRAMcnMbIipPiaJIbMw5uhv2ZR4Srj55nk3x5d1vVVyL
         BIUpAoLawGpMIo53KsckZ8xODR0rEsN1iin6D40BA85KtlqApVxTT6WeiQp/vNCmwE+G
         3SzmnLwC6YXjEnrvhOaXeUPHFLfOzVVc2MCe+ycbmSPvQKaKgnQw01rOQKK45tK3Onby
         yXntnKAICgCNgEN82vvuqIHlHDrPEFVMe7e8i678KlZ82PSV475IicQIxry7oOHUB/30
         Qh5w7gFou9wgyCtjDKLsNip1Zqn7dXaVA4UyK4U2pByftckQgWwz295KeTIc6VufTqdP
         5ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z1XYwEI0lPchwMbqb4cP5bOasnl8qDQI8CBw3IhNzpE=;
        b=FhoahRshDYIJDsbwTtNEOhDcrc8kaQupiT4CXhVEUkOOSC+7u9OMYW9z/Fb0wNqGUA
         oH/nQEgO5gREeKWPvA9D8eZM6BiUzYmccHidnfhOzeuWLLjA4QGS+eOJVvtBhXGxte7P
         ncHl3oKeMfFc6rWicgkT1daj21MFm5MS3rda6guetVQ8OeLLl8zyE0h+mVynHucNti61
         a/y0KJrBhVVdYdHbmBQBp0WDfmbPFcXzHRtnE+2J5i8xZd7euVhGwCkKhIz3inz1UfMS
         6s8FVkVnw5uB/25y1Cl15A10B1MMgciwg5dSpW7ne+i2WWuEGNB8FMKjhUBP3XmFQbTf
         9EiQ==
X-Gm-Message-State: AOAM531tDE5GjXkK3L+JIH0HFtebM9tI0QShW7HKTBFsDxyvL1/BuVqG
        vELbpDbTlxf10SHyzrM7w7aYaa5Wu2SKjfXl
X-Google-Smtp-Source: ABdhPJxFI9AsfymvU66pjNgE/LqwaDhk8SemSfMTUZ0piGhPo2bz2G+kMcdqXbdKPI2onewJtzA35Q==
X-Received: by 2002:a37:a309:: with SMTP id m9mr33597355qke.126.1621896268796;
        Mon, 24 May 2021 15:44:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1c2e:9388:c87:38ef])
        by smtp.gmail.com with ESMTPSA id u27sm12050020qku.33.2021.05.24.15.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:44:28 -0700 (PDT)
Date:   Mon, 24 May 2021 18:44:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        =?utf-8?Q?'Jean-No=C3=ABl?= AVILA' <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc1 - Defect in t0301.3, t1092.6, t5300
Message-ID: <YKwsSgtfhaGq5z8k@nand.local>
References: <036b01d750ed$642b75c0$2c826140$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <036b01d750ed$642b75c0$2c826140$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 24, 2021 at 06:37:29PM -0400, Randall S. Becker wrote:
> On running the test suite on NonStop, t1092 fails in subtest 6 - but
> not when run with --verbose and -x, so I can't supply a log. This may
> be timing related. I wanted to report this in case anyone had any
> insight on whether there are any possible transient vulnerabilities.

The failure in t1092 sounds should be addressed by

  https://lore.kernel.org/git/pull.960.git.1621886108515.gitgitgadget@gmail.com/

> t0301.3 often has transient failures - which has been experienced for
> a while. Most importantly, t5300 continues to fail completely on the
> x86 platform, but not ia64, which I previously reported.

Not sure about these, though.

Thanks,
Taylor
