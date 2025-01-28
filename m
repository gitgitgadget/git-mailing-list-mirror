Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164F1DED6B
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052899; cv=none; b=PXg62A7FjdIWfjroWnZDS+7I0zTvbgAZew9XZ9Ji4QBkxTCuykUihD6AJvYKbNIUCzPx6sy/do2wAQ8JlsRfWhbQiouceReotr8JPApTi0dxwl2P9vHjQp+SsMqnLu+ikE8U9j5KL/hWKtqZugC0Pb2EpNrd4S+O6NaHCPBIu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052899; c=relaxed/simple;
	bh=iOcbrhtMCsYUpXax7MvMzB7OUlu1X3LlpotWpleIkyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vjjj1IcRSy3klSJ2txNa4py7DqjCEX0acoVwpJdzk1LmbYZUo2y7Tw1RlcrEZ8lf9fSHem0kYuu3dSUZz73LIFD3TFLtC0RuqDE30g5NebiENaFAoqGz3t77Diy5hDb5lthGu0QnIGTtoDaM0+pJxy8eTYDlUOVv/S5AKoU98LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Os8vuqmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jW06qG4w; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Os8vuqmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jW06qG4w"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 280E011401C5;
	Tue, 28 Jan 2025 03:28:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jan 2025 03:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052896;
	 x=1738139296; bh=EKGJ7c9z7q80SUP1l/YoC2p2AyxMFGeXAJ1WXAFS/oY=; b=
	Os8vuqmJDEy2pYrh+v+nsFouNO4rkUSXqRrqjg62zUE3V3AUK/yQnc7CauOhUFUu
	l2Q0S1gBRhjOf9/wEGt+235l46IXbKIp6N4VmWcHUcuHznyo6MhREd3lOa8BKlqA
	Ol5EJ4b7m66KU95ZF8IXaHSOT+Cnj77RhE0jZ295xS2prvVib0VtsYHlR/FaEGNz
	2x6Mb3bAnJQIq3PHYkW9Sa4SCSCTW2pMBmr3vIsY/KFNCvYZfTQ2GIG1bsSMDVbj
	F5k8esClQt7xZnSSIw3onYuVjoRChdXiuE0L8DfkqQQzXaf7ux6dLNka7bVBEiHT
	xC//K3/fHx+IOd9oyZ5ExQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052896; x=
	1738139296; bh=EKGJ7c9z7q80SUP1l/YoC2p2AyxMFGeXAJ1WXAFS/oY=; b=j
	W06qG4wKCrfTbTwWJlwzal9uBthrKsYzpsCAJn3dC2sfDx3zb/AhUenA+muSc35H
	hk/5VTSLtRxfE5cbMMFXUqMX6pAFaUiDUKOT4xTnoxYmbiH7thcMLZ1xT0XPgun9
	sssT2p6L7RD8jWsk2BVBsrJtKMGal44gd4ZbicZdboUChKNbMAw89T3POZnuxDET
	/nQtPIpzBSTbUvhqEOH4nEKl9R0NDLz8H1gxXF/mT+sFKS0BNkuoxoebrUsBRV9r
	ETMiqW1kYN6LRbGfuW5NcIztE159Ff4UIJ8ogxzNIOppvn+2RxOYVyfLRnOj+tA3
	NY3qYYpHWu5KK6cx+sCIw==
X-ME-Sender: <xms:IJWYZ06NZfDgzqSSaFTmfBtagpV0B8TLSJYOmJCg3W_vydNpz3Kh8w>
    <xme:IJWYZ15aD8iixJ599LEup4eKdf75xDw9FWama1iEoMu51_PZwkSkb5_mvguumnZ5s
    lQhJeBpQXsHabnW7w>
X-ME-Received: <xmr:IJWYZzdGwsMizTi81RAe2ROBzNhcMHHp4hUZpV9c7c9YDu4ahW94eHgUj7DFQyKxVZEj6fhAFMu71mHPkjyIVyL-u950iTvJqR1Xh8TRXkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IJWYZ5K7ZJZS_4ApDbEX3yhnpQ3CRzoAKnRhWyRBEjafsr2vTfkxjA>
    <xmx:IJWYZ4LNREyDzGR1IMZROfLiuoJ1hjxohPqIyARrQmbOeeiupH63Hg>
    <xmx:IJWYZ6zorPodWV8WP6RnmWWlLmujMaC8XxvOeipr3YQjanGg7XgXlg>
    <xmx:IJWYZ8Iq1y2i3lpim_sNrhIJ-5Lu20Z0_6k6n3PIyQri8P8Yy4kMeQ>
    <xmx:IJWYZ9GPRo2cC_TgWDJ1wGsLKdixYf2N8jFo6_vt0ROasPOT4GQTN9Ka>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f5330dcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:02 +0100
Subject: [PATCH v2 01/20] reftable/stack: stop using `read_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-1-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

There is a single callsite of `read_in_full()` in the reftable library.
Open-code the function to reduce our dependency on the Git library.

Note that we only partially port over the logic from `read_in_full()`
and its underlying `xread()` helper. Most importantly, the latter also
knows to handle `EWOULDBLOCK` via `handle_nonblock()`. This logic is
irrelevant for us though because the reftable library never sets the
`O_NONBLOCK` option in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f7c1845e15..9490366795 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -115,13 +115,16 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 static int fd_read_lines(int fd, char ***namesp)
 {
-	off_t size = lseek(fd, 0, SEEK_END);
 	char *buf = NULL;
 	int err = 0;
+	off_t size;
+
+	size = lseek(fd, 0, SEEK_END);
 	if (size < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
+
 	err = lseek(fd, 0, SEEK_SET);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -134,9 +137,16 @@ static int fd_read_lines(int fd, char ***namesp)
 		goto done;
 	}
 
-	if (read_in_full(fd, buf, size) != size) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
+	for (size_t total_read = 0; total_read < (size_t) size; ) {
+		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
+		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
+			continue;
+		if (bytes_read < 0 || !bytes_read) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+
+		total_read += bytes_read;
 	}
 	buf[size] = 0;
 

-- 
2.48.1.362.g079036d154.dirty

