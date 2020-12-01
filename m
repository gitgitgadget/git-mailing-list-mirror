Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17046C64E90
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A610120644
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgLAXpy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgLAXpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:45:54 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D4C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:45:13 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id i199so3179279qke.5
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtUcb0GPBJKhuGPx0l+fJ0+6ba5EVD9RTPJ9uurrEI0=;
        b=NHniPYFSk8s8XVqKG043vgcIYq8CURgLEWYUPeDk/TIuZ4SPujilh63qNuRJR60Og4
         acstQVh2HOLAUUv/MTiEppQtzXAs8hvKO7DUYozT5lQEV3iU4LtZ6+S3vxkLo/n2nIAM
         OObeoXd0CtormistF8ugnLanhrYWBE2VX6SMcOyStQJIJmLocteabISArxsyeYPPL0zK
         XR0OOH62oCAUv05wbXc/PSe3QynPnWkXY4rloMO1rBgpol0VOfYhbUaeD5cuXP/A38Vd
         DrsBLvfJL1GQZY9KwRNAD/MveBp2+EHatcq/10dqb3xH1n/5dyLnsQ2ytjlOsx8Dt6Uj
         9qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtUcb0GPBJKhuGPx0l+fJ0+6ba5EVD9RTPJ9uurrEI0=;
        b=geKVoJvX8RMWU7uK2GKS1o79dVhZDXX7utIjbqfzJjvS4wME15ytrOG9ths0MBKRBa
         jwduNB9Nx/HLxxEOTslFGVXj+UalYLy1pMHmNdDPHovq2WMwVIhUgAfBptZhqhXgbPdi
         qH0gxEwY6HDoBL5U5G7hgg+fed/a467oVvIZgku+IXN3Zp4zQ7HVPQyvIbQzf+F5OlpA
         ZapbaU7Imv28pMLP34ekvJOZpFuOQNQmCsAgM+Smg9qL7QhkCFXaUrfLE2laXKKe9ZTM
         5rbqd3WcwiTtg9oims1MICoq2NpGZrYzjYMgdpNzh32wUO1loVCf+HFnZGqAAy0tR8zE
         pyyg==
X-Gm-Message-State: AOAM532j/PO9z6I2V0xuUT3/bFJoZcISlbMTXzWnWmhXsiYjjrT8+FaN
        3WkLSGmaPLJ/Yf0p2Ew09oFCqA2OifxSyw==
X-Google-Smtp-Source: ABdhPJwDDtoF6jiH9RweTFxgwVO9kT5X01JnMERvrVQTHzonM4LSR7phZNDIqZxS8hbN8SV9cbKYTw==
X-Received: by 2002:a37:a4c3:: with SMTP id n186mr5682064qke.495.1606866311610;
        Tue, 01 Dec 2020 15:45:11 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id 200sm17294qkl.60.2020.12.01.15.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 15:45:10 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] apply: don't use core.sharedRepository to create working tree files
Date:   Tue,  1 Dec 2020 20:45:04 -0300
Message-Id: <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <xmqqpn3tqugm.fsf@gitster.c.googlers.com>
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

core.sharedRepository defines which permissions Git should set when
creating files in $GIT_DIR, so that the repository may be shared with
other users. But (in its current form) the setting shouldn't affect how
files are created in the working tree. This is not respected by apply
and am (which uses apply), when creating leading directories:

$ cat d.patch
 diff --git a/d/f b/d/f
 new file mode 100644
 index 0000000..e69de29

Apply without the setting:
$ umask 0077
$ git apply d.patch
$ ls -ld d
 drwx------

Apply with the setting:
$ umask 0077
$ git -c core.sharedRepository=0770 apply d.patch
$ ls -ld d
 drwxrws---

