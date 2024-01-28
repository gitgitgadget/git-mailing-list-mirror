Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B33C068
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706477108; cv=none; b=N/MvwCgVuYV11Mmdb5R9igA8NNkfkOu1w9RSRSdttw8uS6eoeqOZUO3YyyZuPUsLbIkvNq1941kSudCwmFJdmEN6Yo/am8SKSIiDhZKmyR5HqXfzZHROATcMct9sLu2Bku8d6rL0Zcba4UVcKsfXu45xkfjPFZQNepHRw1qPUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706477108; c=relaxed/simple;
	bh=41sArTpUqH45OaFhbnWt5yyfhJadB+cWIk3vvhKSsSw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XXlQ4YFd8T233APB0riGfP3FNEeUMknUEN1aTd9CAsFrNt4lW4QqEis432BSL8kuzlTLvgmjoCqh+W/UB+cXG2xrJLCUFwytP8UzKE/KFXvPT93daXocE3L1XXMoY+csrkHkuuVphbnyd/RRTWjmByVu2xU6Bk+88nlKwbKJfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If/jjW5E; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If/jjW5E"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ae6dfa923so577382f8f.1
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 13:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706477104; x=1707081904; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVW7HBWhzmXo81UDrRq7/xb6bOm4LCywYwk2hq6jsWs=;
        b=If/jjW5EAxLs3hCgTXRqPjBXAHctgv6sG17IrkI35tUF9lnObpibdFdQGEtRsZlV+w
         5vl5m7DZKwDoLoGT5QTlAgt0MW+90y6QelHPXlUYAHLaPpW1H/GkJlqL0GpVXf8gHlWK
         DdiSgJy6lwl0gNeXsw/7lgRicLJgECI5mf3o7gAxAoITV3kDxCjbMtsJudSHWjTbZtMY
         Z6LZnYhp/fwEEiOuqL8rM/TTsEOtKa3y+LoXR94dZ8qKg75svXg3gVcwu6ImMSZc4DBv
         aAfQeEQsSBGkU5G/fV+ONK6aKlCCT8FK7qx1GJyHocI+i1V9dkGSab4ZpUgD1uHPymvT
         dNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706477104; x=1707081904;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVW7HBWhzmXo81UDrRq7/xb6bOm4LCywYwk2hq6jsWs=;
        b=s22Tzxgt41e6LJqOOFs7B3EHiJgU9KQRHKbkcSqZUWBhYMrT3c5EuRBP23cGfJPIi+
         1xBVW8M+1j41IRqULONKQLc3ks7XAzHdQo7mALjI9NipN43ZoCudRZF+Sd48vUoQp0yx
         ZGydvSLf+3me/1d8aguE3xRUuvGTMxjy3m+AhOyhaBytzaLpgyaMp4bnRXSjyv9zfhSX
         1XSuBHvbLhihtBwlUh4IbwRCv0i9O/9inCgfgQuLKc2k9CN1Ahov2BfXaGXLEn6wBpVq
         NyvOIyp1/Y7eV2VDdbAW/m2M1P4lU4k9CdfLr8Y3i+XNrF7T4ApBFxUeSv8282a6wgVy
         bABQ==
X-Gm-Message-State: AOJu0Yx6sqx1ekKPylGmipJJfq9aSGvUCp9ZDknxryNeatiI1mJfkUmO
	nQzEGqUmgmLScmUUSzwVJk1qWpY/vLe7dE0SgVtmig0vJcjFccIxXrknoVnC
X-Google-Smtp-Source: AGHT+IHn6ZvAgHjRAX0Gd4gL5ZMMvlaA6+hVslVvZHuVovbPXywLW3On1X4ecTF5103qMHZmOPPHVg==
X-Received: by 2002:adf:f644:0:b0:33a:e67f:cf8 with SMTP id x4-20020adff644000000b0033ae67f0cf8mr1967605wrp.20.1706477104341;
        Sun, 28 Jan 2024 13:25:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bj26-20020a0560001e1a00b0033ae6530969sm3563252wrb.85.2024.01.28.13.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 13:25:03 -0800 (PST)
Message-ID: <pull.1534.v3.git.1706477103039.gitgitgadget@gmail.com>
In-Reply-To: <pull.1534.v2.git.1699251395093.gitgitgadget@gmail.com>
References: <pull.1534.v2.git.1699251395093.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 21:25:02 +0000
Subject: [PATCH v3] credential/wincred: store oauth_refresh_token
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    git-for-windows@googlegroups.com,
    Jakub =?UTF-8?Q?Bere=C5=BCa=C5=84ski?= <kuba@berezanscy.pl>,
    patthoyts@gmail.com,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

a5c7656 (credential: new attribute oauth_refresh_token) introduced
a new confidential credential attribute and added support to
credential-cache. Later 0ce02e2f (credential/libsecret: store new
attributes, 2023-06-16) added support in credential-libsecret.

To add support in credential-wincred, we encode the new attribute in the
CredentialBlob, separated by newline:

    hunter2
    oauth_refresh_token=xyzzy

This is extensible and backwards compatible. The credential protocol
already assumes that attribute values do not contain newlines.

This fixes test "helper (wincred) gets oauth_refresh_token" when
t0303-credential-external.sh is run with
GIT_TEST_CREDENTIAL_HELPER=wincred. This test was added in a5c76569e7
(credential: new attribute oauth_refresh_token, 2023-04-21).

