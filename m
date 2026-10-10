Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74018400987
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791632856; cv=none; b=gmY/uAb2MMT/jMLpHgSpOzLfYWA3JxndOXtXaOxpuelFTEEoWP56/g6XvojE+w2/Y51ZRUm51CSiXh9TIzEfjrzv7UVZdxaxVQGlJ5Cxo0aKrbZ2i/tvEDli44b7Pi02QFELpfXtNSL0LYfy8NcNQBXU7zXasGXD1jIJSo0xqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791632856; c=relaxed/simple;
	bh=MzRTc46H8r3x4yJP3MoJ1NrGdbXCoX9TKu2PFc0Ylqs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OBsZckcytOie830CvFMrSwROqxVuNfipJWputI890QIbl88hB1vG/1x7bR5EG+9+QgQO6+u6FYU+Os/OJPZ2MzSzz/Std1EYWo9eue5Y6YgVBXv4EtCbz4CK6a0iXQbnw8zTfuBzU6XoFWJ02udt5Ys6tz3FQ6xl64m239NuPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKqOXLf3; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKqOXLf3"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917a707f37eso8941356d6.0
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791632853; x=1792237653; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XldB7IN8053cu4ZYeA/ai5y8stMIzxTXkQORdY6YMs0=;
        b=DKqOXLf3jrbCnGjLOwkIlYWjg9smhn6RmyW7pOxYmsLB80dzSK3nnTEWzoDpCyXqG7
         7TBsyrBSjxCqvW7AEKJ4bY03UOts1LRdtErwAu4JyJdgbDrLMlIqTXrA9R9c36kHIPcc
         Zivb5+3eCWoYuA4zgqDQjVwwHHKmw76m2Q6geUZtrfxspL+W3RgcS4UT2SkhaNsb+4Dd
         woM7lWT9caaGZ1WVkOAzJlUqkcHdVH9yo626F1MvleGiVRPTgkVtww+ZUeTs0xp6xDuE
         vCOjbBEAplSGY8F4ep7r+zMPHSq7ykfDvok4j/P1ivTh7sePy5ejqgNVFitbfpuGjI9o
         B9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791632853; x=1792237653;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XldB7IN8053cu4ZYeA/ai5y8stMIzxTXkQORdY6YMs0=;
        b=Tnz7tVOAffXSXvzdJVrZL9oTmBty0XGiU2tKv/s7y63Ev4gZB2fGNBcrP8zXLYPBao
         i/t4SXGHADPMifSfSSPNg5ESP3uy/CUQFegILzjRngiDDKE8tdqtaUcEIY+vkx6HZCAb
         nMhDEQPhE07Yv0ugaWsxACUzsBD1h+k6uxsTXZnr2V02djLkZW3zAyzW4Voj80Pi/zxo
         Mjw3lN9d3BBSlj0QMUSAY8wwAIhFr7GnPZgc0AE+MWOXmSUfVLOLHb7bRDcZpnSKqIqL
         2XwVz1uQshCDA3xkOHDXGFCqOmOiSPyTeBK/8r9dfbU3KndzwvJ/CLSEo2jUqaFHb77q
         nE1g==
X-Gm-Message-State: AFq9FYJlvTRMB7tGr07+dhHQtWUESOAyAg6UxYwAlalXHRReQT24VG7X
	WDQ31k6DvrksZwWkdfmRWEofQLDM/aGPb/u5JvFdHexHoPHAjb5IO1Nw1HfNSg==
