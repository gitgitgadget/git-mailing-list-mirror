Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C10B37F01F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719512; cv=none; b=BnY2Qwv8YemFbu9JD4zS7GYx4QZ83BWCBIRSeNrklOmSUC85LNlW8qWOfPbdVM+v4DQZCMog23jgQvPFhR5urP2yzn0uD9W6iwJBjik6Yeu5NEhlXYHG2bstgU8nQTodSZFn+J03CULHD/WvrgX5IAjeWdLAGL2RAT8nNzyEZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719512; c=relaxed/simple;
	bh=kTExz80BYQD3NYMhATHc8xbqQge6j58ymMe0hJhGkWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dag6nnCwbk2fJ6dSZBt0VILRuQ6Jwk5q/tWdNzyPsnNbs5V4OXZbsmBGOYtr37k0PcvEiEUJu+/w0GvgroQ7guxTGkRyVqqpXdzvL9YI2GN0CDp9S5kMVufyunbtT+ePiezorvF+OC2T1D9b9HKesizCpXt//AiIrVLovFfrojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nQJkOs5u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkAxTin0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nQJkOs5u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkAxTin0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E319C1400272;
	Thu,  9 Apr 2026 03:25:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 03:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719510;
	 x=1775805910; bh=b1XtVjiDv7Lz6OTUsidrLqBdRzola78U8L7RG3K2HOY=; b=
	nQJkOs5uQwFZDAgIJgVuis5ZJQmg0PkfrCXGFAYchNazHBs1RzliMbiTlsntU8kv
	jAC2+NcHLf3J1gni3Own1yE0sQiTHt8dWjAKJXjeY/Y/HraS69KoROS0A6YX5NQ2
	k+8nYkMWFhO1D/sDwDjxSGwsCM/QoxSwhluO6HuuOx7Hrxt7tJmmFjLnpDoTUQXL
	mQ6JCzF5x8Bnf822s6w4mGe8AR7m2y/UbeEQ1pY4EkpTAUd2EBqiTWHbSy6GpaR7
	vijj6p1j4JSVMt8zJnunIS6i/Iubgbw4UFeiBI6QQQi5JocUAWjmwwlb34SEQ/FI
	KPyevvc0g+5+YwTfZaQx3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719510; x=
	1775805910; bh=b1XtVjiDv7Lz6OTUsidrLqBdRzola78U8L7RG3K2HOY=; b=X
	kAxTin0j8vmjfu2L0Aw/PsGVFVzjRcRYigaleeqI8Y2k3684QlrNrCr+cgY1DU+F
	qTHMDfr6s02zHHmmGg/iwCPJLevRyLvx/1PlqkD+yE/fO9701tlNKo3qgt5JW2pS
	xp5JNWyQI8NotOzQhd9kOkJ35YyqaYHP23SPXHgPs023lbvopLof497PYycyo5Kv
	w6+CXuSzu2JA1cbsq0mDtgu5uC7IfqsMSyiEr/xXtaw+vnm61959O6I9T4u0QpFm
	cT7OPCvBCnsrTECPhUYYJkDNJfTeqp1ApPLzO76UJBeU6swKscmU6/NiKO2ygSy0
	pQAZqwsaFTB51uCzhhBmQ==
X-ME-Sender: <xms:VlTXafWDJQLzxjAzU_fTUM_O3fMBbd1gpHSAoeHV-uvl1zp2QPqPAQ>
    <xme:VlTXafBENWxBPm4VVXdOuofxDvuvm2rqbA8lZ39y3uJiU6-V_zE3y7gA5OFGpCRif
    UGj5M3wnCIxeuZICxT-UpXb2oduTgna5cZvq71VLpzxOQ2hFowLxw>
X-ME-Received: <xmr:VlTXaYwCXNBeD4yEPCannG4hk1kn5YaHK0ZfCsiphuDsK6WKawN16bvciLfWiopAgjDArTk7-BtIQutbs9EkiED_8AB8RJRqd_BAmGeKUnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:VlTXaUBhUQtyc53nGhlaPbtIRiglrtjWLy4nhuYOsFrlFlzmaNJu3A>
    <xmx:VlTXadZjZ4AF-LH9QmvnKSAi_lPPBSDyEBbgI98iMG_T-OQgKCLDHQ>
    <xmx:VlTXaUhHkTehH_1fyRjuJKfJK-a4fjWP3M_XsxktHPx3_PE-oO7yFg>
    <xmx:VlTXaX4TGcNhpMYtEpSsVVezD1rAA0IrcufHTYN19BpH_IKlR_bn4A>
    <xmx:VlTXaRaeLDlnX9hhz9hvOo3mgrcFyACxI9hHZLqt8z44YIxQow4zWIlz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:25:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 568b3fd5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:25:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:36 +0200
Subject: [PATCH v2 15/17] odb/source-inmemory: implement `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-15-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `freshen_object()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index f038debaa3..15a6a5ae64 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -290,6 +290,15 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	return ret;
 }
 
+static int odb_source_inmemory_freshen_object(struct odb_source *source,
+					      const struct object_id *oid)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	if (find_cached_object(inmemory, oid))
+		return 1;
+	return 0;
+}
+
 static int inmemory_object_free(const struct object_id *oid UNUSED,
 				void *node_data,
 				void *cb_data UNUSED)
@@ -332,6 +341,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.count_objects = odb_source_inmemory_count_objects;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
+	source->base.freshen_object = odb_source_inmemory_freshen_object;
 
 	return source;
 }

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

