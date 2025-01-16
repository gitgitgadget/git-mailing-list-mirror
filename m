Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0601DBB13
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019050; cv=none; b=ODUyOhQRs3jZp1QT7ubcMplVO4SdSHJXvyCJPOn5rAN259HedSrNX1o6uV4/tuZBrmIGEhv3NXQLzmCY34JOyFCn+HEOpuj+rEfsXgtPbC3Yf6+kus270XlJ/a7M80LQpFxoWtKoEt5saEPjeOe8b1PavUH/CRwuqWPl4L2wfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019050; c=relaxed/simple;
	bh=cH4Sv/OVLRYMiFagRjQkXaEcVVVd0aBrLzw6++IbwrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hngkUeV8XGG+fNMXq9xhd4An2b08+2z9ZRAmKka01WKI/l1aI7zkgnz/l0uzGa6UfpegsbphZ7RIzLTejhEi9uxCi3IV02Ya0CWVrxOW3Zh5Es91FXSPkLBz0xNxAedQLGqDOHHoldU2UuJv/4TwcSXqNpyaPyL9j0BqSButn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ruLTCueo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qgXcPF7Z; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ruLTCueo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qgXcPF7Z"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CDC781140113;
	Thu, 16 Jan 2025 04:17:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 04:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019047;
	 x=1737105447; bh=7pywyglqqnX+PIKerGMq1M27gsgga5P9iOJeOmdB8bQ=; b=
	ruLTCueopsyzhf7r1gvBXzRIb98K7CI1SECiT8I3vZXtR3yByHHU/MQmLF67cMDk
	StE6WhxKvd0KBXtlOI/m/edUQVGPphbTitSEtjXrEU79EqeLI3AdhaIW9i03/BX7
	lAK82BLz4txje3Ohjr+0s0B2uoma2hAuORCwtbceQc4A6qobqPJ3kXRu2BqVdY6U
	lbytS93cJVygWeyh0JIZlzsAeVOVO3fpGmIdIovP68FCo5Z9vq+lL3Eped0a9/dO
	YKLfc9AAw7GBkbBua7HcTz2Jp5nw6mDXEB4j1ROwALURtoJIlDlKXCQSpjspVtob
	Rqh9w4IAWQgstPMp+LpiYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019047; x=
	1737105447; bh=7pywyglqqnX+PIKerGMq1M27gsgga5P9iOJeOmdB8bQ=; b=q
	gXcPF7Z0qRjzX+csKfgnyJFkRAOte/Rr8axEiCTd+JwjM3VfMX3ouYO+U417eQrd
	YvN8yc/pRIB5CUixSYMjpolbYPluHaFsPI1VfitDpBXrFKfU5jYIaUgItC5CMOXv
	dBFZofVmzoNdTkPumfLeud4H25UYmJGnBGNb7P6qwaafOWONaXF5YyFRsqusnz77
	g9PBiD5DIP7WLS5b0rj2j2eBAyv2W03G+AeSbXcZQ10KiFVhgvRr4/evQoWUT7aO
	aD/EmkG/c3FSnjCpMD3wspDESv7MLM6dLHHP39cv7XrI+sM/IVyDtBDKgLTgDPnJ
	u4fU2K7CjjDe93sbRT+ug==
X-ME-Sender: <xms:p86IZ7kRFifoK3jPjlrCq6x2clWkTMC9EBb7uEb1gYWYeMh30sOWmw>
    <xme:p86IZ-3d04QH_XtwS1qplfuLDmr9sT0prhB075gVA1B_Lg4nawIayElyTT4qC0FE2
    oVsokflqh6hcchbzw>
X-ME-Received: <xmr:p86IZxrEdPtiEjui3CSltwv0z3BKM7F1QDr-0qrTXVSGWTbwTblza0D98qJHqiJssiemu4LLKUOKiWl_VhDs23xWHi523G7Azbm0BF1_3t2FmjWyUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:p86IZzlHwpE1h-TRYAQdJ01Kr8S7dyLEkZIaEpLOWW4DAnLWKIIBsQ>
    <xmx:p86IZ51Nhe7Z1FcEv-R9QfsGR3dkV8Cw8uQHq94BCPhKLjFU2-om4g>
    <xmx:p86IZyu2H4YaKZb0oRItmx6jYXHsf625gC-dLjYh1j4mZ7rrN1YwBw>
    <xmx:p86IZ9XDbEULvcu1pWDDiwzpGs9gX94c8GznxaBsJjf5iDO4PX0qPg>
    <xmx:p86IZyyWGut7JX41EMpppTdSnnmlJGSZffo_HVypXvQ0hlviHOS2VDDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27633606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:20 +0100
Subject: [PATCH v3 07/10] git-zlib: cast away potential constness of
 `next_in` pointer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-7-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `struct git_zstream::next_in` variable points to the input data and
is used in combination with `struct z_stream::next_in`. While that
latter field is not marked as a constant in zlib, it is marked as such
in zlib-ng. This causes a couple of compiler errors when we try to
assign these fields to one another due to mismatching constness.

Fix the issue by casting away the potential constness of `next_in`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-zlib.c b/git-zlib.c
index 2e973320c2..519b3647ac 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -59,7 +59,7 @@ static void zlib_post_call(git_zstream *s)
 
 	s->total_out = s->z.total_out;
 	s->total_in = s->z.total_in;
-	s->next_in = s->z.next_in;
+	s->next_in = (unsigned char *) s->z.next_in;
 	s->next_out = s->z.next_out;
 	s->avail_in -= bytes_consumed;
 	s->avail_out -= bytes_produced;

-- 
2.48.0.257.gd3603152ad.dirty