X-Gm-Gg: AYBFou2Fd5sToVrdmvXITHGSLypFTpyvvRSKEDOWMeCroADiGUW9NbIRgN9a8cAZa5D
	QbDgpyfGLikg6gfcEIP1twwOI21aYmbmajoh9n3wB7xVlTiLkDO76izZbJ+XqQCkBTPe/ptOa9H
	qf38MKhM6tnGKxpJhBOlW28FJfOf/eThEAhsIZdlfds5uO3tJyIZtAI9uSo0xstsVaBZl8N+RH3
	ajcLLJcLscgGKvtZ0Cs54GMpM0cqizAGqEA4I3ECcK8W2G3yf7RboW0hpmTuPJkrc39pqtc0PYi
	BaN6OJ71v8n31N+Ze4/JbpdfSJxrf2Z6atBgLJNP0iIowwiUDOCxGS0uSNrdituDNoBQS9PCAX0
	rx5dMIqUYe13Q5Ihkrqjrv8xeLj9rFVeI2nUOcF/9d4zwGZHwCIS+yTjQI9mGqE4dYq/Z6wmoES
	B0ZPaJ8aGRcNiC1Yzr73bZWkRIInYZ/eZU8B61gy59bVGT7EQa/18LVHeyhQNmSeXEfMmMYq74
X-Received: by 2002:a05:6214:500a:b0:917:98b6:bd02 with SMTP id 6a1803df08f44-91b553489dbmr81772826d6.1.1791632852103;
        Sat, 10 Oct 2026 04:47:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.95.51])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550ddf7csm42736086d6.42.2026.10.10.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 04:47:31 -0700 (PDT)
Message-Id: <pull.2251.v2.git.1791632850780.gitgitgadget@gmail.com>
In-Reply-To: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
References: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Oct 2026 11:47:30 +0000
Subject: [PATCH v2] wincred: refactor credential blob processing
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
Cc: Marc Becker <becm@gmx.de>,
    Marc Becker <becm@gmx.de>

From: Marc Becker <becm@gmx.de>

Invalid target size check (bytes instead of characters) for `wcsncpy_s`
already led to memory corruption; d22a4884 just hid the error by making
sure the target is always big enough.
Single invocation of `wcstok_s` only cuts out first hit delimiter.
Consecutive items would always start with a line feed character if
separation consists of CRLF.
Only exception is 1st item (due to following bug).
Advancement to end of password line is missing. Password value is reused
as extended credential item but likely filtered out due to value
mismatch with accepted key.

Line split needs to be deterministic and code should be split up into
smaller blocks.

Create separate methods for writing credential items and the complete
credential blob content to tighten code in main credential loop.
Reduce variable scope and nesting level. Use early continue/return to
improve code readability.
Use `wmemchr` to reliably detect wide-character-newline in immutable
blob data without need to create a further copy.

Signed-off-by: Marc Becker <becm@gmx.de>
---
    wincred: fix line split of secret blob content
    
    Changes since v1:
    
     * move credential blob dissection and output to separate methods
       (maintainer request)
     * mark character constants as wide char
     * consistently treat sizes/lengths as (wide) character count

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2251%2Fbecm%2Ffix-wincred-secret-linesplit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2251/becm/fix-wincred-secret-linesplit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2251

