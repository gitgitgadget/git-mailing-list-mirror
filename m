Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32F19B3EE
	for <git@vger.kernel.org>; Sat, 24 May 2025 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748069337; cv=none; b=eXMV6l7snzrEJQw5/yKBLTObDpEasaRXJkHD6c72gaqAQLmS1zgCjQZx83JtsFkwHARLppQT8N2Ez775D4otaEsOrMweWiMWxa7mieg5xDL0ENB4g/BhT2iRsjnFt/LMRCpifwoH8EiHgzCRDAQFr9AzsoDfF29DbQ+mJgTwNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748069337; c=relaxed/simple;
	bh=ou5yoeCavpZrLmuMLNl0kpWeCFuEpp+L+ERAK6SNVkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWaQRFodSjAtdFiFYhOBbzdmhEeJiz4JErpKl8zLnaZXQNATK23sj77oC6qvqc1RT+MIjDpscWkeU3CcuzYc4XFTh93+vFFjzdhYQyoRin+LxRvYlB8QkCRaZc++blueo39MCMD1qtQAz5DvhGzVTUSF/eXEc8J8cE0X/Y9alM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRME4qII; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRME4qII"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742b0840d98so453287b3a.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748069334; x=1748674134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/YYX88WUvy9WZR33dMxLcnFHWy0EBm8InyeOngWWng=;
        b=IRME4qIInKEQUKlxo25q4U9kpL8m2/pD4FV/VFSNh94ONePqF19WwTurpB/6uuRxG+
         nA90mBN4u0P1gZU8Rl8etawr2LoIuUe8dUsth99kgZDiL4sB8Zf/MNU3skq0GPCfSy/Q
         CLnRC1tGI7JF1BhEgTyYP9aV1Bbwooujz5MAvH8NZ1H6uO1zjqCpO8IgNp1WMaqRnvci
         crm8ocgZGbJtKCKVNRMHzNNLMPKB5IYJH52+lPQI3oZUEJbxOqrzvcFGxwUbdVUU1wO1
         /lZCl68CUV1mAAUlEaODy89Qsd7DCcPCoYzWS8GZHeozZuvf9wNG7Cp6BJaBAGui6Jpt
         lAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748069334; x=1748674134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/YYX88WUvy9WZR33dMxLcnFHWy0EBm8InyeOngWWng=;
        b=D927LNCyQl87V+8pWR0ewpomNuRvTep+yON3zVhPUIfSddLyNeOcwZTcrsJjm0DBZe
         X0QcfPoWW+RtCa9Z47PSiZ0ys3LW9D2lrZnjYWh3Ch1GDriDqw0rhXPa4PBf+Sj0SF9A
         MqwzTKE4sVkR+jCucnoD5Vfj0nOTUVZyG3Uyxv2hGxN4kAj7IqJklGOkXRU2Z29rFnhn
         hmc+feKFege0BGV8XRiAINfdBVA+3gkwo5IUYGmXEigWs0fdW4OPyBRJtbDFw7/LahDP
         CAjNfeLAqDUOPnZxHOWyf9X59rlzUTOHvTzFMkAVzwGmgJwEAFmgDrwn38kwEwYDROTX
         LrXA==
X-Gm-Message-State: AOJu0YySTq65xYDhPaT+cBnFf3FvZxGGgMe1w8cTLAipJy+8W4psFs0l
	NYtMWKgkNee5UCWUVa5RLODiQlNZ32CiN5JaX9+b180up+yixK1SymqyqPz7Cbuf
X-Gm-Gg: ASbGncvoHS7hyXYyDMr938wQaY05UgQQRHljq2hNZRFdwS1C8eeYWhC1+DuJF3VJFZO
	Wjh/RhG/vi5LRZTwV81nW5vLUmv376SNBMxNK6p+oFSOSj3mVPQ4O/AqdtMHKo7SHl1pHchWns7
	OxZB+AJdLCvhSvaOhol3NxOhjP8pOCpdcv0A1PxVbZTUIlofkVOSZEb9acCJe9ZHUF3sbdsOgqR
	batdLox9Yc6H1EQY7Rb4DwW8RKuVCyEcCaVpCJ7toEeEkyzuYHZBg2FLtOS5I3NpJ8ZtuXxSsqD
	Z0t0/z+QzTlECFuQFxs1GmEWSnY6lmhz1M5cvXmByYSFq2wIW/iaUoZH7/ZVFWbSTCauhPT/2sB
	A5A==
X-Google-Smtp-Source: AGHT+IGCheAbysMTE61Ilwp3QdOmqQ/9nX2D2dxUrdkWobnzURxYbtS8l9dLq4e1brpzINN3awNs8A==
X-Received: by 2002:a05:6a20:ce43:b0:1f5:8479:dfe2 with SMTP id adf61e73a8af0-2188c1ed38emr3327912637.6.1748069334250;
        Fri, 23 May 2025 23:48:54 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8e05fsm11862401a12.39.2025.05.23.23.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 23:48:53 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	mlell08@gmail.com
Subject: [PATCH v6 0/2] Avoid submodule overwritten and skip redundant active entries
Date: Sat, 24 May 2025 12:18:45 +0530
Message-ID: <20250524064847.51900-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqqsekzjo7g.fsf@gitster.g>
References: <xmqqsekzjo7g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series of patch covers mainly two areas

1. The bug report where after submodule was moved and the path remained same
   when a new submodule was added then it directly was overwriting the 
   moved submodule as the present submodule since the path matched.

2. The configure_added_submodule was writing submodule.<name>.active
   entry, even when the new path is already matched by submodule.active
   patterns.

Below is a helper function and 2 new tests with fixes of the above problem.

K Jayatheerth (2):
  submodule: prevent overwriting .gitmodules entry on path reuse
  submodule: skip redundant active entries when pattern covers path

 builtin/submodule--helper.c    | 60 +++++++++++++++++++++++++++-------
 t/t7400-submodule-basic.sh     | 23 +++++++++++++
 t/t7413-submodule-is-active.sh | 15 +++++++++
 3 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.49.GIT

