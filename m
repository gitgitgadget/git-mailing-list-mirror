Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E1F512
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSnTJekQ"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dddb927d02so3117347a34.2
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705119811; x=1705724611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bo4kuVQ7FSVLlC5KQJRz2oCXV2+AtEQHO+hisDEdk4=;
        b=XSnTJekQpgTo2vNHqGpJzfW78iNj90yNp1kgxzEuwRdtTSwOXUMheXxTIa9em2VeOM
         Fi/YbyDeIUr+wQqCXL5CvrHh3CPZRTooqzug1bF++vGFqClDefHLF7yAf7RUfY9WUnua
         COnx7fdyd0abcCzypCUYqOneyWovxscI3+Ml46D6wBLfAn+Y3ANzMBnZCT9FlskWDMBg
         YCEfLVo4N/4d/auYEtoT7AJAtVrbLPrsgCLfBmBczDPU22xkk6k+961Qcsy6lwBquhP6
         QLMdx8+4PcdavCO4lO2ljv7OZA9svgOd1XPwkXpVDCt+/tA5sm1SFCmrylQ3VD7Y1szd
         XW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705119811; x=1705724611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bo4kuVQ7FSVLlC5KQJRz2oCXV2+AtEQHO+hisDEdk4=;
        b=gCeuO68pw+4Eb2wRbOWJgPsJaVD5oUhafKEOjdtpSuNY+QDSdv5j8XTSCTVU83qPSv
         4dU0kGqfKeB8pEMZ+cDljD+XnWEtYIBX8P8jyHT9n+0jVjTc3uMj6MhRjPUYBdbJ9Q9j
         6SizvN3J2eZaM69wkKHCnIJBuhrQZdERs9iHnEY8f+9KncRASlbpUbamAez3RV0gdZ5Q
         vbusivxCaGFvmSzNkPkNOyVPwbfjiifjvWgjoX34NStyW65HCmxGFyhY3OkE5mPU5GFo
         M+asvW+EEqs/6mxoKDUKIUTAI1d4kJ7IaAqZR640duS4YxWpoKCiX7bjA6fafEwlbtT4
         cCqA==
X-Gm-Message-State: AOJu0YzLiIX7Nlws7tbLpXSpMRWLS4/JBPiKGDeje7Am9e/oArYpydJd
	lwAtJZRYfGEWVqJwgURHPCvm+/uMnYxLKn3b
X-Google-Smtp-Source: AGHT+IEFGDgzjPvkW79xAcd2mKnigRTOyPaHITrgiCG+TsanaKJt1NKzLGlBzy2OBe7lJeKj1UdJ8w==
X-Received: by 2002:a9d:664e:0:b0:6dc:50a:cd28 with SMTP id q14-20020a9d664e000000b006dc050acd28mr2836794otm.62.1705119810711;
        Fri, 12 Jan 2024 20:23:30 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006d9a1812e35sm3899385pfb.119.2024.01.12.20.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 20:23:30 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v5 2/2] t7501: add tests for --amend --signoff
Date: Sat, 13 Jan 2024 09:51:55 +0530
Message-ID: <20240113042254.38602-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113042254.38602-1-shyamthakkar001@gmail.com>
References: <20240112180109.59350-1-shyamthakkar001@gmail.com>
 <20240113042254.38602-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for amending the commit to add Signed-off-by trailer. And
also to check if it does not add another trailer if one already exists.

Currently, there are tests for --signoff separately in t7501, however,
they are not tested with --amend.

Therefore, these tests belong with other similar tests of --amend in
t7501-commit-basic-functionality.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 3e18b879b5..db37e9051b 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,8 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, test reflog,
-# signoff
+# FIXME: Test the various index usages, test reflog
 
 test_description='git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -464,6 +463,28 @@ test_expect_success 'amend commit to fix date' '
 
 '
 
+test_expect_success 'amend commit to add signoff' '
+
+	test_commit "msg" file content &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	msg
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+'
+
+test_expect_success 'amend does not add signoff if it already exists' '
+
+	test_commit --signoff "tenor" file newcontent &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	tenor
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+'
+
 test_expect_success 'commit mentions forced date in output' '
 	git commit --amend --date=2010-01-02T03:04:05 >output &&
 	grep "Date: *Sat Jan 2 03:04:05 2010" output
-- 
2.43.0

