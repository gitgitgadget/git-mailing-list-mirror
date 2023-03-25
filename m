Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C138C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 07:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCYHj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCYHjY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 03:39:24 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670A196BB
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 00:39:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so2174183wms.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679729958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+ashQW7su37tkK5ponjsy/pDnQaQwbCxMkyhaXwzJX8=;
        b=dMu9jts+ymvAlGI2AK6xtEq8jCgFpxqcE618GcyRuicEtdwXIizGRfGsQLk4S90J6F
         yxnCs1sRAZ7AdhNQmcvqJ4XDt+c1Z34Pi49aPNqP3bKYuGv/i3pw/v43kne4buwXnrQr
         Nm7U734TxwnOAsvtXu/evN93R6M3db0KTUUHyH23xjqZRht9RmejhpDWwuYh1pE0gjCD
         vGAzgzh81cQ5GkZCrQlD5JWWMftadBX1LGUIOp+++igusW3mtzFT8ipiQO69GmwL/Jcd
         CVdIy5QVWrVeeqKQ14cVWbu2ZaFCANERt4uZDYAdqqh/+iQrH3qECMGqOxNPuB0CPaxu
         gv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679729958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ashQW7su37tkK5ponjsy/pDnQaQwbCxMkyhaXwzJX8=;
        b=h9H9De0VgnoYuP9DaN0XonfuaFixROy3UHC1I5WjWIMrqNqX0ytVe91KrTxZ4QZOZE
         EuhoU9CbNM8We5fVIDiRdhw9QN5qoNWrg8LKq04I9aNNq4YrV9D+eQe0OW+VPVh4xqiy
         jDLS1urzG+DNKjycRnqWnWlhl3OzyDCU8dYS4jl5DXXgoPt+0uIOdaHYWgPnfq1g2ymn
         ZHi56YX3MQ9gWNtujsup+3eAUeD88RHPj6N534a7qsDsyRGZ43jruwJzaOJUbUSKlEc7
         nTU+YkOC/PLvTqrcQncu3SGmWzKM7vuZTGxZ5k0tRE/8mVlMduXPiO8QdgOIqyK41y5b
         sfWw==
X-Gm-Message-State: AO0yUKUkGKKznaqcHP3j8uV3x2Cv1dUEkfMWxFwAV48u+zr0UIkyBaRT
        k4/P4DFGayw+WAP54eZtAHefl92zpyU=
X-Google-Smtp-Source: AK7set82UBypB1BlY7x78KR2ugt8W5fwHaqWEUsj110q6VyyHmSLbOWwTBeMrAhGSkQhMABi+vrI6Q==
X-Received: by 2002:a7b:c7ca:0:b0:3ee:97c:58f4 with SMTP id z10-20020a7bc7ca000000b003ee097c58f4mr3994306wmk.12.1679729957700;
        Sat, 25 Mar 2023 00:39:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8-20020a05600c218800b003ede06f3178sm7052343wme.31.2023.03.25.00.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:39:17 -0700 (PDT)
Message-Id: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Mar 2023 07:39:16 +0000
Subject: [PATCH] credential/wincred: store password_expiry_utc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Johannes Schindelin [ ]" <Johannes.Schindelin@gmx.de>,
        "Johannes Sixt [ ]" <j6t@kdbg.org>,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        Jakub =?UTF-8?Q?Bere=C5=BCa=C5=84ski?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: store password_expiry_utc
    
    Help wanted from a Windows user to test. I tried testing on Linux with
    Wine after cross-compiling [1] but Wine has incomplete support for
    wincred.h [2]. To test:
    
    cd contrib/credential/wincred/
    make
    echo host=example.com\nprotocol=https\nusername=tim\npassword=xyzzy\npassword_expiry_utc=2000 | ./git-credential-wincred.exe store
    echo host=example.com\nprotocol=https | ./git-credential-wincred.exe get
    
    
    Output of second command should include line password_expiry_utc=2000
    
    [1] make CC="zig cc -target x86_64-windows-gnu" [2]
    https://github.com/wine-mirror/wine/blob/bf9d15e3b1a29f73fedda0c34547a9b29d5e2789/dlls/advapi32/cred.c#L181-L186

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1477%2Fhickford%2Fwincred-expiry-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1477/hickford/wincred-expiry-v1
Pull-Request: https://github.com/git/git/pull/1477

 .../wincred/git-credential-wincred.c          | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index ead6e267c78..9be892610d0 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -91,7 +91,8 @@ static void load_cred_funcs(void)
 		die("failed to load functions");
 }
 
-static WCHAR *wusername, *password, *protocol, *host, *path, target[1024];
+static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
+	*password_expiry_utc;
 
 static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 {
@@ -183,6 +184,7 @@ static void get_credential(void)
 	CREDENTIALW **creds;
 	DWORD num_creds;
 	int i;
+	CREDENTIAL_ATTRIBUTEW *attr;
 
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
 		return;
@@ -195,6 +197,15 @@ static void get_credential(void)
 			write_item("password",
 				(LPCWSTR)creds[i]->CredentialBlob,
 				creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			attr = creds[i]->Attributes;
+			for (int j = 0; j < creds[i]->AttributeCount; j++) {
+				if (wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
+					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
+					attr->ValueSize / sizeof(WCHAR));
+					break;
+				}
+				attr++;
+			}
 			break;
 		}
 
@@ -204,6 +215,7 @@ static void get_credential(void)
 static void store_credential(void)
 {
 	CREDENTIALW cred;
+	CREDENTIAL_ATTRIBUTEW expiry_attr;
 
 	if (!wusername || !password)
 		return;
@@ -217,6 +229,14 @@ static void store_credential(void)
 	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
 	cred.AttributeCount = 0;
 	cred.Attributes = NULL;
+	if (password_expiry_utc != NULL) {
+		expiry_attr.Keyword = L"git_password_expiry_utc";
+		expiry_attr.Value = (LPVOID)password_expiry_utc;
+		expiry_attr.ValueSize = (wcslen(password_expiry_utc)) * sizeof(WCHAR);
+		expiry_attr.Flags = 0;
+		cred.Attributes = &expiry_attr;
+		cred.AttributeCount = 1;
+	}
 	cred.TargetAlias = NULL;
 	cred.UserName = wusername;
 
@@ -278,6 +298,8 @@ static void read_credential(void)
 			wusername = utf8_to_utf16_dup(v);
 		} else if (!strcmp(buf, "password"))
 			password = utf8_to_utf16_dup(v);
+		else if (!strcmp(buf, "password_expiry_utc"))
+			password_expiry_utc = utf8_to_utf16_dup(v);
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
@@ -292,7 +314,7 @@ int main(int argc, char *argv[])
 	    "usage: git credential-wincred <get|store|erase>\n";
 
 	if (!argv[1])
-		die(usage);
+		die("%s", usage);
 
 	/* git use binary pipes to avoid CRLF-issues */
 	_setmode(_fileno(stdin), _O_BINARY);

base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
-- 
gitgitgadget