Alternatives considered: store oauth_refresh_token in a wincred
attribute. This would be insecure because wincred assumes attribute
values to be non-confidential.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: store oauth_refresh_token
    
    Patch v3 fixes a maybe-uninitialized warning.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1534%2Fhickford%2Fwincred-refresh-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1534/hickford/wincred-refresh-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1534

Range-diff vs v2:

 1:  12f092f45b1 ! 1:  a324c3aac41 credential/wincred: store oauth_refresh_token
     @@ Commit message
          credential/wincred: store oauth_refresh_token
      
          a5c7656 (credential: new attribute oauth_refresh_token) introduced
     -    a new confidential credential attribute for helpers to store.
     +    a new confidential credential attribute and added support to
     +    credential-cache. Later 0ce02e2f (credential/libsecret: store new
     +    attributes, 2023-06-16) added support in credential-libsecret.
      
     -    We encode the new attribute in the CredentialBlob, separated by
     -    newline:
     +    To add support in credential-wincred, we encode the new attribute in the
     +    CredentialBlob, separated by newline:
      
              hunter2
              oauth_refresh_token=xyzzy
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
      +					}
      +					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
      +				}
     ++				free(secret);
      +			} else {
      +				write_item("password",
      +						(LPCWSTR)creds[i]->CredentialBlob,
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
       			for (int j = 0; j < creds[i]->AttributeCount; j++) {
       				attr = creds[i]->Attributes + j;
       				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
     -@@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(void)
     - 					break;
     - 				}
     - 			}
     -+			free(secret);
     - 			break;
     - 		}
     - 
      @@ contrib/credential/wincred/git-credential-wincred.c: static void store_credential(void)
       {
       	CREDENTIALW cred;


 .../wincred/git-credential-wincred.c          | 46 ++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 4cd56c42e24..4be0d58cd89 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -35,7 +35,7 @@ static void *xmalloc(size_t size)
 }
 
 static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
-	*password_expiry_utc;
+	*password_expiry_utc, *oauth_refresh_token;
 
 static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 {
@@ -140,6 +140,11 @@ static void get_credential(void)
 	DWORD num_creds;
 	int i;
 	CREDENTIAL_ATTRIBUTEW *attr;
+	WCHAR *secret;
+	WCHAR *line;
+	WCHAR *remaining_lines;
+	WCHAR *part;
+	WCHAR *remaining_parts;
 
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
 		return;
@@ -149,9 +154,24 @@ static void get_credential(void)
 		if (match_cred(creds[i], 0)) {
 			write_item("username", creds[i]->UserName,
 				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
-			write_item("password",
-				(LPCWSTR)creds[i]->CredentialBlob,
-				creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			if (creds[i]->CredentialBlobSize > 0) {
+				secret = xmalloc(creds[i]->CredentialBlobSize);
+				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
+				line = wcstok_s(secret, L"\r\n", &remaining_lines);
+				write_item("password", line, line ? wcslen(line) : 0);
+				while(line != NULL) {
+					part = wcstok_s(line, L"=", &remaining_parts);
+					if (!wcscmp(part, L"oauth_refresh_token")) {
+						write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
+					}
+					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
+				}
+				free(secret);
+			} else {
+				write_item("password",
+						(LPCWSTR)creds[i]->CredentialBlob,
+						creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			}
 			for (int j = 0; j < creds[i]->AttributeCount; j++) {
 				attr = creds[i]->Attributes + j;
 				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
@@ -170,16 +190,26 @@ static void store_credential(void)
 {
 	CREDENTIALW cred;
 	CREDENTIAL_ATTRIBUTEW expiry_attr;
+	WCHAR *secret;
+	int wlen;
 
 	if (!wusername || !password)
 		return;
 
+	if (oauth_refresh_token) {
+		wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
+		secret = xmalloc(sizeof(WCHAR) * wlen);
+		_snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
+	} else {
+		secret = _wcsdup(password);
+	}
+
 	cred.Flags = 0;
 	cred.Type = CRED_TYPE_GENERIC;
 	cred.TargetName = target;
 	cred.Comment = L"saved by git-credential-wincred";
-	cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
-	cred.CredentialBlob = (LPVOID)password;
+	cred.CredentialBlobSize = wcslen(secret) * sizeof(WCHAR);
+	cred.CredentialBlob = (LPVOID)_wcsdup(secret);
 	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
 	cred.AttributeCount = 0;
 	cred.Attributes = NULL;
@@ -194,6 +224,8 @@ static void store_credential(void)
 	cred.TargetAlias = NULL;
 	cred.UserName = wusername;
 
+	free(secret);
+
 	if (!CredWriteW(&cred, 0))
 		die("CredWrite failed");
 }
@@ -265,6 +297,8 @@ static void read_credential(void)
 			password = utf8_to_utf16_dup(v);
 		else if (!strcmp(buf, "password_expiry_utc"))
 			password_expiry_utc = utf8_to_utf16_dup(v);
+		else if (!strcmp(buf, "oauth_refresh_token"))
+			oauth_refresh_token = utf8_to_utf16_dup(v);
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do

base-commit: b50a608ba20348cb3dfc16a696816d51780e3f0f
-- 
gitgitgadget
