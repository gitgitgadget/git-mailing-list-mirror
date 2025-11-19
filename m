Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2F326D55
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538497; cv=none; b=rUyIWQvQuk2cA4uGj33AvZDgWvibQ+I9ROuP23tiqlQx/DBxrdtYt78hkLFNqWjBYzcoeievlQF0A1CG32shFMFKY5iCWw5oTTvjovxsaYGfV6RXcOpBQU7t+KHo4rpmkRqhfelF8wDUshw2XBfk6yyg8n6CF5iMT4QAJmfaBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538497; c=relaxed/simple;
	bh=UH7zLCy46yuffYR5FfmwF7U56rom6vpaDi4jEU/JEGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWU3seN4nvf0NwQRic3uiNZslMakdlR78a/dZ5fU14o4KV5C0SCICXbSColnXilZ3msYaW5xw3YoPKgpHi4IqaXPfdMehzhHnfDWGAYn31gyLZLSQyD/sTfqneFqiLzcsLYKGwpLByuJZA9QEBhVm1sc4LK23o9XltGc1AkqUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XiZf7IjA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMydX86i; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XiZf7IjA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMydX86i"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75A0614001FA
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Nov 2025 02:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538495;
	 x=1763624895; bh=bOlyAQE7PP6UqUcauyKPJvRS/lPQaMt+p/fOIMqkLBE=; b=
	XiZf7IjA5qG0E9w2oYcQZiyjA1sBaKNEoVq6KBuiUhyMWC/hvNs9apwqkKYSQKgs
	4z7KGmGHXRiNztCtwN8DLvaKQ+/HTXCEC+2Gr72og3NW3HciIADVEhCuDl69D9/Z
	UUywOhBrt9sIggjk/ssF5zcHbGzWDAsNyvpPaOe7Ze8jWU0Am2cSK0lXXqtFhahM
	KDogk/IODLqPU8pm7hlI0wSNcNncIAwMm+NiC+YtTA447MiXMXL/coAI6YGI4lz9
	eyKV3KzGXY7mapTjFW0xvnf5+48vM0LRX2W7pCaalaFIDTq7iXsXsc9W+hBOf7RF
	tMOJSzSa9fz0DVu+k0WBWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538495; x=
	1763624895; bh=bOlyAQE7PP6UqUcauyKPJvRS/lPQaMt+p/fOIMqkLBE=; b=f
	MydX86ie7YlI2ip/LF2G1LtVeoGnfPbFz5MnQPQ1zk8nQ+ImQnp7bN6sOxvUEw8a
	UCEfSnjPH8cvvkZRALDp7j2KTn+qSKi/WZzCeWLI26weYH8GlkjvJfZQ5Tx0zdrH
	ZGDTLcEyhzmWRDUo4AWiqFSG87W4zotX800V44V1gR78jS2T7mF41WfR6W564z2a
	GvjA5jnpurZPgyKXZ7PJ9wvbbYfBr71kp7XPUZ2tAFDVx4qjs/VS4/b9EhSu26yl
	rp5KJVaeAzwnUsUiuzSWKPIor3jTOLMw/TmhGD1zfO2bQquW7hDod7e0Em9/oC5f
	eoEsUtTR9Cy7/UnAb6tEQ==
X-ME-Sender: <xms:P3YdaTK3C6nS-GKaXm_I_FTt9PPh6XeY5xFqw8PkhmfgJoGBjJzaJg>
    <xme:P3YdaeEATGV5GduNOHPNYaFkjhd32Pi_FMkc53LHr6RCxdUAdcK8KNn3ZQWWNSZFj
    GyfyDznO77Ias9V8A9ZbsvvY1S7ssawzw2YeC9iiNS0tUOQivmSHw>
X-ME-Received: <xmr:P3YdaRXxtNNUHrvRKh3RCOtpVAjNN8rpHp9sKTfSL8CgqaADyzDxfAIi-RTIbtKCog_1C49VVrNt6ad6LgPrl73olEDhYZTQJDAIfix4Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:P3YdaRgFdZJDG7DN5aP4TbMTYqEyxMoj5xKzMl7sbUt3aXnpd_Tx-Q>
    <xmx:P3YdaaSwq6FH2ZcVmhrMS3dpI3HXj3zIzsjbid7_LsyIOSF4HP1_hQ>
    <xmx:P3YdacF6qOcKqT9WEFyRceq_tikDloy4EAlfStgHP10EH5sVmMrGXQ>
    <xmx:P3Ydaamz8Je7mbaPb-QId59VX4hWeo2di5G6dwOwV4N0N0ClDZyl9g>
    <xmx:P3YdaYrKlMp9eVcV2uUyQXWp1Red1z9WQIpZ2Eo0Ys5KVukiHtAFmCPV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25dc2527 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:48:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:14 +0100
Subject: [PATCH 14/18] streaming: make the `odb_read_stream` definition
 public
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-14-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 9e20e9a882..3f94bd2a03 100644
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
index 95c2a434fa..3a850e3efc 100644
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

