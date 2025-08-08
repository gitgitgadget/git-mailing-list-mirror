Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9002E36E0
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 01:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754615220; cv=none; b=rlVgIeXQ2aFBwyr9nf1Nxe0P5P3o1DATG4Z0AB7yLlU6X1WVwV0J0yWbXxOAzsO6QY5sfydDScui2KNdqdn8mu3tPsMTEVOCKYy04MUHFNEIv6Oq6lLKqaxWR2nwIt+chESQn+c9EjBtyLdp+OCqd6oEW3fT5TWtVtXIzRSVygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754615220; c=relaxed/simple;
	bh=wNqVH43sJ7SCN13epSOnRuVdq3++6orpovztiVUiDE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEAOivUu5G4i0sh3HVLtKzAHWa1DmaHU3Yv8LZKbn0SfPim7pV0YzVk2vcV+G2cjpvVpAm+5vFjUbvbJSusHZ4Whe6ZgI4NApv5i0nveSMw27FixQhsdv63DGHLV4x8zRzyhkGnDEsDBETqxvMhwM7G0s4HBNcJyl4o0mvSgMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Too5StVZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Too5StVZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so1582083a91.3
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 18:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754615218; x=1755220018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXqHjYx/lt98MsZhayPqOgNIOor+gq+1ErmH8qYsu4g=;
        b=Too5StVZri9OTayJP2f5tsitggNTEZu4ZNlXeKqKJvO+xZmBllE5VNDLgn/a2yDbKT
         xrmTzxG9KP4+Slav9mGReIq2AAFiuN9NYOv/dmIpxg3D9xFCDIviNPTHj7F06+3j+b5O
         2OiucmwCed7Mk4s8+9d09DGOKIQdOOQjQdUP9uLYaplunBv5nPDdemLqv8a6J32sieLJ
         CnntQdZ23GBGnXQG0/8nUs9Ywnfb0KfZSqeOHIvpNozxib4qQnjfCUuYLeTPcSahqn5O
         LWQZquGkqAhB/mLq0+updoParhHpDNzXcizVz7hQe4SW+aXdZwYUiEFIW94+xc8W4/Un
         wc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754615218; x=1755220018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXqHjYx/lt98MsZhayPqOgNIOor+gq+1ErmH8qYsu4g=;
        b=Py/3qBZHJ2n6NXiApo5Rn69G/X+/5dQH3S5NCZMYkAk3Vx0fRxJJdUU6J4Nzt/+vki
         KEfEKRFv0lxBZ2U0zqY0dRBmH5TT4dwJENRVTEtxiOHs5LoypJwgpSWs7HWAkGLR3wiu
         YQ7BPom7bYdkp2dYLLMlhGWz+5BXJSr4g7rGhpdSe1k0CNdGda3p25hu9tsVM3vVwPSX
         xp9szduGIgFQ4P4Z3/7+ZOU7QuShu2ArMPenTHybGUFvki0uV+vrI2xub4HDlYylfnbX
         SkHiigCuRZLNFakB+XSLNTscVq0zTSlB3ksQ8bsvjmVAYXgK0aoCFGYYnsl7jddOO6vI
         TSXQ==
X-Gm-Message-State: AOJu0YzJCcPZABcuHw5oMRwvCROcDs6Edmv1uwUBNnULhLVoV0DKH5h0
	6edT22osHO3yZrkR+ajjJj5VpT0rGGlaPpq6RdC5/1Fy9vi30obalXVkwEnDnixUlTg=
X-Gm-Gg: ASbGncs3ejc+Zx7gsqN05RjNitc4t6LBlzniRRYBS8kU2K7IIz/Xia9ciJlDwBfts/F
	CE6NwHSWamMLiySbJOsmtRZKMNbrTre7eeu3HKMWhTLswK7nlncezpckYCjKR/BHq/t5xFQSTJ3
	A/+rHheKlVD9nL12SsMlIVC5QVgNf4Q0V25CwYd2Cw0hbylggKPLMJgFa2JO8lWsMDuZ7hhJSFp
	FAwBnxndvhCdPB+CnvIFbKUjLu4qZ5TR8FzGyF2Exq4a7Rx/CYqkzZKE4EE7w5RpgPDhVQsVDJ2
	ckdILqWO8yy5WraulmrCjnbau20S+4EE3yHehf48+ZhXMUyj9ZPtvKgqHkThI0zsLx8GPVlPsI4
	Yx1ly91WY9D8mHJcc/ZAV6PQRjxXQoDYRiWI1h+2F1MkhKB+xhtQ=
X-Google-Smtp-Source: AGHT+IHYDXcTLdYTfRklnrva1+TG+viiQtrmQd5LYFX99Nt/OKBMqNBi+F6w+t6pp5d02vuW+BK/MQ==
X-Received: by 2002:a17:90b:2787:b0:31e:d4e3:4002 with SMTP id 98e67ed59e1d1-321839d79bdmr1608106a91.2.1754615218403;
        Thu, 07 Aug 2025 18:06:58 -0700 (PDT)
Received: from archlinux.tail6959dd.ts.net ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321612596d3sm6610391a91.19.2025.08.07.18.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 18:06:58 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: usmanakinyemi202@gmail.com,
	ben.knoble@gmail.com,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v6 0/3] refactor t1517 to focus on help output outside a repository
Date: Fri,  8 Aug 2025 06:36:48 +0530
Message-ID: <20250808010651.591906-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
References: <20250803020744.1037392-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors t1517-outside-repo.sh to focus on testing
`git subcmd -h` outside a Git repository. It does two things:

  1. Moves the existing `update-server-info -h` test to t5200, since it
     tests behavior inside a repo and belongs with other update-server-info
     tests.

  2. Moves the existing `prune -h` test to t5304, since it
     tests behavior inside a repo and belongs with other prune tests.

  3. Introduces a loop in t1517 that automatically verifies `-h` output
     for all main Git subcommands when run outside a repository, using
     the `nongit` helper and `git --list-cmds=main`.

This makes t1517 easier to maintain and ensures that new commands are
automatically covered for this class of behavior.

Changes since v5:
- fix instaweb test using PERL prereqs (helped by Ben)

Note:
This new iteration is based on
7cd03a555a (builtin/prune: stop depending on 'the_repository', 2025-07-04)
commit.


Usman Akinyemi (3):
  t/t1517: automate `git subcmd -h` tests outside a repository
  t5200: move `update-server-info -h` test from t1517
  t5304: move `prune -h` test from t1517

 t/t1517-outside-repo.sh       | 40 +++++++++++++++++++++++------------
 t/t5200-update-server-info.sh |  5 +++++
 t/t5304-prune.sh              |  5 +++++
 3 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.50.1

