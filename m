Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE3FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 08:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiGMIVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiGMIUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3BC5A2EC
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so14372627wrx.12
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iuZeZdbfTT+4BTlW+8ugBH/slvK4jQ8Va5eTx6HZ7LU=;
        b=F6mK1HrgYnMVYleHOlTMENDnpbSIRbgt8hjQz00OQN/OHrPbfE7dXFweaPrmI1BG+K
         /5FlryzUwbD4Vk1WA8IudQE4dXHdKEtZ6nIi58zdTCSnJqcWNKDSVqHS/9ZSKr3ONd2i
         XmCKpwUTJDddven0baqbm77iDm/9eKYGYknasO3/QrkbdqF+WSOmHcmBy8f7Ts7AkEP3
         g5bCaFfR5O8okZNYsvPK23SKU8hjd9RiWK/6cheXthbwiBUO6/rhs4ghCt7G10qJxTEt
         dmUgNV1hO864IO/Tf/pH5zjfCKX3B9UtJqh53y1jpxgeN6ntdhwCldZYK+8zhhv+wJ6Q
         ++tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iuZeZdbfTT+4BTlW+8ugBH/slvK4jQ8Va5eTx6HZ7LU=;
        b=ghlohB77r5J/YWMUqFS+7aIp89frLUo4kYPU13PBklT8eAjT4MNxARyuX9sqhnqEc0
         DB+jftR3c3TVR15ku44VWCPflGKO75kBfLZs/tp63BPgN+k7WkMsUT2e0m/H8RYmAlF0
         lZgz18f0dE7BiDHpsn7nJpDMzzGIgjbER7C289RnDGKihqVMETiDpajCZY0CnZ7NF5lB
         3BSYyqMGsrVKhawnT6HUkEzXzopAu9+gelCoqKvczpltb5hlUo1TlNf+Yq6htyEFGyPe
         QmTrWqnX/dtQQQdllFfzRVzDQiVbgQ2UhJWymBByUSo8cEKjJvFYhPpq3/NS/BFfqaTS
         XEhQ==
X-Gm-Message-State: AJIora8jNi9AN7UN79QJHoSUSBS7budVsi9RL3jKofEf+xNlDgEysM7V
        NU5YoDdKoA7+C6jHe6+s38vI7PGJkIs=
X-Google-Smtp-Source: AGRyM1tk12aJQpyZ0STyhHLiR8K7mppGrLU0RsiLPzVhgWwtvpmB1aJxGlkqvCyJKO2tM4C7aXOXnw==
X-Received: by 2002:a05:6000:a1c:b0:21d:7ec3:485e with SMTP id co28-20020a0560000a1c00b0021d7ec3485emr1956575wrb.106.1657700243091;
        Wed, 13 Jul 2022 01:17:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a5d4566000000b0021d6f03b524sm10218902wrc.48.2022.07.13.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:17:22 -0700 (PDT)
Message-Id: <dae03f1b20430ff93c826b126057961a9030f2bf.1657700238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 08:17:17 +0000
Subject: [PATCH 3/3] mingw: be more informative when ownership check fails on
 FAT32
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The FAT file system has no concept of ACLs. Therefore, it cannot store
any ownership information anyway, and the `GetNamedSecurityInfoW()` call
pretends that everything is owned "by the world".

Let's special-case that scenario and tell the user what's going on, at
least when they set `GIT_TEST_DEBUG_UNSAFE_DIRECTORIES`.

This addresses https://github.com/git-for-windows/git/issues/3886

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e0e020ee574..4144d6247bd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2630,6 +2630,21 @@ static PSID get_current_user_sid(void)
 	return result;
 }
 
+static int acls_supported(const char *path)
+{
+	size_t offset = offset_1st_component(path);
+	WCHAR wroot[MAX_PATH];
+	DWORD file_system_flags;
+
+	if (offset &&
+	    xutftowcsn(wroot, path, MAX_PATH, offset) > 0 &&
+	    GetVolumeInformationW(wroot, NULL, 0, NULL, NULL,
+				  &file_system_flags, NULL, 0))
+		return !!(file_system_flags & FILE_PERSISTENT_ACLS);
+
+	return 0;
+}
+
 int is_path_owned_by_current_sid(const char *path)
 {
 	WCHAR wpath[MAX_PATH];
@@ -2687,7 +2702,14 @@ int is_path_owned_by_current_sid(const char *path)
 			 * okay, too.
 			 */
 			result = 1;
-		else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
+		else if (IsWellKnownSid(sid, WinWorldSid) &&
+			 git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0) &&
+			 !acls_supported(path)) {
+			/*
+			 * On FAT32 volumes, ownership is not actually recorded.
+			 */
+			warning("'%s' is on a file system that does not record ownership", path);
+		} else if (git_env_bool("GIT_TEST_DEBUG_UNSAFE_DIRECTORIES", 0)) {
 			LPSTR str1, str2, to_free1 = NULL, to_free2 = NULL;
 
 			if (ConvertSidToStringSidA(sid, &str1))
-- 
gitgitgadget
