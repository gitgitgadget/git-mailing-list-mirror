Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B37EC0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 16:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGZQGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjGZQGb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 12:06:31 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDFDE69
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 09:06:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so6495337f8f.0
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690387587; x=1690992387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFxeVHj6beia91wQaeJOZMRgd1QkHFAcdoA6CA+gR84=;
        b=hwMWpiUTf7/twRsYi2nGu5gyoUYqZ0335sgM9bU2ibRhB60d0JHTLprp+vBb9WJtnW
         Cpc8Mu9o3oUHvphdgzeoT5bumuK1oFyTIQpmzhUkEITWw/mdD+pAU77jaNzu4fegORuo
         MAZt0nkUTfXIvHVU251hBi06EAu4K6QcdM2xOp8/BCfiDR3Hsyw7v6irm84ftCpjYnAe
         v7c8bzHgvM4It6z5oTR5n8E0ct6zJkY2+j28HbrG5fyBGyiDB6TP8QW3Y4mNEl+ZMzXd
         YerSOX1sM1Z9/XjkhBKJucaC9m5goEXkyD47XmQOcAL4/FCAaG+choPXsCt63duM3ViC
         FiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387587; x=1690992387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFxeVHj6beia91wQaeJOZMRgd1QkHFAcdoA6CA+gR84=;
        b=VLWn8rUQcBQ790KUWX+4I/hNVjvl0Pl5z0a4fdRVEnrJRlSRxsDqcACCabm9cciVEY
         j2W0xgGvn3cgUKdVErfUpCelsUUhi6HDQBrkJDEMb0ki0DlZ3lPx3auZKygS01yfbqfr
         31k9j8Ivr3Shm3F5kc1GynnCQ3SBOEH0TRieV1bd1XN0Hd6VTYGF7UjcdbbUyIFApHzm
         OWl3k+ppdm2UOwyH/hn0oOrGXWuhS7ZvBGpNU7ytC4r+RqkjLBUVhKNEVlrwBrpcpt3t
         09h0wURolzJr3kBueydaOJQ2uyCZYX3QgFgrD3oHq6sQk/nH7Qk5e9oMayNqQr9h+Qk4
         IlgQ==
X-Gm-Message-State: ABy/qLaFc0i85dKMCLSafrXoSmZL7n3ypQ4UciiMUIJjHA2EAi6D37Ou
        Zi1QHLbnw7vDSpLhTzSA9UUPMFEYbPM=
X-Google-Smtp-Source: APBJJlHSQK7CQIuax4peb2yDyBe+ICzq81ENBSHN2rCdT38LuCx4wuuJkgL4QV/c/Mt/+bEVrQvBmw==
X-Received: by 2002:a05:6000:1a50:b0:317:65de:4389 with SMTP id t16-20020a0560001a5000b0031765de4389mr1590862wry.61.1690387587380;
        Wed, 26 Jul 2023 09:06:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020adfd4c9000000b0031423a8f4f7sm20384827wrk.56.2023.07.26.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:06:26 -0700 (PDT)
Message-ID: <pull.1527.v2.git.git.1690387585634.gitgitgadget@gmail.com>
In-Reply-To: <pull.1527.git.git.1687591293705.gitgitgadget@gmail.com>
References: <pull.1527.git.git.1687591293705.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 16:06:25 +0000
Subject: [PATCH v2] credential/libsecret: erase matching creds only
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

This fixes test "helper ... does not erase a password distinct from
input" introduced in aeb21ce22e (credential: avoid erasing distinct
password, 2023-06-13)

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/libsecret: erase more carefully
    
    Patch v2 has a more detailed commit message following
    https://lore.kernel.org/git/xmqqpmax5c4v.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1527%2Fhickford%2Ffix-libsecret-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1527/hickford/fix-libsecret-v2
Pull-Request: https://github.com/git/git/pull/1527

Range-diff vs v1:

 1:  dcc429c1afc ! 1:  b5d5c3159ad credential/libsecret: erase matching creds only
     @@ Metadata
       ## Commit message ##
          credential/libsecret: erase matching creds only
      
     -    Fix test "helper ... does not erase a password distinct from input"
     -    introduced in aeb21ce22e (credential: avoid erasing distinct password,
     -    2023-06-13)
     +    The credential erase request typically includes protocol, host, username
     +    and password.
     +
     +    credential-libsecret erases a stored credential if it matches protocol,
     +    host and username, regardless of password.
     +
     +    This is confusing in the case the stored password differs from that
     +    in the request. This case can occur when multiple credential helpers are
     +    configured.
     +
     +    Only erase credential if stored password matches request (or request
     +    omits password).
     +
     +    This fixes test "helper ... does not erase a password distinct from
     +    input" introduced in aeb21ce22e (credential: avoid erasing distinct
     +    password, 2023-06-13)
      
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
