Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2D385508
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670078; cv=none; b=o08BGk/0zQgo65JCHvFAzIPT5KpF0ZmjnOUXgI5YKVZ4AJ5mcDgUdzAvkR8Wm/iuPXnatjzw/1dbZY6Q8v1KTyqdax9oRYCKZ4JXj/M7HjU2ghJxeA6vvOR7FTgz97hiB5bk6NEMj1MQ2HPSSEz6ikeKo6DJDuTQHwmh5hlnpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670078; c=relaxed/simple;
	bh=lf6HseCjtohku+/jC0a2mmYAPGUwz1dsu22ocKpLTkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lo52yVyZ3Z04mtnGIiK7+tyqzV/uNLHUA3oiQjvVIKRkGumHfu5/2fciXI8xPifArneqtGxyaQ6VC48NKz5zlrQbZvDU7sOVgb4vqZlrI+n0XeRAsXPakCsRk15znqGdBywNLd5rN5yxKn8QCG8a8YHEU3zJwQYdavTiotIE/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DWWUkaWx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKKySY4z; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DWWUkaWx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKKySY4z"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9BCA140009D;
	Mon, 20 Apr 2026 03:27:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 03:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670076;
	 x=1776756476; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=
	DWWUkaWxUweZCN3/+JSYwnH4eSOe5YQ/oV4BcGF5Nq71qdozb7oEXG3PBXnGzu8K
	BkJyhOnmDnvTWWgQ2gDcMUE+eyudbjfwTTCJr/Ou5EWA4aAqvJUkerEKMHt9Zl+q
	emrccaDtAbI23fuUlPmOYuqxJacYT+rEKb5y4eGTDUuKsTtifsym0PDrwzXgfp3v
	vw2Bb/ia3bThE9FcONJDGnB8IU5UUSHpOS2m/E6LIe8A/s6ZZzcHiok7RInoIcz9
	daPE42qC3CP5/QokYrLW7D6lj6JefYVS9MOSS6onmJbvln/71h2RKKDY8VVuAZf0
	Ee/tFzuiK555ccOK4M76vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670076; x=
	1776756476; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=o
	KKySY4zrm9Avwx2w+ubnB5ys8uMeg2pfPRvaiF3VKs5rCv+vEmETgSKR1CZMt8Ta
	HHEpm0kd3zDRfioL9r4dKf8JPjacr+dJPE9DnvHnWDtl/Icd6Ic3RX0UBt6w5YT5
	829OdmHdD9k63FJJJYfgMcpoU3VMRL5QMpO3omx96fVjSPuNZAUFuUHXAKZPuKRh
	5EqVrw1jbE27zU4KbL/vakhcyb2RnnYZhG7xwLlCDSf6OfjWAQAjBXhqnaUabJ1N
	ceXvBxpiMEmPqMApo37iet+tjllMI9lETRHvfYBKB1tsI4iabm3t1pa65R4k1cjV
	LgLGM7N65d0q0LFjO6aAQ==
X-ME-Sender: <xms:fNXlaa-UqzL48c6yTrlm4b3LHVEvV93vVyHYK_KAAOQjdsufeQCDDw>
    <xme:fNXlaRtJJvF4mncCKKnL8kVh6pL9M7yplJpQrZIIBcKNwtVSe8e8QjwcVMOOZSAyK
    F7PU8NhEm4_F_YWKmW7uwORP7HiOz06FEh2koPfsyeHGZhxQGm3lyU>
X-ME-Received: <xmr:fNXlaVBwyU_IVfQaiFsXVr-SIvLGGRKboAOQsafQrBW2fqoTObcCNhh6pqCpFQNavLImCBJJQN4Z3l2emAQGcCyZIaGadggpu8vBvf5nno2D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:fNXlaRXAjLYhgDBIP_6k9PAsHI5ENijQpQac2lZp-rO7F3Uhm-yDuQ>
    <xmx:fNXlabDcHSWV8KsBIGdaDBE85B_ptTzAFO5K2QKqdKwwBr7DJLDScw>
    <xmx:fNXlac9k0wIPp9hIY5mF2nb03yaVVTnxuP68tTauMOfilaz7AqFv4w>
    <xmx:fNXlaaH5UhkTFHYnrNS3sL2LS3fabhfk-DFBlZTvzRyJu-wMaRG0fQ>
    <xmx:fNXlaY9VcjMOWGiPjE0V8BKeQHWOzct-v9ezA94Y_swLusHC69n71ZK2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:27:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82908bfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:27:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:29 +0200
Subject: [PATCH v5 10/12] t6002: fix use of `expr` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-10-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

