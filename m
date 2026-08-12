Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5A3AE712
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521817; cv=none; b=iMk4QUaqU25ATvOSuuyXMaRMwvAp1Vc1IL+8jINyOPQm6/1sUAC5oQzU0hl0E/xc/5g93aM2R5CXRbrO/VcfD6fILIHxHTfPqXMoJ6Dx36AR6d6WbcZBeeqUdYUAssGKjQyg4MCL/D/fYW0tV7d/7WD/OFtV/C8L/a0fkAhe0Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521817; c=relaxed/simple;
	bh=YuZdmJtWAH56WLbqJWyweyHSW7QAabiH0PVEsHBdonc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lB2vKOIWymCtA8SYE9cWyh4gYWjskdUIYezKo3auLwlnTXvcKwOvyxz7FRz79sOXr4AOrJtYkme0guSF8Vh5fN0CUqOvwJtg0u7rwL4uTNSpuh+GRZNju1V3V2RIWPMiZvVeTLWG90k+Bz4tGS9daY43sc8sp6n2ZGWi5H4hZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0914ahM; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0914ahM"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e08baf860so830440a91.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521815; x=1787126615; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qyFuMK1yo/xnP5V6pKD1c36GCJ+o2ocvuldTJW4PwWE=;
        b=U0914ahMp1Q0QPqyADjSE9EghBw5n/gIPFRvlrEe5rS+YBisSmcAqHH4Nmsppg+c5I
         x+hZpaIEwSYB5dyCc9LqMJb1e7QcpyhSaVEIsmO/dwk364zVOCLjNqyGFtTOlqfu0bLo
         BFrVuKlGfzXf6xEuY/9niwwnFtc764++BPKGVJAawgjmeHNuLIlmXZOy28JlwAN4wPGI
         hdzugO82YJZE/x3wcPGj1b9IbfYbF1YD9J8x8bfbA6HBOtwuQPJ59eqH/gUAs/2UM+wt
         T6Lz1eG7evpHdsM3C3ekZsYgRXuJkE6PD3qYHDMECpPjf1sV9u2cEt9y9W3iPvyjJtfU
         8VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521815; x=1787126615;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qyFuMK1yo/xnP5V6pKD1c36GCJ+o2ocvuldTJW4PwWE=;
        b=G+he4MU2XhHcwh7ruD+/GHfFNGAnq5fbqlg78TPcLsUYSpb854I30LKBBsPRlEXGzR
         5jtXr3wD8MFsOJHoDzcEevzjrhgkSgfLWO2RVRX0z1YMkta80STm1MI1xcH879lUF7fw
         s44USu2gFB+D1M8ZzZh2KByU3P/kHZ6nGHqgyJd3Vdm6OVvCtuOmCWWwpKNebz0nxNoE
         4Rl5J1O8jTI25HkWoaC3SMuvydhU4rotvAadjKSZ+dcfaTBTXXj8iWK8+qPCLolVhilO
         ZqDMQmYz8uAXXVMOrqJpkqc3bczf0IlgjlMr0A/n0CahXX8RFz6HM6Mrb4L4URZK+fAY
         OYoQ==
X-Gm-Message-State: AOJu0YytoYfOhfXFQ6PTdDl4LtCB+ikxcq1hImiV9r09ae+RW7s2Z8tY
	dCwQl+Dz8onplDSXKHdzu8vDYRXEzciOZOOIxSs0W778cHZYC4NtVrQ9WErgDXPo
X-Gm-Gg: AR+sD11lZokSZh+1wYdl1AtKGYiWvFTkvdcREgFzJk6Fw/nBf6ndfEh+KhXif6schOj
	OSF45zjV9Zm6ANU9FYCpNpNAYgdr/TOf2fnUHVPoPdKqmjOrynShT56N+hyqaahpZFPwXVmZnRj
	BDE+rR2bMtF0f3owOc5xWiLQQRzSbBn0OFCuLaIcJrCwFxrOzYKGMhFZ67fai8U1yTZ3q10fTJw
	ns2bnnL6lq1AA3cDW1qmydpQlUGzuDFaVihqQ2jRcsY8lF3oBmqeI2LMzioXDUhdyD0VAKX56Y1
	bcBiye4vLOnWjS/Gp9dqcS9HZOCtkouy6MZ7Qat+5rxMINbU3hmG2sKpq+hustfzMswQoLha69O
	gOqK/sMmvW6VAWJJm84Ldp1isT3NzbCprSKsl5XYLyAqvztMBmNGglS8QBeSuuTwisgtQ43Jf0C
	KVW1ETLrbV1fOgbNZherlKQJ6vJjCgDin92WmDjdbk+NuYE8DQTCGa00kNM/osIzRVIOMqcB/x
X-Received: by 2002:a17:90b:4988:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-393014d5c6emr3550122a91.17.1786521815155;
        Wed, 12 Aug 2026 01:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8cffe0fsm2617767a91.9.2026.08.12.01.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:34 -0700 (PDT)
Message-Id: <a49af20d3052a7c905920dfd830ff95996d11bc0.1786521801.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:13 +0000
Subject: [PATCH v3 05/12] reftable tests: check
 reftable_table_init_ref_iterator() return
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

test_reftable_table__seek_once() and test_reftable_table__reseek()
both call reftable_table_init_ref_iterator() without checking its
return value. This function returns an int error code (0 on
success, negative on failure). Every other reftable function call
in these same tests checks the return via cl_assert_equal_i() or
cl_assert(), making this omission inconsistent.

If the iterator initialization ever fails (e.g., due to a memory
allocation failure in the reftable internals), the test would
proceed to seek and read with an uninitialized iterator, producing
misleading test results or crashes rather than a clear assertion
failure.

Check the return value via cl_assert_equal_i(ret, 0), consistent
with the surrounding code.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/unit-tests/u-reftable-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index fae478ee04..6f444f8cf9 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -29,7 +29,8 @@ void test_reftable_table__seek_once(void)
 	ret = reftable_table_new(&table, &source, "name");
 	cl_assert(!ret);
 
-	reftable_table_init_ref_iterator(table, &it);
+	ret = reftable_table_init_ref_iterator(table, &it);
+	cl_assert_equal_i(ret, 0);
 	ret = reftable_iterator_seek_ref(&it, "");
 	cl_assert(!ret);
 	ret = reftable_iterator_next_ref(&it, &ref);
@@ -71,7 +72,8 @@ void test_reftable_table__reseek(void)
 	ret = reftable_table_new(&table, &source, "name");
 	cl_assert(!ret);
 
-	reftable_table_init_ref_iterator(table, &it);
+	ret = reftable_table_init_ref_iterator(table, &it);
+	cl_assert_equal_i(ret, 0);
 
 	for (size_t i = 0; i < 5; i++) {
 		ret = reftable_iterator_seek_ref(&it, "");
-- 
gitgitgadget

