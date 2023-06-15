Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17063EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFOTTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFOTTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 15:19:40 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A53D294C
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:19:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8c74af64fso21938925e9.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686856777; x=1689448777;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EBVh4bOb2FY3GI9F7fKz2zUMc7EwVw/9OOMhwmMIrI=;
        b=WHhGrgj1MUo/z8DYiJC+kkoa+bUUXwELnUpfcqlw0uOdBw+Fsp3X5YQ8j+UlwmDGNx
         IcAam/FOCALsQT0u16WhYu8KqDIyUAKShOybNfsfpO5lZMMmlNFZ6flLrIL4fY5gTDK7
         c2FgfvV1c5EquvTOazcy9xlKLGeSRuJYIYGw+AhQwO2GFnm3psPjsh1RT8FGorNaCuHM
         j5X436qMNhdQwRwWFXw53CijYKKL4BoO45SF4dnYWBDsTbqHA4EL0oIODz9vx1G7bj0I
         rNIDWPQa9PZK6Zynr/yWs0gdKPk3We2tuW3Q7EcGcstt2sS+EXjbE+ubKUvNzydZ1+qY
         RKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686856777; x=1689448777;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EBVh4bOb2FY3GI9F7fKz2zUMc7EwVw/9OOMhwmMIrI=;
        b=XlphzIbCBYgsVsInPbffpsMCLPqeSoEWCHFa5UrMSEQarinkeAVK2UIGy5cnxcvKdT
         HfaOSwTD20vQkkJ15dli2s/v+TgLFIYcLvdwFdQs9CS4CvCPQZk6vena4T/lnkQba1sX
         /9puUMHEV+mojTBSt5JoBJfRrNOKtQ1TCpg5DVkxZugU/e2SinhfAwGy5InGU3VBaqkq
         NCM3ApND3+5qg3Kwor/GL4gGKCE6yNRqmwEv/4rMFKPpRbBivuY6jGj+SZQ4V2dEH/o0
         Mvoj2pwN4Xldg3P79/LMy7AWtsDQSY1TVFcmIsJmNDbzEeY55HN1P7KbnaSsAqWrr659
         1+lg==
X-Gm-Message-State: AC+VfDxyh5BsPpYmEQwTI2e2fqP5sSx/hIxMN83Rc8HwyyJR+aVB5AxW
        REcAA4AU8SKk9NtmJoFs38XFF7cxXgA=
X-Google-Smtp-Source: ACHHUZ7URomYDMGHX5d2kRuNh5g2xAz+7qAFUEu49Sl66rEluDRmmbu76Ca21XLPFEC4pk5j0PtmCA==
X-Received: by 2002:a7b:c449:0:b0:3f4:a09f:1877 with SMTP id l9-20020a7bc449000000b003f4a09f1877mr116351wmi.23.1686856776384;
        Thu, 15 Jun 2023 12:19:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b003f7298a32ccsm21390324wmk.41.2023.06.15.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:19:35 -0700 (PDT)
Message-Id: <42f41b28e6e8738f5f6b425489578bc033b7cbe2.1686856773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
References: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
        <pull.1525.v4.git.git.1686856773.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 19:19:33 +0000
Subject: [PATCH v4 2/2] credential: erase all matching credentials
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

`credential reject` sends the erase action to each helper, but the
exact behaviour of erase isn't specified in documentation or tests.
Some helpers (such as credential-store and credential-libsecret) delete
all matching credentials, others (such as credential-cache) delete at
most one matching credential.

Test that helpers erase all matching credentials. This behaviour is
easiest to reason about. Users expect that `echo
"url=https://example.com" | git credential reject` or `echo
"url=https://example.com\nusername=tim" | git credential reject` erase
all matching credentials.

Fix credential-cache.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 Documentation/git-credential.txt   |  2 +-
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c | 15 ++++++++------
 t/lib-credential.sh                | 33 ++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 0e6d9e85ec7..a220afed4f3 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -39,7 +39,7 @@ for later use.
 
 If the action is `reject`, git-credential will send the description to
 any configured credential helpers, which may erase any stored
-credential matching the description.
+credentials matching the description.
 
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
index f64dd21d335..dc1cf2d25fc 100644
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
@@ -48,9 +48,12 @@ static void remove_credential(const struct credential *c, int match_password)
 {
 	struct credential_cache_entry *e;
 
-	e = lookup_credential(c, match_password);
-	if (e)
-		e->expiration = 0;
+	int i;
+	for (i = 0; i < entries_nr; i++) {
+		e = &entries[i];
+		if (credential_match(c, &e->item, match_password))
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
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 77baec53b6a..032b2d8fcc4 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -46,6 +46,8 @@ helper_test_clean() {
 	reject $1 https example.com user4
 	reject $1 https example.com user-distinct-pass
 	reject $1 https example.com user-overwrite
+	reject $1 https example.com user-erase1
+	reject $1 https example.com user-erase2
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
 	reject $1 https sso.tld
@@ -342,6 +344,37 @@ helper_test() {
 		EOF
 	'
 
+	test_expect_success "helper ($HELPER) erases all matching credentials" '
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-erase1
+		password=pass1
+		EOF
+		check approve $HELPER <<-\EOF &&
+		protocol=https
+		host=example.com
+		username=user-erase2
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
