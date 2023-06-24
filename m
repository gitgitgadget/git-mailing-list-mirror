Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00597EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 08:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjFXIxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 04:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjFXIxB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 04:53:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533A918B
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 01:53:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f918922954so14769475e9.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 01:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687596778; x=1690188778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xrtpq7lg3Vc43CDx8tRi6/pydwAk1B9we78FNq5YpqM=;
        b=Ey2dwn92VyRDcr1LCy4oqrHoau6k8Bt7x2F1WpGrIzkP8P0UTou0GWzwSv4zVq7hGC
         AYOn4str7Fsl6051kSf8q5bV4SFl69OoVUVxIjgcX34QaZnbHs2fujXu9uTu8GG+Dmvd
         dpKaPiGzrGS2SIuooX8qovJ3W8aD61uaf6xAJ2wOykIoSrUOXObMOtTQxPb+HLAJAuDx
         bQLXLBWNWJlPcxeXk0BsaJRLga/ms/2JzLaCqhniONiBvGYl3j3ZWRt4YD/BYwlMh4wK
         scsxrLl0N07fflxCpVLKpfe4ACpM0J2UmrWtidjoJAZ+GgUDiQt7TaYeYW9nBFTEFzTZ
         WJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687596778; x=1690188778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrtpq7lg3Vc43CDx8tRi6/pydwAk1B9we78FNq5YpqM=;
        b=ZUnX76ISSmhbZ03i0qEKV5qniUG6ILEzSS6ER6owwR1KKty9aU6kAcfG9pAYMRRG4H
         UeX8/dlyDlw91lZNeiTGbl7bc9TeZR12L3lrx3aLh5b/pJ58tVGaU6LO1UYOcgZYBqlN
         ahE8xOFMLECvdGhY35DUdk91uFD20LjivJp2BMKM4xz0gN9unuHvxXlB+KJRpvuD8xEI
         rl6IncoTxvtLaXiiyq7d6vrRDrIbhmAP+jIfKQ0LxcTxc2HBG9dAb4IFIPDA6iN+ZQ6X
         yqKghu7whes6ZY9RN3V0leMpr6OcYa8X7xPdvjqEQjItT2YRCy7pYQqJOfEZCqqNx7/A
         d/KA==
X-Gm-Message-State: AC+VfDw8tC6B8PVYs7xLs6L1GSFnjuqrqYUiEkQOZdPS3OeLH5as6b1y
        g/F9IwrIBb09vGBRTSOXP8ZYHUcvSqY=
X-Google-Smtp-Source: ACHHUZ4D52MYDDAEQYq/r1Qi3OcXbGkm7ERYi1l6rjTK6Hu4YhtA1fFjVk7BS6wwlS3itqUpq4f16g==
X-Received: by 2002:a1c:4c05:0:b0:3fa:8272:5e03 with SMTP id z5-20020a1c4c05000000b003fa82725e03mr1068127wmf.26.1687596778231;
        Sat, 24 Jun 2023 01:52:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003f9c859894esm4549012wmc.7.2023.06.24.01.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 01:52:57 -0700 (PDT)
Message-Id: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 24 Jun 2023 08:52:56 +0000
Subject: [PATCH] credential/wincred: erase matching creds only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Fix test "helper ... does not erase a password distinct from input"
introduced in aeb21ce22e (credential: avoid erasing distinct password,
2023-06-13)

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: erase more carefully

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1529%2Fhickford%2Ffix-wincred-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1529/hickford/fix-wincred-v1
Pull-Request: https://github.com/git/git/pull/1529

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
 

base-commit: 6ff334181cfb6485d3ba50843038209a2a253907
-- 
gitgitgadget
