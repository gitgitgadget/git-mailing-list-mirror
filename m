Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DBCC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 16:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446676AbiEGQjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 12:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386298AbiEGQjM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 12:39:12 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967EC2EB
        for <git@vger.kernel.org>; Sat,  7 May 2022 09:35:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z126so8032500qkb.2
        for <git@vger.kernel.org>; Sat, 07 May 2022 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEgwfntUhhn3OvNVkTohT57c/yGf/9JNzyj2XubpfkE=;
        b=lzocTF+YhjdOMykcV+NbOmzW/cw+cFk7DmqXjTFtez+v8rCgq1JnrjaslRXkvJ5Ili
         7OrWlTnLo3bkXglCKi0ywn7AAePyH+yL9UKnQXhT0E2vlv9Vo+Z10Bube9PjE8bJocHq
         nFz4rk8ftJGPW22VuzqXDF+yWQloCKZU9TJcdtB/l9Pp1oitzB8YTg5+6TEHgI5+C5og
         yzADTL5cw12waXTBm5HSgZYonQD3xN2nxHNAbU1LyCUYI3GqSLYaTPXOCIkyOKXzIoAk
         PnsoSKzD4FfAn6avd6wUE3jVEdmhS+O36DkaxpG1j6PjFoY6JIfL56d/jegZ7woKyY8+
         fpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEgwfntUhhn3OvNVkTohT57c/yGf/9JNzyj2XubpfkE=;
        b=ZvvXdq2GaJ0IMRNQxMinvCRMZJ4Q+Eghsyp2QhLBi+FfNCfcZnskgt1nH9qPcPVtCG
         +JUTsidAm1YPsxsm2Jhtxr+fOYCnEAb1HGpalu0WMY/fbjHE+XBEAePKp9r1fycw4gW3
         CND5FwzIunXkx23nckmQASU+zI4hWXreX+XIS9k+7RcPQ1MbA7yXKfXvH68KrOPCuBuX
         sdIjkX2DELmMixlSvQiYb1wk8bGAiPJNNQoheNa0EsXq6x6SYekvkPVAMHCTOnKJXK98
         hy+oCbHAd5Gt+J4JRTJHa+t3+U9N4Q2N9uIggAodYEoARXEfKvKmayKFTN9gEJseRp1Q
         RuVg==
X-Gm-Message-State: AOAM5332ACilbaUBhFrXMMakjdmkdZI4BeXF6aEdVVIrsIIVPibyPWuI
        TP0OTYHbKVwukWoWZNb8Nq7EZTUUyjg=
X-Google-Smtp-Source: ABdhPJzAjLC+2ifMPgT9t56azYb779kHMZ8WxxlnrmBqNmxWJ6IQagIVXqYwD4h6aQ9fAT+W1/i8EQ==
X-Received: by 2002:a05:620a:25cc:b0:699:c303:83f5 with SMTP id y12-20020a05620a25cc00b00699c30383f5mr6552973qko.345.1651941320737;
        Sat, 07 May 2022 09:35:20 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id l15-20020ac848cf000000b002f39b99f6c3sm4244564qtr.93.2022.05.07.09.35.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 May 2022 09:35:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: [RFC PATCH v4 2/3] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Sat,  7 May 2022 09:35:07 -0700
Message-Id: <20220507163508.78459-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220507163508.78459-1-carenas@gmail.com>
References: <20220503065442.95699-1-carenas@gmail.com>
 <20220507163508.78459-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bdc77d1d685 (Add a function to determine whether a path is owned by the
current user, 2022-03-02) checks for the effective uid of the running
process using geteuid() but didn't account for cases where that user was
root (because git was invoked through sudo or a compatible tool) and the
original uid that repository trusted for its config was no longer known,
therefore failing the following otherwise safe call:

  guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
  [sudo] password for guy:
  fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)

Attempt to detect those cases by using the environment variables that
those tools create to keep track of the original user id, and do the
ownership check using that instead.

