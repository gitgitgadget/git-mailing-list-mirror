Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375DA47DD4D
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550040; cv=none; b=cNcCY1TCSeNIsqLeYULz9T/wo6QjXHeokZBTznTqOexRF0kFjsG1Hitd0qOs0hhqRhJX0+qNsH4hUCdlZUsyfWUlfokj4b1m9mwfAaKz4n7cxSKCyF/r1nOsbPyYabLvP1fsGsFkGGCKi09jOScyC61wvw6yOSdP1j2RPSz44oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550040; c=relaxed/simple;
	bh=9BOXPdn4QY3jyR/2GhSrQaYI31pASAg2AyoF/RHaO28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JnDTwGc76SOXP8PQKA25Evie5gDShzkvW8FG9EgkWWxVPWZbs4HZO6y6eu4bRHaZFxJnrq09/AXfEJT63rl7Lf7f83UnLg35qEHY3wlGxnJNjtzO3D8jMggrZJA+cPM2nhj1BwNgGjDTzXEgK2fD0BTdCY0ueZVEVwe/YLeIXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=edNvAxLR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ohf311JT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="edNvAxLR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ohf311JT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 80033EC053B;
	Tue,  3 Mar 2026 10:00:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 03 Mar 2026 10:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550038;
	 x=1772636438; bh=IcA5PAytsUFn0ATCULuhnQ7fVdhTw4GhW3Xvnqu4oH0=; b=
	edNvAxLRuEAo/+xUj+yBuB9LglFHnWX/ftHrq2lXdcgYOCbii76Lrc212KUzGE8l
	gE30+TKR9MbwxwDdgOnmFDQMlUUMVD3RJYlhHFD4CVryLqQCKTMQUYQWbHAqpMFp
	lviW/rYXpbMDKdodLyDavlsik/0n5JgBmgz02MXqOt9grsrkPsXy6tWXb4HZKAb5
	MUENAFDWY9Hkg8/LJOHwNhG9k/LisEOHkp3irusqx44DvfL3sYbaPAv2TRCnwbcT
	QfioeVqaSpH6vtoxVMnpm74W/Pl49/aMUtTnGh0eCJT+eC4NvdisX82LSk0SypR/
	4zKeZjmAdOXRins0pJL75Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550038; x=
	1772636438; bh=IcA5PAytsUFn0ATCULuhnQ7fVdhTw4GhW3Xvnqu4oH0=; b=O
	hf311JTicltlSeYD0oMOwFKs6ve1BxPJ6+9OcdYtIGFE4A+I4FybvE8+azBKNmYj
	0UJ1X1YvRD7ZJsM3NsnNDvLDucUb8SzzYULdjCSY28QJPvWQAAgY6P0f/2QQTOFn
	WPM36J6DqdLFutLku3qkCkjwLLiU9Vi3rlPgS97Yd2cRV/qboZkWnkSDRIAPwCJ0
	WnusOEZENVos8kzof1uDrY8jTaoZRlffrv4xY92u8Qb1rJ1G6kknYiPpnzc8MdNt
	4qv5Pd9tqupRgNgpybPu9CWAkhVri2C9nPjhBBzsMBtdKlAjyEIMpbjNmM2Bj431
	AcrO3pAPLs9V0k3M2yuYw==
X-ME-Sender: <xms:lvemaTEEEP2J0MJY0457AxTJBwsF7qBVMkVaIXq6pkokGWZXo0pVqQ>
    <xme:lvemaXWP8OFKAaC3umBe_-rjngxexwnYTT6a6_dW8N2orFTNPsEGHmDJTjuLHCqNb
    KNt24gsWnQH-8V5pgGAImsqaj7kY0uDb9TSMpUULCuWgMH1UxR-jw>
