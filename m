Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5EB3064BD
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763232868; cv=none; b=matUq82O5tYyuTtlPaBSWcNXpnDlN2CJvv5oG5a6+W7GZPK86vSPvlECF1skaixMO2FQkyuKlsvOgYmvm2LLQx0Oc/dI8BN7KHygDHVsUxnkp2GVMndu6xauO/OXhwVVPSJXwikDFLxl4KGp/COwjWnXvCJPNf1d4Y4SDMLXJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763232868; c=relaxed/simple;
	bh=n8dIKEUoSY0EVPSDhwhR5G5oeMNUfWLqnQ5R+pqv1Zg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kb/hBi6lpq2h/wfS4hRI83X82+1L8tso0BNmbROYo0NN/l1PEMBafRVjaZzCxZXbHtPXLnNDnnmGySt4Zbzk5oja+Vytl6qWpxVenzCIs1H1MhRvOcal2bQVfGN1AEq2AZflPQI2fc5LQjLj1zo2FHS91tkaC7IXiNaY43QaDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UprnJHL1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UprnJHL1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295548467c7so35682835ad.2
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 10:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763232866; x=1763837666; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx6ngw9LSL980fpYaKGOo/1v73rG/do+gqSrcjQOIH8=;
        b=UprnJHL10CacYmv3SJbgBTChvVWE9VWLptodygLnqPE4/aq6q8AFhp6XmXRdypBzCb
         +OcpmfB2xEpT2mY42yerHu2k+QQoqKA2ndV2Fjx57WIwV5nP7yNOHROgSVz/cwj8mMIQ
         uYkk51k7rxtpcD+10jC2Q0pro5zQN/wCwKiQRfkElISjeuHziC78ils/1d8zs97yUb+1
         dSUxxRyKHxWle/jzrN7EeuGCdQmerFg8jVQIVAOWZSUPzm5CvisKuLwOBL26g96KqIb7
         +qvDW5lfw5qhMZILRtVrHxaAkbiqLcLTAT73Tlah7DsqjE1qO/M75yUhAFYU+Esv7YjN
         ofaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763232866; x=1763837666;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dx6ngw9LSL980fpYaKGOo/1v73rG/do+gqSrcjQOIH8=;
        b=d5DUN7fvtFdhQSA7zLaRW68BphSbUqwy+/fWjLRtlGKQ4GJ0/8VixBtMs0sAvVjxZp
         sECisEBQxkDgzopDMGWU92JlxLoQLOfHqmCv9xvtidEXk/M31in41OBSwUd6pJdQRGYe
         AcpiUJJb+NMeUjy3jKIFYNkJNbDTpA+uN3chUbYsb+cRCSw4gn0ApH1zPooEB9jQkFNP
         5Ig2pX3HMEFk6TbEgJRljU11fBakbtxGCem9vFB5q8OPcgWBcUI9x3UbPtemB0siI0zt
         7A1MBKJIfjlR8hYOfw1s1yaAMzjNccuPwLU/O2WtXEgyRkuT+y+R9gi5VasQpwnjh0Co
         3bNg==
X-Gm-Message-State: AOJu0YyuOOVMouwSYRl3b4/M4F5craHbSCsKK7MKkbHWDC2mLEXKsYMa
	GWcXZSTjEBZO297k4hR/IEvBuDQQZt+barqJH5wGLMjnbgS2qefWfFRvvDJF3qTe
X-Gm-Gg: ASbGncv3uueqLyeUP5sayUnoFkmb5ROlLXafBFU2Bg0eEm9LgMFzpoqDi92X8ccLa/K
	sNZQElycfUWWxspgcqKkPOcjruh7gPZmKLv99XsTd2DjV2bOtjxJyXZMutsZgA+dnpDAGX+tHOH
	+Ihh8vKrPCa1s+dWAq1IdSV6XbynL85gHS1K9nm8DA0Bzv8YWwi2W7H91BXNzZYnAq3kTa8otFp
	T9x24pLKFlkjEATg42tISNvdtWw6pmm1xg46gFvjblGij2llf0haAgwD6dZvVlov6mXgWXXV3k8
	s3xhcgqtcfXdJXYC6dCvRpoMCaP2nxHHsWYCeWWlbBovIFdXU37seSsAGr/DEQChfS9AgjRDgf6
	CSl5ILPrKjWZbxiOpbIDmPq5tSDmhirCpDMacxZ4xOPEVv8dxpSHyKh14PKQMg7U7RAETquFfY1
	DzoQ==
X-Google-Smtp-Source: AGHT+IHgktJDMJUwGNHcmOCda8SZpqKt2n/qLIczLwlWGysQ9n29f9ogw73MACmbtbTWGj9+cTAXUg==
X-Received: by 2002:a05:7300:ae1c:b0:2a4:3593:9698 with SMTP id 5a478bee46e88-2a4abb330b7mr2910843eec.21.1763232865912;
        Sat, 15 Nov 2025 10:54:25 -0800 (PST)
Received: from [127.0.0.1] ([68.220.58.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db4a36asm19200551eec.5.2025.11.15.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 10:54:25 -0800 (PST)
Message-Id: <2ebccd3096ba8f36f9ab166b674353890191d8bc.1763232863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com>
From: "Kiril Ivanov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Nov 2025 18:54:21 +0000
Subject: [PATCH 1/3] t9903: shorten setup using test_commit
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
Cc: Kiril Ivanov <ivanovkirilg@gmail.com>,
    Kiril Ivanov <ivanovkirilg@gmail.com>

From: Kiril Ivanov <ivanovkirilg@gmail.com>

Signed-off-by: Kiril Ivanov <ivanovkirilg@gmail.com>
---
 t/t9903-bash-prompt.sh | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 637a6f13a6..7628bc10fe 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -18,26 +18,21 @@ c_green='\001\e[32m\002'
 c_lblue='\001\e[1;34m\002'
 c_clear='\001\e[0m\002'
 
+# (main)                     (b1)
+# initial (t1) - second-b1 - third-b1 (t2)
+#             \
+#              second-b2 - another-b2 - yet-another-b2
+#                                       (b2)
 test_expect_success 'setup for prompt tests' '
 	git init otherrepo &&
-	echo 1 >file &&
-	git add file &&
-	test_tick &&
-	git commit -m initial &&
-	git tag -a -m msg1 t1 &&
+	test_commit --annotate initial file contents1 t1 &&
 	git checkout -b b1 &&
-	echo 2 >file &&
-	git commit -m "second b1" file &&
-	echo 3 >file &&
-	git commit -m "third b1" file &&
-	git tag -a -m msg2 t2 &&
+	test_commit --no-tag second-b1 file &&
+	test_commit --annotate third-b1 file contents2 t2 &&
 	git checkout -b b2 main &&
-	echo 0 >file &&
-	git commit -m "second b2" file &&
-	echo 00 >file &&
-	git commit -m "another b2" file &&
-	echo 000 >file &&
-	git commit -m "yet another b2" file &&
+	test_commit --no-tag second-b2 file &&
+	test_commit --no-tag another-b2 file &&
+	test_commit --no-tag yet-another-b2 file &&
 	mkdir ignored_dir &&
 	echo "ignored_dir/" >>.gitignore &&
 	git checkout main
-- 
gitgitgadget

