Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE302399D02
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356124; cv=none; b=aop1HhvFhuYifUCikw625VDJy1zqUkZMBvuP5HUJgjZTlzPOfBE7e83AtPQ6eaeaxcLiP7Ghp9eCnQcbnCPJezBNRC/gd1JMyHfQkbys2FxnxNtzUbMPSIj5tkuLnRLG0cPqsnnBXHi++Tt5a4BQTwDVPfuNYjGe7oRuC5vyIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356124; c=relaxed/simple;
	bh=5fJfsKhP2gcnHy7KKiOUiaS6IIAUfV+7Ihu1D5XwQGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nioVwNqIfRobj6pTZrERnBxDDnfhVAfiQYniift80cQFYga0X27ZQcQMXH9Z7chGswcG2i1bgzjvNA3SBiYLhY5Uxtlxk6zXWpxDj/c2gDdTPHv6SKA2xZjeSkvngwIQeWF/c0RVlAXW4vbZngss4F0iAYxZ67N3b1ntcEV69Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hsu21ipz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u2glQMco; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hsu21ipz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u2glQMco"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5F847A011A;
	Wed,  2 Sep 2026 09:35:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 09:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356121;
	 x=1788442521; bh=yfrIIl6h5COz+C5GPro6hzOpqICSN0DFRp3rLh1hI1s=; b=
	hsu21ipzwPldG93PVFkJTjqul9lEj6c2/7rvpMYVFzE3dVS2b4XZkm+t0YtcEe3Y
	ySl2ED2MXNgWRm3EwRvsee/e5ucZXF8tRZT1N785HVxDOXBw7lHXFMKGYHm7FrLm
	6totXMsekbqwG9zRcEo4Ef49i+jjfTCINbUaKqlZqWwylQiYfDFqozUzpL8JthUJ
	9agxP2QSQ2n3hDDcatprXiFXNRsxgG1lX/ohtESoydHE97jJEmVc4SkHxtqU3Wip
	EnKZ/1MMsF1i4qsjn2hsR9L11oCM7SxDrNRI0ApPcae08Xs9URvI8rln+vM4BBOm
	GlUUFkpbCNgLe+RbnKS5xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356121; x=
	1788442521; bh=yfrIIl6h5COz+C5GPro6hzOpqICSN0DFRp3rLh1hI1s=; b=u
	2glQMcokpWhlNvJAAoppvTrBV8UPaDXRkeQCNCj0DmUXfIfTJ4SqktENguwdhXea
	EI2WBAuK2BqtQce7dir+dV1YkcyR8IJicKr27MXPGaTCokuchKe/VG9hbttAmFIb
	ORip+bawTodvv2xTfMLuKXwJwnsGyRFIaaxflfBIufCl5I6Cs85ohpmp3a//PGEH
	WURR1ahb49HBJ/G3TCvJ2l0MOMNJ1O3mxxJBW+VTfmto6mXRw8Aa998BIYJ0YxrQ
	kEOTWFHstSzjGwWkrshmSX/DI7oF3YlXecVZQTAirDHdMUMic8abXKoJLUFCBbmz
	B5dIP26m9gzJbPxoaG3iA==
X-ME-Sender: <xms:GSaYai5O8Xalo1JfVYj2ORuJWEKXxuzhxYNVeVMcKKcWdepAaM6uiA>
    <xme:GSaYah499z9yZIWkOX4UwvjVgt0jobgWaOHcnue8_7o4fj8epiYGeBHbMnVpSrbL6
    LEec6C-TKMvIfCh3T0CIDGXwizeiIDvbKTKglQvLz0GSk8Pf8ckqw>
X-ME-Received: <xmr:GSaYavHvHu1kBssLucdx9dHCZeUuTCjIkTeIMBj0rV1-phZ8Z4cUY_rWo35g4_dHdqxgsxY>
X-ME-Proxy-Cause: dmFkZTGarp81zQ7N+tVloiKE1UqEKo0TVx0DnqHMpG6tMyQeDzUmcFcqTqyBBzbj/dcO5i
    LbwQfQxzSJ/F7OuO0073mk61IQ/Y8QnqdvT0Cr0J/Ktw/2nNIdZkmNKQbG5Lv0TtSadPXV
    YJt6BUBe6YFSCSD1qpSFa/W35EhkQFVZ98mE1SmX6MccP/ThCItsxEprn1+jCE0GLkhjxp
    eKRtFU/89dfPD68WyuyQKALyLXoqw1wCy6OPvHcwWR8+2ZpQeL7r9dqYEF6p6YoRGIlX8w
    o8emwGeKpvI/scQeTi2FSXkIEvCq8KSzb2gwGhf9Hz3p6vR0ZHYB0fTSrgYYu9P2x0jiEE
    WZ2xYZLWKguv78f3QrBxm0Kgbig5Vpf0WW+/hHZNseZOhKIwKpjKtmxVUfeVDjEAlTl102
    X0GA3aByIoC51sSbBXUn33MSQ0PqZVRA8zzJmmsrzPst/6VVp7i7kKx43fbvljTjZ/i31u
    4LYLaiWMNEWIjztQ9GuXsiXw0F5qNr4PGtMz685bgIRyu1s/uNOkkKgsGH6AEbWOTYsDhw
    s4nUbBryY4575nLgFTEzNfoBT+YxpHDFLuekBvQgP9gAiBnUjLftMuWAe57wJQkbsc7jlY
    oRl766iS7Wh3Rs2XaRd2rD0mVkoQgH2BOiZL5CqdlRrXB3GxrNFaw8myA2yA
X-ME-Proxy: <xmx:GSaYaqT4xBkLsXy3z_Q-rXrTjnLvVPcYoySxDy_hniw7gLycNs4s6A>
    <xmx:GSaYaouzN0mxcjWaHHBc-_Wd5ia017fYrzAQ-QAhtsByOUPfaSKMTA>
    <xmx:GSaYapw_wuOcX-pwl5Gm0SFcEzi1X8ApNcK0HoRLPNp2V2n3OLyCmg>
    <xmx:GSaYai7wP0aHoDbKcOM1GrPE9ov24zG0ahLj8WQnJ79a1lX2wq4wMg>
    <xmx:GSaYamQLnxxvmHVol5tCvhCwusaxazKiwvzH23R9l0LqxgH71_qkjwOO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7f0aa99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:57 +0200
Subject: [PATCH v2 09/13] odb/packed: fix memory leaks when freeing source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-9-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When freeing a "packed" source we don't close either its packs nor its
multi-pack indices. This can cause memory leaks in case we create an
ad-hoc packed source. As we used to always link packed sources to the
main object database we never noticed this issue until now, but it's
going to surface in subsequent commits where we stop linking them.

Plug the memory leaks by closing the source first.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 1d90e714e6..166e76e2d6 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -844,6 +844,7 @@ static void odb_source_packed_free(struct odb_source *source)
 
 	chdir_notify_unregister(odb_source_packed_reparent, packed);
 
+	odb_source_close(source);
 	for (struct packfile_list_entry *e = packed->packs.head; e; e = e->next)
 		free(e->pack);
 	packfile_list_clear(&packed->packs);

-- 
2.55.0.979.g7e5102b832.dirty

