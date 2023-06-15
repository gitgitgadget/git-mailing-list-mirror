Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F22EB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 06:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243648AbjFOGEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 02:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjFOGD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 02:03:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A026B9
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 23:03:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso9767107e87.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 23:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686809007; x=1689401007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUUI+b3f/SpIj2hu+kvoXUsTd3vD3GGQLD/VXaXAzrA=;
        b=LSAWny6tg5p6yV12vyAnjlmKfJhkC4NlHyOi6UqVBVzJpzEgLEGJAc3yLpKiW9ipNI
         EELP89ZlnyKBM6g8cNW5+cCHEBk8xr00gzN1Hy0keCUEF5rCd1bD4Pxepz8KMZV9+SzA
         eooBlIsksu8zaNjJBAFTz2NHVBKbdfBvY9pvHuCxpuc/Q5F9J6BOo4Ae4CRmLqBBp9ir
         OSYXNDh1bXisTvIa5+ShZnuhMjbNdmqCKnB65LdIXx65z+wxaZkmZlqxIqgiXVnqS/Ej
         ERhDFF2YEm5LXRhagwHeOaHLdSlM3Y8zewER1bMGHwkv/NZl81n04s9KBo6CVvTW2W69
         xdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686809007; x=1689401007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUUI+b3f/SpIj2hu+kvoXUsTd3vD3GGQLD/VXaXAzrA=;
        b=LCKs7XJkvlfVkZoGfYL1Mv/tfG6laHd5AdRl5+GAKkN6dL3jkHyg8tkpx2UFYADk+6
         fmKfxgV2imY4t5oiAHaF07lupxRnfXwiy7e8ISRqI/bLcwMSF1pdmp3mq7I+sBJ38yvy
         JPyQx9Xs1EchRzcxnMJ5Yn1uXRrFlVByz4OUjZtzOyoA4e5+RzE/Eign/YCuUT2936lw
         QxnfBf2LtRJB+F2z68p1AkxVv73G9BmORKfpLlVIcJXzFfVjrbWCZ23p+zuMGIDpGtrx
         plkp8akQpFwwoXAy9WkHY5pdG6i5a3fCN42CGYORE2C9Pha46rLI9bkyNOZedFRxtLoF
         Qt2g==
X-Gm-Message-State: AC+VfDwxJOCokKBxDcQL0hQ4Mtf022nGzBxwnbKKyzctQxGEYUiwEgi9
        kAU1h9L1tcOvmeN3UlcVTkNkmnPOZqw=
X-Google-Smtp-Source: ACHHUZ4IssECYVUDbrHKEUlOcz9qNLqqauyH4xrxiynLX1pgTH7p0kqguYfF3n46QtBAzinNTt3n9g==
X-Received: by 2002:a19:6916:0:b0:4f4:ce78:2f17 with SMTP id e22-20020a196916000000b004f4ce782f17mr7873079lfc.13.1686809006913;
        Wed, 14 Jun 2023 23:03:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000194a00b0030497b3224bsm20005179wry.64.2023.06.14.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 23:03:26 -0700 (PDT)
Message-Id: <e06d80e99a00c30fb8430afcd457576bb0bf9ce5.1686809004.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
        <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 06:03:24 +0000
Subject: [PATCH v3 2/2] credential: erase all matching credentials
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
Some helpers (such as credential-libsecret) delete all matching
credentials, others (such as credential-cache and credential-store)
delete at most one matching credential.

Test that helpers erase all matching credentials. This behaviour is
easiest to reason about. Users expect that `echo
"url=https://example.com" | git credential reject` or `echo
"url=https://example.com\nusername=tim" | git credential reject` erase
all matching credentials.

Fix credential-cache and credential-store.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 Documentation/git-credential.txt   |  2 +-
 Documentation/gitcredentials.txt   |  2 +-
 builtin/credential-cache--daemon.c | 15 ++++++++------
 builtin/credential-store.c         |  1 -
 t/lib-credential.sh                | 33 ++++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 9 deletions(-)

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
diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index f80ff59f18a..06bbfa4dd03 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -35,7 +35,6 @@ static int parse_credential_file(const char *fn,
 			found_credential = 1;
 			if (match_cb) {
 				match_cb(&entry);
-				break;
 			}
 		}
 		else if (other_cb)
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 7b4fdd011d7..3f21ba66929 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -45,6 +45,8 @@ helper_test_clean() {
 	reject $1 https example.com user2
 	reject $1 https example.com user4
 	reject $1 https example.com user5
+	reject $1 https example.com user6
+	reject $1 https example.com user7
 	reject $1 https example.com user8
 	reject $1 http path.tld user
 	reject $1 https timeout.tld user
@@ -342,6 +344,37 @@ helper_test() {
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
