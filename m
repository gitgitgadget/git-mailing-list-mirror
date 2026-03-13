Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07643603CD
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384337; cv=none; b=tTVCIQsNLczUPhUhC+yDn8NqLEptQlNPfTYII1JRdI39cXCVkfp6eGy4PrMz8Vh9lNEEMx0ZAD7Ft/SfYP3uwnJJrb3WUtCDVAWn8us6+dZ7DKGhsyiSVXo0Nno27jMPOi6Gx4iCyvz4+J0g4syPrsamxO4n8m0BEPijnr2KOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384337; c=relaxed/simple;
	bh=ToE8mRKztUqYGSXOPTqYb0q0gX2dR65sXRLYIc4bnIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IY05cpIaKPpq3ehebaJqi/CMfnam8qNrrrTkzV5SQWZUP1ywkCnmI1MQXA8D2Jq8rIvD3kvA64MVnD5e85DFXAScCXWZ6Z07vfLnnVxbsUosgrxV8wO4878GUAUlvSDUV7IKFV4w53v3bBkHM2T4a3Di+YKXRhnM+hy+4pXSKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FAzF9F9V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHvw2ndG; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FAzF9F9V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BHvw2ndG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 19FE01D0010D;
	Fri, 13 Mar 2026 02:45:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 02:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384330;
	 x=1773470730; bh=wmRlNmH+3pF7OxgEYfLDjA5siLY7LfSdc19tKai4kP8=; b=
	FAzF9F9VNNxOufTYEvza5U60uSJsJrTkTkOjFFHBdrI+hr5Asrrsx4qVPIhtN2aO
	EM9XBKmp+5q2xbHJ0lO0zuGV3ezUJTr/mCo/4LZmHeTVYixG9OReCv5QOH2whtfl
	WBu/K8LF9lH0N4nG1426riVshFmCXPfjHIlSDocJ/vyS882LCG/NcNz9YLdQRWND
	CrrKsnx9TI0WsqK8wMHLlc9MllRrLQOYgn+DjS+RyL9VvtdY+PY+BnzTNLNMUFId
	4yKuSj6F1qwVZnyhov93FJPKLt7qFodux+aK57TMX9bb47TPiTZU5TwWYVqA/BzP
	j8QX5veHYmE3ZZVyR2Cs5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384330; x=
	1773470730; bh=wmRlNmH+3pF7OxgEYfLDjA5siLY7LfSdc19tKai4kP8=; b=B
	Hvw2ndGfskXRzk21pp8P6aygbR/uHOwwQ3Vtx+KxuNeP5AKDSxsNQFZCAmKsiJax
	w4qg7dQjmWIk0U751Oi/V6hSUJpIBkqGprf7SYREpwi0rL9Lzyq9f441F7dlxqE+
	wqaF2TA4OyxuYlfAbV5BPvwV+jGGDgo3cNgoThcOqX5CAmWYQ9XcmWol1EPuVJF8
	ALUjEITsBcX4PrhDYcDV+jrZuw+txyDFzE3ttrMTfXW6rIoDSwF4iUPpFBE1tJKl
	r8tJRYyWfYx6a4lyIimF/j6LbYCDpfBkMWTXzxXNdqUyk55do6WSY5CnttoZ7rUH
	2JDCYHpfABcfhb9WzmUvg==
X-ME-Sender: <xms:irKzaYEY75xxW5rW0uytdiNvbbKtwOdlQGfeXaJnyrGUjoP-SG_h6g>
    <xme:irKzaYM76jEOgelw61wdWgTBCz6ND4mgDqVb4fAKP59T9woK9tng00FzK4a4xDP_C
    ccTAsQuWHrxajxl6lKCQGR8yQemGsx0GDt7kdAEGIeP1CnmB04z>
X-ME-Received: <xmr:irKzaaebCcy731LU4yMjg8mbUoSWitns04N8l4pqVg0DZCy0cXu81TffOBERe-sUGfJ3O3eAhHkAcCwaKKB7dYB7bnKhudKLjgfJEfzhsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:irKzaVt6hFerNIDuXSGZ-2adzw8kPpmxvhZ_3MdzBHE4eEqCRxMXYA>
    <xmx:irKzabmXTzTbsFF4IpbwPDfM1oe3cesi2TgX0EAHl8FzCDFHxnYp-A>
    <xmx:irKzaXwpvBgCT3pKj5qXM8AyjZXCfURaLpiCkrao0crkydy6TnIvaw>
    <xmx:irKzadNZ7LHB1YOzqwTJeo6sKuz1P-cfPLGIg-puYsCgrV8FlBcEkA>
    <xmx:irKzaYMcaVS-sgA2hnc4xhl1TlEXlrjsTVVHsH8l3710as6QOZC0O78f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 636fa917 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:15 +0100
Subject: [PATCH v4 04/10] upload-pack: reduce lock contention when writing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-4-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
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
index 7a165d226d..9f6d6fe48c 100644
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
2.53.0.904.g2727be2e99.dirty

