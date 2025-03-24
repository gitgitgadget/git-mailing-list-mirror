Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F32E3397
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742777518; cv=none; b=cL5jCzKji5AhNA/+wcgRN7REYEunNVTtprdHETBFBLq+Hw6sL2BFaZLXV2gMKu0d4/xtl0BHu7ZRx+WSRXGvnAisFfhYEv/03xJJokBRVOeshbrDVtXW8ztvU5a6Y8ATVl4KHSEnHtHpUNeDw2Bzk7IJq9P8PfNvU1K4ZSDDdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742777518; c=relaxed/simple;
	bh=gtnAE2c7qzhlv1qLLJPQvpTzLg5dO/n+xubot82tWN0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RiMnpmdH46ZqE3iJGAX5hwWJmFAXH+uC73RjLOYnKozBA76lpRDthfj+GHKJbYswab0NExC+PZm9TQCieKzNAf6W31/vPyIglzFuqjxg5Y7wzYh9Cm2c965I1RRlu36O4o+mUr2sM8soz70Vl3M//pVw7fsxGe7xymeadfmCKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmRCaHNj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmRCaHNj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39127512371so2394193f8f.0
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 17:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742777514; x=1743382314; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acOQOTqfAKpUTN6If5AMvdGkuVO9gPI3CHtYfDNTSnU=;
        b=cmRCaHNjSfYztbEpirFkJEJHUeLVJDLn+qGpC11WGAaFcf23KpFRnv1NL1Ah5LWjqO
         LmxvkhzG6zz5HJ1IZiBgfky8F/2Akr/CXKRfxcFzHKBr7pR6HNfCbhi87QwrZGU0XNRs
         nsKWaBUGh0hkpagTCdsdfWZLW68rzgFSqafQofqvBdUR5Hrr6s3LRQoTYM3QtipAecaS
         Ewcwx1ReYaF1wykiI040O/un5XN4Fzz9dBG82p/ph664aPQy2zzpWwCRExeySvmPtZKz
         uxKT8HZPturEuB0EmZ1M6Zi4tZfVRT2P1QiZojt5i/YwMyKTj/ixr5HfpfpeyT2W41W0
         0IMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742777514; x=1743382314;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acOQOTqfAKpUTN6If5AMvdGkuVO9gPI3CHtYfDNTSnU=;
        b=vfcDaqQAqIMpDus/WXW6VejzkBmE6JtGhZw9aI84P+QHOYAMqlVZ/Y5lKZYCFqB0qz
         PEvtonTFiwUCHegdYhU+qFtG1hztJuiCOBnck2WN7QP0/m87wqxf8hbz8otU+XB8raXB
         PFhvts1Ridf3WHhOGCrIwVMpqay0vjrrpiLnZ0mscLGUD8actRSgtWuf1zD3HGKRElbh
         xDREWAKnudy0ccIxbQdVg1ohQucXa3ZCUXxk2kB5fbE9Y0ihTTrx4TH6DbfHM2t15Yb4
         nL+DiQHMJ18d0iwYlNrPhmsBWkt1Lf6fNdTbIyXRNzDqzvjwQ3fjM3WIGgp9tYJ/Rmbn
         ubLQ==
X-Gm-Message-State: AOJu0YyVRt1OPd8kmtpSkAisK3YcKYUouTiGYdrzwjbVAGTfkAAWpQYk
	FsEjnBICpPInsACHQlPxk7KIeLgcvdDbPnLAyWAXVkKautFEseSBcjmLpw==
X-Gm-Gg: ASbGncv1nPKe1A/hh0Q/iXiqcm553dHzEq8Urht/AzPKv8j9RGFLd+0388YeDXaInMK
	UlrgO20mHb0zxZs+4/aFBL2Mpv5pr8TU9Gi8lsdanKWL/ZcmFEUxSZ6jLrxgINQa5zcU2i2BRKF
	sUtaMa+HnPeFZgciSjQahgr6TzetvvA++lWERsWp1jFE38wwywAC4kzFiISpiPqr9sBo/Ide4Fq
	8wFkdSe7RHXxxnV8VXHc/7usuEQL+2HORmMMSstdqKUkgv/HaAYpfJWX4TvByxbI9Tog2oKKr8Y
	lgWn0i56kg8nJVEdEQEmVP0Eu8OhTI52OtkqvLORqr5ebQ==
X-Google-Smtp-Source: AGHT+IHVJFpX+/JYL/pzpuj1ZQ7NWXGGfDGL0n+jrj6F9q/kW/pBK+dS2bG87xR532r+9gv+oxRmeA==
X-Received: by 2002:a05:6000:2103:b0:391:2954:de27 with SMTP id ffacd0b85a97d-3997f93c2b0mr7499690f8f.45.1742777514421;
        Sun, 23 Mar 2025 17:51:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9f0107sm9432208f8f.99.2025.03.23.17.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 17:51:53 -0700 (PDT)
Message-Id: <8135c008325fcbdafe4767d02873deda5d873d2b.1742777512.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1885.git.1742777512.gitgitgadget@gmail.com>
References: <pull.1885.git.1742777512.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 00:51:50 +0000
Subject: [PATCH 1/2] maintenance: force progress/no-quiet to children
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The --no-quiet option for 'git maintenance run' is supposed to indicate
that progress should happen even while ignoring the value of isatty(2).
However, Git implicitly asks child processes to check isatty(2) since
these arguments are not passed through.

The pass through of --no-quiet will be useful in a test in the next
change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/gc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 99431fd4674..6672f165bda 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1029,6 +1029,8 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
+	else
+		strvec_push(&child.args, "--progress");
 
 	return !!run_command(&child);
 }
@@ -1185,6 +1187,8 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	strvec_push(&pack_proc.args, "pack-objects");
 	if (opts->quiet)
 		strvec_push(&pack_proc.args, "--quiet");
+	else
+		strvec_push(&pack_proc.args, "--no-quiet");
 	strvec_pushf(&pack_proc.args, "%s/pack/loose", r->objects->odb->path);
 
 	pack_proc.in = -1;
@@ -1263,6 +1267,8 @@ static int multi_pack_index_write(struct maintenance_run_opts *opts)
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
+	else
+		strvec_push(&child.args, "--progress");
 
 	if (run_command(&child))
 		return error(_("failed to write multi-pack-index"));
@@ -1279,6 +1285,8 @@ static int multi_pack_index_expire(struct maintenance_run_opts *opts)
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
+	else
+		strvec_push(&child.args, "--progress");
 
 	if (run_command(&child))
 		return error(_("'git multi-pack-index expire' failed"));
@@ -1335,6 +1343,8 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--no-progress");
+	else
+		strvec_push(&child.args, "--progress");
 
 	strvec_pushf(&child.args, "--batch-size=%"PRIuMAX,
 				  (uintmax_t)get_auto_pack_size());
-- 
gitgitgadget

