Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DE309EE9
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062786; cv=none; b=gPyvL4FIR2N/UlZdJ0/WwrNAtuKbvbxe0NlKPzv60UFpAZbb6fmfzC0cPsdo4/rDE9Z2IaJgEdpgXjJADGi5rvM+87duXnpKFN3R/HoxHdJ9lgbXeTUZ32Rwt3VaxrH89mRpVa1M2xotP3cXnYpVX+xe4hmyYPC/Mb61zNPaAhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062786; c=relaxed/simple;
	bh=DEcyseSweOqbBYot9kqw3m777DGhlJYzGArhAgBxt+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJOF0Qvxwo2tSNZyUPDqe9lRFINo+NKKa2r2gxG+KQj/K6eCroV3ay4SwkH5sbozLYMoDxbSCbn1hrkm44skh6rtLoQr04MvUSTUE7MvlNb27WN+cx5p1z1i4VvJr4gaZ9rEIb47kTERt4FdHFjCnh8mAv+O6KA9gauZgHScS8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JRvFHpXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c7gKFect; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JRvFHpXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c7gKFect"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 187831D000B3
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 18 Aug 2026 10:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787062783;
	 x=1787149183; bh=EyNX2XfSveBUaX1t9x9+/XUdy0ArBqEXcGWQMZRDrzs=; b=
	JRvFHpXTcyUZxgSvOV4mXWUsU/mH+kEMphYl4H2hy3TbhPSJx7E3kz1xNiCwRDUF
	Ob/hwRusAxOPCnrRZWlG2QDK9+jVzMxEFbYOIb2Eq6n+bBcJUfFuslYGWyaDfgj4
	SbCQ7ZuWsXfVyYgelg/oTpVvP6qR5ZQp2BgiNiy6ZOdapS6VraEPTE+6IQdk72Nw
	7BNy+lV9W5Xowy6pvyj8Lc3MswuzkipIfw1LYqHRMZ6oTiZCNex84rgPYebZycfb
	mXbcbkdRoa8io47e0gsUy4E8weH/vIezXFRb926IpUOkvWIN2DxnKYERLNuoA3Jk
	Q0spaPZq1Ozkca+CZBmtCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787062783; x=
	1787149183; bh=EyNX2XfSveBUaX1t9x9+/XUdy0ArBqEXcGWQMZRDrzs=; b=c
	7gKFectIUUIteUJzu2I9uvuh7x28eD8cEtkD9nLicL/o9nxJsQNJj14AzzPaJ7Pe
	LEOe0HQ+R9yYV3QUTMzPGeq/vKUIEIsxKrYkz3SGGhCxwyHU6e9o/3Ctg91Km80J
	bkB7wAkH69jiL1ZKE+GS4YvEDiekPP0VpHzbs+PSSDKyCR/bgjF2iwmpqxzM+h0j
	ZYjdfNqHyU5eBJvFVCRO35/oDsK3A8xZbDr5k5sdWbeM0hhBAB6dLwUJKl9GnqaJ
	K31RkdodljxI5Y8d5t6/0nlse9CtkkFoT1EOSXoQgbidiuHX4vGuJZIps8+YM13s
	S+Cbv30gpYRqfdTuji7pQ==
X-ME-Sender: <xms:_2mEao71-955LL09AUOjSB_uxATFEoBXHIgVGqOsl0vGTEDQRFYC7w>
    <xme:_2mEag02bXlDOFxwUlCmFOHueLWuQYti8ORiVTKWPpFAICbqYArCcMSJ_4GFaZ2jx
    -dtkTQrhHttAHPnKP2UyJBJeDjH9G_edzskWYjGfS60L4SZ_DXg4x4>
X-ME-Received: <xmr:_2mEatEcLmgj_z-7SO3WWFdiOMmP9kUXo1vJdRPRE9r1Uvpovgi85GGMejcs-5PFptKUl8OyLoj-CyIE4bVeHo0G8AOlI1ztJAh10hPn>
X-ME-Proxy-Cause: dmFkZTGSoJp7k8c0Cn+kkyI49yzacQKpkTxj0CYv6iZVkinoAl4hjDbQ4pKe6QO32cZZlg
    ZLC+erVc3/aZNPlbelo8VxvwzwtJpCGw4RaR3KFLJjFqS+H7kSlUbiIalE8uVq39xM3xrM
    oKlGhH8IJ3jjPdPWvZdyFwBJw/cKncFPYozfcBgmgSfBW0u5XNxAbImSnkleaD5p4tFswo
    6llvEoBRy3ZLp0GlgZZLZ4fT2LGU/0JMQg7zLs7NiEN2BBeKMLYn4hbrvtc1XsLqyhlY5H
    K2HBNYR7bnjg/4cqcVDJUoTt/V9RqevBQ+8RfA/4AiOJQZqXXhcBPl6edIVnuVDkrBj9k5
    zZKUb1G/sGr4PyhpR8p0WX/3RVo80gw65PPlo8ggF/bs66g9+MpcZm/6xTMOT8mLs1cCta
    Za/StuwWLVE+N1uwrhy44hPlZ8sJM9ot4vclNnM1czMWSBNLoYl9yfvZuq5pxiMG7UZmUj
    FohklQJmWZD+5KLLvFnR3GyU8ojMlTBDaoxe1w06LjXpWTUK7gqS4o3Jyy1/o5xAzr9hT+
    8jzx3tABmQcDc5tDF8KrS7Vk8yPNSEQCL88Rw86xvzS8WQRWHNTi7ewoKQALRpb2lcrO5C
    M0so8lgKQetT19ErHiK+yerwC6WYnS7PkE0U3cNbFLdOMHasXB/6vbvT721Q
X-ME-Proxy: <xmx:_2mEaiSMpwCYOLOfny8srPLI9vxuxdbGAWTZNg2aUAx_WqlsPo1P3A>
    <xmx:_2mEasD4k9m320GX5OZkU-9l4KiUBSUWJi-H0FtgfpuLq9_YBjMJ3g>
    <xmx:_2mEaq1WKCgsd_eMNd89nykPW04ApZSSsQXfgS_b7ds7sBU4yipYMA>
    <xmx:_2mEaiVfh1N4Nwec5IvXrPX9QW-HaZELOtYFiMnD1gEKxpna0E-oIQ>
    <xmx:_2mEapYs59viOXUgYil7NBmfc3I0jJxLOqu582Ii257UsXXW5PGIk5DA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab873861 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Aug 2026 16:19:29 +0200
Subject: [PATCH 2/7] odb/source-inmemory: signal missing objects via
 positive return
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-2-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The in-memory source returns a negative value from its
`read_object_info()` callback when the object in question does not
exist. Adapt the callback to return a positive value for missing objects
according to the new calling convention.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c         | 2 +-
 t/unit-tests/u-odb-inmemory.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 3e71611b8e..57183daf4d 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -66,7 +66,7 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
 
 	object = find_cached_object(inmemory, oid);
 	if (!object)
-		return -1;
+		return 1;
 
 	populate_object_info(inmemory, oi, object);
 	return 0;
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index ddf2db5c81..93b3f38dab 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -72,7 +72,7 @@ void test_odb_inmemory__read_missing_object(void)
 	const char *end;
 
 	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
-	cl_must_fail(odb_source_read_object_info(&source->base, &oid, NULL, 0));
+	cl_assert(odb_source_read_object_info(&source->base, &oid, NULL, 0) > 0);
 
 	odb_source_free(&source->base);
 }

-- 
2.55.0.822.g20453c30eb.dirty

