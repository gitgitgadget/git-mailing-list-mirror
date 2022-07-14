Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C3C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 21:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbiGNV2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 17:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbiGNV2W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 17:28:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E5C6E889
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3812668wme.0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3Jrh+W7kpE1LBYTVD/EsZcJLLfqG63kOKPgXVwLryUo=;
        b=HMSRUC9JE6Wh24ckMLFU8UZD0EY58yI+OPDkn0gU6GWMt6ysMlhfykJgMzq9MGEXdC
         I+kFmoH7qf41eUFsyoB2XUQfJ5XnIDkYr+Z77JtrSmn4WMw8HJ+OIyDWVnj/xrJUJuVA
         0pyJrtv9TdgXkqa3JdIG5kKsKl9VUjrbcxqOVGNZoB6mm9rWtqmKIbQRSXQ0j5vjfU29
         +BeexmqDGdleaR2KI/+R1jdICe0ZtKQ9A7wfqOhOFgq4xRcBX4VrcKnhH09yPOm9BVIA
         A38lsPl8va7YT17U60WCafEHo51mOyt4Fh2oLT7lkwKG5Mc2kx+9dM4RbfhzmF/fMkn9
         0+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3Jrh+W7kpE1LBYTVD/EsZcJLLfqG63kOKPgXVwLryUo=;
        b=nacEOzKQpVWuciR9s7d9KuVvsTKISf8dM1TEb8culWRe2j1JLvPwnwNRHK15W3V10Y
         g9wTM1Q7uwNYltPzI4DZJXQSqcc7u3VApc9yQzDeCMx64hfom3nCZYugT6usy3sjrDZG
         ob49TDCA04JyD0wDzigQGqyxURgztSuR9oFbNK2BewphsyPs1bfKNnoXKKilor/fx1BA
         cV/W9YGzd2tSGzsHp3dqdjAzu9GFVmZNsCo0WBpzW3X4anDWRiBuuJAdtJQq/NPbXMTy
         8nLDCFD3SewXvCKsnpLQMx+BqVW5vDQSTsAq479reL66uAWFy0wQUGcDDOg0WODcZd4m
         TPmQ==
X-Gm-Message-State: AJIora9vXP9Run+HY9h8Fc+hFlo0025p+IgDchWuHfprXZeExXYS5VGw
        rf/w3EWyKZW9Obj2gIXmv6KgO9ceWnk=
X-Google-Smtp-Source: AGRyM1udkwBfxsn52IumWJe1OPhA2RmcdrEi/RyFqOrwf8LTfPFs5+LDLHeGWQOapCDe5eWBX/8rZg==
X-Received: by 2002:a7b:ce04:0:b0:3a1:92e0:d889 with SMTP id m4-20020a7bce04000000b003a192e0d889mr10886030wmc.131.1657834091076;
        Thu, 14 Jul 2022 14:28:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003a2e2ba94ecsm6514785wmq.40.2022.07.14.14.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:28:09 -0700 (PDT)
Message-Id: <b3256d68f8425d8b16ccb7deedfdb02118e26f5b.1657834081.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
References: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
        <pull.1261.v8.git.git.1657834081.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 21:28:00 +0000
Subject: [PATCH v8 4/5] safe.directory: use git_protected_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Use git_protected_config() to read `safe.directory` instead of
read_very_early_config(), making it 'protected configuration only'.

As a result, `safe.directory` now respects "-c", so update the tests and
docs accordingly. It used to ignore "-c" due to how it was implemented,
not because of security or correctness concerns [1].

[1] https://lore.kernel.org/git/xmqqlevabcsu.fsf@gitster.g/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/safe.txt |  6 +++---
 setup.c                       |  2 +-
 t/t0033-safe-directory.sh     | 24 ++++++++++--------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index fa02f3ccc54..f72b4408798 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -12,9 +12,9 @@ via `git config --add`. To reset the list of safe directories (e.g. to
 override any such directories specified in the system config), add a
 `safe.directory` entry with an empty value.
 +
-This config setting is only respected when specified in a system or global
-config, not when it is specified in a repository config, via the command
-line option `-c safe.directory=<path>`, or in environment variables.
+This config setting is only respected in protected configuration (see
+<<SCOPES>>). This prevents the untrusted repository from tampering with this
+value.
 +
 The value of this setting is interpolated, i.e. `~/<path>` expands to a
 path relative to the home directory and `%(prefix)/<path>` expands to a
diff --git a/setup.c b/setup.c
index 09b6549ba9e..ec5b9139e32 100644
--- a/setup.c
+++ b/setup.c
@@ -1155,7 +1155,7 @@ static int ensure_valid_ownership(const char *gitfile,
 	 * constant regardless of what failed above. data.is_safe should be
 	 * initialized to false, and might be changed by the callback.
 	 */
-	read_very_early_config(safe_directory_cb, &data);
+	git_protected_config(safe_directory_cb, &data);
 
 	return data.is_safe;
 }
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 3908597d42d..f4d737dadd0 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -16,24 +16,20 @@ test_expect_success 'safe.directory is not set' '
 	expect_rejected_dir
 '
 
-test_expect_success 'ignoring safe.directory on the command line' '
-	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
-	grep "dubious ownership" err
+test_expect_success 'safe.directory on the command line' '
+	git -c safe.directory="$(pwd)" status
 '
 
-test_expect_success 'ignoring safe.directory in the environment' '
-	test_must_fail env GIT_CONFIG_COUNT=1 \
-		GIT_CONFIG_KEY_0="safe.directory" \
-		GIT_CONFIG_VALUE_0="$(pwd)" \
-		git status 2>err &&
-	grep "dubious ownership" err
+test_expect_success 'safe.directory in the environment' '
+	env GIT_CONFIG_COUNT=1 \
+	    GIT_CONFIG_KEY_0="safe.directory" \
+	    GIT_CONFIG_VALUE_0="$(pwd)" \
+	    git status
 '
 
-test_expect_success 'ignoring safe.directory in GIT_CONFIG_PARAMETERS' '
-	test_must_fail env \
-		GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
-		git status 2>err &&
-	grep "dubious ownership" err
+test_expect_success 'safe.directory in GIT_CONFIG_PARAMETERS' '
+	env GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
+	    git status
 '
 
 test_expect_success 'ignoring safe.directory in repo config' '
-- 
gitgitgadget

