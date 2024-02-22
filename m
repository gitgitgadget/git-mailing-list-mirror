Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777F3DB9A
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612611; cv=none; b=HirdeES8ufQ5YjBTUz2IDfo0VUU9B84ZUNJNvhT+J2TLD2LxmGcwQgCTUBt+WZrYW5VCU67oieCqkTkC6wyuvpVdM4MrQGgG9BHWn5LCC9LfN5wD81P77/tHZDu1VP1lduCppzDihge5sWVtnQ9p4jwCzg7u63kafVk+HWhkUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612611; c=relaxed/simple;
	bh=CWSOJRx5fGiD+VWfre6qxlFaVX4Agto1Xz0sb8/ndRc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oumQo3CMapXVaHO1O58LKoojlMTzmnKsGo9zIWuIgjd+PqVtO8ExANajlsxiAvw2WVPqLL8TbovpND17qaEp8HKu+C2VZ49ifAYYGAMRmADqI7s7vyuy8AvJ5UMdD1A0jdHDpCLQE3cxTO3oD9Vhw8aUeNJ0MRMmpSQnYbhGmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maQ0meK8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maQ0meK8"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d568fbf62so2593855f8f.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612608; x=1709217408; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwYeaUigHoLqe07Dyr7OAsD6q6DCJT125jNN3V4+eZs=;
        b=maQ0meK87yYvS1nnBxj/ez3sWz0L3VUXbuwb35yXK7i27q9Csx+/tw3GboGm2wqOyz
         QBxynSj1OLOMj/CzGRfz95TwLIKZkLCAMQy68ON0pfRPT0vlMX5hVijsyAx1zqWpRbxh
         2WU+8haiyCMwuq8vdNAdjlg2v1PyNBfX4ve0ZLFPmfmMOqXhzet/MbmD3CFzjg6vxbfa
         JUFmjHHfFSV3yyNfTLQ84SDnYGacCtgTifdkX+sV5HwrZDlTwHW/bJZXLJi7KjOyZJAZ
         h6bR2rdU7NpV0jzkAtC9EyXNpWjhQmh5jf07aDvAd5XpXntnufcFbiH0lNWG0FFLLPXQ
         z9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612608; x=1709217408;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwYeaUigHoLqe07Dyr7OAsD6q6DCJT125jNN3V4+eZs=;
        b=F5chVlo1L3cE0OJ0W4yQT1bPhMwe9MSBkovuAQDtNLH8jZECOFTK4RJuaFTZFG1Gy1
         xYYpL0t2QPSHadwJqUu1b3a5ClLYJONzmwnezhoXElcHGPz5TBaITziMSYIdoMqZSH2f
         jOMTgUjh8uoElnLWWF6rX+zKR7VJiLbhe8GO5u+3DaO6ggibZZjOv4zXreXpXUiaj8ko
         IfNJCl79okUziVootAUIXpH9wa0FF8fWJrCUINVWSb+7mz7Lda8baXA3IS42I3JRF0k/
         xf+sankRnd+jMyMBm88dH0YqsV24MBrEwRvyMksfXFajzElIaD0k64RdA24VV2GRdVuC
         C7aw==
X-Gm-Message-State: AOJu0Yxebg6sGnREdqHenuRQE0CFEh0Q926X9qMRbbKCDiCMmSOLDlgH
	LwoCRz9n61w/vp42+WRY7RzT/MYIjM2q4lI4yWQW1ospAR6X5k8uMq9nqUP9
X-Google-Smtp-Source: AGHT+IE7KajycQsS9qgG2zSUtc22MGDOmJVFpb71r2lUcuG4YBBqNaM4xE7HmCLhgueml5R8VCMckQ==
X-Received: by 2002:a05:6000:1a85:b0:33d:264d:6dfc with SMTP id f5-20020a0560001a8500b0033d264d6dfcmr14448968wry.63.1708612607713;
        Thu, 22 Feb 2024 06:36:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cl2-20020a5d5f02000000b0033d4dab14a8sm14720330wrb.22.2024.02.22.06.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:36:47 -0800 (PST)
Message-ID: <11b9cd8c5da5e6792ce940ea29d2e93e57731555.1708612605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 14:36:41 +0000
Subject: [PATCH v3 1/5] merge-tree: fail with a non-zero exit code on missing
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
    Eric Sunshine <sunshine@sunshineco.com>,
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
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

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
index 7d0fa74da74..908c9b540c8 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -951,4 +951,15 @@ test_expect_success '--merge-base with tree OIDs' '
 	test_cmp with-commits with-trees
 '
 
+test_expect_success 'error out on missing tree objects' '
+	git init --bare missing-tree.git &&
+	git rev-list side3 >list &&
+	git rev-parse side3^: >>list &&
+	git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing <list &&
+	side3=$(git rev-parse side3) &&
+	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual 2>err &&
+	test_grep "Could not read $(git rev-parse $side3:)" err &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

