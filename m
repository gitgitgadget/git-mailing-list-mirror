Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2023C4555
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212077; cv=none; b=jFRFMO5O4vj0vuZNcEx5Z2PsuzVpOPmYaxf6cxqskmLHJndlA8C4Q2Bqv57Dn+RnGZXd4GKlQ1p0LBsSJEVY9eliW5ARfdHQ8MrabxUJPqjAiJJZPTpVyNvLhoO6YqoUjiXc+q9p00yaoCbOmMe1ytXLc8KkoX8kjYLswCnha84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212077; c=relaxed/simple;
	bh=DHYGf8OIehgNc/1gILCmJL7WiZfJSlOXpqJ21CfoD1A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aoH4YCJJeH6g5+xrag/pWsyCyfrl+VddSdh5xEmMfPW8GHT/rIfKhYxH9kWERu4F4j8+CM7qUZat4YwoXaUYUxzC06UKKXmHAa6Gq4P+a4bhSxGz8HqIgbTd3/UhrDmx0E/cQs7B0zJK55unJ/QyHG7Vcmis8XUXcMK9rUk2emQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwlm0WNF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwlm0WNF"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8eeb4508f29so67749216d6.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212075; x=1784816875; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jfT0jSMwEHB02wauz+X7YWa0tKV3KVV8d9Inj309tcU=;
        b=jwlm0WNFpLEb5UwXLzIOgZL19ndXVtW3nEm0VWYWH/sgG913nbclVuMYVU8McU1kLW
         4zvyNRt4gN6yNoSFwTACOBUi05MjdIKgmT7491AHibd8Sp38INdE0RbbwKSnhe/8/8pf
         UkMxJSISSqI9ktgRcgpKx73FtMXMg3b0syQAB3nnntCYxeJSfEX2p1OnDdDrMxqV5LUf
         YWwUk0qLF6aQQFC8roJz8pOziWRA5pQ7F9ZBP0m+TJ3zGZDMke3W9PXJcFtgae3c+eCr
         QqibSOFQLNjZYszH/sO3LtGn17/NIiFYcByR0uvbRHMUTlg/4mD5BF4v+JjVloYe5bK8
         lEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212075; x=1784816875;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfT0jSMwEHB02wauz+X7YWa0tKV3KVV8d9Inj309tcU=;
        b=dhTJkAFbcfaOrnGAnJ3TrXqB3nR4KFo2TmqZWYl+las0J01kMdlMpx+Nk3/VO+g8tn
         F5QDHgAChhb2vlAhnq2D7FvYbSlwut3gj0hUh7aGStediecc4BeIPgKFEsURsXf1IYYR
         pnI9R6agQ9FIsBhQdFtOqHtzglU9moJk1pZNdqfcZ7jKOPhDukfMjj31bVzHasQ7JHrB
         b1GlgEYl40GxEcEEM9tXRQXeaWJ3NXHi3ZWDSfr8c7B/FoakU2s5J9Vgaokyx8H4lgMP
         4F6ggL4/2RO1oj9At5BmhKPxZrioAa1zRY46EzafRXBwBqUyHq07u9eSBjh9RTta7LIT
         dDtg==
X-Gm-Message-State: AOJu0YzRIqmPaYZ07O5Jn2/kcfJF5UZskGxhX+NUvegjoe9cnNFq36bo
	2thwymsUrSAoGWmEyHQfxJL3w1zCHnXo2DRJK2wnCrdB6qbkKpXYrPoS3Jo6TQ==
X-Gm-Gg: AfdE7clRMt81d4tAYO0Ao/CWQ1vy6VncEAY/ZXg5SHvHpDtl516hneLalnWW5KRuDSc
	NjFGLdSqJscWYwpuA05MdnuhXIgcX9o1m2dPYQFrQdfs8164+4rY6+5u8AbtKYLK7sSCrpbxV36
	A449lQfdDL3PGI8RbAKX0LlWcu+a3HOh2yt29G/BeqtYSi7Bli4Z6Uh/DoDqytBTOgm2JhjMAe4
	GJT5rkvsUMdf/m9RgxrEI3Io6wAMdHrk3Lh4kIwADMniYPIJeTKJOOzXwbUqAfKDP9P2q2kCWuk
	sZSn1UmSjTgb3/66oeCsLWbzm60PCKamZUhFbjs8uE9W1muQymLqjkVgbfhAIf3W0uSprgjOKWD
	n0qyJYiPuVccnB0+hk8HoTRUFYPjK8XxclGucKWHLpPwjlldMzNWKdRWbakXyTOs/fuqwDsQg/z
	8t3hho
X-Received: by 2002:a05:6214:2b8c:b0:8ed:a980:6b29 with SMTP id 6a1803df08f44-90758debd50mr87238816d6.32.1784212074554;
        Thu, 16 Jul 2026 07:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm241178556d6.34.2026.07.16.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:27:54 -0700 (PDT)
Message-Id: <3ceda5ed3d8f56fc84b3794b9bce918271e22a32.1784212072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2182.git.1784212072.gitgitgadget@gmail.com>
References: <pull.2182.git.1784212072.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jul 2026 14:27:50 +0000
Subject: [PATCH 1/2] wincred: avoid memory corruption when erasing a
 credential
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The earlier d22a488482 (wincred: avoid memory corruption, 2025-11-17)
repaired only get_credential(); match_cred_password() has the same
defect and is reached on `git credential reject`. When Git asks the
helper to erase a stored credential whose password was supplied by
the caller, the helper copies the candidate's password into a freshly
allocated buffer for comparison. That copy overruns the allocation
by one WCHAR of NUL, which on uninstrumented Windows manifests as
process termination with status 0xC0000374. Because the helper can
die before reaching CredDeleteW(), `git credential reject` masks the
failure and the rejected credential remains stored.

CredentialBlobSize is documented as a byte count, so for an N-WCHAR
blob it equals N * sizeof(WCHAR). The pre-fix code allocated that
many bytes and asked wcsncpy_s to copy N wide characters, but
wcsncpy_s always appends a terminating NUL WCHAR, writing one WCHAR
past the allocation. The destination-capacity argument was also
passed in bytes rather than in WCHAR elements as the API requires,
so the safe-CRT runtime never rejected the copy.

See GHSA-rxqw-wxqg-g7hw.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/credential/wincred/git-credential-wincred.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 73c2b9b72a..190bbccdf9 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -121,10 +121,10 @@ static int match_part_last(LPCWSTR *ptarget, LPCWSTR want, LPCWSTR delim)
 
 static int match_cred_password(const CREDENTIALW *cred) {
 	int ret;
-	WCHAR *cred_password = xmalloc(cred->CredentialBlobSize);
-	wcsncpy_s(cred_password, cred->CredentialBlobSize,
-		(LPCWSTR)cred->CredentialBlob,
-		cred->CredentialBlobSize / sizeof(WCHAR));
+	size_t wlen = cred->CredentialBlobSize / sizeof(WCHAR);
+	WCHAR *cred_password = xmalloc((wlen + 1) * sizeof(WCHAR));
+	wcsncpy_s(cred_password, wlen + 1,
+		(LPCWSTR)cred->CredentialBlob, wlen);
 	ret = !wcscmp(cred_password, password);
 	free(cred_password);
 	return ret;
-- 
gitgitgadget

