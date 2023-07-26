Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC1DC0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 19:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjGZTq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGZTq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 15:46:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EE21727
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 12:46:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso956405e9.3
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690400816; x=1691005616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5c8FuS62lBJSSyLiKkyOwWBV0B8VcBTmLN/lv36sjQ=;
        b=NPl84JAc0k9y+zN2BlCqxgr7O1EejQJnDDyVJfElLjYlezcBaZ0aSwRvHJTAG+5YsI
         PdK1wZiml7IJi5zZUZEzcHbRQ/FVxPTZ72l3iI/mjWbAAWUzqHcJsUe//NR+vOsr/jC9
         21o9VRRHuNTN5dvR/nouxarujsJPmB1zZT982wkXe0CkBo5/QEDD7r1fPmF1nRBIVI72
         jR6BQGcYGMm2EK2msKIk0n6V3tLkwz8dOqkY0tLHZ7n+Rtxd9U+KSqf4woPMtCLUAViZ
         NOaUNfauMOTZKZTc06Oq+APARKJQ4rdejmSTu6nWmP1UO04rgRH8uckQKWbMTSmUR7Uo
         IRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400816; x=1691005616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5c8FuS62lBJSSyLiKkyOwWBV0B8VcBTmLN/lv36sjQ=;
        b=AHOrKeV6v/FjL8WLrd2bUSy1ZhtNJC8Il5LaUCqsDlyDGCuZMwyJ2jsxus8+gQbJgZ
         +1DIurH7OFPFs7MlIhUVilbnPvA9/r8J1trch530eFePjvT5Kh2ThKCbNe/EP1vLns64
         sIGZUATl1LWOSrEtBSr8HuNWeZW56SViT5lQsF5dUYHryMAogKy1z+llOhwcjUWl0LoQ
         fkcuZHvdap3YFg9Y8BKx9l/+CrpeCaC3s5JNtVOeE7vTmesVOh9eAolar8GXe/tbjRXA
         9ldsUIET9JlyA0TdiTcZTZ9Ud2cXuFXBTE2uRzCRip+LktdGPpzABcn8x51W1DGRKkga
         jwnA==
X-Gm-Message-State: ABy/qLaEXnMQICZmw7E8LrgAFGfZfmR/NcYIHgrpVs7m4P+vTLpjhjPA
        fMyrakQCyjt0hBy1w1zLJLirNV5c3d8=
X-Google-Smtp-Source: APBJJlGkVPGMsmREbbK+zO5l4bEeB1a98Ck9Iy0CE4pz+bhniAUh+O74Fz0my3dL9lnJNSOwxIWgAA==
X-Received: by 2002:a5d:6982:0:b0:315:93a1:c733 with SMTP id g2-20020a5d6982000000b0031593a1c733mr89785wru.20.1690400815663;
        Wed, 26 Jul 2023 12:46:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5492000000b003142e438e8csm20638141wrv.26.2023.07.26.12.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:46:55 -0700 (PDT)
Message-ID: <pull.1527.v3.git.git.1690400814492.gitgitgadget@gmail.com>
In-Reply-To: <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
References: <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 19:46:54 +0000
Subject: [PATCH v3] credential/libsecret: erase matching creds only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

The credential erase request typically includes protocol, host, username
and password.

credential-libsecret erases a stored credential if it matches protocol,
host and username, regardless of password.

This is confusing in the case the stored password differs from that
in the request. This case can occur when multiple credential helpers are
configured.

Only erase credential if stored password matches request (or request
omits password).

This fixes test "helper (libsecret) does not erase a password distinct
from input" when t0303 is run with GIT_TEST_CREDENTIAL_HELPER set to
"libsecret". This test was added in aeb21ce22e (credential: avoid
erasing distinct password, 2023-06-13).

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/libsecret: erase more carefully
    
    Patch v3 adds instructions how to run the fixed test

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1527%2Fhickford%2Ffix-libsecret-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1527/hickford/fix-libsecret-v3
Pull-Request: https://github.com/git/git/pull/1527

Range-diff vs v2:

 1:  b5d5c3159ad ! 1:  6b3db416c61 credential/libsecret: erase matching creds only
     @@ Commit message
          Only erase credential if stored password matches request (or request
          omits password).
      
     -    This fixes test "helper ... does not erase a password distinct from
     -    input" introduced in aeb21ce22e (credential: avoid erasing distinct
     -    password, 2023-06-13)
     +    This fixes test "helper (libsecret) does not erase a password distinct
     +    from input" when t0303 is run with GIT_TEST_CREDENTIAL_HELPER set to
     +    "libsecret". This test was added in aeb21ce22e (credential: avoid
     +    erasing distinct password, 2023-06-13).
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      


 .../libsecret/git-credential-libsecret.c        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index ef681f29d5b..9110714601e 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -52,6 +52,8 @@ struct credential_operation {
 
 #define CREDENTIAL_OP_END { NULL, NULL }
 
+static void credential_clear(struct credential *c);
+
 /* ----------------- Secret Service functions ----------------- */
 
 static char *make_label(struct credential *c)
@@ -185,6 +187,7 @@ static int keyring_erase(struct credential *c)
 {
 	GHashTable *attributes = NULL;
 	GError *error = NULL;
+	struct credential existing = CREDENTIAL_INIT;
 
 	/*
 	 * Sanity check that we actually have something to match
@@ -197,6 +200,20 @@ static int keyring_erase(struct credential *c)
 	if (!c->protocol && !c->host && !c->path && !c->username)
 		return EXIT_FAILURE;
 
+	if (c->password) {
+		existing.host = g_strdup(c->host);
+		existing.path = g_strdup(c->path);
+		existing.port = c->port;
+		existing.protocol = g_strdup(c->protocol);
+		existing.username = g_strdup(c->username);
+		keyring_get(&existing);
+		if (existing.password && strcmp(c->password, existing.password)) {
+			credential_clear(&existing);
+			return EXIT_SUCCESS;
+		}
+		credential_clear(&existing);
+	}
+
 	attributes = make_attr_list(c);
 	secret_password_clearv_sync(SECRET_SCHEMA_COMPAT_NETWORK,
 				    attributes,

base-commit: a80be152923a46f04a06bade7bcc72870e46ca09
-- 
gitgitgadget
