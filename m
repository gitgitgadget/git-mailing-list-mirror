Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722CC433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbhKYW7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbhKYW5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:57:42 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDACC061759
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so5617228wms.3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOZ5YvM9Q3uXmM4Q0Gps7urCZmFpfS/Czr2Jg81l35Q=;
        b=ZUNdYQ9T5bWIKifojklWVSCaWXYDTSLuMjZucqwBFC781DW0AWXBJ+iQMAYfrL/zYp
         zUtE7tcyAqAWu04hDHgv6NfptNfNi26IWgUTpeEi4mfHxYY+5rk2KnkVU5DU2Pu+/bsQ
         OzV/46N7O5/SKNKP63Sv5FD4UkiRHRm0TkTqKasUASqqzxLb+qATK52hOBnnWOLAAtuj
         zdZLSAEcszkROsL5dm6kSyRkhOaO1zp3schB3Ai+/8AB/9ZYrusukNLom4yKHcLU6WLy
         lIBtmVpO27qZSmMxbZ/SBw4lrTRf5L4xKfAcyawY6KOtZh600XYeP2UE1zqQfInFmpv+
         NobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOZ5YvM9Q3uXmM4Q0Gps7urCZmFpfS/Czr2Jg81l35Q=;
        b=DALwbfgnvvxq+FWnwOd3sbuZkBE5FNE2gZ0D1piLOjK+0sVWPHwU03FjpnqgSKiIu8
         2ufB+7v15VR0tnlosYh2XoiD2K8TT2Zb+hnVbaHOluScEluKAUiUZPu05FOBXxHMFG2R
         M2P0A0Ryxj148ITXNX4QfxUVgMIsKVxu9caVQJS5se13xz+OvXpU4UupsvvE0lOXZwKJ
         AJPJT8d+Ktmzg4xXnQLTg8LhNg26tw9LldJxMdqO9bNzakEL18Ijd6Z449dXTavuzz+q
         w+N9zrLsx1WrqnalVzrJh5CgUI9m3RxGaISv81UEOhO2ybO6Ua9aSdRq+Xw991M3hBK6
         o56Q==
X-Gm-Message-State: AOAM5311PvEaVx+ZSNJBGtXY9lgxqvQJHDNXu/l9UlaPmRIvvvNiICBi
        uz5m1bT5AwSkGay0Z7wjDdenuqmiOzUfww==
X-Google-Smtp-Source: ABdhPJw3bcDc1Jfts+xJkzsD/IOGrOj2eww4dIZ14ErPEtaKJK5oLdukVL7Uq8ndSeVGWFd3gWQySw==
X-Received: by 2002:a1c:a74a:: with SMTP id q71mr11960572wme.105.1637880755188;
        Thu, 25 Nov 2021 14:52:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h22sm5001257wmq.14.2021.11.25.14.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:52:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/9] difftool: use "env_array" to simplify memory management
Date:   Thu, 25 Nov 2021 23:52:23 +0100
Message-Id: <patch-v3-8.9-203f44a91f4-20211125T224833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20211125T224833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in 03831ef7b50 (difftool: implement the functionality
in the builtin, 2017-01-19) to use the "env_array" in the
run_command.[ch] API. Now we no longer need to manage our own
"index_env" buffer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/difftool.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4931c108451..4ee40fe3a06 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -202,15 +202,10 @@ static void changed_files(struct hashmap *result, const char *index_path,
 {
 	struct child_process update_index = CHILD_PROCESS_INIT;
 	struct child_process diff_files = CHILD_PROCESS_INIT;
-	struct strbuf index_env = STRBUF_INIT, buf = STRBUF_INIT;
-	const char *git_dir = absolute_path(get_git_dir()), *env[] = {
-		NULL, NULL
-	};
+	struct strbuf buf = STRBUF_INIT;
+	const char *git_dir = absolute_path(get_git_dir());
 	FILE *fp;
 
-	strbuf_addf(&index_env, "GIT_INDEX_FILE=%s", index_path);
-	env[0] = index_env.buf;
-
 	strvec_pushl(&update_index.args,
 		     "--git-dir", git_dir, "--work-tree", workdir,
 		     "update-index", "--really-refresh", "-q",
@@ -222,7 +217,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	update_index.use_shell = 0;
 	update_index.clean_on_exit = 1;
 	update_index.dir = workdir;
-	update_index.env = env;
+	strvec_pushf(&update_index.env_array, "GIT_INDEX_FILE=%s", index_path);
 	/* Ignore any errors of update-index */
 	run_command(&update_index);
 
@@ -235,7 +230,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	diff_files.clean_on_exit = 1;
 	diff_files.out = -1;
 	diff_files.dir = workdir;
-	diff_files.env = env;
+	strvec_pushf(&diff_files.env_array, "GIT_INDEX_FILE=%s", index_path);
 	if (start_command(&diff_files))
 		die("could not obtain raw diff");
 	fp = xfdopen(diff_files.out, "r");
@@ -248,7 +243,6 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	fclose(fp);
 	if (finish_command(&diff_files))
 		die("diff-files did not exit properly");
-	strbuf_release(&index_env);
 	strbuf_release(&buf);
 }
 
-- 
2.34.1.838.g779e9098efb

