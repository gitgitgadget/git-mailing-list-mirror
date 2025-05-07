Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DF757EA
	for <git@vger.kernel.org>; Wed,  7 May 2025 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579328; cv=none; b=kjfiD7u+sE6WYdyyp08NFHcvQxPoKKsByqrBL4rhs5PsdV7huRR+PwJ9012ww4lAUB/bk0t84Y3sbOcMhWEqcY/rWfOPsK7K23ufz49aMXAqMFgQAa4psXqaCoRB4QxDrTB83L4/jsUMDF4fzHnw6bEnQ3fQ8LJ5rkbyEOJ6ufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579328; c=relaxed/simple;
	bh=hlsN4FOntRxFbSgXmqWebcGuMuB9s/zVebGWMntMb7k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uIBNQwGkeORfEPG0vlMNabAeXcvorvt8mPLAfOk1zOKOfzR3DhHgtu/hv3KJ0s+mxXuTIfjrdxGuaXG4nPTSgdmFzOfgHGVQia8BZrfniZq2o5cqmyOxgZ8S8rKCVZbLFPG4TfFdscseAF+x7DhoASMhYy+Jy4dJEYiM62hxmUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8lYNUb2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8lYNUb2"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so7420412f8f.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 17:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746579325; x=1747184125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqTaSpXdJAcd1kkEqodaCsarh0ZedqDXns+NowWEHms=;
        b=F8lYNUb2+824PIbhHFC/56/gEpJbgGaZOdcBMWq7xfuup+tRI7SIXPqe9ZiRa6vDjU
         lDZMm1pjA+cG4XajpeDhKcA8xZ3Vwh2aTn0qp30yFMnYlyU9eWUZDD7RpOygpSUPHXYm
         jNpi/9hx8oyIacPdVIcSt/emVaTiKn1pPUr3vBpDT4sadO4/ZpyK0WiG9+/Ea8JJKftf
         EmBX6oToDblUa2bMN5fnEkXvKXZhFjD4rAE2yzt3XffXtKhLvJouxELoPVW0PEbsLryn
         3OTzr+bHFk1d+61DWryZp7NzpMsp6QfErp3spQHVf48RW9oUfIGX/KWrRoqku5uBGXQf
         X13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579325; x=1747184125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqTaSpXdJAcd1kkEqodaCsarh0ZedqDXns+NowWEHms=;
        b=cZMwWQFwvIhqKZDEo8KjFURpemKGwc63mo+n6apnj5qbnuDrYHQHVJRKK6LhcFfrnk
         T5HRIqXphW1ZeG5fSfJr6n+/Luyo4+cy/fn9e2havsRbGELN3i+3Pjl2qa1pXSX6qArM
         dv+OI0ruVYldqiqBUh7qOiH0+RQdL2p1dyJ8bZHnhkJlgBtUK102lvex2/H2DX43TwDT
         0Rcd+c4im/b+f7qXLNFqtnAO7RudniIyM9GyIOvPYnaWU7LzuZKfYKLYQVUDvyqWFyYE
         FmyW9HFHRfmdjBdaV4PEoQg0E1CgYnMBoFb/ezLCDZ3KqVr3VtGJThr/be9XyyGFlRkQ
         qmyA==
X-Gm-Message-State: AOJu0Yz2CziLci2eGx+9nIT2k7cZFVzlCol2uAr0NG5LjXcKc1QWazMg
	KrU+FgRnTDGbUE6JbAhlOEhFdeNNtD9AjKvvs5dKt3kYHIZV09V2EP1IVA==
X-Gm-Gg: ASbGncsrgGW3Mljd823+YXInIjoBrmysQWAGUmsnl1hfe+ozE566pzoFNQK814LcA12
	MxUrKeE8FJbXfQc4jM5cxWjE2QhoxNJd3L1wWncqzKqHEtpNrH76xkNs3Ytxi5i9GgIa3Sn6T3f
	5zoO4rRK9t/oVubAyIaMFh3rRx46X7l3EMUHW3xziHE3T/za6XiHV7HrmAkQdkAEUAD0QG+q4tK
	QmJvo2F8DHylyOUKgPsMKGypQ6C+zM9k3aY2ntv1MHl5nBgaZukyhbq4oH4jkafH6jREOPIclyO
	lnc8mI7j+Wp/SxuIWE4Ebl32qpWnlBwGFNu5Ukoh+Q==
X-Google-Smtp-Source: AGHT+IF1OY5AFtbq47AwRSz2K1yL3VNyrQaHOmrOkxjL7vBdT3T/4Zn8OuOHgZNr0z9BzDVO6NWJsw==
X-Received: by 2002:a05:6000:2c7:b0:391:4889:5045 with SMTP id ffacd0b85a97d-3a0b4a03562mr996104f8f.36.1746579324536;
        Tue, 06 May 2025 17:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b3331cb0sm1948770f8f.65.2025.05.06.17.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 17:55:23 -0700 (PDT)
Message-Id: <7a777281626dc5fa9b191efe25442e0e856950e6.1746579321.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 May 2025 00:55:20 +0000
Subject: [PATCH 3/3] p2000: add performance test for 'git add -p'
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
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous two changes contributed performance improvements to 'git
apply' and 'git add -p' when using a sparse index. Add a performance
test to demonstrate this (and to help validate that performance remains
good in the future).

In the truncated test output below, we see that the full checkout
performance changes within noise expectations, but the sparse index
cases improve 33% and then 96%.

                      HEAD~3     HEAD~2         HEAD~1
---------------------------------------------------------
2000.118: (full-v3)     0.80   0.84 +5.0%     0.84  +5.0%
2000.119: (full-v4)     0.76   0.79 +3.9%     0.80  +5.3%
2000.120: (sparse-v3)   2.09   1.39 -33.5%    0.07 -96.7%
2000.121: (sparse-v4)   2.09   1.39 -33.5%    0.07 -96.7%

It is worth noting that if our test was more involved and had multiple
hunks to evaluate, then the time spent in 'git apply' would dominate due
to multiple index loads and writes. As it stands, we need the sparse
index improvement in 'git add -p' itself to confirm this performance
improvement.

Since the change for 'git add -i' is identical, we avoid a second test
case for that similar operation.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p2000-sparse-operations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 39e92b084143..3da6ae59c000 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -135,5 +135,6 @@ test_perf_on_all git diff-tree HEAD
 test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a
 test_perf_on_all "git worktree add ../temp && git worktree remove ../temp"
 test_perf_on_all git check-attr -a -- $SPARSE_CONE/a
+test_perf_on_all 'echo >>a && test_write_lines y | git add -p'
 
 test_done
-- 
gitgitgadget
