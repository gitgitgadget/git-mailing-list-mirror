Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579F3AE6E9
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289420; cv=none; b=P+Sb/C2K6lcC6VfhjG1lOMA17Mh1YB9PHRY+cVvziKs7YUT4QA08krL3xb47sRvX77fH9gezCQpHPQ6+AMi/ViZqq0AYTIwDjUvWDPHnPfBQnBnVCHqfwHgiGfbC9Fkp6umDWIrrAnvKSmstP42ogoQERRVlNklBzNXG899T3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289420; c=relaxed/simple;
	bh=MuGRrCvrh4YVx3PpNV4gYT59JpqlyPAyi0970k2RMRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEGMeeJWXRDelSdc5EAtbWTnJLrEiknR8RTff5Fos8yyLR0Ot1KeSWRpX7r6Dp5+Fh1CnF6LOgmkjtAaqnwxLdjmKXEEgBRm3Scjuyo4z6OTlAvAi6/nuJuXf1/B5DeQK+pzMmAc5vY6zvXuAKyINCVvZSfHXUNKj12CQgnL3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h/Ty7OrI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KMCT2ug9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h/Ty7OrI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMCT2ug9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B78917A01D0;
	Wed, 24 Jun 2026 04:23:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 04:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289416;
	 x=1782375816; bh=b0jBmHvwlwCGUn1O9TU4nE/MPGEpjA+4wlx9mgH3uDo=; b=
	h/Ty7OrI5n/45+nMuCK7QLj/EC8ZqiXEFG3ztKNEKkW0tkfeOxVGw+cVzR6pRPxT
	kBySC+T99NbM7+kLSarykWOjJB1hw2/2kYCVVJnAFfIgC9Y4jyUVHHo/me1Q26NU
	yglVwfkLVOT69fXvKMw1N+gexsrnppNBvGXJTxoIKQVo9ZP8YlYUGSkG/5g8Y8yU
	lxj3iHLqZc4DyFBM+AE/eYeLUVzVdO91kLVS6KmKNXfPZdpmgzJxIdCvFnh/jvqq
	cXZyvgv6DbCj8oEnZMCOFfp3JsOAPRDbiCaOpZQd4TO2/cs413OfFFzfoDojuitY
	jQgFua6rCkS3BYkFhHvc7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289416; x=
	1782375816; bh=b0jBmHvwlwCGUn1O9TU4nE/MPGEpjA+4wlx9mgH3uDo=; b=K
	MCT2ug9x6xqAVrcx08aF1IIh6B7GvWulv9pl9u7iuaKmK+30bAQhZrl3LHw9TROp
	kXhSoU3wZ/9BCzsmXahXFQGIL1E1vTHw1F/6kwFHUIiH+Sb7iHmVynjcTUWZ197X
	zQNFa8Mo/j6A98gdGQopdPCdQEOXZCuQT+sjLH4Tms06h14lCvSt4U1UdovmtAIM
	/FrdE1t53AsFEKPff9kj8+RDrRQPLxDy4PMioF22iLn4Y2jD+NmaASUCnFXeRF26
	6DUKXVfFwyzjO6wiC42VQnwc8CVXJ12yRT//s1sZCdqYqXVRiHAEWv3NKsan/48j
	B5CtyB9xnohNVtCsp/A4g==
X-ME-Sender: <xms:CJQ7athQkzCenMQOONQrfMGEek9V2dRyKC0Q4E9COJV9HNQVM-6Scg>
    <xme:CJQ7aoAbD7k9_GVdPakLfAnwJLiS1XlmnXp-djZCabYb8FVxktLBKqwywoWz87JQ2
    SmSwR5vGA3B-2_SjDQRsWk3eMQiRNWFI2t9GRmMJwmSOFiijP2a>
