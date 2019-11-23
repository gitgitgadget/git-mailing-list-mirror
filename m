Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD08C432C3
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 06:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74B02071B
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 06:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldHy+YnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfKWG2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 01:28:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55597 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfKWG2p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 01:28:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so9711063wmb.5
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 22:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z1CRCTkccVlQIX5h9LmF41SPwihKGDRh6bB9V/grdec=;
        b=ldHy+YnR0+kYt+v1980apw5oshag3X78shf/mR2Hy726knpPlvvhz+b6DoHrZKLDaB
         gdep5dgA5gjYG91A4EgN59chcoqWaci40KAwbv7TjiwAXZIhGr5Xy9AKbSDhslU6x5e1
         Yuc06G3/rUq23/unKJWJR50PLrI3KWOCUHBrGjG2h/Cd3LnI51QN+R3elFFAXYimjgod
         904zkEvHW3MTNMqtuzy+dTs6mA3FJIU6Sz+O5VsJe61gpEyLzSId/e5UtPPNVQJNxMJD
         13YXC0W9Wryu21fCirG2zFF8KXN95ebTr/dx76vtbvs1r7gMKTWa0xukC5a4opKX1o0H
         wBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z1CRCTkccVlQIX5h9LmF41SPwihKGDRh6bB9V/grdec=;
        b=jqhnAzepyihcLinmvdSfieZBYYh8gRDXa/J4NHHKAkmqK52kMjOObyAwK5mb6/N9HT
         s0EoPQ7NTppi5Sc1w131qsIhBxl9V6wAPBKDUu/XnjbGkyVxUnjEi1Ak/xYQ3G85eWZs
         dxTsgpQcONJ/rTftiZ+ezpil/XkKZumEkaNMb0PWC+qe8OuuegycwGApt8ozBEU0Pfrt
         PYarQfx6F3slA5MJBg6hlKFV2S8dUm+fakdAHPNVRgkY43UKS3c3Frq6sTfvLH61lBsO
         4XSZaRm5PII2FiYQ1lpuuVGeci5TB5Q61golggWO7/EfIc71O7beEIvCTfuiK/Wqpm63
         1quA==
X-Gm-Message-State: APjAAAV0yvYYVw1f8cBa6/RulyfwNN0faFInaSegVC7nf9yy5d+z7VAa
        9HHfElPsB5CezHqg1HFfakaIJ5wC
X-Google-Smtp-Source: APXvYqyp+jJJcG8XLfXrxBJTGtbsLEPxe2CIj8OX4aLiaeVIkCTK7kAw221m/ZL1h4FlmGfKld3Xcw==
X-Received: by 2002:a1c:7709:: with SMTP id t9mr19669029wmi.80.1574490523366;
        Fri, 22 Nov 2019 22:28:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13sm772239wmc.41.2019.11.22.22.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 22:28:42 -0800 (PST)
Message-Id: <2004f4aaa99e5d936a3f3d141b5612df9b013f14.1574490521.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.472.git.1574490521.gitgitgadget@gmail.com>
References: <pull.472.git.1574490521.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 06:28:41 +0000
Subject: [PATCH 1/1] submodule: Fix 'submodule status' when called from a
 subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Manish Goregaokar <manishsmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishsmail@gmail.com>

Previously, when calling `git submodule status` while in a
subdirectory, it was incorrectly not detecting modified submodules and
thus reporting that all of the submodules were unchanged.

This was because the submodule helper was calling `diff-index` with the
submodule path assuming the path was relative to the current prefix
directory, however the submodule path used is actually relative to the root.

This fixes the bug by setting the `prefix` to NULL when running
`diff-index` from the helper, so that it correctly interprets the path
as relative to the repository root.

Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
---
 builtin/submodule--helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 909e77e802..abc5b46d46 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -802,7 +802,10 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			 path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
-	repo_init_revisions(the_repository, &rev, prefix);
+	/*
+	 * prefix is NULL since path is an absolute path
+	 */
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
 	diff_files_args.argc = setup_revisions(diff_files_args.argc,
 					       diff_files_args.argv,
-- 
gitgitgadget
