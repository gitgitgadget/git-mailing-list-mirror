Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2C405C4B
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778947186; cv=none; b=GAOS53KZr/Y03nBv9TkiY+1tX3hXWaRI8XvycBFGKP5ep8aBs2PXiFNFKqeDARqWfpd6oULhKbqGtyL1HMalcQC0wmpey0kHfYWtU51Xqv+qmAmblCm3OTz/vQvcvkc7JHfjz6fue0cgqgCdIRuomu5SfQulSZm1t1RKTHYY4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778947186; c=relaxed/simple;
	bh=SArjMurTFf9Y7DWuAoiwAUiK3COoLAm05bocRvrGX5A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MmLoOxMQjurTEdslYeMMCEK9nwlHPxsujARhvZceB8Rf2fpbrBU9OdH7HOTjvh8DuJNvoyvcJ7taIs5NKIBZmXb0Hsg897kF+33C9fe/qapUXrlc4MckJ6SwAAeCAjJZi9GdL6HNRpC/mpQNJFBdqPDqLfDbEbQKq0adxJIaQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afRIdgY5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afRIdgY5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f33ae12f97so3568396eec.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778947184; x=1779551984; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBPQkyxZs6fSNd7cbgielRsKBVFFUqz0h0RH5de7kyU=;
        b=afRIdgY5kX5ShcHP2OM4N948DDNrwAJyRQMjwzrb6wdgES4DUrRS2l3X1HdL3wfonF
         KUuPpFFd+caKyNOexZLOmoRmrKkji941b/U0dWdtq0g/C5WIomLfllriodQCpNdSGQlp
         16hm3cyy/k5CPANVXR7ZGfxr5bquZPdqQaBXDLJRjFMCyufyEO2bt2ICl2CzkizGWWDL
         I2sSyuVxLnAqCqPqlpYlorNWGQ4H6T6wC6OwDK5u8+wqYBJOB0TkmVopGbF0Lqmu+/3Y
         Fb7otZ+4vRoRDfGnQ2pUvC5XvyysXIusX4HiDhEeASkY9pbXk3sqhAA9t/rZ8LUDzAwQ
         2V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778947184; x=1779551984;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBPQkyxZs6fSNd7cbgielRsKBVFFUqz0h0RH5de7kyU=;
        b=ZP0Yrs01rxLboPJRE+r4gFtYINd420UhX7EwNl8DWYrZpTcSMCZxjBJrEn5rh4q9Hc
         wyclItAlW1s9Rt11dwZQObylVqU1QXCsGe+p/E0aer+06lBV/PsBeZhxFm3u0cm0a4i2
         GOS9M+YPLly2VCmC3AAiw8KNNWF0ZByudcFOm4qSxvM/psZfJ/vMTQS7KKOWQ5Xh/Ta5
         cAClsSntUrhcG7z6bfX5eTZzOLp3j8SDM5YzTxtZegfAbkRZRqJPW9Rg2rJs9IYKFb3y
         YfWgNePwOq8zfeMaAVB6RhlWYiSH7kt4jGX5wSdf/9Oavx4H36m6pmTRIECJ9noJndHB
         FKJA==
X-Gm-Message-State: AOJu0YygsQqAbW67AHuDLP3IQdPYx6610uc6/xveCoClkCM62/J7BAC9
	LgssTdNuboKFjRNxvMbRSwwuHhAu0lr8qr3Ki6YnGob+5U8/Pvzu2YidUYzAuw==
X-Gm-Gg: Acq92OFdrK+K//H8RnxvVWfYhPyGB9VA3lnnaYAV6emUw4ukkHyJpwzdM8O+w3ld1l5
	HPl+ZTt5V9EmnyXxPajw/M15jVVtcnphz0WpbY3vQYt5zRIbVlrsvJ69LkjxrqLb2RoQaHIGIW7
	pNT+P4K63sDez0bj1Ko/qWt1wjlkyJAPI1Bue6zX0CdYCdwHOgRSwx18olj5ovbrdp3gdYNpSnm
	2zSXiaj9DBRm5PUfREEF8UquChe8EEdZl6NEh7uBrKzhW3ZFxfbrPFr+TLxZggsv9lvvlmfBkPs
	iohD0k7P1xlb94RuuHAIYzGpIkAOb9TLavPBWEfeWkEGoAwE+sncbYLdBhWagkfKqj8kU11+l2s
	gdlfX3+aK5PRm06hLIPYv2s5g2rhXGnJKLTXibQL78P2uT4OURKsbQnP+EVX1qv9jamEHn2MvnT
	DoD8rCPhCgv11sb/zvOH0Zo0VlXh1Vx8oz82JNYoE=
X-Received: by 2002:a05:7300:dc03:b0:2f5:5907:3a49 with SMTP id 5a478bee46e88-3039867718cmr3829102eec.30.1778947183847;
        Sat, 16 May 2026 08:59:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302944ffb85sm10059357eec.7.2026.05.16.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:59:43 -0700 (PDT)
Message-Id: <pull.2116.v3.git.1778947182.gitgitgadget@gmail.com>
In-Reply-To: <pull.2116.v2.git.1778922993480.gitgitgadget@gmail.com>
References: <pull.2116.v2.git.1778922993480.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 May 2026 15:59:39 +0000
Subject: [PATCH v3 0/2] commit-reach: use object flags for tips_reachable_from_bases()
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
Cc: Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>,
    Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>

This replaces the O(C*T) linear scan in tips_reachable_from_bases() with an
O(1) flag check using the RESULT object flag.

The function is called by git for-each-ref --merged and git branch/tag
--contains/--no-contains via reach_filter() in ref-filter.c.

Benchmarks on a merge-heavy monorepo (2.3M commits, 10,000 refs):

 * for-each-ref --merged HEAD: 6.6s → 1.6s (4.1x)
 * for-each-ref --no-merged HEAD: 6.7s → 1.7s (4.0x)

On linux.git with 10,000 synthetic branches at the root commit:

 * for-each-ref --merged HEAD: 1.35s → 0.35s (3.9x)
 * for-each-ref --no-merged HEAD: 1.82s → 0.31s (5.9x)

v2 of this patch, addressing Jeff King's feedback:

 * Replaced the decoration hash with the RESULT object flag (simpler, no
   extra data structure, handles duplicate tips naturally)
 * Fixed early-termination bug when multiple refs point to the same commit
   (the decoration API overwrites on duplicate keys)
 * Removed the now-unused index field from struct commit_and_index
 * Diff is +11/-12 lines

Kristofer Karlsson (2):
  commit-reach: use object flags for tips_reachable_from_bases()
  t6600: add tests for duplicate tips in tips_reachable_from_bases()

 commit-reach.c        | 23 +++++++++++-----------
 t/t6600-test-reach.sh | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 12 deletions(-)


base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2116%2Fspkrka%2Ftips-reachable-minimal-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2116/spkrka/tips-reachable-minimal-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2116

Range-diff vs v2:

 1:  7399a12518 = 1:  7399a12518 commit-reach: use object flags for tips_reachable_from_bases()
 -:  ---------- > 2:  4d11ebb79e t6600: add tests for duplicate tips in tips_reachable_from_bases()

-- 
gitgitgadget
