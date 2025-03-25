Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4026A1A1
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945543; cv=none; b=toUYD03wemXYNWx54Pk00bTd4M1CS6XEj24SiosjMaaRB/c1BW+x8OIqKVvd4LFZcv1usPFzfjyz2FR2d8DG/IAggjows+mQ90SSgW9JYr9zG5vRtYV4Xdz/9+i6jgV5L+dbK9ivl4BLeUuXOxfEXl9gcspgv0BdEkPblcOJymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945543; c=relaxed/simple;
	bh=Pv9V94JOWDm/C5Hfi8rcT7S7ttM3/YIay+Hx1jlbqkA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P5Kh6Eqy/SvnKZQVvr1Kq3v1YlM/dJAjnKIdPRsQnHau0UaIl8qlNOPebNHPkPcpTsfNhuyQWAC5cA8rLVzsysz2Ap7auq05St5Ne160SJiwYOKVOzpWOTjhntHM1lh2aOwrXw0h94P1URfAQsCQI1hiDBDIWka4mkzia3xP78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gewfesvS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gewfesvS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so44673875e9.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945540; x=1743550340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4IkiO6Glu7VZfepMK9AHTcNaz7euwVLDLmIH1KpWls=;
        b=gewfesvSZz/b2u7uFJo1Ng1KXsCxjb0Qcf/MBnHDeaDIgvrPl3875xS/uy/dhw5P3R
         zm0itfk0KC/KdjZPaNw5ywjg2lNO5oTtHEiPzM805wsD6IZwiKMh70PzQK/y1nzUUF0f
         GYvgFNrCUG0+ies7kXc+ZUk9SlqO0SGGuscR84wtytNULdUGyRG9VJs7og1sgo07xqaD
         7EsqFYNwzPIj+xZRX3UaVIH5mzR1/rzGUbDsGv2ukFFZNNCCR8LveH3tZbdDZbakMC2x
         RvxyaZLx6HEcX24xzOcym7OklKLeV3Flj6TcAC3bhaV6d+53avQp5VpXpkjd1uHlzQa4
         evdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945540; x=1743550340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4IkiO6Glu7VZfepMK9AHTcNaz7euwVLDLmIH1KpWls=;
        b=C8v18yRefLUxBwDFZPxrXBgwdUPkFaaRmYAzfJhYL6Fy5HNCJRo52GIawcZkFG8Gqz
         MAAguU/PfcS5yq+GKINyhygJVTfyRw8zkOPi/vnuV5+2F1+ITb7vQoy1sf55hcLlpiHw
         eb2kffKKZZzcRBUek8NikHoNMXUvS5CCUIcUjWJEclGxj3KnTEmHI/mtbYorZ7WXoJw4
         NjbHHpUIngsdUtZPBX8jPWM9runs2zv2vwLMdDtkj3xxI5iSGQzaWMybQM5KT6FHOzMb
         9IALsbc2ePmzpkabA2VZ7d+0m0o5TyX0hPjmmOcADD310+zG36Y88RYzLNqF9Pyh2wML
         w9Bw==
X-Gm-Message-State: AOJu0YzK0u//qf0OsJWOtkCkANwEaKYRAtwapaPVRLch5Yyp6hIFKQV0
	1nrw69fL40RIGiaJMxJeUv8rqNYQEw77d47uVQrRI9QbjqbN7WCzI602ww==
X-Gm-Gg: ASbGncvidbR8ImEXQGPMYp0t48GexS2BQp7C07fBOQDv2l0/DH9Jn1/Ix5qNhWj6i04
	QbvYWS4Kw7+9Vr06FAeMTDhrZb2gmJA0YzfuTVmN/XR3PhGR2mF4WFKUFCy9HioBf3CGnAnxn9h
	z4tWtH3yJA+K0CZVMDS5fcoHvhA7Zy0IVJWzbnruJUu4/vXJCTBSpJbNayJ1ZHIWbB0BQwBJWPS
	7lkZOMT/zyxR4smGK5Y9bg/ocfCHf0I+uICESHxkYx07LvxSHfE/HOxOtNmTBMuUQvELGOIvP9A
	64D09gR7s0ll1C+pj8E4ogQTaViwVK0Md7DUqPjLehgZOQ==
X-Google-Smtp-Source: AGHT+IGdyCODlzKNGX8wlRBjT6FdMp4yxhu/hFpSjErEZTjNpXGerT0Crs3QY5bc2e4SGDaoFI9OkQ==
X-Received: by 2002:a05:600c:1989:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-43d50a21402mr121537445e9.21.1742945539797;
        Tue, 25 Mar 2025 16:32:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea400sm165719055e9.2.2025.03.25.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:32:19 -0700 (PDT)
Message-Id: <f60ebe376e10d7741f6bd657874a17f6c09d4477.1742945534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
	<pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 23:32:08 +0000
Subject: [PATCH v2 04/10] clar: avoid using the comma operator unnecessarily
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

