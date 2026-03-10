Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579B40DFBF
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149111; cv=none; b=JVgh5VtKZH4O12Dkr0KfJayvVNoBOmAACE74RZVwusY1qFH7hzU3yPboB1EtJeNotEJkwUktBQliNvCWTmwstlSSREGEg6FnYLUdIsdse20NvjbtWrgRHWFk44KZR9a0dr1u0L4Hv3FhlSwX4Z3S2bqhABpoIRk1cpiWwRJMaHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149111; c=relaxed/simple;
	bh=8c7/+oNNUm4eOWbJfuryDdmJPq0Gd2mMS1aWKauGOO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8WB+uQThbr/anUliTlTwq8MwNC47Wizl/GPw6jIDl3DN/ng/WWfFLCQFKo/88Nj6Q5pQG1sGVRCu9yJGMkYjLpS+fSB0ImpLgii/4TXLXHULqrT7bSyhos4bz8+3dSF3y5HtvKJ1SnYeOFfgy6sL08CfiUJ/9Tu/BDVSV0z4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VEqUFfXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0POiNEV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VEqUFfXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0POiNEV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86AC714001BB;
	Tue, 10 Mar 2026 09:25:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 10 Mar 2026 09:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149109;
	 x=1773235509; bh=waMTFX/lX2a/RVQvkVhNkhXXf+jFQ1cCeanAItzEXZ4=; b=
	VEqUFfXWCblwlW1Ty2A4L+frmp+a0pc2J9rO9r9QlnKuyFReGQHjo5u3b1kJzbR4
	vWcmKUOvE5BCd1tG0KN+CC0x7YxDHw+qCs8/rFIshSdG96G+mq21hKcJUGOETiha
	jcXxn02bzIWaDwFnX17J7hdZe4sG9e51sir7eykgVR4yjBoHpVBPgis5GoSO+e4C
	OR80CsuKCJ+HuJkGuNgz5IX5tPVgsEvgbVWhq1dwBPC21dwkuDzBoPek9mlpM2Hc
	5rVb9sH0FZ0whV8fQvvShrZMEVfdfXj/NKFvaO5UeFTQexTvXpGVegtKK7LhOqY0
	Ez4cNs1JIE6Ri06iuDKvhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149109; x=
	1773235509; bh=waMTFX/lX2a/RVQvkVhNkhXXf+jFQ1cCeanAItzEXZ4=; b=W
	0POiNEVKOa+bA9HcUza85rLNrOjaOpt17oeL+uiZG5WElAHry/3SzSaflL1CO7yO
	QngfcwEtsuxmrcwRkq0Mn082eY1OeZUApuMGWI1Syl5v0AxT5eRoEZ8KW8mbOxg8
	scYSzHe+v2HUgum6xxORebN2EfL8Qj7Kz6vaHC/7YH0WFJVXNCtFaQkjxG0X7uSS
	336X2DyVzrG3V9eUC9NnzCC8qYRSA0CIwxlXDzckGDC3DOw9q1fPF2HkPkDO1i7r
	204gNU2z4B7tU/ALnj6EcvdcgmCLykaAgC5V6praOyCBPktoqNWWTPqO5az0Wdv6
	M/0hA/44TMUDDphOefh1Q==
X-ME-Sender: <xms:tRuwaQkItubpWnqmCLDNw2msI8blULYMPOcbA6n5sEu1YEYjcJ9xUw>
    <xme:tRuwaWtoMhhvrz-rohfYG9cgDDmGLlMzhOruRh0OR5vSFlsreY_DYkO5_RNq6lt0g
    40p5GjuBtqdo8eliUF0PENeCNZJOOrw6xTVvICHzfxx7g-jF7lrMg>
X-ME-Received: <xmr:tRuwaW8q_Ua7vmPBddKVDI7b0xVPXZGnIwIrx2IRdq3LDLOU6rbqSipZdsmHdvTaVg1sVtMnzgDQRNQL28p-ZTdblHJpU6GZ7EXlIFgz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhi
    lhgvhiesghhithhlrggsrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:tRuwaYP135PUP_K_myJDtexc_SdEfz8U52pvdtZKAgat2DYYA2DCiQ>
    <xmx:tRuwacH3yFCdZ-UnseVvFk-kIPbzeD_BCVQQZARECpc7Q3ceDbxkEA>
    <xmx:tRuwaeQ8EbwTWMpI5AIoswYj23PqzE13HP8znTmG5Z6bUj3nnyDfQw>
    <xmx:tRuwaRsNdcAono4yFJsm4wgs1jvjsBeFH3WIeKHm6-ltH6E9w6Y2TQ>
    <xmx:tRuwaRJRv3Lna9OFTks7a-VyK7QQGwTkWbffOgw0QDvXHWgPl5BTpDp1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1ee110e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:24:57 +0100
Subject: [PATCH v3 01/10] upload-pack: fix debug statement when flushing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-1-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

When git-upload-pack(1) writes packfile data to the client we have some
logic in place that buffers some partial lines. When that buffer still
contains data after git-pack-objects(1) has finished we flush the buffer
so that all remaining bytes are sent out.

Curiously, when we do so we also print the string "flushed." to stderr.
This statement has been introduced in b1c71b7281 (upload-pack: avoid
sending an incomplete pack upon failure, 2006-06-20), so quite a while
ago. What's interesting though is that stderr is typically spliced
through to the client-side, and consequently the client would see this
message. Munging the way how we do the caching indeed confirms this:

  $ git clone file:///home/pks/Development/linux/
  Cloning into bare repository 'linux.git'...
  remote: Enumerating objects: 12980346, done.
  remote: Counting objects: 100% (131820/131820), done.
  remote: Compressing objects: 100% (50290/50290), done.
  remote: Total 12980346 (delta 96319), reused 104500 (delta 81217), pack-reused 12848526 (from 1)
  Receiving objects: 100% (12980346/12980346), 3.23 GiB | 57.44 MiB/s, done.
  flushed.
  Resolving deltas: 100% (10676718/10676718), done.

It's quite clear that this string shouldn't ever be visible to the
client, so it rather feels like this is a left-over debug statement. The
menitoned commit doesn't mention this line, either.

Remove the debug output to prepare for a change in how we do the
buffering in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e8c5cce1c7..b3a8561ef5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -457,11 +457,9 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	}
 
 	/* flush the data */
-	if (output_state->used > 0) {
+	if (output_state->used > 0)
 		send_client_data(1, output_state->buffer, output_state->used,
 				 pack_data->use_sideband);
-		fprintf(stderr, "flushed.\n");
-	}
 	free(output_state);
 	if (pack_data->use_sideband)
 		packet_flush(1);

-- 
2.53.0.880.g73c4285caa.dirty

