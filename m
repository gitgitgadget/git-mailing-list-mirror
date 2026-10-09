Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CF4ABBCF
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545544; cv=none; b=FBZVATLSCtrBNBUfnY8V63FbkTS5nurE2PkyabcLn4Gqj7LmVT/Rc1e8ck9xvpZYavYjf1RmisR6DhBKX2nV5N0Nou9gJXFxdmcrfba6mgsJ5Rl8T0nv39VAOYju0MBvwpzDXDk+8H73q4Js+vzA5arSRD0uXCcrwT9rPewLASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545544; c=relaxed/simple;
	bh=h1SMBfOqkYRm2REc9HCHovlow6IQyFwZHZLEiUip7wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KoBGE8vFqTeuaNHTeqG+x2VWcT4fen3w0lETvMzpgdRCYvmwwTnU8QiE9r0X0IWLoCx796dgzZCIcQ2/fyl/NnSWsfzke+ugtw0WKQOeiOfHmkBd1PwzUwl/xSHygdem+K5J2+8c0ATLjTMjxsn5xDNtnx/H2V5rePPvqEsIvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UZcRyOyi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPfHFvXb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UZcRyOyi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPfHFvXb"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C356EC0125
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 09 Oct 2026 07:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545533;
	 x=1791631933; bh=MXVfrPhs2cjEgqjJam7wQmVmCeNfDogvk/7p4NN7cj4=; b=
	UZcRyOyiDs9pq3qGl+bFwET6/5gn5EDqK6I1+Mg7tkOCcxLe85Y50D7PwuZcRsAC
	jukuM3g5RMFqhIiVvuUYnY2Vxh3J97IQhwbJTOWoaaoPXw/F7+lq4FLVBpsqEcDu
	r9jWBuE8j4nhKGRAWbWMnnTxQYoB8kKBv8lwytE5FtdfvFhrWZMokDSNbFxSMG7p
	VkH28Gkcxo4jJpmRRrZiRp50W0K7StogZoWNGYi8tDf8Pw0n6XKfQZXtxz9GTp6M
	exwhegjgytXRYJGtTGE3G42FFJ6zO4Krj5F9gNmmazaYkrsSL2aBF2ZW1O32KRqY
	X/7tv+Chob1E7eb/u/1s/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545533; x=
	1791631933; bh=MXVfrPhs2cjEgqjJam7wQmVmCeNfDogvk/7p4NN7cj4=; b=M
	PfHFvXbcwFt9J4KtjNbneRwswOk9wU0MR+4tyWXcU5nNCB+IhjlsEbiMdCfGem39
	9Zo4CK7tOUJa7G84gWZX9IDU9e4JNuiRPWB3ROr+p+GTnBvdUjq4x6H+FQr1yoiS
	F0oeQmi/V/udHIW3IMmQ8qKRds2Obn/4fCseh8uV7r+M7PG3katbzJQdpjLesLpI
	X7UA1+eDR898w/c2v/sArS5IEJZMzkF2j0mP1v9oBdCoGtcjrbprlG0nr7Wa1V+o
	YyaaOVlRXPS4MM08oBUldNN1/NaFsAU4n7kpsRQe7kBcFkoKNpwpFxWlHTkHqUCH
	5Myvrsct03xcl4A6Y1PdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545533; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cXi+In0mvN02Trmk++f06jd2yZ6IFciJOVu8inEFpR+oBXk
	2NBZZhypACzkkGtjyBYmnPc2pQQIs8p4vYwEjA3CKBPjcDuYKu+bEzLIsyeHzFjx
	KFW6qZTSgHeXrYmSaz7lhyT9uRHqutvzVF4wdI5DsgmJsV62jvh66nVPwlZt0Tpb
	M7ML8OVETR+PMjDmTRa9jfAzxHoVl1Qe3IRa+TnBVmGpLhrck6x+xlyU1uPGWsCu
	61MM75DYz8XR/qfEhkNzURbReZsNjbFBZ5PF6y2T0/b3jO+l7cMN2oQLO08O4pCj
	wdcT6TUFXioAltiCwUGwn9bsLUHK+tZElqlYJmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:38rBMGd524oS0z1CQ5L8v0a/3j/tqFrOmJYpjPek8vk=:h1SMBfOqkYRm2REc9HCHovlow6IQyFwZHZLEiUip7wc=;
