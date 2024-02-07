Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3781ABA
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324469; cv=none; b=medRqBOrtEUjxWvaXIVWopZZ1seiT3NrAiQRkFHHY/bGAJF49YPHpBr9078jV1aJn4jU3pn9mP6Dx5o4OHRevNlOhizeWLzPNsCARWfDTMbU7q+d25g6I9uNui+1/CrwwLx4Hj00jY2Mb/pxztNYCRmjcp+GvKCzJy+vaR+pBMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324469; c=relaxed/simple;
	bh=MfzEz3f2fTrV5ElY3TkqYiDXh/H9PmvoXCu3Xs7vjqY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aZHGK9EeevN2yPMMvZLtuT8QluMrRyX1ZW/OjIuoVhhol/p/7AM7MijSV6Pcc91SjKT6NuR+mPyrni36ZgQEdVya2TNUjkbWuNpFNyyP/LBvQysZ2BLu4auq1lX44d+RtdjfcoUXDmL3awozRz7DQpyo5qytiEAG3RD7GIyBUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixJ8JgN3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixJ8JgN3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41001c6e19aso5304225e9.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324465; x=1707929265; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVIkc2Ihi8kjW6dU8gPmFjtjN43r/absliTw2Qf3Acw=;
        b=ixJ8JgN3e2wqliP/KTwFGhssqfe9N9VuiWdF3DRFy/vIukcxkIe+pctVoC5ke8fCxA
         yr4VQNeeze3MU3Gxu913RFf4GWdCYZw7Z0q2jLcWJ8ZrxDveUadTaEaNGWMhNGrvhbKb
         rmp8Qp34zl3WxMYhIKQI3nnf4h7GrM5SKqMBn0im18Kwybp24EmqBJr6GfLsvLKkTTZr
         /dklzSuciXpOcLCWz5Y//XbbluF7O/RHJujy5ex0JIqtc6cgUToEcr2j4u3ntd6Girne
         AJPVq/knGcAj8o2CJYSMo9VQvvI/9DtKrmNj48IPvqpM15XYGz7ZvHyqJzkoVYqLoFgd
         JfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324465; x=1707929265;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OVIkc2Ihi8kjW6dU8gPmFjtjN43r/absliTw2Qf3Acw=;
        b=sPM9+bd9ISk+zBkOO8KC2H14LImP8siQqEad5FppJzF2twlxMrfRFTS6jZprSiFg7V
         fAV8vNxwAnTo97gIp6F0SSOoVcIlC3Unzy2Ee/q1Ink5bebxv0K8XGrljWR81nS3nDuF
         hJGsEEbWqCYrcpbIoXu1+MLTbGXAN5nN2N73kMIKrcHp9K4BzZdgyNw6PpjRBS518Gd0
         Yl+m+usvcTxlVCwaUDU+YpkmRJfdHYPzM1M/A34sibf6p/RhzalA+s3ADiqOid8BAXCo
         LD37wShL8eLX4hUlXj+TEuFc4F1GhWXP5sSP4o1Y6BkJ+UyQtR6tB3kcE1yZk6LHwbMc
         xJKQ==
X-Gm-Message-State: AOJu0Yxr8YMO/eHd9ZycoctouFjRxvnNLOGuRjF/YpUji7jt+56c635+
	fZkBR2vxBDaI7zcMG/x+XYp10pEtjnkU03b7Dey6aDqafTqJ83IKGLsY7mub
X-Google-Smtp-Source: AGHT+IEoaqWTDpG0KCoPqtn1q5MYIHfiV52CtZ6MUQD+AMYLeNaZlLs2kp9UmZlYALoZwUozin7XjQ==
X-Received: by 2002:a05:600c:468f:b0:40e:fa51:3526 with SMTP id p15-20020a05600c468f00b0040efa513526mr12674wmo.10.1707324464784;
        Wed, 07 Feb 2024 08:47:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX5ZVPgSWEXl0PfHJdPgn8ZnE/N9GsbQ5EDSoICub/tngRg4WlQbKsPrW+RPobzjS9bFRLrDIjPV4alFe/JNf7w+ZwhC1y6E82Bg==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c450900b0040fa661ee82sm5873396wmo.44.2024.02.07.08.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:47:44 -0800 (PST)
Message-ID: <01dfd66568c1818819e81e001cc189f9066d0cf0.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:47:37 +0000
Subject: [PATCH v2 1/5] merge-tree: fail with a non-zero exit code on missing
 tree objects
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `git merge-tree` encounters a missing tree object, it should error
out and not continue quietly as if nothing had happened.

However, as of time of writing, `git merge-tree` _does_ continue, and
then offers the empty tree as result.

Let's fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c                      |  7 ++++---
 t/t4301-merge-tree-write-tree.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6491070d965..c37fc035f13 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1659,9 +1659,10 @@ static int collect_merge_info(struct merge_options *opt,
 	info.data = opt;
 	info.show_all_errors = 1;
 
-	parse_tree(merge_base);
-	parse_tree(side1);
-	parse_tree(side2);
+	if (parse_tree(merge_base) < 0 ||
+	    parse_tree(side1) < 0 ||
+	    parse_tree(side2) < 0)
+		return -1;
 	init_tree_desc(t + 0, merge_base->buffer, merge_base->size);
 	init_tree_desc(t + 1, side1->buffer, side1->size);
 	init_tree_desc(t + 2, side2->buffer, side2->size);
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 7d0fa74da74..7d588557bdf 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -951,4 +951,14 @@ test_expect_success '--merge-base with tree OIDs' '
 	test_cmp with-commits with-trees
 '
 
+test_expect_success 'error out on missing tree objects' '
+	git init --bare missing-tree.git &&
+	git rev-list side3 >list &&
+	git rev-parse side3^: >list &&
+	git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing <list &&
+	side3=$(git rev-parse side3) &&
+	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

