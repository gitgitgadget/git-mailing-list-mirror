Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB83C27C76
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 14:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjA1OEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 09:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjA1OEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 09:04:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2133C2C
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 06:04:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j17so5286938wms.0
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=araOlnj+h+BSNA8byuzM/QnHz/hDwOxGhEY2xKqVGNQ=;
        b=ocCmSf3Lgdt2m4+vYILIfT+NuRpwMHjZ9vcKazyMykiYVf1JhSPyaV7qpn2lKzaWa9
         L3HU8Egl5f8cCK5/88PJ7CJbCYgkRNEDYijc0sM3D2qE+enuPaR0WSk9Vyitsp5XmT1O
         JD+k+BWQ6zkWuiZr4aRqCbw1Jz6S1IcKk5FbKSXQ3UcD6US4fbn3/V/n20hH8ZyVLz/H
         HFbBFKUhU1aBwd5bvdhgrDDcbyLNcmLcjAlF2tRZ++O4T9/B7zeA3hDJ1pOR6vdTMALF
         zU3drJINfUm6tf48rt68PGzszmuxG7DjhqDetephW+gOJnMezuB+qypfut97vgs+JGvv
         itbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=araOlnj+h+BSNA8byuzM/QnHz/hDwOxGhEY2xKqVGNQ=;
        b=sS22Hs09K5opTrEPh5TBcZ6momGa+N3uVdrcgP04lAf6mUpey3m0JuvsbVQvZ+GxCa
         W6OeUI1LhRpn3Nn1Wt5Vj3isYMPyLjg9UVpQNjZ/e+EIhxzTw/D59yx8afopcBU8tIag
         ARgl82n6eTn1GXpqDtcAUZA8SkbER/Vt2/yzrVblHa3oa7qDrSzaSaCQ8svDYs/aOt6e
         wI5Fp5M6hLbz5+6AZ1yblw3zysWOmdoWts4U9/+Fz6Kn39Xqlrsc5dxFauxCNQB+L5Bi
         +0AjvJnt95ODJXO5NbJ6HDZHTrXguqOvkN/2QkggyF20s2sZT3kgAkrLWcs2z/R7ud6s
         kvjg==
X-Gm-Message-State: AFqh2kr6K3w36Y5ohQ6sLOXZyNxycD7CIC3nblXJqHHxvfjnzImq9amd
        g+TPvcGkELtdh9SB0xYg6MmDBIkI0gQ=
X-Google-Smtp-Source: AMrXdXvC/kY+VrIx4Pq57y9AT6Nkh5uCIOVhpes5ZmbwagXc+h2p5g4ZKkOodAKXviLPa9LOF5c2cg==
X-Received: by 2002:a05:600c:6006:b0:3db:21b8:5f58 with SMTP id az6-20020a05600c600600b003db21b85f58mr36068875wmb.2.1674914652169;
        Sat, 28 Jan 2023 06:04:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003dc4050c97bsm5330116wmq.3.2023.01.28.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 06:04:11 -0800 (PST)
Message-Id: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Jan 2023 14:04:10 +0000
Subject: [PATCH] credential: new attribute password_expiry_utc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

If password has expired, credential fill no longer returns early,
so later helpers can generate a fresh credential. This is backwards
compatible -- no change in behaviour with helpers that discard the
expiry attribute. The expiry logic is entirely in the git credential
layer; compatible helpers simply store and return the expiry
attribute verbatim.

Store new attribute in cache.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential: new attribute password_expiry_utc
    
    Some passwords, such as a personal access token or OAuth access token,
    may have an expiry date (as long as years for PATs or as short as hours
    for an OAuth access token). Add a new credential attribute
    password_expiry_utc.
    
    If password has expired, credential fill no longer returns early, so
    later helpers have opportunity to generate a fresh credential. This is
    backwards compatible -- no change in behaviour with helpers that discard
    the expiry attribute. The expiry logic is entirely in the git credential
    layer. Credential-generating helpers need only output the expiry
    attribute. Storage helpers should store the expiry if they can.
    
    Store expiry attribute in cache.
    
    This is particularly useful when a storage helper and a
    credential-generating helper are configured together, eg.
    
    [credential]
        helper = storage  # eg. cache or osxkeychain
        helper = generate  # eg. oauth
    
    
    Without this patch, credential fill may return an expired credential
    from storage, causing authentication to fail. With this patch: a fresh
    credential is generated if and only if the credential is expired.
    
    Example usage in a credential-generating helper
    https://github.com/hickford/git-credential-oauth/pull/16/files
    
    Signed-off-by: M Hickford mirth.hickford@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1443%2Fhickford%2Fpassword-expiry-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1443/hickford/password-expiry-v1
