Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787114E3ED4
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553523; cv=none; b=tGph54dUbY99AlNlhJ/UiZ/gpS/5tWCiQLqpUnV3+vmDU/1U8LrFeEEeftguddYij6dRr9NmQYK1NUgG/KsS9YyJpsg2RAx+WuBbfYlOD7hiMeF+34VAAWg3NDD1c03cpXv/Ii3mp08WaOSja4RzNWpL7lrO311ZoODqQRCsmM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553523; c=relaxed/simple;
	bh=5iSvd5QRwRjHK45HgWGGI1h3fX/JWyuG1tNL8K7mnBs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fhyVcdmCsUBNnJK0UfGiTvSp09oeE53aBAx10akeD8SSABmc9PRPUbKCsaDOdt9VV0BCZGLXR+gf4zx39Q79FQG+b7wcctSBv+ZGRwuWjLW80Q2zksqFrBdZfkd286xBLTmKlb8V3N0nLE+4k+1/otnQQKI0ZHQloB+PljnJlaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCQukcgO; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCQukcgO"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f48c750afcso4329084a34.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791553520; x=1792158320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WcTj2mPvnzrBfRvf41tuGAwrH2Ppi/9tcDeiZIfKIkg=;
        b=nCQukcgOvmSBYGP7ZRb5V4BRtgZte/GF1QqmXz+e5a3bSBzJVrF0BmcY/3iHbZHtxt
         zfmdKGhfXbtTsYb5EaXCvyqPr3ALnANDLJjcOhnlrc7N8isnG99BcQzYPrHE7h6jc6ls
         szw3AwwVBvhIj86g+jwn2VjEcDEZNe907aC8vwFdfnbPmOq2dBTc025IIGYBwJNPYLdj
         i1NS2NEJivJfK57zQpZeHByaE763V71APU8pHakuMe44HlVS6GUEIRn6Hz2vrrDfq89G
         X4bdicT62rBJdhzMQAevdJ6CxzsiVLvkdpI2avoONg7RTGj07N3Oy94e5Vlqq8HUS5tm
         s8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553520; x=1792158320;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WcTj2mPvnzrBfRvf41tuGAwrH2Ppi/9tcDeiZIfKIkg=;
        b=RU04YG3Y5IeKMdbmSwJTLHoZ+WmoRLFYZnfGRaEy56z9K0bAGsbvmKX8qqdohLizrJ
         OK8SpxNVcyYrjuFmcKcqRtM6G3162IGVeUkLiHxPVNEUBCP/hy/MUMpggJbf7qneBjgX
         A5oP9/akbW03CAGH/AV7Tia5AylbqFQ3dYtoXEq9GLiM5W0cr7r6QqNoGV5VV4vgsQox
         JefAuR3iJ7TS7Dhjd7ytY3ODTxjvUqPtSCTxzd+s/4pWTWTgK7sLGTXjen7WYyuW1yW9
         I0LIixzKf/GDsL0FMVkdbvnCAcEtTIZ/MB7e6als15145jTQVUOYDNrK6vtp4RwRGtU9
         d4Rg==
X-Gm-Message-State: AFuF++knOMR0r7OY14nw7RsnWTKQQF6/rItPfmyakGBot7HhJPmwrj0f
	NDW7x0Nz9QDaz/pvGFuCtdlu7c7ejebhDaHZSLfVx8JSA9ykYwdy8hlEwJXW+w==
X-Gm-Gg: AYBFou0QXAzLjEkS4/tk3YGsnQrnDK6EQWizeXCGn5csDRg0fiG38E/VXnLnA6d7pZJ
	cTE2wlG3JyTQAQ+G/vfnc2zSQc4f8kbrwJTFIoJw18MXLpkYF8+uWu1XAj4OohwmV2gi+DzhUT9
	8jXVAkQhhyQRpTTmqJvXBz4Yw8tMInWZVv3TBj3SkRHk61Dhxcp6GiTT7ECFVN4FoMad3IfgYp0
	xiNSHIWXwHD3pLLqkO972CZITh3eDC8fiAiYiSAj9oRnfkAXvc/9kycmctWjXuBMpFUoKJT36aH
	CRIZOTiMr6zDGNWdPh1vWLSgKMdJngO65yW2/fOrRI22jUx+uy4aCkKx1z9YsYewgcHu2nUZ2c7
	lsX8QHlzrCfmfIhulJZJKR0pLS+8Ze+bm+/OC2H0ef4raVkuJS7lEtnavyaMK1pWW89l0mv42JA
	sIwS0e2JX+i+inW8uKHMJKYaU2XHN1OLTzub2+fv713ZOuj6WOvLplXzP6OezoFwqWa26Aci7m4
	cYS
