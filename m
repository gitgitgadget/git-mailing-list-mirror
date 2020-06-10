Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04103C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13202074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 22:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edwardthomson-com.20150623.gappssmtp.com header.i=@edwardthomson-com.20150623.gappssmtp.com header.b="Z8SqV3QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgFJWfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgFJWfb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 18:35:31 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417AC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 15:35:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l17so3302265wmj.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edwardthomson-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+H1fGC0Ny8nBWOAGSDYqdPcHwCFiJrVsAXYVec/sDjQ=;
        b=Z8SqV3QKS/7bPzSpJr9jhbtPSGp656BabL89UPmE+mDJR7Pu0CdefexH+Qn8S0JVeD
         D+tBms0LP94FiQnFjaaqvX6SZ4POgd8SWoslihiyT5n2SxykiIJ8XE9rit79Ty/zeKRy
         CjVQ1DWD3cuxblwKOoyeG7Kdmeyzv/ZSwUBmC52yIxrQOtIJwL9IAWLI6CtMincf+tRy
         FxnMcP1jvr6C2ymS9kj6LprYtkn2nPzf7bLnTCSsKPusVygE/CrcIa0k20TUoK5jNwFC
         MkFPN8FJhlgam7GkkDs/QTPwHyCCargZ29ayd1+4OmVoicxgs6Hmfc0j2VuNLGnsQDKs
         v6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+H1fGC0Ny8nBWOAGSDYqdPcHwCFiJrVsAXYVec/sDjQ=;
        b=p+HMcEqIx3GeL5xbyVUzGQU8SnOdyJ5whrm1k7wzAdOcvq4mDmJnjpzK0l9cqyF+Ev
         2xNFqPX7puYI0jmT9w3GpxOHVeX6UIW1lWomRpunZM7K2Esu7IVvprNC6Goj1slIbxlZ
         WoFoPVGoeoAPeC0E1m5tDrnQp1VvFB0EXmTMg4Ai1637FzpRsHzg5GKOr+nYTX/P43YU
         tgIxK8IvRUrHQK7i3BUq/AY7FG5ez0+2jm9uJWH8GHQN/VwPy//II5eihJXe9kj5Yqpc
         xhANLOF9O/ti7BzOWtPcZzQVAlDy2MFNNOFjl10euXNF0yD27ng+QaWP6Dv9fary0FKo
         ED4Q==
X-Gm-Message-State: AOAM532l/SF8eJxh5jY5E/4JQtF/BkDoB3sRNnU6LF6aS/DZ4CfsgEoz
        7sboj0eA4wouSfkuhwp+4+bdZg==
X-Google-Smtp-Source: ABdhPJx43U4k8aJ3qCwU5EdwQHQB9x08ssEVsHZr8UurJNajYgld8BM1L0h6NG4A1hzwCDMALaWrVA==
X-Received: by 2002:a1c:6884:: with SMTP id d126mr5112292wmc.121.1591828529764;
        Wed, 10 Jun 2020 15:35:29 -0700 (PDT)
Received: from 830aadfce907 (global-5-182.nat-2.net.cam.ac.uk. [131.111.5.182])
        by smtp.gmail.com with ESMTPSA id 67sm1845565wrk.49.2020.06.10.15.35.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 15:35:28 -0700 (PDT)
Date:   Wed, 10 Jun 2020 22:35:26 +0000
From:   Edward Thomson <ethomson@edwardthomson.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200610223511.GA7@830aadfce907>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 11:30:31PM +0200, Johannes Schindelin wrote:
> 
> Tentatively, I would like to propose having this meeting in the coming
> week, via Zoom, just like we did the Virtual Contributor Summit last
> September.
> 
> Could I ask all interested parties to reply to this email?

Yes, I'd like to be in attendance; this is a fundamental change that's
relevant to the libgit2 project's interests.

Thanks-
-ed
