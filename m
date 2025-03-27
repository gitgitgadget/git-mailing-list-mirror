Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711032139D7
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076393; cv=none; b=a810SGrjL59JMPPTFy1R2W74c92U3JZ+fgm0luk63BDkrmqIKKUw+7POD3EJs0FZOTCBqT3S3nzWXSvLzJcxR5aj9E2qzsmIeR3uSHObR6ORIvFLy07hj99GiRNH8VfR4j/LjG8NEMtb/F2tME18E5x7b9nm1qhRBW16P7p4ZXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076393; c=relaxed/simple;
	bh=Pv9V94JOWDm/C5Hfi8rcT7S7ttM3/YIay+Hx1jlbqkA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qiGAntfkGS2bHgb1PlllYHwM5/zgdHxtW5mZomJxIkOr6PzeUYOGLuZDNnbASn+kNgA+yDpdS3BkW9hH2IkN9fV2L4DR2Qdg2K047ZW/wO6bNSoPcRCSbQom1ci9cBofFavTfhjLsIRZ9f3gew//6HHcJPKcIC7ZE6VuJbOaNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQXtPWlV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQXtPWlV"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39127512371so511089f8f.0
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743076389; x=1743681189; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4IkiO6Glu7VZfepMK9AHTcNaz7euwVLDLmIH1KpWls=;
        b=QQXtPWlV+K6YJVczPTc4AKUtda4nDpUFqwXGVW8Q9kxdWfJNmqcjGBYYQuATeciEuq
         RlLxoeLW8Cpu2oFgqNPirsx55IprRaMQZhPKpI69Qdcxx6YtJoRiBA3ZB4po58j/fKjX
         l6LtkHeCvNea0Y3qyUSgYTRQEyIx+hrn6fu66IYbEr+cdz53EKGghjniwm4dy/7kkiSW
         8qGpD/8wG2wytSHts9FJEhbITUlIkJj/+ATUSfOYzQlQjg/Bi8Qt8nOS7giHRnhpGHMV
         dYdxFKlTZSWnJhTeJfuY/yHVee6TXTa8ovSsvle9mElp9PDuRysp34caZkTrW5azIlBC
         7c8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076389; x=1743681189;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4IkiO6Glu7VZfepMK9AHTcNaz7euwVLDLmIH1KpWls=;
        b=H0cW7zplA/Wg+zHdWluLVWoaqKqvFNPir1tNOTD7OOow2yJXeUKy2zUOZNTt9D/ea6
         QYJbOg7joYPSFDepeavntEmXJ8iTmI+PWiUY1fVRA16U2BhrpXaJSN8IaXJ8CbPISw1b
         kZfyIhqWB/v0Skj2HQk9Gn1OwUHhJmg37BjnCCVo08ucFxaC9pXXZivgIg4zx97vJZbJ
         HXG7a2S+MNjJn9mNGfQa0vG4nEsU4MH9HcfKhvpCyzrWPoKMvs9MHc8eh0zv8VvNAFNu
         OJHeT3CN3ON7Ls60oq8+zywqTm4XpLJYMCDvmfq2kZYlFIz81Iyv76NdSQTQBe03i+Py
         ynNA==
X-Gm-Message-State: AOJu0YwtKUclcbE9UUTsAP8GN0jNsvLSJpSGnANHac+sDwP6+kCQMk4V
	WuBorZD8qOMATlV8hz5+t3D192cjt7LconHqEdTLbMvQdyO63Ix0zhK4gA==
X-Gm-Gg: ASbGncu5aaJ4FMI29e0Zf+jlgTZ/fb+V/qMpaHMZEyZw6+0aIkZ9z48SOhg2yZ758IA
	dhOS2iFjKqLvMkL39E+uyT58/Bd7Cf9t9OCj01obbUleS3eqp5OAuaccI9k3oE0bbQY8oMz/eZ/
	LoVFvq87QzRrJTzgbCyyaKEWVHr9+mrKI3t5W+VaC8x9GXO086NgdmhmyI9kJtrFqf8dVT3P9z7
	gmczOQer2487x/908VuEJgdE94hDiy9sUmGxdSscZV0Nu9UIjzei/fjHNZgi1krUpuP+SSQSS1M
	3DB/2sxVLDI3VXDMSAt9jGHSHcN9Gt/0FbxDTSyAOnA+ZQ==
X-Google-Smtp-Source: AGHT+IGEB+KmkXYtOEkybh8J2agZTZWcuJMhCK2hfhfAImbG1sNfpaIvjXibmugj9CHz/tm+lGvRwg==
X-Received: by 2002:a05:6000:1889:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-39ad174dfccmr3326274f8f.25.1743076388572;
        Thu, 27 Mar 2025 04:53:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6667sm19976733f8f.72.2025.03.27.04.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:53:08 -0700 (PDT)
Message-Id: <f60ebe376e10d7741f6bd657874a17f6c09d4477.1743076383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
References: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
	<pull.1889.v3.git.1743076383.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:52:57 +0000
Subject: [PATCH v3 04/10] clar: avoid using the comma operator unnecessarily
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Chris Torek <chris.torek@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. In this instance, it
makes the code harder to read than necessary, too. Better use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/unit-tests/clar/clar/fs.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/clar/clar/fs.h b/t/unit-tests/clar/clar/fs.h
index 8b206179fc4..2203743fb48 100644
--- a/t/unit-tests/clar/clar/fs.h
+++ b/t/unit-tests/clar/clar/fs.h
@@ -376,9 +376,12 @@ fs_copydir_helper(const char *source, const char *dest, int dest_mode)
 	mkdir(dest, dest_mode);
 
 	cl_assert_(source_dir = opendir(source), "Could not open source dir");
-	while ((d = (errno = 0, readdir(source_dir))) != NULL) {
+	for (;;) {
 		char *child;
 
+		errno = 0;
+		if ((d = readdir(source_dir)) == NULL)
+			break;
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
@@ -479,9 +482,12 @@ fs_rmdir_helper(const char *path)
 	struct dirent *d;
 
 	cl_assert_(dir = opendir(path), "Could not open dir");
-	while ((d = (errno = 0, readdir(dir))) != NULL) {
+	for (;;) {
 		char *child;
 
+		errno = 0;
+		if ((d = readdir(dir)) == NULL)
+			break;
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-- 
gitgitgadget

