Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F9C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 00:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiD0AIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354866AbiD0AIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 20:08:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0961403A
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 17:05:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c17-20020a056830349100b00605ca7d1deeso66956otu.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAJ47mBWTKjya4FsVP3elHy5E3cg/lw3Nmd8G63Tr4o=;
        b=nhjdOMh8tkWLe9RXwYvf9iUsF3fLfnLvI81lCltemzIZF/td471EmsasjrYEsbGGBx
         9bz0IskcyN1MnPry/3aTjdvfjGl821MsAYBI1FfdtghPv/TOudiQWoNkM9CTBBzmZGLK
         DJghXM3nXm5O0ZCRe4Anjuy/8qOu/snmWItKdTrPjeVoIF7TZXaGmcoz5Vei2ja3KvEh
         K2bLG+GdJToOxqmIEWY8q77kn3tv9c3I9/JHNkvde4Tnqi2vVFBN5kwuESDdKhLdYvOm
         LHLo9aQJpFr5KviJlNpHQ13VDPdyD5k7PKoV9UKIv3TUcN6xyNRuewMPWvr5CmxybR69
         VtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAJ47mBWTKjya4FsVP3elHy5E3cg/lw3Nmd8G63Tr4o=;
        b=22vZe2kvYSBXd1otuBd2IO7HFFZy8redZzQp9xTOBmnJAAfjcHouG220IHZ5oCXoT4
         5UTq5/rGSJSOV8wi/+TT9AhDwPF3Qf5sF8fDFxvWOAx6XlbJ/nnKnKGQhgaOljI4oSJL
         Te5CeX7xPMBvXx1oM9pDvcvrLyD1F/SL5O4xMNuQm1Kdnax0scEX0BjJNyqTTXcy0oxJ
         tHcwr4QSYR0dAWq6uRyPE2RaS0o0adPpl8jmWo/XLqJLiCkRbuWiy1+7+t0eXL4QxsJC
         TDhEgkk5SCjFc1/UEtUHOjP2aoILfHxZPWNvwEmk9EQiXdmjy6DJ7QyBsHRxtMICHgdU
         gdaA==
X-Gm-Message-State: AOAM532tyWhPX975AtnqXSU/x1TRv/jjr/Qygjxa53Pyp8fV7O8eTCRh
        96pax4sE0kbgUMYCBrT37CPXu+DwGOdb8w==
X-Google-Smtp-Source: ABdhPJw11xSDdEb9OZfrC/ANeY+pfSSPAtrHs1GI31mFlrdNq+Vikyc0xbUgo/8dlxtz/3eI/x7++A==
X-Received: by 2002:a9d:53c4:0:b0:605:72a0:1ffb with SMTP id i4-20020a9d53c4000000b0060572a01ffbmr9363854oth.9.1651017930407;
        Tue, 26 Apr 2022 17:05:30 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id n25-20020a4a3459000000b0033a622c3b5dsm6230858oof.27.2022.04.26.17.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2022 17:05:30 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Tue, 26 Apr 2022 17:05:22 -0700
Message-Id: <20220427000522.15637-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220426183105.99779-1-carenas@gmail.com>
References: <20220426183105.99779-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bdc77d1d685 (Add a function to determine whether a path is owned by the
current user, 2022-03-02) checks for the effective uid of the running
process using geteuid() but didn't account for cases where that uid was
root (because git was invoked through sudo or a compatible tool) and the
original user that repository trusted for its config was different,
therefore failing the following common use case:

  guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
  [sudo] password for guy:
  fatal: unsafe repository ('/home/guy/Software/uncrustify' is owned by someone else)

Attempt to detect those cases by using the environment variables that
sudo or compatible tools create to keep track of the original user id,
and do the ownership check using that instead.

This assumes the environment the user is running with after going
privileged can't be tampered with, and also does the check only for
root to keep the most common case less complicated, but as a side effect
will miss cases where sudo (or an equivalent) was used to change to
another unprivileged user or where the equivalent tool used to raise
privileges didn't track the original id in a sudo compatible way.

Reported-by: Guy Maurel <guy.j@maurel.de>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Randall Becker <rsbecker@nexbridge.com>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since RFC
* Addresses all spelling errors, even the ones not reported and even if I
  am sure "priviledged" is a nicer sounding word even if obsoleted.
* Uses strtol instead of atoi as suggested by Randall and Junio, the extra
  error checking was too much to handle inline so a new helper function
  was added.
* Removes checks for DOAS_UID, in an attempt to make the change smaller
  and because that is part of an extention that might not be that common.
  This means `doas` is still broken, but that was punted for now.
* Has been tested a little more, but is still missing a test case, but
  as Derrick pointed out doing so is not trivial, so punted for now.

 git-compat-util.h | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..9bb0eb5087a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -437,12 +437,48 @@ static inline int git_offset_1st_component(const char *path)
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
+ * an environment variable, do not use unless the original uid is
+ * root
+ */
+static inline int extract_id_from_env(const char *env, uid_t *id)
+{
+	const char *real_uid = getenv(env);
+
+	if (real_uid && *real_uid) {
+		char *error;
+		long extracted_id = strtol(real_uid, &error, 10);
+		if (!*error && LONG_MIN < extracted_id &&
+				extracted_id < LONG_MAX) {
+			*id = (uid_t)extracted_id;
+			return 1;
+		}
+	}
+	return 0;
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
+	if (euid == ROOT_UID) {
+		/* we might have raised our privileges with sudo */
+		extract_id_from_env("SUDO_UID", &euid);
+	}
+	return st.st_uid == euid;
 }
 
 #define is_path_owned_by_current_user is_path_owned_by_current_uid
-- 
2.36.0.266.g59f845bde02

