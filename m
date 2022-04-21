Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392282AbiDUUVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDUUVF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:21:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC14C794
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:18:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so6604211wmb.4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dNUBW5KfplQDZQE70P1sX7AfduLuPfYGI0rAuIwZfio=;
        b=i1nBdilM+hNwFtBK47vNK7wFpWvxD3nOxVl3BxoKT5CrqsgneLt6Yl/IO9Gecj2XHB
         0M1VQuhjGM8wWdyIzsMWbHI0pDbwEI20IJ1EFeTbf8PY9l+kC84M8gC/LlBvTcMidRjw
         ZMJMvhElavF7jfrUAKqfWf8iHC0wxsmQcMz4b0DgLQse3mf8UDeu1byTkETbo4eTRh3p
         y3hTjQ6gP4hm9D60H+VY6RvV8t1nHIeRBBTEqMqboWto7lEu53qIYchPM8BhcuBdnff3
         vETb26kbTlGXQ9HoBiuo2Ydo9FSRn4VH9TUUTpPkz59RSMNm7K0XBWl5q8YUJaPwquxn
         E8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dNUBW5KfplQDZQE70P1sX7AfduLuPfYGI0rAuIwZfio=;
        b=KW4Mtctk0D0r1r5c78MN1GfYDgu8z/BzfYodsENbptgQgmE0pPsfg9H04SdsA7lLTr
         3a9A9Bkl5PcwfZ1SiYNJ+FXrly+4WFzlCNVymSejrneyxAeC1k0NyjtfmK5YnMQavBEg
         hFBB8U03+00pdAKkiUtoMih0b/VaqHEmksjxWs8n+Vbv3J3RiF66FqJ8YCGbaTF3tRHq
         iMHZ/x2ayPqrU72J5yS1gW0wXvF/QPy6FviZYQEZgtXoc9ymXRc34TNzkbSa+OIHUPkG
         oHTdAFC6nxii3Qn1kO/XrSX5PDCGm5nvz/cT9UvqCqsQYHJGwMmKfb8iFP0zGiSLvU1W
         ha2w==
X-Gm-Message-State: AOAM5321yuZ0G+vNb213J1e/85p1ejD+MrgIJYLehqLS7ysN8EdDlAK9
        gBCt4ARksjW9+R9I6DxPq3Ai4B+wjyY=
X-Google-Smtp-Source: ABdhPJz0DnXhQ1l+mG5jq97CVRM3yTazv+VptIdvF78pWbxfofzxAE1fRhUSvmDFpJUNVp53tPRt4w==
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id 184-20020a1c19c1000000b00393a19f8f95mr912133wmz.149.1650572292307;
        Thu, 21 Apr 2022 13:18:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a0560001a8e00b0020aaf034e59sm18968wry.90.2022.04.21.13.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:17:34 -0700 (PDT)
Message-Id: <c591e50ebb4593f9716c8e7682ecdecdb6fb5ae1.1650572159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com>
References: <pull.1256.git.git.1650572159.gitgitgadget@gmail.com>
From:   "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Apr 2022 20:15:58 +0000
Subject: [PATCH 1/2] diff- family --stat: use the full terminal width
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Koutcher <thomas.koutcher@online.fr>,
        Thomas Koutcher <thomas.koutcher@online.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Koutcher <thomas.koutcher@online.fr>

Make diff-files, diff-index and diff-tree --stat behave like diff --stat
and use the full terminal width.

Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
---
 builtin/diff-files.c | 1 +
 builtin/diff-index.c | 1 +
 builtin/diff-tree.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 70103c40952..2265cd256be 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -29,6 +29,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
+	rev.diffopt.stat_width = -1; /* use full terminal width */
 
 	/*
 	 * Consider "intent-to-add" files as new by default, unless
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 5fd23ab5b6c..9cb9555fdeb 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -26,6 +26,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
+	rev.diffopt.stat_width = -1; /* use full terminal width */
 	prefix = precompose_argv_prefix(argc, argv, prefix);
 
 	/*
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0e0ac1f1670..4a2a2744fae 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -122,6 +122,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		die(_("index file corrupt"));
 	opt->abbrev = 0;
 	opt->diff = 1;
+	opt->diffopt.stat_width = -1; /* use full terminal width */
 	opt->disable_stdin = 1;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.tweak = diff_tree_tweak_rev;
-- 
gitgitgadget

