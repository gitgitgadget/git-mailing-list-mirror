Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AE3F1071
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453694; cv=none; b=OfxkaZr10Gi/MoGXfW8LNG5s1znGT5Cuhcsmom7O/IFZeCIf+py0t4txSgzSYeHn+3nMi2kZoQ0ZRcvqWuuNGPw9hk7kPOnZ7uOWAdZZBjkZ/pLowYY8NY8J+Z5HnARfOuMgsavx5UtEkfk9Go4+Rih1rmGPH9/hw4fO/mQCmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453694; c=relaxed/simple;
	bh=u3MDMl8durDNvLzVNd2J+jM1dn0mvPSwQLnB0gJjcpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLVUJSdipiF9GHgrAmpG2nrTdENrSxOBcXn7e4zRcR8u6zxUkvBgIkDysNiEKUd5W7BjvqJx1eWC6/38/VH4taJHW/Zbr1cvWATFbj+GDAXELMFQYvUBsjNAM+Z+W4gPxx9/tGWw1WwwZqMUTaRp8jKmgdIW+wypc2HQb6+ZUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uBorAXRQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yZ649dIp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uBorAXRQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yZ649dIp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D22B1400169
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 06:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453692;
	 x=1791540092; bh=j9XxqzUxNYfctcOK+HbWUI3EVsRC89//JsDE9PIU9pc=; b=
	uBorAXRQFaWVVWGCGmCBlyECMHGkYF46tr7dg7z+buYmJ4sGvLPe21aolSKkpCXF
	CwbT8ac/IJKcSVgQD6DK1ObWnK4xGGhPnvh9Amp3B1ddYeSQvyqnDQLN5mNmySbb
	Vw+fAmyOi7NvqhBu29wrEVrOp/sn7GB0eZBJN4hRiCqZupcwIKVl//CKqDaSF1E9
	thXkUty/WDgyIoEww0XEuqD1VRJh5ZQzYPPuk0y43uygRblD4mUscQX0aRDMGXEB
	4WX3bSEMkns8IwIZ2AkgkW1Sw9tIjE+p+Zmx1s5wYaMTDdf5F6ejiyaN2pomlIth
	rWK+nc+5KwRn2sg2qD0lFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453692; x=
	1791540092; bh=j9XxqzUxNYfctcOK+HbWUI3EVsRC89//JsDE9PIU9pc=; b=y
	Z649dIpibx0oS27JAorWRrc22ME4XUsUf4HphylDBGI/9OvAx5d/XEyS8nVkWUwN
	3xnnn22dQ+s+6WHEbq6QdrqLmPytz9/iPaz4j55Fu3olbzdd4gBdA0/vlkmHIO9f
	GzyNtQsRxcw9LLpGhefyxwtCjWVbBNJ1kmW02PcYvKjFq4TGdam38FEluGqQxsHm
	tT/1HZVX0OZXyx0MzTzveVbkCs3D8KJ1G/RBtn2NfrzOJM7b6xhFnTfrub613Lkf
	gPv23waj1Bo306mmw+cH563FxLZDlawQdzP5h+MqCDoCc0x9hi9ZD9jcUZVnlYiq
	/vU0gv4mXR7kzSw5gikjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453692; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Mu559ZOC4OQyWRNmQxSkw1pAss4Vet2ICcFCTcRyJH7jl0C
	yyOKl0/TiKBQRD9tMhQ/cOj+0KVFQ2kD8DzKNOHRDxKrcJmuRrwzPj1Zt/mUUR0Y
	Ta3juKt5PLSGgEniu9HhwB2I9EO0s929yuDYoUO3Qhqj7LUOaW0cmhI7gn94dbca
	cNAjzflDza74rVpCiZyFA3X/FG1itwTxsuPcBEW0a2jnJY7ivRW0Qay3sDqypszL
	ZqiK8cSM8QBOqKVdelKAdEN/ZYiHph0gberSm395t0Chpzf8LV2UEseie8uL4g09
	YggNTaTlUqFdzN/DqN4zRlbK5yrRXfvsIauFIrQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1llMQdD55WKR8+knC6KwgBRDXE74Do8Ku4M/E7Jih0M=:u3MDMl8durDNvLzVNd2J+jM1dn0mvPSwQLnB0gJjcpk=;
