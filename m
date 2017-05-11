Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14AD61FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755097AbdEKHo0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:44:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34501 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755081AbdEKHoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:44:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so4943587wmf.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brz+9aIuJP2GGteanazzqj6NnUNd38gay9tsohiU/iQ=;
        b=OuDE+7jYl7m2xNSuXUtpIkSWp7IgIyuXnmMZtK5M0BuLWFz5tQwwxF0IlT/KdIh5ah
         tT58i51hx3AxSHx1xG491Io+8x6cCwZAsfUfOw88WrRRCa5oISWuvrqVnYxrTAV9lTTc
         c/MUr3srwc19uiW3QCEVZ0X53oM87xxp633YELTrllngYLKIXBqgeYSMjQaUvOKD8bI6
         6a6zmhBpRktks7Sm1zSSxdeggEvXjq4e0qWhFONWi5rFcf8gAg6GwB41wwzzw5xTBzrD
         sU8tIPXG1HhgYMlDhePLb3izLc19xwYNNChPqSkicKGoyOB+ETPkk+mFY3QISpZDUjaz
         lDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brz+9aIuJP2GGteanazzqj6NnUNd38gay9tsohiU/iQ=;
        b=oKOpP0DcFcUKw7i23H4hVhZuiWD6WXGi9vyu53ZGHapYXS70qbsZaz9D7P6Fm0NX2M
         ooT/AZzmD2vws9kYI9gVkTEi1Ckfs+B3PS/YBhzfzvwrj27yil9LcZOI6ZNbr9f5iRIY
         24ay2P3Ae9ll2IqjHB7Myr6d9NEmfoIYRBXzPiI6MAL3d3L4nB+CBXJDJGEcCgLXXrV4
         Evu2aW35CVPfyYuw+Ap5RbbYzyccBiZnOK066mNB/QlY1iuMJVid+GjQo1Yza4O04Hnk
         p0yoSZU/SbSCQCMtzGmj/hubLSIdRSOnLSyVpGlo3tM4gmdqJIIOqVtaOZKMqvBw/ep8
         DMmw==
X-Gm-Message-State: AODbwcBwNLdXpMo7kUnLXTG+fe6WplS8QIWUOcpo1/+s3/D+iJutJpXN
        QP1HtmgUplBOeQ==
X-Received: by 10.80.130.36 with SMTP id 33mr7187089edf.154.1494488663920;
        Thu, 11 May 2017 00:44:23 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c35sm325071eda.55.2017.05.11.00.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 00:44:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] perf: add function to setup a fresh test repo
Date:   Thu, 11 May 2017 07:43:53 +0000
Message-Id: <20170511074354.11336-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511074354.11336-1-avarab@gmail.com>
References: <20170511074354.11336-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function to setup a fresh test repo via 'git init' to compliment
the existing functions to copy over a normal & large repo.

Some performance tests don't need any existing repository data at all
to be significant, e.g. tests which stress glob matches against single
pathological revisions or files, which I'm about to add in a
subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/README      |  1 +
 t/perf/perf-lib.sh | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/t/perf/README b/t/perf/README
index 49ea4349be..de2fe15696 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -106,6 +106,7 @@ sources perf-lib.sh:
 
 After that you will want to use some of the following:
 
+	test_perf_fresh_repo    # sets up an empty repository
 	test_perf_default_repo  # sets up a "normal" repository
 	test_perf_large_repo    # sets up a "large" repository
 
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index ab4b8b06ae..f51fc773e8 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -78,6 +78,10 @@ if test -z "$GIT_PERF_LARGE_REPO"; then
 	GIT_PERF_LARGE_REPO=$TEST_DIRECTORY/..
 fi
 
+test_perf_do_repo_symlink_config_ () {
+	test_have_prereq SYMLINKS || git config core.symlinks false
+}
+
 test_perf_create_repo_from () {
 	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-create-repo"
@@ -102,15 +106,20 @@ test_perf_create_repo_from () {
 	) &&
 	(
 		cd "$repo" &&
-		"$MODERN_GIT" init -q && {
-			test_have_prereq SYMLINKS ||
-			git config core.symlinks false
-		} &&
+		"$MODERN_GIT" init -q &&
+		test_perf_do_repo_symlink_config_ &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null
 	) || error "failed to copy repository '$source' to '$repo'"
 }
 
 # call at least one of these to establish an appropriately-sized repository
+test_perf_fresh_repo () {
+	repo="${1:-$TRASH_DIRECTORY}"
+	"$MODERN_GIT" init -q "$repo" &&
+	cd "$repo" &&
+	test_perf_do_repo_symlink_config_
+}
+
 test_perf_default_repo () {
 	test_perf_create_repo_from "${1:-$TRASH_DIRECTORY}" "$GIT_PERF_REPO"
 }
-- 
2.11.0

