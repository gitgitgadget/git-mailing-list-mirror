Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52D2C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC3SSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjC3SSE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 14:18:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C61EB4A
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:18:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so12367619wms.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680200280;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW2b0gkEoWgAzQRMAra6MSBPsJEHQeC69ijeUNXCvDo=;
        b=QbVqsrdbpUGEtQ87huPqgDlcbHiTTfgKTWadpv3Ugdq9NvcenmzOlWR1jC3ZosP9UP
         W1f1LsezqVkPDOZscrMu37xEPJpPTFFVdRxvRNkvLETQjh0gwwL4c+Zai40l7R+lqBJj
         J+/8WX+PyI7B8QSjUPm1cuFgwSeLpP7Pu0T8Vn3rgIuCR127hTPSURqnMTBGObvTdTbo
         1ritiIhBcILfkir+9t3oPT7a2HQoamNnXurS5gEDxa4zPXv3MAWSIXW61ASFbkVNhCLx
         Wd3GPG4DLckf8S+wid9mRPxzaBhWCRUF/+8mdSY7Xo7uzBQNLxKTN9nwktcg/8UHlIT7
         EIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200280;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW2b0gkEoWgAzQRMAra6MSBPsJEHQeC69ijeUNXCvDo=;
        b=cDqesEK5cvteoKWMv8lSzZp6J22cK3b/JMwqa7n8aPURav1n6nqHTtOx71JlMcnOVV
         uB4zMmIEoEySOlw+g8S37OzQq4Qh239N/dZX4NNaoWZTWIorHcirFBzQmcneUl9afxES
         W1iPKTNEXv92dE3NReF42E51DdlsJr/RuonvXO9I05Oywkv5sgZ+dFMxCl6vquWevVd5
         dQWjryOq3M8k6DVnxCxS+fHkWDE8aF80q+7Ny9hgP9oxfEf4PCq0f/NPqZxDHtL2Dx+z
         fcf7lMfqh/b6KyM12eCQaw7yge5EVDJrfrIBybn9Q0yiqYlKxL9Vse3CEftmA3RuTyk5
         pO6A==
X-Gm-Message-State: AAQBX9d2iqPjuxJotAg7dftlfGeG/tGflBVVUyWOkiBszZlb9rFSFe6i
        dQV48BmvSRrCGWDMTsGOZVAvYKP857Y=
X-Google-Smtp-Source: AKy350bsrwHSTb7swOMXUmqkthqifdOz4Ziu8SfyT6XyyVKNHZwddSGtQyl9Hoj5z+SYnWNzTfpxew==
X-Received: by 2002:a05:600c:2144:b0:3ef:6396:d9b3 with SMTP id v4-20020a05600c214400b003ef6396d9b3mr14693271wml.18.1680200279685;
        Thu, 30 Mar 2023 11:17:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003ef5e5f93f5sm7096495wmq.19.2023.03.30.11.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:17:59 -0700 (PDT)
Message-Id: <pull.1477.v2.git.git.1680200278780.gitgitgadget@gmail.com>
In-Reply-To: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Mar 2023 18:17:58 +0000
Subject: [PATCH v2] credential/wincred: store password_expiry_utc
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
expire after as little as one hour. See
https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b

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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1477%2Fhickford%2Fwincred-expiry-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1477/hickford/wincred-expiry-v2
Pull-Request: https://github.com/git/git/pull/1477

Range-diff vs v1:

 1:  05340715ef2 ! 1:  51a9039bd15 credential/wincred: store password_expiry_utc
     @@ Metadata
       ## Commit message ##
          credential/wincred: store password_expiry_utc
      
     +    This attribute is important when storing OAuth credentials which may
     +    expire after as little as one hour. See
     +    https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b
     +
          Signed-off-by: M Hickford <mirth.hickford@gmail.com>
      
       ## contrib/credential/wincred/git-credential-wincred.c ##
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
       			write_item("password",
       				(LPCWSTR)creds[i]->CredentialBlob,
       				creds[i]->CredentialBlobSize / sizeof(WCHAR));
     -+			attr = creds[i]->Attributes;
      +			for (int j = 0; j < creds[i]->AttributeCount; j++) {
     -+				if (wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
     ++				attr = creds[i]->Attributes + j;
     ++				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
      +					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
      +					attr->ValueSize / sizeof(WCHAR));
      +					break;
      +				}
     -+				attr++;
      +			}
       			break;
       		}


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
