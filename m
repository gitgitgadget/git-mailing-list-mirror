Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3E26FD9B
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130307; cv=none; b=nqMP+MgsYWtecVZglHHe5YqvNj3YJA6KjpcXhh7FI+FjmEmcWQWVt0GuUC/9ABkLlQ7OnJPsRV329ug89SUDwoxBrqVmPC/DOjnbXKXn6PaWQZxOtgrTgclxeJDOZEkiZT/nBjYCO5yA+Gp1zMPYoozbRT1n/m6rrsSXH9jBiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130307; c=relaxed/simple;
	bh=lc6IkamEHrxWARMaJRTpMxwLZytYMCf0wB0ylrlySzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGiSfqpeJiqGaaalVg21vsgGpvOOlNGhgf72BDM2rdNX+GWY0IJW3Op8EpiXz1Bao6dh3SqDyf6uI4XG/TBIcmeP3Yi/jImYR4+K40/pR5x729/c9rbWBPYulMqzhpXi+eNJCqGFf4HnPWY7XDi+gyb3kbyfcG9XX0YWAj94IMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=wCKNh6Oj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9hAFlRQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="wCKNh6Oj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9hAFlRQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 96F4F1D00081;
	Wed, 10 Jun 2026 18:25:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 18:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1781130305; x=
	1781216705; bh=FBmsqbmCIRa/0xck9myNXILYJw6+OVfPKB//VVUcAMo=; b=w
	CKNh6OjUsi288YZf61JujQy+oGtrgkOkF/HwSAJC/c+T3wbWReLhGVUpDTuzwE0n
	DOVMLVO7bImlF/QVKCwXZjTqNbS6W4dP3ZMaeEcJ9LyQHMfmEY2PGvH6HCEnNMFM
	czI9WNGhbDY+aVvFy+WuXWRV6xuNVNtJ6VlXuKXmbMRjIwHJ9brDeMferic67ygO
	gRFkKUIGtnBPXmz/sk8kA041DNOXdCfxwVqW/8Ve7rxyaA07YLxfq2F2AwD57BFX
	+bDCaApcP2yDvI5LRC71Ct6qY78PS5gA8CJFspRBV4fz2zTwq21IlkpNDAbNIvVw
	DbdNAVQKvXJesf74I1Q9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1781130305; x=1781216705; bh=F
	BmsqbmCIRa/0xck9myNXILYJw6+OVfPKB//VVUcAMo=; b=U9hAFlRQqV6fyxyOw
	AHBaXN4AD25OkwoxJ+IPV9tJxQ7x3V2eh0xB57NzDZiAO+cnAikJP916H+sf23mv
	tAsW//W4X3fY2bMoTVBALGk7qAexO9Yy6goz+A1bJLDSjutY3Pf7JvFYbUMg62JN
	ANRmr5tub59eXk5FukWEi5dovp9XOjHR3kF+PInSmBpbpkPckR/r7Vr3H/Yro5kZ
	T2Jrbz6vVl3Uszwj6R5U1KKWSWKiwmFWU2PAEOKcRO9IGgVvOEhDqquRtLqp+QE9
	KGkLAYBxPc3Xw5CFYBlY1laI+uLxICu86nv4npjOzE1X5CC7McGIrPd7f/W2d0vJ
	dPBgg==
X-ME-Sender: <xms:QeQpaudwAVcoMORzNhRhsHi3fA6_wB-i5tXisZdH2cDpu9Y7ovXjunI>
    <xme:QeQpauM7lJaGjJHZF_B8R1bllTChz3Gau_8ATifANttgOm0zwZFgCbhEL2KJ3ihsf
    RoDvP6rHFed0i7k-OHk2e3tu122oPqtpMc16-nsL2zR1gaPKlucpw>
