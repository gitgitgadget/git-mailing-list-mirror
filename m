Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02218FDAA
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386051; cv=none; b=YfEdWzBoq6Gv055r3tqr3O4Icp0XzasdLVj8BpT0FlTfoxb5+59RhuEBC7vbw6OCYy5fKF43W9yZ1YwfYK3oFeO/4ZlFurdWoAwjRLU7xWNEWkNPgmangwBDIZPOyir6c50kxHGKVQylhAnHyxehGKFbXAwrwiFKjetA3K7ekxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386051; c=relaxed/simple;
	bh=eMInr5ADkvmLVMCudz6dvvBhqsdNt1eKuHt0axIGsMg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=L3S3xaGOZvikYc3u1gsQrLM8OK0X9nxxYXxDkCCYt+adnAJPlwHdnfN3g9uLazMmglbxNYyYAMPtLxyXGKEVE9szMqdqdD7jQ/NWQSXPYmhhpeqvXU3X1Fow/54d0D5CWYmKBlFmV2O3QYSbOu2rMd7FKnGvvo+jKqrBTYNuGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rud68Gx4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rud68Gx4"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86fa3dea99so309457766b.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725386047; x=1725990847; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW54UX0NTzJEGMgEhLkQ11JbtBNm6F1fIpG8tR/3b4Q=;
        b=Rud68Gx4rqDvWPXZnB4UFljyp7SioqzhfdEFHw4l49AFEOwERwS1G3Zist47UEupsD
         yCb5AmFtD08nlTUVSDl8w8WmvfAsfayPe+xgYPA+xQxPcNZifKpmn1efnJ3ftqvhQu3a
         xk5nQsvmDVuZgtbvTQLPdePiVXf2hGfeMRTjCZRDklrCd5Et4yTyZLt3lwM5ZUqk7vKz
         vs2pfvGvFjCdVNPi3SooEeEuQvLv6Se17yIeeFIQ4c3+wCjvg5k2G25cLLXLm1WqKyBg
         iBNGG3JTJ4qndj590SphiM7emZuTE3rzPYzLTAiBHXcYfAD+erJa0GxINRu6mqe4+syT
         hMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386047; x=1725990847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW54UX0NTzJEGMgEhLkQ11JbtBNm6F1fIpG8tR/3b4Q=;
        b=d3KyfoOhaz30whamTfDYakSrPLR+bAxTOxtLOYZGB+89Y7iV2clrdjSijkijReHM5P
         SHG++O+CA2klLd/LlhcV8rzdf9VhKSDEXD8WX9Ui3OkpfBfpvh6B9x2dTdyqTW3YJykN
         ydEJPLLzkNCvfWNxg5LwEUoqmLKlQzvScJiW44kRVQVeykSJZN5+2UMIqS/t8fjyPMSR
         w3a3gQn6+rRXGgImINGAiGBRaOC3C5Ac2jLr0Gz1WrvLiJ/+l58FYEmbH2TicBx8s+Fh
         ssrdU5HnEOuy+HZN64TgpK1mTcxmCNS4obqW+TjP65uhFe8DOHrUcsslmomb/06Xdu/a
         sWPw==
X-Gm-Message-State: AOJu0Ywk0F46uU+T4+DVUsHW2uTI6nnMt6szpxfgyYpplOUGTNWDlQqG
	7VIpHxhrduK/tfUJHTZ/qi/h+dNm4pAFvqyTBguGo20zbjOF7aZjrTuAew==
X-Google-Smtp-Source: AGHT+IE2l9idJSH5JVcZ/w9GAGL5a+S+F5OjqNE0fIHCJaKYdIt3GCrT8IgCbYme7vtR7zzLcOTxEQ==
X-Received: by 2002:a05:6402:40ce:b0:58b:1a5e:c0e7 with SMTP id 4fb4d7f45d1cf-5c21eda0d11mr18499907a12.35.1725386046887;
        Tue, 03 Sep 2024 10:54:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892221cdsm706167966b.207.2024.09.03.10.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:54:06 -0700 (PDT)
Message-Id: <b310593aec24ff102e2d5cf29c1d8386adbce45d.1725386044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
References: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
	<pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 17:54:03 +0000
Subject: [PATCH v3 1/2] Allow using stdin in run_on_* functions
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Kevin Lyles <klyles+github@epic.com>,
    Kevin Lyles <klyles@epic.com>

From: Kevin Lyles <klyles@epic.com>

The 'run_on_sparse' and 'run_on_all' functions previously did not work
correctly for commands accepting standard input. This also indirectly
affected 'test_all_match' and 'test_sparse_match'.

Now, we accept standard input and will send it to each command that we
run. This does not impact using the functions for commands that don't
need standard input.

Signed-off-by: Kevin Lyles <klyles@epic.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 6fa7f5e9587..87953abf872 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -179,22 +179,26 @@ init_repos_as_submodules () {
 }
 
 run_on_sparse () {
+	cat >run_on_sparse-input &&
+
 	(
 		cd sparse-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
-	) &&
+	) <run_on_sparse-input &&
 	(
 		cd sparse-index &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
-	)
+	) <run_on_sparse-input
 }
 
 run_on_all () {
+	cat >run_on_all-input &&
+
 	(
 		cd full-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
-	) &&
-	run_on_sparse "$@"
+	) <run_on_all-input &&
+	run_on_sparse "$@" <run_on_all-input
 }
 
 test_all_match () {
@@ -221,7 +225,7 @@ test_sparse_unstaged () {
 	done
 }
 
-# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
+# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
 # Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
 # leaves the sparse index in a state where <s1> ... <sM> are sparse
 # directories (and <c1> ... <cN> are not).
-- 
gitgitgadget

