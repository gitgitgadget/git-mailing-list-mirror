Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F24C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiKGSZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiKGSZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:25:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E97DD5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:25:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g12so17477050wrs.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DRV7S09oxHyjlWW9LTu6BBRTV9vgbYB5M+gy59NejnU=;
        b=liKMvGed6dfLOz+aMHQQyJlqeit5V91wPNkRdn9Yp+NBnO0PqEtrkpTQexmKMURBve
         HA59MfJJHTt11hQoqZPa0aEKnUYRy5jPxRVVb7tzqIyID+VPgCNSKRNDuDMMgZYtAfPm
         9AQDr8HGvwrB82ZEXAniqQqOzR/uf1BmM+IcmmO4DJ5MGYSRCr5H8sG/dxGpkZmeJXA2
         B8h+ciZ+RzZdzI/K3snjAggzVm/bVV6vNZsVEaFOrvnbfgJZw/uCTMtSLGfXgHZ/QtMT
         Yn5IIGjGlF7aCUJGQ/Z30Q2T82ZeIAQM5hT9KfPCO0Di2n3PKrDTu0zQ3DhwOstfrvPy
         yB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRV7S09oxHyjlWW9LTu6BBRTV9vgbYB5M+gy59NejnU=;
        b=QVtrky8qVJ4/hXRCGmrtoinmV09SDqJbvh9RzDy4lyYaP2MOskePSybRJ6Sr1pFHZM
         474/Lh3rxa4Ea0Bm65+MYZ/H4mepDJvg7bwiChRmOFi4Zqr2c3hmFdG8fF+RuQRRfT/B
         BkXMPvOsx9zQi+PXh1tnwjWDp7bOb9F4wXAopIK2bxt1tKsfuvGWrJU1uWvBDiuLaXHE
         aY1XKocRFob1klmkhhhWPRgq/lmO2e4OWhwyFl1sHzgDMF1fZxpmQ7Gl/7Tvi64XHCQK
         j39jaCYfM8MFVrcG/BD/HDj9VTomasjzmU/bcfA6mrO/WeJBRfJ9Qk/ASSZYX4FUx0DH
         QmxQ==
X-Gm-Message-State: ACrzQf0752PD2EGSxzPdkuYU8diP4q3vu5ZL0WTlbx/swAvouYr6Lu8p
        l6KnAHdosLF6GiwIHs7p9y3lvqyFEsk=
X-Google-Smtp-Source: AMsMyM4g3FiNr4sLgMVCn3j+PgH6QM1c+g5/QhmK3zG7arPqmzXekmTSLXn2YnBfiVCym8DTSqFzFw==
X-Received: by 2002:adf:f883:0:b0:236:a6a3:d6ac with SMTP id u3-20020adff883000000b00236a6a3d6acmr33409154wrp.538.1667845502838;
        Mon, 07 Nov 2022 10:25:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az2-20020adfe182000000b00226dba960b4sm8309505wrb.3.2022.11.07.10.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:25:02 -0800 (PST)
Message-Id: <pull.1407.git.1667845501422.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:25:01 +0000
Subject: [PATCH] scalar reconfigure -a: remove stale `scalar.repo` entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Every once in a while, a Git for Windows installation fails because the
attempt to reconfigure a Scalar enlistment failed because it was deleted
manually without removing the corresponding entries in the global Git
config.

In f5f0842d0b5 (scalar: let 'unregister' handle a deleted enlistment
directory gracefully, 2021-12-03), we already taught `scalar delete` to
handle the case of a manually deleted enlistment gracefully. This patch
adds the same graceful handling to `scalar reconfigure --all`.

This patch is best viewed with `--color-moved`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    scalar reconfigure -a: remove stale scalar.repo entries
    
    This has been on my TODO list for, like, forever.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1407%2Fdscho%2Fscalar-reconfigure-a-and-stale-config-entries-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1407/dscho/scalar-reconfigure-a-and-stale-config-entries-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1407

 scalar.c          | 54 +++++++++++++++++++++++++++++------------------
 t/t9210-scalar.sh | 11 ++++++++++
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/scalar.c b/scalar.c
index 6de9c0ee523..7f4bdb6c153 100644
--- a/scalar.c
+++ b/scalar.c
@@ -599,6 +599,24 @@ static int get_scalar_repos(const char *key, const char *value, void *data)
 	return 0;
 }
 
+static int remove_deleted_enlistment(struct strbuf *path)
+{
+	int res = 0;
+	strbuf_realpath_forgiving(path, path->buf, 1);
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "scalar.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	if (run_git("config", "--global",
+		    "--unset", "--fixed-value",
+		    "maintenance.repo", path->buf, NULL) < 0)
+		res = -1;
+
+	return res;
+}
+
 static int cmd_reconfigure(int argc, const char **argv)
 {
 	int all = 0;
@@ -638,8 +656,22 @@ static int cmd_reconfigure(int argc, const char **argv)
 		strbuf_reset(&gitdir);
 
 		if (chdir(dir) < 0) {
-			warning_errno(_("could not switch to '%s'"), dir);
-			res = -1;
+			struct strbuf buf = STRBUF_INIT;
+
+			if (errno != ENOENT) {
+				warning_errno(_("could not switch to '%s'"), dir);
+				res = -1;
+				continue;
+			}
+
+			strbuf_addstr(&buf, dir);
+			if (remove_deleted_enlistment(&buf))
+				res = error(_("could not remove stale "
+					      "scalar.repo '%s'"), dir);
+			else
+				warning(_("removing stale scalar.repo '%s'"),
+					dir);
+			strbuf_release(&buf);
 		} else if (discover_git_directory(&commondir, &gitdir) < 0) {
 			warning_errno(_("git repository gone in '%s'"), dir);
 			res = -1;
@@ -725,24 +757,6 @@ static int cmd_run(int argc, const char **argv)
 	return 0;
 }
 
-static int remove_deleted_enlistment(struct strbuf *path)
-{
-	int res = 0;
-	strbuf_realpath_forgiving(path, path->buf, 1);
-
-	if (run_git("config", "--global",
-		    "--unset", "--fixed-value",
-		    "scalar.repo", path->buf, NULL) < 0)
-		res = -1;
-
-	if (run_git("config", "--global",
-		    "--unset", "--fixed-value",
-		    "maintenance.repo", path->buf, NULL) < 0)
-		res = -1;
-
-	return res;
-}
-
 static int cmd_unregister(int argc, const char **argv)
 {
 	struct option options[] = {
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index be51a8bb7a4..c7f8a379108 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -166,6 +166,17 @@ test_expect_success 'scalar reconfigure' '
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
+test_expect_success '`reconfigure -a` removes stale config entries' '
+	git init stale/src &&
+	scalar register stale &&
+	scalar list >scalar.repos &&
+	grep stale scalar.repos &&
+	rm -rf stale &&
+	scalar reconfigure -a &&
+	scalar list >scalar.repos &&
+	! grep stale scalar.repos
+'
+
 test_expect_success 'scalar delete without enlistment shows a usage' '
 	test_expect_code 129 scalar delete
 '

base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
-- 
gitgitgadget
