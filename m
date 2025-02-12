Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD81DB154
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330843; cv=none; b=Lr/8zpWD5p0/AL/ySp9kScAfY8foGTL0UgLMvFUlVK9mJ55+RjQssSJ+xfNHTuJU5LYDhnmSFcF1YmVedcFQ5UHYLWP2FrcoCLWKwTbRmoPUKdf7kgz5fGxGHWr7hiyOyhGsvJj7a5gLIm2yQpjzc6kNHD1acm9XzlU9kzj5oC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330843; c=relaxed/simple;
	bh=sA2Fl6EaZ/yJyhqVWnSlz2kiXbSnEIokifLfU1UBcuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag5ZnzopDfkPFnv40zk4o3bgP2Jj3huue1dIQ8xB/VSYAuGyDtI3AYKTrVV1u7DhFpKMwJpfBUt7nehu4Yu7P06tNa/FWBGyflaoVMKH4/oJW7JU5ket6n3vJ6KazlEG1b+77XYNhRGY4LBHD0Q340JQUpvimhs0KYZVjWkfGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIM1P4Y9; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIM1P4Y9"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so5434481a91.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330841; x=1739935641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oShxNFBA2whHNuM0znTUdxztBoBluLeuiQwSYo49ZOQ=;
        b=bIM1P4Y9cGEqBB1CxUC0POHWD5t0MkRrOpg1j8RT1lOcxO9cOK2HQLk1zCFunVfo7a
         ZzC/oMPMB+lXqs22v2YR07r+7S882KS6HkowDhgmiTlbcWS6XiwkA3M9wSacAKDeEE0w
         fNg16RiD6AInpsPy6WI1MIWLM6IWAEOxNS5fDCsfYIPtCI458Uz+AucGulQOX0jRPTI5
         vWd5vlB5N/ew7gUxaEj1IsGGSan1SDI88ekU7h8DVYxz616r+/hG+hmpWE5gKGsMvnq7
         LVCWk/HkR4AfOS5vAxD4OOi8wbUqC7IhZLMb4xj7d5mAeBsluMr1NzyElWKaI1RUK08/
         mkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330841; x=1739935641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oShxNFBA2whHNuM0znTUdxztBoBluLeuiQwSYo49ZOQ=;
        b=mB7CUMs1/IXniMT/W38/JM8hRvNjEgfIhwHefq+a6mIg0PVDpGAxIR6kQ7Bnnl2R89
         fpEGe5iTaX1hcyKdRm6SbuxlvC6Kt6DmrZEEOzrR+rYHwtfznDv5baOuLeSnKPsTvBZh
         8UiPplebLO0afrvbzqDjZmGqyTwgFqs00rTV54LP2pT76q0/a7BrCZzvilBQ43bg0DUS
         Y0N0AW1GDbvESFlCfwn0Rv6AOGSaVG0YwxNYoJCW1b4DFKqNKpkQJXPVOX43gIZdy07T
         ajMXbMCFxuHXNIQEMHZan1Ggh83T1QZP0vx9jcZ/E8X0xDHEWVFqOEkV4uKGKkzYm+g1
         956w==
X-Forwarded-Encrypted: i=1; AJvYcCV2okToigSH38k4xg6cfHLxH4yFBwzaEbqghBKfG2Q6oUFtw1lTG99I3EMh4kKHYuia8N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvr7rXJyWk3xrOhm/UTLCm0rn/f3abF2h0EkmjyNrS1Nbps53
	MvKM6hs2PT2J60bicRwArJnqEJ77RvwrBcel5wALJzKi/37YaXn4
X-Gm-Gg: ASbGnctmecioAomiwKkAEOydveL5qYIlESbof8DfrUt3+Pzf6p1mc2a0NgRYw9UPWLx
	O8fUGGLCYDrhpFUtAarrxkMYRMIJBfMrkCgMy2uPmp4oq8iJDgrKuRmbUFHSp8+nHbyQRCfPn9j
	ipSB0DNpwMxOFM8XBr9YhLB9zfzXwg01d0h+xvSbpXNjR2SZ+2P+l3WzCpiP5NucttrGsVZUuib
	V5q05uK0Ipfth6usywUwLk69Z1Eo8rzJj5R8cT3Mu5TB0BgEvrZiXJfMFOokk775euCuxpVKifM
	CiFVyhrfPKt/mqOJ6T5D2xWjR5d2NcwL6chzrtU=
X-Google-Smtp-Source: AGHT+IE3NqvCAA6xeQ4EYVYxr7zJtQrY5SIjErltw2xXnScnUSHmK/5N1NU3dW0DNQGuAqmbRSP4jg==
X-Received: by 2002:a05:6a00:181a:b0:732:1840:8389 with SMTP id d2e1a72fcca58-7322c0a0194mr2425171b3a.0.1739330841077;
        Tue, 11 Feb 2025 19:27:21 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:20 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 07/10] completion: Support --patch-{grep,modifies}
Date: Tue, 11 Feb 2025 19:26:51 -0800
Message-ID: <20250212032657.1807939-8-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 contrib/completion/git-completion.bash | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 41391..daf335 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1900,6 +1900,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--output= --output-indicator-context=
 			--output-indicator-new= --output-indicator-old=
 			--ws-error-highlight=
+			--patch-grep= --patch-modifies=
 			--pickaxe-all --pickaxe-regex --patch-with-raw
 "
 
@@ -2216,7 +2217,7 @@ __git_complete_log_opts ()
 		__git_complete_symbol --cur="${cur#:}" --sfx=":"
 		return
 		;;
-	-G,*|-S,*)
+	-G,*|--patch-grep,*|-S,*|--patch-modifies,*)
 		__git_complete_symbol
 		return
 		;;
@@ -2239,6 +2240,14 @@ __git_complete_log_opts ()
 		__gitcomp "$__git_diff_algorithms" "" "${cur##--diff-algorithm=}"
 		return
 		;;
+	--patch-grep=*)
+		__git_complete_symbol --pfx="--patch-grep=" --cur="${cur#--patch-grep=}"
+		return
+		;;
+	--patch-modifies=*)
+		__git_complete_symbol --pfx="--patch-modifies=" --cur="${cur#--patch-modifies=}"
+		return
+		;;
 	--submodule=*)
 		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
 		return
-- 
2.45.2

