Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFE4C6521
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545542; cv=none; b=U+VhC+RIxHUwrRVwGhPdj/Gnzp2L7B2uw5IoiWiZvGef3qTkM61HgpkHCKGb+JVg5DcpZxGqCNmOIta42IeueL9ArZAMs8cKNA1ab2PkzoTfJKVoFLGjGjSK4NDnz6z6eAL62U1J1LxG/eEo+I6K+L38FO/J8DizRqed6BlLrto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545542; c=relaxed/simple;
	bh=U5frdHs1YIqSTMMy5d6EpSGn8s+J7IUW/p3DMrkJ0Iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWr1SQRqIMZTtva52QybF1GOGKBKMbh0HRSvguI6DtYXXoxmi/gDwRgBurF7nB5FiVG0dz/aoqDXnF97mSpmCQQMvVDxNabP3GF4MWMFtL1R1AmhYuYQ1FROqFEEWKcTTokvrztDwlM4vnQyDi/NIZStMhxNJRjFfSzPufVjbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H+oxeUPX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mhgKrozA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H+oxeUPX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mhgKrozA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A7801400078
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 09 Oct 2026 07:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545531;
	 x=1791631931; bh=MyX/O7XArIpFKF1jvZ+avITGDy02o1anIv4tQwbc1/s=; b=
	H+oxeUPX0u0ZBhpg8LZhjKuw91Nwa+++/ouBaOx1ot2VOHBzqZyEaH45omc4JUNt
	3foBWBKWxS3tSgRt/iu5o3OH7lavdATD6otsm9FSKrRO67HIdwaCwOz+8J1J13kh
	TIIFMqumej1C3IKwQe4Pv1sKoFDNCfM1UlzDFn+zF5BYF6UpfUhY/qjsKgzcNfqN
	J1+ehnViIVIYId++/qU0WgqWDPheEnh7QsshOkDr7zZ2pLIjMrwXHgc4bx6wWb4z
	cw+sBKU22JME8mBr/wW3Fu0WU+6UlZvjOiI6dF0OMB/+hrok5g2OlF72Le8x33Zj
	OAKmQfs2oL6c2f2Q4ZVfGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545531; x=
	1791631931; bh=MyX/O7XArIpFKF1jvZ+avITGDy02o1anIv4tQwbc1/s=; b=m
	hgKrozAqYkNG+2AOzM1HL4rlqOSsa1NxUCdB2o90XeCX+kR7g+XVggkQG9Of7D9u
	P5ybybKy24CaF8fZa5sCME/kOr67vlnUWmcW7iRxpfOoXqUcIu1yxUropLHYMzun
	4SEiToI/ETmmTgH2pbnbF2qCGgwbjJafIRkjQvaVhVyqE6lD6tvpQmyEVwydZXLG
	N5H4hh+dYXbuNwzch+Wg/Za4KE/xNLM/9X+4DH2iZfzQMd+oCAVp4/pQI1v5cqRx
	a+gpwFjekWlLC6M3pKbPp6pMGUyZsexoiwSJ9UFiJxBcP4BYI8GEVuPlC/GYgsEy
	ATN3hCwOEFLNUMIvOW3vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545531; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ibx2JkLhwxMlz/inUfgH516Unba9nCJ3CNILQlJ7eBCFdU3
	kqReJvgsU4/pa09G4HAtcGR7fnUV2QZY5VYFF2ScBz+BN/0JciMARCI7DpC3/gEO
	kFixD/MIjyZrCeaJlRtikUGcH9/Ex4sMk6Nklgyiip/j5HI9QzstBcoLddICl1l/
	NfcmNDeRC4MVNm9jaTXQOGfhaR9uM1k4pWYyqegGofdoU1W2/yZFK1f1gFRXAi8j
	4jRbQhOvDBe6mRY156Pd2pI0ZemFxK8GFALpeWu2cUcaaDIOFRRmyGs3WqJkHILd
	I/VItMRMP2qVBmmH2qpU8RQIldo456mvmeZ3HDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:k+UFcYK8zSAqMtNxH5t2tXEUFjph0skPnLr/QrWzr8Y=:U5frdHs1YIqSTMMy5d6EpSGn8s+J7IUW/p3DMrkJ0Iw=;