X-ME-Sender: <xms:_GnHap70TEn-opgCYd91Fejo-xiTr6a2Yqy9KHoHNAhzgpuzdQhxrw>
    <xme:_GnHauUSBJFAOI1j9Wxy80R6mYjxspitPQvlIaqpRHoye19RPFPlflpK6onm9lrdF
    sy85UQNaXpP7asNFxFlMdH0G47U3FJmaunZtbuRa_0opfuIOmjcYz4>
X-ME-Received: <xmr:_GnHat3RT53WQZ2eR47OWv40sVjm3kRewWq6D4KqkPYOTTmXamEoOg>
X-ME-Proxy-Cause: dmFkZTFcPkAz1MwdF9G91Q2HHt/DMwRQeFnKx+x68D7GybYDQ/i0KpIs24O8mGC97InV5x
    l9pAW0ts/UU9KH515tlBDmv+WZ0+KYrQRh6xeKbZfQat2Qz+Sg1rXt3b5uJznUCyp0m8uY
    71BCRA4fNnv9oBdGpbiziYXhCQjhE8NT9KNX8KIfhb0V1qRTBvsVj704A31+Hni2pY1ggP
    a3q+zc2dU5mDDUUOQmy2j1zpr2bNPvsQxh6Ysa48mXJ+zQrThKKxZGkcT5LdtAIGkRdeOf
    ck2bD2X0g14DJXkT4iu1Awq0JBVy1rhu1vpE3BYH9j6MP3iwrywFfxgjL3LV3YpxuArGRS
    3D+Q6mtI55aJAqaZVFdh55C0TeNjgY7AKB7904xyEchXZ89z48g9A/LsFTQQMdqEDlaiim
    0hfgACataEj9YO6RPg2eZD30ciuDSza9yrwLmj78soKitMqRHe6oK5YGcRCYSt/h8eqx/a
    Abcl6AuZcasUlFdyej9z2kW6/rCUw0hwtmibC61MViQyd7DeZRWSKoi97oBW5vRGDNjg7X
    OI04w+63MxbZPL1SvEayy3jarN7c+KamFI1lcDj5RD4Q9S+Wd7DF05EU02pmy/lVbjiA7y
    RzOkfXlH547hIlyf4sXlCTdyY6srFIkQH+E6Z8lbucLnKKW7thToXV4in5KQ
X-ME-Proxy: <xmx:_GnHar1sD7gdOZTBmuJR3Qsiy18SoKonWYphi-TiSXbtM8NyUs9apQ>
    <xmx:_GnHag-W4MjSShJocvGbMZqhHmQ-1MJokZ7G4wGUImg1OrdNn8XskA>
    <xmx:_GnHao3f1rBrdoQvnE_ekhUaFQR3f4H2fGJDxinip9tcHgx0NXzbDA>
    <xmx:_GnHat_mJCIel0dA_7HLk_2X8vomtfewyTDaaG851NzAOoCeNDuGsg>
    <xmx:_GnHalERmzX79ij7We1pbnKKRQY29IaPSYwy7515jh8i49aUveFMdr9q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3364d47f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:19 +0200
Subject: [PATCH 1/8] t5004: skip SHA-1-only test in SHA-256 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-1-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

One of the tests in t5004 extracts a ZIP file that contains some objects
larger than 4GB and then double-checks whether we can read and archive
such an object. That test has a bunch of prerequities: it requires a 64
bit `long`, unzip with 64-bit support and it only runs when EXPENSIVE is
enabled. Consequently, not a lot of jobs even exercise this.

One of the jobs that does run it though our Fedora-based job, as it
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
2.56.0.406.ga2d225a756.dirty

