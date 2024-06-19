Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0612594
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766026; cv=none; b=MDoJYpMGJx7AaNeuQDgLGr2NEuPVXeC/mMPl7z8uXjgr4dCJuJqW5wW6nHVY4ybJmHvy9KD2kwGICTZ40HalYDswULxo9fQzHvQztGG0DM3aaCsHDflLj6Z2XC1U8meXvEuKyuqR6+OGanralNyk7SxlZBKeA0fVoS2aqsyna9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766026; c=relaxed/simple;
	bh=URc+Xn1Nm1ZI4I4VEvem3okKDvwA1LUDYLqkZk+n/Nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qVWZgVRRyUEhhGqpP3xEcUba/KPEH/7D9ouJJf2WOZrJMfmyktwj9XUNgykxOBPAyxNHSBH/S2z0ElXsPafs9673JALFcBN+cPXzcOC2Zo0ynRSrU9PtIhpClzsiGW98whsa1RXKRq5ZRYC0dUtCnniRElO+tiIeCxdDEHtEdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5CHYUNs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5CHYUNs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f14af40c2so5135043f8f.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766023; x=1719370823; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVdZAMq+IYS2SrXDc0mge0VdZqsAN0YncneL5cyJhk8=;
        b=I5CHYUNseBg8hnDnZ64b0kDONZirYsYGeF/RwcJ71cGxQav6rs2FSiv+Wv3Vc5Pukz
         5tx71UlBGqJvdyAUZAN1ELhOHZmobgbgiDxow0lr74A5who0JV+jbQmbk6TiNpe/d1Qc
         iXIcd1WM8ZnydVe5Bpy+0Fz3GVRla6naz2Jq9L2gCLZsf/TbwdzED+E94NF7HBl+YYm+
         9mvB5gx48u+lU62CRF1Idu3453by8S93l7qmKw/4AY/9U73+5V6kwhab19NM5SmCPpSd
         zjJCHHf2IpaDU+9/KhiTSwj85dGiUTQvy2Za2Pm7Oha9YYHdLjBz3EeqTkF50uOumCys
         mfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766023; x=1719370823;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVdZAMq+IYS2SrXDc0mge0VdZqsAN0YncneL5cyJhk8=;
        b=bVrEBPx9i55LD838wWbYoWEsUESPvBUQhbT/I43EfkHZjG7AGUa05neTo07CeAfx0G
         ZUSoJOIq9+v9L9W+hTFtarg5XS6Mn60n5XjHMvMko+uXdvAvwNzYCt/wZFmZg2HXuSFm
         9ndTyvvAmJJf2Mo/OGdfsQMWCok9/AA9hAmaoH2uEKov5fd4AY3oXo67ffoOG6JgB3Uj
         uruuLVp5kAQFHDl3LEHI5dPEEx5rnLzsUgBog/JzhDPsLge1+gXk+kl3fDe4lx8dzvvM
         fWLQ7VQtuxJE6FmjXVKTy9U3XsGJIV/EhyvQbY2GanmeR2/jHf789aWUPXsv45KtO4XE
         YQRw==
X-Gm-Message-State: AOJu0Yxd9Q0mzftQ6uxpWtpInqx+1oMOBi9ZmIVPoH/oaKBnEnVyMtO3
	tvBURunJPZgPevGYTmbUG8hXGk0aEFI1jBQOoc8uPX6j8tAYb1wSeiYqTQ==
X-Google-Smtp-Source: AGHT+IFGJPJnjTdtZ2LRnWDgHuhQUQ/MiWUMCXWnA/7YExRYwWqueNqhu24B4LE2WJRNtWA1hsy/uQ==
X-Received: by 2002:adf:f791:0:b0:362:3836:35e7 with SMTP id ffacd0b85a97d-363192cf052mr885475f8f.48.1718766022467;
        Tue, 18 Jun 2024 20:00:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d41sm15855429f8f.16.2024.06.18.20.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:22 -0700 (PDT)
Message-Id: <5c50c0b3aadbefc7973a2e8d77890808c95875d6.1718766019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:13 +0000
Subject: [PATCH v2 1/7] merge-ort: extract handling of priv member into
 reusable function
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

In preparation for a subsequent commit which will ensure we do not
forget to maintain our invariants for the priv member in error
codepaths, extract the necessary functionality out into a separate
function.  This change is cosmetic at this point, and introduces no
changes beyond an extra assertion sanity check.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index eaede6cead9..700ddfccb90 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5000,6 +5000,26 @@ static void merge_check_renames_reusable(struct merge_result *result,
 
 /*** Function Grouping: merge_incore_*() and their internal variants ***/
 
+static void move_opt_priv_to_result_priv(struct merge_options *opt,
+					 struct merge_result *result)
+{
+	/*
+	 * opt->priv and result->priv are a bit weird.  opt->priv contains
+	 * information that we can re-use in subsequent merge operations to
+	 * enable our cached renames optimization.  The best way to provide
+	 * that to subsequent merges is putting it in result->priv.
+	 * However, putting it directly there would mean retrofitting lots
+	 * of functions in this file to also take a merge_result pointer,
+	 * which is ugly and annoying.  So, we just make sure at the end of
+	 * the merge (the outer merge if there are internal recursive ones)
+	 * to move it.
+	 */
+	assert(opt->priv && !result->priv);
+	result->priv = opt->priv;
+	result->_properly_initialized = RESULT_INITIALIZED;
+	opt->priv = NULL;
+}
+
 /*
  * Originally from merge_trees_internal(); heavily adapted, though.
  */
@@ -5060,11 +5080,8 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 		/* existence of conflicted entries implies unclean */
 		result->clean &= strmap_empty(&opt->priv->conflicted);
 	}
-	if (!opt->priv->call_depth) {
-		result->priv = opt->priv;
-		result->_properly_initialized = RESULT_INITIALIZED;
-		opt->priv = NULL;
-	}
+	if (!opt->priv->call_depth)
+		move_opt_priv_to_result_priv(opt, result);
 }
 
 /*
-- 
gitgitgadget

