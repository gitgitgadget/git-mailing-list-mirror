Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE8C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4932235FA
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbhANCF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbhAMWao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:30:44 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CAC0617A3
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:27 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 186so4468886qkj.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlHVhEYX5cqJqldP2f83BYJJb/dO87xV8oTauLhAP6A=;
        b=Qxo2/EZj3alJJyRv0kMGAABtGqFFYhgAEwrn9pPx8U7UAbrifDN0bhQ0fRUs2sVsiQ
         ydxciMNW+IhtL9NU/tBw1+42mCw0Cp8frfyje6NY4vPs/CEdqWp4t4kcm6lAsYenpcwY
         5IGxyM3iUHdJZ9yQryKstlmdeo0jUfwh2+/HsUiftr6SLr8OuzUoWUf3JuntPDVUbzmg
         lHZ5NC5bE/M+nxGlaWYXoTQh/JQUpD1qmr5dOl0oUH35A6vvH4rAuBtFfNwzvXQNy+BD
         T9eTsYlIasSdmIlL92HCV6BPaSq5EIPSGzugGmTyppfMRPODSZzC+iieYWmFMXI/UW47
         WUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlHVhEYX5cqJqldP2f83BYJJb/dO87xV8oTauLhAP6A=;
        b=ET1Cz+/su33QyxBp97pCDmQDq9KgtU3CrxvNaRciQ/INRjW2MXQdMtQYfuSNv874j9
         cm7V8DTxJhhgyauGed6R0uxbc8eJ085u8DCE3rNlNBijo9KVp9QrineFFinNdBR0NEFH
         4BHCMklHZ+9FRJ404Jfhhz0JzeRJPKamvpVqLKKpnDi3XghXoNkA+6VNxcUvcJXfA+S6
         uctGx+pu49lmljvGUkKktz1OkzU+E66SORw6Jmg4HTl3CaHJoyzvSodRbVk9nq2WyUtK
         HD1/gQIWqxiG6wEOCEEfCzbjPrV6PKoHw0ppYfO73oEG8NYZ49kUmxsMICOrPncaVpaW
         Vz3A==
X-Gm-Message-State: AOAM531IaXeW2DaUsN2Sfwq/Ai2dh7nVJIgGXuMmeEHgn1Gj1Pa0eAb/
        X8Zv6Ey2b5rDuMrGwVdM7obJoCwT09Hrxg==
X-Google-Smtp-Source: ABdhPJwUkZcl+E9Ztg8EM9rRrsMNgx+/0hHMa1HbH1f6djwhgxRr5vVsucf4xQ4dfdKB5OhyjlWP5A==
X-Received: by 2002:a37:68c2:: with SMTP id d185mr4349091qkc.45.1610576906586;
        Wed, 13 Jan 2021 14:28:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id i3sm1915864qkd.119.2021.01.13.14.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:28:26 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:28:24 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 5/8] Documentation/config/pack.txt: advertise
 'pack.writeReverseIndex'
Message-ID: <38a253d0ce29868000d7659158b1a1d5b841cdc7.1610576805.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610576805.git.me@ttaylorr.com>
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

