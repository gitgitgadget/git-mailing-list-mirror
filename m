Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A33D3D1E
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954675; cv=none; b=HRAEDzXxIOg1KNsUw/5WUpCiUMUOv/sH/bdxx60b8tESNfmWPKOcz9k7+TIb6VNYS94VGci36NeLyqrWmoQr84RuH+MdlVVEnhNdNS9vJwS2VUwNxToHDWoXyDHG/V3uyaK7QDtH/3z15spR8ISxImIuIqpWobo2ng83feRyg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954675; c=relaxed/simple;
	bh=YuZdmJtWAH56WLbqJWyweyHSW7QAabiH0PVEsHBdonc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fpqji1HDH0pDnkSLeo0RDm6Eq/TZgA+ScTX9/kOyrabmqryVnmyYb12b/sj6wciXjdySWO3NFsNdvx9x2u4riEgvRru1AE6x4gShhf695LWxOuv4JBb5iTDjTjSLMbFtpaD/m5wRLXRYaRlt/PMgtidsiyCw1pwR4jm7FBCAPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URnCzEQ7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URnCzEQ7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848743155bcso701261b3a.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954670; x=1786559470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qyFuMK1yo/xnP5V6pKD1c36GCJ+o2ocvuldTJW4PwWE=;
        b=URnCzEQ7dx+/5yHv9GLqgLhvdCOaKDhm3zfJbD0nUNPO01L7AilppGHOboGIHSx11O
         Xbc8y0dtwIvZdy17SIow982+uAUCimphTplWcQ5PJerKXlCKPuWxJtoqKLBZBXYtIzsJ
         nZ+YSJpcOa6YZDz0jYwscvpAJz82zFwYh0CBns65CMu4QhfaaBFUB05pSUJbGCvQd69t
         YfBO30GVF2LdEgcYCExs2Oq9NgfLyfNOaa2vL5oCt91jmDb5JhH37AZKGOgeD1MhRIXq
         ePSuRZyrdApl7DipQlMKHBFtF/3byxh69O9y5rMeMJLJoIh4KnJa+hOaKD1k7cLbL69S
         NQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954670; x=1786559470;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qyFuMK1yo/xnP5V6pKD1c36GCJ+o2ocvuldTJW4PwWE=;
        b=MVsCdRf839Kt5QrjuGwxtdNfHmT9R5LLIdOrovOfXPPNe54ZrqIr75d/tPBbDTb0Cw
         Lq0TwWi2QWupoOwsLyvfpThKmg7ZnlFrMT4pLm1fUWbnfOTZhnK1ostbMWOASaDaH+gs
         5e7DBamexDYmSHAH3SVOPCXaHj0+CiJVGHCXB6BowFK4bjq3f3vBr6ZZZA0O9Zm30k7E
         vCDGyRhcc7peBTa556djIjaVplcaNgta4/o7v+UtYecrIMmPbCP0bx2i2DTDLekc6nju
         T8SI0458rZF/Jk1mAHG23Iz4h2WboxBU77qfx5kOJjkpfANXzh576D4hqbhi/by1tQXn
         0aUg==
X-Gm-Message-State: AOJu0YzTgbX9f73DUZKiIEcGz0uOBQlcuimgOrr/q/C5SwQUNHlD73ls
	Fe6dd9KhXh1jD646hVpplcadFTMU8WrwUxI8J4JUZx9G4nl2mLXwzAsagiMb7g==
X-Gm-Gg: AR+sD111SqfN3ZfhSn8AFge4ACKhIIeny5TGRqR9mfSjXn6y7s6lUnP+yeS8VfcaI9i
	bt9EbbuYkB8olUSRxiGsZEqdgh1TSGBKl7hyQ4Lxn6B3b5F6PMXcemDFsuCdYP2fQTwLi/kWsXV
	DzJ3n91fecn5v2fo+9GbMcbV5L+5aTcY5ErkGaEsJTdk8Q2sPh2irY76a8+J9jDhLCrtQecqZQd
	jTIb5ejGBGeXsPh6p9lLJ9sZTfHokqNO43OMxmi+1Vcn2Vb6nGfr5Ep6VxprYz0JOozzdiKWkZ2
	gcJeLkQ33aEx4UAwUGO1CFY6lCkB5Rd9JqEnLHqkAnbpIhJH11iwi8AJGhpcp4m1t2FRfw5dsnM
	NaRKMRFeUi+vY1MuEA/Y1wIt6TM/og2ep6CuvX/Vei3TmprMKgsmrI4f5TzazPPr1uUn4HldTmp
	8nQjXnDKIENwYIvd9c3PucRbgxhjaJ2F8mNoxCDuI6ArZNH0TLN5sHWZKik5QcPXHsYg==
X-Received: by 2002:a05:6a00:1784:b0:84e:23f7:1188 with SMTP id d2e1a72fcca58-84f2e01077fmr9386909b3a.28.1785954669568;
        Wed, 05 Aug 2026 11:31:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2c41besm1310508b3a.6.2026.08.05.11.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:08 -0700 (PDT)
Message-Id: <711671c3abac64d9bb0872a69d45df4f103afc66.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:53 +0000
Subject: [PATCH v2 04/11] reftable tests: check
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

