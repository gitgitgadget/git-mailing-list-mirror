Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82B4A2076
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966648; cv=none; b=oEyO4B76fQt3sJtkEpv1shDk4jYefPbV/FV2FpHM1Un2AxmUgwcYQGgchmCZnVBCVovF7WO738iG8syz8l6XayX4Tj3y3//hY6tmVIdpL/8RH7MuZpgI8CCUgEZpRzcZd7iqD8l5bJoxUUpEGX0K7xo0axAP2J+DNhVsm0GCpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966648; c=relaxed/simple;
	bh=pNgXAi5qS7XuDS3F8sASfLAy4CZFmWAn3UYw5f00Igc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDeuv9x8U5WvWSqs/0+o/CV0dbq7Ycr9DSryVanR0HuE36ybm64z8zyR4bFxHBrWX44IofDh1wC+FPCj0V/9EuKrWk7CkqH42nXVQYqo1oZy81vaw3Z11Sq3hQmzp2eOGHVCgKV18i8sZF/E2bKxKHeKsk9FdmRQjR1t9YmitF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IVWViZuL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ui8QhBuA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVWViZuL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ui8QhBuA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F7DE1400144
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 04:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966644;
	 x=1792053044; bh=tfyKsQSkDfantok2TpjBJFE0VSF828pT0LTTB7Z/LmY=; b=
	IVWViZuLMUODuVTUPJLpe4VaW/qKnufUXQ+GbrbbPRhs+YE6NjwMdvNi2sl3NzC6
	YTZXQDotCXZOXZdQfRo8ifw8DIQ/b1QKWD8+YU5SDFXcRDMkWY37Uw8/rVC9WxfL
	7RT6u/CMzXd1WPPNq65A/tYbbf3Ey4bJ/gOjCF0bg8j4FjH93H+y64NeTkHkQqRm
	UynRb5cWMUnKGKcjTeSazye6W8gVQ60l41Ti+EBWt2JXny8qoPQssj4WR9/Y4ksJ
	0VeYogXAQRbBR9TvD4AffdPx1lU5m+lKHox2KlSHj/Pko+aqoxDGJTCfMEzMV/J5
	8jyqAf3MQ2sIsjV7B7q+xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966644; x=
	1792053044; bh=tfyKsQSkDfantok2TpjBJFE0VSF828pT0LTTB7Z/LmY=; b=U
	i8QhBuAapZYd13hvXDItVtfalA9+PHtGf9vK2R/RQqcZCRL5QBOd7baUABmHrl15
	55IyWtEgKl6SOB9D2D6sBkoPYHk4Gi8bn3jNLto4NqGyTqB3xbZwFRbM/GhgpaXi
	xdefB1XMAauIYjB5MP8wJwAQd32EgFQ4EZHGo+hb4RocJVFh1ED0f7k6tkxuHIjb
	ut8MlUO+P9UBM637+eD/URZnmysJaet/Luq2EOSxERb8whvGs8zq2jmwDkU62Ank
	BpGN8c2bwwiYw7GAaHDZtAMhHUGGis0za0isoF81UE8A2qEV6Izv3/vek7sSl3em
	xy7Kbu2beD3BptdHoqSqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966644; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IO9OlfvhFCeMuOnEXbAP9JMcRm5sKfO4/PPhfAdTc4VfijW
	6s4ZS6tPWr0QrLoDARTR7gJ3TxNgm0PyBTRjpf3LNH1DTXkTISOcT2scvU9pIyJ0
	uR9g3UZ0AuHOlt+LJYX+UVAsTs3Ol9N2YWkMoadf2DtWSNFteQ8eLO2lciqrM+Ec
	1vGpJ1rr84rMjVlKo7Qw3wDlNhh0omv8BgWjlHXifY1RUi6tprOGQo9q/M+/hE9g
	yYhR3T/cuDXm2TCtY7JQTUNdENm7l/SJjJhTfJnpqI6Rxx9IUpoy8XDZmuKqu7/r
	w2WTHc3so+D5zMDT4NACw9PheBqZjDL76wRAHkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mGBmwX99jD1sDlrysg3G2KLZJSXY7UWvIsXR4gr1v+s=:pNgXAi5qS7XuDS3F8sASfLAy4CZFmWAn3UYw5f00Igc=;
X-ME-Sender: <xms:tD3PagysjpQuEa22leHSiKyJXs6hwA5L0r4K6xBZdNqbIEo5-4emNg>
    <xme:tD3ParLvjo1HVvKxUj4IMGKc5EBIG_K8ybm-lEAGx2l6YyoQPG3rqPCynZFvbVlyD
    KsVeOEe-lNZbsxgqHL9lmXTKFN2varTcN1HwzZBSxIMaAat0mEAGA>
X-ME-Received: <xmr:tD3PaqqNYKgHIry1eExOWzGZNcK2ZCbcRfD726oTMAFnaxrR44dclw>
X-ME-Proxy-Cause: dmFkZTE6SzrF/RMjrmroRJrOmjW541t97+9JkKtEXWPcIIQocVBp29e6gPvHrq4uuFZIVA
    sYdO+KaespEORtvjgMDFuZZlQMj0loh7+rLLPES4l9f5ZQLP0iA6HOyWN/23cqUpZ0F4K5
    39e1I8XadGc0Qccr2ydzopoEWTLpJ6aVkJSniN+W1kjmLLuLIQnRVNdeIknZfnc68BPmOa
    m/5ibopfbb3L9YFNS06OyKJahMcnn6J06N7Jy1f2LLF/BeI0oXwWJU6MOF9yfkvXDhLdbA
    pqJEno+/VKPhKuRrgC1gnfvwFLxaXk88ptmFA4jT5DpJk/0g6rOg/zbzCs29gZAz9zl1Cl
    L1w+8h64gpidbgawYziyMryqTAfq6uUoPVDz2vABIivu8EblXNk7RFBbJicze9GC0tPeAS
    ZJYobY6v4mx3/kPiUj8Ku0V+z1WzBujsLSvNS4b2FHrIar80uZBHMsfdyrR8hy3zayLAGb
    Ex7LBl1L0OPAP/p/FlFRT4UL93kp3mcuH4EexNVR9AqS2UffT38RrX5sjGXBnaayZR/af5
    St59JOgmH/Po18TRUY9KjAIePY5h7ue2fPaGNi6t5k+uH3c96hbWOmNlEBmFzlfZ1yX+Xb
    WgtiK/P7C6Ke0TKXXCO/r6nLJgkck8dfM2StSZgI61ZsvAWCCp0eD9FM108Q
X-ME-Proxy: <xmx:tD3PaqI3vPql-zNfQ_x_ZKLNRZz_dchTKRPMoNrGnMSjD1kp63SCsQ>
    <xmx:tD3PavT4jNZntDSuXV8V5E0GmrD_mwovKkb5mkWdoGwlcPN5f1UEbw>
    <xmx:tD3PapuRnR43pDT7CBp5C9DwdAwxLG_b7GWybw6qE4qYCLcPZpby0g>
    <xmx:tD3PagaJBZXOaKdAFOv6cTequitmP4SLHDzK7_7vtF1ripxicuohEA>
    <xmx:tD3PampyC01FW1y2JOR32CspoRKWWLrphhlLc0WwFuDrr3HRiGMeHfZK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d621571c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:29 +0200
Subject: [PATCH v3 3/8] ci: drop unused "linux-clang" logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-3-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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
2.56.0.212.g129ede20d9.dirty

