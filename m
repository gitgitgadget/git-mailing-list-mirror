Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300230F939
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571592; cv=none; b=TsLsmiLldEPFyyStrkzdC+IEviEFSb3LhGZrLoXeZaKicU4Ghb+0NxfvISkkGXhaboEXz+vggSLAlBOOhTnsrc4Ecr/s+RjspCJmDwKo5xX2lwoLUDOfDO15DqzJ7j51579YwbyDbxdQDimD5pHKYx26Gc05Ooi0mtTN4e3ioeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571592; c=relaxed/simple;
	bh=FpJqTSVTeLZZgNTLo6SuFgxF5TgjSpB7ulU2QcCfKbk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OPQs31IQGkF5wgRGfOEkMgvHoeLiWTUjoVpmaCAyEZcFkqbxa0gX97zfIdHBSHTQcBuV9tS0/ZFsKNY4+7FFY8At5wPBTCkKQe2cgP4zEvr/UaJloIKIPW0ULWjtNcmE28nO4pFYWFdgfX7XcmuFaTSwfPw0jJ7i/+faM6/I4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoO8Wzvr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoO8Wzvr"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2ea2b9631so598356785a.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766571589; x=1767176389; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg7PcIVpBoVEosQxL1KXF2jR0OU8lXjc/yJlWf5Gq7w=;
        b=IoO8Wzvr9/MaBx5pzD5rbp+xWPKZ48oAui2lpeviUZk44GpYGR9hftQ3Wyc0VkBaUp
         4WxduE/xD7KBsj3L6nZpfxUG6735bTcuOC4wUG3iqItltnv/MvIFRjNpr+IQmCocmFnv
         OIVJeUWYKzVkvbVBsAYa/wZ07auqyLE1baIK6WLnqloMSjw/H4tGJTFVM67Gbv4EO3sw
         7oAx1H/OKVZwgMD6a2uGlO/hqt+ZbbTyNV3HWhl42Q3m7W9PMgBMlJ/ouCGd24ZokIOq
         2AXrvNY8n0OGcCTdbpOvJGxjNaGejy2VwsWQoZOGHe8N5t7XtJgwFdXR4yu0ZYAW2pBC
         ygyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571589; x=1767176389;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kg7PcIVpBoVEosQxL1KXF2jR0OU8lXjc/yJlWf5Gq7w=;
        b=rdmyBmQXa16XJj5LMgDDcgTOym6dtlujy817mHu54fVTR5qR5RgpzDVGFwNu1+pBcO
         KgeZY31bMrWFguDGoyCLeqJpZFbLEMoNQpNiiRe18gD3LWPdeF+Bqgnz7cDaWouDgFDF
         RBn3GkiygSxh1Szyz3qKpCD21IhDiZ6zKGRHLIkkGMtWQryx8KOcSkvq4d0zo/2grUQS
         SeNopl9rr9XWYeIz/v2ZxFerFzWfxHp7z1TxcXNE0I7d7/x7ZuKP2QVZeZTBovHLQVvz
         nmw0tj49nH3scSTCuidZ96wzf/tMSUZeJvTmWNMA26tRFl/GCT3paUmWSII2kDZznEwb
         6BGA==
X-Gm-Message-State: AOJu0YyHo3EBFaAjYPGpjtqGCUhNk2zliRbwYBDeG8QQbLBkqNTBtgWM
	47a/52+hZZ0lsqKXqhSOeSt4oIHkPBkJxK4Xm9CLLVb8HOzJEjBpZSQTqYKutw==
X-Gm-Gg: AY/fxX7iTPC+Vj1uMFozAlWr/d3PzeHqejteN8wNp2D5hR3VUQ0e9xPXE6Cp4hXPLq+
	AWHpPbvTmuYa6UnWH/mSGzS4LlJLdQyH/BVkd39bM0D1ChucR97Qgbv9FKVwcYouhHXYRB/PZsZ
	8N6XS8aPztxzSx4EvCCfqzik1FdlFxOGhHiEggmiu+rQyrcnRo5M39FyQMAdavvX6MP5Lnr9E3k
	pNsQDch5QTvcwcaM3X9WKD3E1ROcOwg6/DkFAtYmnHK9GSxlkoa+ba5kLY6d67SQQCVDIBE3MSw
	3NfpTBbELKgK6d9oipb2neBgCyHKIV+QjecXHm+g5H7fJ+MtOopwmpFFz8JR5KYdVXLX9GtaofW
	3CVivJM3PNamAYvuFGo4nV3cEnvvUS+Sk2dimxMDCD3gTYBhOqv2B8uD4O+R+eWm/y8XescjTFn
	KAChWtIqqXt4eaMA==
X-Google-Smtp-Source: AGHT+IFfTTD2svx1DLv1GVHnLylm5UnpR71PB1/GMKzT8DfDA8bZwX+ouqT2HZs003wpVQ9hiAxEDQ==
X-Received: by 2002:a05:620a:4454:b0:8bb:a346:8c89 with SMTP id af79cd13be357-8c08fd22339mr2458260085a.56.1766571588962;
        Wed, 24 Dec 2025 02:19:48 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c095b79b32sm1263834185a.0.2025.12.24.02.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:19:48 -0800 (PST)
Message-Id: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
References: <pull.2138.v3.git.git.1766568665.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:19:43 +0000
Subject: [PATCH v4 0/4] status: show default branch comparison when tracking non-default branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net

Harald Nordgren (4):
  status: show comparison with upstream default branch
  Simplify default branch comparison logic
  Use repo.settings.statusGoalBranch config for status comparison
  Rename default_remote to goal_branch

 remote.c                 |  92 ++++++++++++
 t/t6040-tracking-info.sh | 317 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 409 insertions(+)


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v4
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v3:

 1:  a3800aed18 = 1:  a3800aed18 status: show comparison with upstream default branch
 2:  417f2075fb = 2:  417f2075fb Simplify default branch comparison logic
 3:  c9ec5d9610 = 3:  c9ec5d9610 Use repo.settings.statusGoalBranch config for status comparison
 -:  ---------- > 4:  0e308141da Rename default_remote to goal_branch

-- 
gitgitgadget
