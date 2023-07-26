Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F0AC001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 19:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjGZTv3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 15:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGZTv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 15:51:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EB21BD
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 12:51:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3176a439606so175310f8f.3
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690401084; x=1691005884;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHK6KHU4jGi9vuIZtmH3I3yBvjJyw+Vn7x4JGpVv5nU=;
        b=Cc2WLMuDk11Iejruh/b54lh+chhY1W0UDZp4hVu6U2tX+vkgglwS8w4ZrW2WuHL2RY
         eD5B+s62weI6cQXAs2m1sbrCn8cNAB58MO/GXJOiFys5JUGuQ8MW7Yb6g56Vn4YkF2KM
         KU4pQMvjg0y73QCl7110Y6DPLgrtCc2a2E1BkLE+SPZgavoWVTYqnxtCyrLt+9wOy8Hs
         pvMUKvUVy9qzrvlY6F6J+X2+twCbf8N+khw82o1H6M3k9+jrhhOzQX23UayJci/eurBS
         Grfr15XfIngsNP2y9SR1jEBoXhJeDCEcayI/5IfqJTFKKgH6V9NFuyqjaZJiLZbPdtDY
         +ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690401084; x=1691005884;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHK6KHU4jGi9vuIZtmH3I3yBvjJyw+Vn7x4JGpVv5nU=;
        b=iy3pGNkIv/LVkdfzuHlSW4B0kw70gC2JQ5FyK2VvUSdSyHm8vbM6fEHJD+snOkx28r
         ccQXqYSC+ScpNpCfeYEDsqUIc7hlpc2hB4AfOtVCywenbSNTtj3+kXwGmVj/J3+OpMsY
         RpNtpXEd2MlWLoDArLf7VKNdL8YRQfH9O8Ss6tMSzXz5W5Z4IoiwAZ4jEB/yqDGs+o0q
         Y6td/C/dGuud93ifXnAN/FVhjRVzCFSxJTz3mxM/TqJaPadNhXbO+qE0JyypJvj5/t8N
         4aRJNnDiOmTXJYVgPwPQ44eoHA5mljd/YzvbSvQ68E1rcjYipzl9atWAjXUlAnS0sNdv
         RQNg==
X-Gm-Message-State: ABy/qLav34pdqSIrD66DPA3O/lFs5BQsFWvAwh9MKQ5lT5fWsUD9QfO8
        SVwRmZfGOVBVXevpZttPjDWWB8738bM=
X-Google-Smtp-Source: APBJJlHxm2EZg+JZdm7dqlPh3mg4qJNw7a5fP6jgld/ZMyP/xHJrK+GmUO17AgqsFMja+mOHmAOu0A==
X-Received: by 2002:a05:6000:12cc:b0:314:1b6a:a095 with SMTP id l12-20020a05600012cc00b003141b6aa095mr81264wrx.23.1690401084583;
        Wed, 26 Jul 2023 12:51:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600011c700b00313fd294d6csm20662653wrx.7.2023.07.26.12.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 12:51:24 -0700 (PDT)
Message-ID: <pull.1529.v2.git.git.1690401082695.gitgitgadget@gmail.com>
In-Reply-To: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>
References: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 19:51:22 +0000
Subject: [PATCH v2] credential/wincred: erase matching creds only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Glen Choo <chooglen@google.com>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

The credential erase request typically includes protocol, host, username
and password.

credential-wincred erases stored credentials that match protocol,
host and username, regardless of password.

This is confusing in the case the stored password differs from that
in the request. This case can occur when multiple credential helpers are
configured.

Only erase credential if stored password matches request (or request
omits password).

This fixes test "helper (wincred) does not erase a password distinct
from input" when t0303 is run with GIT_TEST_CREDENTIAL_HELPER set to
"wincred". This test was added in aeb21ce22e (credential: avoid
erasing distinct password, 2023-06-13).

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: erase more carefully
    
    Patch v2 expands the commit message

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1529%2Fhickford%2Ffix-wincred-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1529/hickford/fix-wincred-v2
Pull-Request: https://github.com/git/git/pull/1529

Range-diff vs v1:

 1:  d45c61d8f79 ! 1:  5e2aae38f72 credential/wincred: erase matching creds only
     @@ Metadata
       ## Commit message ##
          credential/wincred: erase matching creds only
      
     -    Fix test "helper ... does not erase a password distinct from input"
     -    introduced in aeb21ce22e (credential: avoid erasing distinct password,
     -    2023-06-13)
     +    The credential erase request typically includes protocol, host, username
     +    and password.
     +
     +    credential-wincred erases stored credentials that match protocol,
     +    host and username, regardless of password.
     +
     +    This is confusing in the case the stored password differs from that
     +    in the request. This case can occur when multiple credential helpers are
     +    configured.
     +
     +    Only erase credential if stored password matches request (or request
     +    omits password).
     +
     +    This fixes test "helper (wincred) does not erase a password distinct
     +    from input" when t0303 is run with GIT_TEST_CREDENTIAL_HELPER set to
     +    "wincred". This test was added in aeb21ce22e (credential: avoid
     +    erasing distinct password, 2023-06-13).
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      


 .../wincred/git-credential-wincred.c          | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 96f10613aee..4cd56c42e24 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -109,7 +109,18 @@ static int match_part_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
 	return match_part_with_last(ptarget, want, delim, 1);
 }
 
-static int match_cred(const CREDENTIALW *cred)
+static int match_cred_password(const CREDENTIALW *cred) {
+	int ret;
+	WCHAR *cred_password = xmalloc(cred->CredentialBlobSize);
+	wcsncpy_s(cred_password, cred->CredentialBlobSize,
+		(LPCWSTR)cred->CredentialBlob,
+		cred->CredentialBlobSize / sizeof(WCHAR));
+	ret = !wcscmp(cred_password, password);
+	free(cred_password);
+	return ret;
+}
+
+static int match_cred(const CREDENTIALW *cred, int match_password)
 {
 	LPCWSTR target = cred->TargetName;
 	if (wusername && wcscmp(wusername, cred->UserName ? cred->UserName : L""))
@@ -119,7 +130,8 @@ static int match_cred(const CREDENTIALW *cred)
 		match_part(&target, protocol, L"://") &&
 		match_part_last(&target, wusername, L"@") &&
 		match_part(&target, host, L"/") &&
-		match_part(&target, path, L"");
+		match_part(&target, path, L"") &&
+		(!match_password || match_cred_password(cred));
 }
 
 static void get_credential(void)
@@ -134,7 +146,7 @@ static void get_credential(void)
 
 	/* search for the first credential that matches username */
 	for (i = 0; i < num_creds; ++i)
-		if (match_cred(creds[i])) {
+		if (match_cred(creds[i], 0)) {
 			write_item("username", creds[i]->UserName,
 				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
 			write_item("password",
@@ -196,7 +208,7 @@ static void erase_credential(void)
 		return;
 
 	for (i = 0; i < num_creds; ++i) {
-		if (match_cred(creds[i]))
+		if (match_cred(creds[i], password != NULL))
 			CredDeleteW(creds[i]->TargetName, creds[i]->Type, 0);
 	}
 

base-commit: a80be152923a46f04a06bade7bcc72870e46ca09
-- 
gitgitgadget