Pull-Request: https://github.com/git/git/pull/1443

 Documentation/git-credential.txt   |  4 ++++
 builtin/credential-cache--daemon.c |  3 +++
 credential.c                       | 21 +++++++++++++++++++++
 credential.h                       |  1 +
 4 files changed, 29 insertions(+)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ac2818b9f66..15ace648bdd 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -144,6 +144,10 @@ Git understands the following attributes:
 
 	The credential's password, if we are asking it to be stored.
 
+`password_expiry_utc`::
+
+	If password is a personal access token or OAuth access token, it may have an expiry date. When getting credentials from a helper, `git credential fill` ignores the password attribute if the expiry date has passed. Storage helpers should store this attribute if possible. Helpers should not implement expiry logic themselves. Represented as Unix time UTC, seconds since 1970.
+
 `url`::
 
 	When this special attribute is read by `git credential`, the
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index f3c89831d4a..5cb8a186b45 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
 		if (e) {
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
+			if (e->item.password_expiry_utc != 0) {
+				fprintf(out, "password_expiry_utc=%ld\n", e->item.password_expiry_utc);
+			}
 		}
 	}
 	else if (!strcmp(action.buf, "exit")) {
diff --git a/credential.c b/credential.c
index f6389a50684..0a3a9cbf0a2 100644
--- a/credential.c
+++ b/credential.c
@@ -7,6 +7,7 @@
 #include "prompt.h"
 #include "sigchain.h"
 #include "urlmatch.h"
+#include <time.h>
 
 void credential_init(struct credential *c)
 {
@@ -21,6 +22,7 @@ void credential_clear(struct credential *c)
 	free(c->path);
 	free(c->username);
 	free(c->password);
+	c->password_expiry_utc = 0;
 	string_list_clear(&c->helpers, 0);
 
 	credential_init(c);
@@ -234,11 +236,23 @@ int credential_read(struct credential *c, FILE *fp)
 		} else if (!strcmp(key, "path")) {
 			free(c->path);
 			c->path = xstrdup(value);
+		} else if (!strcmp(key, "password_expiry_utc")) {
+			// TODO: ignore if can't parse integer
+			c->password_expiry_utc = atoi(value);
 		} else if (!strcmp(key, "url")) {
 			credential_from_url(c, value);
 		} else if (!strcmp(key, "quit")) {
 			c->quit = !!git_config_bool("quit", value);
 		}
+
+		// if expiry date has passed, ignore password and expiry fields
+		if (c->password_expiry_utc != 0 && time(NULL) > c->password_expiry_utc) {
+			trace_printf(_("Password has expired.\n"));
+			FREE_AND_NULL(c->username);
+			FREE_AND_NULL(c->password);
+			c->password_expiry_utc = 0;
+		}
+
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
@@ -269,6 +283,13 @@ void credential_write(const struct credential *c, FILE *fp)
 	credential_write_item(fp, "path", c->path, 0);
 	credential_write_item(fp, "username", c->username, 0);
 	credential_write_item(fp, "password", c->password, 0);
+	if (c->password_expiry_utc != 0) {
+		int length = snprintf( NULL, 0, "%ld", c->password_expiry_utc);
+		char* str = malloc( length + 1 );
+		snprintf( str, length + 1, "%ld", c->password_expiry_utc );
+		credential_write_item(fp, "password_expiry_utc", str, 0);
+		free(str);
+	}
 }
 
 static int run_credential_helper(struct credential *c,
diff --git a/credential.h b/credential.h
index f430e77fea4..e10f7c2b313 100644
--- a/credential.h
+++ b/credential.h
@@ -126,6 +126,7 @@ struct credential {
 	char *protocol;
 	char *host;
 	char *path;
+	time_t password_expiry_utc;
 };
 
 #define CREDENTIAL_INIT { \

base-commit: 5cc9858f1b470844dea5c5d3e936af183fdf2c68
-- 
gitgitgadget