X-Received: by 2002:a05:6820:807:b0:6d8:171b:58a9 with SMTP id 006d021491bc7-6ef02a8d54amr1256777eaf.0.1791553520103;
        Fri, 09 Oct 2026 06:45:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.172.249])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328da8sm1781853a34.24.2026.10.09.06.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:45:19 -0700 (PDT)
Message-Id: <pull.2251.git.1791553518774.gitgitgadget@gmail.com>
From: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 13:45:18 +0000
Subject: [PATCH] wincred: fix line split of secret blob content
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

operate on immutable blob data (wcsncpy_s still had invalid target size)
split on newline character to avoid bleed-over on multi-line content

Signed-off-by: Marc Becker <becm@gmx.de>
---
    wincred: fix line split of secret blob content

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2251%2Fbecm%2Ffix-wincred-secret-linesplit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2251/becm/fix-wincred-secret-linesplit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2251

 .../wincred/git-credential-wincred.c          | 86 ++++++++++++-------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 22eb27ca31..584f457774 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
+#include <wchar.h>
 #include <wincred.h>
 
 /* common helpers */
@@ -148,51 +149,74 @@ static void get_credential(void)
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
+	/* search for the first credential that matches target and username */
+	for (int i = 0; i < num_creds; ++i) {
 		if (match_cred(creds[i], 0)) {
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
+			LPCWSTR username = creds[i]->UserName;
+			LPCWSTR blob = (LPCWSTR)creds[i]->CredentialBlob;
+			LPCWSTR end;
+			DWORD wlen;
+
+			write_item("username", username, username ? wcslen(username) : 0);
+
+			wlen = creds[i]->CredentialBlobSize / sizeof(WCHAR);
+
+			// check if content is single line
+			if ((end = wmemchr(blob, '\n', wlen)) == NULL) {
+				write_item("password", blob, wlen);
 			} else {
-				write_item("password",
-						(LPCWSTR)creds[i]->CredentialBlob,
-						creds[i]->CredentialBlobSize / sizeof(WCHAR));
+				DWORD length = end++ - blob;
+
+				// correct remaining size and drop carriage return at line end
+				wlen -= length + 1;
+				if (length && blob[length - 1] == '\r') {
+					--length;
+				}
+				write_item("password", blob, length);
+
+				// key/value content starting on next line
+				blob = end;
+				do {
+					LPCWSTR value;
+
+					// find line end
+					if ((end = wmemchr(blob, '\n', wlen)) == NULL) {
+						length = wlen;
+					} else {
+						length = end++ - blob;
+						// correct remaining size and drop carriage return at line end
+						wlen -= length + 1;
+						if (length && blob[length - 1] == '\r') {
+							--length;
+						}
+					}
+					// find key/value separator for extended credential info
+					if ((value = wmemchr(blob, '=', length)) != NULL) {
+						static const LPCWSTR refresh = L"oauth_refresh_token";
+						DWORD klen = value - blob;
+
+						// write entries known to git credential protocol
+						if (klen == wcslen(refresh) && memcmp(blob, refresh, klen) == 0) {
+							write_item("oauth_refresh_token", value + 1, length - klen - 1);
+						}
+					}
+				} while ((blob = end));
 			}
 			for (int j = 0; j < creds[i]->AttributeCount; j++) {
-				attr = creds[i]->Attributes + j;
+				CREDENTIAL_ATTRIBUTEW *attr = creds[i]->Attributes + j;
+
 				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
-					write_item("password_expiry_utc", (LPCWSTR)attr->Value,
-					attr->ValueSize / sizeof(WCHAR));
+					write_item("password_expiry_utc", (LPCWSTR)attr->Value, attr->ValueSize / sizeof(WCHAR));
 					break;
 				}
 			}
 			break;
 		}
-
+	}
 	CredFree(creds);
 }
 

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
