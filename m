Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9436BC43217
	for <git@archiver.kernel.org>; Fri, 13 May 2022 01:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359834AbiEMBAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 21:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359827AbiEMBAj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 21:00:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6068C28B877
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:37 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id dv4so5636431qvb.13
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyolCt5vrNxZZwHvL6LyGqRrlNXwbUmjD3hLew2/fZY=;
        b=Fkr2mih/hmqbfiQoFJbYPR/alYSiDhqxKX/ZJRuhXMXrnDO+9MXsYOi7BfGyOiqxkF
         9R7TV87/lrDYzLR3Et+rZBww4alyoSEnwwJOax/01J/ptZM2K7W+RNiEAxQAm/BxTY75
         4VVQqJJnMyzN4cazOxIQCDptFjbs0TPRWs2nhi2pbdU3GTg8FnK96xNECZ392Ndc4LzK
         +t6CY6oH1Po7Q6Y76FRQrkTWho5Kn6EzuD//6akDf7a0a4QrabwLYd4t3qLwz+/ry3nN
         f5ytrUeRdvFMLgPpLL40R3I5OJRI51gekU4LC14iSVcqfqbO19sAOS3QvJdqHOXwRAHX
         vwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyolCt5vrNxZZwHvL6LyGqRrlNXwbUmjD3hLew2/fZY=;
        b=7mxl0hmvq2ws5ADOcTNnf0GLXQuz53lWvN56nBHnN2vgVW1Kru4SJVBAjsFrtat0JK
         y4WcClYZFy58e6kHYAi4KUnT4wMM94L+zey6sZD/54CLum1wiIY+5TSvXxWl5kA3oD2y
         pc9R+x5xvymHwSFbusmMI3ExE10aQt6JBCiG7hq0su6z2EjWwS21+QhvcF6fwMX2/BFi
         mL8is+YX93myjxbhP/X5++AfIJhGNxvkHSpX46Lspx6KYH5KVkOd7iVooeIgH8eQv4NJ
         j4FtXadgAnTetB/qkKUIwu/qd3zY2eIpIM8+nSQQfDVkx6jfQ2hrije2Z1pjFxuc3p4R
         hh2A==
X-Gm-Message-State: AOAM531fbohky/mRWYXjq07p/w7atxLhq6Xd8keiDIGo4I/E5eP1f8tt
        nN3v0qhe9+WMRtmlkDxCAA+S/lUrUEk=
X-Google-Smtp-Source: ABdhPJwzf+Qc88uVI4E83OdQSq1PomlqF1FBhml0rk80aqeTs6PdMSysR5rwLaichb4j0uglMr2HNA==
X-Received: by 2002:a05:6214:d8c:b0:45a:de69:79e7 with SMTP id e12-20020a0562140d8c00b0045ade6979e7mr2333871qve.15.1652403635661;
        Thu, 12 May 2022 18:00:35 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s202-20020a3745d3000000b0069fc13ce227sm583541qka.88.2022.05.12.18.00.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 18:00:34 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 2/4] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Thu, 12 May 2022 18:00:18 -0700
Message-Id: <20220513010020.55361-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220513010020.55361-1-carenas@gmail.com>
References: <20220510174616.18629-1-carenas@gmail.com>
 <20220513010020.55361-1-carenas@gmail.com>
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
it is considered unlikely to happen and even if it does, the code would
just mostly fail safely, so there was no attempt either to detect it or
prevent it by the code, which is something that might change in the future,
based on expected user feedback.

Reported-by: Guy Maurel <guy.j@maurel.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Randall Becker <rsbecker@nexbridge.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/safe.txt  | 13 +++++++++
 git-compat-util.h              | 53 +++++++++++++++++++++++++++++++++-
 t/t0034-root-safe-directory.sh |  2 +-
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0ccf..c6ebd1674dd 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -26,3 +26,16 @@ directory was listed in the `safe.directory` list. If `safe.directory=*`
 is set in system config and you want to re-enable this protection, then
 initialize your list with an empty value before listing the repositories
 that you deem safe.
++
+As explained, Git only allows you to access repositories owned by
+yourself, i.e. the user who is running Git, by default.  When Git
+is running as 'root' in a non Windows platform that provides sudo,
+ however, git checks the SUDO_UID environment variable that sudo creates
+and will allow access to the uid recorded as its value instead.
+This is to make it easy to perform a common sequence during installation
+"make && sudo make install".  A git process running under 'sudo' runs as
+'root' but the 'sudo' command exports the environment variable to record
+which id the original user has.
+If that is not what you would prefer and want git to only trust
+repositories that are owned by root instead, then you must remove
+the `SUDO_UID` variable from root's environment before invoking git.
diff --git a/git-compat-util.h b/git-compat-util.h
index 63ba89dd31d..e7cbfa65c9a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -393,12 +393,63 @@ static inline int git_offset_1st_component(const char *path)
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
+ * Do not use this function when
+ * (1) geteuid() did not say we are running as 'root', or
+ * (2) using this function will compromise the system.
+ *
+ * PORTABILITY WARNING:
+ * This code assumes uid_t is unsigned because that is what sudo does.
+ * If your uid_t type is signed and all your ids are positive then it
+ * should all work fine.
+ * If your version of sudo uses negative values for uid_t or it is
+ * buggy and return an overflowed value in SUDO_UID, then git might
+ * fail to grant access to your repository properly or even mistakenly
+ * grant access to someone else.
+ * In the unlikely scenario this happened to you, and that is how you
+ * got to this message, we would like to know about it; so sent us an
+ * email to git@vger.kernel.org indicating which platform you are
+ * using and which version of sudo, so we can improve this logic and
+ * maybe provide you with a patch that would prevent this issue again
+ * in the future.
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
+		/* silent overflow errors could trigger a bug here */
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
index f6a5d63ff41..6b8ea5357f6 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -28,7 +28,7 @@ test_expect_success SUDO 'setup' '
 	)
 '
 
-test_expect_failure SUDO 'sudo git status as original owner' '
+test_expect_success SUDO 'sudo git status as original owner' '
 	(
 		cd root/r &&
 		git status &&
-- 
2.36.1.371.g0fb0ef0c8d

