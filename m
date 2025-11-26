Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30EC201278
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195521; cv=none; b=uWLw7LUw4mFC34Z3XFmsqaHxkrTMFsH2v2w4JzrokOVs5Hp38lqteABdDnlWFuQXFBg+H4qoO7CpQt+lMe/mTYEorLli00c7eQ4eXMFo6mpefOCzu21gF9mEiQceSO3/y3LPMbYSS8H7POWs8TBpoQ1emh7YSmtsykVOda0USW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195521; c=relaxed/simple;
	bh=J/F0bsdVXM3r9aDEXxyEPLx6o6DTi7TxGYfbUn/SYzQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Zr7ZpDFa2dzlj26SpEbsQf0+bqmcM+oXzarah88KQb7NcnfCsH9nPrQVWwlduNwGLsUoKPyZwWDF8+fhWg94OmkLfx92OZgfueHYIKZLXbJXieR1aHfdzVyc1iQYWwzaORjH0WssMFFoEf99NgRLA4qVNvLaiF1Hnaq8ZEL0mfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zxnsj/Ub; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxnsj/Ub"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2dcdde65bso34019185a.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764195518; x=1764800318; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tYnRJMbkmFtgUHybLjXn0SG4jUs3mUbJOfHN7uwTl+A=;
        b=Zxnsj/UbJ1I9CQPkVXojai38VsDQR0Qk0Y79Svie895viWFpCeZ7I7/uC6DuPYyTRd
         qZ+KfnewDlIWggzeN8fGWfZAuCnDKqCAjoSqAgmxzMrZ5IL4XMABb4K/SnFT2Y+rjEdj
         fFGjDZ/PhJ00KqY+kNcc0FnAVMvWiQxHG3mbF52unelJ0tXdDBrX6+IK7zRJzKVw3zdt
         mEribdgqpfj0QwbJN4toHI5a5GzbfFslNAKbKSkyFv6Fuh35zAw4GFAbVj1K2WgyoG6e
         qZQ9exXTi9sKbb/wq9pOAxb9PG6RY1nZVsqBHxm1990+MbwmTfpy3ixxGKsZRdgWhRvG
         PZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764195518; x=1764800318;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYnRJMbkmFtgUHybLjXn0SG4jUs3mUbJOfHN7uwTl+A=;
        b=rmwRqns8uyld7vv69FobshvyVCgI0YT2E+dcBTHiHLx958+BDSXWklzRj6GLt+TgH8
         Nt1vshxXv0q6g7SYxSCDqXJwX/EbYy8p1RKg8W4bBNPMMqTdxgqBjHqj7MryVEqkEFrB
         6z+05bxxJP+cJYqP1rx1DWj1otnHhDt2FBswwC4MyWc3mXkkhkZ50C1d7ipEqGLZXty7
         s7VtZc/Wdwmwszq4coy7emyAFudsMcQkgmAdjN5Z6ACeAK85+BbUBlKwQvnB+ryl6ENO
         dOCLixDJDCZLsfTe4Wtf9jluZlXnVO//uWDgbslluReaPZrxiOXhBgcBb3JDgEwQKdH5
         NIvg==
X-Gm-Message-State: AOJu0Yw2NhgDJ3qemw8ZIWtRKzxt77NTzbHTl7QAa0Ni9TqtX+ag9+Gu
	97O8TAwh51rHF54RzGU6ooEB5UetTh0j53jtKMLk9DbrD2zBzLXMg0BbpCKuc9Up
X-Gm-Gg: ASbGncsLD0ISza9j/zdI+PFcmO3JjEqSCpOv4zjzM3J+9ChsVsa6S7KPQCUL+bdGBOg
	qZlzCd8AVV8h8VDOPU7d+9ZNK8CfE2/qBWQN0W2TfWkpCCnryRgmIyy3QRNLX6L9/kLYK2Hs3FQ
	oG52kEx1bSPWJxUntu13ZyPnkuiOM4sDSkVXLZijViiyhEVB8LldwNqSA60cj+Hru1vdf4nzeWn
	SqLWebBvTXcECoXi6uF4IXzMJ3198PFQ3BiGBaBYTIDul1YOZhe7+xuwY7dciPgsYd1zrgxzd3K
	rvpn5eXurLg5Bgjf6KPdATA91FyhY8EomA/KcI4+euI4iOmo8ppX4InzKYBNsvVC3/2dh5qfc6L
	1ARVrOCn/V80rBSc7S9eJb/bcFgZ13Thw4GxofACLevubK9u2yE2mr3BQUBNidT+SODtNuPYc0U
	3+UCwOzY3EVu8=
X-Google-Smtp-Source: AGHT+IEOMMyvHdMDSmWeKLJRn74q0gHAoEdJfHDtCZjknPAjadh+zpgQVOGCdXm+ZgBtL2K9Ni5U5g==
X-Received: by 2002:a05:620a:440c:b0:8b2:e598:e319 with SMTP id af79cd13be357-8b4ebdae818mr1093634985a.49.1764195518136;
        Wed, 26 Nov 2025 14:18:38 -0800 (PST)
Received: from [127.0.0.1] ([20.161.78.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c17basm1483035085a.29.2025.11.26.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:18:37 -0800 (PST)
Message-Id: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 22:18:31 +0000
Subject: [PATCH 0/5] Audit and document Scalar config
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
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>

In September [1], we discussed that the Scalar config options could use some
documented justification as well as some comments to the config file that
they were set by Scalar. I was then immediately distracted by other work
things and am finally here with a series to do just that.

[1]
https://lore.kernel.org/git/ffa61066-7004-48dd-9096-85b305373bc7@gmail.com/

I have indeed used Patrick's idea to add '# set by scalar' to each line
added by Scalar, it took a little more work for all the kinds of config set.
I made myself a co-author.

While working to justify each config option, I found some stale or incorrect
config options. I also relaxed the override setting in most cases which gave
me an opportunity to alphabetize the settings.

There was at least one case (I'm thinking of core.fscache here) where the
config doesn't even exist in core Git, but instead in Git for Windows. We'll
need to adjust in that fork to reinclude it in the right place.

Thanks, -Stolee

Derrick Stolee (5):
  scalar: annotate config file with "set by scalar"
  scalar: use index.skipHash=true for performance
  scalar: remove stale config values
  scalar: alphabetize and simplify config
  scalar: document config settings

 Documentation/scalar.adoc | 158 ++++++++++++++++++++++++++++++++++++++
 scalar.c                  |  81 ++++++++++---------
 t/t9210-scalar.sh         |  26 ++++---
 3 files changed, 218 insertions(+), 47 deletions(-)


base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2010%2Fderrickstolee%2Fscalar-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2010/derrickstolee/scalar-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2010
-- 
gitgitgadget
