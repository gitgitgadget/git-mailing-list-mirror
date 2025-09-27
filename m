Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D92E6CD1
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984660; cv=none; b=BCo9xDwwK4I5/+NVPUSK+8DXsojYRy1PkQXOdmIKGeBvPU4bSmqT93ZZx2mDAQjaMcS1GwUHviDprmOCBqJsNk8fmCTQOVCnnsDPpwPjk0/txrPiuuXfiXRljKemiwtTuIZ4N9eqe/5Nk4v+ZUHOl3fpRHU9rNFuMcz95D7hkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984660; c=relaxed/simple;
	bh=Kszwp6+0tMDHiAfRyn9qNChVAcR18Sd+ZsnEq0OQLxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1iPX84GHKEZqJglkOS+qOK1wOZ60oRU4BLiL8VXYN1haCEWZtnfMoxwvIqBxwI864He6SsS8VgdBzPRhPtKgoWxLch6NZxIfErHP2K97IfCX7dbJYPPf+Vwja3H73Pp3vzOnNmTxdw/G+WfBJJHbUMGO0jZt5VcpT+5zmDe8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghckvY9b; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghckvY9b"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-64360622b98so55687eaf.2
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984657; x=1759589457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcRT2ffP+vxI6AVhFBHJkLAGJBXmvRXauD9r00j0AIA=;
        b=ghckvY9bNJOtEovOT0cgSOUa8qt23jN+FYkPvHVlR5ln6Mee04kK9w7taOuHNibSHu
         o6TMKjr4aZkNnD5n4Cp2aKZzv6dF88h/OfBd/8L/iolT4bgvV/A11PPR7qsMPfJRVI+C
         sOdWQ6OQZbbSb1CPVakmKlV9/j+Se9XSnvzP8TyKz+ovM4cr/njWH/h84fnAAeR70bl4
         6Grm+z43iEZY1P6521AAfEapqVtuyBIkYDyZKc/LJiaSgkq0VgwocZwLAfIhuJqaLBtS
         ea9k3G3lLskmfb9B8hZadytWZF6Ly3pU32SdBSh/zqQ15/1IR9YsVicsg3wYc+Y2lvFb
         D8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984657; x=1759589457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcRT2ffP+vxI6AVhFBHJkLAGJBXmvRXauD9r00j0AIA=;
        b=bfzOGB8pxga+nrtuQPKoUdjvxGdkwVBm4LHOEYxgcTwPLUS8vl0CpZVtZnzVWQLg4y
         XrWBWTzlrh+Lkbr7+zMR0vAT7E8cXMZFaro2/KAZz+RcdmC3otqA28k6t2bqQonoq+rQ
         bPjnlieMUWg0fv5EiBszIrq6EK3dc8lvOqOKT2FXQgyBj/8Ei93h/3cqW35RjeaQkgly
         MeJEm1E6tYlYRoVKY5hT6m/V2N8ee5qImti55mFKUOBn/BoiE+Y1GF6oCvnOn6A8Fkxr
         gX8ShyobZrGJJAuYQhg65H06VpQyGi5XwR1P3xWJqKR85sssIfzrIagWkXJWEe1clRzM
         bBsA==
X-Gm-Message-State: AOJu0Yy6Yn5J01XQwmbaFF8yksKdnW0lWhITc2vvsKHkYmc/j600SAa/
	9wrRDsQTrwl5p8kxX/pDB5g66HZThd3bXI97JnXdSyn+JQI/JZmfFaGc77Uf+Q==
X-Gm-Gg: ASbGnctTrdVxSpiOODnU/o0+OubxRrSU1V1Nu4tO6nxROQ2mR7Qhs3xuQVlQSb7rqAF
	+ZDT9RYeEX6oV5qh5REZ8RvUK9UfZfL/xdyeufB+CsxashdXYH8FJuCMBEwy60eh3CU5Pv3JPCn
	s4J0SZvz51DDyhjRkRwvoYpJsCvE888aH7trJfZFD2FFBoRMpcV9YU50vfo9GbTp8a8d2W2n++8
	g2Wnz4e+lbB4BmbZRdMBI6j1SUFNKmIUHBEeOfxnekGZrZGfKoPekSjzX4IuU8hguxLJ2F0/DUC
	Kx7WLeDCRlQuEfPLKkmvJ0AhZ/lWeDpWM/lbflKG/5og5JtDB9mWnc/Qj5KgqFn6XKRFUkGK3Ol
	FBXuYPDsJCNkqFsqD3TDfoEnt/dSj094=
X-Google-Smtp-Source: AGHT+IGKmrQA+1lp02KuYdzOfdXYt23YD+PCyeh8mc3lus/sizNB+RGGP4sEOhs3iGAaGlqXDWVtSw==
X-Received: by 2002:a05:6808:1703:b0:43f:3d56:4dad with SMTP id 5614622812f47-43f4cfa0406mr5723913b6e.38.1758984657584;
        Sat, 27 Sep 2025 07:50:57 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:50:56 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 3/7] clang-format: exclude control macros from SpaceBeforeParens
Date: Sat, 27 Sep 2025 09:50:45 -0500
Message-ID: <20250927145049.723341-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The formatter currently suggests adding a space between a control macro
and parentheses. In the Git project, this is not typically expected. Set
`SpaceBeforeParens` to `ControlStatementsExceptControlMacros`
accordingly.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index dcfd0aad60..86b4fe33e5 100644
--- a/.clang-format
+++ b/.clang-format
@@ -149,7 +149,7 @@ SpaceBeforeCaseColon: false
 #     f();
 #   }
 # }
-SpaceBeforeParens: ControlStatements
+SpaceBeforeParens: ControlStatementsExceptControlMacros
 
 # Don't insert spaces inside empty '()'
 SpaceInEmptyParentheses: false
-- 
2.51.0.193.g4975ec3473b

