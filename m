Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E959283CAF
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756890; cv=none; b=rLiSspLlos94XKbcQ86JyS7TlBnal7cAp43HrOpGA0IJTNw3Khycx6K3Bva7Uq9nYUYcx/CyJG7cFB/I2f2ClGuePJe+edjFCVQHgEMUF/+pw9sk2IdKb3+W+GWYAquhJZPHx2wIX0oUcNfRQi7/kXihOqqMhnIrvwiVt2w9FDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756890; c=relaxed/simple;
	bh=QC0nQdv9l5mCzrBpgseK976/AE07UBKFvH+mKp4y4yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ax3o85tm7KzLhOOO/JEwiakS5cyFgq9Z4XX8H/39fxyObrSoUnYFH+hIeVGJkf3Pl7CR9FNvjMcF3FjvIV7aeNqRCxttPa9j41r0Rnbwb9OZ2ZbGvKCf25K9v7FmUSgUOiTG8t/aj/egL+yfI8luwp4vJBhxMyZ6aQGIILtvnZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N3i264Ev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJfi2Gp8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N3i264Ev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJfi2Gp8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDEEA14000AF;
	Tue, 21 Apr 2026 03:34:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 03:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756884;
	 x=1776843284; bh=08DeSBWBf2W1ufQoZmq0RqL+tfN8MIgp0irvtaZE0Rc=; b=
	N3i264Ev1WblEUffXFy8EoTu/1xRqYarThx59qixYPDw/LrWFRWS9g/Cw0UHgpt6
	bWvZe96UTSp9g3W2VMBxS+YehoHE2zG4LhMxFDudSVLPjY+J3KWvJvStySTyw+RH
	2sSD9ipXVFVYQ67H03ALZigIfyLJH1cHIIPH9MJ38kU7zzT0WDpE1i7MSAYBpxLe
	b6bMtkK+Ibg3Bz5T7Gqd4B+aCuJwnXsqL6A9Mezm3PA8JL7fb2jV9UajgoxtFD21
	hFiJ9tRJpHGBWQ+dl2IqVPrEY+qbKL8nhVAB2rVSwOZAJfx7W+lyyay8W9Mj6TLQ
	WG4Dmc9yMMnGI+Xmk98+GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756884; x=
	1776843284; bh=08DeSBWBf2W1ufQoZmq0RqL+tfN8MIgp0irvtaZE0Rc=; b=s
	Jfi2Gp8z4KUS6wN6+LHRerVIgJ+ysax5ZuYw2OMklJad3k51lDpNj5LFk6FlMQfR
	OWNy7JY+2EfWmaDBx8V0+B4BDbhcQ15Zf/HPU8BdMZ/Ai54VPF+3PgIKafKhmCVy
	k2ZNKQ1zumfqzlGghlQ3WLLEOd6Tg+RqXNH8Ryo2ZXQ/XUXgBcgkd/cR4nO5tuEQ
	15WFtDkKOUQXVD6ZtYLeOigwQWk1nQtIDLWdl9TseqGyYIJCS81bvtH93KMlxpSg
	0gf4m1cPypePEALZKsqluV9vnfUR+PhxuNJ12qBqr9FKf9GF6vbH1UEPy522sWgT
	h2UGJE870QZrNYc5J71mg==
X-ME-Sender: <xms:lCjnaeJslqCRBZPRCIFP_v_f8kaNsAUneWAYzHaC9BYbqCRLgUHmPA>
    <xme:lCjnadIoZkXgo2fQYSnfZvjmbriALyIED67gwE-00hmLRpSzei7d4ZzUF-StYQwZl
    rsx4JBCaA-EV4kbDbUs0XTMYYuLjXOHFDHdfa2-8JK_H1LuAOQ8yLc>
X-ME-Received: <xmr:lCjnaTsbroBOcwJtSSOj7MGArLC2Du0ivx3QVLm_oyC3riBE2OlecdZIIeeJK4U7YWJ5hlrCAW41oVvoBJrc4R4NzP-2KZiwtSq0tsaQUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:lCjnaSSoHFToibWgVQU2lrnU-JOfjsS9XS4UFOVBESj_fs0mQYTKuQ>
    <xmx:lCjnaRMltXUwc6Ge-iG2S6LhDi4UvaU3VtWCBNkK0hfSv28qyAlK1g>
    <xmx:lCjnafYoitPgdTQDxQTmyxk1yM3MuZcVlj17sD0jRxVfVQr9Rx7QJQ>
    <xmx:lCjnaTyIU9HyQUuGc24U60CjICvAXqowlkNhkmdTxxBruCy126nKbA>
    <xmx:lCjnaZq-BYjnksr6tnEB0xKGJ0f6cigMiQjx0mGHkJ1QfwRKa9FgV1to>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8b344c44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:23 +0200
Subject: [PATCH v6 10/12] t6002: fix use of `expr` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-10-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

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
2.54.0.545.g6539524ca2.dirty

