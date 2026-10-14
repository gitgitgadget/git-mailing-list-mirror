Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49EA4A2632
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966644; cv=none; b=Ly9050h9TOtNBT3qx+RyPWKflF58YFyjkdbu1rPdG5Wk6WodjSAK47QNcqYpFJwFYBLeRxlWhXBdlrZcwZkjnL3pXsq86ruR8wLsXynSieICcHQGBqiGfsEZttt0eRhlcnaqbZ4GZJOYZARSRw3qoK4sFSbXNNPQP7SsAB3hLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966644; c=relaxed/simple;
	bh=8oiZ+4ae75ZHHQ8FEu3FU32y+iaSSZu/b9wCGmkJbaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmwGh7jf0upHihgmA5yAG0ePdmsGptKIdd+ZdvR7Q0u2ocT0TfNqXdEqUroqxZs7QnSqTZt/15rJ+YagaIyHYkJBIkrwySbwpo+pC2w2jqHgxg8ML+cR+D5qBszEMl91ks0BlKKElEy2OPreeQm4iX/os+jdq6qV6hrjQS1uADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BC1dfbGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2vdoKTK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BC1dfbGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2vdoKTK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C2A28EC026E
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 04:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966640;
	 x=1792053040; bh=OKDKiLRnlF83qOG2ppXP4AwlMApm1lF1BHCp9eJyDK4=; b=
	BC1dfbGKonidqtX7FY/JElikvYSpJ38BQt2+UUQgBBo+LfeqXfmmHnpQhOMbaHhQ
	N50A8hnlx8JKsLwQCJSq8E9r4ShYJSaAXbQHmJCZ8i5pq7WoFjmcSx1CA/ef6xnD
	HaN4P77mVisznZSp51brIdlcY86lgf2W4v+c5L2H0FrWSIg6/oYcaWN5oueXHi31
	jtPAJoUS9KuaiWZMXBSJ7JbMVl03ZXKoRWpQMfTG16mZkZIfkXVwIjJNFrDCdEa4
	z5eCh56tzalP7opbdIEub6PjQ+QgeKrufkAA59H+ND4P9J8GqFNL6oWtVbk0j5JQ
	+5in28dmFUSajUjaDiQLEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966640; x=
	1792053040; bh=OKDKiLRnlF83qOG2ppXP4AwlMApm1lF1BHCp9eJyDK4=; b=G
	2vdoKTKROG/j1g088hSYgURiFoDRNfTdgaqn/gU/uHPmOCCn1chzvmuur7eJuZTD
	p08U1yFQuhB2mQsBaMwCtXxAIze/24tJH4bgcLC8mgu46MBH8qIKGNkL7TGJlQIR
	T336zZ+ajfsDhsrzGe2kB7b9nYHPWHd6Hhal0x5hbsfqXeBuyMOh08nge6R0GFTL
	mzOZO6XZo1vjEXPgKWmM7LrOioQT16kMsosA0FOn9obZWBTZH4Pmn4iwyYBuo900
	kYDXKFC/ZHynDuypiNbmH5DRtS0bLw+ZfEYZrXlFwjPVcrXvJKan3Q4iwas4ouUK
	i2b2ECVmIOsz/NXzlV0ag==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966640; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hZQ5gGNoq2sVQH8pUOHDhRkj141x/pSkIorE054KDijk3KG
	ryq2sEQMTCVgcNx0DpNHSHzcUdpAla3ElqvT3G80t8rTWWyegKn6fAdlj+8COYR8
	6Jv0hx5LUl7Gxp5V6nu9eFiGsgkmCvwkxBZuAxgdVMXMKVb4NrkEFMazxOEwXhUj
	c/WPTbsx/BRhUb25zw3VuX5eHZOJOvV5LxcBAFFYZnaHJkLtz/YpDfubcfGKH9UO
	tcQ2LhIjbQkMmeghiDc/DabserDeRukHyDJWLyuq+7ysZQVSsWBZ4Y96ARIF0qKG
	Jn/9nMCDQ+omV+I9GYxlJOYtD+r70XyjLzfHZHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EkK6R0RfoO0pv8KBncTEw+PaMheGNE/qB93UK/LB244=:8oiZ+4ae75ZHHQ8FEu3FU32y+iaSSZu/b9wCGmkJbaE=;
X-ME-Sender: <xms:sD3ParjFW1S--M5duCC6wzodFkeUBT2deyL-2__S5Np63nIgPTw5zA>
    <xme:sD3Pau5lg09LWcsW8Gca4QnDGc0SdsUDqVfqKN-Dy-IzkcxQaRGhgCWj0nbiVG7z-
    dGI1vs7XPsva-DfA-0b_1OP5_bp1tBOsBbuqnMrpcHIxZI8RCQpCA>
X-ME-Received: <xmr:sD3PajbNAOfY2jeKQvyzozpdfuRTEbUnQLLNFWpexB7UhVilmwzWDw>
X-ME-Proxy-Cause: dmFkZTFiXFj+FBRzh9HS/srF0SxU/3tlRmBXj9wQFBopQh3IFYJMfA+RUJUfDoRGuNt1KT
    0rl/kzbB8sYSM9TDGX4EVTusgs4+ZnUx/1PLczw4a541VqzKaCGYPukpYUQHVzjIc/aMFf
    cmg2rG7xHEahxp8TvqD957x0FXuNJBsVzxoSPBbR8Wv1EBIOjDMNZ5IblLdHw434hoaPei
    2IfpGBQB4XY5UK3hklkouyTooFIaMQC51vcUKxTV4cExYv6h01V6uRodCalZ79DgjJY/QK
    3oY4RJ0CTISZilN+VrAVJftpDGR6lD7EN9S6WMQqRb2G3fHmErx8LU0ncFWSAdN+wtJJVR
    3LHJGwEdIWMbyWi7xCvfNluqYAp4r+bPUR9M6aooO9a4lDBoKONudCqkgAQduO1ErC9Tmm
    KPJAFoUt6q6Kns8bDyoPDB2EyJFeyhl1Y+vNNGKpY8x9R6O36l3Cqcx51HJEJRPFyt8xJi
    U0Mj5I0qQ0NRynHoMx33GEvV4FgK2IKW0y/aV3eFUj/rC/Zawj/KX6Zlh3VbI2MNZJfVIM
    FOGH/uFyUIVoop1EmWidE1HYZoO4Ez1fD9++ZA/cZ5XCyyIRi6iQFr3LqC+j7CcGEG5AQu
    9gBeilpcw2disGegTaqfby+nDRClEtmRbvAVoC3nws07O9FFqeAqdphN2H3g
X-ME-Proxy: <xmx:sD3Paj4OH5vrWaDBz1fd2u7dLl5cabG4m1knaKXZdaEG4c1xmylJfQ>
    <xmx:sD3PamCBQg02hdnpgcKV2rumiDZf78jFRGCnzgiWoPOc7wOmffoq0w>
    <xmx:sD3PapevCe5dz03JPlHqVhsV4fkJ1Hd0ii4dSR7n8b31W0sm8uesCg>
    <xmx:sD3PalK1TjXRuUm9itrv1df236iA0kCWGxzECi74FQPnUD2oPKaUbQ>
    <xmx:sD3PaoY7-P--wfpMnXI8mnOPkcr4XSGJP-cdJtjTEPeQ2d5rcmlx0qKE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5429ffdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:27 +0200
Subject: [PATCH v3 1/8] t5004: skip SHA-1-only test in SHA-256 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-1-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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
2.56.0.212.g129ede20d9.dirty

