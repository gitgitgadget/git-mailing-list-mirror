Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18148C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 07:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjDCHrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 03:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCHrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 03:47:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1CA1FF5
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 00:47:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d17so28248847wrb.11
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680508029;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhuxQPhsHkVwqQPoyycwFCVUafz97/DxOxywtZR7M/4=;
        b=UFagaPoIQ5XNIIkeS6AZISRviEve5DiKVXRDG89PQzJKLFASZ2hjdCVqje3Ea04BHy
         N5y9AGzFmooJ2KTMV7pwp/6HwgI7ashsBnNqL6CZWYpxDXTyXTIg5z/EQAmehAan3GUw
         s/0mYm0uLCUxNWVVxatGgkuoko9UxZ0S9umfPtOBNnT5VHHEBCaJ656X2UpkuJ91ifuQ
         yP9YHS9SW2ssv18TB7b6EN8BNoPePn5X2vMqbd+0KWvj7BfkdqQ6nQwExy0/4H9DfkI+
         1Il882qmAvRUFmFJe4MU30PIiNU7a4QCd6m2WvbBqmJe/iUB8h4RLF4K3BeI/HPp3z32
         1ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508029;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhuxQPhsHkVwqQPoyycwFCVUafz97/DxOxywtZR7M/4=;
        b=rjn0NMatAzBaouuL9fz8+dP6QGkY3EcVY/jrJdjqqRkGRWdh9lh6aXNVRCj9AvfxzF
         zQJuGtlYWbjuCRBK2gmJG0EvG4Z+0iiBQwn0qQ72Q9xc5seX1cV1rN2xpD8VyWK0GqYD
         DOUCLINAf1adHLHSyTEwQv7DEkJyvf+p42fmA43tLb1Rh1hcpCB1Q5kTGzrBiA1vQwYn
         5f+rwMFpZlgZEnSJOzVDo6gpokCJQNn7Nq7NUeavQHBmmoclhvo/aUVBZI5QIZZm9JHP
         1sAwuXUOsZfZu7tm6+221x4VG7/+K7Bvg3NQyGcQNMEXQZbnTEJP2hPTR7vBkXKCLZUT
         wESw==
X-Gm-Message-State: AAQBX9dWd1NLXHhCvn+t4RRuL51r0Vp0WsLogVWpmR8lyP2YD60BWhE8
        W1pxl7+T+PlLpOW6t5Tq1MbrxF7gWgE=
X-Google-Smtp-Source: AKy350bXffvWZGW+g/Oli48n6jC/oay49rbvodGP5aIcZ/sJw8TnJwqlfJj9Kfesw1tD24xbaEITsQ==
X-Received: by 2002:a5d:400b:0:b0:2e6:dc6:2dcb with SMTP id n11-20020a5d400b000000b002e60dc62dcbmr5949988wrp.45.1680508029135;
        Mon, 03 Apr 2023 00:47:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2-20020adfe702000000b002d6f285c0a2sm9057041wrm.42.2023.04.03.00.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:47:08 -0700 (PDT)
Message-Id: <pull.1477.v3.git.git.1680508028077.gitgitgadget@gmail.com>
In-Reply-To: <pull.1477.v2.git.git.1680200278780.gitgitgadget@gmail.com>
References: <pull.1477.v2.git.git.1680200278780.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Apr 2023 07:47:07 +0000
Subject: [PATCH v3] credential/wincred: store password_expiry_utc
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

This attribute is important when storing OAuth credentials which may
expire after as little as one hour. d208bfdf (credential: new attribute
password_expiry_utc, 2023-02-18) added support for this attribute in
general so that individual credential backend like wincred can use it.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: store password_expiry_utc
    
    Windows users can test with the following commands:
    
    cd contrib/credential/wincred/ make printf
    'host=example.com\nprotocol=https\nusername=tim\npassword=xyzzy\npassword_expiry_utc=2000\n'
    | ./git-credential-wincred.exe store printf
    'host=example.com\nprotocol=https\n' | ./git-credential-wincred.exe get

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1477%2Fhickford%2Fwincred-expiry-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1477/hickford/wincred-expiry-v3
Pull-Request: https://github.com/git/git/pull/1477

Range-diff vs v2:

 1:  51a9039bd15 ! 1:  d2dff063eb4 credential/wincred: store password_expiry_utc
     @@ Commit message
          credential/wincred: store password_expiry_utc
      
          This attribute is important when storing OAuth credentials which may
     -    expire after as little as one hour. See
     -    https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b
     +    expire after as little as one hour. d208bfdf (credential: new attribute
     +    password_expiry_utc, 2023-02-18) added support for this attribute in
     +    general so that individual credential backend like wincred can use it.
      
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      


 .../wincred/git-credential-wincred.c          | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index ead6e267c78..7b4e7fae675 100644
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
@@ -195,6 +197,14 @@ static void get_credential(void)
 			write_item("password",
 				(LPCWSTR)creds[i]->CredentialBlob,
 				creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			for (int j = 0; j < creds[i]->AttributeCount; j++) {
+				attr = creds[i]->Attributes + j;
+				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
+					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
+					attr->ValueSize / sizeof(WCHAR));
+					break;
+				}
+			}
 			break;
 		}
 
@@ -204,6 +214,7 @@ static void get_credential(void)
 static void store_credential(void)
 {
 	CREDENTIALW cred;
+	CREDENTIAL_ATTRIBUTEW expiry_attr;
 
 	if (!wusername || !password)
 		return;
@@ -217,6 +228,14 @@ static void store_credential(void)
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
 
@@ -278,6 +297,8 @@ static void read_credential(void)
 			wusername = utf8_to_utf16_dup(v);
 		} else if (!strcmp(buf, "password"))
 			password = utf8_to_utf16_dup(v);
+		else if (!strcmp(buf, "password_expiry_utc"))
+			password_expiry_utc = utf8_to_utf16_dup(v);
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
@@ -292,7 +313,7 @@ int main(int argc, char *argv[])
 	    "usage: git credential-wincred <get|store|erase>\n";
 
 	if (!argv[1])
-		die(usage);
+		die("%s", usage);
 
 	/* git use binary pipes to avoid CRLF-issues */
 	_setmode(_fileno(stdin), _O_BINARY);

base-commit: 8d90352acc5c855620042fdcc6092f23a276af6d
-- 
gitgitgadget
