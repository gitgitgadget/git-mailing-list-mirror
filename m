Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAC481FB9
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993671; cv=none; b=Ec8WDIEgSpFvgxAtVFxqVg+FgDzltTX2Zjq3pdltSeK2wfPwKdkrp8LWgSfwIKb8to3ujDarx90+p4G+t6MjzX5T4LJnciIHVBdTenCl1PtP/XbLT3NHzD0sN+Hq7wpRTxzw3I/SyXiWUh/Grq09YzetdWqBSRhFBFvyIKMiX6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993671; c=relaxed/simple;
	bh=JCxB/myrPoFZzDHrD7+gVahtD+oXIkh977qzgJuRdX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUJwqYoCQFt1qF5Zlv9FGEj2K0CYxphJHXGwr4qGsNEFUky3fQJNA3UIjiRHMBuZAKYTvCqQ5IOYQuNBojIt2gcoXHGJlH/ipL9qwr3urDVpANTd9d1v/iE3Uv1zt+FLKNaKEld0JOb4Qh3r4w2kNmbHXmNdp8JRwr0b9NKL3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ArfEvt66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UePDEACx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ArfEvt66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UePDEACx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8EA711D0009D;
	Thu,  2 Jul 2026 08:01:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jul 2026 08:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993669;
	 x=1783080069; bh=Ozp/KmdrhgccsNQlaEtWMGGh0FKTeP27agwxTeHLYuI=; b=
	ArfEvt66/qNcjA67BkmyHPlawrDq9eUHnxPDO/VeX/nvqDYcfs/CMpaxNVlUsuC6
	liS4x+jxR2ldCm1axjzkIMogunWZ/wckQzKhhf6RueDnDyRRU2dJIRguhn4X/wvB
	L63VCNB6CZjElZQBszKWWOgNndITMm8Blr/WocILqV/kpX2kVhLMWpBmtnV1u9Rf
	GSECeZxER5wy/CnyidbP198/ANii3nMWk46p6g0r9YkpPn9hR2zxNTK5+WESKfJ/
	k3r2+aYEJ/N4tf/owv0Nr5B78KCGWMb+4y6UVN6PFtCOQ4FXZCHaVXdM/SmtsgE9
	Wq+rcaWG4K/DRzrUXYkd5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993669; x=
	1783080069; bh=Ozp/KmdrhgccsNQlaEtWMGGh0FKTeP27agwxTeHLYuI=; b=U
	ePDEACxe9MDTi6V8nqhb5+zTJlbM4aojti4J7X/b182JTms3JGKZ6fdoD8EdI8JP
	sPhhgphrosszzn90l3V3AFn3jE01PxuLEC0OyNUyt9pjsvvcwc11zd4lyZtBorYR
	Hk77nAkpoZAiHLLxdpmw5/1/9slbCv49PcXCasrktPrQsdwMVmBVxIuDix+P4jem
	ELaVNh1OnlMAapMz6HXqeyuR7uhKQ3DO7+ul5U26V5rYsPqOULlX2GTWPknWsPnX
	beQOIuff8dDNSZm6epnosdHHcd+mxEmP0oKu4/rJ9+jJSOVO8JiJiDUr0Ca6/OVu
	rHWhvo9+OffjFFygI6aOA==
X-ME-Sender: <xms:BVNGahajKDddvm_ochP3eObQ3IR7YefO59JiFhabqd5CW4QV5YOynQ>
    <xme:BVNGav0r7RzH_HDnkSa_y-zqbu-gfOYgeTm38DuVnmATEsDjj10S4pCGtMLOa4Xp_
    ibmBDW_tsQznAi-17Dm_Jvzvec1GiUniJh_QGEV_VQ-1Mx0qqVpkA>
