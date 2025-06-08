Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710171F872D
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373794; cv=none; b=MLXFpcSVFoYZmHcXdrv17gorHkeVrDfLliTfKup/cDfyK9KnJaPEjPoxBRNLsfVGwv06nUYWU4rLwivQfiBqmn2Zn5H7txQ0Scs6OPtkE6+VrA+y6+HWxOXzJXN6zzHO+9iP8v45sNgn8oDywg+grYGtWQAihLtthtoxCJ74jGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373794; c=relaxed/simple;
	bh=Ci0IGeiSXqE8gxO2e8sFSaFghb7UqO3Bu8LFuDieZDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=oUkJDCxFWSjOuq1/BIedDHwBoKHomO6VK76trQzox8ilFAvM/GMJVsTgY1BfV6YOV+tKKFskk6YfX0gkoOLt+MEm/Vd+JzGnUSAw6R25lPAK4cjposXV5RSb4xoHHfZn+BFbe1Xxc/LPqJFfI2uDNdvYG7kuqf7Xvka9Nen8MTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfRlUTSs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfRlUTSs"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45310223677so1076195e9.0
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373790; x=1749978590; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIuc7HQDmJphmTaGbeQ7G5D/RpNeCF1tIJ26RTyrN1Q=;
        b=LfRlUTSsXaJ8BOgMi+1x3biaOvu3zU77u/BBhi1tISrPQJe3OkzSkcaJmV5cNVfzNO
         q2D9TPh08Wceq07TlXg3xxOthBS5fV/tXb1DRQ5/S/p0WxyXOPB2iMmi/2S9oiEh6/9+
         RwsBsLSl37cFafruGEWPe4eDm2LJD8fNWF/jMPDVtGpfUG1CHgoO//Ag9pKFzYNLCjpy
         g1gEZl6hDlIxii3Hvxbz6X018HavhlVmLk2ssY1te3/IA/nH+Of4m9dNPZczWjpGLkxw
         neqk0TU1Boak4rL21aVOKxNTsExjNRdsbUJ7TH1FM/U9nzaE7q0F3v8ddScRgCw6nCHp
         13zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373790; x=1749978590;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIuc7HQDmJphmTaGbeQ7G5D/RpNeCF1tIJ26RTyrN1Q=;
        b=gv6+sJR7Oq9ohfcg6tSeGEI+fOAY2kJi85J28yGk6FIziWKpqhJD1N89kkflYO+SA9
         yP4rUeYsNAOjvgSsVormkta18kLhNGjgSRCM0hpm9Hpr2YP3LB2EUmibvZ4S0P9a056z
         KbbUVgvP9mHqDVUIk6+Hpu5cDh76us1kpuVZic8gtzF0TzfBq04OhCjsI/nrhZNjsvai
         t8UTegn8ewpjcu+KZpDsb0CFIVUvvxldH5UZNkPez28Q8C+kAO5NIWl7Nqp8yWB45B1t
         HYpgPO7GfNQoeI6JZ6usewseJB+Bw4EIeQmpivC0MrM4zqtgDmJRfUOUG1UD5GjBANgC
         m7OA==
X-Gm-Message-State: AOJu0Ywd4VJAMts+rJyqvjnQxVHRcunuq29+rqqREpFfl/O6H0PXZnM8
	V6XwM85Mw3vd/mF4On5SBzJJdpaJ9xE2Bax6SRNgeJB5VdYqNomnAqkW8Y7Dhg==
X-Gm-Gg: ASbGnct+xsooC/3eSfSyajzmH9pEY/LG9hT/FBTVTSv+fXoWAtOrtI9MkF1AshMb6YC
	pYykFfsjq659m7otDkWoVZCdkjQkNsJYdkxp1zC3ku36ajZzgXJVSH76GR59bWgu1kQ3+QjPexh
	Cg4folScyXTIybhNFHoYXJ1d8161jD5ifK/Vx/43DyZV/hj9D/Yu188DalcAI5aCmXP+OdvSje1
	3L09X/qT8As9y1PbhH9Uqu29wR4G6zFdHHmHzr4TueHhaiP1GxmSp3w6hSIekxkzuhPow7A+l1/
	o4HdVYLjjszL2D2c84zO26LmvYIXvxPIZVX+Nt6pI271+deOXnxP
X-Google-Smtp-Source: AGHT+IGGjhJWTJEUhgn9QKrJf+dna+zfo/hqWf8aAf6CTmYOSv2+ODLR4n6hzY0VnitElt0asWZ4LQ==
X-Received: by 2002:a05:600c:1e09:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-452012ace18mr106012185e9.0.1749373790211;
        Sun, 08 Jun 2025 02:09:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45307b9d827sm30600065e9.22.2025.06.08.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:49 -0700 (PDT)
Message-Id: <ff22d0f1adf823ea3baf3ad3ddbf25add1187ce6.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:39 +0000
Subject: [PATCH 2/9] doc: git-log convert rev-list-description  to new doc
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use `backticks` for commit ranges. The new rendering engine will apply
synopsis rules to these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/rev-list-description.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-description.adoc b/Documentation/rev-list-description.adoc
index a9efa7fa2722..82c680e57013 100644
--- a/Documentation/rev-list-description.adoc
+++ b/Documentation/rev-list-description.adoc
@@ -26,8 +26,8 @@ endif::git-log[]
 means "list all the commits which are reachable from 'foo' or 'bar', but
 not from 'baz'".
 
-A special notation "'<commit1>'..'<commit2>'" can be used as a
-short-hand for "^'<commit1>' '<commit2>'". For example, either of
+A special notation "`<commit1>..<commit2>`" can be used as a
+short-hand for "`^<commit1> <commit2>`". For example, either of
 the following may be used interchangeably:
 
 ifdef::git-rev-list[]
@@ -43,7 +43,7 @@ $ git log HEAD ^origin
 -----------------------------------------------------------------------
 endif::git-log[]
 
-Another special notation is "'<commit1>'...'<commit2>'" which is useful
+Another special notation is "`<commit1>...<commit2>`" which is useful
 for merges.  The resulting set of commits is the symmetric difference
 between the two operands.  The following two commands are equivalent:
 
-- 
gitgitgadget