Range-diff vs v1:

 1:  fb80cfc32a ! 1:  01a1039f70 wincred: fix line split of secret blob content
     @@ Metadata
      Author: Marc Becker <becm@gmx.de>
      
       ## Commit message ##
     -    wincred: fix line split of secret blob content
     +    wincred: refactor credential blob processing
      
     -    operate on immutable blob data (wcsncpy_s still had invalid target size)
     -    split on newline character to avoid bleed-over on multi-line content
     +    Invalid target size check (bytes instead of characters) for `wcsncpy_s`
     +    already led to memory corruption; d22a4884 just hid the error by making
     +    sure the target is always big enough.
     +    Single invocation of `wcstok_s` only cuts out first hit delimiter.
     +    Consecutive items would always start with a line feed character if
     +    separation consists of CRLF.
     +    Only exception is 1st item (due to following bug).
     +    Advancement to end of password line is missing. Password value is reused
     +    as extended credential item but likely filtered out due to value
     +    mismatch with accepted key.
     +
     +    Line split needs to be deterministic and code should be split up into
     +    smaller blocks.
     +
     +    Create separate methods for writing credential items and the complete
     +    credential blob content to tighten code in main credential loop.
     +    Reduce variable scope and nesting level. Use early continue/return to
     +    improve code readability.
     +    Use `wmemchr` to reliably detect wide-character-newline in immutable
     +    blob data without need to create a further copy.
      
          Signed-off-by: Marc Becker <becm@gmx.de>
      
     @@ contrib/credential/wincred/git-credential-wincred.c
       #include <wincred.h>
       
       /* common helpers */
     +@@ contrib/credential/wincred/git-credential-wincred.c: static void write_item(const char *what, LPCWSTR wbuf, int wlen)
     + 	free(buf);
     + }
     + 
     ++/*
     ++ * Write known credential item.
     ++ */
     ++static void write_credential_item(LPCWSTR data, int wlen)
     ++{
     ++	static const LPCWSTR refresh_token = L"oauth_refresh_token";
     ++	LPCWSTR value;
     ++	DWORD klen;
     ++	DWORD vlen;
     ++
     ++	/* find key/value separator for credential item */
     ++	if ((value = wmemchr(data, L'=', wlen)) == NULL)
     ++		return;
     ++	klen = value++ - data;
     ++	vlen = wlen - klen - 1;
     ++
     ++	/* write items known to git credential protocol */
     ++	if (klen == wcslen(refresh_token) && wmemcmp(data, refresh_token, klen) == 0)
     ++		write_item("oauth_refresh_token", value, vlen);
     ++}
     ++
     ++/*
     ++ * Write single credential block
     ++ * consisting of password and further (accepted) credential items.
     ++ */
     ++static void write_credential(const CREDENTIALW *cred)
     ++{
     ++	LPCWSTR end;
     ++	DWORD length;
     ++	LPCWSTR blob = (LPCWSTR)cred->CredentialBlob;
     ++	DWORD wlen = cred->CredentialBlobSize / sizeof(WCHAR);
     ++
     ++	/* check if content is single line */
     ++	if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
     ++		write_item("password", blob, wlen);
     ++		return;
     ++	}
     ++	/* determine current line length and remaining data size */
     ++	length = end++ - blob;
     ++	wlen -= length + 1;
     ++
     ++	/* skip carriage return at line end */
     ++	if (length && blob[length - 1] == L'\r')
     ++		--length;
     ++	write_item("password", blob, length);
     ++
     ++	while (1) {
     ++		/* key/value content starts on next line */
     ++		blob = end;
     ++
     ++		/* find line end */
     ++		if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
     ++			write_credential_item(blob, wlen);
     ++			return;
     ++		}
     ++		/* determine current line length and remaining data size */
     ++		length = end++ - blob;
     ++		wlen -= length + 1;
     ++
     ++		// skip carriage return at line end
     ++		if (length && blob[length - 1] == L'\r')
     ++			--length;
     ++		write_credential_item(blob, length);
     ++	}
     ++}
     ++
     + /*
     +  * Match an (optional) expected string and a delimiter in the target string,
     +  * consuming the matched text by updating the target pointer.
      @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(void)
       {
       	CREDENTIALW **creds;
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
       
      -	/* search for the first credential that matches username */
      -	for (i = 0; i < num_creds; ++i)
     -+	/* search for the first credential that matches target and username */
     -+	for (int i = 0; i < num_creds; ++i) {
     - 		if (match_cred(creds[i], 0)) {
     +-		if (match_cred(creds[i], 0)) {
      -			write_item("username", creds[i]->UserName,
      -				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
      -			if (creds[i]->CredentialBlobSize > 0) {
     @@ contrib/credential/wincred/git-credential-wincred.c: static void get_credential(
      -					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
      -				}
      -				free(secret);
     -+			LPCWSTR username = creds[i]->UserName;
     -+			LPCWSTR blob = (LPCWSTR)creds[i]->CredentialBlob;
     -+			LPCWSTR end;
     -+			DWORD wlen;
     -+
     -+			write_item("username", username, username ? wcslen(username) : 0);
     -+
     -+			wlen = creds[i]->CredentialBlobSize / sizeof(WCHAR);
     -+
     -+			// check if content is single line
     -+			if ((end = wmemchr(blob, '\n', wlen)) == NULL) {
     -+				write_item("password", blob, wlen);
     - 			} else {
     +-			} else {
      -				write_item("password",
      -						(LPCWSTR)creds[i]->CredentialBlob,
      -						creds[i]->CredentialBlobSize / sizeof(WCHAR));
     -+				DWORD length = end++ - blob;
     +-			}
     +-			for (int j = 0; j < creds[i]->AttributeCount; j++) {
     +-				attr = creds[i]->Attributes + j;
     +-				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
     +-					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
     +-					attr->ValueSize / sizeof(WCHAR));
     +-					break;
     +-				}
     ++	/* search for the first credential that matches target and username */
     ++	for (int i = 0; i < num_creds; ++i) {
     ++		LPCWSTR username;
      +
     -+				// correct remaining size and drop carriage return at line end
     -+				wlen -= length + 1;
     -+				if (length && blob[length - 1] == '\r') {
     -+					--length;
     -+				}
     -+				write_item("password", blob, length);
     ++		if (!match_cred(creds[i], 0))
     ++			continue;
      +
     -+				// key/value content starting on next line
     -+				blob = end;
     -+				do {
     -+					LPCWSTR value;
     ++		username = creds[i]->UserName;
     ++		write_item("username", username, username ? wcslen(username) : 0);
      +
     -+					// find line end
     -+					if ((end = wmemchr(blob, '\n', wlen)) == NULL) {
     -+						length = wlen;
     -+					} else {
     -+						length = end++ - blob;
     -+						// correct remaining size and drop carriage return at line end
     -+						wlen -= length + 1;
     -+						if (length && blob[length - 1] == '\r') {
     -+							--length;
     -+						}
     -+					}
     -+					// find key/value separator for extended credential info
     -+					if ((value = wmemchr(blob, '=', length)) != NULL) {
     -+						static const LPCWSTR refresh = L"oauth_refresh_token";
     -+						DWORD klen = value - blob;
     ++		write_credential(creds[i]);
      +
     -+						// write entries known to git credential protocol
     -+						if (klen == wcslen(refresh) && memcmp(blob, refresh, klen) == 0) {
     -+							write_item("oauth_refresh_token", value + 1, length - klen - 1);
     -+						}
     -+					}
     -+				} while ((blob = end));
     - 			}
     - 			for (int j = 0; j < creds[i]->AttributeCount; j++) {
     --				attr = creds[i]->Attributes + j;
     -+				CREDENTIAL_ATTRIBUTEW *attr = creds[i]->Attributes + j;
     ++		for (int j = 0; j < creds[i]->AttributeCount; j++) {
     ++			CREDENTIAL_ATTRIBUTEW *attr = creds[i]->Attributes + j;
      +
     - 				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
     --					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
     --					attr->ValueSize / sizeof(WCHAR));
     -+					write_item("password_expiry_utc", (LPCWSTR)attr->Value, attr->ValueSize / sizeof(WCHAR));
     - 					break;
     - 				}
     ++			if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
     ++				write_item("password_expiry_utc", (LPCWSTR)attr->Value, attr->ValueSize / sizeof(WCHAR));
     ++				break;
       			}
     - 			break;
     +-			break;
       		}
      -
     ++		break;
      +	}
       	CredFree(creds);
       }


 .../wincred/git-credential-wincred.c          | 126 ++++++++++++------
 1 file changed, 87 insertions(+), 39 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 22eb27ca31..cd72e71ecd 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
