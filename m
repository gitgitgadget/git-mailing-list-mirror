Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30EEC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963C0217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb7MJXqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfLGRrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36563 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfLGRrs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so10566221wma.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F3lsGhleOwq/ZN6IhAsrTNv41G+GcQGvy/r72d0gD58=;
        b=Xb7MJXqbnGXRljzuOM3F/bFb1UbMOMPjjgEvEJLcpagzt4vA/AnrOIEpf2Mz464qhk
         BYsyRxtSJCgMdqXoN4XbhCTHZMnCsK1SoMy48b5zZEQCt7cVoTwGSBrgxD5kVrNSEMTo
         Me0/zwRddNHLeAV8nn9L6bFmVoahLHgiuhbpnBkHpEAlV8vXOfnuZ5cYrk+R6pKTpApv
         JFEa6lenP0BwqDbpugFvpTE7nH2BQxHjlUalUhfXGskWPixjVPIE+g4lgtO+cily87dv
         LfCFdm3D/ELSmGq6gE4hNCHPMtPiJiLLqxJ+q4kyK75RUzeZNJwHDOOH0HDLEgGtJXLR
         1Z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F3lsGhleOwq/ZN6IhAsrTNv41G+GcQGvy/r72d0gD58=;
        b=TK07+fXjMs3nFpzDA+9vUT8RZSqS8QvlD5D34sGgfIA3HV+ycWcNVC1nB61Ry6xyYP
         +g4FYX5zHi6nWAx0DITXtihNas7OdA82G375csM4r3WtpqnaOq1cU6c4AJOI4hU56W4f
         ifkAPac7AtxJvSF935TEb4KanjIVlpMFLE1aX5FC2Qca2m22umUFtgVDgU014KV/R9k2
         gcgE4gGjKYr+RQ9LFcii5qVJW3V0JYl+RJrQcAMBLwBrdCgXZUeFtN0undVazSTV0p+5
         O7oSRGD8Q5c/QjfPMJgCkUlUYBaoPbW2hO+YV/bEhSIZ6ZQ07yaGLTLyfsNIokTcjDrF
         gj/g==
X-Gm-Message-State: APjAAAW4h+1K5Op1EowG9gdTKgwnfoCmPvnprRpB3zX18cIPPo3N6/bI
        C4agNxqug27zEyA8d+O5V5T1ZSkf
X-Google-Smtp-Source: APXvYqwNkAB+AfSDxtr8crdGpQOG7buug2TZfc9G+4U6iBU5LAO+lwVjlnxf1DO1BniTm6Bj0teJKg==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr15406487wmj.41.1575740866799;
        Sat, 07 Dec 2019 09:47:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm20497050wro.85.2019.12.07.09.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:46 -0800 (PST)
Message-Id: <a7a4c5a2aa6b01236435bb4602ffd8c47614ae14.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:30 +0000
Subject: [PATCH v5 02/15] t/gitweb-lib.sh: set $REQUEST_URI
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a real webserver's CGI call, gitweb.cgi would typically see
$REQUEST_URI set. This variable does impact how we display our URL in
the resulting page, so let's try to make our test as realistic as
possible (we can just use the $PATH_INFO our caller passed in, if any).

This doesn't change the outcome of any tests, but it will help us add
some new tests in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/gitweb-lib.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index b8455d1182..1f32ca66ea 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -60,10 +60,7 @@ gitweb_run () {
 	REQUEST_METHOD='GET'
 	QUERY_STRING=$1
 	PATH_INFO=$2
-<<<<<<< HEAD
 	REQUEST_URI=/gitweb.cgi$PATH_INFO
-=======
->>>>>>> t/gitweb-lib.sh: drop confusing quotes
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
 		QUERY_STRING PATH_INFO REQUEST_URI
 
-- 
gitgitgadget

