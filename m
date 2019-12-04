Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D364AC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F80C20661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8/KUmJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfLDW3m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39380 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDW3m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so1522370wmh.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XJqUfapH7odAB2bWQ1ubCrdJoAcc5L6/ywib7uw6o9w=;
        b=f8/KUmJZOgqH0/V7veTqjNDeOQf3/3G6z4Gbstc3/35tRHLpN04Sz667YI4c7quP6I
         6cfArLwOcYUMZvMBgV8sUd2xUPdQn4fZiNeRON96qmEy45lRBHHLrIsfXAy8j/RTH2gq
         eKpG15GLAIwMAgRU6W39EyYYAe/m4TO+iRYQjs0dQTTZrT3EbBBrtDIDxdsbfzNZB1kz
         xJjuiqxxwQc4tZ12G2Lkj30UVEBgFgednFcRCOzQXx/ToVM8fFZ/w9zwVLIhaI7MLyvt
         +mcD17Y+lX2jKLsZNnEwUrJ1cekYUPkh+/K6DGEdpOQ9yzgx+RJoKeVtVGkKJri41VnB
         VMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XJqUfapH7odAB2bWQ1ubCrdJoAcc5L6/ywib7uw6o9w=;
        b=UgPVzSAQ8l3Sec4QBLYHxXzEyQ9Fyw28D7pnT7AmVvtK9oqV3c0qnZv9GqVH+/Iqre
         8barUBIN+VXgHojnZ8svPXeHblmyRc7ZrAn8E7GiY0TxM/R2JmE4NceqQ+75elGQK1R/
         StgzUYuRLAv/upiAcF1qjrGHRekenpm+YL8Wnf90rS4M7baRTzoRBcm291tOUELEGymA
         V3ZOh35OLCuGkfhv8cRwyPqtKaZSau6vuv6RJ1p1QUV9qwM9Jls4ba7/5FHeDcvpxR7W
         U616X0yVUy++odpXNX0/eq6gJePgGxon9LkmrfXN7M284us52VX+geF5yLe0oo30Xabc
         IjZA==
X-Gm-Message-State: APjAAAUvjDl1UvhZ4WX7ED1RyeK3uZuejJjwE/RwnJCEnfoXKUU0mAR7
        ZouMXod0ovXYjBvK3XC4OIT13YpF
X-Google-Smtp-Source: APXvYqwWqrQsChu08h9XvF0QBzWEaQM8bvpG3bkJaTusPWMGq94hp3818QaBa2K+2wI5pezVuoXOjQ==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr1841060wmi.178.1575498580354;
        Wed, 04 Dec 2019 14:29:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm10227070wrr.50.2019.12.04.14.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:40 -0800 (PST)
Message-Id: <40124269933691796ef57fd8df50f9e740d103b1.1575498577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:27 +0000
Subject: [PATCH v4 01/11] git-p4: select p4 binary by operating-system
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Depending on the version of GIT and Python installed, the perforce program (p4) may not resolve on Windows without the program extension.

Check the operating system (platform.system) and if it is reporting that it is Windows, use the full filename of "p4.exe" instead of "p4"

The original code unconditionally used "p4" as the binary filename.

This change is Python2 and Python3 compatible.

Thanks to: Junio C Hamano <gitster@pobox.com> and  Denton Liu <liu.denton@gmail.com> for patiently explaining proper format for my submissions.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit 9a3a5c4e6d29dbef670072a9605c7a82b3729434)
---
 git-p4.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..b2ffbc057b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -75,7 +75,11 @@ def p4_build_cmd(cmd):
     location. It means that hooking into the environment, or other configuration
     can be done more easily.
     """
-    real_cmd = ["p4"]
+    # Look for the P4 binary
+    if (platform.system() == "Windows"):
+        real_cmd = ["p4.exe"]    
+    else:
+        real_cmd = ["p4"]
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-- 
gitgitgadget