X-ME-Received: <xmr:CJQ7aqurbOwi5G5gmUqzbfTVPL4-jE6qwJHkjrhh9If6vp_3JostcvovDmAvv4G0Z5Os0hzXFtU_pFLVtmgMEJNkWFYLyxCA5UoO9Y2z>
X-ME-Proxy-Cause: dmFkZTFBzRyZmediwmxpVIvDclFZs2oZ7aDDY+7mVx+Vm9LOdUHnrEfD2KyBBvLc8rc8BD
    qXO+6xeB2PYgRe4y4z2oBexFFD/ZKKeyer3LAQkZy8DAfNuY80W0hqcWjpAx8oYCPSCjHC
    Mn4kDldjyr2WyQuKoTvhLJdK3Si+8QDRVZ2oWxIJsvJAi9fQ21RlKdZfXgfn0EnmBA4Gtl
    63sIJRWoMp7+Gq4jl9W0VtrE8KG1Fvk8sv5nfoCx6WkR8+3v/yte0+Z9DRFBNCNqz2xgW1
    UObw2JbazdO1JTm7lit3VU06IExg130AzbZi8fPlHz17POxBiwO3W8B3qQjpTkvu0Hw+nw
    KnmJJj+nWasLhQJA6jgv2Rt7YhGzI9JiuWh8s+Nej39TjNeOMaMDPF7iYgK9iUgfAfBlgI
    ygBLukaiCGiImSzdTr6A1Aose+K2Kl4r6hn0LM4pXxGeJ6UJ6niYmlzehHNcuh/FeeSuEe
    NNXzXGZ3a2bLfVxWk51xe5PpBwsrjhx5i5ZbsuigfwjW2N17HEth+ngwghxO/XJoPyeZ61
    4F4QRpao2H6iWAYsWl8hJ4qVv9iEz95M7pOV3hpoNkA6pBPuaHQMZfCSMf3PXOCB7x7buM
    yyronGirFSSnr9mJwKFYPd4CxhqdaFOOu6It88YB3TKZ5g1h5ODW0usjww0A
X-ME-Proxy: <xmx:CJQ7atYC__9ruNjBD9EUvRNnyxhfQ11YgFGuUNCn2w8DiRR-Gt88xg>
    <xmx:CJQ7atX2Ljc15KkzfgXNFCK-6JFewHrMCn3_YvbHYqslKIpNrVBHew>
    <xmx:CJQ7ah5itpCpGnVjpPuky__JNsNZGOIWhF6upbhoEcNStqgvHbDS2w>
    <xmx:CJQ7aohtC80gKh4Q03hlPOgCN6Gcj5LjMc7-1rWiXPoPE4veAUyoWQ>
    <xmx:CJQ7an_cec7TYbuJlieo-bpyhBMbaD9PJr7E02MSZR7mzZvzftl2VG_9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 941f1593 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:06 +0200
Subject: [PATCH 03/11] reftable/basics: fix OOB read on binary search of
 empty range
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-3-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
X-Mailer: b4 0.15.2

`binsearch()` performs a binary search over a range of `sz` elements by
repeatedly calling the comparison function with indices into that range.
When the range is empty though, there is no valid index to call the
comparison function with. We still end up executing the comparison
function though with an index of 0, which of course will cause an
out-of-bounds read.

Return early when the range is empty.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                |  3 +++
 t/unit-tests/u-reftable-basics.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index e969927b61..f0442a46cf 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -152,6 +152,9 @@ size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
 	size_t lo = 0;
 	size_t hi = sz;
 
+	if (!sz)
+		return 0;
+
 	/* Invariants:
 	 *
 	 *  (hi == sz) || f(hi) == true
diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
index 73566ed0eb..c5d83b6714 100644
--- a/t/unit-tests/u-reftable-basics.c
+++ b/t/unit-tests/u-reftable-basics.c
@@ -60,6 +60,17 @@ void test_reftable_basics__binsearch(void)
 	}
 }
 
+static int unreachable_lesseq(size_t i UNUSED, void *args UNUSED)
+{
+	cl_fail("comparison function called for empty range");
+	return 0;
+}
+
+void test_reftable_basics__binsearch_empty(void)
+{
+	cl_assert_equal_i(binsearch(0, &unreachable_lesseq, NULL), 0);
+}
+
 void test_reftable_basics__names_length(void)
 {
 	const char *a[] = { "a", "b", NULL };

-- 
2.55.0.rc1.745.g43192e7977.dirty

