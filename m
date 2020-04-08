Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E31CC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E25820730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJxbWu63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgDHTej (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:34:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36770 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgDHTej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:34:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id i7so10244053edq.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tPcIbSPbiFPZltfjArtjFMHBYFzkbAK9U9JdPJ/F8KM=;
        b=YJxbWu63VTOavqgPgL12O+YvBQxmOWO1fyMck59SdZATdogrpTeDSwdmT2lAiTCa36
         hZB41xLEWeVghFPJsOsXHMvZ4sfePNQwI54nX00AXJbFDCtJvhEGCFMKTh+6uUMtHvUf
         ZzPuClUAJj7mvZRSve831NakHzA7RoKFp4oetFBa8nH8RaQEoQKzDkBcgCcnJhZrfzi0
         U64FoOq4fk5i/yvib4nO8MSZXO9LKWemHNQZTB6nAYL7OkqkbXF6tPz3sGuqpFidET7f
         yrJD9QraafrUaE6KL0bNOtDlX0zaWtAZGT+SKHgSEhrQqQ6Q7EW9PAyLUBhnYsRcq5AO
         SI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tPcIbSPbiFPZltfjArtjFMHBYFzkbAK9U9JdPJ/F8KM=;
        b=ktVuayDFxuO8OtViHVFJWAOVAphcHDH3yfWuaUUwozywW/nDjB+4ejoiMpP+XgBqq/
         GimQmZ9Qb0M17SyOIX1LoXgeS075H5M2VJWCf5RCNB0H0YFfqqmTWDetSsV1EqrUtdCX
         tgnE6gCl6ctFO3YXK07/JiYq+zEieKu3jYuqRI1LGxt2sVZXpPeV3aFBh7TZciAeu9rG
         9KtBWRL+FfQUBd6RYZnNk6Hj5zaJvNKqoLc1fFNCtIwQ47YxBQWsArK+aiO9JnzGF9+5
         b9tEaab88zHwOIF/vn+cTFeSA2yb4GFntYgCVk0AgDPR5lVVbw+QKy2R6J9qsB/vC4Cj
         sVKA==
X-Gm-Message-State: AGi0PuakoaWNctQ/vevYILCB9daPioexeNcSMjs/XAqqxOP6WjwZJGC6
        HrUu59De3nFCxoOQMldTRI7oKLAr
X-Google-Smtp-Source: APiQypJHQFLhsV6rx4oVp32DAQS/ne/6bFEpeX1/yhtgMiyXzeNiC/02m8WKQPEworV6v+nYRIUumg==
X-Received: by 2002:a17:906:eb98:: with SMTP id mh24mr7915977ejb.375.1586374475262;
        Wed, 08 Apr 2020 12:34:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c19sm2813379ejd.48.2020.04.08.12.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 12:34:34 -0700 (PDT)
Message-Id: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 19:34:34 +0000
Subject: [PATCH] mingw: make is_hidden tests in t0001/t5611 more robust
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We should not actually expect the first `attrib.exe` in the PATH to
be the one we are looking for. Or that it is in the PATH, for that
matter.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Make the tests that test core.hideDotFiles more robust
    
    We have this feature on Windows where the files starting with a dot can
    be marked hidden (whether a file is hidden by default or not is a matter
    of naming convention on Unix, but it is an explicit flag on Windows).
    This patch improves the regression tests of this feature, and it has
    been carried in Git for Windows for over three years.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-603%2Fdscho%2Frobustify-is-hidden-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-603/dscho/robustify-is-hidden-tests-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/603

 t/t0001-init.sh         | 2 +-
 t/t5611-clone-config.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 26f82063267..2456688b281 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -395,7 +395,7 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path
-	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
 	return 1
 }
 
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 60c1ba951b7..87b8073cd74 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -95,7 +95,7 @@ test_expect_success 'clone -c remote.<remote>.fetch=<refspec> --origin=<name>' '
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path
-	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
 	return 1
 }
 

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
