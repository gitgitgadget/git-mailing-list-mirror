Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF73F86F5
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723748; cv=none; b=mYkqbVzbw1LpcnJeHca42l7ic2xZjatBJRHZ3ZOYG9D4Vtv3ESq6nRPYUiRXy0w4ovXVu0Ak+0U1lh3Sl8TV+exuA9YMkBrBX8oC3Fra6uGTVDyjmcd+xoqMu8uHWrECQDsVvwBqrHtNe5H1pavx1z8LpbEzVCGz2nuPU95/f94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723748; c=relaxed/simple;
	bh=LHZpD+ExTYmjLQU3WUsZLdD4n2KCaOO2m2g4d1jqgzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbRmzHVv/Cxu1RiTW4JM4vQqqUisQnIXHqttlTuwvbFzjSDvcsNvSMo9Gr13wLIvkOqgw/QdkmBLBJPMuRJW6jigALf6jqm2yd1WyLD2nZkTb7RHhyL35Hju7l5WAcR05z015g7kHv6coSBHebR06qzv3J4g1VZ4i3JK+mJdQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XMxcE8bx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdBWS0bW; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XMxcE8bx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdBWS0bW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1828C1D00044;
	Mon, 29 Jun 2026 05:02:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 05:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723746;
	 x=1782810146; bh=muBgPtLaC2LNCu5JuabZjEIhvaysIS34glZZomoHyhg=; b=
	XMxcE8bxlDpo1wg0zP6H7IpjrPx+Sl1wcIyjpXA98QCPQzFRINj1FWLmzeXyIJC6
	AUKQxQCHt+7oIZ7XhG0RkACvWTera+/v1iSSDgUHPv7gl0HPncYJwvCZozdO3EbB
	1Kqm87HqZiDKI++qaYYGtyYp7jLSHqKhwLk28un9BUBLMWowaEavtOkc47HSCz7L
	kysXbmrZiC+b5Ql+x66Oe/mx6JrlPIOS4CwxdaeA31s8aMerEZwHqImHjk4m38Bm
	Cbwt4uTMPFs+aYTOrHX/rPGpv/VpVARD6sMsUgQzR7eoWGzKdSy2dUpVV58CLUGy
	6lo9DqAI+f590E9pMuj7Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723746; x=
	1782810146; bh=muBgPtLaC2LNCu5JuabZjEIhvaysIS34glZZomoHyhg=; b=V
	dBWS0bWCH0qWUCUbezAu+HWVfEqDoJoWU6898ZnT7zbNSUV9gwzse6P9ofT//Qru
	ufmxdaAxiZ/e3gbf3dCROm3EiXL5lM1+wScEml6u/EAWtiQThj83zdt0N0xNqCua
	5XcVJhQLcZOp0BYcxRqxWZHH7IhWXLssH2YeLgyW9Bc0bQO24YqqXSjYJGLhlUnP
	5gZKImnpXtqKRF3nO3sjEnnjnT0qKd6/w4YNrlutZKJZrK9C85W98CIeB6TbZDmU
	aFX8Ne5IuAExxmJF3QR0CHC3Ly9fkVrqn4BI387qHpnTgYGEGIl5s3PVr+Vs6wRw
	4WQJYRbyBp5xIkV59oXog==
X-ME-Sender: <xms:ojRCaqewZzIJsnbPi15BCttZkRpSf_SfBvc43Fx57E_lLIf90j1uXA>
    <xme:ojRCaro4ovzMojArPANUYUJ7HqOATsUGY_FVtwWI9NjZ7dLxvI0lorRYirZKmizBt
    ZaflwrvWp3eCKwDho5AfHK8bwplCn-s9fbP0WUpBpURjZ7fXzK16A>
X-ME-Received: <xmr:ojRCao5L_xvK2H6j7L87gGHMnSbwTUmLTsPyXDsZBzMrQ-FdS54FFKbKiZ6dVuKOxgYyA6OS0U07UK7Di_AyynXPpI2MC9PjGP8jEGGixvC0>
X-ME-Proxy-Cause: dmFkZTElDj9HXeyP+QZVJzPvGFiswssH/mJudho5NcBlnWjATd9HSZt+Bu8oY6BDRRDLP/
    WH6c6stVAn2dsc2zionMf3ysAVNWw+2O43iOdKjmKri6nIu6rfWTp9Mvdop0+gxWBHHPeE
    k9z4gumTToygiBkMDSNm/6nKA12GGbORfrzwHEvqrqCrDf4jeF8MLkmleJzpL247ej1arr
    pxTOjSNw+XBcjoiSHPKNSzAs5lVduA167vCExbUKfnDytQYlzp08G1jxQjXVgNVh15ZHUd
    7g3JQVtk+BzRji1PiYa8KmL8cU4uYs3CZlV772oi0RAxftG7t9yAhSKGeuLagMNvbJzzoJ
    bBlRoHwIWzcm/dwS+5Ss5yqRkClxcbmoJVp7ZwVFHrJrAtORB6+2SggnYbzDHBG4j8yhqx
    +L2Fe7jtj1bgQPqsy8Royg1fNWZ29Gcmk6zz1SlhlUOuC2he8A9nXU7WWjH6AMKMJwSBc0
    /mX0EFrEPd3QpxWyRBgMIz8osrNWJfA5rB6yOnaE1oQ1rIkVr7s+SmFRB/HrKt5hpclzQw
    dDMzrIhgfS1p2H4ALpb/Ubn9wNHoS+lIdfI1YpkD1++XzYkuN4iUsGvTu5cpAbD1pMj6Yf
    ASJpXpN2d4s7xP/h97/8BdwHfkVEaIMnJCuTwEa0mdnfrm7IMMr6aMLBGwUw
X-ME-Proxy: <xmx:ojRCahpDR_28athpGmEFnVLNDaRqSK8gtrcKw7M6MgkZeifLCDsCQg>
    <xmx:ojRCaqhp-q_AS5ARVh0rI-sLQXVzmS-rlu4q47Rj7RHOscC2Qsu_ww>
    <xmx:ojRCarJt_QmlW6_10mY-iVlmtWnQqKKizNxo-IrWVvswUgij_dcTmQ>
    <xmx:ojRCaqCqYNvrTES3eXNEmM9QCDyAOWm7GqJ8MiuBB0W8STrZS5TvAQ>
    <xmx:ojRCamlUtSDGsGsprMVxhY7PFte8kUBYv9u_dzJo8MMEfXoTfVs6bZYe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27866abf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:16 +0200
Subject: [PATCH v2 03/12] reftable/basics: fix OOB read on binary search of
 empty range
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-3-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

