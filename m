Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6336C0CE
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191622; cv=none; b=AOMyNWrYqSfarA9cJPb5NExXkL8lmTnP9LYObZm3teMnSQPEya4uBtrBmbav6CWKPhta1YyT5/QyNBKWlMnUuQlFUb5n6IdVQkyZmulAp63940fjEn7Lp8K5XEKt/t4qGY3ZHDhqR+1+rNQc4CHgphLsKbjk3x6uKD6bYzaaNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191622; c=relaxed/simple;
	bh=tNceN/V6d5KOtiB6Ve4C3ynAZdAyfNbFRh/p5r86baA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r35kDkEjbX0LTHo4DqyFP+fZIL+bEG3ESmieJ+ScijlYO3CzhS/Oz0+aYKiWQ1skBdoKoxGLjU2KrDe1vZA/6N4Nw6oSPChC5M5b2UcP3gNfo1fecXvQUcDNWhSlmyHt1JyE8lfHMWCg4+KkKJh+J5UNVzy24HkjV8hpSM+7XCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LXR12pHN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+cOEK6T; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LXR12pHN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+cOEK6T"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 401671400268;
	Fri, 27 Feb 2026 06:26:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Feb 2026 06:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772191617;
	 x=1772278017; bh=BErvaq6t5S7T+XELP0YVBNIK6o4lvjpB4jsaFW10WFk=; b=
	LXR12pHNOKrzc6ohY1SJ4aI2bqc7iAAlKXQnjrDFXyunqLTgV25OzveEpVA7ZGEW
	E7eNu7oZMaWvSwwO5OfCtJJZ7khkHsH3zCfpMiHxQoBmSGhP1nVC3h94bbwnlgL+
	NADYxBiawZ0tlrPuA9Lg9Qb1HIIVCFNxhtDdSsgyGUhhwqef46NQnxL0jKsS2UNY
	j8RQpNI0KUU1DT+Ej1EZJ4B9fLTIaVKgqyZxgEor44yaH3/YlH1295mrVQNa/PNG
	DUcNKFZ+qh2CDTrE8bZBWOqk0wh388jl/McfU9RaRzluX1K+o6j+sVTzTQHbtR/s
	fPBfsoOWK+Yh6X/n3HKY1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772191617; x=
	1772278017; bh=BErvaq6t5S7T+XELP0YVBNIK6o4lvjpB4jsaFW10WFk=; b=N
	+cOEK6TP6C6n8HacdukIOsXSbBo2wcyQPVJXJnHpnHJBq3Q6MpVHYMGTG+3Kf2lA
	czizDt/99jboYS2fgYKYGBe9PC9tv9eg7CMXtCntMHhXcQHi9+ItLODqxaFilM/O
	BGPxB7mW2+pNXMWkpjlduJeJIWAU+ntqgi9QTF5z1Lm106DuC+QYGi1yX4an/oZh
	1qAqNOPF/59iIWquTX3mL+CXw3GzmBUfJgpQh33TD9UXFuLyHUBpjavZRF2clSwX
	sLaqyTVj4tP3YsYdiDziWDJBUTTfH21F0fdsr/B/bPA+dBLIOIPgNwTJQsg0/0WU
	qXmUoGF387nX5fLrESqBw==
X-ME-Sender: <xms:gX-habhzb0HmkY75no0RGN5TIOjRPBC8gRpIhCDVK6iUYygn3L0YYg>
    <xme:gX-haeA0nxT1jG90ugC4r8gTdMZXAk2yLPwo85n-moo86CdkAx27GtMcnFtiq7lGY
    mP4_toxV-mWK4_xTorJ61GV4OQnNO3QBIji1kSqsHjA8Jq-5E3RZw>
X-ME-Received: <xmr:gX-haYu5EwReiKhA0ID93QrWDbu63dRWBO_BGUiXLmLLplJu3N02LCF39X4HEIiDjNaB5Dwfk-ALs95_Nma3P3a6mIt__TlGc197qLna>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gX-haTYrFzPb6YWbvSEvTammRXqqflTirm2NTnvOAAQC4Ws84vxwow>
    <xmx:gX-habVnPiXfbtNKwyhbLPEYHvN0KFQ2tkmCsU3OCSF41X8IkHsyxw>
    <xmx:gX-haX6xMhtsjEKaMiwsemQ8ZtXHw21aMj9UBre682nHboyNEGmRNQ>
    <xmx:gX-haWh5yd95BpYP1g6z-tpOJ7gnZG4NaLRblZpn7nfLUc8hyS0OmQ>
    <xmx:gX-haTTqBC19BcARvR7UzStd6OLNgQMmlKQLzVR0BCrASmulwrg1Zr0n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 06:26:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95acbca7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Feb 2026 11:26:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Feb 2026 12:23:00 +0100
Subject: [PATCH 1/2] upload-pack: fix debug statement when flushing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-pks-upload-pack-write-contention-v1-1-7166fe255704@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>
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
index 2d2b70cbf2..c2643c0295 100644
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
2.53.0.536.g309c995771.dirty

