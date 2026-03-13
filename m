Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4E250BEC
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384340; cv=none; b=n8fjTVtMjWhxWegyYaDfHphSybuxuV1QZYqaxwD3X5wK2jc568h9Y0zRThl9rqusX5Of2f84YcvDBGBcUne3Zl56tAliap6j2lZhZVDfmiYsb8YCZplDnSBFmsC4JL9QzHa1k3/YB598qZ8jYRlxp/Zswko3nryC+OiLSbpPI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384340; c=relaxed/simple;
	bh=eo+ewd9obycNFmCjJAXgaFBLchpwV+g1XDde/pqfjJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O54gWEC4Y6T64YdF2aNbHGuTf9tcs+vQmgIMVLiRu1RnGIb6IbIAoV7HDw207NKvZob1sqyJTxMhrF9jb76i521tNtJN1bCrlTKUGEFEahb3VncKqDLrvvpi6X5f99mWKteVe7jrImwUnc3s4vzG8VUCEazWDpc6JaGDLBkyeZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CfhcgKqd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XW6KMTrU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CfhcgKqd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XW6KMTrU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F105F7A018A;
	Fri, 13 Mar 2026 02:45:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 13 Mar 2026 02:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384338;
	 x=1773470738; bh=sqUPrtBeF1Ann5UfkI5RY0gF/Yne5x/OUpUfMg0F470=; b=
	CfhcgKqdqsB/O47QbS8XPNOjmzwq8gchGLpSbR9+7LDIJ11kzBH26tUSSgXA2LL1
	4TEETVME4+4dZgBkLzHmImOn9uIXVIC/sNgiDUW10feWsO2PvL8v/8+eIi++6cAB
	PSzP4lWV9v/L6nR5Eeqo3Rxv3Ud5OgT5Z4a+nSKSu02l4ky695GBNU5Mm45VA5Yq
	6sUGkrwO5zmmR9xwKcFmJfARsvYLqm4VoD3DEzjhUPMYNZW4MF12QtjExYyrVm8f
	FqvdMoRfVbfus2WrF4/SGg/rZrUYX+2KO0sutgCv/qby9oEX+6OfQFQocGa1CyGY
	mfMnw2h1c20xRrS0YnOkQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384338; x=
	1773470738; bh=sqUPrtBeF1Ann5UfkI5RY0gF/Yne5x/OUpUfMg0F470=; b=X
	W6KMTrUcfkWYsrVeNekeYUwP5m+kK6Re2h+5MFwbXIBMY7D2PnNdxANorFvNCliW
	c48d/61GS3fCY2YXZiL7gRVE0h+5WmyP09lo7pok61IPmk4KNJIw+VT/Lyu76brS
	YqfaGc/I/wzLVbitr3JgJ2LOHd9toqsw5rGoADs36fjnIoGjwu6xQoZA9gDsOBQe
	mfX5N46Eg4N0tOq1gKUK7UZDzfcwAX3uuKB4/P2O03Dli1c9VbeyVbEUaQxfOeOj
	wQ42bQilemp0MFY8KPWbZ236l5HYoqSKkXqp7YDI9LZC/kCQOkoxmlsSHkXyBwVb
	RgrbzrrA4PbCLm+jOexrQ==
X-ME-Sender: <xms:krKzaYrFBmMKUUgpzDs8Tx9kqRPWryrRmEWS3mnUaYRpSmClXpa2wA>
    <xme:krKzaVj-wCFZALvMXnaMNNUn-1-3E-7Aby2tC0vIKe8ny_tqnfryfHXVvi25zFkOP
    40qXf6nfLGqFBxjDpOhFTU7wH2koHJ03_HisrZj2zn4wRtPmubkdw>
X-ME-Received: <xmr:krKzaVju4S8xeolrJAEQeTKqED9dccRuj3xG7lJbeayWQt-T9euleoqVKx2xDuie0b6e15F9r5N9STA7xxl0VrwZuD1UQXSwJ0fcDy_6eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomh
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:krKzabi1Fu5pQCgH0I_mexhC3wCy9WqJyFYombUSjnTZTb5T9Vl59Q>
    <xmx:krKzaVJspBHihkq-S-k0uVT6GzGl9Xggw6q_hR3GeNX_tu4Tw-0wrg>
    <xmx:krKzaaEk6DdV0sTO6YEK6nL9ag9P14kGMflPTmiMPy4xGPyKkmDKsg>
    <xmx:krKzaZSGZRfKtBsIOL2-coRHVySkd5hWxTFwgmuD0-O1kM2NAuVgZQ>
    <xmx:krKzacAEn2_sez4pyfNEX8sJ92AGJgdC8wKLSmPeqXBZ3Lg0CJqtlekl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9cd8f84f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:18 +0100
Subject: [PATCH v4 07/10] sideband: use writev(3p) to send pktlines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-7-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

Every pktline that we send out via `send_sideband()` currently requires
two syscalls: one to write the pktline's length, and one to send its
data. This typically isn't all that much of a problem, but under extreme
load the syscalls may cause contention in the kernel.

Refactor the code to instead use the newly introduced writev(3p) infra
so that we can send out the data with a single syscall. This reduces the
number of syscalls from around 133,000 calls to write(3p) to around
67,000 calls to writev(3p).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sideband.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index ea7c25211e..1ed6614eaf 100644
--- a/sideband.c
+++ b/sideband.c
@@ -264,6 +264,7 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 	const char *p = data;
 
 	while (sz) {
+		struct iovec iov[2];
 		unsigned n;
 		char hdr[5];
 
@@ -273,12 +274,19 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			write_or_die(fd, hdr, 5);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 5;
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			write_or_die(fd, hdr, 4);
+			iov[0].iov_base = hdr;
+			iov[0].iov_len = 4;
 		}
-		write_or_die(fd, p, n);
+
+		iov[1].iov_base = (void *) p;
+		iov[1].iov_len = n;
+
+		writev_or_die(fd, iov, ARRAY_SIZE(iov));
+
 		p += n;
 		sz -= n;
 	}

-- 
2.53.0.904.g2727be2e99.dirty

