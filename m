Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC977364047
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196179; cv=none; b=m7iZExUmTyxXVbm+hKwEz+PmMDWkS+pBzcD/MBhrNZ2AoGNvhbPK7E3iI4lqMCyzJ9AFpvcKk4IhuwuhLTNhywlGxI22Zs70+xIqPn3s9MYP5u6/dzu4PWSOkUD8Y95YnX/2gLuuT6Qp5WeDWrQy8mGJYRxS2NOlASxlqjB449E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196179; c=relaxed/simple;
	bh=cvmSo1PastPHUnpU99aMqkaumBYcGyi+9UaCNV9qC7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhIGesBfYHJdKupAbwehquIuFi8kLEqDXzWWnCuYHVJ3Gwl088L14W7l67SIMrXDGdAuR36gNgYB715nX56wG7bpuMitK2o3le+cNerEv+7M1PZ6j3bsRg4CruJjpwham0i01lM8vt7P61c5nIoVXTcltqf0Zl8jdP5f/CbE+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rd9bG4AT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EmT/xj0O; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rd9bG4AT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmT/xj0O"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6100B1D0016F
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Apr 2026 02:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196169;
	 x=1775282569; bh=Wvn9+5KbvdYT2H3xs5/cEkxCR1W6CglrNO3Ox+ie9uY=; b=
	rd9bG4ATtlYp8wrp7HgEwoSFGsZvx6rN0icKp9xvjiz9FPAsmyACrJOXzG/TvnDK
	a9ySP9das1QbKStsgA/6zeqjrP4u34lvBBekOEZ080T9P1qkcTF7UkbCGXTi7ZRQ
	pg4m705Jx+YGKlGIuKIOQyUALwYNDXHqAq3BBt81xIHMoXwHQaQhVVdbtt6acqYr
	CBRTTJq4YwvahN3ExD9/Fng1EweBycbG3LndEGaj5OKbonLf1S695IXulumQP/PV
	bDC6f9h1O54BdXLdooXQWCZ7TDGqF3+4MjL07tjwYlUAsfH1rHmyE2ITiNOv1WjJ
	F3UY4m+p6Zp2XX5ffB4qrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196169; x=
	1775282569; bh=Wvn9+5KbvdYT2H3xs5/cEkxCR1W6CglrNO3Ox+ie9uY=; b=E
	mT/xj0OFeta7vcsdVb4UNR2x+NqUQBAT2Zy0C2H+XMug9bmFUyhpwD/6AGIQrWLe
	p9bT4HdTDe+aoy5ECbk7ACxqUgDbw/ZgRuEO0ygeMkwtKCpkC1l6ExFMVkG6O3Od
	eZBhS41CCBSL7BhTrMBwWOK+19QgryyH6TfpcqCvRBW+4ivuuy8lpPpD8EsmEHbA
	ieN4x8ZDaY6euNi1+Lvfg3sPxDC9Nj8j8IrwmhLRWu+GPiLEDZMn+xFtjBjfIvY5
	HGVR09Q5B8/fpCLDqZdN6foBGZBBHIIiqX/YG/Dm9V6je9OcOmYu/YNMpP6S7lLr
	OvBWXyFJjkshDCi3SVf7w==
X-ME-Sender: <xms:CVjPaZAFo5wwcKfKxt9UDH-sTQmPfsIMgsIxosu-71dAcnOux30CHw>
    <xme:CVjPaefSyM9RxLMcjzWRwvCvOSdjQq0WsZb__X1AGURu0tEo0gA0pYS6ju_NChxRv
    L_eSbcHu-A6lTqhrOWWJNYeFT1Pr19E8cgjdjVTYRv6TZpbdgo6qQ>
X-ME-Received: <xmr:CVjPaaPBEyH_ncDOh8uVorAo-U8vfMfocA3YNgvjfUOP5z2rSZAG3sle9dDy3ccOA47ICrPWP6YTcosQnwhjSMO8_t8oPDmYoNUfzeEPlLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:CVjPaY5lGxovInpPPTquNok8ZbrgZh9Wgk1pM14RvwvabqqlVvdjQg>
    <xmx:CVjPaeLG9B4vR8gYqdspyCGIQx9qkfH40TmtOvEMYgp_KvKnXYgn1w>
    <xmx:CVjPaSen6i6xpnGQp_3k7r8mRuytar5jGgfTxwNfFRIIZyzVd3KXGw>
    <xmx:CVjPaRc_CcUPS0TQia-VacRNI3ymdoBm9zLxqOYeTbAFpT-8Tphs-Q>
    <xmx:CVjPaYA0DH7PbsIiG03qaYcw_DHit9alROt_5hzgYFMZQimu7Onk0YNR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 621e4c68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:59 +0200
Subject: [PATCH 12/16] odb/source-inmemory: implement `find_abbrev_len()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-12-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `find_abbrev_len()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 0ac20df323..16182bded3 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -164,6 +164,44 @@ static int odb_source_inmemory_for_each_object(struct odb_source *source,
 			    odb_source_inmemory_for_each_object_cb, &payload);
 }
 
+struct find_abbrev_len_data {
+	const struct object_id *oid;
+	unsigned len;
+};
+
+static int find_abbrev_len_cb(const struct object_id *oid,
+			      struct object_info *oi UNUSED,
+			      void *cb_data)
+{
+	struct find_abbrev_len_data *data = cb_data;
+	unsigned len = oid_common_prefix_hexlen(oid, data->oid);
+	if (len != hash_algos[oid->algo].hexsz && len >= data->len)
+		data->len = len + 1;
+	return 0;
+}
+
+static int odb_source_inmemory_find_abbrev_len(struct odb_source *source,
+					       const struct object_id *oid,
+					       unsigned min_len,
+					       unsigned *out)
+{
+	struct odb_for_each_object_options opts = {
+		.prefix = oid,
+		.prefix_hex_len = min_len,
+	};
+	struct find_abbrev_len_data data = {
+		.oid = oid,
+		.len = min_len,
+	};
+	int ret;
+
+	ret = odb_source_inmemory_for_each_object(source, NULL, find_abbrev_len_cb,
+						  &data, &opts);
+	*out = data.len;
+
+	return ret;
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -268,6 +306,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
+	source->base.find_abbrev_len = odb_source_inmemory_find_abbrev_len;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.53.0.1323.g189a785ab5.dirty

