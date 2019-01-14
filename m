Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6679211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 19:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfANTDg (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 14:03:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42737 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTDf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 14:03:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so30206pga.9
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P18Ybx+1xKKLvJQq12gGSq4cRTFibbzJGFMIRbyzA44=;
        b=iQk8DiwVv4mdcGSbzyGwzPbCYZHLtnj5yqo5tg3XlOJDgYJdcVyIoQT4FSN7Qo2u4Z
         8iL8OPwULzzPBMVGwngTRal3xmHCzxiQHksfl+m4kcxby8wTia0QZQXCed/a68rLiOuV
         footAX8C14R1NCwNI5RfuVrDWWcnQZKCEyGHDmhrZD6pNGvkvp1Wlf4pRVLEmgDbA54f
         jFpUoqxTnwG/VdLeut4/4NtPMBVmxM02ODMunnViY4J4TBnQabHvqIbsvPUtvLT8Nrho
         RHnBunWcbVOtFTovr/5D0ZZeDmm2BlfK0+USxi1c9Sohj7++9GyB1RN/mZvocgKMRC7M
         d/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P18Ybx+1xKKLvJQq12gGSq4cRTFibbzJGFMIRbyzA44=;
        b=SZ2WOKXZ9FxpmDNqXKhkJWnakM9NG5F83e6q4CGiUrNpSrMyrkOJNzWg0hoV2cnynu
         /NOGSVp//eJKNsniLu85/w8mhOmlMpp2GU1DgPycUuSG0Eq7LRwJtGvbAtT5umA2MVQc
         Fk35evimWJcljIe3bryFCPOkUiXTqJ8CMW5zPL4zHs/GD54pTg0TrCbd2YvAuzH8dBrM
         bGDi1X4+/wBzX940rbLQEdbbE5wnjT/WR0ubyTmavsPxmb3Lv4pIvNJkqPwRf7/XnnyK
         k5zYqIzuiCGShgqafcwCKN5gP8RAYNWwObAydtPYgiSF12xjS9C1kvjzpuAlMUKAjioK
         EcYw==
X-Gm-Message-State: AJcUukfRnxzAmHtmaHMHycMkJN7tj11ryIUwU5IvhhSpgPnmcNBhoRJY
        euSfpDL/LTSOpGCh6QLu4j1Jnw==
X-Google-Smtp-Source: ALg8bN6ui5GlMlNnQVN9sVmj2rmLm8sh8ngi0YT00BLFCj00CbPPq9WJ2c2+BFWSaQq4vI/WTMl2Eg==
X-Received: by 2002:a63:b0a:: with SMTP id 10mr24217641pgl.423.1547492614548;
        Mon, 14 Jan 2019 11:03:34 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id y29sm1257767pga.59.2019.01.14.11.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 11:03:34 -0800 (PST)
Date:   Mon, 14 Jan 2019 14:03:30 -0500
From:   Barret Rhoden <brho@google.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Stefan Beller'" <stefanbeller@gmail.com>,
        "'Jeff Smith'" <whydoubt@gmail.com>, "'Jeff King'" <peff@peff.net>
Subject: Re: [PATCH] blame: add the ability to ignore commits
Message-ID: <20190114140330.0fe3e382@gnomeregan.cam.corp.google.com>
In-Reply-To: <003c01d4ac36$bdf29470$39d7bd50$@nexbridge.com>
References: <20190107213013.231514-1-brho@google.com>
        <xmqqbm4s6ozl.fsf@gitster-ct.c.googlers.com>
        <20190108112742.7878d4cb@gnomeregan.cam.corp.google.com>
        <xmqqimyz57l9.fsf@gitster-ct.c.googlers.com>
        <20190109154828.1b19dbb4@gnomeregan.cam.corp.google.com>
        <xmqq1s5k16zj.fsf@gitster-ct.c.googlers.com>
        <20190114101956.2b899d0e@brho.roam.corp.google.com>
        <xmqqfttvw2sv.fsf@gitster-ct.c.googlers.com>
        <003c01d4ac36$bdf29470$39d7bd50$@nexbridge.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-14 at 13:26 "Randall S. Becker" <rsbecker@nexbridge.com>
wrote:
> > 
> > Sorry, I made a too-fuzzy statement.  What I meant was, that unless you  
> are
> > ignoring E, I do not know why you "would want to" attribute a line "foo(x,  
> y,
> > z)" that appears in F to X.  Starting from X up to D (and to Y in real  
> history, but
> > you are ignoring Y), the line was "foo(x,y,z)", after E, it is "foo(x, y,  
> z)".  I
> > didn't mean to ask how you "would show" such a result---as I do not yet
> > understand why you would want such a result to begin with.  
> 
> From my own community, this came up also. The intent was to show everyone
> who touched a particular line, throughout history, not just the current one.
> Perhaps that is what Barret is going for.

Yeah.  I want to find the most recent commit that changed a line, minus
a set of commits that are deemed 'not interesting' by the user.  

The primary reason for this is to not see a blame attributed to a
commit that does nothing but reformatting the code base.

One could also use this feature for one-off investigation with the
command-line switch.  Imagine a manually driven git-blame + git-log,
where you do a git-blame, check the commit, decide you want to see the
next one back, and rerun git-blame with --skip-rev=SHA1.

The Chromium depot_tools has a python tool that can do this, called
hyper-blame: 
(https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/git-hyper-blame.html).

I thought it was a useful feature for all of git's users.  And I also
didn't want people to have to install depot_tools.

Barret

