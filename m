Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F53630A3
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384330; cv=none; b=kvkMn0UeGxkMR/6VCYNnMFsn7xRNBbj/HmlYFePlJw5jFl1rSpcMekyrqma/+ZHxIHoYGSXIVELdv2QlnbuxCt5jD3hon4n7CYWyxPvTbtGPnec9bsF++rSyqS5y6czmGYwnPP6svOmYYYYCrM1IsF81/0vKDi8xWXfdD0EFKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384330; c=relaxed/simple;
	bh=Y6S6okaOXbWT5I2BivvYenio9rpGWWbIGQdr78ih4TE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqZ6NoBOcIWc7NxCuVoG13emh7gVAisSYzL7UDyuMTDeXrcB0KvVcvKpYJwZ3Kq9TIbjNfh0Wq7jcRe/G+l2/2D3x0ygct4FXTHRCy1CLbBbgQdj0fpLo3RicsqhaMf12XQMPaKXP+M7s9bwfqSabohhSbbKrgtBr0so0VVrSoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hwzo7XHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmJ0eccm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hwzo7XHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmJ0eccm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F6667A0099;
	Fri, 13 Mar 2026 02:45:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Mar 2026 02:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384328;
	 x=1773470728; bh=wVLpzr8g2onEwM0+mKLlJxSR7+3YclTmzFJkexHcyCA=; b=
	hwzo7XHa72c3/tPG2wVifKoB4WBjbpsVMLcIOMD7c/tPmHDz9wOAoLToih88+Qqt
	QfZ0rDkaXfeLUO0jrAYqdKTT2hQJp22ynmEv7h5QcbvpIGCByhEMVPrC/8tWSB/j
	JWIzlkq3T9dcSSNJyP6z060l3kHLiF5oCraZXcewlpF8h2mzx29Y0n71uHqmS7ps
	gJBEDONjOkjvffSkIlL8UtCtsgIrRzVNy2s8/6Q0LmZ65kgA9jWxjoW8GYL2TWDS
	qOPiBo0p6CApm8lzpGGVuxP3iaGAJfSfgJYntnUz0wC9b1QxDMNMbZzGcbtGk06J
	kMUeRC4BcEamtVf5eyhVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384328; x=
	1773470728; bh=wVLpzr8g2onEwM0+mKLlJxSR7+3YclTmzFJkexHcyCA=; b=V
	mJ0eccmuvS85rG03Trek5I9EaB04ONMW9xw7TY9Kuy41gxIoONPvzH1AYakQPmpg
	qxIaMDpYw0Mf+xJ007dZ46+ByznxjEH9m1kDCYx/jG9oDNnSZ9oC1by9vwh1WOpU
	Y9naC7WpRpE7FJ+AsjDdIFI8PV6TWeLuv8nC4CQIsHggq1KGwbD0EHepoeXPxY7m
	QOyLJ0AaZ8VkC8SmjpSuQZoSOcJg8cz+nGw7W/lSXngIMr9Xe4NXEgBYkVwQ7yPK
	j0ENF2eO6c5XHZt6DOVTTY77v7NuNiT/WkajSbwGYs3b8Qbffy/kLWnagbsVLNHg
	qYzR9mIgA6WFaI+4wFPHw==
X-ME-Sender: <xms:iLKzabvMdZZMo_CHiPS5p-asEDPGO0VFg_SaZTwUDqUh-ea0LXHpFA>
    <xme:iLKzaTUUqecEKPu_qaPbhexKnZKGMMYBY_VXmlt-340GpfTc6Oz78gEN_55igtuHJ
    kxauERVFwFR1-CmztAonGVLMsh9J3YT_VpGN6wrP5hOBu6zYXMbOA>
X-ME-Received: <xmr:iLKzaXHLE8VuAdy8FoGP2KhdUL8KvJ-EiGzFK_QNPOhcZp43KFwDa3dppZN4rrqoDJ2on-ERb19Wg558F-94GPWNWSsOyPmg4aDgySk1Pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilh
    gvhiesghhithhlrggsrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:iLKzaV1PAsKkLcI04GTtRtVElnULys8m8WC8OE1zlbrm81QFiKJkzQ>
    <xmx:iLKzaZMVG7NZRmWI1rCVYNdj4wY4p2xiqijxztrPnnQdB8327S0Egw>
    <xmx:iLKzaU6bavkXMOB2dxw4J8Pp1izx30otWTvqgRkB7cbEcomXOk_LJQ>
    <xmx:iLKzaT18DSCtG-DK6YYQbQ6wxuKflndxCk1VpUM0IsJIy6iopKCAXA>
    <xmx:iLKzaaDrs9U7Gi3zzOQkAdGoj5MLGukt6HuizigzbH5WLjxvCSwHo-Zx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c582244b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:14 +0100
Subject: [PATCH v4 03/10] upload-pack: prefer flushing data over sending
 keepalive
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-3-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

When using the sideband in git-upload-pack(1) we know to send out
keepalive packets in case generating the pack takes too long. These
keepalives take the form of a simple empty pktline.

In the preceding commit we have adapted git-upload-pack(1) to buffer
data more aggressively before sending it to the client. This creates an
obvious optimization opportunity: when we hit the keepalive timeout
while we still hold on to some buffered data, then it makes more sense
to flush out the data instead of sending the empty keepalive packet.

This is overall not going to be a significant win. Most keepalives will
come before the pack data starts, and once pack-objects starts producing
data, it tends to do so pretty consistently. And of course we can't send
data before we see the PACK header, because the whole point is to buffer
the early bit waiting for packfile URIs. But the optimization is easy
enough to realize.

Do so and flush out data instead of sending an empty pktline.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index f6f380a601..7a165d226d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -466,18 +466,27 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 		}
 
 		/*
-		 * We hit the keepalive timeout without saying anything; send
-		 * an empty message on the data sideband just to let the other
-		 * side know we're still working on it, but don't have any data
-		 * yet.
+		 * We hit the keepalive timeout without saying anything. If we
+		 * have pending data we flush it out to the caller now.
+		 * Otherwise, we send an empty message on the data sideband
+		 * just to let the other side know we're still working on it,
+		 * but don't have any data yet.
 		 *
 		 * If we don't have a sideband channel, there's no room in the
 		 * protocol to say anything, so those clients are just out of
 		 * luck.
 		 */
 		if (!ret && pack_data->use_sideband) {
-			static const char buf[] = "0005\1";
-			write_or_die(1, buf, 5);
+			if (output_state->packfile_started && output_state->used > 1) {
+				send_client_data(1, output_state->buffer, output_state->used - 1,
+						 pack_data->use_sideband);
+				output_state->buffer[0] = output_state->buffer[output_state->used - 1];
+				output_state->used = 1;
+			} else {
+				static const char buf[] = "0005\1";
+				write_or_die(1, buf, 5);
+			}
+
 			last_sent_ms = now_ms;
 		}
 	}

-- 
2.53.0.904.g2727be2e99.dirty

