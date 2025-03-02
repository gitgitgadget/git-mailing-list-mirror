Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ECA1BD01F
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740901531; cv=none; b=F8xk3/RNA0thCQEXEoUoaF0+VSqu8U+bw0nDG+L9ik909DF0qIWmCU8ylnxupm5mFhqoRHtEY0HzewH6qxENBwo3WfjKm6N6kLWIrSat/htlfMY05DSOaXTQN1qraIOSj5W1WMab56YHJQUawiUZ0ktSL2KAQH5PwVTXx5ion+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740901531; c=relaxed/simple;
	bh=9UbH5fRM8D7OWySSr1WX3miOJ8ws8pKrd4Z5g1mCUao=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UVUIUh0qII7Q8FauUm3ht9oNz9mYxehAGGQVtf2OryDSMDo5tmcAd1RpnrCBFHqnNhRjNk5x8TdnTfI0RzaTZ91CnL7t3iqGUCD+bvsgGjFj7MecjgD8f5TI4sm7Qa6kUD0hUigGQOo8FdtBs5YipoDxHqGedwQAtcKc9FpXIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7UolJ29; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7UolJ29"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43994ef3872so21963925e9.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 23:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740901527; x=1741506327; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVHQO+bhQ6d4Sk4HDFa1QABWCGfs546zyD4jF4I39nM=;
        b=E7UolJ29dePTqkwz0+vIQ1dlgh1wB2JUZa1jpqEFh3b6f3R6ziFcgiTeXFmonYoVcQ
         UmteTGu60M1UhsyKQoicRLVagslG3o3I89pKKM99ps0dxGoOBtHmCZEWMwH8MTZ6BTgM
         xLrbDffgUMYahvyNyuqa3YcqT8Tz/ySmfQIWvAap9eTX7PoLcaIw1xEJqVWrTO3Vi/4Y
         DEN8umMeMNMDEXA6kWnh61yLdw1N1wF/pcZ9NLkc1UiFjuUnB9CdpLQucNPuqtHx6kGK
         bVgw/y97h6+MS4Gjl2f4aPpTOz3k4eNskBJO/1Ci1DGSdRmnjAVnMwW5HwvlOu/MlY54
         NcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740901527; x=1741506327;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVHQO+bhQ6d4Sk4HDFa1QABWCGfs546zyD4jF4I39nM=;
        b=YoY18eaFcPkgpHdAC18i82gWNqlC03LEx3QMafrtuS8TxDhbscZkBN4kKJ0nA2QPFL
         DYiWa92FDatxxPOs31uGzNW42FeXYiYWqS9rIRPucYSzb+0ZgqyEvzymdSsHVstqVzk7
         f3/h8NvDGEGBf3kTQsHIVm2PdBSBSl7l1/6D0a/Nmcly25Rpu0KiZPunGcikoevQ02c6
         FBsoofzwsiswT8GzYN946zq3zNCokxnmQ9JweK3sVRvSW39CHh67czGsGthgYC4KN8IM
         W/7S0ePYGiNV56tn/7hqXVMeoUm3umPvV1PXi6JlHr6m9BwvChvKMI9xDVkKo3KSYND+
         wcFg==
X-Gm-Message-State: AOJu0YwIiRTGvJf0nqO1jOAJG5nzWbYInzSI0K4ck9bxZof/aXFvhlpB
	BU2fUdfcclKQ9B7z6PXCEUzZWESJLjJM+LDZQu2eYDc4B0wiLA5XWeO5hw==
X-Gm-Gg: ASbGnctc7BSQe8d/+GhmBAvEXVRiXKXQZPlQ+CGdxIct/9ko43LIBBzyjFBGtTov63Y
	LghJ+xg6ZIexhtFGO3q0E0I5sodTXWAhbXmdN8putTn3wM+PpcwC+O9J0+DMplLDLzOOuReG1WJ
	zILuKiLBVJM5zSTZjymdvlBOfM460raYos8uydA3R9VDXR7ux9QTK3Upom7hVg+sAnTGjTdqZ9i
	0Yfo0NbbZwjlyAnaGCm0JXiJ1u2S7tcpzGsnM1nBftqRmDfePNCQQUDutAHLySazF+kaM5xf6ts
	4qCdzuUV4e/0eHP7FC5TX3whyxvC19HowT379eUi7XB6sQ==
X-Google-Smtp-Source: AGHT+IGCC4dbdWVQQ1LXvkvcPgod3mPpFjh0yFUyMEYQgkJH9g+4tPsWvY9y+TIhL8qHkgtbkgxEMA==
X-Received: by 2002:a05:600c:1c22:b0:439:8c80:6b02 with SMTP id 5b1f17b1804b1-43ba6a78efcmr81076555e9.31.1740901527277;
        Sat, 01 Mar 2025 23:45:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbc8b7cbesm7504225e9.37.2025.03.01.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 23:45:27 -0800 (PST)
Message-Id: <c8594d311741e884680fab8f9cc15eb881774163.1740901525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
From: "David Mandelberg via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Mar 2025 07:45:23 +0000
Subject: [PATCH 1/3] completion: add helper to escape strings for fnmatch
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
Cc: Jacob Keller <jacob.keller@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    David Mandelberg <david@mandelberg.org>,
    David Mandelberg <david@mandelberg.org>

From: David Mandelberg <david@mandelberg.org>

A follow-up commit will use this to escape parts of ref names for
for-each-ref.

Signed-off-by: David Mandelberg <david@mandelberg.org>
---
 contrib/completion/git-completion.bash | 12 ++++++++++++
 t/t9902-completion.sh                  |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 413911be3be..cb10f818a81 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -234,6 +234,18 @@ __git_dequote ()
 	done
 }
 
+# Escapes special characters in a string to pass to fnmatch(3)
+# 1: String to escape.
+__git_escape_fnmatch ()
+{
+	local s="$1"
+	s=${s//\\/\\\\}
+	s=${s//\?/\\\?}
+	s=${s//\*/\\\*}
+	s=${s//\[/\\\[}
+	printf '%s\n' "$s"
+}
+
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 51bd7508376..c5e91622876 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -455,6 +455,13 @@ test_expect_success '__git_dequote - open double quote' '
 '
 
 
+test_expect_success '__git_escape_fnmatch' '
+	echo '\''foo\\\?\*\['\'' >expected &&
+	__git_escape_fnmatch '\''foo\?*['\'' >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+
 test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	with-trailing-space Z
-- 
gitgitgadget

