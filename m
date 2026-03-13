Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CA51A6832
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384326; cv=none; b=hwuWCW0OzDfT/yC+X8wm9dQ3wh+c8chlHefGVm6bWOvk2Qe7CoDvwXehXLiKZIUNLzCYZnCScDMt4kILbQlnNy3OyU6Jy9KV1TsMsdNDDNuBjeC369fTIa42Spu40Y4/VYiRtnNcKsLo31jObQ7sR3HzLEVjEi2sLSlGErZypGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384326; c=relaxed/simple;
	bh=En3QF4qc7FjO8ZJx66z4NbkIO0GPzrPRtKDFzqL1Rps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQk9H06pXXiQhf75lSXFnU2CNg9r/vq7oz0vhsQCwFjXafgyZqG4KaHbeRZwQeBL2DukL/fgTGMGiAe57noolMWNgF/d94l/3mDN3+pLlnCTUPuF8cSuvI70mYa0dvq2eudlPMkqtPVToCxcU/CcuqBOhMfEGE0qAvGxtgyVwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k7RUb3eD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q1z7DTFg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k7RUb3eD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q1z7DTFg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E11127A0099;
	Fri, 13 Mar 2026 02:45:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 02:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384323;
	 x=1773470723; bh=JTFTxi4xNKwZMvZhQXpIhEKDHPjTKyymiA6YzliBHKk=; b=
	k7RUb3eD+x2hDwdYWg0Cseo6LNmPwfeEiCgM1t715cXCzrknPlpop+p8g44vXW03
	RIDbis5B+1xkGNbNw8kd+KKBbKG5hSvzVLQttXFm4o9lAVVrilDha1EmuCd416Lj
	PF4NTYcsPFmsLpeiM8OweLUMY89hdvop711lCjFoxRk25RWxOUfBooilZhVEGsN7
	dgxLESoEIe106EKaoo27oj1SQlWjlDjcsUENZIqZsM1EHQowH34qfi9QuSLv8luf
	b0rKz52eSh1zbxwwoYWvt8fr2nIFx711FkqTpG96PfTstmPkd8NnfXsOLHtPexRC
	kz9kB9O5APOG681kqF3aXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384323; x=
	1773470723; bh=JTFTxi4xNKwZMvZhQXpIhEKDHPjTKyymiA6YzliBHKk=; b=q
	1z7DTFgR6ogpq41D1D3nMQnStksMuEI6p8Zl+oCgKgTrhoAT968/k0yj2+Dins4I
	JGE6lJlZULwAhGhqjajXWc8WfdERKz4gwzU4zI5zd8b35s4A9v1mg7ImIDVFITi0
	XYoIJbiXGbqJ1/DJLB+4PEf4BJYMF+tltDDQfzsWgU8/7xTrhKY6fQ7O+FR04PMY
	Y/kbTs2OwcPjJW5XNGEqnE/wmfEIm8bMTx202ldr3BlTx+rgTo5c+KJM2ORgRhpj
	dxC4ZplV7U2vqfJeYDyg0ZC36Sm+zmz7GnKA3Ob7oF1ig9HZ2RJCB/Mget3KCJgU
	vi8nwc/FCnS+EKvvMgMKg==
X-ME-Sender: <xms:g7KzaVxWfkVp9Fa1PNemAHbBISdHs9peJl7Z1QYFYbgKXsrqKAgfaA>
    <xme:g7KzacJTXpgAqiTS99tahWa5V1_QNbntpTGwbH7nK5OK81PozQxg5rdLjVUoTn7IC
    h7rILc1BuBTKW5Yji6aLvcrd8un4Qc1U777_ai_GyNbkAAGx4x89g>
X-ME-Received: <xmr:g7KzaXqIVLWAi6kFmAxovOxQbvThNSHdJV-bCd63nSJ8Sr_-xEIxr3iuau9zvyC8Ml1y0mLq860jPfn6nuLaLaYwbiP8QO2UIJaf-H-kyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhh
    phgrshhtvgdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:g7KzaTLitEkWz98XXNnuQaulsTUomtU8KcH8TgnasKOpy73B3h8Ydw>
    <xmx:g7KzaUT4avyxfZFIQpvvweVfRDTqpC89tInrNrt79HtXL1lyG7SNDg>
    <xmx:g7KzaasmRW92jE5ajjVr2auAoeV3MPU81mNBZqsUa2bt7XewhSU9dw>
    <xmx:g7KzadZgDMc0y9qdtj2DgoX8uE3SvPHsNSB1xojCjv2_9j7Lx7KOTw>
    <xmx:g7KzafoymBth1PyTb5l4Op96Po459Y6TWfD84z-mEYLBlJTjdCCsLpYI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17b4aaac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:12 +0100
Subject: [PATCH v4 01/10] upload-pack: fix debug statement when flushing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-1-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
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
2.53.0.904.g2727be2e99.dirty

