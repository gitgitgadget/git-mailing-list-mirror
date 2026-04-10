Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C6B3BE646
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823205; cv=none; b=avXDlOLG1HibTyjOF13oFe6So3NLl8FxbWmjZw5y9Pf83nP7Xs+dHsvIcSLZ841n5uBha6dJA6XTxVwgleBe3GEM+H4hfxapa+snpSB9d3c5PXYVdznrhhqYcSFJ2dI7nV4LNA0w2D3oWka+qQQbz627J3NLr6SnV5qiAghukFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823205; c=relaxed/simple;
	bh=dH3uNK0dd4WaXSTjxC4juFZTq6vG4jHOGbORMBrfHgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6c0/Sc3tzUjQu0WFSVTXEpJcsM0dGWLF9pSimHvhap32MQjNhKKZQN7M8nvgVi0rpNlVqJ9vReqWeN7+84wRJPNU4/xf4Vi5at0/gLTyHIt2fdtwvwDRC8rbKs0HcPZ2uDRFeZWYDbCxuVdH22ZIvBTflfp8z2PaY4vT266yHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vyqcA/Rf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLuY1LCd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vyqcA/Rf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLuY1LCd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 15E0D1D001DB;
	Fri, 10 Apr 2026 08:13:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 08:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823203;
	 x=1775909603; bh=f1Sb3hDKLof7Ts3YheJ7Ngk/MH8lF6KtQS1kXAaOgto=; b=
	vyqcA/RfA4y94TivEx5i3Q+YDDwXHbIpnO+1ckxh5/N0s6v6Ia8deKtpwUoi0at4
	XvMqv9xiOKSntM8R4mDTkVRQ2MSNkDKUbCbyt3/qx2GD+3RCVhgiR7Rn5Y5VGQMe
	eK2HwlGnJissLWI+skNKTvjiEkv6FYIWX457b/F8B6Tw8wwcn+ew1iAAi41tMu9C
	LIrdCnDfJynoirCz/X0ec63M2/ToHax+FbRSl5yX2ukdCh8WlAZPwvBXd/nVCSFd
	0+IiYhJf+lQm9oKDyQV9swUoRFw6HLGKk1v4a4nh+TtRFPXZF7pF5zeD7t9q6AVy
	DdpkMc6sgUyRdWk5L6FimQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823203; x=
	1775909603; bh=f1Sb3hDKLof7Ts3YheJ7Ngk/MH8lF6KtQS1kXAaOgto=; b=F
	LuY1LCdC2Fci5Bef+nxlZ7VEefGYrzMXSVPxO//UVjDDGfFOgEUgaRtOsmcSDx2T
	IdksDTlT4dJKxL0Azo7F9F3T007FuQSy0m6HqC1pfSrw0LtKaaVYEm3n5nFwUu27
	eFmhJ5auLLbxsLCwkcWPp+gLWtQCUmc7GwPs/60BNemyD1CH6USfmMf0F9qlPBGG
	GkEqtfoB1LYLQ4dUTorcdQKktfe2kOlGiO9E3bbS681eujiS2beRToSQcZi+STqW
	Qvg2ctI3ynAwmiJ0RvjUc7DGLF8O7qk+pDkanG3RW/dJ92G76JoPwhPbeJ1COL/9
	nb+qEz8z6tn+fe/oyzMnQ==
X-ME-Sender: <xms:Y-nYab_NR6vXdlH4vMen39-ieh6LF1LaxY1aT4Yj4u4eP35g0bnGmw>
    <xme:Y-nYafIrUnAJwiBSLJNgp9dHzRu9_cfH91QpPWQeKfOMPVQc21QP_j-zM9GmlXMHG
    hW0q2boXa1qLpwBmNecVxW0CbSw4o0uLM3BPHtEn5rRP3kjbolxtQ>
X-ME-Received: <xmr:Y-nYaWYqDjqcMMYIM1ND41ybToFQaZO-K84HkppXKS1ATiRfqI-VqXgqeBJGiPl4rKLxDwVHfJXjkW0KkCZ5IPfahl7_zIlznZYZbouqTRdZYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Y-nYaRI18uQcFFJ8hx6jf6EGFqqHoj2EdUZcpXz6tPunmcD-ii_qpA>
    <xmx:Y-nYaUBAyAnaywpWOzSsVb2nq2pr4m2u15aiCk-9Dt1KuYmzLPc-Hg>
    <xmx:Y-nYaWpcjtn2GmcBK8pS7m9ToFxVGs50Kt_Slv68gTNmYv99t6F8sg>
    <xmx:Y-nYafieLxRYeh33IY45YMOWo0VmroZobo4NjlKDBdifNGManQUY5g>
    <xmx:Y-nYabJ4QcexqXQ5R-4O0Rg2v1CyGiMq_TJdj5a5jhqQ_RCMyNDXksuS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id adbad51a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:44 +0200
Subject: [PATCH v3 14/17] odb/source-inmemory: implement `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-14-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
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
index 674dbcad30..8934e0f547 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -294,6 +294,15 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
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
@@ -336,6 +345,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.count_objects = odb_source_inmemory_count_objects;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
+	source->base.freshen_object = odb_source_inmemory_freshen_object;
 
 	return source;
 }

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

