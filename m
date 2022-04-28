Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A6C433FE
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 10:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbiD1LDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345168AbiD1LCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 07:02:52 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E3A204C
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:04 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id jt15so2911991qvb.13
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Def9yQQ3IUenybB9/BxRC5wGHNUgLmmvEzUPm2mVd1o=;
        b=VyKEXfxw/5NGjnIdfzIK2kePWZ4AoSAUBkuYUG7x5zfsqzMjrjozpV76yDztx2GyHZ
         4UaBIFwa/JavY6zzdX7JGZLMR3Qw8FBnKnTGRs4ny3SNbhV/Bpf2d6bBf8Xcd1aiszl8
         L3iV+KCzdwJOVdM0ViUqr2P4Me32oEu/XXuDb+RWDH8Lvct+KFF/I3iLJn4i0eG3ZDJq
         KoZ09nShN10tvO3lxf+PuZ8Bcz1pWe1O4xjns2oAYni2CK2JApatCk7ZgQgfpVuVfB6j
         nMRi0psUW91+TAUlsKL5D4Ywx+ctaX4flB4o0NEyZA8q0R4FuH5BJ+t3Mlw6/VgLzUx7
         OVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Def9yQQ3IUenybB9/BxRC5wGHNUgLmmvEzUPm2mVd1o=;
        b=wYtXPPeNmp6o/FH8IctEClqILDJTDU1Oe5Oc4BUYekY/+4urNJMSrHavUoLvT/rNs8
         /9Imp29HZ5dEnSyhBYngswSfIXY+YdkzQABby73s33HeeB2ReV1FIsLUA+afAYjt7Y+I
         HyhT9xJSKdzeTiWLz4lBh9ZJACgHus85TvHPHmOONwff/UVQ/wMH4JP80h7aFXN3VIEi
         N04aIK6I8xtsRpqonshPIeA3bdfidS0nI+6CBmCwrzqic7oach9XS+c3me+lDGMSBVQf
         pln7HemJYlnZQCZcRF7tWQNMq3Z5ZadAeMZoNfPmnQrA3W/VsXStFZMxbzZLgy2BW9Bw
         U8rA==
X-Gm-Message-State: AOAM531XdN1kXDA9wCPnDYSPB3KmyJm9gxUAsvt0godQqh17uKq8YPEi
        LzmFrcfWDm2fKn7n78g5W+NjmtTBmeY=
X-Google-Smtp-Source: ABdhPJyY/Sw8f19rTULHdmbqr+yxxLntJMEVT9KeLheVaYDxeRQRoz+dmNNn7063sKa/cVkqlp7RgA==
X-Received: by 2002:ad4:5c4c:0:b0:456:4d9e:db91 with SMTP id a12-20020ad45c4c000000b004564d9edb91mr7148185qva.37.1651143543093;
        Thu, 28 Apr 2022 03:59:03 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm12950299qtw.64.2022.04.28.03.59.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:59:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/3] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Thu, 28 Apr 2022 03:58:50 -0700
Message-Id: <20220428105852.94449-2-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220428105852.94449-1-carenas@gmail.com>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

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
-- 
2.36.0.352.g0cd7feaf86f

