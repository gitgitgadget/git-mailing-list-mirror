Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C1C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 22:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiD0WaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiD0WaL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 18:30:11 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C350444
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:26:57 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s131so3557327oie.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVcefWAA4osKGPZ1S3H0nveqjHHfT+M5JieEPkOyO78=;
        b=GFEBigBTn4BE54CD7d4EwYtP0i1YYq/+qzrmRP8H58QTcaUZAiZkphjgO5Sfnj+A4d
         O2kk4WapEhhjgXpezs8R3DzQ4oOooPtJhGahzSXvjGxMP5ZoZfNdn/MMm/Tn/Z1pwZTD
         sDJ79G0T+fxkS6zGFrNr8pBFTo2NcEPe40cYrDNdSChoUQt3r9rHgybBJgMAuWr+Vdsn
         Ujih8lgg1tbpqNhF3c4Gv3iEw3exOkL2RTJC8cHNPCuWM0n8kNvzdnKDp9gBJR6I+Xp/
         pZcKttrju51mTDsPb8O9BElAi17DNTirFZqQd0zhoBJ0SGvE+PKagaESpNV0QRbq6fbx
         3NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVcefWAA4osKGPZ1S3H0nveqjHHfT+M5JieEPkOyO78=;
        b=CE1K+rivXOqjF9y992T5G3WRkJL2l2TCTqOkzEq3aIuBY+7qUEN2JPkWpLz2TkzkL0
         ZmvP3fH4Xv7tl3yqyJZACz9BFx+G5r2yEty1Cfq8Sy3roHl8SywPkhpQjtCeCPOe1irB
         lW035L4yAmRb5dXT4BqoyIfjwpQm2mQTUafeFcGWQBBi3ByTaMNAe3FWJ7/uisr+opEB
         MRpx57YbJ5hAbGQyAD2gKCVdTkKaQnJ5cBmzpDaJjhFh++eqLVSjdTYDh3lMiNtroAiI
         hjC0FYH9cbJUAT1PALyG23TvKMXRYFdiaBuvyv3gVLlegcj46WdrSG0kM1/ofxBS65Ei
         ROMQ==
X-Gm-Message-State: AOAM531OVLLFpN3UeSqrhp8b9usW6uT8N9aLO7h7C5ZF3q4ETmJkO/0n
        h3neBcMbHF+TZUJ1ttBgKP7gzmsD/UzwTw==
X-Google-Smtp-Source: ABdhPJygrpmoOFzU95O5nc1OKg2iZkpcrfesCNefcsvHntro3tIratkcnpGeJiakwBjo5QQ38FCFLA==
X-Received: by 2002:aca:d9c3:0:b0:2fa:6f51:7bfe with SMTP id q186-20020acad9c3000000b002fa6f517bfemr14191846oig.59.1651098416817;
        Wed, 27 Apr 2022 15:26:56 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r7-20020a056870878700b000e686d1386csm1212914oam.6.2022.04.27.15.26.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2022 15:26:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, Johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        rsbecker@nexbridge.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [RFC PATCH v2] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Wed, 27 Apr 2022 15:26:49 -0700
Message-Id: <20220427222649.63516-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220427000522.15637-1-carenas@gmail.com>
References: <20220427000522.15637-1-carenas@gmail.com>
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
therefore failing the following common call:

  guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
  [sudo] password for guy:
  fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)

Attempt to detect those cases by using the environment variables that
those tools create to keep track of the original user id, and do the
ownership check using that instead.

This assumes the environment the user is running with after going
privileged can't be tampered with, and also does the check only for
root to keep the most common case less complicated, but as a side effect
will miss cases where sudo (or an equivalent) was used to change to
another unprivileged user or where the equivalent tool used to raise
privileges didn't track the original id in a sudo compatible way.

Reported-by: Guy Maurel <guy.j@maurel.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Randall Becker <rsbecker@nexbridge.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since v1
* The helper function was completely rewritten to include all feedback,
  specially in areas that were too confusing and that include:
  - removing the return type that was only useful when doas was also supported
    and that is therefore no longer needed since v1.
  - using strtoul instead of strtol and assumed uid_t is unsigned.  This is
    a likely more popular configuration and allows up to 2^32 uids in 32bit
    systems.
  - using errno to check for errors in strtoul, this also includes saving and
    restoring the previous errno even if that is not yet needed.
  - avoiding truncation issues in systems where sizeof(long) > sizeof(uid_t)
    by discarding any values that wouldn't fit in an uid_t.  sudo uses
    unsigned int to represent the uids so no valid id should be affected.
    This assumes an unsigned uid_t which is not guaranteed by the standard
    and therefore might need adjusting later if some platform we support does
    not provide that (it is expected to trigger a warning at build time)
  - renaming variables that had confusing names
* Improved comments and commit message, and spell checked twice.

Sent as an RFC to make sure it fits everyone expectations and since it doesn't
fully implement all suggestions that were proposed about the same time it was
ready.

 git-compat-util.h | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..3c9883934f6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -437,12 +437,50 @@ static inline int git_offset_1st_component(const char *path)
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
-- 
2.36.0.266.g59f845bde02

