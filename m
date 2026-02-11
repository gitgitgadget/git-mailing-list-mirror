Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFD352FAB
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 04:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783098; cv=none; b=RtnYdCo+kwKb0xZ3xqv2O2+YY70kfuVKjAIQ/qJED4IuPPWeYqhPN9BfSCu6TjwRi8NMHb8mslWiAQ/84ZZSe1r8/v40sGm1NhwywdQfeYaztXQqNBDNEETR7lsi6SqmH7B68Wygl7FjOtmxluNXMR80H02yBDlYhFARBLutLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783098; c=relaxed/simple;
	bh=sAZBf68dZ2Vu02jgSpw7RewN4H0WktjV97bxfTpL2fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBsLZs+T/wiMBJCSwf0z8GHI3+DRNqsse1UqKn0r+LdWGvYLw3zZMjH22wkulvdQCIGyEwNb/UXlhYM4eq6HctvE/3LPRYEI/H9U7VJLLiJOYj0mKeHAFlHz5d5pVjlOBdsH95DD/XiZQWeOFw4/F110spuqeqR7IIo9NnMKDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YtDpG4M3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YtDpG4M3"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35640ad94d3so1303068a91.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 20:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770783096; x=1771387896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1lfSlPLaMxTewDJtXX7e8NPKXhZALACq7LOrsggFTs=;
        b=YtDpG4M3wkeQzTLz1MT5mNik/dKXkJ9VNkkXAp8zIsxQFpPWRfC2Hvt9g/8n17p/O6
         zXIs7C2Hssod16JfJ8Hd+lqCuQ7efv0Zr3C3cou93m4cpPBQVEbSQUXxYagq66Iz8Xfn
         GryeswFrGD0FgoVoJ/0RE8l/sqAatSqSqq/V1A6pWSEy9z3WsNq3+zGlpcRkB9Jn5c6u
         Bw/XgejUUThNHF1uff6pnrExA4Pqkmjr4vDgtMCunoH4llIUQ9vfzidR4GkMw7IWVsk9
         yeH93n+Hf3ZB0l98rW3twfesYDahYfYzjoYbVU2N44cmoa66eouF/lJ8kBvgMo4nEcib
         H3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783096; x=1771387896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1lfSlPLaMxTewDJtXX7e8NPKXhZALACq7LOrsggFTs=;
        b=uyZ9FB0p3JPhNzQiPngHzmclwDn732zUZtwWjPW7SYdSkQVwAxznDKK/os/XdXiX2n
         4CzQiBLTL/8jASWsDoZhJTgZjc4WVaW2Amr3cNfEs8eaC2t0VBoe3prkzcr4F9cdKODy
         Bcw5xQQZeClXQiSyU4k0aNy2p5za6iMs7rKztZed9OcIu4SJj8F2BL9SlLFv8zYUQOVe
         0ALeZXlmewLHRfou+9RPF5M38bGrt9Yr0l0TNZ77YM+xDPfjcoDzJZCSd5YnXFmBuVH3
         pqF77kjCEJOqOUPoGo6CupzDf4IHqKUZWBHcbZeHnigcXgcgcgDWph4UF6tAjuCr9oZO
         8dBA==
X-Gm-Message-State: AOJu0Yyo+D4X8k8MvdqZR6oFgQcObDdM3oOchd1SOs741hg16XwyIk6T
	mHrbcOwtQ3QvXx3P5E7Yxjw7v3eHd0RxfXz4YsFKmZYD31ZD9kGKW6/qptol1PfUqTzQCUt9oZr
	StNER
