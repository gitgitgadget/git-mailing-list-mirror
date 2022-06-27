Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E2BC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiF0Sie (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbiF0SiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:38:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F3CDB
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 189so5500494wmz.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vK/cK2CsYvziF+h6RxKNGee1lI7W8gvh+Wi2KpMeAJo=;
        b=Xdu+2K5kKEMY7i4P37JjRUNZxMgsuB2GMW8K5nWFcd7xLC1ZZjcE4wyp/GTNfhXGMa
         aItNr7e0l3kh+V+yDtKG2mhaid1gz+lkeiInV47C9PVDMkHHHOyFcwvKKy6AfC9KsTZL
         dwLm+UN8jAV6+vngepOyy+8I8TxVGOSzQxfuPquN30d5b52h4NIZpQdLwA/dOMP8LQEQ
         vhcaJwXgR+Q6BX/8/4jNAnVxNeRXiF7T0Paj8w8DLWKImMvFOhC0d3leJSsNSuq3WS5/
         mSzrY20dc0NtXqq3yYY5VcfU3bO87VWZPz2XMmiGDjQRC/ZW6geGn6Oq6Zyfs6b3DwnP
         XuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vK/cK2CsYvziF+h6RxKNGee1lI7W8gvh+Wi2KpMeAJo=;
        b=IogE1F7pZn79tXIDGpIDe+0VgGRWt7JsuQTblGvifb+OsF/0lkCF6UMnCwnh84j3E4
         IkAbilTKcKzea8B4Wble1Tz3Iz+hPpgzLbkghtGN+u4kC1WwVe5bGHqA9HY1E8WaDiTk
         P+NQsa1aCaTHkBHutdmnPwhy9lwS8Z/TdIQiXWvCbhTJEhEiMhdfK0UBJvYoLqzKPgi6
         tyRa3uFVE9NruR6ZBnF7SbgRl37y70i4FeBx6kjf7t3myOgnaY48GgxFeoy6wWnvSb6w
         n9eItoXX2rBoXnhQLfYCbuuB8ycBJYRDPhHPJ3KXqi1u2WExD4FncLG2JSeSNaGOBOct
         TZPw==
X-Gm-Message-State: AJIora9HngC0oNfQHvHQFxGsRdznc6048PJLmlX7/TDf+x+wZqD5y2FS
        1Fr6IhmzfdJfXH/e4hEj9QDeO2//LzexiQ==
X-Google-Smtp-Source: AGRyM1tnmaFdQovx2o1qykj+v0b4Vv/pvklzXhjHTA+pdjckXVryIQpdcxusqIEHA6bpfKDIKAaE+A==
X-Received: by 2002:a1c:19c3:0:b0:39c:6479:3ca with SMTP id 186-20020a1c19c3000000b0039c647903camr21378717wmz.27.1656355000409;
        Mon, 27 Jun 2022 11:36:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18-20020adfe852000000b0021ba3d1f2a0sm11064972wrn.48.2022.06.27.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:36:39 -0700 (PDT)
Message-Id: <ec9258234142c4d1d164cbf475cb86e7b826bb8f.1656354994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
References: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
        <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:36:33 +0000
Subject: [PATCH v5 4/5] safe.directory: use git_protected_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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
index faf5095e44d..c8e3c32814d 100644
--- a/setup.c
+++ b/setup.c
@@ -1137,7 +1137,7 @@ static int ensure_valid_ownership(const char *path)
 	    is_path_owned_by_current_user(path))
 		return 1;
 
-	read_very_early_config(safe_directory_cb, &data);
+	git_protected_config(safe_directory_cb, &data);
 
 	return data.is_safe;
 }
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 238b25f91a3..5a1cd0d0947 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -16,24 +16,20 @@ test_expect_success 'safe.directory is not set' '
 	expect_rejected_dir
 '
 
-test_expect_success 'ignoring safe.directory on the command line' '
-	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
-	grep "unsafe repository" err
+test_expect_success 'safe.directory on the command line' '
+	git -c safe.directory="$(pwd)" status
 '
 
-test_expect_success 'ignoring safe.directory in the environment' '
-	test_must_fail env GIT_CONFIG_COUNT=1 \
-		GIT_CONFIG_KEY_0="safe.directory" \
-		GIT_CONFIG_VALUE_0="$(pwd)" \
-		git status 2>err &&
-	grep "unsafe repository" err
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
-	grep "unsafe repository" err
+test_expect_success 'safe.directory in GIT_CONFIG_PARAMETERS' '
+	env GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
+	    git status
 '
 
 test_expect_success 'ignoring safe.directory in repo config' '
-- 
gitgitgadget

