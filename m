Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697818CBFB
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108347; cv=none; b=DBtrYbFonJe1rCSIqF5VQcEgWNNUbW9Kn8ESavm9yPKjj0Bn0yV1xXu4edifnpfN61NO5wQgbTaO9VqHNa6JAYnT7E8hdylAM1zCupHfpVf4zGZOIbjoJWpMpr469Hly/LpFcpQaqNUKdJ1RauKbaX2Aqp6xAbziEkTI/zK3tEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108347; c=relaxed/simple;
	bh=78hN4PthVj1QxCh61MB4ZqcfuzLVzeHnER2rlibQBx0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s/fxJgtcpZmNL/w9dQa0DQY4FEaLx8CKhUIP1DG0lDjlsEsndXXnEChutWvgFPUfqeI6BaGvGGx2TLngA6nME1iyayF9f4wt2ojFpbegAibcWfLrzJnlo4Jrrjwuu5XFzjvcopd/N5r9lXfq+SiZDaTTYiTeI2xxQpOxQ7N/r1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFEYqcU2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFEYqcU2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so6552835e9.1
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108343; x=1742713143; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHm3VFMdqqCNMIhC8e37imd+b/d+RUEFaSVMQN/hfus=;
        b=MFEYqcU26F9RItl1sHNoiqZD3A+jMrGyrtMesUSsN+5S5MEUt1o/j3ilQOA1kyNYAV
         +whek2DgaNnM8I+YIWqsaQr9yq1HdM5UwFV0xKa2OmcLJqTQOX+eu2NhsNcQ1rH9CA65
         IV7CYhoAouOCn3JpelPqzlR0aC6G6jrdFM6YlRtXZoEn0rtrzq3U0SVsFRh2wx9AS4qK
         2CpUGqs1QV01W3E83dLRMDulytC87ntxKqHnYMy4V/sVEdBbhytsVDP2Di86+oJ/3LAy
         3EyPBmXDuAYI76WRWN6RuJs7RDXtKkyQFQT54sXT79An6BmCO+xWAcUzsDTEQnGI2uVF
         VkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108343; x=1742713143;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHm3VFMdqqCNMIhC8e37imd+b/d+RUEFaSVMQN/hfus=;
        b=KWs7gNpwh/QKc0QUgcOzzfHs7zdb3ZDatJi83WsFGK8VHNciJNLZ4p8qDHHtxab+Yy
         7B4Ai4pll68VkwphKZwzxZ6czqkNMHGVJfaOAWI4dhnCqcauITyC9wmjms3si7cbWvgd
         GBT1R+njc3ilWxp+2IT9erbaSOtFWpGkDIEMf4ChT3ekJMDzmiK2Ag/2E/BO2Lrij1OQ
         F0luN+9bzfGPkF7RKmAiObixx1QKSMuYGweqCenopIt/8ftG09o7OX9K5QENBddyaLVb
         GFe4M1tms7KIL+uyssF38CGOuyJJu/5hqOYvp5D1MHa0m7xVxPgrNAVZagRJQfF9y1An
         kivQ==
X-Gm-Message-State: AOJu0Yz2SUwyyAgOSjRyHBM4m+x0N4ltIPRU/KMv4xguihj6oSO5GsN8
	DctV1twJtpa22h93MyBmKuGkQJk3QjUzx4YCvdMpjJ8RZGb+JYEwEYDrZg==
X-Gm-Gg: ASbGncuAO/A/b96bfkDNu366XaE6xBAQXIXAMl/c9YCq4aZxkJVA3cqlIM8eZisgeMM
	IbpR4E2/5ys/NcwBHen4wCyCC3olvg4GD97PZ6xnP9hyTfQRp+DSmnusTmQxruNVVrZrV++viK+
	+j9nePFUEfXmQyG73Eg0UhwZ/+17P+ioRDiPMm6/OzdWysfczueK/C1Px/6TcpLeeMD9eyTsbXs
	J+O8WY9FPT4Q/xoXt+acs7RhLgBY+0IRZGMS725z3xNRIuhE2dMEvQFXDAVxiOLqYfmJtdNoBt2
	gk/N9PM/ydUFbCKofIHLkKev8hgt5jVBrS4j1asARPBrLQ==
X-Google-Smtp-Source: AGHT+IF9NMfzS++zUta0G08UQFVoFpOpIYhNmGUFPh136MHbG0Hz0zNQhjpr/L9XeaOA2jnIzX9zMA==
X-Received: by 2002:a05:600c:198f:b0:43c:f928:71dd with SMTP id 5b1f17b1804b1-43d1ec646f5mr63836885e9.1.1742108342846;
        Sat, 15 Mar 2025 23:59:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975febsm11452494f8f.59.2025.03.15.23.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:59:02 -0700 (PDT)
Message-Id: <0d42acaf5d45cd205abeb848670017d7253ab7ba.1742108339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
References: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:58:56 +0000
Subject: [PATCH 2/5] t6423: fix a comment that accidentally reversed two
 commits
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The comment describing testcase 13b of t6423 somehow mixed up commits
A and B in one paragraph.  Fix the references.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 94080c65d12..ebf47cdd6b2 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5549,9 +5549,9 @@ test_expect_success '13b(info): messages for transitive rename with conflicted c
 #   Commit A: y/{b,c,d}, x/e
 #   Commit B: z/{b,c,d}, x/e
 #   Expected: y/{b,c,d}, x/e, with info or conflict messages for d
-#             A: renamed x/d -> z/d; B: renamed z/ -> y/ AND renamed x/d to y/d
-#             One could argue A had partial knowledge of what was done with
-#             d and B had full knowledge, but that's a slippery slope as
+#             B: renamed x/d -> z/d; A: renamed z/ -> y/ AND renamed x/d to y/d
+#             One could argue B had partial knowledge of what was done with
+#             d and A had full knowledge, but that's a slippery slope as
 #             shown in testcase 13d.
 
 test_setup_13c () {
-- 
gitgitgadget

