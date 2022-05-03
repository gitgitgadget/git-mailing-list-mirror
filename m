Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED61C433FE
	for <git@archiver.kernel.org>; Tue,  3 May 2022 06:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiECG7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiECG6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 02:58:30 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10F1A05B
        for <git@vger.kernel.org>; Mon,  2 May 2022 23:54:57 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w3so5173115qkb.3
        for <git@vger.kernel.org>; Mon, 02 May 2022 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TdkODzDz7C3MT33wHM+co2RvRfx2H18qd5gbcXTvPYY=;
        b=je/ZlcMvHjnSxetT9dzEbXRc7mDwz43iS9DxWOI+sQPl83yvzM4Im7mnaSi51QyXvK
         WpK2Gx3aLA9d/rYsVJ54uYgiQfpSaj5y4fvjNS0L8UDLdwmWPiIcsHAkIJGz/b9L5Rrp
         Ld612WC9lN2hlZcHtKqUic+pd/khEz5w1BxzAVBlSRo0H9uusoRsJ8ScJGpLl7qKy/kG
         ldPjGLx34Wr7B8EQm4dncplXrIkw5ben+kMzctEDYRCJC0GXrR5VdzmP1u51F4sQY3+x
         gpQj5jhYzmpNGXonlXGcljzDRhFd69Y11d6Voq3kxp/6oOPnYVB5qQCH+sCmJwsv5zw5
         Y8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TdkODzDz7C3MT33wHM+co2RvRfx2H18qd5gbcXTvPYY=;
        b=Rqd8krmQ0y2dX8ySyr3rNZLtDr50fUjTq2FtG6yPfH6tkQf3/yDoDJeYdgAfZwaIsq
         mabjIQo7rkSdgY+9A9FSgRjHor/A8RRU4LnAyYr4PF+vq1kf7GzP55HKU9nvIMWt5Cqw
         goyDlX+VxvRDb+EZVZNJXYXdS1vMINapdbdzMIFdzKyuom5+A9HgDgXLNysoGvZ6lqkj
         0nXbltIDoXXiL10LZFgoPgAxGAl7vbHk71myQsit9QinkxWIZ9s9fxspAdYdZn+vSDkg
         Dkc39swDfW4/icE4m3lHEaPMjOYmDS71p6YH8hp9H92MEdtbuCqY91/DURikCBU7b6gF
         QMPQ==
X-Gm-Message-State: AOAM531tMD0KB478NWeejp6pbQAuO/oBy/M/kiJD28tNlHaXdPTrKVPU
        Nc6LrDJw43S7RpacCT/4AfEUHyw5UNI=
X-Google-Smtp-Source: ABdhPJzOhlC1+c0LXIAodMZ8ywAnCxUImMexNjFlmCkUy0s58w/Myp7WpGLmUPAVqfWYqeXrcFEkTw==
X-Received: by 2002:a37:bcc6:0:b0:69c:2930:85ce with SMTP id m189-20020a37bcc6000000b0069c293085cemr11096458qkf.188.1651560896418;
        Mon, 02 May 2022 23:54:56 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id t1-20020ac85301000000b002f39b99f68bsm5333369qtn.37.2022.05.02.23.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 23:54:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com, phillip.wood123@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Mon,  2 May 2022 23:54:41 -0700
Message-Id: <20220503065442.95699-3-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220503065442.95699-1-carenas@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
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

Reported-by: Guy Maurel <guy.j@maurel.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Randall Becker <rsbecker@nexbridge.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/config/safe.txt  |  9 ++++++++
 git-compat-util.h              | 40 +++++++++++++++++++++++++++++++++-
 t/t0034-root-safe-directory.sh |  2 +-
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0ccf..ee558ced8c7 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -26,3 +26,12 @@ directory was listed in the `safe.directory` list. If `safe.directory=*`
 is set in system config and you want to re-enable this protection, then
 initialize your list with an empty value before listing the repositories
 that you deem safe.
++
+When git tries to check for ownership of git repositories, it will
+obviously do so with the uid of the user that is running git itself,
+but if git is running as root, it will check first if it might have
+been started through `sudo`, and if that is the case, will instead
+use the uid of the user that did so.
+If that is not what you would prefer and want git to only trust
+repositories that are owned by root instead, then you should remove
+the `SUDO_UID` variable from root's environment.
diff --git a/git-compat-util.h b/git-compat-util.h
index 63ba89dd31d..dfdd3e4f81a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -393,12 +393,50 @@ static inline int git_offset_1st_component(const char *path)
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
+ */
+static inline void extract_id_from_env(const char *env, uid_t *id)
+{
+	const char *real_uid = getenv(env);
+
+	/* discard any empty values */
+	if (real_uid && *real_uid) {
+		char *endptr;
+		unsigned long env_id;
+		int saved_errno = errno;
+
+		errno = 0;
+		env_id = strtoul(real_uid, &endptr, 10);
+		if (!errno && !*endptr && env_id <= (uid_t)-1)
+			*id = env_id;
+
+		errno = saved_errno;
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
index 6dac7a05cfd..dd659aed4e1 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -32,7 +32,7 @@ test_expect_success SUDO 'setup' '
 	)
 '
 
-test_expect_failure SUDO 'sudo git status as original owner' '
+test_expect_success SUDO 'sudo git status as original owner' '
 	(
 		cd root/r &&
 		git status &&
-- 
2.36.0.352.g0cd7feaf86f

