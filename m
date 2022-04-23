Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA4C433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 20:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiDWUOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiDWUOq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 16:14:46 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D781A1A6B48
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 13:11:47 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id e189so12814152oia.8
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=61adGI9RjUwz0x5wNBpGhYAAC0Z9+ib+P5iOC+zMnqA=;
        b=ClI85UA7te2z1R7npllUMhr59tJMVrHldYm3m6eEVUfj19iqxBaUgylxXIt6T8AhrV
         iB2YXZ82rtnTCONyEOTRfp2FLf3IhqpQhZGskUIDOFwkgeQMbiwLT+wUKKeouIAJ9uOy
         7I6wZiXNZTUKuA1/QSrQLewSp7dA5SzJ7FAYqhutj0yuNwmSx8vKc9BQkXsTk/JaMjhj
         yoFOmsdL6ZHLge33I3NPibWrn1wY2IbRIqy5JaOIEzN6zGV2kxgv4Gqj857PJPu03cG6
         9wrfuRTGyuCJwu34hcJz/vVb85rSN9sTRCth3Y8vHQgdjRVKwnOElyFEX4TJA7+NGgRS
         7DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=61adGI9RjUwz0x5wNBpGhYAAC0Z9+ib+P5iOC+zMnqA=;
        b=C+nN9sorZFtRFYFcTbgDZ95btuU5WELbtLP16SAAk+hQk/SaSpityOLATlxJOD/LK3
         2MS0jPxzAdFlYLpyfYYlW/DJ+wUi0hPDzNk0AMJ0HA/TiiRcUWTLfKqD344m4390gjHB
         trbgAYNIRKqC7Ztj4sSW2OLMKp9AnXG77RnKB8cxlgt8jxJdoJeZcVytQL+cgBTFmA9B
         BdjWnZ1uAvFQMp4bGjc7zdUDGp/3t0Fnkrd5YdzeqhuC5CrtnOCi0H6YxrVrmE/bumSX
         t70fysdisBDA2j7HPo1YdR3PH0qeQRa7BD61A1xLMFKNoESfhsCq7wY2wZPvdjlxVNTt
         qc+w==
X-Gm-Message-State: AOAM532XwoyMZrtnlvP/cz3DMY0EwJKIwjUZ9WWkCAivNKG1qBoIvnGI
        4M9eh/4MPbpeVlidm00kMiN6UXv2ghE=
X-Google-Smtp-Source: ABdhPJwMCQ30kYDmd5uwsKlshSdVffXAY76lQ+PAApRCDGtnSQ0WXcTMtI76PBHgSVGz4DyRUlBNdQ==
X-Received: by 2002:aca:b28b:0:b0:2fa:6d40:4b3d with SMTP id b133-20020acab28b000000b002fa6d404b3dmr9485488oif.67.1650744707045;
        Sat, 23 Apr 2022 13:11:47 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id m187-20020aca58c4000000b002ef721352easm2086273oib.14.2022.04.23.13.11.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Apr 2022 13:11:46 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] fixup! CI: move p4 and git-lfs variables to ci/install-dependencies.sh
Date:   Sat, 23 Apr 2022 13:11:29 -0700
Message-Id: <20220423201129.34133-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <patch-v5-10.29-07e36035a1e-20220421T181526Z-avarab@gmail.com>
References: <patch-v5-10.29-07e36035a1e-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once the code was moved into an ubuntu specific branch, it doesn't make
sense anymore to refer to logic that only applies to a different branch

Cleanup the comment to allow for the implementation to change without
making it stale, and while at it rename the variable used to track the
P4 version to something slightly less confusing.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 ci/install-dependencies.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 098baeef3fb..7bea45fd339 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -23,11 +23,9 @@ esac
 case "$runs_on_pool" in
 ubuntu-latest)
 	# The Linux build installs the defined dependency versions below.
-	# The OS X build installs much more recent versions, whichever
-	# were recorded in the Homebrew database upon creating the OS X
-	# image.
+	# The OS X build installs much more recent versions
 	# Keep that in mind when you encounter a broken OS X build!
-	LINUX_P4_VERSION="16.2"
+	P4_AT_LINUX_VERSION="16.2"
 	LINUX_GIT_LFS_VERSION="1.5.2"
 
 	P4_PATH="$HOME/custom/p4"
@@ -39,7 +37,7 @@ ubuntu-latest)
 		echo "$PATH" >>"$GITHUB_PATH"
 	fi
 
-	P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+	P4WHENCE=http://filehost.perforce.com/perforce/r$P4_AT_LINUX_VERSION
 	LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 
 	sudo apt-get -q update
-- 
2.36.0.266.g59f845bde02

