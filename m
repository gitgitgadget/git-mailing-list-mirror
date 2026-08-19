Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B34392806
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145605; cv=none; b=qVFxiCm3VRQ0D8xOCF6UAicuUN/oib988gqrQ1U1CVkGcf5AhJMXfJ8bWIG+TmizLKAXGmNkaQWlybmyrvZfQgFFSv933fYVFfK+aTLcc3Fln/6BMSkxO2xZm6qeFipOcq6ZVI47lSZ33QlSw1XKin2w0XOKiBOClKnvvOs19pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145605; c=relaxed/simple;
	bh=Na8ybHfM55CKgiqXSEIbwPsCZTVtZl8lotsUFwfUzyw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pZ7whZ6ZdMczCS2GgW/edp/SpyLxqLTb/Low88BNCIbmbfc905qjbTzXm0TEIKUaGsWumVnSK2fzK/wrD1wjH3rUHt0zznD5WhEYK/9cjDucDOJ6fltkAQyvVZUHAwmm2snGROcCYydQqMRVOFedE4f4var+/Iqvjvdii8z5ssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpLM1BMz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpLM1BMz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4813ea321cdso1441131f8f.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145602; x=1787750402; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=84kcllmlzQ2GGSsUhVVNvsq3Q4RjvuZH5cwVIkSpcY8=;
        b=IpLM1BMzmDLlM3v50WQMTAisLReAE8iB0ymNK0fsZddd6Oo50Y9Z4qPC2M6ED7KkIG
         mCRnqlXtykxU8b3nGa5KVLSja80O6M54f5Fn/qpA6r3yRwZdrQiJIMxFwk3TkbRsqDIl
         Gqi0N/gFZXtzEIiYjRGqmlrmPhpZnbI/EGrwM+pyLASwoI6NDd9eShFExtqlEdsYLrtj
         fjob5lx/9QOYu4X5pNolK4+Q7sSdHerzEIYeEc2O1zHAOl320YB2OD4eEb/bq5FsM/U6
         N6cD7+YK4tpUgfq8ml3hkHPE6AalMbq+TrjhEh2k1v0qmX+PzSvVQ8J8iP17XxyEMjzx
         7A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145602; x=1787750402;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=84kcllmlzQ2GGSsUhVVNvsq3Q4RjvuZH5cwVIkSpcY8=;
        b=jl+6VBUCQwe5DNHD20p0uFP46JAGuKrJKR5ggJGq4MixgPL9TKiSMqMbolwUWOmERh
         BtOOtXJb5pIou6dm73nkFrnJDvJ0awtAcbyIOiFhgswYvAfBC24IMGTTb5C4hG20ws7C
         piwM7aLzPzoRlVXrkr7fFAC8zXZBQeYLJiKt4gsE7XVmXbmzqHECoEOZicrCWqhMxBJh
         GC220sZjnGp+Xh5uTLISf2T5rcrBYlPRt6ffuZoMGGUw6YucOQGOaDQZGLoBhFU0ClsH
         c0G7SXGa5JhMtomoL8D17U1Yn3fjq65eVKYh0q/eQ4ghKSP01umQ8Ey4S7x2WW1smYIv
         bF9A==
X-Gm-Message-State: AOJu0YzvAktbfNqBp4cOsc9VFY0N+l5K9cV0cdGTwoSCI3dEkYjinEwA
	9ys7IphgvScDkOdUCDadHUoKorL8yAyuWQV00O0QzUfbz3+Cjm+24fgiFQxA1kHx
X-Gm-Gg: AR+sD11xVUQQhGvL5JRViEy2b4Jz4S2CXaHHHGSK/J2NleUcdIu7b7pOI7FZbVqegeo
	Aa3DTqC84+HnFqY4/nh6zYnNnJApAOf9/GaJUkLgjN+02wV46U+ujhNFlRTMUVHtqh90abwCnII
	ix93IJNopYvaheQ0x+BugstJyVNEKFBVv2A1vV76bx7VzH+HhLEM9n6SytDgLNltzEcndsn93yU
	TUuDOVnOguQjQagJbzJFPoOVyd4C1W7cA5AQxaDORGCJ8dqbor/wDIdC8jGu0zeOp6xGomgrxDd
	SPlQA/1B29kxIJ/9cnm3gANmVJpbWCreMJa4hUTBrf3NP38q3sp8Z4TkcyNG2kHimCUNpT5Hmn+
	zfTb+1krYlCzahLn009DXTOdkW/mKah8yUM0oZD3Hi2AKUJWmdWhkzMP7TLv2CcR77VYItez003
	AscQrjVtT654bHUD1NdsyDueDxzEaNVDFidpMlDIhqtdqgMq3BUc2zof9yaiAOcL7rm7wOOxppr
	TGylTGyfjQNQGdTFuBE+HVvccvUvffRosdhAg==
