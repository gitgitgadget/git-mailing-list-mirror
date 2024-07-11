Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F61A08B6
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739504; cv=none; b=ZaMMqVSkegM6K5k8oE3nQ9CTVKfYXkIawxQqr73PUi6Owsi79MLA8nbnJMrjskz1BHkxyys8KJVzEi3FDCBkWks2m6OG4wYhVqAFlrHn2PonJritBjKmgKOrQvxiWosFZ/PMqcadjlcIV8izZrhfz0NWBR93yKZnXFL7TCDiGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739504; c=relaxed/simple;
	bh=R97B9Uf9PS7uc3AFFl7mnsI6myd/ued3PxgFtgachbM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MkIZBOppYduJrGcq4qmHbuaVW1LMxBFk0CpAcUoSWBibOHVBTEcfPAdvPwS8VyJgUK8N3J4ecCQZOp+55dvuIFzxBQbzpQ6agubS8N4QBqDnHJ8LLC16XVCRfH9+FYync+Pz2Ot5AW/lk0aulpD5CRVK9q26BjrkTFXfxxiRyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SV/rinvI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SV/rinvI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367993463b8so800181f8f.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739501; x=1721344301; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkwX2PpzjRQ24nxrS0sZ+WTECEKRNLzB7B2VnM4hk34=;
        b=SV/rinvIQDgwGCcgHbocob5WhjrDMwMgBNPPSRtJn66ppVkV55EKuiDT+OZ5Lg70+V
         vNz2td9R+YE4vggDRKv0N5VntUSnfMPbNe6VxxiAmRRLdLx562vqtFTaATvEqRQaf/Z+
         etQIivo7YjY6uTi5rG0MVmB0tB1lTCnrdXgXU2MVXu5marGf5LOjgwAsfvx6K8NNdjLj
         7jr/yRzYQHvo4v/hfUha1DdtwBSyn3RyF5rwjXn+0VvqLNgohn6pDXLtOQvI5tcjGfOx
         vfvML5AVi5QVGcmLJ0SxOWE2sKcw3oY0qjddQJG37fIyOt4tszL4WIbaEfeeosSLhkmI
         opFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739501; x=1721344301;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkwX2PpzjRQ24nxrS0sZ+WTECEKRNLzB7B2VnM4hk34=;
        b=ehe9WQkApOU+W8KvZ2Z+J3UHJGmtF3wGkGv3Mhx8mlUtGiSedmWdktqxKFXUeVkK0g
         8wG4z9LFQ/ygFZSviq3NCYczCCtzn44AocrO/IKfDG4nZbdQcjfc9W7+UYTx4yMKZIWf
         B5+bDwVnWrdBwOmLV/Dcfn+ybzsMrvR++uVxTSzOvUG/7B0eeS+X9ql4NrweoxSClLjS
         gFJuOH1PVJpXN4oMO7PCfTRGa+eeUNBC66cJh9JpaVqqpYFdW9dCEb0MlVGauqem5tgP
         yq5NRqMMmDOkhY6Vnc7+7frphehyoIDTQAU0farp/Iaj6crgPcYc98zosYdZ3PdRdGe4
         TNdg==
X-Gm-Message-State: AOJu0YwpZDI0BgzYp9ooet3Py9yS1tsk2JNTMcgRaYuhEGPunC/todmI
	aBl+e6k6AODIM6MS5avo5PHeZe7WdkccsOFXzdBoQu9IzycZfHDVSwFTvw==
X-Google-Smtp-Source: AGHT+IERKa5/px7NONHdJWLe/aP1K2tinnLCA/8/D3fuRNvB/Js7/sZsb8It5fEy8J1He2+31aoVWw==
X-Received: by 2002:adf:f649:0:b0:367:434f:caa2 with SMTP id ffacd0b85a97d-367ce5ded5bmr6884236f8f.0.1720739501130;
        Thu, 11 Jul 2024 16:11:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36802d3f680sm334645f8f.33.2024.07.11.16.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:39 -0700 (PDT)
Message-Id: <a718183bb3b8eabd5ced274d8db124909bcdf493.1720739496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:32 +0000
Subject: [PATCH v2 3/7] win32: override `fspathcmp()` with a directory
 separator-aware version
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, the backslash is the directory separator, even if the
forward slash can be used, too, at least since Windows NT.

This means that the paths `a/b` and `a\b` are equivalent, and
`fspathcmp()` needs to be made aware of that fact.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/path-utils.c | 25 +++++++++++++++++++++++++
 compat/win32/path-utils.h |  2 ++
 dir.c                     |  2 +-
 dir.h                     |  2 +-
 git-compat-util.h         |  5 +++++
 5 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
index ebf2f12eb66..af7ef957bbf 100644
--- a/compat/win32/path-utils.c
+++ b/compat/win32/path-utils.c
@@ -50,3 +50,28 @@ int win32_offset_1st_component(const char *path)
 
 	return pos + is_dir_sep(*pos) - path;
 }
+
+int win32_fspathcmp(const char *a, const char *b)
+{
+	int diff;
+
+	for (;;) {
+		if (!*a)
+			return !*b ? 0 : -1;
+		if (!*b)
+			return +1;
+
+		if (is_dir_sep(*a)) {
+			if (!is_dir_sep(*b))
+				return -1;
+			a++;
+			b++;
+			continue;
+		} else if (is_dir_sep(*b))
+			return +1;
+
+		diff = (unsigned char)tolower(*(a++)) - (unsigned char)tolower(*(b++));
+		if (diff)
+			return diff;
+	}
+}
diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
index 65fa3b9263a..e3c2a79df74 100644
--- a/compat/win32/path-utils.h
+++ b/compat/win32/path-utils.h
@@ -29,5 +29,7 @@ static inline int win32_has_dir_sep(const char *path)
 #define has_dir_sep(path) win32_has_dir_sep(path)
 int win32_offset_1st_component(const char *path);
 #define offset_1st_component win32_offset_1st_component
+int win32_fspathcmp(const char *a, const char *b);
+#define fspathcmp win32_fspathcmp
 
 #endif
diff --git a/dir.c b/dir.c
index b7a6625ebda..37d8e266b2c 100644
--- a/dir.c
+++ b/dir.c
@@ -95,7 +95,7 @@ int count_slashes(const char *s)
 	return cnt;
 }
 
-int fspathcmp(const char *a, const char *b)
+int git_fspathcmp(const char *a, const char *b)
 {
 	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
 }
diff --git a/dir.h b/dir.h
index 69a76d8bdd3..947e3d77442 100644
--- a/dir.h
+++ b/dir.h
@@ -541,7 +541,7 @@ int remove_dir_recursively(struct strbuf *path, int flag);
  */
 int remove_path(const char *path);
 
-int fspathcmp(const char *a, const char *b);
+int git_fspathcmp(const char *a, const char *b);
 int fspatheq(const char *a, const char *b);
 int fspathncmp(const char *a, const char *b, size_t count);
 unsigned int fspathhash(const char *str);
diff --git a/git-compat-util.h b/git-compat-util.h
index ca7678a379d..ac564a68987 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -506,6 +506,11 @@ static inline int git_offset_1st_component(const char *path)
 #define offset_1st_component git_offset_1st_component
 #endif
 
+
+#ifndef fspathcmp
+#define fspathcmp git_fspathcmp
+#endif
+
 #ifndef is_valid_path
 #define is_valid_path(path) 1
 #endif
-- 
gitgitgadget

