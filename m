Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A412880E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212988; cv=none; b=dLUiyNa/JPwOpxQnQ2ysThKa/6eqvHE4jmr7DsDRaK0/Ud3P9HSCd0ueGnx4AS/mdEUc8cLwGSat9qL9usTqnBvMiwdVy4rwvtW8v/J2kPzGS8IceriINYlHnNzyYMv/JsUySo0XmXLUOaiK+vxPGx4kMa6hMl+AsCPu8kQ083Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212988; c=relaxed/simple;
	bh=UF1LtAtCg3Xw6aOmpz2Kn8rD8A25KkCrQgAaLydPfJQ=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D4mAs/tnl/RdKogSRBa4UDAPcSmYlV6D4qXbkBuX4eRW4nEBM9GaWJBG9G/sDdgdFo5U90RAmTwjTnbC2OznOBUBTgzW3MNYSxpqoJlW/yU5Piw6P9YOTCx9Ti6Moul3eaSbjUSiptDW/kLaMPuL9LsP9WJdw9Tg/ymssZK2nNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3zl0qHa; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3zl0qHa"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b409fc4aeso1101145f8f.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707212983; x=1707817783; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR/xfp1VY9CgeMC+I7NGlzGCLSwaZNZyqDSar95wmrc=;
        b=b3zl0qHaH1VSGwoWtb9I2qwolE+ZbC95rZOMoi84xOt5vIOu8i98shO49950WT+WRM
         7QJD+0IlYVSEfFNCEVJWGjXQYz61A1C2vVlEHCplnopkyW1cdNF+nT4f6Tf8xEJlpmP/
         ICrWjIn6HLkT9Q3NwhLz3ofizilDCwV/xqs0I93Vrwu+UA1KGgdZjw34k4oY4ptixznZ
         OgPJlZe8g5V9nlvepJLBOcxHC89NA8ChQuW8kHrvHiJUEgDWStXEbiiwllpaiSSnayaj
         2M2DaDUKzXKOIM0ZFp5BPs0b7rKNNLWI8cFGw0nekQ6PLtvf52bT2cwsxtVCgLoCXihM
         6Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212983; x=1707817783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR/xfp1VY9CgeMC+I7NGlzGCLSwaZNZyqDSar95wmrc=;
        b=kGtwts+TgFYhsJFPZsgpzBk54JIaSFGSPcaXlREkmVuGneOicEn3H8fqrih0xgPWMD
         UuJ366cJSA2QNF5DqRhupFnvcYFH8nUEeb/FN83/PmodUD6/Lqjb7ZmsycWUTS3uCv3P
         gEbGaziLICOMlOIRv8hqVvVv7uNoF4jBMnnK9ZpldxXFUaxIJXI1zfitx3n5ehHXG3lD
         jhelAt6cghgpJVAccx36nr0ploUIAOf1s9JvXZzxYZLYxtX4SuOjbpDWkaiicPq5S2Yc
         gFfbEvDJShaE/xYmV4ue5lWQovDKDjTEX8ksfjbbi4EO4zN2Slh3RHd7FXatYDG4H3LQ
         7/9w==
X-Gm-Message-State: AOJu0YwZ6iBtZFjSdrlSN2z2+/OFUvpr0Q9T8J1euGmHtAtS/itq8sYG
	cj8Vm1UtwbgWtkx/8Yn2vEkyZlFmYwpwhZ5Q/c/5OwPtXVFOaXHFjdYv2PG3
X-Google-Smtp-Source: AGHT+IHxHbod8aEUhkl3CJShL/ikn871qzlPM+MYHFVJ2lYNpYMQgSTlNZtqj+ALL3wqEL3VgLLJCQ==
X-Received: by 2002:a5d:4cc8:0:b0:33b:381d:a71e with SMTP id c8-20020a5d4cc8000000b0033b381da71emr741431wrt.17.1707212983191;
        Tue, 06 Feb 2024 01:49:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r21-20020adfa155000000b0033b2497fdaesm1637634wrr.95.2024.02.06.01.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:49:43 -0800 (PST)
Message-ID: <a3e8ae8611484f95df15490ea8f1abcec8f4cb36.1707212981.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 09:49:38 +0000
Subject: [PATCH 1/4] merge-tree: fail with a non-zero exit code on missing
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 7d0fa74da74..4ea1b74445d 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -950,5 +950,15 @@ test_expect_success '--merge-base with tree OIDs' '
 	git merge-tree --merge-base=side1^^{tree} side1^{tree} side3^{tree} >with-trees &&
 	test_cmp with-commits with-trees
 '
+test_expect_success 'error out on missing tree objects' '
+	git init --bare missing-tree.git &&
+	(
+		git rev-list side3 &&
+		git rev-parse side3^:
+	) | git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing &&
+	side3=$(git rev-parse side3) &&
+	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual &&
+	test_must_be_empty actual
+'
 
 test_done
-- 
gitgitgadget

