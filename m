Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0D32550D4
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924434; cv=none; b=jPWPdL1LmkH/QNUwO9h9H+DjbGzxzaLnAh3TGbSdqViFuWzBdY07MdJwtMdrv3rVunmZtzoj4FH9rHa2qQZtsJ7ZrKmRgwbIx8mC4KhgQJkXBlDL678UAGoOfl5vX1lTO78f3N4rjlVcqov6hQJfvUeMLAqQTh8jvVWHOcl/wvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924434; c=relaxed/simple;
	bh=VoADjXQR/Y4aCz2KKxJ2ej9uJx77vZB26O3RN9nbUrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3iTsw0lgUmQ5ZFTzcL8AQstEvmOpl2keaVAIrNNtVdo+Bolpqc+0NAJqcOyHRxd3eyForDimw1tXr9NWnWKQEpbKWUXXRiylcTXkyd9fmru9XaWStlDlJg3TvGiXxFIOBX/hRVZqlZjiE/SfnTHvUgQ24c+rPvmCMjp77aHalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pL5BNOpL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZykphrLR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pL5BNOpL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZykphrLR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F3701D000DD;
	Sun, 23 Nov 2025 14:00:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 23 Nov 2025 14:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924432;
	 x=1764010832; bh=qvzqiSexi+1ElfDY0rj/IgVYcPPC4sJ+pzUd1dKLzw0=; b=
	pL5BNOpL3nXjqLBiQXgG6nc8IX0vwB4KNGmkmb4UXpRZUjh+K2yhdb6Tea61uRKp
	+4CLzAbc/RYsjKlxOfzp84Ai1dT3rZCep5TM3W5YPXBvOBVvvAFYSIQgzHiFq7SL
	LfEqHUPHXPY4zCUnFXdUylOYRCSbhAK1kxcH8iU6NcPCMoNukZ3380IMPyYW4OFc
	QbZstMnWoBG7oS0evopZRxV8nplmPRQsbRUZpmtD4/+kwqmeuF3+M8VGF0zJtKKA
	l/4Qt55ryxilaiWXx5QY2Jbp6ExXMlqrOATD7H9BMubqEmnsfn33JKCd81W5XnPO
	EzzfJ34UcK4nXbY+WQMOOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924432; x=
	1764010832; bh=qvzqiSexi+1ElfDY0rj/IgVYcPPC4sJ+pzUd1dKLzw0=; b=Z
	ykphrLRHF+bRVByueUEu21Pg2MjvNrJ305vgI/f/2sfJoAmhDV8q55tf/5S5s/sS
	Ew0Yb+HAoON9I09iplsLkV9ys44ojrhBdVpwM14M2PKRVuQJr7T3CBbkCktBwfjw
	BNNWQkcI2JsxTInT6i9jK8CElCcspOFZRxKsKOdlyCwDDQGu+V+39T3kRDjBFUbN
	e5S+2Sb1HXfp68f7O5PC66rxVIN7HvaqmtyxKkk3zeKtQnFpIL44yUiZCGRYcIpx
	iDaCW81MmyfXsc7gOUKRarKp2AIpLfcxTAV0pNp6WeKoBiNcCeWk4r+PIUuXGLNr
	LkA40D+bTKDIiYZdFfZgg==
X-ME-Sender: <xms:0FkjaY4ya6UMj2f5ucI2-eCXoqYDKpdFsz2aBbCE3zHs8ZzoyvcOfg>
    <xme:0FkjaQ7bJuB8I-ZDGL6Z9zBla00OZO8Mnlu7T9-oBa7nqZUTJKjVcs7Ugp_os9aPK
    el0RltuE1JSCkXkDaeOZpwsW_6ZXE5rkdJtRdx4hTDd2iLdXstvFw>
X-ME-Received: <xmr:0FkjacfmK9z8rLi1nPKNJsmi25b1vKtNcwOgF_MJ9Q94zXPBcz2s8WEZtrmDBD0WUBjR4ghmSzc9fUPyjvSTCNxQ2D7c4ffnVFtH08amkcYZVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0FkjacAanFo_zGqAO9E5rljBDDMSbEPyJtYeM7utWftdlqZKf6D7lA>
    <xmx:0FkjaX8ZwarTOraQNo5CnLJCSWhdwSYyye0XF5ZeX6SUOgVvOUcprQ>
    <xmx:0FkjafJCyiJbru8zEfWurH4FCUDDcxTRrld1Jy2Fvs9oJAbxh8nyAA>
    <xmx:0FkjaYgAR6PjUDJpMI5kN-zoiypJGKrBE3tsEr7GHUG9beBtk26ZlQ>
    <xmx:0Fkjab-rAV3zv10LffG-qOlyV4aF9XP07eAnVn41N1g2OZZON5GDWvM->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eff1f438 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:39 +0100
Subject: [PATCH v3 14/19] streaming: make the `odb_read_stream` definition
 public
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-14-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Subsequent commits will move the backend-specific logic of setting up an
object read stream into the specific subsystems. As the backends are now
the ones that are responsible for allocating the stream they'll need to
have the stream definition available to them.

Make the stream definition public to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 11 -----------
 streaming.h | 15 ++++++++++++++-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/streaming.c b/streaming.c
index 807a6e03a8..0635b7c12e 100644
--- a/streaming.c
+++ b/streaming.c
@@ -12,19 +12,8 @@
 #include "replace-object.h"
 #include "packfile.h"
 
-typedef int (*close_istream_fn)(struct odb_read_stream *);
-typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
-
 #define FILTER_BUFFER (1024*16)
 
-struct odb_read_stream {
-	close_istream_fn close;
-	read_istream_fn read;
-
-	enum object_type type;
-	unsigned long size; /* inflated size of full object */
-};
-
 /*****************************************************************
  *
  * Filtered stream
diff --git a/streaming.h b/streaming.h
index 148f6b3069..acfdef1598 100644
--- a/streaming.h
+++ b/streaming.h
@@ -7,10 +7,23 @@
 #include "object.h"
 
 struct object_database;
-/* opaque */
 struct odb_read_stream;
 struct stream_filter;
 
+typedef int (*odb_read_stream_close_fn)(struct odb_read_stream *);
+typedef ssize_t (*odb_read_stream_read_fn)(struct odb_read_stream *, char *, size_t);
+
+/*
+ * A stream that can be used to read an object from the object database without
+ * loading all of it into memory.
+ */
+struct odb_read_stream {
+	odb_read_stream_close_fn close;
+	odb_read_stream_read_fn read;
+	enum object_type type;
+	unsigned long size; /* inflated size of full object */
+};
+
 struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
 				     enum object_type *, unsigned long *,
 				     struct stream_filter *);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