X-ME-Sender: <xms:vdDIaqBxXuFI63NT2sTNzwCmuG1B55u9ugWA0K-XR5AA9lyCGFq9pw>
    <xme:vdDIarjh-rFwjAf39EcmDUCHXRIg4NNkHK_N6K8xQ6FeB9zPrAu34f_fU4Uv5HqWy
    ahMLrlF49H3AHSewybCuymVQCBDUzhnBnqRWhu6wKAPCtTrOoukA90>
X-ME-Received: <xmr:vdDIail5J0J1pawrOd1jt7Dg3FTXT0SpMvAMiJ-I6AnE0f-rk4tuLrqvziPgSb6y_dgJJw>
X-ME-Proxy-Cause: dmFkZTFSd4uJWEVpr59KjPEdI1xRyQch1Zr8iaaKQsBqdR3zMcEobjzR/qAeRFASLTJa4Y
    s7alI5TteVe0Ssch8yxflpjI/87nvwlrZ+tI6m2QZfeRxd95vLKph98PzEtQFtqlgBp7qG
    u0G42Bw0yq7MMZ9EdelupVu2tSqpHDdrO+v1XuNsQiNvOumURNDfiUMdKIfAQCs6U/ieOC
    /vEyg0ZypTC2TtIs9tjV1GJbmMhM6LsTe+rcivquoxztq60VE+JARdn/a4Q8b6gea8hPY+
    0H4I/3sDfFW2+EIYnlA80+ihTWt2A2Q3u2VMeeGw/lxaN0S+Y3ruLUTYC5VITT+szWxMXd
    amxCm6/rsKjJu5Fiw6mXmn0ZZwPjGPhDYCUI/qj9dTTJYBzX+omqofad0OgNvaYSmpdpX9
    vU7M0NMF/r9xgKWYxnAQ2v8ITjXL4a0kxY/qahtCvBpXfGnDnRxyJ4GQGeGqssz7GfZMN+
    k75h0yvwQviz1Fd9MN0EQ8UNeLBwFNlM8nDHIU6ZLd0C2Ah4xr0wMsvXGowh+BG5lLTcLf
    2Sh0biEH+sdjEuB9416AA0QqBbGepnB2mLYxTHuFn1iwl/QCFaQeer8Q60thPUu6UEAaBg
    As5rdizTUwsh+I7kg+Zkg9hkA+SYbSF4QzlovXcTHUjKVh9gAuBDMU3TA/+Q
X-ME-Proxy: <xmx:vdDIanp6lbp6IzUJM_7xjUT3gzCEXSGjLTjZPgGazm56mL-vOCWD3g>
    <xmx:vdDIarH3Zx8d4xWcXP0ZUcuo496OECakvcszHRTRieCWjBkPz1br2Q>
    <xmx:vdDIajzKj-sAH64Ouy7Pr8MuVHeyb0vSD14241A2M_I0iwPrcCVLzA>
    <xmx:vdDIagoXJnu3k6GaqOMzYGmInWDuSaOm3hN97txq7LXWztxGs5uaHg>
    <xmx:vdDIahhQaHheJAfl8Cn0Hsm8tyPsf4I-2xrEXx9dJlhZvI5z1nZCvbQG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f0524e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:31:59 +0200
Subject: [PATCH v2 2/8] ci: fix "fedora-breaking-changes-meson" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-2-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

The "fedora-breaking-changes-meson" job exercises Git with breaking
changes enabled on Fedora with Meson. There's a typo in our CI scripts
though, which has the effect that the build does not enable breaking
changes by accident.

Fix the typo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6a3b43b366..bc5058c917 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -18,7 +18,7 @@ almalinux-*|debian-*|fedora-*|linux-*)
 esac
 
 case "$jobname" in
-fedora-breaking-changes-musl|linux-breaking-changes)
+fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;

-- 
2.56.0.170.g584c36229d.dirty