X-ME-Received: <xmr:QeQpatJneI6fAnPv-GCZidienTapwKyRlUor27FxCWK1qef30WmaNUPspNVnOpTiYatKd_jPYCg0JOw6gnTgTlcArJkqkqPQeoqU5pphhvcrt2b8Q5UDWu8Shw>
X-ME-Proxy-Cause: dmFkZTGrzKGbv+xXEq4Sgy5YqLKyZa+311BpD430xww9JZyS8UwGL7jvbtDmwoK/k745A/
    ZeWbrd197CoQxyrO7fWe+/sgYAiV6ZAmce4XOogOqSCkmvlNOuFe9h0eiukJ+5IRxex5ha
    TZjrQcifGGCVt9xCMQ3nCbfW9TzqYUzVt1KHLQdy5KfYXbNtrd4an0AZ7TiYEfjuBtepbX
    SL2T7sFIoux+FqunPwD6JJy5pbIqwXM9sJJd3+AD/HdnaeBAfrw0e5wpMjZwVvQ4o/Zpx0
    lzjra5LVTSSew0aDMud8XGL6iNgz79Gf0pzk6Qf4AwIY475l9j/LlU++a7FIXyV817Sfaq
    YxNCAktUIAf/2JQY8CtTQRpmdSRzcXk7LmK1oJ8f4XPfI1uLTvw+chJ7AMRFwUX9xyTASw
    uQXutI8QGma78gkC7l/QuyA1erGIdUj55A1d2QzBXuyLARRPGzaKXLKAmoWQStp70HkTLp
    W/1y8lllBnjbrNF9+7gn5x/Oz9PI2ssmyIPT7ZZYYjzpr2/ReZ+p0NV2jiGzQoC7V2rq+H
    /5MHe+mh76xJai3zsGv92iDUMkavJ/1Ohu/rvioVXyfaHXmGK00haAjMeJ9lr7l/pLR17a
    se9tqRmoTAzCB/cEHqPWifXmFA1qsSRxjIwGyGOI40XPg+sUMGAPfDD1pllA
X-ME-Proxy: <xmx:QeQpanEp_c9ZKWZ_LPnst2jm8FnRGMdpMDqfqE7qmC5zXXflpoO8RA>
    <xmx:QeQpatSo-B052zjXiZNcdW1yJD9PyM_MEhod3IN9UjPH7z-d_QkX2Q>
    <xmx:QeQparFFlkMJsiDmYpgCbMbZ7yGgp7pLz3v_JD3Ta2nb31A3flNLLg>
    <xmx:QeQpah9lWWJ58c0mpbBZWjCQwj5Zd1UEuNIKvM53ZFGihXBdUrFvFQ>
    <xmx:QeQpap3-u2b0Ur0NFwcpFzN2CRl-YN5nhnsHzU1vDKtj8IKpd9AbNZ8m>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:25:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 6/6] SubmittingPatches: note that trailer order matters
Date: Thu, 11 Jun 2026 00:22:49 +0200
Message-ID: <trailer_order_matters.8f9@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_SubPatches_trailers.8f3@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

It matters where you put the s-o-b; it should be last. You are signing
off on the patch as well as the whole message up to that point.

This also makes it clear who added what:

    Acked-by: The Reviewer <r@example.org>
    Signed-off-by: The Contributor <c@example.org>
    Acked-by: The (Late) Reviewer <late@example.org>
    Signed-off-by: The Maintainer <m@example.org>

The the first ack was added by the contributor and the second one was
added by the maintainer.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/SubmittingPatches | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 3d2e9ecfbb8..2045708bdf5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -490,6 +490,11 @@ particular are not used in this project.
 Only capitalize the very first letter of the trailer, i.e. favor
 `Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
 
+Note that these trailers should come before your `Signed-off-by:`
+trailer. You are signing off to the patch as well as the message. This
+also makes it clear who added trailers when multiple people have signed
+off on a patch.
+
 [[ai]]
 === Use of Artificial Intelligence (AI)
 
-- 
2.54.0.22.g9e26862b904