X-Received: by 2002:a05:600c:6308:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-499aa0ab6b0mr77076225e9.1.1787145601775;
        Wed, 19 Aug 2026 06:20:01 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:15a6:881d:7fd4:eabb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499a9ddee1esm37578955e9.2.2026.08.19.06.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:20:01 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] reftable/stack: avoid reloading the stack when locked
Date: Wed, 19 Aug 2026 15:19:36 +0200
Message-Id: <20260819-740-optimize-reloading-the-reftable-stack-v1-0-6bf5305d4e43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNyw6CMBCF4Vchs3aSAfESX8WwGNopjGJL2mqMh
 He36PLLSc6/QJKokuBSLRDlpUmDL6h3FZiR/SCothgaao50rls8tYRhzvrQj2CUKbBVP2AeN7n
 M/SSYMps7uoPbs3XEZAjK31x2ff9a1+7v9OxvYvIWgHX9AqvYKnONAAAA
X-Change-ID: 20260814-740-optimize-reloading-the-reftable-stack-f5f3adf0a0c0
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2853; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Na8ybHfM55CKgiqXSEIbwPsCZTVtZl8lotsUFwfUzyw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqFrYCEHtqxzj9ALNSS6881N0w1EzrH1spVM
 uIC09Cqv0B6Y4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqha2AAAoJED7VnySO
 Rox/2NwL/RrtTcyfNM8StJrBu9HsAORHdGpA6FyyksYs5CgsjzoN7s0nEj9tkggEC5kChiLQAIP
 c1Oc1y+Uc7IXdI93qR2ActHp5L+EkBJHWfAm0Zo6TcfCb/kb3oL2eqnCiHky2Uflpnrk6kQ0CNO
 y0CiiMj/x1tjU5tUV2WBArSomvAUKCuXpijhz6yfliSLjzYHZ7y3yJqcnN0+c5U7Z0aD98R/6sP
 VaLbFqe6/5yK+/JTaYj2a0nWspZv36ixjxUe4ndNdpszrV9PNWI2G/+rQs9UsEr1P/2J6s3Q0hL
 +JGaGc5nNLpb8wLOncmYihUbWjjN7+cPDoORFDbID0R3XxJ/rg8Qf8cZoB7xGmnsKmDd8ibV1ef
 9tLEpzNczblmC2VDiUhksjQoxxwHYDOLJ0mOfRgFEYNaL9eSgpiW/PyCOk9yk6hMknVHbhEJ/7h
 Q9NhVMsyfhwCJH8+ilGJUs0GfoMZlE1SsCjaXSn6RQ65+253mGO6cUuwSirCQPiwFrWAjw5dkJ6
 xM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This patch series is based on the report by Jeff [1], where he noticed
that when creating a lot of refs within a single reference transaction,
the majority of the time was spent on fstat().

The issue stems from the fact that within the reftable library we do not
track Git reference transactions, as such any calls within the library
would potentially reload the stack to ensure that there are no
concurrent updates made to the stack. While this makes sense outside of
a reference transaction, within one, the stack is locked, so reloading
the stack is a no-op. The only time we want to reload the stack is
immediately after locking the list file, which is to catch any
concurrent updates made to the stack.

The first patch in this small series, cleans up the flow of reloading
the stack by providing a flag explicitly. The patch argues that since
all flows reload the stack, the flag can be safely removed. This
simplifies the flow of when to reload the stack.

The next two commits move the lock variable to the reftable_stack
structure and then use this information to decide if reloading of the
stack is necessary.

During benchmarking, I first tried to benchmark adding new references
against HEAD. This kicks in the DWIM ref resolution, and we iterate over
siz difference candidate ref names before settling on a match. Each such
lookup reloads the stack. This happens before the reference transaction
is created. I quickly realized that this would dominate the benchmarks,
so the benchmarks in the third patch are against a static commit OID.

The benchmarks show a consistent 1-2% improvement in clock time for
'git-update-ref(1)', but such low values could also be chalked to being
within an error rate. However, the syscall counts show that now the
calls to `newfstatat()` stay constant at around 55 calls regardless of
the number of refs to be created. Before this would grow linearly with
the number of refs.

[1]: https://lore.kernel.org/git/20260629203527.GA1895313@coredump.intra.peff.net/

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Karthik Nayak (3):
      reftable/stack: remove `REFTABLE_STACK_NEW_ADDITION_RELOAD`
      reftable/stack: move list lock to `struct reftable_stack`
      reftable/stack: avoid reloading the stack when already locked

 refs/reftable-backend.c         | 18 ++++-------
 reftable/reftable-stack.h       | 17 ++--------
 reftable/stack.c                | 69 +++++++++++++++++------------------------
 reftable/stack.h                |  7 ++++-
 t/unit-tests/u-reftable-stack.c | 69 ++++++++++++++++++-----------------------
 5 files changed, 75 insertions(+), 105 deletions(-)


---
base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
change-id: 20260814-740-optimize-reloading-the-reftable-stack-f5f3adf0a0c0


Thanks
- Karthik