Only the leading directories are affected. That's because they are
created with safe_create_leading_directories(), which calls
adjust_shared_perm() to set the directories' permissions based on
core.sharedRepository. To fix that, let's introduce a variant of this
function that ignores the setting, and use it in apply. Also add a
regression test and a note in the function documentation about the use
of each variant according to the destination (working tree or git
dir).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 apply.c                   |  2 +-
 cache.h                   |  7 ++++++-
 sha1-file.c               | 14 ++++++++++++--
 t/t4129-apply-samemode.sh | 26 ++++++++++++++++++++++++++
 t/test-lib-functions.sh   |  4 ++--
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 359ceb632c..4a4e9a0158 100644
--- a/apply.c
+++ b/apply.c
@@ -4409,7 +4409,7 @@ static int create_one_file(struct apply_state *state,
 		return 0;
 
 	if (errno == ENOENT) {
-		if (safe_create_leading_directories(path))
+		if (safe_create_leading_directories_no_share(path))
 			return 0;
 		res = try_create_file(state, path, mode, buf, size);
 		if (res < 0)
diff --git a/cache.h b/cache.h
index e986cf4ea9..8d279bc110 100644
--- a/cache.h
+++ b/cache.h
@@ -1255,7 +1255,11 @@ int adjust_shared_perm(const char *path);
  * safe_create_leading_directories() temporarily changes path while it
  * is working but restores it before returning.
  * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily.
+ * temporarily. Both these variants adjust the permissions of the
+ * created directories to honor core.sharedRepository, so they are best
+ * suited for files inside the git dir. For working tree files, use
+ * safe_create_leading_directories_no_share() instead, as it ignores
+ * the core.sharedRepository setting.
  */
 enum scld_error {
 	SCLD_OK = 0,
@@ -1266,6 +1270,7 @@ enum scld_error {
 };
 enum scld_error safe_create_leading_directories(char *path);
 enum scld_error safe_create_leading_directories_const(const char *path);
+enum scld_error safe_create_leading_directories_no_share(char *path);
 
 /*
  * Callback function for raceproof_create_file(). This function is
diff --git a/sha1-file.c b/sha1-file.c
index dd65bd5c68..c3c49d2fa5 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -291,7 +291,7 @@ int mkdir_in_gitdir(const char *path)
 	return adjust_shared_perm(path);
 }
 
-enum scld_error safe_create_leading_directories(char *path)
+static enum scld_error safe_create_leading_directories_1(char *path, int share)
 {
 	char *next_component = path + offset_1st_component(path);
 	enum scld_error ret = SCLD_OK;
@@ -337,7 +337,7 @@ enum scld_error safe_create_leading_directories(char *path)
 				ret = SCLD_VANISHED;
 			else
 				ret = SCLD_FAILED;
-		} else if (adjust_shared_perm(path)) {
+		} else if (share && adjust_shared_perm(path)) {
 			ret = SCLD_PERMS;
 		}
 		*slash = slash_character;
@@ -345,6 +345,16 @@ enum scld_error safe_create_leading_directories(char *path)
 	return ret;
 }
 
+enum scld_error safe_create_leading_directories(char *path)
+{
+	return safe_create_leading_directories_1(path, 1);
+}
+
+enum scld_error safe_create_leading_directories_no_share(char *path)
+{
+	return safe_create_leading_directories_1(path, 0);
+}
+
 enum scld_error safe_create_leading_directories_const(const char *path)
 {
 	int save_errno;
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 5cdd76dfa7..41818d8315 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -73,4 +73,30 @@ test_expect_success FILEMODE 'bogus mode is rejected' '
 	test_i18ngrep "invalid mode" err
 '
 
+test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree files' '
+	git reset --hard &&
+	test_config core.sharedRepository 0666 &&
+	(
+		# Remove a default ACL if possible.
+		(setfacl -k newdir 2>/dev/null || true) &&
+		umask 0077 &&
+
+		# Test both files (f1) and leading dirs (d)
+		mkdir d &&
+		touch f1 d/f2 &&
+		git add f1 d/f2 &&
+		git diff --staged >patch-f1-and-f2.txt &&
+
+		rm -rf d f1 &&
+		git apply patch-f1-and-f2.txt &&
+
+		echo "-rw-------" >f1_mode.expected &&
+		echo "drwx------" >d_mode.expected &&
+		test_modebits f1 >f1_mode.actual &&
+		test_modebits d >d_mode.actual &&
+		test_cmp f1_mode.expected f1_mode.actual &&
+		test_cmp d_mode.expected d_mode.actual
+	)
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 7ba3011b90..0f7f247159 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -367,9 +367,9 @@ test_chmod () {
 	git update-index --add "--chmod=$@"
 }
 
-# Get the modebits from a file.
+# Get the modebits from a file or directory.
 test_modebits () {
-	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
+	ls -ld "$1" | sed -e 's|^\(..........\).*|\1|'
 }
 
 # Unset a configuration variable, but don't fail if it doesn't exist.
-- 
2.29.2