X-Gm-Gg: AZuq6aJTNFitUHKCKarYHCgA9d+Xg+2TDzHn32yrKTouU63tRUCCSnmrLFm/3RTF44D
	u1+DgCZlnF7Q6agsv7ysyYcUAYCv24ixqivr7P7IXVetYVO2Bgz8abYndrbiPbdLG4NfVj9RXpV
	wH+XN/UEMMSeId0uReFiZtXrOvNexwJW9xvDfE1zm30vLobtfe2ix0m5RiVfCS3jUmABFM9Par6
	dkI3W0EsOud5OKqU2bxDdEhop4e7c4TJbutJQsXrph414++fYPtREr7iiK92Td8zpq2DbbOa7qs
	iCVsKBL44LWY3cwHT9t/fXUaChRzIn54HSc9u51Ie8S8eQR2HIl9PDKl3Db79QCDsCZc/39mp6w
	lzKPCmmfIYiQTiButrpXOlWg2S29BF9Xbu02aAxGiM/mlWfldB9zWhUvTxtJ1WTyyngtC/4ZvH3
	TB5V7N92cPR1BGdyWWVCbpT1kosKzK6mQi9prPLvY7/4i2aWbVlcWgFmnwdJo3OpBWpA==
X-Received: by 2002:a17:90b:35cc:b0:353:5595:3247 with SMTP id 98e67ed59e1d1-354b3c74a3fmr17848066a91.12.1770783095477;
        Tue, 10 Feb 2026 20:11:35 -0800 (PST)
Received: from LTY2K703JV.bytedance.net ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e538d6sm4371513a91.3.2026.02.10.20.11.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 20:11:34 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH 0/1] diffcore-break: prevent dangling pointer
Date: Wed, 11 Feb 2026 12:11:27 +0800
Message-ID: <20260211041128.48412-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The diffcore_break function in diffcore-break.c forgets to set the queue
reference to NULL after freeing it. In a blobless cloned repository,
the queue could be accessed by prefetch and result in a segmentation fault.

This bug is only triggered if:
* the repository is partially cloned
* the diff operation triggers prefetch
* a diff is split into delete and create before prefetching

I've prepared a example repository that triggers this bug.

  git clone git@github.com:hanyang-tony/dangle_sanitize.git --filter=blob:none
  cd dangle_sanitize

  # download the old version of the file
  # to ensure the splited diff exists in local repository
  git checkout HEAD~1 .iac

  # reset the file so we have a diff 
  git reset --hard HEAD

  # segmentation fault
  git reset HEAD~1

Here is how to create the example repository:

  mkdir example && cd example && git init
  mkdir -p .iac/configs/devops
  cat >.iac/configs/devops/config.yml <<EOL
whiteListInfo:
  - target: TARGET1
    emails:
      - user01
      - user02
      - user03
      - user04
      - user05
      - user06
      - user07
      - user08
      - user09
      - user10
      - user11
      - user12
      - user13
  - target: TARGET2
    department:
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_01
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_02
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_03
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_04
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_05
  - target: TARGET3
    emails:
      - user14
  - target: TARGET4
    department:
      - DEPARTMENT_06
    emails:
      - user15
  - target: TARGET5
    department:
      - DEPARTMENT_07
  - target: TARGET6
    department:
      - DEPARTMENT_08
EOL

  echo bar >> foo.c
  git add -A && git commit -m init

  echo baz >> foo.c
cat >.iac/configs/devops/config.yml <<EOL
whiteListInfo:
  - target: TARGET1
    emails:
      - user01
      - user02
      - user03
      - user04
      - user05
      - user06
      - user07
      - user08
      - user09
      - user10
      - user11
      - user12
      - user13
  - target: TARGET2
    department:
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENTS_01
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENTS_02
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENTS_03
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENTS_04
      - DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENT_DEPARTMENTS_05
  - target: TARGET3
    emails:
      - user14
  - target: TARGET4
    department:
      - DEPARTMENT_06
    emails:
      - user15
  - target: TARGET5
    department:
      - DEPARTMENT_07
  - target: TARGET6
    department:
      - DEPARTMENT_08
EOL

  git add -A && git commit -m 1


After partially cloning the the example repository, fetch the old version of
.iac/configs/devops/config.yml. Trying to reset to the initial commit should
result in a segmentation fault.

Han Young (1):
  diffcore-break: prevent dangling pointer

 diffcore-break.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.52.0

