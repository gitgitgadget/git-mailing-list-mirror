Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E8C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 20:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347575AbiFQUYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiFQUYA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 16:24:00 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83456238
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 13:23:58 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so3886480otg.3
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 13:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRYUpa9+lETlpJNnPD3d4pP6D+EkDSw/7VTjFyHqHmg=;
        b=XZi+rve/DKwWFU5uVPxw6cZbHsIjM85AzeMsjQzqX1VmebmIE9tzNFCNUFAQIs+VAx
         0032JTQ1glRjCwE0VkyXSqrOJRyk9Iix2bHn+/7fNPqSHFV8mNMM+TzhLJln2CjPlb6k
         z5K5US83G6hqAB7ybwnfOnb3gsE4Umc3+cRk69Y5J537jk5wBhQlAXmxy/3GFYaM0r67
         69QMhfwvzk+X1mYQOiRB7ybrs49wtdz0aiDynPBw5ZOReALerDHF9f73kWT5zzc1u3Ct
         b8T22m0yd4lHHP0WGCozw750IYs0wj1bh+xsm41MHzz7e9kE6iSB5mpxZyp1nw5svG+a
         UbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRYUpa9+lETlpJNnPD3d4pP6D+EkDSw/7VTjFyHqHmg=;
        b=CeWFPnnBBQlnISTULW5/dEGAo/ZKHimkM7s/nYDe0aplTtvNsFhSIOtZAkMtrQN6CN
         LK2hJ+UoUstYyUpXyhx1UsbOJ/I5RLqCjgcGyNL8cac+OD3DbQLaVGM3/zp9bzr0dcxe
         gKvjvp9A/G6FBty6eETC/FuAOzNA0EDu7kuIxdUHyaD360+X/LAnXccDyMX0itrftmv9
         uXgy5ikYFvOpA9rVKo7X7DpuzB4BUjPBKPRTQq6Z4JebPqM//w3LYpQor9tWGE4vCSFA
         72osgYHcMQ2Ml1XhWtkr7XBaIvDYn94eM7JWlFA5mGTvnUXcN1wJUzkzv123ASjDiyTS
         4PEw==
X-Gm-Message-State: AJIora+YtfVagM6htvnQsGW/pJNd+f6+CDZATKuqwTasjOgO7R0HZuV9
        LXfv6XUzGVzJGnU+pWFxaK78y1vsyYE=
X-Google-Smtp-Source: AGRyM1s+wsqy17fuQj9Q5/vMNl5rD7xFWOiasFNWGFxFXMC2ZX2c7daxicu3e4vG+jd6NuUDcGadLQ==
X-Received: by 2002:a9d:4581:0:b0:60c:7ce:448b with SMTP id x1-20020a9d4581000000b0060c07ce448bmr4889985ote.362.1655497437417;
        Fri, 17 Jun 2022 13:23:57 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id t8-20020a9d66c8000000b0060b0b638583sm2979096otm.13.2022.06.17.13.23.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 13:23:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, bagasdotme@gmail.com,
        johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johanness Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6] git-compat-util: allow root to access both SUDO_UID and root owned
Date:   Fri, 17 Jun 2022 13:23:38 -0700
Message-Id: <20220617202338.27984-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.1.371.g0fb0ef0c8d
In-Reply-To: <20220513010020.55361-5-carenas@gmail.com>
References: <20220513010020.55361-5-carenas@gmail.com>
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

Helped-by: Johanness Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
It is a little more involved than the proposed change just to make
sure that it doesn't introduce any change on behavior (the code is
still strictly only invoked after we confirm process is running as
root) and keeps the documentation and test changes that were in the
original proposal.

A CI run (which is the only way to reliably test this, since the
prerequisite only works in macOS agents like the ones provided by
GitHub) with this patch merged into master is available[1]

[1] https://github.com/carenas/git/actions/runs/2516394052

Changes since v5:
* simplify logic change to avoid additional refactoring

 Documentation/config/safe.txt  |  5 +++--
 git-compat-util.h              |  7 ++++++-
 t/t0034-root-safe-directory.sh | 15 +--------------
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index c6ebd1674d..3128b13271 100644
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
index e7cbfa65c9..f505f817d5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -447,7 +447,12 @@ static inline int is_path_owned_by_current_uid(const char *path)
 
 	euid = geteuid();
 	if (euid == ROOT_UID)
-		extract_id_from_env("SUDO_UID", &euid);
+	{
+		if (st.st_uid == ROOT_UID)
+			return 1;
+		else
+			extract_id_from_env("SUDO_UID", &euid);
+	}
 
 	return st.st_uid == euid;
 }
diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
index a621f1ea5e..ff31176128 100755
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

base-commit: b9063afda17a2aa6310423c9f7b776c41f753091
-- 
2.30.2

