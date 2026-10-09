Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2A4908CC
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545545; cv=none; b=XYAB5iXXnM7ej4qeMx1oOtaJ3SkR63T3gebrxN5+k/MRGy7xEuJQJdq22q34geYRDyH8nAljwhW6KE3wlI6geP5InsgR770eBFGH3gTEAjrtYNmFq+4qK53QFC7P4raPeqAXY0DDbxzxfD4wL+/PZ1uppTYsevuiDy4su5NVO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545545; c=relaxed/simple;
	bh=NVUG3o1Ublz4xsD/iNNNc+xumEGhq/a49N4nN7N+SMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fov+QBcpenDDjjNf0qv3ZW+NKWV/DxbE766GPJGIp26hfJLrw0wYd8SkQFCqAkCkBBfF7Y4mRJUJgjQeXkFw78Q3Abqoo+5igRpff/FM3C7G2NX7PhjLnPVuBskDgbAEwRWQ50x9gMX9E6KY8Zzx+qHs70Vs+VaAICph/QXxgz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C74oj4Kf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAmO1ZUe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C74oj4Kf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAmO1ZUe"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 63BE8140007C
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Oct 2026 07:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545535;
	 x=1791631935; bh=3MySeprUatuj61dQPoC21w0cjQD6IxUNBsOqgHMSr8M=; b=
	C74oj4KflUziLQAFmzHzqyho62n0VaMTu4SbPUnpGh4vX0dqqPkdrjdkHEVVFOLw
	IZtD7jWZ2GHyx0KJyJNHjQ2Simoeen8uSY0Gqoxl2jHXfyd89ist6rbk6FmyEVgy
	Yk5nG+Xk4UO4/IhnLdwTtYs7Xvp9dkRmql2f5z9/hBJ84UmB0ZBoufPHCAYDRij/
	cKZ210hTvZNO2/JfGjHYLKC7q4XaJvCaWVde4g+/8RI4sByInBMLB/X4jPF7JhDN
	m5nnUQTcuZ6n47tBN3xBMRHvnLWCuyk4GoWEUEJ3jupJQq7YVgvnRFDlhXfEC1l6
	g4mQvo5QPVWouQmkTCGU0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545535; x=
	1791631935; bh=3MySeprUatuj61dQPoC21w0cjQD6IxUNBsOqgHMSr8M=; b=j
	AmO1ZUeQmrihL2JiGAwdI2pEfwID/XsgEs/T+EymR375mxcZDmoaEB9rltw5EYkR
	1Y84JJ/7vgxGd+MMMR91Th5iX48kBuC1DD+eqqpHXUQucdtClvG8WSOX7FMJiQtA
	VwK1gPLrkjoI9hbhvBC6BHY/Oh2XN+OxgmAvFNgN/uc4vmzHsLmbDqLytnibjnHf
	xf7ExibZU9LDQp+6GYuajljTAUf/w3VEIxhkbe++NckAXpyVNUXZZMrC+yv88qeX
	RlCgtG5MkH8ivNGO9O1IPs5HGGKCRkBB2QG9qaE28PRARqSpA8/d8hOppIRaja3e
	8tIUODHyiVo2QicG6SGFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545535; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WpBVPP30NBpQ9RXK6DSSht1IUrczzmjZza/GAnDTVK2vcCp
	JXLBJJReceTL6kqX64mTZgwqa3Gl+7yBc9K1U2Vl/TA4wMAs+hBSDXnWvO62gAUk
	jQwdsBdlnFN9u9O7+g2sd1NdBnCduNZmwUK64omBhax3JikORhr8BvhgNB8kJfWX
	hjmVG/JkV63VIS6fXtKjeZlTQ4PE1ae0AfXFPnNkY2/PUkMNBsT+g8R9mLMSewww
	lCyOAsjvTEnGvO/gyY15j7sS/2s5N44R0TzfLqyqBEZV+jTWmpbRPrCtm8pL076S
	yhqUP5sFBrxZRcgJSUUFFjSLK8HAY6SPLkwMMtQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:oiS09+b1r/kmW9A0MKT766csYv2yIv5bAppMKts1Ic0=:NVUG3o1Ublz4xsD/iNNNc+xumEGhq/a49N4nN7N+SMY=;
