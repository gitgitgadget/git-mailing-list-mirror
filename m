Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFA26290
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769905629; cv=none; b=mVogZurRf+THr3d+ZlBxFv63MiRvW71PUjAuRdN8grUyybrmpXoGq6HWkRe63eColXxnyaHIKGqltUWrXDWjEUciwHP0KFY0eoNwcnuWmSyUuCNCL93xPEPzdMjrx+0TqZJkWj/Ddy0jtjwMcKDPBiRXorZynYw+iTe2OyvBWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769905629; c=relaxed/simple;
	bh=23cEQy84AHV6oaeqQ6WLHnB8TckfOO3caSHmUT3OBTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixjZp1WKUyQIKz4KpQXgtchDPus9lPpAfX1HrfdBdO2ku54p6I4D9FThWATp8AuqCsWiCthpZ4UDfQDk9OdN5TW9iLht5uR2wHyAOlpQJTHLkfnQF+2ovt3CW8vevx0fhotfVGJISAwot+CTHhIhkOVgJLWzYz2iAoE+tcZ3lIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZSzeYKe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZSzeYKe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso27469045e9.0
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 16:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769905627; x=1770510427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz4MmXSzDvzqR50Q9R0mIMA+x0dQSGdkvVNZcSMo2V4=;
        b=XZSzeYKeF0PM6hAT1A64dMciKnRQMSTBoZygQCZ1uG7lEmdVJZWbAx5qKhu/OSfpKn
         0CUP251EJ+JeMTLZ7UWTZ4AhvtURBFkuw7fV+5tAae6voMuFRgkX4S+ZKeO4TA8bInJF
         ceqvp4/R8G56tSDBLMHeoUo9bzU+R6g+2P9+psvUeuVw88LWNE3C9JsF5eP5TbJtqqXc
         HyUKa+1a7tWzI6Jjx6tYjYsTE3Y09Sn954ZT556UyPeXTebx7QCR69BYcMQZ+TuwPVHx
         ty9ld1y/FSDecR577AJ+HLks1NHphREhuVj3jsoNyFqcVce+NokZF15en/9BG+IlicZR
         hSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769905627; x=1770510427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oz4MmXSzDvzqR50Q9R0mIMA+x0dQSGdkvVNZcSMo2V4=;
        b=AdjqLwaV5FaCnAhz1aN8oGuCeM42p5BaAkT38bBwJiiopf3ku8YX6RYnSQYGUgRMfh
         /PuBUwdyoAZHnzzaVZ30grqF0MsqzeKfqn2HOVqGWYcy2BkDilwnT088JiS0YroyWo97
         q5ANX6HuimWIGA6BgG3u6HLDmRaqO5knba3ZhfWG/E+mJIFapTV7wtN4il+pDsMtd33o
         n4Pba9Jj4nol6/07QJDLKTK4QHgJK7TbmaC1dccWEAk/XvZOTxq+n67thQOG4LeHOGfs
         8c1tfOAvjMyIOevWyEP6DKhg6um8GSAFA3ClMgjQ0FK77Pvmvlgz/EXPgth15CB3VZNy
         XF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUgCNJPtZxIzQRu1NH0jEhBfCEjkARBl7ujJ0RKLBgZ8Ln1YYFtgTK+KE4aRtkUJI4UByI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5v+3wexhzBzQlH3Lws6qm5tuV5qlR4snNW6RJlrHMGzrdFN8H
	zsV6R7VNcZt97kC9LC29pe+V9GRY++9+s7eEyP7QjXZfquVrkhWCF2lt
X-Gm-Gg: AZuq6aLxI+hzl5cAbVtzGDVVhrk9qR5wvsHYF3UaMLc5xYFEMSNt33Yrv/scqf094LR
	4Vvi1n3uY1intJBmsxK1GKWQrbTAR+sL7DeLiCYV5234Ppkk5kjY5lutdZBKedxEA4g/Wt86KhS
	mOhBj8VFZC+bgBQDSgOKNE8HjqE/OjiRWqmDvBZVeurEuRSPT3Us+njq9u1ty13Hkwc4Lrpujam
	ikaiTWf8u8EFQllGAWb0aLwh7ZNzVFmzZQ9ldqCWFygiz30oGdMtkfsiB43cbuS6AW4f07LYjsa
	GbaFzSbCq2PIqA+2roDkC3p2o7kV6ijiya/MpzvWnB4iJ2jDrZ4t7NWTB6JCU83kLrhqmAV11ss
	lH9B2cBT9ofNHJEWYI1oakewCbedFQoNaEvEmU3EEjksQuPVG4/wSq42LsQYpRdoP+2Kb0TmZ6b
	vVuJPRpv0Q7U3ub9JshrBqMq/M8ynekV8dRlbZQw==
X-Received: by 2002:a05:600c:818f:b0:47b:deb9:f8a with SMTP id 5b1f17b1804b1-482db491bfbmr90171335e9.30.1769905626489;
        Sat, 31 Jan 2026 16:27:06 -0800 (PST)
Received: from uranium ([156.210.131.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e047d863sm55541895e9.1.2026.01.31.16.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 16:27:05 -0800 (PST)
From: Abdalrhman Mohamed <eng.abdalrhman.abdalmonem@gmail.com>
X-Google-Original-From: Abdalrhman Mohamed <Eng.Abdalrhman.Abdalmonem@gmail.com>
To: gitster@pobox.com
Cc: tmz@pobox.com,
	git@vger.kernel.org,
	Abdalrhman Mohamed <Eng.Abdalrhman.Abdalmonem@gmail.com>
Subject: [PATCH v2] .github/CONTRIBUTING.md: link to SubmittingPatches on git-scm.com
Date: Sun,  1 Feb 2026 02:26:43 +0200
Message-ID: <20260201002658.133153-1-Eng.Abdalrhman.Abdalmonem@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aX5sNO4aMVE-qcrz@teonanacatl.net>
References: <aX5sNO4aMVE-qcrz@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The relative link to SubmittingPatches is broken when viewed through
GitHub's specialized "Contributing" tab. Update the link to point to
the documentation on git-scm.com to be consistent with other links in
the same file. Also, wrap the line to improve readability.

Signed-off-by: Abdalrhman Mohamed <Eng.Abdalrhman.Abdalmonem@gmail.com>
---
 .github/CONTRIBUTING.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
index c8755e38de..93042128d6 100644
--- a/.github/CONTRIBUTING.md
+++ b/.github/CONTRIBUTING.md
@@ -10,7 +10,8 @@ conveniently send your Pull Requests commits to our mailing list.
 
 Please read ["A note from the maintainer"](https://git.kernel.org/pub/scm/git/git.git/plain/MaintNotes?h=todo)
 to learn how the Git project is managed, and how you can work with it.
-In addition, we highly recommend you to read [our submission guidelines](../Documentation/SubmittingPatches).
+In addition, we highly recommend you to read
+[our submission guidelines](https://git-scm.com/docs/SubmittingPatches).
 
 If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q4&feature=youtu.be&t=6m4s)
 might be useful to you as the presenter walks you through the contribution
-- 
2.50.1

