Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11BE379C2A
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413013; cv=none; b=hftze3CiRZCV4wLLMJTNy5VWNjByz+ca15uGWKIIIlBdAaXKDzaj71qC2qeg+C3d65O0qy+KehwG6FEJAopS7lg/P0uRh++yJGcw5nR5RrSiIkZXA+o7+ynpRVRyH51pqtsrJOtIGHsNm6Y0MWF0/3wAvPz2pNhiy2nFHwnXWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413013; c=relaxed/simple;
	bh=0jTmqsUkMCAFT2jFNDV9xpR8EyGfKX7NnhCKcvUF7dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUbRxHylTozsyLzE6/Z4uhUn2PJU+3JpE3/tcpyFOxeZptUz5UATozNt9ABRajAa7YegxdZlDDyB/Bn6pGIMQ8jBpmzqB/ApDYCEc0xJnxDLRLxZo2XCaZz5sI/M5nFxlD6ODG2N3PheBWVkbAkPSnZCRbnR5lqlg7MCNnODnic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jnh0GDZ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CG/eoxIF; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jnh0GDZ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CG/eoxIF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0078F7A009B;
	Thu, 30 Jul 2026 08:03:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jul 2026 08:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1785413010; x=1785499410; bh=LV
	i5MyvnnsbST7Q6N/v17lYwTnAX+nuMLCRAZhu4Dp4=; b=jnh0GDZ9Xo0xFLSSuk
	qS3a78AJCblT388y+QKPaaXJ7zbvOxW3r47Xig5E6ghZl8JYNxdbSXuSfx27fRtV
	2DV46lMU6l2Dfbp8VdnCjGA10KmEMaBtM6pnwVTfZXwZz6sT8mAOnTEA1MTb8tY6
	BQNoKsz8Y6inPX1psqZpOvC9Aom1xFhFyTs1IEg5LyqMxn2GtS535q1fX4q/NrLX
	Ds/2f6n3iqVmL/EUvCCe1gZ/Q2vX11OHVR+V39bvteuWIZFNE3dNYjYlEw6600jl
	ZhLbC9rT5quTW6yQHlIlvTnBQbU+K0u3GjR6GTGAJQwoMIAelG593vtvkSDDKaGI
	VroQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785413010; x=1785499410; bh=LVi5MyvnnsbST7Q6N/v17lYwTnAX
	+nuMLCRAZhu4Dp4=; b=CG/eoxIFe4swMu+kRzm1shEa+n9V8B5DDBltrDdjXnID
	IqDVGR0kf6ayANoh+dSIgI0J+L11S/rVpWX1auJbIYbPEzzJfxYrkqT8NiWFgwV0
	IwY2mgMr/qMvCjhhiHcU7CHazYSwQ4ktw+P7Xfmd6xWe4Dnh6A7y5W6CXoD08ZQm
	0RUKLPX5reqjbnfrPxJ1qMI8JVlTed57hGXkHWMI/gHWvjZwjNF01CDTrRFGoR8p
	ur4mGtifz6RefyUeGYck62dr5eJic98MQk7HM4chI3ncGAGcNQYb4TXc2U1gzuOM
	yE2FEepZqbvkIr1T6cvytnUGSdiJ5N/tZtcNsOj61A==
X-ME-Sender: <xms:kj1ralgODCGWm75SjR2PQPFDs48n2bqnk7FO-QdRFkQhSVzh3iDYnBk>
    <xme:kj1ragDLuEhKLDqNVtZwnDWoLHkN8OJHWwQ8LqK1mAgVak5Bh8FcjaTCbzI7Xgz0f
    i7-Brfr3Fdb9qv14s3LYTY4_D2y9j_ahgGyYPgjOsJPngm_1kc-Yuc>
X-ME-Received: <xmr:kj1raitlWVUhNuuaOqCKTnEXhTpGKTPqgaIuWYmfBLNe-YT-SM-LHksiWQZuDEve-cyI2272YkcWBanplJvzDnM7ZenfbHklpU5pGsAKR4s26mmMnoyoCgI>
X-ME-Proxy-Cause: dmFkZTFyUsLnGaUruIGFOcWQKzKG7BOO922FDPj7VG4dY76XH5GcIDFaaP3q1iC5j/0Cq6
    7tRjMxWU/nx0/2Ej/O/4wNZsFtaNJgVEiYNMTXsdF5nCRAAaka/wPaak60S3qc1JXTrB9J
    cPq/JG2deVnqJ9lVGedYApUZ5S+tWQ1z+GwrvvHhqcrnzRmV4DzrbOAiXZ5zglo7yXXmyH
    4OjH1szj47DyHywbClLg3WErDB2nBoXRLQkG3lJTRKF9JjfSA8YzvHp2IeWEMPA9ctfsOL
    ilVqvLgyToY9N24BqycHokF9Gqp7DASImlQnIQxzFjTZE5hhNJchMojJTRr2fPHbd91FUi
    5RUxqRsENcoBtEMFw++pDUvHoSWGr3WRZTupyqT80cNs3eWX+wnfeIQZqCOdSjuq2SG5TS
    wzM3WmTnclABVfH4bKe63L2xwdVj2yxsePQH+pUp73VMaCbcBhPCt2+NnjzBh3WYPIROp+
    9Px6/J5b4NmXTsRAdrk7tXxfyyf5gqncKda4Pi63b4tnNaQyqPzGix7UUY+hEY9B5ZqaYb
    B/mhPIeb5ZlYyOUqbPB1bA8/cmgj4LBzUsTVJZpF/9G0nHxEJRQ8VUmJpCkJSq2242zM/N
    z8o7Qr+gq9f3bBGOfU7VbKwmao1PGrSJrUfDgsSiQ9xnaLzimlDtQRo9gx4g
X-ME-Proxy: <xmx:kj1ralb-cl1LqLIbv2nGTYGiodMrCDN-uOEq0WMRP_w1DmSHQS865w>
    <xmx:kj1ralUMhg_Ws-cfihK4CFmT5iBQemnm6xiUgSy3xsFwvSrhPEddbw>
    <xmx:kj1rap6JG72-Ba_TTwLbFYPZMmCSouQl_NRP0vI8riSSDBSgJTt4BQ>
    <xmx:kj1ragg_mv9bdGqEz8zZ5KCbtiGAZptklN5jYdQBNa7Qu8ja04G4Uw>
    <xmx:kj1rao4o__Vbk_mvnlmPRkMMgyAvE0Lk2fE_3sJ7cifLA2m1JKCtdpuc>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 08:03:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: format-rev: use [synopsis] on code block
Date: Thu, 30 Jul 2026 14:02:55 +0200
Message-ID: <synopsis_block.af9@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This code block uses the placeholder `<subject>`. Let’s highlight this
placeholder properly by using the `synopsis` block definition which was
introduced in a34d1d53 (doc: convert git-show to synopsis style,
2026-02-06).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/doc-format-rev-1

 Documentation/git-format-rev.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 505a52feccd..836ba4b0c24 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -96,6 +96,7 @@ The mode `--stdin-mode=text` replaces each object name with the
 formatted commit, i.e. the format `%s` would transform some commit
 object name to `<subject>` without any termination. Like this:
 
+[synopsis]
 ----
 Did we not fix this in "<subject>"?
 ----

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.54.0.22.g9e26862b904

