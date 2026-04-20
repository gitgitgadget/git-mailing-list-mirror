Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A311C84A2
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670073; cv=none; b=f9oOOs52UXikGCVcYWNTy2QtaS0wRrGv8Ixj8VknlOJRMAHWK1xW4y0pNa41Nkc4WwLRTcxjou922qp0mtxLWQPVkOB60ZivaSSNgPwtJVspn1d3Te3oYjmNyn9qVI9uvgiIN5qOBSitNpLYySWy7dWFrJZlIgOYh+YvwHJVIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670073; c=relaxed/simple;
	bh=Sqxral/SVat7YZbY/zlwJPMjwZaC+tbEEgeKF5W+yDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCIoNJxMq7dNaXRmZoU39DxvjnQQOuiR5dDx+VGS/X3pLV6yYfKHmmQ/20ZE9k4691XiWbIew164ODmUVEz8rvhiAdZgVviH0PRjatXMC6K6A18XOBMawZp2Eac8f209/ybWD/nu0Wf0BKh/YxEEVVksR3vTsb2ElcyYcfzmNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W60fimZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GfOHV2AY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W60fimZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GfOHV2AY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 76661EC00C0;
	Mon, 20 Apr 2026 03:27:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 03:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670071;
	 x=1776756471; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=
	W60fimZg7Z5wDokK1rArM6ARcOmveLR/tPqImfX94/0fOSjaWbySKgsTUrhwhgUq
	51xcTRnt8Qo6CDVZctFgSggvxgVtj2VePIH5dEvEWVeUddaNRjv5t8p2hrhHYFLj
	0yjKRVwQKe0257D8txzg8xF6SRzbxPIcpYlWfBAA4/dRiEpiMz0EIHjJD3T55se5
	NC0J1gq6R0s9lTllUUgARNKouoY4+bZ0XlrHwoSw4hnpz5xr7wf+X0cExR15+yLt
	apzikdimsO5mANYHLL4mClDSpMw1J4mvnhJE6fK9yUbGl+QGIvYMQBZ2y6JQBIv1
	Xz7w8cyRgH3jMahl72BCwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670071; x=
	1776756471; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=G
	fOHV2AYd9XYaApcb4DCm4gKr7WKMSbtit2eh9I7J+1mLPEMEFRS8nquqnfz18AFM
	z8tOJSXEysmYFF5qfQMj8ttMoPHPsAs0by1P9BaDs2/YfuIoyshgX88iJ8RtCPoW
	Z0hsqKl7tZSfPeXV4vbYJQDIohhX3/nmuYLj8HF7H/SXc6LrHIdMwRW7NyO+ibRR
	URGE6Ma/qA5mVSWLy9zsE0Uwxee423T9lglZ2uVGLIPxGH03SwqwCGXPYo9Y5tWB
	hVpg7SewpIP+6bO4em9ZVkLwcgySElyBV/15KW/7VlWxEJltfYWxhUGM5AVhCNhD
	EJ6wu1kQsCYK/uy/Iwt9A==
X-ME-Sender: <xms:d9XlacsN8PuGb78SPHuYqyNnDlre1UySekb8URotefK7AtyP_gDuiQ>
    <xme:d9XlaQcC7RUKBJcpyxpK8ro3YdBZZxA4f4t6UIvPTscfh1-5rNmA8tyrYCQq-b2sM
    GATH02-2hbnwTNE8KmjDV-h9XfZ1YuFJS_TrFNLsm-a-xChJ0rvmw>
X-ME-Received: <xmr:d9Xlacw0GqRKpIvWfALSdeGUIEYh9zrFOmImHe45TeQCzY7ig-mo6ysXbMNSrpqWCFDBy4ab2wtGvTCRPJq7euEzuqSwFsxkPtW0Z8ix6T0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:d9XlaeHQx9eTcoWSD5B4OQAuoj6p1xg4frXkDmJ2GgKsutXRvCiymQ>
    <xmx:d9XlaYxLa8BDIjOd2o5yZEWfbgL-3wX4vuiI3BV25oJDBq10J4TwXw>
    <xmx:d9XlaXtANa-X9fAHPfTgWwthLux9bxNDYk3qL_1S2KqUoruPhH1VYA>
    <xmx:d9Xlad0J6hReb5D9r71P6-py4ii6savf2b5bR_b9O8HDbgXecfo7xw>
    <xmx:d9XlaYsAtBzaNlZQpFFUtyZSrqleP0pGeJgAOVuyRRRT0Cila76IgXB3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ea6e91b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:27 +0200
Subject: [PATCH v5 08/12] t0008: silence error in subshell when using `grep
 -v`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-8-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

In t0008 we use `grep -v` in a subshell, but expect that this command
will sometimes not match anything. This would cause grep(1) to return an
error code, but given that we don't run with `set -e` we swallow this
error.

We're about to enable `set -e`. Prepare for this by ignoring any errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0008-ignores.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index e716b5cdfa..d77a179bdd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -122,8 +122,8 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
-	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || :)
+	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&

-- 
2.54.0.rc2.529.gd9106f7525.dirty

