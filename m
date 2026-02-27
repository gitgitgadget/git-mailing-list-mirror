Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270263EFD09
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191624; cv=none; b=XG+NyHKFtEfCTDN6mJPp5Y7J05vf2AoCzuVa00CQp4LMF4RAMx26qluejs1ooT6aQU/DNqm/feILLoq+twE9sIDRXIWgQtr9wecdgkB72DHz2GPGgz9RYSIsG9l6uW5J7ys+kBm0VYnpQ559OukzAzVlJZ5+wgyfWQSdLAythtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191624; c=relaxed/simple;
	bh=7YTrePIfD6SOifwvYevCqO8hGU76ZF6ssb7JyQKdrMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PLKWVMQqBf0o1Ji7LQfwhm6zgST40GceThrbbUfYH9pWKP2uUPST7vvWkxizJNMt63YeVirSdz4l3lYyAHKpSqoTj2xnEuIbFTtseIVmurDsffh0Ohzjs76I5WomnQrbtzIx8lszFUo/MjO6AnN/kWc8Kx54NF7l/aqMOjP2jYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WqLf2PVJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mDM8BL6J; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WqLf2PVJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDM8BL6J"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20D241400211;
	Fri, 27 Feb 2026 06:27:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 06:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772191620;
	 x=1772278020; bh=STP30OBwHcnL/zr3YJoRdFUnMc1YtXhfJ65Ri4DK0ow=; b=
	WqLf2PVJqPlXBU0+zmpgOeE0vZEZCUEDNAJeVhcWYcew2rR0gvEhAl/e8zw97Tyl
	B35O1dRwIiuCoYd7oYjQsBuRAga78spb/1pQpacAXcrnEM0ZTAQCEr4YnlbdCoWQ
	ftsA7QTWOTYhJfbxEO9Fo1k9LzLDuqKzbhCjBJ8+orFNObvEnGO1URXUbFOIr0pu
	PmtYUm6kIG+fbR5ajxwWcj6avcXNA7fPMLHAg09C0g2TOK4M+cFjQR3wwShVXksK
	mTSiuSj2+u2kVC2V4hZHR/VouJWNIJU6GeNiDgsW4/Mtic3L1hiyyimu0b/wqxmU
	kVAEGrAkLPXZmBwC3eyVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772191620; x=
	1772278020; bh=STP30OBwHcnL/zr3YJoRdFUnMc1YtXhfJ65Ri4DK0ow=; b=m
	DM8BL6JimxRb69G/TuyFXTKXS3zDCQA/L/xlwTVOsLLUdi7tS+UjdKHh30kpbvLO
	50OzXVi4GN7HALf7d8fYL4uLkyVorMAe96m+fE/vRBFkq9AlCF2ZAxqM1R58Srgx
	st+dSbtdMekkdABpYbzhPGUrLpEmijJUrM6Yq3ztg5NCmkSoFYec/WsZMk2h8z1K
	MFTH+edXYwZGOO9kcT06gzirmkxruwEUbX5JAihORO0ulpnnCSOe/V4oxmy8AzWx
	IDEBfbVFunOFJ5qRQVIZX9xEruuk6L5lieDxf8nN91NROBitETya5S/PiRBTqRsp
	C7Y3amcpumYlyK/HOnZqQ==
X-ME-Sender: <xms:hH-haQdJ1gbzHJRlqwdrjy0NndISMnjCoN7DQ7d3CV-RoUaEswubrg>
    <xme:hH-haYMB4auN7hUWsFD6SNfpheRL4ftnDrz8BfBhCupywih5Q3JlI_zPSZppQsYcb
    aE4H2JPU1MUFWqzvcLiFTSNgSSanzPowsPo1fHWR0YtWC_i6DVYoA>
X-ME-Received: <xmr:hH-hafJMNomIzZf2t1zKkBRnftQbQSfcoaP5wzi3nFmXNwA78wZORMhMRYqAzelQCKyW2acXHicefHBnDF_l8jhY80EVx-oFvyg8ChgH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hH-haRF4MihC1UpoqyignYZs8DwpjmeiZ9tZ1xtir42aU0pwCgA0qw>
    <xmx:hH-hafTizsxxPCu0LCxwvBn9_Ohr7OWNS0rFKmUwZxjQXzMkYjsojw>
    <xmx:hH-haVHFhYJOAdkxBoQCIHZo-BF1LMCjSKhhJrZL83gTXQhjTt3sXQ>
    <xmx:hH-haT98fMKaDzeHKJ5NM1ycV4YeKrwiLLBtxsDhRdIqvRQ-LBLD0A>
    <xmx:hH-haXM8JDSKdiUKqfXGK4-M8TfHs05aBQSE-Y7H_27IZCiJiSQ6mzFa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 06:26:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id facda8ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Feb 2026 11:26:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Feb 2026 12:23:01 +0100
Subject: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
In-Reply-To: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>
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

Helped-by: Matt Smiley <msmiley@gitlab.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index c2643c0295..f8ba245616 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -270,6 +270,13 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
 		}
 	}
 
+	/*
+	 * Make sure that we buffer some data before sending it to the client.
+	 * This significantly reduces the number of write(3p) syscalls.
+	 */
+	if (readsz && os->used < (LARGE_PACKET_DATA_MAX * 2 / 3))
+		return readsz;
+
 	if (os->used > 1) {
 		send_client_data(1, os->buffer, os->used - 1, use_sideband);
 		os->buffer[0] = os->buffer[os->used - 1];

-- 
2.53.0.536.g309c995771.dirty