X-ME-Received: <xmr:lvemaaJAFni2YMw56u0lkpgvmKacv2JLgpq3gFQ81CIKlvcD_raIkYv2T33W8xjpfj_qGXqzYMzADluKe9xhlkLWDbqPQDsrDYiSDk8oi13c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtph
    htthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:lvemaf8eAwqRPM7128J6UpFMiGivYo2rVu41P2imE5IMoLbZro1AjQ>
    <xmx:lvemaVKCgnPIcuqXv9qfVAJLqgDRxm4fsWMLAddKavr8bvcfPZo89w>
    <xmx:lvemacl21f2juak0ipYwJh0sktlZfndHKLgjEcNnkb5NVROy6zcY3w>
    <xmx:lvemaRM90zPE3TwabD2X2nnW5ghiFg8aQIQK2NUCbrXQuuJV4USO4g>
    <xmx:lvemaSijc0lxfGzk3sg-p4QNAlpOYF2rzmW_g_Ssg-pwZlnkv-It5gp5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 894e9e97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:18 +0100
Subject: [PATCH v2 03/10] upload-pack: reduce lock contention when writing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-3-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

In our production systems we have recently observed write contention in
git-upload-pack(1). The system in question was consistently streaming
packfiles at a rate of dozens of gigabits per second, but curiously the
system was neither bottlenecked on CPU, memory or IOPS.

We eventually discovered that Git was spending 80% of its time in
`pipe_write()`, out of which almost all of the time was spent in the
`ep_poll_callback` function in the kernel. Quoting the reporter:

  This infrastructure is part of an event notification queue designed to
  allow for multiple producers to emit events, but that concurrency
  safety is guarded by 3 layers of locking. The layer we're hitting
  contention in uses a simple reader/writer lock mode (a.k.a. shared
  versus exclusive mode), where producers need shared-mode (read mode),
  and various other actions use exclusive (write) mode.

The system in question generates workloads where we have hundreds of
git-upload-pack(1) processes active at the same point in time. These
processes end up contending around those locks, and the consequence is
that the Git processes stall.

Now git-upload-pack(1) already has the infrastructure in place to buffer
some of the data it reads from git-pack-objects(1) before actually
sending it out. We only use this infrastructure in very limited ways
though, so we generally end up matching one read(3p) call with one
write(3p) call. Even worse, when the sideband is enabled we end up
matching one read with _two_ writes: one for the pkt-line length, and
one for the packfile data.

Extend our use of the buffering infrastructure so that we soak up bytes
until the buffer is filled up at least 2/3rds of its capacity. The
change is relatively simple to implement as we already know to flush the
buffer in `create_pack_file()` after git-pack-objects(1) has finished.

This significantly reduces the number of write(3p) syscalls we need to
do. Before this change, cloning the Linux repository resulted in around
400,000 write(3p) syscalls. With the buffering in place we only do
around 130,000 syscalls.

Now we could of course go even further and make sure that we always fill
up the whole buffer. But this might cause an increase in read(3p)
syscalls, and some tests show that this only reduces the number of
write(3p) syscalls from 130,000 to 100,000. So overall this doesn't seem
worth it.

Note that the issue could also be fixed by adapting the write buffer
that we use in the downstream git-pack-objects(1) command, and such a
change would have roughly the same result. But the command that
generates the packfile data may not always be git-pack-objects(1) as it
can be changed via "uploadpack.packObjectsHook", so such a fix would
only help in _some_ cases. Regardless of that, we'll also adapt the
write buffer size of git-pack-objects(1) in a subsequent commit.

Helped-by: Matt Smiley <msmiley@gitlab.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 04521e57c9..1b1c81ea63 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -276,6 +276,13 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 		}
 	}
 
+	/*
+	 * Make sure that we buffer some data before sending it to the client.
+	 * This significantly reduces the number of write(3p) syscalls.
+	 */
+	if (readsz && os->used < (sizeof(os->buffer) * 2 / 3))
+		return readsz;
+
 	if (os->used > 1) {
 		send_client_data(1, os->buffer, os->used - 1, use_sideband);
 		os->buffer[0] = os->buffer[os->used - 1];

-- 
2.53.0.697.g625c4fb2da.dirty

