Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB196823A6
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324470; cv=none; b=Gqq/uVNhpWPkQW+xOq1EE0jKNllUAhrbnI+M5pSoJ0SWiT1fyhP2TqfwiSYUmPo2u8D7rd/rI/aFRcKfoR5QW1PlmQK9ONpScBhleUC2xfcrvNpayhurNU4DqZDO/993WLJnmtq1FzPgJaL4vzF3+Yq7gCAlwOzirubPkxw76lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324470; c=relaxed/simple;
	bh=JBcRPa5nLeGdC46g8tLz+o5+9Vy2lA1k1AxBYPjCeJY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jLiXPdB9MbGWnqeiia6XqWrRnbYOsDTOV1BdwrtR+R69RWMKmBdbrLhnH+iYx0CskCut44+muAMygBKR+NOdGrPrIR8GjlMT4PvGzbsm2W2WhQRiPBN33wwgollzYH0zboHUKC+49NGXbs23NKeo/VEzP0jOQ6MR5F1h3pA9Vi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdIo6dVx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdIo6dVx"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so613506f8f.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324466; x=1707929266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT8tDqMc6Facujm+HRzNQdJHHRzp/n1WW2khUvavG+M=;
        b=DdIo6dVxm6wd/qDWexcDqXHxhWZmCyKZSxnDdX9PqD8fBJvR04h0J7BbRNAbmRPZxK
         poqti+bRYLFlIUMVAK+uFqd3017sBZJLNJUTVAEjSnB+u7HPhV8o2sl5FPvoYM8Y/o9h
         3d3SjsS6y/ttLp180eshkh5plbZIllts07ltX8L2ToqKoE/tN4mit9cHSi93uirpOXfb
         ajymqV3uzq6qwLz/w32Z0sCY2VmIyfuT5h6vV/0CufJ06KLCVSRs0zGpcZ090QUWnyWG
         WoSlcSs6P5eogkEp4ldC4oCjiXo4L3nqiHJQmVREFk2fwWdKoGAk+K3n+2bRx7XTi4Rp
         ti2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324466; x=1707929266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT8tDqMc6Facujm+HRzNQdJHHRzp/n1WW2khUvavG+M=;
        b=CoeizPWMIjkvOtPExMOXtZ8O7CzXDoF60enHiJkGx0y0LOYNQ+rIyxJQNIQcSrcCqG
         ew2Er6+J1/05RumhmZIZ807v2bo8aeka8H69DrBEA3lZUp/nzhDoOHHW8fGeVSK8KBKn
         GZq/3mMtS8iDOeJsDoYhw62uxyqjc18gCZseT7JT7L99mzxOdLyEFSbFHl3dCnGK/TwQ
         QfKFIQXJ2gA4QqzrdeynmtFhdkgusuXRmnAump+1uiaUKC6GHZEhjqZQZhp4aixcua8s
         DzDOiyXgIR0Soq02vvFoz1rgVTmHsgKXOHlbCiVJ/tj2sEMFAMwwl+OwY63WPHpB95gz
         E6dw==
X-Gm-Message-State: AOJu0YwJqEOHAP4A+KoOjrwwVzU9iftr1Msb0r83HbmHAaPs8RvoVrga
	e1rS67mlJ8lX3nyc5g5K0xbVgiQWx8f1jx95IDRnCnKMvmUTj750FPtkc+Yr
X-Google-Smtp-Source: AGHT+IHuzIDxqTRxoJOSlQhp3PHiMmaatYeiIby+FctNlncKq2I5O9iws9TZA76GwfR4pLy4QuGiGg==
X-Received: by 2002:adf:f44a:0:b0:33b:3c04:ddbd with SMTP id f10-20020adff44a000000b0033b3c04ddbdmr3524667wrp.21.1707324466252;
        Wed, 07 Feb 2024 08:47:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/Azh+N76v0KuaBBgAJ5DQp+Zmgt9edAbJjNG4mpUhA7EHSG6qrRQXA5rbK5SwKqjSrQsRViAM0zoH3yQf5PxZwzbJUeTrfERCfg==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe7c2000000b0033b4dae972asm1866213wrn.37.2024.02.07.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:47:45 -0800 (PST)
Message-ID: <be1dadf28502fe3e9662fa61523e8c57ce3352f1.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
	<pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:47:39 +0000
Subject: [PATCH v2 3/5] t4301: verify that merge-tree fails on missing blob
 objects
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

We just fixed a problem where `merge-tree` would not fail on missing
tree objects. Let's ensure that that problem does not occur with blob
objects (and won't, in the future, either).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4301-merge-tree-write-tree.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 7d588557bdf..9211cb58aa1 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -961,4 +961,18 @@ test_expect_success 'error out on missing tree objects' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'error out on missing blob objects' '
+	seq1=$(test_seq 1 10 | git hash-object -w --stdin) &&
+	seq2=$(test_seq 1 11 | git hash-object -w --stdin) &&
+	seq3=$(test_seq 0 10 | git hash-object -w --stdin) &&
+	tree1=$(printf "100644 blob %s\tsequence" $seq1 | git mktree) &&
+	tree2=$(printf "100644 blob %s\tsequence" $seq2 | git mktree) &&
+	tree3=$(printf "100644 blob %s\tsequence" $seq3 | git mktree) &&
+	git init --bare missing-blob.git &&
+	test_write_lines $seq1 $seq3 $tree1 $tree2 $tree3 |
+	git pack-objects missing-blob.git/objects/pack/side1-whatever-is-missing &&
+	test_must_fail git --git-dir=missing-blob.git merge-tree --merge-base=$tree1 $tree2 $tree3 >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

