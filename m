Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDFC43381
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9163323A7C
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbhAHSVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhAHSU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:20:59 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F56C06129C
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:20:19 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id h4so9288235qkk.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlHVhEYX5cqJqldP2f83BYJJb/dO87xV8oTauLhAP6A=;
        b=ZcF//ZZA5fjFktTgf0tnnAAAakvIJ651RdZoOf84lgUSAnSS4O2GIs5fmDkJFBiRL8
         tniL8oUNAmOGDUlZDYVac7W7VecEgrluoIW8s3exBXApnoQN6+fPo0FfjembM5xKQK7e
         gpg9UATxaNvti9OrGqelqBGN3Pe6bbNxlJGk6nlF3BfvWzSSWUJ/rxne9YltoYyF2v4h
         mYvUZI1akxHGKSwE9BC32gDFDoXSLBfmo0p0evtC/etvf9EEr4vD7vCDGUJu5beIdbxa
         EjM1mwelNnhWSSPqKFnicot1dC3o1bvXkietkvlP8Q5QyDAimxWQvMmnXKVyLE3cGg0e
         s2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlHVhEYX5cqJqldP2f83BYJJb/dO87xV8oTauLhAP6A=;
        b=Qhp4d0uEVChSqIpba6vJXnt9/X+m01zac5Ae2eokdgKKx69wy0EAwE25tCIpXmjWG+
         sJvHVOuelujH6kNoF13jnwZ+KDB50zmAgPG3SL3L+zBGnDF+/gqJ36dX6xNuAszJMN7S
         sspGKu6Kb46m6DIzUZMdStGqB6jB2FK6m/ONR4xB8jNdvnu3QsKWnsWBKQAc42ZXHzjf
         FkjCYT5DZPLqfL58WbnUv+h0GoFqZtGiArfjUM7XQrUpCfJI5HtnpHPt7FGSeBiSyX9c
         rD5SvvD2GvzBMqUOAS/+58MWfKOUSBIYDIPUoImuDlRU0CBmTZlGDfQDxypTHJ97FoD1
         yblA==
X-Gm-Message-State: AOAM530UAZIQVMSAXOFa2LN0PAmMSWC6L6NSGOKC11evsX6xeUMBoRl3
        DwtB9i6JH+rbJZf5L11G5Utg8/DxyvKUuA==
X-Google-Smtp-Source: ABdhPJzY83d7yH4VJPNm3mzVn63pw/iF37LhByVkUtiVXf2tU12/W+MHvd2ltd/6PcY2P+Sc78D52w==
X-Received: by 2002:a37:b983:: with SMTP id j125mr5033571qkf.418.1610130018726;
        Fri, 08 Jan 2021 10:20:18 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id b78sm5041544qkg.29.2021.01.08.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:20:18 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:20:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 5/8] Documentation/config/pack.txt: advertise
 'pack.writeReverseIndex'
Message-ID: <5d3e96a498527959ae2f77476cd00474e36fbc97.1610129989.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the pack.writeReverseIndex configuration is respected in both
'git index-pack' and 'git pack-objects' (and therefore, all of their
callers), we can safely advertise it for use in the git-config manual.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 837f1b1679..3da4ea98e2 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -133,3 +133,10 @@ pack.writeBitmapHashCache::
 	between an older, bitmapped pack and objects that have been
 	pushed since the last gc). The downside is that it consumes 4
 	bytes per object of disk space. Defaults to true.
+
+pack.writeReverseIndex::
+	When true, git will write a corresponding .rev file (see:
+	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
+	for each new packfile that it writes in all places except for
+	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
+	Defaults to false.
-- 
2.30.0.138.g6d7191ea01

