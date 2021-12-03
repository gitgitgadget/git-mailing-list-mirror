Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF1CC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383190AbhLCVTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383185AbhLCVTi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB2C061359
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso5864624wms.2
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qnnARUJEEm3sGTd8Pw36NMYQWEiig9WLeH2Su3z30Pk=;
        b=VGBuCvEW/5wnWRYq95/UMiJemL3bFC6HjxhjSIlEn+x4XEjEthlREGmiuHBBxRbpqJ
         ya8t60BhLsvFDeiLUWGAN5ZZYbTRkHsOoN73VuBsTYhOfG3f1ZNsWQQuaqbAb4yrt+CM
         bjAd7mlWBPPRNUrlU52oOibLJGlqVkyYVFLwDjWgpnG7N3+NAIYc48uLYjn5Svfhdu8I
         a3Goztzo88Sokqgf+pMkxSoDIwUrwAa3/ZXZPRLilyaKqy5JOLWyAhw0wXbgrPj4IJQ/
         WlsCVJOp6NNJhn/r48QY3NMHaynwTLapu/cZufv5Pcw9WdQOfiXWtomZvQfoEwciLzc/
         s+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qnnARUJEEm3sGTd8Pw36NMYQWEiig9WLeH2Su3z30Pk=;
        b=4uBDvj5hx1MFQwCJnFzLuEwPME4R4B9E43GxOL290ttNwRpaCuQQo9/RhOyOI0JinF
         uVRH0s/Z3EOF9yNZCpuke/+ZK/PsAmAgxtSK89wPsqLXhL2M4FRgzE9S4QRhtBpz49LT
         1e+28ibgccM9PHsOP/ZkuE1K4Z66uoQ/nMe4VblJmkqTNOZKJatoH8iSOPhY3iwBDwj8
         NGrUnLnIa+BahYSwntDdkPEdE6zyhskiCIDOLM4MYMFJ+IfNEJ/qqRtoP10DSO1jpJyj
         4jONsAbSnoMU02EnugxiQJi15yUNV9p1ZhV3x6EpqQ+rsSB76aRHcgDHYDWCNupKkGW/
         bj/Q==
X-Gm-Message-State: AOAM531MLN1a1pgroObkGGJqTTZn4A2133xH/7QM7bf2TYC2ZOnQ+Tfk
        5Zm+O1sq2Uj6Q3zszxCtEEITE/BGFwQ=
X-Google-Smtp-Source: ABdhPJzlcGDAFPBt/0XvRVYube6Rw5m7OTX2c8MUtCBi4iyONNA06KuIxLik3m8EYfXi83Tp+MQjuw==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr18239451wmr.45.1638566171903;
        Fri, 03 Dec 2021 13:16:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm3791848wrz.97.2021.12.03.13.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:11 -0800 (PST)
Message-Id: <4d8d58c473b51cac6645a7d71336e995c1f3d28b.1638566165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:16:02 +0000
Subject: [PATCH v5 4/7] repo-settings: prepare_repo_settings only in git repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Check whether git directory exists before adding any repo settings. If it
does not exist, BUG with the message that one cannot add settings for an
uninitialized repository. If it does exist, proceed with adding repo
settings.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
---
 repo-settings.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/repo-settings.c b/repo-settings.c
index b93e91a212e..00ca5571a1a 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
 	char *strval;
 	int manyfiles;
 
+	if (!r->gitdir)
+		BUG("Cannot add settings for uninitialized repository");
+
 	if (r->settings.initialized++)
 		return;
 
-- 
gitgitgadget

