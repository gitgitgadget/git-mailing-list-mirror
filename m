Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98D2165E2
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757232629; cv=none; b=iKqvvLheypFuvTUa/H9sh6mZs1NGV12X0MvR8XmLMl+BxBv2/785LpTe/JFt5s4gRQtBGau7S9cfRvJjVO4f37OAYCfiHcce6dVns7+Dn+QysK/8qLC+/X8OE8rTK9F5NX6cY8ZoGWjp5s5Be2T2xXRNTIP5DCEvOi1uuKda/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757232629; c=relaxed/simple;
	bh=acdtGLrzKt0iI7hOs5moYHP2TRP7uqOuGKg99z9a2WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd9YPaKGAsQLnDQNAqtFHwhtAnCiAJ1qK3oHhkv1F4TrWyG5jh0sYg6AtLYf3pP6JKGOfJKJpPEzzrT57qxwqpg9d94D7KgUjjxTUY3RU8b2Vc7+IaXh2+k8p4pJa/eBBM17hRrSmXGi06r+LhOljt2gMuRUVUZS3N4kwxRz2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5CRguvi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5CRguvi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24c8ef94e5dso28197365ad.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757232627; x=1757837427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqB3Idc0o2d0GjzFdMQXYVkU4m/J2inKeAj+dHr+pT0=;
        b=O5CRguviJ6+wVEDTKeJRzAadwAJ38V/MoUtumCe6g9YvSyOpZsK9cWKr/xw78YvV9b
         JILIe11fCEvvMx4cSNcvnQ78f8HigkymnzKJcAeGrLc+z0TAIsYxtzeIS6RiVls7agBU
         r+vBv08AtVIkxKiHDZ4tmnQ21VeM1EPqL2Qm8V0YctVdZlxhIzp5gXzGxnpanJpS/9RB
         i8s7qsCATrBLN8ffVgMdY4ea0uwm/m5jaa25m/7JKuzG+ekJMJGS4458Arn/I4QfdLoG
         evoyW5El+RFS/Y+uhf7X82ET0NA/Ga/4MfcK6E/TYcrGGwArXLSeE+Ao81G8wXuXFsTc
         uo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757232627; x=1757837427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqB3Idc0o2d0GjzFdMQXYVkU4m/J2inKeAj+dHr+pT0=;
        b=AZvnaHX/GAaMKbySgR7WNaD5/iwtPESB/GtE+VCgzoMqUgaD+s6RdAsNvrYZ3JbS8r
         lxZw3eoVuUblni9pTFEGhHYvmXDQbWMZY+iMNM/3IRci5Jsbx8AC3sMt3LKE63zQcE8H
         3iNZ02uTpEoKVjtNbJNGBnELYHEVYihQcSzPSmyoT3rx2N/nXJBGIDx9JqkeL5GhrbED
         c1nSsVC2N3BR8+JnZ7nbhLeUjrHZPpoJBIN4i8jI3xXB/txei8w7DrWGTGE8+y1ebJh/
         m/6EjkWIr1Oc2Xov7xHI28Ay0oJWm7KIKSNutXDfp0YYElRV9YXm5pS8k8/0tA8c9mAc
         rE2Q==
X-Gm-Message-State: AOJu0YxR7p3ROLtFJudHquqidv8QyTLfVxu0/hH6X7opaCZGaam/aDQ8
	suAPSnXi5rSAs1WFqcJNQE4cUvl315xMhS+Z4DT++FGfl+SnC09zCtir
X-Gm-Gg: ASbGncsBzvk/vmsJUDpHuVV2Ub0wgwJDj38AKAoHeXKyimxmFFx4Lf3iawZLtOroIVc
	IsSOswqxQIovGDjosbYbnTgEdUuqs9rptRxVc1uXJBNjEqU8T6/k1YJ7pzdaRa4k90oG4abH/oZ
	1nNt7HumwFzZCTAOxDPbC+NG0wE76kroGAG7GoFo5bPEy+QWrySYKVtFMPgc1YpROple9lAtq0t
	NJZA7wTQEiOSWc0O8mL6YNQ+oIAqEpML5mo65qj4GPVNZtkb8/fbqCvGu2IVTr+NdI0vwUH9lK6
	ydbWwDYWjig21JQHCax3LItOZ/zlIuysKLivM1RSKk/zcuIYl2aSmS9Xar3C29F8TTRdwiwX9RO
	hV8tWAOTXSzq1fM2Jqtl5wQlliVrs5ViuRIIJV9VoabWB
X-Google-Smtp-Source: AGHT+IEqdIskC8amWMXGl8JLUoQoJ5Tz+fAcylmh5GBthWWmEnh3vRE/cEfnew9dbbCWg4vRAffTsQ==
X-Received: by 2002:a17:902:e541:b0:24b:2afb:b3f2 with SMTP id d9443c01a7336-251788fcc2fmr54387155ad.14.1757232626936;
        Sun, 07 Sep 2025 01:10:26 -0700 (PDT)
Received: from Fedora-Gink ([2405:201:c005:b018:d9a6:4d5c:c462:f739])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9669a0e1sm111051265ad.56.2025.09.07.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 01:10:26 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: nobozo@gmail.com
Cc: git@vger.kernel.org
Subject: Re Is Git Add Supposed to Work Like This (git 2.50)?
Date: Sun,  7 Sep 2025 13:40:14 +0530
Message-ID: <20250907081014.17466-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To answer very shortly, "It is intended"

Reason:
I don't exactly know if I am pointing to the right code lines

But if you dig into builtin/add.c you will find these lines

	/*
	 * Check the "pathspec '%s' did not match any files" block
	 * below before enabling new magic.
	 */
	parse_pathspec(&pathspec, 0,
		       PATHSPEC_PREFER_FULL |
		       PATHSPEC_SYMLINK_LEADING_PATH,
		       prefix, argv);


If you read the comment you will know this
is already intented (the behaviour which you described)

- Jayatheerth
