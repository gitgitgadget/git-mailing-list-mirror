Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CA52BE4F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985532; cv=none; b=RApkhauY1DtyY1nZ99hRk89ekgrRZjp8XZJVktDoC66O/l0W1QdF2uuHdMf5Q4OhpNyqK4D2bXZpwCitvTcA4VIKIi71XMAbSSUMJ9L/38jgp+exW4Xcwrp3RgApLU62hM4wJ9svFWLbEhqGDXGYBmknT8BtacIRPhmBiFarqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985532; c=relaxed/simple;
	bh=uqEKmwfBZ75wXHUn4/Bu1CNFvnBxxN1wpUYrdWynqy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QV2EQTdb0A5n1D+nL3BUu1TD6QMMaSq2sLWzQB6CYescK7UoW+ZD3My+A1mEr1bN32jHoKYhbp9IkC+qYrwu7b1aKnkrVOk8FY5ip8Ws2+r9UMv0UDKnorbfTqp7eEsl8JbGFp6tQ85vBlTHZc9eUlcVhvXDoPCSbj66TWQh2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noUUmycb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noUUmycb"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-487049569b6so2890579f8f.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791985529; x=1792590329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJCy6Npt2RW8zYE5++VzlBWJShQ4Sawjc18QACCLgdk=;
        b=noUUmycb0q4sO7+tiDcG7jXgfrg4jSCBmNLdZ9W5Y6G4DtzLg3eztBgnNGgUY/PN0x
         VWrixYGZhaM1v77kmd5O3BkoX9JI0P0MeG/3h739YMq8DSCJeYV4fF8zqa+9g6f0ybiw
         ZoD3KrS6EHCPVwREFrkov6lbNntPR9VyQpA2onPaVMWIAlwYSZSlOHenuFNHmZX7mcG6
         QSAkvbHe7EOzofwzgWPm1xpN9ev0tPLftdFH07X8S3wXNq9bUGMZMeG8KRKA4/MTlMYv
         O9AZ/Ls3GH56z2u8sg6qLwE6tTdBPsaL0ReNZWvxAtdOMXbgUFZdFRaYwlwtoWZiuaD4
         cLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791985529; x=1792590329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJCy6Npt2RW8zYE5++VzlBWJShQ4Sawjc18QACCLgdk=;
        b=Byl+Z4ZRytp1d7eikNTkT4OBfZapmn3fiTNN5BFaQCzI6BjH+uQJYaTzn1mPRPVPSE
         EfblChFoDkTKrSb8kcuja2hqfhT+XQ5i4+jh4s0X10wwMHdyyFZIA8gjlyHHKPtqqnEt
         L/W2hgg4tc86urpJ6l7YESL+5+sIJF1QR0oCP9mph7EkBjzwo5BkxX/mZ1ILbzH9JHjl
         JhWposjpo2dPx0cfYI27peWG/nK7oW3pJi0audeWfGSDD+NP1gT+de19gdgRaCy4dQwT
         pmZIfLVXCwxbsTwTcXWKpkgT7Qyz+qK3EunxhB1gRnqQk+emso4Ic/9LAH2jNOhAQyxh
         +CzA==
X-Gm-Message-State: AFq9FYKmuhLRONManFi/LBs7825ACgH4OLfT0++vJsFLHVmWA1egQ65n
	hNB56WfW739kw13pRaCz2soTITdsFigrm7sVXsY/wynv9YUDyPlFCZRJpA6Vgg==
X-Gm-Gg: AYBFou2bd6kzmDF0vCztbTEw7UtAigsb6FKNTCdw/oE5Sz8ab+pj4I8GAc+FPd+OjDk
	1+y9W8xnSj3OcqjqHAPD3HBk/Inbtucv+SvIciUW3R1XmljzFLHf9SiLFdZXQTivxHW57JKnWDZ
	DcUqexaFRYh6mwx56HVvBhLnSz7dgFsvQF06b3Ac+AyZPvwMD/bAiX19v1cyc1GP5NXFyzLJ8gc
	92A3vB3K3WikUEqGFl0SzTZe3is6EZ/H/yRD34AzdjikxUPRNesm6Uw5JlL1uJeSrZsrH66ZnXW
	WyywZ8yBvyTt6m8okWXIafvVXJ0pU2epL+P90NLl++pcGEV6UMmW6zLMH6rqbguFOQFHsv53uxz
	Rqi2kl/lmsHItnbjwEDILxytwS9turqZrvCOJceUX6iYQnJXfxUgGU7WJA4r3xDrmBupqx78uvr
	pS1unpfWNj8VQpSlWCCMGR+g6h0fnOvW1A3rDeto1CujLhGtBy1/TmYdKGWWpSLqV0z9L6vLWjB
	jB/em3RptoMga2VomXaeUuHR3dbuE29QYQv/seQVETS
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id 5b1f17b1804b1-4a18e4d8bbamr278042105e9.27.1791985528628;
        Wed, 14 Oct 2026 06:45:28 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7003982sm9334303f8f.8.2026.10.14.06.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 06:45:28 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH 1/2] t0410: use rev-parse to get the subtree OID
Date: Wed, 14 Oct 2026 16:45:03 +0300
Message-Id: <20261014134504.1152225-2-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
References: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'rev-list stops traversal at missing and promised tree' test gets
the OID of a_dir by piping 'git ls-tree' through grep, head and cut.

The pipeline goes against t/README which says not to pipe the output
of a git command, since only the last command's exit code is kept.
'cut -b13-52' also assumes a 40-character SHA-1 name, so under SHA-256
TREE2 holds an abbreviated OID.

Use 'git rev-parse HEAD:a_dir' instead. It returns the full OID in a
single command, the same way TREE is computed with
'git rev-parse foo^{tree}' just above.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
 t/t0410-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 788e9a1631..a24b663f73 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -405,7 +405,7 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	TREE=$(git -C repo rev-parse foo^{tree}) &&
 
 	# a tree referenced by HEAD^{tree} (tree referenced from tree)
-	TREE2=$(git -C repo ls-tree HEAD^{tree} | grep " tree " | head -1 | cut -b13-52) &&
+	TREE2=$(git -C repo rev-parse HEAD:a_dir) &&
 
 	promise_and_delete "$TREE" &&
 	promise_and_delete "$TREE2" &&
-- 
2.34.1