X-ME-Sender: <xms:v9DIauh53iKeMMijWFX5g2L4u7lXH-BAT_H9XtXWlYlpvokCrGoRug>
    <xme:v9DIamAYT69RNC0EgV5pOn4zDv1EJkWvxuxEym5FQozUbKXnS3xoZlCQq8mxD4ZrH
    4wTJ07R-2txDmpmGvmJiql8Kn5-6-8yH5bxp9DViXZvqSpRRe2FUl8>
X-ME-Received: <xmr:v9DIarGu_drnW918P4AFwysRXy6KBY62QAfmcHbTj87Q83aRjEmVMk4_aD8HETAD7y0BqQ>
X-ME-Proxy-Cause: dmFkZTFSd4uJWEVpr59KjPEdI1xRyQch1Zr8iaaKQsBqdR3zMcEobjzR/qAeRFASLTJa4Y
    s7alI5TteVe0Ssch8yxflpjI/87nvwlrZ+tI6m2QZfeRxd95vLKph98PzEtQFtqlgBp7qG
    u0G42Bw0yq7MMZ9EdelupVu2tSqpHDdrO+v1XuNsQiNvOumURNDfiUMdKIfAQCs6U/ieOC
    /vEyg0ZypTC2TtIs9tjV1GJbmMhM6LsTe+rcivquoxztq60VE+JARdn/a4Q8b6gea8hPY+
    0H4I/3sDfFW2+EIYnlA80+ihTWt2A2Q3u2VMeeGw/lxaN0S+Y3ruLUTYC5VITT+szWxMN6
    kH/suIl+ojg+Ikqj3KoyChfv1DzggvOPvqbTxBa3tN8wbyFfB/B8s6/QNxtRcrqINlZbRl
    iWsi56gPUQPOS8vf1EJQ/MYnhNJo6aBfBPChUlFgJNIJKXeyKEULq/EuiKMVc2MKJQBiab
    U1pmgxy/K7huSDbjmZFxFAZbeKPcBLwNitLGsG4XQAWwt26+k+QHBc3r57BMKAXEPo02QB
    a7YmAaMdmAqQo2O2xf4d8n326PC/B+5FtrJUyj2hAEjGYLA5D51eCLIDKidWcelC3XZ7Px
    LkY42DetGArZ2zVdLaSSEBv1dDDQKHqQgLzu7ZMVNx0DHm4Uy3Y8cHLHvlJA
X-ME-Proxy: <xmx:v9DIamJ1Qot981qNZJhaS75G5RDyNlLkV407SrthCNlzQSDTaerGVw>
    <xmx:v9DIank8W-D1AdY5S8UYE3pwj1z-bj8s64odXMRstNUs7tfWGitLHQ>
    <xmx:v9DIamTDT3tmlLgEPiA6wCT36PF4vCLdsAOYn9jbVy3Yw8MC56Lg3Q>
    <xmx:v9DIahIdnYqhfMDJ_emg_Hchqgvm52u4fJliV9znFPdT944SVEvTZA>
    <xmx:v9DIaqCSZlnDGxrbDb23DcpIKcvqg3fSxc8pVPb_-PT6_GA6KkwJuYbN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 379331fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:32:00 +0200
Subject: [PATCH v2 3/8] ci: drop unused "linux-clang" logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-3-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

In d88d727143 (ci: drop linux-clang job, 2023-06-01) we have dropped the
"linux-clang" job because another job already uses Clang anyway. But we
forgot to also drop the logic in "ci/run-build-and-tests.sh", so we now
have some unused logic in there.

Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index bc5058c917..23e87cbbd6 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -37,10 +37,6 @@ linux-TEST-vars)
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
 	;;
-linux-clang)
-	export NO_RUST=UnfortunatelyYes
-	export GIT_TEST_DEFAULT_HASH=sha1
-	;;
 linux-sha256)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	;;

-- 
2.56.0.170.g584c36229d.dirty

