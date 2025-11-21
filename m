Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B53376AA
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710917; cv=none; b=U53pNQtDjCL8vquqZBcSprjS6lsBs+xp74QkiefjMZiPVYPsg6C9pMCHzP7/cjda/EgSG19VOAS/BUQCWlsUunTaSHHMFOUcsSodhryNt9DxELeur2XnXWYmd3FQK9OhZMvOpNsrqtrFBBozAiHJ6IUTT1mYjDrKblxKYK7hakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710917; c=relaxed/simple;
	bh=QoVv5WlHAzLOqnkhSfxY5iUSkrvsmFdZQ6TgYNV7YPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PalgEd35mISaT/xp2cxUwyJgxSWVr1wmKQeSe1tlfM/pGSlEZi2YKkStT/WO5sZQrFzxrmq7cwN+SlZm/oeNBMeflIh79PgB193a+swUsYuyqUqoYFCUzfNh3XqO9JLYcUKBe9x2KrQ+FkxCmbrHnTyCXZTaQmU+Ke4E6w+JTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PUmmC/qS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lzOwChAB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PUmmC/qS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lzOwChAB"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A61BB1D00176;
	Fri, 21 Nov 2025 02:41:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 02:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710914;
	 x=1763797314; bh=VmC/40jVEPJ62krjMveyuYITG0tN4NwGKiQ0uUsdBeQ=; b=
	PUmmC/qSeRX2LIngmoKxr4IJfGkkd/llOSOPr1pJz044TggiVeYhvPga81mVwP/w
	dBuitruzXhakQoiVe7fp6bgiZl9H18bjK0KQoMH3N60iRfgaLbVcRvJ9rvVh7FJI
	J9RwNICpedOnG77GQ8UmEhqr7D1PngnRl0ZrR4XxDHBbimFxQJu0Ig6NHoqSVkE7
	sN2JHBTyuHPzh5PjfGO9x2JWU6lgZ6w36xkwJ4Wcp91Cs2sA5wBA+hcHr9xvgQZP
	t+KjE/AWanuxiLA943VZVBm74XTJvLSljh1AT1AUhvz9ZyWxIyzWAFLt0k6sBz4w
	mBxEVO9dCc3VMGtnVkwrKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710914; x=
	1763797314; bh=VmC/40jVEPJ62krjMveyuYITG0tN4NwGKiQ0uUsdBeQ=; b=l
	zOwChABPo9e+EMSGj/0jGEQKWdfS0XqD/9OwGHMQSjLZ6d5vDi5k1YVIjHKsYx++
	NIUlyUewsQNzF+E/kgQHF93hdzvr0y7X76Kef6g34Uunnn4Sm1p6THeiDdJlld2J
	WevP9huPTxDpHeSo2+SdbtZtvaAYnw8aesoLAfh2wytLHQclPFviW42wy4CEcrNj
	RQDvHYPmBt3EId9B/5uppz+RJ3h4mNn13/ZEMa14e7aBrcBBNfveHAuNx+hWK5fl
	g1Uwmgp8eI5RvA/sIXimfSXWhHEeNroQeh/hr00dRhAK+rn6feeM13ZAuhbp0Cpu
	9dD4xmMJQWsNdkP1FImTQ==
X-ME-Sender: <xms:whcgaTHgeLcUcPkhxjuY45RVlWjImGSkCoaLbLL9z-mvgzfYvYtqQQ>
    <xme:whcgaXxy4ZRX6qaV1w8p9v5he9AanG7X515VTGOLKb14ih1MFSXTKO3xnZw13nN36
    w6-d4pcBC_Bjbf_y9ZwwRzU1kwIRdxkiiGlIo1iIgHSnD5KtgdgSw>
X-ME-Received: <xmr:whcgaSgvpzczPCldhXVncc-puqYlvHJ2USusioIjNlg08hSuJRG6E3w2nAl6wcMVNv86f6jxni9vnC-q0GT1YELAqRYOvjWeFdDFSQnaMW7t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:whcgaayHN_jGLkjf_JNCQea-r2q5V7WLztg9uWX4Lf4RlYtFvwkUSg>
    <xmx:whcgadLHejiKn0EGXEyLzTsjp6-3k_t0lKDH5hxiH6XVXjscv9E-KQ>
    <xmx:whcgaZRB97d68-xN5Tm4gb5mQCEHb-e3tn360Uf42JN-1GoUOxcWFg>
    <xmx:whcgadrtdLNCVJbsJ4Te5vIb0Jq0LUJhuFPrhhsb4kwxNAJBa64Mdw>
    <xmx:whcgadcbXyh4U30e3yT7ZT_tN0Y86zRDzvfxQCX8E37NpQHquPp_Qf2B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0a75ee6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:59 +0100
Subject: [PATCH v2 14/19] streaming: make the `odb_read_stream` definition
 public
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-14-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
index 41c2070941..586c20eac6 100644
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
index 1a3de6812e..acfdef1598 100644
--- a/streaming.h
+++ b/streaming.h
@@ -6,11 +6,24 @@
 
 #include "object.h"
 
-/* opaque */
 struct object_database;
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

