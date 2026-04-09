Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119D37AA6D
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719494; cv=none; b=Rue1rc5buIybIQPUiNLHQw8t4tAGWUXVlbkW1RLYzG0iX3KfToAYJjoFJNuqSJd8tKVQvsn3lhzPwaxVj6u6nxy4VZwL/tRrBtqBnVSSMEyjvZHNT6qG1lkXFotXQ0hzNhHZB/zl2tem2kGaKQtO04h/mXfLg6BiEvD+/CtR0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719494; c=relaxed/simple;
	bh=cRJyvaTjdGvQGvVCl/W1li02EA54Nyh9vr7SuccmGOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zt06XiBw/ziAILy5RHj4DpXJ0XxSrizhGxlCu1nWEK3zPyNiFkPiKgEy0kHBUZ0WG1fISuKJ4a9IfRsdRWNHgRbl0NvZWPslgGvsbWg8y1aAyOniF73PfPnm9SYBRhs7b4bRKNWnlmfKVLEUgFIBUPz2BNyEqE+SiQ9OEQv5JAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LYvGEfnJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egCf6+98; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LYvGEfnJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egCf6+98"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 123481400276;
	Thu,  9 Apr 2026 03:24:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 03:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719493;
	 x=1775805893; bh=nYrA0HPjj64kvKyg4WAR6kzLmQAq4XOAeenTOhtnbP0=; b=
	LYvGEfnJlsl/NMmiq/wAqyAMaNhxiN5UQ5bkDkNsyZ0+CqsRIk+viCtOxz7E1u0+
	hkU+6wequjLNIXxJqgFnwSNOyUnnV2alQEPtS3tWE3qQ0NRBbI56vNl6O3Z8Gnxe
	kVzVV5AsHDPH6/CVXJKEvftEEeoHEl9aGRXFjTgwFPzGbb4sCQg9QBTY+ibrno0u
	0VPfyl+0Va153v6reV4y1jowNqiXoenwZCvr/7AHeEnqro2DL7u48n/LX/NAa+IE
	K4M/cfCgavpsPT0nlS5a8qcMepzyz3nfI4byLzNqd/kj84chiajLZidYRvFkefdM
	8j3gfU3TawnYLmaoXyXJIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719493; x=
	1775805893; bh=nYrA0HPjj64kvKyg4WAR6kzLmQAq4XOAeenTOhtnbP0=; b=e
	gCf6+98h9plgPAiV3t27IefCsYzt1p99x72g5AjcCcvNTB4uWnl3a1yufCDTvv6w
	SvIc2DxX0j3TDrchpKmu13yLz8nmcnhuL7N39EI8hY+PMMvzZXPeSDDodyRcuCRr
	IS2/AGP2Ir4VYnf+x41+hi3KNKx4CFyQraa4CfEnNohmW6vnPjQd4eZZIHu0I36r
	tSxfs8VdFRA75c4EBYd43X4Z6itgpvxI0CF/chJeCwYzlVYWHHV6NUvAES4HcW2V
	77AfbAop2ej9BtSYicCUpngS87s64Iz99z15JuVsgubpINj5NaPJxvpp5DorOvdl
	1Grea/IMxF5i9epTR1XRg==
X-ME-Sender: <xms:RFTXaagnwyLQcYULxiCWsK1W-84l159ziD8gv60-trxlSs4cjXHqBA>
    <xme:RFTXaSfKahNJdUiaydNfWZUB7GUVJxcwrqXdhghUl7uyv-u_9eV3l8WPTeh434kTn
    7XzHr0L7FZsA3gPV5-XxucT0DICJpnvISlyI_bsLBswFM3Ro4E0Lg>
X-ME-Received: <xmr:RFTXafckiZhtqVMuYpHV6A0qEtPbRHqScnnVFcTA7LOAEteoL0CwCWa25emodeTG-9WPmaQOc9-fH_MpIm57ZdN9XPtFLR4j4j-_-f7Y85o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:RFTXac8qGVgMmSaXhKf5mxnUz5LsETvwq3afYi1Vbz-0rKP1W9HRjw>
    <xmx:RVTXabmvYoK8rRtkMJSma-5Q7HzZklyWhMKh3QSdytRcAR2fI6TElA>
    <xmx:RVTXae-IAqXgJ3yivqwfQ3Jm3IxPgSCjs6od7DMPUExnJjAVzljRow>
    <xmx:RVTXaZkRQnVZawK6DoXdxcik7uYPCB1P6n_hVNDSeTazgAig7QGCVA>
    <xmx:RVTXaScLpTonINhDmTddnpbug3TVv897Zpirtiy39k4vUOhJhRmOl2an>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6334b1e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:29 +0200
Subject: [PATCH v2 08/17] odb/source-inmemory: implement
 `write_object_stream()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-8-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `write_object_stream()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 96e8efd327..578ceea550 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -126,6 +126,45 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_inmemory_write_object_stream(struct odb_source *source,
+						   struct odb_write_stream *stream,
+						   size_t len,
+						   struct object_id *oid)
+{
+	char buf[16384];
+	size_t total_read = 0;
+	char *data;
+	int ret;
+
+	CALLOC_ARRAY(data, len);
+	while (!stream->is_finished) {
+		ssize_t bytes_read;
+
+		bytes_read = odb_write_stream_read(stream, buf, sizeof(buf));
+		if (total_read + bytes_read > len) {
+			ret = error("object stream yielded more bytes than expected");
+			goto out;
+		}
+
+		memcpy(data, buf, bytes_read);
+		total_read += bytes_read;
+	}
+
+	if (total_read != len) {
+		ret = error("object stream yielded less bytes than expected");
+		goto out;
+	}
+
+	ret = odb_source_inmemory_write_object(source, data, len, OBJ_BLOB, oid,
+					       NULL, 0);
+	if (ret < 0)
+		goto out;
+
+out:
+	free(data);
+	return ret;
+}
+
 static void odb_source_inmemory_free(struct odb_source *source)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
@@ -147,6 +186,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.write_object = odb_source_inmemory_write_object;
+	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 
 	return source;
 }

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

