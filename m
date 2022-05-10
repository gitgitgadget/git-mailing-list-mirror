Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845D6C433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 17:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348405AbiEJRuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348386AbiEJRud (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 13:50:33 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6712E58E61
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:34 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 185so4284819qke.7
        for <git@vger.kernel.org>; Tue, 10 May 2022 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQ+Zw/Rsfd09yVX5FsQ4w2Y+Uv0WtuP/cJZg0jXBKp8=;
        b=d4C8LiXcU1OVwgNWmTmyyeNhsDlfQe8A3zkjVL1o8lUVzJotlT2DutHGRXcsV/r1tn
         f3hgp4jw3AIaH8yxaE2RsKT3v8lndCM7/UMrklHkgHG5liS0MohBoDtY0jOni35pL4PX
         IKGip64o35lDPTaLkBGCyyDr4NTPiV8RtTdoDChxJobX99j1SX6bEAdg724e5YR62kHA
         x5LZBiGP+WqTdm6i1LrnbB2ROOmYFZtxSMFI+AixmbhPR/y+0eZd9ThHOWtRjotl8E2I
         1AKFImGWd/3Si8+FVGnd96c58EYNyPqoNCX2r3xiIglITlKH5cbSMkrw176bQ2BJmobN
         idZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQ+Zw/Rsfd09yVX5FsQ4w2Y+Uv0WtuP/cJZg0jXBKp8=;
        b=HKxayboJmCnX39xEy6k/ilDQF/SCK798XwZCzPdU1sOOzzPYCqmw4NFKLFD+mxbXWx
         228eLLYxRRFEwYsSmQrG+e0l29DSBQCWjapHXmlLgsvyrFoQBmCyKF5QKSnoSo+7wL/T
         00AKm+JnGYPARB0h0fn+CAIzQQsmwsKuQ4n0bKOMMvuL41ye+eawAWjK3IQCgMphLM1m
         2uQOq026OQizc4+h+5NKIkx4XSVh0bwcRh9W8/+a6NhzGPksH+EuBZkjfBHR4cp9Ukhb
         pmBncci70b0l+YIS0auy5CZx6XbrFZV6+1WsJ832SfamnYrUdraFKV5Et1IZKfc0qhIg
         +YYA==
X-Gm-Message-State: AOAM533LtupUdh9M+om4Td8RuTo7aP+JF/VRt/hOPfhGuJGAtvbZzmvj
        fPaJYhThvaTgMZg+PtVioEOfI6bOyGg=
X-Google-Smtp-Source: ABdhPJx5oUe6JgP1zrn6JeVfjyBSzCsmfu+d4P23fOViIAv0OKw/EWHTYuvg5NM4TCuxhFQy/aQWiw==
X-Received: by 2002:a05:620a:2402:b0:69f:ff32:bd37 with SMTP id d2-20020a05620a240200b0069fff32bd37mr16166337qkn.657.1652204793231;
        Tue, 10 May 2022 10:46:33 -0700 (PDT)
Received: from localhost.localdomain (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id h191-20020a379ec8000000b0069fc347ef5dsm8719280qke.74.2022.05.10.10.46.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 10:46:32 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: [PATCH v4 2/3] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Tue, 10 May 2022 10:46:15 -0700
Message-Id: <20220510174616.18629-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220510174616.18629-1-carenas@gmail.com>
References: <20220507163508.78459-1-carenas@gmail.com>
 <20220510174616.18629-1-carenas@gmail.com>
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
unsigned integer type (which is not required by the standard) but is used
that way in their codebase to generate SUDO_UID.  In systems where uid_t
is signed, sudo might be also patched to NOT be unsigned and that might
be able to trigger an edge case and a bug (as described in the code), but
it is considered unlikely to be triggered, and even when it does the code
would just safely fail, so there is no attempt either to detect it or
prevent it in the code, which might need to be changed in the future.

Reported-by: Guy Maurel <guy.j@maurel.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Randall Becker <rsbecker@nexbridge.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/config/safe.txt  | 10 +++++++
 git-compat-util.h              | 54 +++++++++++++++++++++++++++++++++-
 t/t0034-root-safe-directory.sh |  2 +-
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0cc..dba9d5b2d1 100644
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
+it, and if that is the case, will use the uid of the user that invoked
+sudo instead.
+If that is not what you would prefer and want git to only trust
+repositories that are owned by root instead, then you should remove
+the `SUDO_UID` variable from root's environment.
diff --git a/git-compat-util.h b/git-compat-util.h
index 63ba89dd31..754cd90d43 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -393,12 +393,64 @@ static inline int git_offset_1st_component(const char *path)
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
+ * This helper function overrides a ROOT_UID with the one provided by
+ * an environment variable, do not use unless the original user is
+ * root or could be used as means to escalate to root privileges.
+ *
+ * PORTABILITY WARNING:
+ * This code assumes uid_t is unsigned because that is what sudo does.
+ * If your uid_t type is signed and all your ids are positive then it
+ * should all work fine, but need to make sure sudo never generates a
+ * value higher than what can be represented by your uid_t type or a
+ * negative value or it will trigger wraparound bugs.
+ *
+ * If that happens the uid used might be incorrect and then trigger
+ * an access error from the filesystem itself.
+ *
+ * In the unlikely scenario this happened to you, and that is how you
+ * got to this message, we would like to know about it by letting us
+ * now with an email to git@vger.kernel.org indicating which platform,
+ * you are running on and which version of sudo you used to see if we
+ * can provide you a patch that would prevent this issue in the future.
+ */
+static inline void extract_id_from_env(const char *env, uid_t *id)
+{
+	const char *real_uid = getenv(env);
+
+	/* discard anything empty to avoid a more complex check below */
+	if (real_uid && *real_uid) {
+		char *endptr = NULL;
+		unsigned long env_id;
+
+		errno = 0;
+		/* silent overflow errors could trigger a bug below */
+		env_id = strtoul(real_uid, &endptr, 10);
+		if (!*endptr && !errno)
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

