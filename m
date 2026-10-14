Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55486568FA3
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001788; cv=none; b=m5YK/LbyGBbTO32sx8N5qoroz6x/gPKa3yno8RlO2/eTHrhbvG8TVAWkj/5GqsFo2jDSU4Ar2zn6sh+IyRUcYD1rx6P0VeKKdUHwS3I1bfKp3t3DmlZVNXgN6MIamOvo2w8nDypjWMedv1bLU5EETkmnmNkgDpA6fn7UcENRg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001788; c=relaxed/simple;
	bh=KZDERoPSzgwHlclhQn1s3pKhXs0NbEATLDRpexdIsP4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u/BuuiXRxjm7JPRn30p5QusR4GFIiCNoEUubdNIBZHjf1qP4IrTqlrwXFq/yOJTpbrhFDANvpDsUmJgJfIxS3e0wG9DboYBy7dNICKAYe/bV2BZT2lv26JGV33lDWy7D8WHJ8H3IrEojWTgLo2rP+wVM02S23zSL+rjq0XVqJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCXQhmtw; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCXQhmtw"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-354ba08cfd1so7406712eec.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792001786; x=1792606586; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OQG3S9uiozi+ko2w5M5s3mgnZ3sZYzc8fDMNih9R6L8=;
        b=eCXQhmtw5JwF5Dlu1fV+YR5pOrsB7jPNnIeXcQ+wTEYV38QkF0s047TAKE3Pwuh2JM
         r4W9c7wXNiXePEZs/EGDatF1F/mVcw9bX32oYR5cXRYCriojyi3N3uE+OpvYHICuJUjO
         VImkaSKDy7OgnLUu0N9Gq/fFGJ3oScEbY4AjGNndLaVqp++yAy/F0NmW5ZSBRhilbILt
         Q41l7RMVwKU3C95sz+0bNealy0OJB2kmwRjc3j1hPOLZdeFoZrrVzHndeczsiZ5iSvGP
         y31mHYTISO2iUJgfZt74GM8/2Rpx+sxDt8oPd8AeYW9gYfDySukfGxYPSaIck9MLo63y
         vqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001786; x=1792606586;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQG3S9uiozi+ko2w5M5s3mgnZ3sZYzc8fDMNih9R6L8=;
        b=p2ghAWfjBYxq8ZT2sDpIOZk652yp8gb9vtrqv1enWaWfPyJ7WksVb1VYW2PZMMs8kq
         Ia59GT84qFtqBMsSRRj48Clp1KyAn+Nm2Vc2I4hgzcX/CgJcREj8lK6qVTgbKd4Z8GCu
         DAEq5FsNkbLOQmEQL8dQ1DdUbe5hbSDBnU+ukbr/LX+pEAqyL1sk9irVqclKBUZx4pZm
         UhC9SwuVK0DQ1bWMA97rvvU0ZusQKf+cySp+esBgC1nPp6RfenhEhZ0HeUQOZpPp0h+t
         +mlm8ZV6zD2Nb8Aw3qTQbeHyCbGwlMQwPF1lRzo5Oi0zchABFMcWPi7qqasg9qT++Ert
         LVUg==
X-Gm-Message-State: AFq9FYJXdD/4hV0tjHyxXSOhxPUuvJIetpWvqinFJ13W1KpDFeIjg4Vq
	7QZkIbNW774zC5k0jpsGzJbPIHLnm6Hm/P03Xh4sbKv3cGWHXolxWrrLhzFRqw==
X-Gm-Gg: AYBFou26aVbAs8MUIn8dehv80aPSq8ut4b4sOmRccyfV6MmxbtbPo0aJpAwJXgVZcUH
	nmNIwsueAX91pI/CjwYofG78k+8yq4hppXWtdnCv9uyDfF7X0SxDdTsmkap3oEMW1ikPM1PFc+6
	MjS+NSltqLQVwXrC7mN5gTxtfSmIpa2CGDzMP9FaZUDPcyHozip1uv3ke4OwNocbXMbFG8b5tBM
	hPhb1NdypwenbEET1Xg/1VWodEdTBiOMHvMFeXMKk+SC8/q00JAjiTRH2IFp1ZxjnH0yIAqVz8p
	+DmaaBjbDGniNpDNxdyjUnRkyvCKoU3qCBLNymZdk3StXlYOP/XWDYqlytuQRZbKxRdj+uT8GlW
	NRZ1aJE7PqZ18wFLk0T83iEG/8AN0hZ4fEfD42bsXRpsNWlgdERyCX199g0ZIqk5llpQlzazNFn
	8e2Y9LvtkVwifFFGybVdjs/SGjdRrpQO4Ru4QUVX+ZZiwzzw5ZUUUPphrbVg0CYPnsjdcXMw==
