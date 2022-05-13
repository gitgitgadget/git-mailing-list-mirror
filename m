Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A6BC433EF
	for <git@archiver.kernel.org>; Fri, 13 May 2022 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359829AbiEMBAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 21:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359826AbiEMBAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 21:00:42 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410C92AC44
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:40 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id n8so6041842qke.11
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQrjGTrsWKP1WT93Fe8GRh6sgBgr5kcfMyJZSAoWf4I=;
        b=iaZJ3z/IvqwhkZjmaLpfVPpa8hyBYAkoX+tk6htX4F/DI1ekTGWjn4NDx+dLZhmzaM
         eYksrQgnr4P5a52CIgQ5jUrQpbeepxRr587XfnGGXfq6fNiwCbqTWxt8Pl7O4z7cw38x
         kSCvX39HOIEA+3ibttUGU7eUWZmhnOBtrcgoYI8Y/KHu/Ncdt1fzfUtz06AU2z4BnJA/
         G01CCnMK7+CvBfLnpnnK3O+tvcRW/z8ejuJz1v3GlSr7ODUFOPfxfQbuY2EORdUhEDnC
         TodC93hSnh/QhKjP+OYL0gCz5ipLtw2nTrUU/e1QjB5iB01NRvL9vsEGZFQE4I9bCeBM
         uPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQrjGTrsWKP1WT93Fe8GRh6sgBgr5kcfMyJZSAoWf4I=;
        b=y0M5ogSWb3QYPfGinvHelifediAUQ3+zZ9x5MDY21SZIgTJStrVKGi807Z1OfARspU
         pQxrcwOHpWCK8hz56jvNW2EiE1y/8DmQ4DzK6d9azsPZipdS/qiJXJ8V7Osz6nTJxbwa
         HB4/fSJ9wGy5sruSFct1p3nKRGOG7WX9oFeg/X6d78sE8qWBou0Rd8j9E1g1tudbnOUq
         IURf5InlsXK9XTJr1tcK6aWJbxfmqrkBEy1pR4ZTigGq0+u87uMY7HOYb7B3nlmNg98t
         wn7pT957J8ZHF9jzeBZONDREnOgekPQ8R5u9Ohp+h2mjJWYHKRm6PUHRTYeW6xj7aRkA
         n+Cg==
X-Gm-Message-State: AOAM530f/brHtEbV1pQP93fxeZGK2KOkSeH/NTTZNo0aiICp/Z4xEhGg
        BU3PQXwNfL8GW/RfHVoFSRok/cfGF5c=
X-Google-Smtp-Source: ABdhPJyMcW+10Wjby6/8GOEWlFvhsGtf0VE/QUZ2fl3C7pnyr1jHd5yE1MWG1tE9v1u2uXn+tzS7tg==
X-Received: by 2002:a05:620a:1a97:b0:69e:b83e:bb9a with SMTP id bl23-20020a05620a1a9700b0069eb83ebb9amr2011018qkb.711.1652403638677;
        Thu, 12 May 2022 18:00:38 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s202-20020a3745d3000000b0069fc13ce227sm583541qka.88.2022.05.12.18.00.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 18:00:38 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v5 4/4] git-compat-util: allow root to access both SUDO_UID and root owned
Date:   Thu, 12 May 2022 18:00:20 -0700
Message-Id: <20220513010020.55361-5-carenas@gmail.com>
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

Previous changes introduced a regression which will prevent root for
accessing repositories owned by thyself if using sudo because SUDO_UID
takes precedence.

Loosen that restriction by allowing root to access repositories owned
by both uid by default and without having to add a safe.directory
exception.

A previous workaround that was documented in the tests is no longer
needed so it has been removed together with its specially crafted
prerequisite.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/config/safe.txt  |  5 +++--
 git-compat-util.h              | 15 ++++++++++-----
 t/t0034-root-safe-directory.sh | 15 +--------------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index c6ebd1674dd..3128b132713 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -31,11 +31,12 @@ As explained, Git only allows you to access repositories owned by
 yourself, i.e. the user who is running Git, by default.  When Git
 is running as 'root' in a non Windows platform that provides sudo,
  however, git checks the SUDO_UID environment variable that sudo creates
-and will allow access to the uid recorded as its value instead.
+and will allow access to the uid recorded as its value in addition to
+the id from 'root'.
 This is to make it easy to perform a common sequence during installation
 "make && sudo make install".  A git process running under 'sudo' runs as
 'root' but the 'sudo' command exports the environment variable to record
 which id the original user has.
 If that is not what you would prefer and want git to only trust
-repositories that are owned by root instead, then you must remove
+repositories that are owned by root instead, then you can remove
 the `SUDO_UID` variable from root's environment before invoking git.
diff --git a/git-compat-util.h b/git-compat-util.h
index e7cbfa65c9a..0a5a4ee7a9a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -420,9 +420,10 @@ static inline int git_offset_1st_component(const char *path)
  * maybe provide you with a patch that would prevent this issue again
  * in the future.
  */
-static inline void extract_id_from_env(const char *env, uid_t *id)
+static inline int id_from_env_matches(const char *env, uid_t id)
 {
 	const char *real_uid = getenv(env);
+	int matches = 0;
 
 	/* discard anything empty to avoid a more complex check below */
 	if (real_uid && *real_uid) {
@@ -432,9 +433,10 @@ static inline void extract_id_from_env(const char *env, uid_t *id)
 		errno = 0;
 		/* silent overflow errors could trigger a bug here */
 		env_id = strtoul(real_uid, &endptr, 10);
-		if (!*endptr && !errno)
-			*id = env_id;
+		if (!*endptr && !errno && (uid_t)env_id == id)
+			matches = 1;
 	}
+	return matches;
 }
 
 static inline int is_path_owned_by_current_uid(const char *path)
@@ -446,10 +448,13 @@ static inline int is_path_owned_by_current_uid(const char *path)
 		return 0;
 
 	euid = geteuid();
+	if (st.st_uid == euid)
+		return 1;
+
 	if (euid == ROOT_UID)
-		extract_id_from_env("SUDO_UID", &euid);
+		return id_from_env_matches("SUDO_UID", st.st_uid);
 
-	return st.st_uid == euid;
+	return 0;
 }
 
 #define is_path_owned_by_current_user is_path_owned_by_current_uid
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index a621f1ea5eb..ff311761289 100755
--- a/t/t0034-root-safe-directory.sh
+++ b/t/t0034-root-safe-directory.sh
@@ -68,7 +68,7 @@ test_expect_success 'can access if addressed explicitly' '
 	)
 '
 
-test_expect_failure SUDO 'can access with sudo if root' '
+test_expect_success SUDO 'can access with sudo if root' '
 	(
 		cd root/p &&
 		sudo git status
@@ -85,19 +85,6 @@ test_expect_success SUDO 'can access with sudo if root by removing SUDO_UID' '
 	)
 '
 
-test_lazy_prereq SUDO_SUDO '
-	sudo sudo id -u >u &&
-	id -u root >r &&
-	test_cmp u r
-'
-
-test_expect_success SUDO_SUDO 'can access with sudo abusing SUDO_UID' '
-	(
-		cd root/p &&
-		sudo sudo git status
-	)
-'
-
 # this MUST be always the last test
 test_expect_success SUDO 'cleanup' '
 	sudo rm -rf root
-- 
2.36.1.371.g0fb0ef0c8d