This assumes the environment the user is running on after going
privileged can't be tampered with, and also adds code to restrict that
the new behavior only applies if running as root, therefore keeping the
most common case, which runs unprivileged, from changing, but because of
that, it will miss cases where sudo (or an equivalent) was used to change
to another unprivileged user or where the equivalent tool used to raise
privileges didn't track the original id in a sudo compatible way.

Because of compatibility with sudo, the code assumes that uid_t is an
unsigned integer type, but adds additional logic to protect itself
against possibly malicious ids outside the expected range and ignore
them.

A warning should be generated if uid_t is signed and the code would
need to be locally patched to work correctly, but this is also a
weather balloon of sorts so we will then now which systems those are
and whether we should accommodate for their portability in our codebase.

Reported-by: Guy Maurel <guy.j@maurel.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Randall Becker <rsbecker@nexbridge.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/safe.txt  | 10 +++++++
 git-compat-util.h              | 49 +++++++++++++++++++++++++++++++++-
 t/t0034-root-safe-directory.sh |  2 +-
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0cc..a6b81f6cfc 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -26,3 +26,13 @@ directory was listed in the `safe.directory` list. If `safe.directory=*`
 is set in system config and you want to re-enable this protection, then
 initialize your list with an empty value before listing the repositories
 that you deem safe.
++
+When git tries to check for ownership of git repositories, it will
+obviously do so with the uid of the user that is running git itself,
+but if git is running as root, in a platform that provides sudo and is
+not Windows, it will check first if it might have been started through
+it, and if that is the case, will instead use the uid of the user that
+did invoke that instead.
+If that is not what you would prefer and want git to only trust
+repositories that are owned by root instead, then you should remove
+the `SUDO_UID` variable from root's environment.
diff --git a/git-compat-util.h b/git-compat-util.h
index 63ba89dd31..409df99463 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -393,12 +393,59 @@ static inline int git_offset_1st_component(const char *path)
 #endif
 
 #ifndef is_path_owned_by_current_user
+
+#ifdef __TANDEM
+#define ROOT_UID 65535
+#else
+#define ROOT_UID 0
+#endif
+
+/*
+ * this helper function overrides a ROOT_UID with the one provided by
+ * an environment variable, do not use unless the original user is
+ * root
+ * WARNING: this function assumes uid_t is unsigned, if you got here
+ *          because of a warning or a bug will need a patch and would
+ *          be nice if you let us know
+ */
+static inline void extract_id_from_env(const char *env, uid_t *id)
+{
+	const char *real_uid = getenv(env);
+
+	/* discard any empty values */
+	if (real_uid && *real_uid) {
+		char *endptr = NULL;
+		unsigned long env_id;
+
+		errno = 0;
+		env_id = strtoul(real_uid, &endptr, 10);
+		/*
+		 * env_id could underflow/overflow in the previous call
+		 * and if it will still fit in a long it will not report
+		 * it as error with ERANGE, instead silently using an
+		 * equivalent positive number that might be bogus.
+		 * if uid_t is narrower than long, it might not fit,
+		 * hence why we  need to check it against the maximum
+		 * possible uid_t value before accepting it.
+		 */
+		if (!*endptr && !errno && env_id <= (uid_t)-1)
+			*id = env_id;
+	}
+}
+
 static inline int is_path_owned_by_current_uid(const char *path)
 {
 	struct stat st;
+	uid_t euid;
+
 	if (lstat(path, &st))
 		return 0;
-	return st.st_uid == geteuid();
+
+	euid = geteuid();
+	if (euid == ROOT_UID)
+		extract_id_from_env("SUDO_UID", &euid);
+
+	return st.st_uid == euid;
 }
 
 #define is_path_owned_by_current_user is_path_owned_by_current_uid
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index 2e4492a66d..ecd9dca6b3 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -29,7 +29,7 @@ test_expect_success SUDO 'setup' '
 	)
 '
 
-test_expect_failure SUDO 'sudo git status as original owner' '
+test_expect_success SUDO 'sudo git status as original owner' '
 	(
 		cd root/r &&
 		git status &&
-- 
2.36.1.371.g0fb0ef0c8d