X-ME-Received: <xmr:BVNGahURO45ixV1ljwdzZqQQYzynYu3vB9V6V2Ixox1ub6supeLDHg8LwDms4ZaZc21a2gHJ4jByMf2u3EKju5x-mYcK27G-WPUAFdN0wyLwUw>
X-ME-Proxy-Cause: dmFkZTFsfeg47pLyJVh+MJCy0rSB+TH7HazKVe5gTjlZ9gCth6IsyEccbKvNWA45L+68n/
    BUJYDW0wyVqb8e98CcrnUplq3uYAkp4yLoeEN3QOYezDy8qHZJS5llCwxliJJYLjD8+2rU
    vGYXMACIgORGpxAXAfUrAPKXIN1YCFo3usZV65lQWeyqHFnaBiWXrMSLwnxObjbi944TTs
    Pe4Tl5/p6CYBVCvKaNN9pukZ3slG1X/28Pf51xd7ZjsHrY2FAweIVhugOSfKNLWxBmbw4b
    nGYOTbsG2d8KfEyYwiAYI8ncVC26Q7gZcl6HxLw4UR9RDpo7XDCIhWKkA/feygZ5aDQUWq
    SUG8w/SvHBzusuRq+lYkFUO7HzI6exPOMqtud71fNjQb+3du0WB/GhGYkXRPgbUe3UkoUi
    15V/5eStiNSZNJJclb2hLr+ib7keF2bal9FPuWuMXEl1x+YrfLbwEkBWZ1YjRbmuA747Nu
    5cRlQfptHjiMWwwNc1qL2V8cT8GT/Dt04Cnt6CiZOCX5milB/OovzpKWJTx0FYskowovBm
    laj4YFydvylJ9keon+bnuhUi8sSizTv0a9A8xDj47Yb11+S9Yh07RAopUPOFVaAnwBO1uu
    iGqD7I2Obe5qOnvq4Y67q28tKvtLYFUYoQTNdubsZtkq3eyszyVr6QFSSH8A
X-ME-Proxy: <xmx:BVNGapWnpX7u6a8HsBHRWwT18NdnUB2a1r803yFIXkYO0hj_z7o3hQ>
    <xmx:BVNGage01d7fBKsgKk5zWvd3XrV8GL0Kz8Qp87GjpRilpWh1dPnuVg>
    <xmx:BVNGaiVywfO3xuMy_cGs2XUMdb-cIU21ePK1PX3m0v8V-EndiedF-w>
    <xmx:BVNGapfh2VOUNVJCmtE2sVmX-S1KkDpqDuMgkMdgLCIdYp1y2WdIdA>
    <xmx:BVNGamavvd3bZ5gFY6NvSm7ag-oKBZYCoEybjoqkdL2xvjV4FGkYpWRN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4097d312 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:00:55 +0200
Subject: [PATCH 2/9] t0021: skip EXPENSIVE test that is broken without
 SIZE_T_IS_32BIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-2-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

One of the tests in t0021 writes a 2GB file and then roundtrips it
through the clean/sumdge filters. This test is broken on 32 bit
platforms because they typically don't handle files larger then
`SSIZE_MAX` well at all.

While our CI has a "linux32" job that should in theory hit this issue,
we never noticed it because we didn't use to run EXPENSIVE tests until
7a094d68a2 (ci: run expensive tests on push builds to integration
branches, 2026-05-08). And after that commit, the test does not fail but
instead hangs completely.

Ideally, we'd of course properly detect this situation and then test for
it. In practice, this turns out to be hard as the test failure are not
reliable as they often (but not always) run into ENOMEM errors.

Instead, skip the test altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0021-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 033b00a364..7b9a0ca877 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -296,7 +296,7 @@ test_expect_success 'filter that does not read is fine' '
 	test_cmp expect actual
 '
 
-test_expect_success EXPENSIVE 'filter large file' '
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'filter large file' '
 	test_config filter.largefile.smudge cat &&
 	test_config filter.largefile.clean cat &&
 	test_seq -f "%1048576d" 1 2048 >2GB &&

-- 
2.55.0.795.g602f6c329a.dirty