+#include <wchar.h>
 #include <wincred.h>
 
 /* common helpers */
@@ -69,6 +70,72 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 	free(buf);
 }
 
+/*
+ * Write known credential item.
+ */
+static void write_credential_item(LPCWSTR data, int wlen)
+{
+	static const LPCWSTR refresh_token = L"oauth_refresh_token";
+	LPCWSTR value;
+	DWORD klen;
+	DWORD vlen;
+
+	/* find key/value separator for credential item */
+	if ((value = wmemchr(data, L'=', wlen)) == NULL)
+		return;
+	klen = value++ - data;
+	vlen = wlen - klen - 1;
+
+	/* write items known to git credential protocol */
+	if (klen == wcslen(refresh_token) && wmemcmp(data, refresh_token, klen) == 0)
+		write_item("oauth_refresh_token", value, vlen);
+}
+
+/*
+ * Write single credential block
+ * consisting of password and further (accepted) credential items.
+ */
+static void write_credential(const CREDENTIALW *cred)
+{
+	LPCWSTR end;
+	DWORD length;
+	LPCWSTR blob = (LPCWSTR)cred->CredentialBlob;
+	DWORD wlen = cred->CredentialBlobSize / sizeof(WCHAR);
+
+	/* check if content is single line */
+	if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
+		write_item("password", blob, wlen);
+		return;
+	}
+	/* determine current line length and remaining data size */
+	length = end++ - blob;
+	wlen -= length + 1;
+
+	/* skip carriage return at line end */
+	if (length && blob[length - 1] == L'\r')
+		--length;
+	write_item("password", blob, length);
+
+	while (1) {
+		/* key/value content starts on next line */
+		blob = end;
+
+		/* find line end */
+		if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
+			write_credential_item(blob, wlen);
+			return;
+		}
+		/* determine current line length and remaining data size */
+		length = end++ - blob;
+		wlen -= length + 1;
+
+		// skip carriage return at line end
+		if (length && blob[length - 1] == L'\r')
+			--length;
+		write_credential_item(blob, length);
+	}
+}
+
 /*
  * Match an (optional) expected string and a delimiter in the target string,
  * consuming the matched text by updating the target pointer.
@@ -148,51 +215,32 @@ static void get_credential(void)
 {
 	CREDENTIALW **creds;
 	DWORD num_creds;
-	int i;
-	CREDENTIAL_ATTRIBUTEW *attr;
-	WCHAR *secret;
-	WCHAR *line;
-	WCHAR *remaining_lines;
-	WCHAR *part;
-	WCHAR *remaining_parts;
 
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
 		return;
 
-	/* search for the first credential that matches username */
-	for (i = 0; i < num_creds; ++i)
-		if (match_cred(creds[i], 0)) {
-			write_item("username", creds[i]->UserName,
-				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
-			if (creds[i]->CredentialBlobSize > 0) {
-				secret = xmalloc(creds[i]->CredentialBlobSize + sizeof(WCHAR));
-				wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
-				line = wcstok_s(secret, L"\r\n", &remaining_lines);
-				write_item("password", line, line ? wcslen(line) : 0);
-				while(line != NULL) {
-					part = wcstok_s(line, L"=", &remaining_parts);
-					if (!wcscmp(part, L"oauth_refresh_token")) {
-						write_item("oauth_refresh_token", remaining_parts, remaining_parts ? wcslen(remaining_parts) : 0);
-					}
-					line = wcstok_s(NULL, L"\r\n", &remaining_lines);
-				}
-				free(secret);
-			} else {
-				write_item("password",
-						(LPCWSTR)creds[i]->CredentialBlob,
-						creds[i]->CredentialBlobSize / sizeof(WCHAR));
-			}
-			for (int j = 0; j < creds[i]->AttributeCount; j++) {
-				attr = creds[i]->Attributes + j;
-				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
-					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
-					attr->ValueSize / sizeof(WCHAR));
-					break;
-				}
+	/* search for the first credential that matches target and username */
+	for (int i = 0; i < num_creds; ++i) {
+		LPCWSTR username;
+
+		if (!match_cred(creds[i], 0))
+			continue;
+
+		username = creds[i]->UserName;
+		write_item("username", username, username ? wcslen(username) : 0);
+
+		write_credential(creds[i]);
+
+		for (int j = 0; j < creds[i]->AttributeCount; j++) {
+			CREDENTIAL_ATTRIBUTEW *attr = creds[i]->Attributes + j;
+
+			if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
+				write_item("password_expiry_utc", (LPCWSTR)attr->Value, attr->ValueSize / sizeof(WCHAR));
+				break;
 			}
-			break;
 		}
-
+		break;
+	}
 	CredFree(creds);
 }
 

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
