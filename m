Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59051C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 08:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E80F2080D
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 08:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvtVCk8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGUImv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUImu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 04:42:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AB9C061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 01:42:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so11622183pgc.5
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qNcDgBCLm+aWtbb6eyi66iUa1Sd5wbPrimezq8a4aTw=;
        b=EvtVCk8upyamePxnSfUR4SLukcb4LhxUShJeIsKSHLWoMtLfL8Gi7BFbnxzIMrBiJr
         c5C7CTrH7R0fF3W+Rg5YhB8k7lVaoDL7fjrL1pW7q4lfjM7U8q4CWEaWnVlmqfH6m8IK
         pV8xK8Ns/xloWhfBagh9r+IK4C9EaDVIeNsp+7LdPEASwq5AiktQgNv3/wI1YyZ1BWtB
         m3khQUvDFcUdHltyFwwrppkl/LzkWcuzdqdDikwHZAp5vYu7yB9XcQjfV4cxoj03mweJ
         wZ4eSL+Dv8qLOQ+Xwn54GKvpaEDNnVrq5rqsoZnBLZXOQs32JugzGYuMHJmGw3r1u9cI
         ek6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qNcDgBCLm+aWtbb6eyi66iUa1Sd5wbPrimezq8a4aTw=;
        b=gwG4zP2t6pmM8uADnwQYER0zzktZLuFs7R6kuLrH0NFL34J76DFI8ioKLCETxT9Uun
         JOUYSInbQc12Hto8cczNb7WvoGAK7WDcJ6d5kGA7L2QlBrX4d+LwfOaVxfPUBsfef6VR
         qL9v94wrNzpRhkxVJ8SELy8VPiwKayWfbWdy43szwTQGcG3FcxV1uyxpfcL4mGCpCx0Q
         tjbuvuZgyf+fNNLcf9BwmCN27aXt86ExF5dGVvw2pjJNsM/1ULCZKXU4erAzHWvrnQBS
         zSqedn5F9W8JFojofayxtCPWAnUS+z6TXq1207jmFWZgYxrmwbKzMVUWeKgEmLtNrKRn
         UCOg==
X-Gm-Message-State: AOAM533VcGhGHOXG/Dlwt3rSqoebcJWkeFeSto6RP4wnhSmBjQo3THmO
        8tLxOvvfbUMm3IJqHIkgZS7LdPrg+Pw=
X-Google-Smtp-Source: ABdhPJyj+1ybwRp5uIMrGpM9yxB7k/fjJxqfUWBWH/yAqMfVB1I3Bzm6/5q/XK/ia6nJop5dDXWaDA==
X-Received: by 2002:a63:495c:: with SMTP id y28mr22129398pgk.30.1595320969999;
        Tue, 21 Jul 2020 01:42:49 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:4e15:5d57:88bc:ced0:b9c5:4254])
        by smtp.gmail.com with ESMTPSA id 137sm17702901pgg.72.2020.07.21.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:42:49 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:10:49 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com
Subject: [GSOC] Blog about week 7
Message-ID: <20200721084049.GA38525@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!

Over the last week, I continued my work on generation number v2. It's
usuable but is failing tests for t5324-split-commit-graph and
t6600-test-reach. I am going to send out the patch to mailing list as
soon as the tests are fixed.

Here's what is left for the patch series (which I intend take on for the
second version):
- Add an option to skip writing generation data chunk (to test whether
  new Git works without GDAT as intended).
- Handle writing to commit-graph with mismatched versions (that is,
  merge all commit graphs into a new commit graph with GDAT chunk).

I would be grateful for a pre-release review, just to make sure I am on
the right track.

https://github.com/gitgitgadget/git/pull/676

https://abhishekkumar2718.github.io/gsoc/2020/07/21/gsoc-week-7.html

Thanks
Abhishek
