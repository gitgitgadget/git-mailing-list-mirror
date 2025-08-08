Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565923AE96
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693560; cv=none; b=gZmYKrBRmuAvKsU+oZt5b2TjfpMIlgCJNOg+bplpRLxiEw7CEoiWLbKcWI8oKVl3j5L1cZGxY6VRcSJvJbfh8QoekH3VkFUl4hQO6VagA+7yGUMen5K5SBA/XX9Sj08UnwyU/UMfgawgcn84U6tox5eyRfT/suzNBtH9MkJxfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693560; c=relaxed/simple;
	bh=5smaPi0nar8T3bKkVFgpao9Fx7NqUVAhAAaImjPII2U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b9vh3ZcvBy+TneEKpEe9JLZXpWfqKUABfzTbW8Sk5O8APdK9M8k/TvsfsruYGef9oM0GqI7WOU42WQc+NPL78Y3H14d8P5BRh+VINJ0tbVePVX17UQqBokTqd5tZmSdouDzVSayenmSM6g3ijcmPkOh5LCKl2UzeP/coqy4zJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPM+A7WJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPM+A7WJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so22219635e9.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754693557; x=1755298357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoUCiBYCZXwmc89JN53sBq2aGrXcWtFMAZHcxVzMOkk=;
        b=GPM+A7WJW/V4MML2jyhsBdMbQwieVt1dCztlzikElmgfM/OEcIPlg9SCxha38dFgnf
         mcv5Pobr2AHaVTseTw6GeyOWYx9Jz52RRwa2WwxnL1JJ4T5W5rzvLkko9xDe4eoB5rKp
         7qEnVlCbtTEtAozVYkf6Gtl9HLVcMrYDCU50FZKaelahJ8WdnVhsLWvirU+0TYmDCZ3Q
         v4A7QC8en4lqVOHRtVopt/F7XHnuic/BoQbw0PC3XM4pKB9b7okGTs8DSYXTfegs8ETs
         cn5nXsUFkSa0HHS5qMmNn8wN+EJii/0Bg18+VWwqt+YQNNHVNSCN439v9axmhcR4j7x5
         6S1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754693557; x=1755298357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoUCiBYCZXwmc89JN53sBq2aGrXcWtFMAZHcxVzMOkk=;
        b=FOadM1CMZluOchDlWTN5b23WytNlzqV8jXX8Xre3ivCBRsLeO4WhhYtgXoLsZ7adcp
         6puIH1z4gCanG0mqJ93uwVhn3ckzsR+8oJv5uymFLvKYdFRJdECqeZIAniYanNPdOo57
         Hy6Xa3LnOXe1b95ry3BuNI1CJXqiPQKVYzsrIOLRo5Oqjj3Ied+gqTXD0qckbrOML8Qh
         CKHLaUGo9DPWKfy1DIzA3kYzntrCDaGXEmb2LGvdiLBAzajkpaS7h8VvS+LdqZH5fUHs
         NNybxGRX2xegjMnMfYhLoR6baUPtbLAb1aaYHDgOE6G8zNP+G96dNooY3CsXC6vB1vhN
         HpqA==
X-Gm-Message-State: AOJu0YxF/y48bCSZjN34L+IHf8doUdqFyhvanhLj2T6vV6ONjP4uIqsR
	OZXaBuQt1CGO2GsHQ8Z6hvgnoqW/bzJRsEpBkhmH4AKNswv5UCmw5MXPO1GeKw==
X-Gm-Gg: ASbGncsf87Hv6ml8CwNrskFbkQFu2RxSKzE9Sk796lar8kWwkjeTZBZZChi0nPDBtTv
	2jOtTU0/393YmF/ifcDLTtsPEusg0tV63S5qq6FlEvsWB0Reex+eQ8571BKHiOb5pgKTqoX69Cf
	2IuFEQDjSph1WUDOultpwABg1JKS8mI07OsE/xqaG6ddsZ6YaYpyIMcCWIsxTBVcJwwV0Qr5BP7
	m5QgWMMg5XfBclhqYupMT8KSb6PXOPRvV9nep8sTUhS2YjkdW7UIB2vdDpVpq8B8f2YxB1yjumx
	1QPLNXJee0gJTC9TBKzxZW11dXJ5o9BAn2WfR1yd8DS0PggoSVqovM9OXMxR0twF2Ml13wnB5h0
	8+4MmYr4psXYbZsLL/jRa+Wo=
X-Google-Smtp-Source: AGHT+IGhfsLNTxiObU/+1R7W+PpQhURwXT7EKA1+eY0d4ubBAb1SazH47jYBwzL2PHf23iNJot2ZUg==
X-Received: by 2002:a05:600c:46ca:b0:459:e3f8:9308 with SMTP id 5b1f17b1804b1-459f4eaf6e4mr39240005e9.11.1754693556449;
        Fri, 08 Aug 2025 15:52:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587d378sm150166045e9.23.2025.08.08.15.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:52:36 -0700 (PDT)
Message-Id: <013a5044ef3dcbeaed0e819f21f62a7e398e35d6.1754693552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
References: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 22:52:30 +0000
Subject: [PATCH v3 3/5] doc: git rebase: clarify arguments syntax
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove duplicate explanation of `git rebase <upstream> <branch>` which
is already explained above.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index a93c616f38b1..e700b92e35ac 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -59,12 +59,7 @@ one of these things:
 
    git rebase --skip
 
-
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

