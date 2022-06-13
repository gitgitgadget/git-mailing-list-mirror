Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A1AC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiFMWjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiFMWjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E61FD04
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c21so8857423wrb.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6kWpDb7cOxkASsP9RDswK2OLw7IzdvDRnFNSRMnWyQ=;
        b=LTSbqylZEtQtH1fkzsJ75QFNlJ4Vl8mAjcWgWB/Ox/gHq8D4kTSnNVGVkM9L/YQh0W
         c/PYkUgxNJum3MoVbxNLUbNuIcXAmZ+eW0EHlQcSsLRwsQ8uqWSaySiSr4f24jlf8lm+
         n78YptgHircTxKUEb+Lyluurh499+K5/+ZIaD3h3+MapFlowZw2bci1ZNIaZf+QsIHY1
         nGdQyawAy6q4ubWf1uvN9v3tUbd7piiRCI4UqvhOzmPq5w/3i5sAKr/LJk5qcxWCb8+C
         wtSmNidj4xpVc86gxHZs2q4nZdZeeda9tgGfLhLx81XXcJ/gRsZTXySqUAkuTLrNHWlA
         J46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6kWpDb7cOxkASsP9RDswK2OLw7IzdvDRnFNSRMnWyQ=;
        b=UEtuEzu4z7Vn0R7jykJVqkPzE03a//Zp+X7i6BFMlp6n25o8nNIhEC8n43LhgiwhTu
         aM3CPRZQKzXz53B0WHxx3Rspaujpn6mzf0eJDTwLQ2vN4Sv9Esx4NvK/lJXn2eUKTyqM
         /zi7gcQiW/kzf+3U9y2L60yxmvc1ubHnp+R17OOxBXQXiiiFsIEtkuKRe2KUuGLEEe2N
         Ful5mW38gyqaSIDl062DOQLO8H5ICGOlBPzNw+Dw6aGZqRrAbGxRA/CDm7PMUXskjzrK
         RGV5guyvuqLXZAH1+ozTXD2gmX92scr/GZSiBGjEt/tbxY1KIZ0PIndgDzZjPQ6f5kLH
         l+DA==
X-Gm-Message-State: AJIora/PH5KPYaV/A9eznK+6sFKFEF+YKHn4452PU1OgFaaNOqBGjndB
        96qUJTbYJih1ZUwRo9jlZpGBlPlGaCs5mw==
X-Google-Smtp-Source: AGRyM1uPkXS1tBoqgoRNT6qkJlG9p93rQx0cgm9W4THLHVfCFreSMoiwD61tA8z80PonEkdgkW1Oew==
X-Received: by 2002:adf:fb46:0:b0:210:2316:dd02 with SMTP id c6-20020adffb46000000b002102316dd02mr1761552wrs.557.1655159954212;
        Mon, 13 Jun 2022 15:39:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/12] submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
Date:   Tue, 14 Jun 2022 00:38:58 +0200
Message-Id: <patch-v2-07.12-63155ab5026-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "absorb-git-dirs" subcommand to "absorbgitdirs", which is
what the "git submodule" command itself has called it since the
subcommand was implemented in f6f85861400 (submodule: add
absorb-git-dir function, 2016-12-12).

Having these two be different will make it more tedious to dispatch to
eventually dispatch "git submodule--helper" directly, as we'd need to
retain this name mapping. So let's get rid of this needless
inconsistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 git-submodule.sh            | 2 +-
 submodule.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7bcb76cea6a..574d6e0a79b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2787,7 +2787,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorb-git-dirs [<options>] [<path>...]"),
+		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -3386,7 +3386,7 @@ static struct cmd_struct commands[] = {
 	{"deinit", module_deinit},
 	{"summary", module_summary},
 	{"push-check", push_check},
-	{"absorb-git-dirs", absorb_git_dirs},
+	{"absorbgitdirs", absorb_git_dirs},
 	{"is-active", is_active},
 	{"check-name", check_name},
 	{"config", module_config},
diff --git a/git-submodule.sh b/git-submodule.sh
index 0df6b0fc974..1c1dc320922 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -552,7 +552,7 @@ cmd_sync()
 
 cmd_absorbgitdirs()
 {
-	git submodule--helper absorb-git-dirs --prefix "$wt_prefix" "$@"
+	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
 }
 
 # This loop parses the command line arguments to find the
diff --git a/submodule.c b/submodule.c
index 4e299f578f9..2af16c647d5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2374,7 +2374,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		cp.no_stdin = 1;
 		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
 			     "submodule--helper",
-			     "absorb-git-dirs", NULL);
+			     "absorbgitdirs", NULL);
 		prepare_submodule_repo_env(&cp.env);
 		if (run_command(&cp))
 			die(_("could not recurse into submodule '%s'"), path);
-- 
2.36.1.1239.gfba91521d90