X-ME-Sender: <xms:utDIaqGTna16ZABIO8X-GJ3o4KFttq5iEuojwcfx-SQph4u3snQVsA>
    <xme:utDIaiVCVZiO2wgwTTenCRmS_hlm6X2I-Qb53p8atKYf0jQLf1W4GKWEz9RCvJYYv
    O-W_8u8jfU8LV7M5XkD8RYQPgKlcgPrfb7gky0Z0jpGZ9s-wquzWA>
X-ME-Received: <xmr:utDIapJ1wPMhvV_KTfpZDRffJVml5N8qW5v4y-qG773AAR_IAKKWXWwi5k8hT27ICaqWDA>
X-ME-Proxy-Cause: dmFkZTFSd4uJWEVpr59KjPEdI1xRyQch1Zr8iaaKQsBqdR3zMcEobjzR/qAeRFASLTJa4Y
    s7alI5TteVe0Ssch8yxflpjI/87nvwlrZ+tI6m2QZfeRxd95vLKph98PzEtQFtqlgBp7qG
    u0G42Bw0yq7MMZ9EdelupVu2tSqpHDdrO+v1XuNsQiNvOumURNDfiUMdKIfAQCs6U/ieOC
    /vEyg0ZypTC2TtIs9tjV1GJbmMhM6LsTe+rcivquoxztq60VE+JARdn/a4Q8b6gea8hPY+
    0H4I/3sDfFW2+EIYnlA80+ihTWt2A2Q3u2VMeeGw/lxaN0S+Y3ruLUTYC5VITT+szWxMcN
    vXZpnqFgF1iHlG0aS8puE3dYvZloNhgjvgBHnzruxd165LTKkLyBRAfVEMlhY+KCfPhsNs
    VwxO4mx5h2prHYsl54iifh9Vqeu8ZSdHg2Qr8iHGcnYZ9TiH72t9hpYRK6yI2FptTPk5ui
    Zi0vNQfN9199TDyN0u3hsbv+626YvR5iZzFn3In8xb4bPvyAhECM69jo5WPn3w5T3gcJml
    3QMNHY8lvNVE3nSKM2loiL6bokJ6HwYHo4GeItyMK7HlZEnjwe+0z5aYgjreuLXCLdKU62
    rZEuNwR190AjdNiFsaCoNt+py76ZCW+5Gn0YLdgRVh05VNdq0M0MfAl9TQAg
X-ME-Proxy: <xmx:utDIai9JS4qWYX4rn3xhUj3xDWiiznQHDMBzw6bZMl4oWZtjs5kCnw>
    <xmx:utDIasKYY2yQI-xxXND4fbnYj7uW-nOca4TjNtB-OI7cVoA0fsyV6A>
    <xmx:utDIanmkFP9pdtFozlFMjQaqm7MxjepNu3SvzyvUsEoCAc5Hu_giKA>
    <xmx:utDIagPRBT0KFQkREFICs71zeaAZ7mO5ER0YHcVNNLm6lnoIQwfBfw>
    <xmx:u9DIaiEJU5ltcOMOH8zxWpPB3lP_6GVUkOLERteogTNjylNGbis3tNEG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4cb468d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:31:58 +0200
Subject: [PATCH v2 1/8] t5004: skip SHA-1-only test in SHA-256 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-1-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

One of the tests in t5004 extracts a ZIP file that contains some objects
larger than 4GB and then double-checks whether we can read and archive
such an object. That test has a bunch of prerequities: it requires a 64
bit `long`, unzip with 64-bit support and it only runs when EXPENSIVE is
enabled. Consequently, not a lot of jobs even exercise this.

One of the jobs that does run it though is our Fedora-based job, as it
ticks all the necessary boxes. But that job was silently broken: while
the intent was to run on Fedora with breaking changes enabled, they are
in fact disabled due to a typo.

We're about to fix that typo in the next commit, but this will also
uncover that the above test case is broken when running in SHA-256
repositories. The extracted objects are SHA-1 objects, so extracting
them into a SHA-256 repository is not going to yield anything good. So
once we fix the Fedora-based job to enable breaking changes, which will
make tests use SHA-256 by default, the test will break.

Fix this issue by adding the SHA1 prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5004-archive-corner-cases.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 768b0ff85d..c9c879cc5f 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -185,7 +185,7 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
 	"$GIT_UNZIP" -t many-big.zip
 '
 
-test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
+test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO,SHA1 \
 	'zip archive with files bigger than 4GB' '
 	# Pack created with:
 	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file

-- 
2.56.0.170.g584c36229d.dirty

