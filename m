Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14C2D6603
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531680; cv=none; b=buOxA5NDUt/sURQhSGvObHRELyWTHL6ffvrl5WrFuiCDnBR/YkxYAHZe7Nhzll2AiMCXSxyTG/mqk1eO7ToU85g0vY1yzdqNnSlxfcU4OCf5elrVeoglMsuIeTSL0C3IviMwlny+wfTgs16mXWKFa1L2+Qsl7rcd7mwZLNCoQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531680; c=relaxed/simple;
	bh=wLZX+NX4DR6jhZLuNrLcqqKmDi4GodXFgC5gcWg+VdU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s2ykdXOvz9I9tMjKpf38UdehOu97vPzsb7ia5p8MT+VOiXaPYGPE0fhw1hVOBncJmmIIQ0Ccb1NG5UyrmsZ5qEIsq3KZCtySrYfhv4ZrgQtr2ja0sWPTMJMRntCUXB9DWXgP580pS+iav1dSH7dulyKJOBkCaA5nWkMKKyDly+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k04PuOuu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k04PuOuu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77269d19280so6743380b3a.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531678; x=1758136478; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJIet+DxGDfeIVSrl/H1f9MRp6p6lMKD1L3gQWNYOc0=;
        b=k04PuOuuyyxIrsxPJWoApW0Ft/k3Ta6QpR0nZMQQN+zjoxL4MbsNdtiI6zvmRDvp8L
         RyfU787Tee/+ZT0cKDsQubvfa7fBnVqWJ1tMCmZVsEeT1o8tgiCWLFVm4QerBtSo+LjY
         ubupp92CiSTqHs6dEZYtEGGxoPKYLPCTGPj1/bvS+zCR82HCYF/3hbxzljGN47evMvdz
         QOgNeKDPC2JX2TMV07b8w+mqgzyQw3gUdjSYnSsPXTTfVQLluMeN0NgWPBqYvnm3RV6u
         MZaXS2tmhV+37xG4q1u5KqMe124vQ4f1YmCWa9pxdx18uDBl2VkDUzVcXb2BtU4+WrjQ
         HrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531678; x=1758136478;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJIet+DxGDfeIVSrl/H1f9MRp6p6lMKD1L3gQWNYOc0=;
        b=d2inwN5fw2t4W+X6zrsRfrBV7xdpiL34XnPh80zY3JN4CSDOvj9LlZdssrewu3+cX8
         NDXgQVtWzdlbkJivS8DtTVmAM/ESKzaLXx3RYvobiVo+Au7AASPHj40kU/STstR//OE6
         +4yhVZHRATBZuoJhuHoxqsj7ph1VIZFqPR4muY8b3fKC2mdzDACxC72S5fMQ5LJcqf9A
         JMJcluRQYp9nISCjJ7dgo7YhwOLlC1xfkn0rEya607bO7vJexHTO6+3EHp9OFrJJvze6
         tJn4IBVd4Gljz6/iU7B8ltey7z+l4tKmv1qAsP0TMHTob+f0zu6fsMRqJ24+VeHC7vbS
         FdUg==
X-Gm-Message-State: AOJu0YzFS+Wj7sQpHO6eqehgiSZq8gA2j/X1LIK40zWt2Sp8Kch3Ccqr
	iZ3OC2mVBKEjNMMB8lUXx6wpeevksp3AVznYzH2SSp7mqXtE0DTamG7w1r7w5Q==
X-Gm-Gg: ASbGncslZa9pUPRDfVJZVPWlaMycVOLOAtU8BC/M1fpZ+K+c3Sou/TJ0+E/1tpNTDzc
	Z2poCRy4Edgrd5+5s7Q/UBHK17i4PzBNRcYfRDXPJ/Vc1PeWOnD28wHAOA5U9qvBipAM/o2goNc
	y7U1uv0vKqNNZtE5fg0XtJpMqtL8lCx/Yh61K1ayMCFAFkbrxC47/R+O33UCXuaN0SmLOFYEuKo
	P+wHRGuSVYJ5hMbZN4d/oamD8nH+dAvjTFmtlU/g4IdMI9Ekz1PNghHvReY3pkM5djx/jHjgXXc
	e2G2BVZfct71u5rPuzZmlCSh4adn3G22VOxb1DTP5KxGtGT6Qjtow+CeJA6yveQS/lhrRSrp19O
	p1crXpR1LpZ/eoqVQvJGv5SFts88=
X-Google-Smtp-Source: AGHT+IGYivUIsC6/Qq1iFgZ4NOsMTvNa6/XGyNFwMvBoRbYo6kis9hXo+URYXrt5TEa4Ve9f6lNVUQ==
X-Received: by 2002:a05:6a00:23d4:b0:76b:d75c:8a76 with SMTP id d2e1a72fcca58-7742dc9f446mr22614642b3a.1.1757531678230;
        Wed, 10 Sep 2025 12:14:38 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746612d9c5sm6008393b3a.34.2025.09.10.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:37 -0700 (PDT)
Message-Id: <e7d9641125c78924aa7eb8d0534d361d760ea534.1757531669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:27 +0000
Subject: [PATCH v4 5/7] doc: git-checkout: deduplicate --detach explanation
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: several users say they don't understand the use case
for `--detach`. It's probably not realistic to explain the use case for
detached HEAD state here, but we can improve the situation.

Explain how `git checkout --detach` is different from
`git checkout <branch>` instead of copying over the description from
`git checkout <branch>`, since `git checkout <branch>` will be a
familiar command to many readers.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 7ae2ae9483..dd3cbb210d 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -66,16 +66,9 @@ uncommitted changes.
 `git checkout --detach [<branch>]`::
 `git checkout [--detach] <commit>`::
 
-	Prepare to work on top of _<commit>_, by detaching `HEAD` at it
-	(see "DETACHED HEAD" section), and updating the index and the
-	files in the working tree.  Local modifications to the files
-	in the working tree are kept, so that the resulting working
-	tree will be the state recorded in the commit plus the local
-	modifications.
-+
-When the _<commit>_ argument is a branch name, the `--detach` option can
-be used to detach `HEAD` at the tip of the branch (`git checkout
-<branch>` would check out that branch without detaching `HEAD`).
+	The same as `git checkout <branch>`, except that instead of pointing
+	`HEAD` at the branch, it points `HEAD` at the commit ID.
+	See the "DETACHED HEAD" section below for more.
 +
 Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
 
-- 
gitgitgadget

