Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2EA31618B
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338407; cv=none; b=o7rK4ULe81I57F6OXifmRQwP1BrPMI8mZQ8m5vrOjr6933317iQ18vCdn8LI3wD0IRriSszjqdAkRw21+D/xmnr99y28jDAih5KH4u+Abf3PiJsoOgMmBcn0xTJdZKSS02m+Hp7Tfl4Q5oKW6tnCfhCSu4OvRiYci9RMlF9jgic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338407; c=relaxed/simple;
	bh=lf6HseCjtohku+/jC0a2mmYAPGUwz1dsu22ocKpLTkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNKz1AxgTnmbAQfYjDXQ0D51cfVD5lO8yOeN6kRrX7HFKWbqVeW8sGH6SZ0XNrvwexIwn6bClxhpwnOKaGIDuK/fm2a5BabXZ8wQo6aiVamPuN5vkx7sBvjtd7pPDQ/GlDJeWjdvKCWAD/pPzjaW9K7LtT5aUqJbMRgnH68xe98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qwy5v5JP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJjp+3tM; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qwy5v5JP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJjp+3tM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE9707A01F7;
	Thu, 16 Apr 2026 07:20:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Apr 2026 07:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338405;
	 x=1776424805; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=
	qwy5v5JPhhBAD+g6r9EGZQzdqx1n7u67SQfil6hOEQ3BZZ7EWGoMr+5auRgoNdw3
	nWUZDQRYOde1QVM8p+sgQrr8iIESyhuBNTHWNpRpX0YEay1x34DzFn73vvqgVdY9
	Ot3xfz+8FfrZs2uc6HRPbhgHIe+aYAu+Fiw4YOQtblq0SJ92TPgyPFVyYDLPORL4
	i/wJAZWVJONqxgoFbU5G/dfavFSKLyaUgLSR9Wl9uvayAWYvEn+f84pWUEYOs7Y7
	t3TLiAFMtPWshvebXyqYAxmw/zCMUR7abQAeoA7lv15S6cD7QbNRNxcIBFXbFTtx
	nFiAeBUI3b0jcGP9JvnLYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338405; x=
	1776424805; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=Z
	Jjp+3tMnrMHHxq/1il0LXnlB3VZWMszUMhPeod6tTpFjS059jUWB9g7/MkmYCIn6
	QrMdzdPCOu4x5hKKpJKMAp74EEaHQQCBw/AUI9TBiBkzMr+oQLnS0tcPb1yOIBj3
	nT/HcXLLZEd8VfGNEiQJvWhHts7rA7RLq9aWnXgmSldGlMJbg3uytgUkazYor0Js
	xXijoJd/EX1IkVH0KQVtxGfdOEAeD8p9jLlx4Oc9OjrtCflKKwUPXwc4TO13VNUi
	Q/mTQfAV5eZ0+6bNHP4rfJcob9gGeomSIGQ/KkjVqWXh90O/eoW9nHDBiRlij7mx
	FOLYbNulDD3AFmWb79ZNw==
X-ME-Sender: <xms:5cXgaZLYjzbhGOjaHxXoOmLtKaoMslqFjc-pCy6deD1GDAQRMgmelg>
    <xme:5cXgaclZPGy0ShAJSh75zqmS85P4dy2kT-nrgjMn_t4iWVviuHXQbaDqBQavRaWln
    r99VSMDhTi-cIA8Cq1xg74t1rKRqaa1lh5w2B1icrLCEaQEI-F6xQ>
X-ME-Received: <xmr:5cXgafHYJpZsTQKovax_gQ7U-Ug6V2wwOonENkI7ODxdp7S8aOjSkEoADDi36mc0s7n1zFdyn7GcPCbzA4h9jen3OyGOxqPE0bZTuRVKcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5cXgaUFoabrDpBtPTQWZdn4rWPOV4H3lbwMyMtLqO3BgBZPnk-yxpw>
    <xmx:5cXgaUNF2fba2SzOHY9wsYh6UWYXFmJ-fuHihzEUMdw7yQB7yghaJw>
    <xmx:5cXgabEwEk0rOdIW2_GiAO9KpYNvrEUDxtbVoC1olkVl4i3lGq_n9A>
    <xmx:5cXgaTPLfPfsGSnXw_XBFmBz2YR5-1Vk6BlO_PxezaQzI-ZvkHQzyw>
    <xmx:5cXgabVSv7tn-kxT56pFHsmHOhub1j7ShfuhY5h5DLondlMASV9fX-71>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:20:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58a0e761 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:20:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:27 +0200
Subject: [PATCH v3 10/12] t6002: fix use of `expr` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-10-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
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

