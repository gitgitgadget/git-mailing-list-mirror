Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B182C54FCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F34D2076E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxBh+IC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgCWNIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:08:49 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37419 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgCWNIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 09:08:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id b23so16122948edx.4
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oDtK9WEchZOoMcY6m+8N6e/cNAToJn2AxKrNRqAjXSU=;
        b=CxBh+IC3oQ8rkYF5M4ayY8ASoFjf0gzwEJIeD3hlo4z5xFkxa7eoooSgr6hCkRPLQL
         kmHMGvcm3ICx2AUXL+fFIzlHMO2w8V5bzLGYzDDtDFpFEASfkoC7FU/hrGQxVJyltbbR
         xkEShTMGjLnTdbcf4LdRCW3UYPTAQzLauw8nNJFpoMXtbHVSHLF5vBwPE6H5p9U8jz3V
         O5TLEfwyeU+BI1ANLvDAt/vxB3iIU5TKO4+joY8YFDxEQHrJb+VOSMPAzzN3Fx1BNEi4
         1miiEBcUufrxNUsFR6CWzvJI/DbOKvWW3UgIi8PnFe37czUMMJlJOaOGADuesGvEAgMh
         5Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oDtK9WEchZOoMcY6m+8N6e/cNAToJn2AxKrNRqAjXSU=;
        b=aJR5/AgHvc215IkgoQktvQQ12nXHN5wVHa9cOeFDC6tGZI1ilb0mnPIdwOGSG11Hve
         hGLGSYyaV4JZ2xxAtgFe0q9xX+pCJj3dwMaF36f+Jnv6AcnHX4JzDbf5e7ewgYAp90U0
         3c5oTmwAr+qEqDlf8JvmNbIAOYznRjFv5Xsw4dlzxwIiKyz3iWi00hJdqRSJj667VSHj
         7DCya9rFb5nxxl0tiZRApUSW8lscjZE72fcMxS4wRdA1wIl56uPS6/pvTj9+wCO88xqP
         NfYGGqijkLMbOQkTvHWcYrmScy28L6x12cs3rdCVN66JzNubJPuZQ6DxxxD8OYJzALev
         V6IQ==
X-Gm-Message-State: ANhLgQ1GJ2JwZwQL/mYhZBkGpJrHN8wPL1+Rz809PWNDucTYAIEIZrSM
        qXGju6NHCJMPjsdSkov2j9LjYfL1
X-Google-Smtp-Source: ADFU+vt8ohfjb+K3v61LtpjDgmPXPMCzm1i+Ifa7w7ZDrowwEaKGetkZb1me3bCFPC9k2UroSXUxaQ==
X-Received: by 2002:a05:6402:b71:: with SMTP id cb17mr21023647edb.190.1584968925561;
        Mon, 23 Mar 2020 06:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm816034ejr.62.2020.03.23.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 06:08:45 -0700 (PDT)
Message-Id: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 13:08:44 +0000
Subject: [PATCH] import-tars: ignore the global PAX header
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git's own `git archive` inserts that header, but it often gets into the
way of `import-tars.perl` e.g. when a prefix was specified (for example
via `--prefix=my-project-1.0.0/`, or when downloading a `.tar.gz` from
GitHub releases): this prefix _should_ be stripped.

Let's just skip it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Ignore the global PAX header in import-tars.perl
    
    This problem came up in Pacman-related work, where PKGBUILD definitions
    would reference the tarballs downloaded from GitHub, and patches would
    be applied on top. To work on those patches efficiently (e.g. when an
    upgrade to a new version of the project no longer lets those patches
    apply), I need to be able to import those tarballs into playground
    worktrees and work on them. I like to use 
    contrib/fast-import/import-tars.perl for that purpose, but it really
    needs to strip the prefix, otherwise it is too tedious to work with it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-577%2Fdscho%2Fimport-tars-skip-pax-header-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-577/dscho/import-tars-skip-pax-header-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/577

 contrib/fast-import/import-tars.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index e800d9f5c9c..d50ce26d5d9 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -139,6 +139,8 @@
 			print FI "\n";
 		}
 
+		next if ($typeflag eq 'g'); # ignore global header
+
 		my $path;
 		if ($prefix) {
 			$path = "$prefix/$name";

base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
-- 
gitgitgadget
