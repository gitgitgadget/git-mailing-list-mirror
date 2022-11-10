Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4D8C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiKJQh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiKJQhi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:38 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265BC3F054
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:37 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b185so2667417pfb.9
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx4aSNeHu3sCYhnj1uKkCX55g5706yLEiPjl3WxMLsU=;
        b=Deq4jhWcRdA7xFNogAkMuMGtEI8t5VuuO+dEnsRFC7DUsQ6rhqr21Jtaw1zJEk7fMq
         cnhr9ko/qdB8dgFkCaNu+mV6TwmnXT6CjjfYk7LU0j9i1/FWAqbdUJZICnMebUSH/kN6
         gvorEMPLEI85dbkWaFLmIhoXVgABN7fXxrOOVOcc8A1dfOmypqNBvJMG3zkRJPRPKxmW
         AZsBXUgdJ/jEbcfa5f8yGJ90D3skelaGrLZzT09VWi2i8TBHzP+GVw9FB5JFWley2d+K
         QNFhzLP5L8/3CszFPqltrkWJzjG4GVwj+ORGYULTb9ne5Dd3Ur3q5oOXdQxwRGW38PaD
         AEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx4aSNeHu3sCYhnj1uKkCX55g5706yLEiPjl3WxMLsU=;
        b=hWnfpoq1sxMs05Fbx6XR+RIbkRVMT/rlpkmKnO4bfEyHEs9NVpfL+A/yrh+uIgVINh
         Lor+p/h9N/jbuwx5MHR69JKwyymw5zNbRMGXwaz2Y8K9pacNUZSbxc5FzcOHWeyOOIpG
         b7NYdBrHRv18AeqvIvB3EvqGaHfyQddho1gDMtl2O3z4Q50K/xFiaUu6F6kKMjGvaXSw
         +aU+WEwGxBcioX391t+Ad3celsfQZRvF/oM1CSvTzQWx1d8VYFOljThY5FKZnvlXkNZp
         Z1uNwKBgF51gJcjgVVyDhVI0ettet1O17Y9BR1fPdymWx4BiIBjJ7MlM9J59ZMXegWRg
         AP3Q==
X-Gm-Message-State: ACrzQf0y/dMTYL8c1db69ibrVjsDgMy7fquqvm1JKB5snkmiXlLVu4IE
        q103j9j3F7ORWM8NON88gUeB9QXsOg4=
X-Google-Smtp-Source: AMsMyM54owTcSVM/kz22nIkqn8j6RTTAWnDpPXwQ4FJCeTTFkAbTFsi7YStWdMD/MxvCsmIJqtCBJw==
X-Received: by 2002:aa7:9298:0:b0:56b:b6dc:988a with SMTP id j24-20020aa79298000000b0056bb6dc988amr65527403pfa.5.1668098256278;
        Thu, 10 Nov 2022 08:37:36 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:35 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 11/11] Turn `git bisect` into a full built-in
Date:   Thu, 10 Nov 2022 23:36:46 +0700
Message-Id: <dadca7adbe3e7984f60fd6de6c8d63edb6a1ad8f.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that the shell script hands off to the `bisect--helper` to do
_anything_ (except to show the help), it is but a tiny step to let the
helper implement the actual `git bisect` command instead.

This retires `git-bisect.sh`, concluding a multi-year journey that many
hands helped with, in particular Pranit Bauna, Tanushree Tumane and
Miriam Rubio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Makefile                               | 3 +--
 builtin.h                              | 2 +-
 builtin/{bisect--helper.c => bisect.c} | 2 +-
 git.c                                  | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (99%)

diff --git a/Makefile b/Makefile
index 4927379184..78785c6b84 100644
--- a/Makefile
+++ b/Makefile
@@ -627,7 +627,6 @@ THIRD_PARTY_SOURCES =
 # interactive shell sessions without exporting it.
 unexport CDPATH
 
-SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-merge-octopus.sh
@@ -1137,7 +1136,7 @@ BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
 BUILTIN_OBJS += builtin/archive.o
-BUILTIN_OBJS += builtin/bisect--helper.o
+BUILTIN_OBJS += builtin/bisect.o
 BUILTIN_OBJS += builtin/blame.o
 BUILTIN_OBJS += builtin/branch.o
 BUILTIN_OBJS += builtin/bugreport.o
diff --git a/builtin.h b/builtin.h
index 8901a34d6b..aa955466b4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -116,7 +116,7 @@ int cmd_am(int argc, const char **argv, const char *prefix);
 int cmd_annotate(int argc, const char **argv, const char *prefix);
 int cmd_apply(int argc, const char **argv, const char *prefix);
 int cmd_archive(int argc, const char **argv, const char *prefix);
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
+int cmd_bisect(int argc, const char **argv, const char *prefix);
 int cmd_blame(int argc, const char **argv, const char *prefix);
 int cmd_branch(int argc, const char **argv, const char *prefix);
 int cmd_bugreport(int argc, const char **argv, const char *prefix);
diff --git a/builtin/bisect--helper.c b/builtin/bisect.c
similarity index 99%
rename from builtin/bisect--helper.c
rename to builtin/bisect.c
index 6066f553fd..cc9483e851 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect.c
@@ -1401,7 +1401,7 @@ static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
 	return res;
 }
 
-int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
+int cmd_bisect(int argc, const char **argv, const char *prefix)
 {
 	int res = 0;
 	parse_opt_subcommand_fn *fn = NULL;
diff --git a/git.c b/git.c
index 6662548986..a2deb15e46 100644
--- a/git.c
+++ b/git.c
@@ -492,7 +492,7 @@ static struct cmd_struct commands[] = {
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
-	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
+	{ "bisect", cmd_bisect, RUN_SETUP },
 	{ "blame", cmd_blame, RUN_SETUP },
 	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
-- 
2.38.1.157.gedabe22e0a

