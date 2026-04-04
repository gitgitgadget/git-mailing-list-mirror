Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206086341
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775322771; cv=none; b=EkFIs4bLXVSFRbqxzwilMLiWiNuEpRFJkS/VrmSe9MKqaNz3tX4dlQS96p1fql4JzhNr0FDvch6sW8ijPjfM7eW/DXnDH//BMlWq4boruPM52/z4tu4Ht+XhjWFqHhuztkx18RpXdYea3MMoDskGGBva9uXsuDAiJml7P8j2sAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775322771; c=relaxed/simple;
	bh=r3CWP2pcp7metnPQgyv5hY62WxwzDwZvW7TfBjxfdHM=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Asx56MrPsM/FkJjdjiUdHhsxNj4OvQ89DxFAxy7wTb0wNh/z8Z6fBte6oWKYcvGNgQlWxu6NR4pOjRUv2uLaqrlr/NDLKFzFaoM+IbZmiLQGz5GokvHpqtK1RTqiHIM1YL9qFhW41l4YEWibF0piiuwFbdTpwg/0JKbD1Na/xz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4OtjotM; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4OtjotM"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba895adfeaso3006052eec.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775322769; x=1775927569; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3rX6kog0WiND1vKJItBPvNGZ0DQ567Jj/zem1pITjXM=;
        b=I4OtjotM/BYxc2Il6U5JVHpTI+9FdnyCcCuECbFYwZhZmvfh0GLGB18Bqzn3Xr+xwD
         fsfRlR3caiYBKzQXLVbR+kNmdzhsKiOETBr9cza0BrR9ZL9vDtEDlxajYdVar7pnfxvD
         t2peoxjaUTYyDmNH/Qm4WlNefsOVp2nrKXhi5PQUJjDvptKMmKTz6TwPl4WZEuj/DQOU
         ilRMJI1+xw/8Y5cfaLXqYnsA36pWvzh8q8HrCDPBkgflSChpNK5xqGsOE/2U0xFa4wQq
         BEGbw5LPf0rIg7yEUlltCjr4PNcpSioxiOHwCysEvuqwtZEGpNlkgufdc3IHMnVecb81
         mIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775322769; x=1775927569;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rX6kog0WiND1vKJItBPvNGZ0DQ567Jj/zem1pITjXM=;
        b=UGmbND1ZAEiJJSi6mI4D3wwJqRz/Krz8mhacXozCTxPfXZBbCpr0y18IzWIVSd2bmg
         uGGheFp/ypPK6uevWJhJbmcqlW+xnhpVenOQEhuf1+ch6jo3A18peMb5OYSj1CgfoZgJ
         6r3fuR1oFTsaT57Ks0KpDxFMeIHt9ZeoR96YcZRiP0Ju8weKieFCeqW/Klzex+g4QUJM
         AwBN8/im3BYvMSy0gDdzLMjX/L1ZySFLZpAwHVqCi3O2v3xqTDG38ALCZ7+17RRkH5XC
         Cx5rGu2CGvXVctbhY4XwYQ+SfRpyTvs+/3IAt3qwPyKpmhyTrUJpRbsvzHmqV7f8FF8W
         G/Sw==
X-Gm-Message-State: AOJu0YyEM9A1SavsZk3qrD8BVWKG7sp9hZMmD/PtjxvnzaH7mTFHFVLZ
	57P486PGsF6pPIiUXq70NGvYiXJRcCquLSTkHO63ALH8XCMPzR/KkMvzvzAjgQ==
X-Gm-Gg: AeBDievwaBHglcmba5UaOyg5tk7zEnuRycgtWsUXpoCr9qC3sVuxPFq5kcMWVJC019B
	x+2EZh5eK96U66cnS4v19vUu1d+w65zqvmD5VwMlG4lh76GQ/rPU3DU6Cfqr5yEACCE5cJv6WYQ
	QVT6pt+OJtnefssRME42oBz+gOVFYJARi+T6s0Vkp5sLboG1aV6YztEPRvXu+uSd3AZGViGtHmb
	9W+VI4VnwyrvGas2aZ75rtnWMpxcn5OPzOUBb/7Bvddsb6BkMiuzeopXZp2SVqnJBecrl0i/wGi
	9XilbFpl1UeSVGkCOB5UvSsBLNa4zJ7NfUhdy2f6jzyYnu0T+qqIf51aPjN/3Fium9AGUcHOrgX
	MOM1XlYii+4EYusOVbHHnhVew/Ok8lgBixOjBaI+FRa1eImIgFlWYKjNndhOoTQcKByOnvdpQmM
	jL8Uppj3HMK8fQNljMLXjqNckYIA==
X-Received: by 2002:a05:7300:cd8a:b0:2c7:2c0b:f334 with SMTP id 5a478bee46e88-2cbfb4a6039mr3485619eec.18.1775322769093;
        Sat, 04 Apr 2026 10:12:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.111.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df3b84sm7931384eec.5.2026.04.04.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:12:48 -0700 (PDT)
Message-Id: <pull.2077.git.1775322767.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 17:12:43 +0000
Subject: [PATCH 0/4] Doc difftool
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is another set of changes to convert the manual pages to synopsis
style.

Nothing noteworthy to add, pretty straight-forward.

Jean-Noël Avila (4):
  doc: convert git-difftool manual page to synopsis style
  doc: convert git-range-diff manual page to synopsis style
  doc: convert git-shortlog manual page to synopsis style
  doc: convert git-describe manual page to synopsis style

 Documentation/config/difftool.adoc  | 24 ++++----
 Documentation/config/mergetool.adoc |  8 +--
 Documentation/git-describe.adoc     | 96 ++++++++++++++---------------
 Documentation/git-difftool.adoc     | 80 ++++++++++++------------
 Documentation/git-range-diff.adoc   | 50 +++++++--------
 Documentation/git-shortlog.adoc     | 60 +++++++++---------
 6 files changed, 159 insertions(+), 159 deletions(-)


base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2077%2Fjnavila%2Fdoc_difftool-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2077/jnavila/doc_difftool-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2077
-- 
gitgitgadget
