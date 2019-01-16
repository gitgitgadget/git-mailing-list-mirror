Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC351F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404153AbfAPKcm (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46913 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so2862290pfe.13
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ol+wViqE8ObUVWj8YOJCZuKfHYIe3CDHUcXoJVNNB3U=;
        b=sBz5wumLCe9gpskpYlhj1iSj+9pt9deT3xPX8KfaMaYWm32YbRLY9qoi87NFE4+PWk
         KOkM9KJgWWuKV3iDDS4yxED85pmyD2sR+WccgFaanAFJcqXKyuwN1SrBfzFm0PC47JOf
         OEa06NmVn1rLlbPpxk2qYmfTR3OMyxZYy7ugpQlLG6r9GCZIoMIwfrRpYppCNHo24axE
         CfWTnm9/1A1OQIVMEjaeXuxbF4cX3NUdbTryAksUeoA2jcb1Xv2eU+nTE49rvxPHRgPD
         oJeRFhhB0wIAsD59Vl2QcOzlMTUvS2cLlTHJKr+SGOe3+8SpgoGq/yqCUtrgo2KbmevE
         S4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ol+wViqE8ObUVWj8YOJCZuKfHYIe3CDHUcXoJVNNB3U=;
        b=sd5VUTRnJruNbdqp0WealMFux3OMK6Luj7tpw4QZ/06HKO0J1tuY0H3ZhJjDyQSTe0
         khpzHAC79ymAQ5LOsEy157bUJAtHBxW6VC2OJImi+oDVSjaz66JKL4PCrAyoD55gjsqs
         /OyxuAPhZU0rtWA2UjsqCmJ405Kak9w5AD6Eevh4pqwKvgRjFcrfYYcoZ11g4ohpVYUR
         21+LF8BHd08Uv/aIuCjhKIIDRZxZ2Yg/64FR4jcbgI0oykFRoKomW6l8ArUWG6Ei0eph
         GX4xkATUV61z8jUs99H4P6EvSsVnK/2/brzliZpi3gk1r8QYMrz8R6/B37I/txFcc7/v
         6LPA==
X-Gm-Message-State: AJcUukega20TPLAyJcB4jPHk0eMhg1Urw2jhnAF+8FjTEEqql1+2UMaY
        J8/sqc4j3R73OtBXCCQPDG5KqryW
X-Google-Smtp-Source: ALg8bN7EdVsZCzpbqHXmnH4kp49d0XJy5M+GF3RdQbHOEvTi6Hte3yZZWei7zrl5R9G6mnl4MUaOPQ==
X-Received: by 2002:a63:d104:: with SMTP id k4mr7989317pgg.227.1547634761022;
        Wed, 16 Jan 2019 02:32:41 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 84sm16750626pfa.115.2019.01.16.02.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/10] submodule sync: support multiple worktrees
Date:   Wed, 16 Jan 2019 17:31:55 +0700
Message-Id: <20190116103159.9305-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c    | 12 +++++++-----
 t/t2405-worktree-submodules.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6b749b41fb..288858af83 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -939,6 +939,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *sub_config_path = NULL;
+	struct repository subrepo;
 
 	if (!is_submodule_active(the_repository, path))
 		return;
@@ -979,7 +980,7 @@ static void sync_submodule(const char *path, const char *prefix,
 
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
-	if (git_config_set_gently(sb.buf, super_config_url))
+	if (repo_config_set_worktree_gently(the_repository, sb.buf, super_config_url))
 		die(_("failed to register url for submodule path '%s'"),
 		      displaypath);
 
@@ -1000,14 +1001,15 @@ static void sync_submodule(const char *path, const char *prefix,
 	strbuf_strip_suffix(&sb, "\n");
 	remote_key = xstrfmt("remote.%s.url", sb.buf);
 
-	strbuf_reset(&sb);
-	submodule_to_gitdir(&sb, path);
-	strbuf_addstr(&sb, "/config");
+	if (repo_submodule_init(&subrepo, the_repository, path))
+		die(_("could not get a repository handle for submodule '%s'"), path);
 
-	if (git_config_set_in_file_gently(sb.buf, remote_key, sub_origin_url))
+	if (repo_config_set_worktree_gently(&subrepo, remote_key, sub_origin_url))
 		die(_("failed to update remote for submodule '%s'"),
 		      path);
 
+	repo_clear(&subrepo);
+
 	if (flags & OPT_RECURSIVE) {
 		struct child_process cpr = CHILD_PROCESS_INIT;
 
diff --git a/t/t2405-worktree-submodules.sh b/t/t2405-worktree-submodules.sh
index c1b19ad613..55daace672 100755
--- a/t/t2405-worktree-submodules.sh
+++ b/t/t2405-worktree-submodules.sh
@@ -78,4 +78,37 @@ test_expect_success 'update submodules' '
 	test -d cloned/.git/worktrees/secondary/modules/sub2
 '
 
+test_expect_success 'sync submodules' '
+	sed s/submodsrc/crsdombus/ .gitmodules >temp &&
+	mv temp .gitmodules &&
+	git submodule sync &&
+	(
+		cd secondary &&
+		sed s/submodsrc/crsdombus/ .gitmodules >temp &&
+		mv temp .gitmodules &&
+		git submodule sync
+	) &&
+
+	git config --get-regexp "submodule.*" | sort >actual1 &&
+	cat >expected1 <<-EOF &&
+	submodule.sub1.active true
+	submodule.sub1.url $(pwd)/crsdombus
+	EOF
+	test_cmp expected1 actual1 &&
+
+	git -C secondary config --get-regexp "submodule.*" | sort >actual2 &&
+	cat >expected2 <<-EOF &&
+	submodule.sub2.active true
+	submodule.sub2.url $(pwd)/crsdombus
+	EOF
+	test_cmp expected2 actual2
+'
+
+test_expect_success 'reset sync submodules' '
+	git checkout -- .gitmodules &&
+	git submodule sync &&
+	git -C secondary checkout -- .gitmodules &&
+	git -C secondary submodule sync
+'
+
 test_done
-- 
2.20.0.482.g66447595a7

