Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EB5EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 11:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbjFNLXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 07:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFNLXL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 07:23:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1BB19B5
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 04:23:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8d2bfec3bso6085255e9.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 04:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686741788; x=1689333788;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4jP1ZRgeOJVTJBG1rvcJe7IZrjN7oK4Tus1E8ygicI=;
        b=gLX0P6JK4gVFRwnz8TRJex7QOG7aRluN+++ZBzynQ52/GjWI2c0WRLN4VOE/GVbLT0
         fCTDlLGvyQxg39g7VBDgkdSXahX1Q94Qo9c0AmxcCsRn6vxScFm0U2dQtVHK5L70qwvr
         UFqCHZbdg9ysAExGUOqTTQx5MYpIcsNP9iKQbGjXu5NFXCTJze59L4/vOs8Qi14dFLXD
         9k9BZIUSduPmzKTu3HI07/C2/0dyaDYrGtoz5HF9fKO7AubmN18dfVvKhk7qsG6JKWo/
         6xZ7IwKIV5AcWslkTaex7cCuatbh1atKHg8/J5M2/DJ6XKZOo7VnnHkc9vHTk7P45YLS
         HleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686741788; x=1689333788;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4jP1ZRgeOJVTJBG1rvcJe7IZrjN7oK4Tus1E8ygicI=;
        b=XN2VJY5zlbEzUUJvN8j9vCeeQVAw/vjzmiURwqs423DIJKBi1teS49IgThPruDLoeQ
         QPJXdYMn2qD2GC6ZM2PeEnD1kmKWhYW1KRENKw/aAkH0V56Q0XILuV01flZ33CEv9Mw2
         4q1P2A24naSOhSd2YDqQF04o9g5IjrcAfSMgKb/xL5HkOLWkI9kWo9ntRiLtt+pVzttv
         lccT5788GGAxPyDL64Ap01vCLbV6qY+9srzuDkzesyMIU6rxSLTn9lTtse6jV/096C8j
         fuCKdQzDkan3VATynP7o/W9zdug1iRvbcb7k9ArRZogO3wUM6ub+gtboKw063z5+Nomw
         Ak3w==
X-Gm-Message-State: AC+VfDytYRihZt3SXZM3tVExt+oiuC4RgtYOH/EfLEHgu+asznDygckv
        4sjiNiCkuK+zP7xx3fLw01Dk8x52pW4=
X-Google-Smtp-Source: ACHHUZ4s4i9723qtUDkb7jTDpUNJb24r+423qV9fl4ebbckxGIk6MXGH15NSsW7LJBSwCW+wyiFwLQ==
X-Received: by 2002:a1c:ed06:0:b0:3f5:fff8:d4f3 with SMTP id l6-20020a1ced06000000b003f5fff8d4f3mr12734201wmh.7.1686741787949;
        Wed, 14 Jun 2023 04:23:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a1c7411000000b003f7e4639aabsm17167668wmc.10.2023.06.14.04.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 04:23:07 -0700 (PDT)
Message-Id: <fcdb579263f87dd089c50fc5799cf30b21f4d12c.1686741785.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 14 Jun 2023 11:23:05 +0000
Subject: [PATCH 2/2] credential: erase all matching credentials
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

Users expect that
`echo "url=https://example.com" | git credential reject` or
`echo "url=https://example.com\nusername=tim" | git credential reject`
erase all matching credentials.

Fixes for credential-cache and credential-store.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 Documentation/git-credential.txt   |  4 ++--
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c | 15 ++++++++------
 builtin/credential-store.c         |  3 ++-
 t/lib-credential.sh                | 33 ++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 0e6d9e85ec7..04bfb918de6 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -38,8 +38,8 @@ to any configured credential helpers, which may store the credential
 for later use.
 
 If the action is `reject`, git-credential will send the description to
-any configured credential helpers, which may erase any stored
-credential matching the description.
+any configured credential helpers, which may erase stored credentials
+matching the description.
 
 If the action is `approve` or `reject`, no output should be emitted.
 
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 100f045bb1a..65d652dc40e 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -260,7 +260,7 @@ appended to its command line, which is one of:
 
 `erase`::
 
-	Remove a matching credential, if any, from the helper's storage.
+	Remove matching credentials, if any, from the helper's storage.
 
 The details of the credential will be provided on the helper's stdin
 stream. The exact format is the same as the input/output format of the
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 82f376d3351..5e3a766e42d 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -33,12 +33,12 @@ static void cache_credential(struct credential *c, int timeout)
 	e->expiration = time(NULL) + timeout;
 }
 
-static struct credential_cache_entry *lookup_credential(const struct credential *c, int match_password)
+static struct credential_cache_entry *lookup_credential(const struct credential *c)
 {
 	int i;
 	for (i = 0; i < entries_nr; i++) {
 		struct credential *e = &entries[i].item;
-		if (credential_match(c, e, match_password))
+		if (credential_match(c, e, 0))
 			return &entries[i];
 	}
 	return NULL;
@@ -48,9 +48,12 @@ static void remove_credential(const struct credential *c)
 {
 	struct credential_cache_entry *e;
 
-	e = lookup_credential(c, c->password != NULL);
-	if (e)
-		e->expiration = 0;
+	int i;
+	for (i = 0; i < entries_nr; i++) {
+		e = &entries[i];
+		if (credential_match(c, &e->item, c->password != NULL))
+			e->expiration = 0;
+	}
 }
 
 static timestamp_t check_expirations(void)
@@ -127,7 +130,7 @@ static void serve_one_client(FILE *in, FILE *out)
 	if (read_request(in, &c, &action, &timeout) < 0)
 		/* ignore error */ ;
 	else if (!strcmp(action.buf, "get")) {
-		struct credential_cache_entry *e = lookup_credential(&c, 0);
+		struct credential_cache_entry *e = lookup_credential(&c);
 		if (e) {
 			fprintf(out, "username=%s\n", e->item.username);
 			fprintf(out, "password=%s\n", e->item.password);
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index e0ae028b1c3..85b147e460f 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -36,7 +36,8 @@ static int parse_credential_file(const char *fn,
 			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
-				break;
+				if (strcmp(op, "erase"))
+					break;
 			}
 		}
 		else if (other_cb)
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index f7e4e29c5e1..3f4100b6ce2 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -45,6 +45,8 @@ helper_test_clean() {
 	reject $1 https example.com user2
 	reject $1 https example.com user4
 	reject $1 https example.com user5
+	reject $1 https example.com user6
+	reject $1 https example.com user7
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld
@@ -298,6 +300,37 @@ helper_test() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) erases all matching credentials" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user6
+		password=pass1
+		EOF
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user7
+		password=pass1
+		EOF
+		check reject $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		EOF
+		check fill $HELPER <<-\EOF
+		protocol=https
+		host=example.com
+		--
+		protocol=https
+		host=example.com
+		username=askpass-username
+		password=askpass-password
+		--
+		askpass: Username for '\''https://example.com'\'':
+		askpass: Password for '\''https://askpass-username@example.com'\'':
+		EOF
+	'
+
 	: ${GIT_TEST_LONG_CRED_BUFFER:=1024}
 	# 23 bytes accounts for "wwwauth[]=basic realm=" plus NUL
 	LONG_VALUE_LEN=$((GIT_TEST_LONG_CRED_BUFFER - 23))
-- 
gitgitgadget
