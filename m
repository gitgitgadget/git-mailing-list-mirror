Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC37291C1F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303884; cv=none; b=MiqPrl7l7RHxvzplhCq7vI6gvnFBxmq0vdj71XqkS+fa0eVAmK8kRtEOL72HHLrlQUXNRAgf8EQdgZUQFJa2fI9HKgxfL7ahnjCy7nT9RJiDYA92B8zeWCRnx7NxO7DWwW91xnQFKdsJqqC7XSXB5b3Oj6kcD6GbYYShtTgL7r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303884; c=relaxed/simple;
	bh=7Zv6hIxr4JuTzDNbzFfAFL+kYzX8YaGjdulWOb0qTRg=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=b0gQgIonHzt2Tyw4SzR9L/xlaG5nrWnsWGDMcBk7gPdfUkB8XNm9YRLAu6FCzHSyCCRoPWtljPCOoC/dyCBs0xNbJ4HefRY6HTD9j5KSQA0xFAEVpfRcdJhc5dtiuyz4SvrFxXH4mnd0wWp15B3CVLSp5ip3FVBobH12uS1p7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EES7MHSu; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EES7MHSu"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso4789469b3a.3
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765303882; x=1765908682; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hg1DHS0AsX2xSH0GYcSOwzjudJAeZ2Y7eh6UmTUNSoE=;
        b=EES7MHSu0z/fruNii+jiwn3u7qLeBQwamdkFO7GSv2G4AyZmzn+BZezIM4nhLds8hZ
         xvVicAE/2W1xoobYXkZ2b1QjBPzMINsnDwoMzDFEHggkuCA0IXZWIHjWscW14bfvVWoF
         pjisgnLtVxzbfVxiIiomgvpaa3WMokSBRqXR7PWymSWJn7jK9TPMwo5o74MphjQ7MP22
         AART4xTo6YFa0HgOV/slUuuhwFqnEkGaMlzCKml00jwzLuwSC9RzUj4crQqltGBaIk6j
         ZgotNQEz2qr/oMvDl9/OPp2Jccg9CJOj+bZoW6sqlAxV9S9yX0X2tuoRbp4mZ/mxrrcp
         EXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765303882; x=1765908682;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg1DHS0AsX2xSH0GYcSOwzjudJAeZ2Y7eh6UmTUNSoE=;
        b=uvqSC4EfwZVRjGEviavFvvO4mMI44FYaMq6X4mvmOV06hNBDhI0RRvEcEUIf5G/Chx
         PRsePat3utrauiaIWPHPeT19JetchKf2VMXk2j82YZWPVA48OHuVeP5Gku18/bF3cEGQ
         E6JNhQPPcR71whrN2NNjunYTnXmtjMqsV2AGkxzDmbAGmMYdpi3hnhrj8N2T9LeC6QlW
         ReJVVyk86YwMWAsufZs/svsKq2IAVvv+6QMVOnjww+pRUzYd52M5UON+8X6/AgCkAd3J
         /HARmdlj94xCPI/GGQbmDT7MksPpkOiSPZmGgDeIBC/jTakGENnEPOoLmxi92S4Kn2f+
         ddiQ==
X-Gm-Message-State: AOJu0Yy+PJcRMjx6lJqzaJSwnnvZ+OcH5oKSHQF7Q3H+70+ziwNsl2Lk
	u/HUoAFpZFgFHj1lNgmAAfHoQSHQb+A8u3JTLptEc1qN9tex+i87cF/yCSOmfw==
X-Gm-Gg: ASbGncvd3GbM9ZjeHCeWVG240/iEKNwuasM00voSvPOvPCN2J1pYancuP/HZaVn3kjt
	0xr09RNnelTjjAhjutP5T/rNQQ7Mt9fryk8CpL6VLhxqDiIQsCV39XoP3WFNqWKLV5liPbc0fz6
	2qhYygvOaE05aliAF+fA4uWIGKtYijIKSVSuD+/IXAPapPEzMgdD294LaCTacJWrVdyRdFqJCCS
	2DHFc1Ir4HZfYLVwIostXKCJ/QnT0oDIoFEP2cEalRsptzMHm5W8PGjzNcrui3Wne0iT3fe1j5a
	WG3WILcK9tLO51EYFN75GSttNDxRzAVBNHzUUeOHHWHbJ8kVcCzTexIbMzFpvt4ziG3zUHhOpjp
	qpgqW42bWU2l6diUnzLKAYRJDiI1V8XCqi5Zk3PWKt+ECKp7DSe9Ush3Kqsr5dg1iM9fn8s19vB
	wt+gB31maXtZJd
X-Google-Smtp-Source: AGHT+IFYl44NZcgc7lYqparkLfvtdHoAmVmjPE3rAa4YUXNoXILlOXvCyFe5nfgkjw/zrE29Zqdnvg==
X-Received: by 2002:a05:7022:6997:b0:119:e55a:9bf0 with SMTP id a92af1059eb24-11e031690cemr8304239c88.12.1765303882006;
        Tue, 09 Dec 2025 10:11:22 -0800 (PST)
Received: from [127.0.0.1] ([20.168.111.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f283d465csm1484460c88.14.2025.12.09.10.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:11:21 -0800 (PST)
Message-Id: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Dec 2025 18:11:18 +0000
Subject: [PATCH 0/2] shallow: handling fetch relative-deepen
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
Cc: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When a shallowed repository gets deepened beyond the beginning of a merged
branch, we may endup with some shallows, that are behind the reachable ones.
Added test 'fetching deepen beyond merged branch' exposes that behaviour.

On the other hand, it seems that equivalent absolute depth driven fetches
result in all the correct shallows. That led to this proposal, which unifies
absolute and relative deepening in a way that the same get_shallow_commits()
call is used in both cases. The difference is only that depth is adapted for
relative deepening by measuring equivalent depth of current local shallow
commits in the current remote repo. Thus a new function get_shallows_depth()
has been added and the function get_reachable_list() became redundant /
removed.

The get_shallows_depth() function also shares the logic of the
get_shallow_commits() function, but it focuses on counting depth of each
existing shallow commit. The minimum result is stored as
'data->deepen_relative', which is set not to be zero for relative deepening
anyway. That way we can allways summ 'data->deepen_relative' and 'depth'
values, because 'data->deepen_relative' is always 0 in absolute deepening.

Samo Pogačnik (2):
  shallow: free local object_array allocations
  shallow: handling fetch relative-deepen

 shallow.c             |   1 +
 t/t5500-fetch-pack.sh |  24 +++++++
 upload-pack.c         | 142 +++++++++++++++++++++++-------------------
 3 files changed, 103 insertions(+), 64 deletions(-)


base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2121%2Fspog%2Ffix-fetch-deepen-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2121/spog/fix-fetch-deepen-v1
Pull-Request: https://github.com/git/git/pull/2121
-- 
gitgitgadget