X-Received: by 2002:a05:7301:1603:b0:351:1e89:66ab with SMTP id 5a478bee46e88-3537e03cdcamr22531478eec.7.1792001786165;
        Wed, 14 Oct 2026 11:16:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.58.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c61eaa0sm60567444eec.0.2026.10.14.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:16:25 -0700 (PDT)
Message-Id: <pull.2251.v4.git.1792001784634.gitgitgadget@gmail.com>
In-Reply-To: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
References: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 18:16:24 +0000
Subject: [PATCH v4] wincred: refactor credential blob processing
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

Implementation for splitting secret blob into separate lines and
parsing those into key/value pairs has a couple of issues:
- invalid size limit to `wcsncpy_s` (missed during d22a4884)
- inconsistent detection of line separator (matches _CR_ and _LF_)
- failing to advance position after initial password line
- deep code nesting in loop body.

Line end detection needs to be deterministic and
code can be split up into smaller functional blocks.

Create new methods for processing the matching credential and each
supported key/value pair of a multi-line secret.
Reduce variable scope and nesting level. Use early continue/return to
improve code readability.
Use `wmemchr` to reliably detect wide-character linefeed in immutable
blob data without need to create a further copy.

Signed-off-by: Marc Becker <becm@gmx.de>
---
    wincred: fix line split of secret blob content
    
    Changes since v3:
    
     * update issue description in commit message to (hopefully) be less
       obscure

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2251%2Fbecm%2Ffix-wincred-secret-linesplit-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2251/becm/fix-wincred-secret-linesplit-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2251

Range-diff vs v3:

 1:  c7b03346cc ! 1:  5fbd3987cf wincred: refactor credential blob processing
     @@ Metadata
       ## Commit message ##
          wincred: refactor credential blob processing
      
     -    Invalid target size check (bytes instead of characters) for `wcsncpy_s`
     -    already led to memory corruption; d22a4884 just hid the error by making
     -    sure the target is always big enough.
     -    Single invocation of `wcstok_s` only cuts out first hit delimiter.
     -    Consecutive items would always start with a line feed character if
     -    separation consists of CRLF.
     -    Only exception is 1st item (due to following bug).
     -    Advancement to end of password line is missing. Password value is reused
     -    as extended credential item but likely filtered out due to value
     -    mismatch with accepted key.
     +    Implementation for splitting secret blob into separate lines and
     +    parsing those into key/value pairs has a couple of issues:
     +    - invalid size limit to `wcsncpy_s` (missed during d22a4884)
     +    - inconsistent detection of line separator (matches _CR_ and _LF_)
     +    - failing to advance position after initial password line
     +    - deep code nesting in loop body.
      
     -    Line split needs to be deterministic and code should be split up into
     -    smaller blocks.
     +    Line end detection needs to be deterministic and
     +    code can be split up into smaller functional blocks.
      
     -    Create separate methods for writing credential items and the complete
     -    credential blob content to tighten code in main credential loop.
     +    Create new methods for processing the matching credential and each
     +    supported key/value pair of a multi-line secret.
          Reduce variable scope and nesting level. Use early continue/return to
          improve code readability.
     -    Use `wmemchr` to reliably detect wide-character-newline in immutable
     +    Use `wmemchr` to reliably detect wide-character linefeed in immutable
          blob data without need to create a further copy.
      
          Signed-off-by: Marc Becker <becm@gmx.de>


 .../wincred/git-credential-wincred.c          | 124 ++++++++++++------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 22eb27ca31..c25f34a0b6 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
+#include <wchar.h>
 #include <wincred.h>
 
 /* common helpers */
@@ -69,6 +70,70 @@ static void write_item(const char *what, LPCWSTR wbuf, int wlen)
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
+	/* check if content is single line (retain trailing carriage return) */
+	if ((end = wmemchr(blob, L'\n', wlen)) == NULL) {
+		write_item("password", blob, wlen);
+		return;
+	}
+	/* determine current line length and remaining data size */
+	length = end++ - blob;
+	wlen -= length + 1;
+
+	/* trim carriage return at line end */
+	if (length && blob[length - 1] == L'\r')
+		--length;
+	write_item("password", blob, length);
+	blob = end;
+
+	/* find line separator */
+	while ((end = wmemchr(blob, L'\n', wlen)) != NULL) {
+		length = end++ - blob;
+		wlen -= length + 1;
+
+		/* trim carriage return at line end */
+		if (length && blob[length - 1] == L'\r')
+			--length;
+
+		/* write item and advance blob position */
+		write_credential_item(blob, length);
+		blob = end;
+	}
+	/* process final line (retain trailing carriage return) */
+	write_credential_item(blob, wlen);
+}
+
 /*
  * Match an (optional) expected string and a delimiter in the target string,
  * consuming the matched text by updating the target pointer.
@@ -148,51 +213,32 @@ static void get_credential(void)
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
