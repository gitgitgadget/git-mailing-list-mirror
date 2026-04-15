Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64F38F92B
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258429; cv=none; b=ms20G9Yn/3yTHdgr1yj1yE3fVmwssbCgqJZvmovSNKZn/id83luBi9Ks6xxH/qKVJRXBSAPJrTDctml5HTEJcpzyGlDUQ6PGiaXjyCu0zjuKoqcEfRvEnXO+m4zEYqz32ZXGr0ED5hyn+BVQm7Fs+bQHk5dFyKPIe9EmRB/QkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258429; c=relaxed/simple;
	bh=lf6HseCjtohku+/jC0a2mmYAPGUwz1dsu22ocKpLTkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drA0wisYbNllVfWNZ0lFiHYN17RABiMTnVF9u4WCUzQ5O9hywhw25FUnvIvJQRiTdYt1sLCvcQfGuEPr0pZcgF06m1QfUGW9QrjwfL/O2wHH8QJqeLrNI8MqV2GPHlxvBc+6jMZiJt8Tyl3MhpVC8K5Yiy1E3HfRv3Ns9j/b0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=auAuXWrh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N/ky7OYN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="auAuXWrh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/ky7OYN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C042BEC033E;
	Wed, 15 Apr 2026 09:07:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 15 Apr 2026 09:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258424;
	 x=1776344824; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=
	auAuXWrhXO1Q/cdf78Ca88+V6hz5+n26Gzl6tlnakQDM3imnTW4HTMjVB5or0teF
	hN7sLXVfWQjTZ+q4nE0NKUiVscLp3xOD2J3RcjH98ZGoaAIWzOCvuhmCvzMj8JDp
	lLECgAW7iiJO+omPxg0/yeaJTMKC+Q+ubqbPqgGD9aG7H696FmkNmlkrq943+hXU
	TlLYWsclp6n4rykmtp7ONFhvxBfDX3TnvWbB+11Wd2/oI3ZtWia+mf+m27dJX2rt
	TrDEKjuV1VlPMRFSWPGgaGowE1sOrk9q0UXlLKc5/90ktbXi1zvXKszGYtYiK5aM
	FqjUIp7dnWOskKg3ef+Gvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258424; x=
	1776344824; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=N
	/ky7OYNYKS+ar+Pl7v2fn5AOnWdmJLrHJJ0BFq6kdH5Sighr6R44z6cP03riEuKh
	OOXhhMW/Fs8SZp189KYZGTnqEFJGGxc5lg6LuPgCM+fUNFfoNdZSXTA7wXXfNdiY
	NEDYvqDXK/ut3K7HimSuxHz5+Hy4fI+rjxscj5i+eYw1YLIrz39vxQ12YiJ9yaki
	ckdCh3TtvxJT2nNG3Ultp5v9c31phjeTAgpD7nNWeDoNkT2esi342YRvN+W/nprX
	MoigW1MIeTShL59g7jwnu2DpoMc48L9b2lBbnfjyYciur9a74jPo7N+vGLdlWD4+
	TYrpuMSLWDm9G88EfSqkw==
X-ME-Sender: <xms:eI3faSya48kJhzXkyzz89zg-2m2c1vsQqbelKtuxFmq_1OWmZFGn5g>
    <xme:eI3faVskzmyv1M2RvW1DyX19Gw3cKXOZC1ftspC15Ub4Pdf6nNaqBigwLtcZAv6mm
    2HNljhtzzsonZ7FiOcOZkQzBVzdwPv1wxtvlcrBvWiu7SAWN3eslQ>
X-ME-Received: <xmr:eI3faRtF0Sqe_oZ38vyZHqX9pUGawtOD_qCRyCXSit6sjOO54lt51SpNFl6vuKSgmAgr5IGoFxpuBe7Ook4Ww9b27wh_KX6tqHKP884INtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:eI3faSMy30aNpl61tBxAaFUDvmbzYv-kRMPkVDaX3jxAht5bMTTm_A>
    <xmx:eI3faX1GubDTUL_tJ8vqr4fdkaSEhINy6M6L1c_N5Gi5RDTfSLVbDg>
    <xmx:eI3faWPSBCBYGISoqNSGIHM5aatPYuZk-1YbQYeCxJhb4I2BsKqeQQ>
    <xmx:eI3faf2PKTJ-VG6oSRE6OSE1zAf3JIsM-X8XXU3QS8bQn-PFxh3jAQ>
    <xmx:eI3faYfunFfCPQ6thrOeYJBg8CMSmyajyVDqjv-3dtqj22b9Ij1Bo6Ag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:07:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ab36975 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:07:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:43 +0200
Subject: [PATCH v2 10/12] t6002: fix use of `expr` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-10-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

In `test_bisection_diff ()` we use `expr` to perform some math. This
command has some gotchas though in that it will only return success when
the result is neither null nor zero. In some of our cases though it
actually _is_ zero, and that will cause the expressions to fail once we
enable `set -e`.

Prepare for this change by instead using `$(( ))`, which doesn't have
the same issue. While at it, modernize the function a tiny bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6002-rev-list-bisect.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index daa009c9a1..f2de40b5ed 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -27,13 +27,16 @@ test_bisection_diff()
 	# Test if bisection size is close to half of list size within
 	# tolerance.
 	#
-	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
-	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
-	_bisect_err=$(expr $_bisect_err / 2) ; # floor
-
-	test_expect_success \
-	"bisection diff $_bisect_option $_head $* <= $_max_diff" \
-	'test $_bisect_err -le $_max_diff'
+	_bisect_err=$(($_list_size - $_bisection_size * 2))
+	if test "$_bisect_err" -lt 0
+	then
+		_bisect_err=$((0 - $_bisect_err))
+	fi
+	_bisect_err=$(($_bisect_err / 2)) ; # floor
+
+	test_expect_success "bisection diff $_bisect_option $_head $* <= $_max_diff" '
+		test $_bisect_err -le $_max_diff
+	'
 }
 
 date >path0

-- 
2.54.0.rc2.529.gd9106f7525.dirty

