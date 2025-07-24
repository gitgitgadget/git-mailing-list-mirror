Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4340274B29
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344900; cv=none; b=DhjFn9JWIbcJ7doKsUlgCx0s2MBA8mCax0X/24IpAWCzNKvlo13Khs2HXmcAZD/CSdUjzT0cwmWH/y6m7E3bLCoN8IyDT+fa3u4zXMy/pcnM9wTVGAznJ9tU9rAWr0Ru8f3tWzBzdTKC4Luz3TVLntaW4mxiQ8Bfpbf+Ph5uX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344900; c=relaxed/simple;
	bh=6CDLoM3FWSqvl64a+5dRd3p7aKKfRw/rp2zUrtYAwjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIJ6kX6ylC/K75qKA73kxVpixDdJelhDZ9ILJfnJ9jZRITLgjALyFd6AOs37teSL7Ndis7laHdP3ta9q8lMesEfWskgGhpIrdZtQ6MpbK9HVxiL0NQbipez3IYMH/7t2mo24d+QT7Ba6VTi1GY1fhPs0uZjpyu2SqL6AgeaqyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDQvkCsm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDQvkCsm"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45629703011so4425325e9.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344897; x=1753949697; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfvE5OXKEU5B8CbO+nB7LKc4z/QT7rn38qpAtT+146w=;
        b=PDQvkCsmSQYPQlAG9Du1KVUEjIeOFZaTFnmy2pZkESdOnioLxmwqfLqJ6Te0c1caGS
         TIKEU1f9KX+dDSgvjSAaZuhi+Yd/kZteiLsUihylDNxyBJ5sveT1hQlm7yDxOKeMbj1f
         dpPTm6/u77hdzXzAwl6SIKf5ofifYHct/38c240j2mDL9Xy0eAW7dvuEMJujZzUaw7dI
         4njKVJy3JU5s0hqJwz7nCv4RUUTjX84D2C7QFH0bIu+u8XivxDbjFd3D7SauzXa76k7A
         9KOrlfwFflgwRohDKy516jSuZFjt7q7mFEAk//sHGmhvw+w3c3+pigMTvVvsvCgBmDOT
         wlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344897; x=1753949697;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfvE5OXKEU5B8CbO+nB7LKc4z/QT7rn38qpAtT+146w=;
        b=ncxgle9VJDoVJDoV+MyMOZ3X8KxY6WzSOrAvldmcCSRXyDDlBLeqlDn/mxFTEvI7sG
         NynFBH0H1fV3NEDsX5S2UW6V+jyI1f2j7S9FuOlvOLivw43X9mQdsGMKr22q5cIhbkUF
         wnUJk1PTfzSegE6gRVN4H5r0YkvnjTxY6VU/XJJW8h9Nqu/beevsCWDhjros0+xmtM0Y
         6pajDCE7OCe7pE8YMH1Ko5PWg8nLIAfr10uHFeV0n8e2+1PMzg2cg9YQQEqwVemxVHr9
         a9pUmCvJmt8BdBhHHxaOZKLm1K4eZ1AQuFI/ftzKB0ddtrzKMyIWR/3kyhspCJt2AFLS
         t0jA==
X-Gm-Message-State: AOJu0YwcNipqbN4IteP+BtLs4SPebaiA2WeUsAAKfo32vPKKaR2vJeFg
	oDy2ISzWQGuafq+dDBzZU51YjqKt7B3AcXlmRRITklmJvJ+3PG7fzsAnbnpVdvVS
X-Gm-Gg: ASbGncteFAPCZeymS+fzVsoF6G6RiQSUNMuTaTacbpe9Qf7DcqxeQuW8BWu5KWgX4Xq
	01r54dFL3XT/v03QoTJcPE86k/6nWOQE7m/AsDqPe11h1HjmyXJwvSUPDjXuPD11+xkpZ4N6mU+
	BMYwokWbU19QKtj2P7Z2y3h2kJw1v6/2y5SPD4T4QzU0aKBHSXvz6WZYzpmI6aFSGzQFJwFQrS2
	+fDSdAK3gmQH8YOLSa+gcCz0qqv4G3+gOr4fFNNog1rzkY9fT9A1V9ywFKSuJVIFWxNT7JZCt8R
	+6ymH+XoToF5AhF8BwgHu3jfGjUhmcNQBKcz3eGYtYiSqyghsvirNB6a470IfVC4D19Aa6Y3SII
	=
X-Google-Smtp-Source: AGHT+IHFu5rS0AnNc+3k7E1Uw/d4XOcPs0dzoqly0La7M1eM8c/YQo4Z0PcJklh6+UOfAYQIobIjBg==
X-Received: by 2002:a05:600c:8717:b0:456:24aa:9586 with SMTP id 5b1f17b1804b1-45868d4efa6mr45859235e9.21.1753344896715;
        Thu, 24 Jul 2025 01:14:56 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586e7d1326sm14678865e9.0.2025.07.24.01.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:14:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 24 Jul 2025 10:14:43 +0200
Subject: [PATCH 2/5] for-each-ref: fix documentation argument ordering
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-kn-small-cleanups-v1-2-0c70f591de3e@gmail.com>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
In-Reply-To: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=6CDLoM3FWSqvl64a+5dRd3p7aKKfRw/rp2zUrtYAwjM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiB633SZklz/ppLkv3HIRGbgT8BcdWDcbDlO
 puIVGTpPKubEokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoget9AAoJED7VnySO
 Rox/1ZQL/iYW0DP3xkIhtgmf4SJPEiCGJ1elvx8tW9rNABAuqyyriiyjleCLNddgelnRMhe0hKB
 95HJ+purUTlLLClhA8IWN4MLucqBxpbAQZp+psSDQflAOW9EyVs6o2E7SUerhspwraLEHGV7drT
 e2xvcarr9WTnOTo9oN6QLcA1uO9uKXgPgcq5FnwvTxgM4Jv4SZJxbGPoCHjdw5LxpxckplZaVfl
 RGwdeWqM9nbSCjkns8TfRHA/LCLGuFrBld42qqo4aYXDvEoR2tR5X6yMqNVxY/vlS8zBDeNgnAC
 hJ4VRsiKaRLV/bUcWk/crhEmFklowbiiprzEI4tAoPLeuGZ3g13c/KE1NrYTPgIpAtM2SRBZuX1
 UoZTr3KdWvuVpyMM6OJSsspASCpMg4gzMSSD76BmvxkCj2stOkFcks3haS6zHOOngh/vPH2E6Bb
 iUphcrztAi6kRNlDIbdKEZ8kMVYmy8GvFxOY3IkgQwfTUJ6jwSHVaXE3ldn8gYXTU6lMepYfi65
 gg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Improve the 'git-for-each-ref(1)' documentation with two corrections:

1. Add parentheses around `--exclude=<pattern>` to indicate this option
   can be repeated as a complete unit.

2. Move `--stdin | <pattern> ...` to the end, after all flags, since
   `<pattern>` is a positional argument that should appear last in the
   argument list.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index ae61ba642a..a170de4209 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -10,11 +10,11 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>]
-		   [--include-root-refs] [ --stdin | <pattern>... ]
-		   [--points-at=<object>]
+		   [--include-root-refs] [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
-		   [--exclude=<pattern> ...] [--start-after=<marker>]
+		   [(--exclude=<pattern>)...] [--start-after=<marker>]
+           [ --stdin | <pattern>... ]
 
 DESCRIPTION
 -----------

-- 
2.49.0

