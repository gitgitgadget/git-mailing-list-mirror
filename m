Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C434AB1D
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719511; cv=none; b=Ik/vSa/dCn6I9a6O4XW+QLXggHVMPvqHIPZJn+rMWnALs6GG+76k1gQLHghg1n8RSG4BeYidlSxYodbPwNuo3RfFgYo6VP0qacROWM/ztwNIiZUFvI/jeexRSf5kJVwPOqJUYbsR0vfxGnCNucea8WgcBpveUF23sobdRK1U3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719511; c=relaxed/simple;
	bh=DpRJXIBH7wrstHHg02+Ht+pqoKaUvCjRrcYp5KmGXpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFRN+hwy8cHqg35KSutBdMdmq2c3FM9gMhDPULQ7zCj0fT8RSTG/8t3jH1o4+ASM+7tj6uYfIboNlR5Ky/pr8oq4Z9o7VOwYylF82ct1Is1rlC+CHR5TEFr9FKrg/uyGiUTQvW6/l6L+xI3ldPDdMEBCIUPiy5LE4Kbwyuhuu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LCS9ECQz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GW9GDrWb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LCS9ECQz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GW9GDrWb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED35B1400273;
	Thu,  9 Apr 2026 03:25:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 09 Apr 2026 03:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719508;
	 x=1775805908; bh=n8KwFDz6AoXu0urJzGRqRZpk35PzQYIWHvRSFrdGvpY=; b=
	LCS9ECQzkW7bv20d/rFiCOXepjS3Tn3GIkAfr7FX6c5ktwBxB85hFDXWdLhLWcsd
	Q7jk8duCyVgVJ+ln4FjqOfUZHwDBBe7hS38MKJuKENkHeisoTz1c75ftRZPllgNb
	i96gnyZDEFwulA6KKbzL9NTM7xDlUYTXLgRxChG/x13Nfc4Vv30msLKaspxPGfCd
	hqXqwT+lDaVV7zv5SEE/5byuMgzLrTnobats8nAVg4Jnt8TNKEJYn6n+7WQu4+af
	0Ol1znNzL1w4rv6NuTNWCmED2YKnpNDkWRSpgBu748xZWD2XhY6+d+awfFtFTMrY
	lKrsBUauR4z7F0iIsFRxzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719508; x=
	1775805908; bh=n8KwFDz6AoXu0urJzGRqRZpk35PzQYIWHvRSFrdGvpY=; b=G
	W9GDrWb2xG4xuTI3+dA7qPQ7AsZYqVbItjO+DlrgbPd9Vxq7YuIL2MjBZHgmiAg2
	177YbroPIqqfIV80NfPCxorVxwVtbmiKPsPAFpuQ1JYmmO4lHYKA1cNc9h4OTNgn
	GUUChPYLeIa8H8UsgfUS94cuUbCB7M4mFPRIGLMor8Cs8nxEhvG3ROigO7f/v9/e
	6RJdK8AC5+0aEg2xJSaHhuYBMEizSoM5Tq4qz76R7AATI5Ln0VVZuFYNvGmOY3di
	tmUFzw3YHhtnzn0Fr64E23S9SPbw5ok3vxEJHFz2tFi2MP9YaXsgHbTAi/k+mYCl
	tDYlu//U+YydMUotqIOoQ==
X-ME-Sender: <xms:VFTXaSWF6uihIyyqlOzQMSDfivK3w_L08SxBdIMJSS6Ryy09HUcSSw>
    <xme:VFTXaWDmZ2XNwDat9fBC9YLKAIBYMsJepviffSZ8jLyiROKyt0tHdl-1732UsK0NG
    DPHlq54WN_dp3Kde6Fp2OK6zf3wcVgZL876hVfEfMPW5sXHqddJQzA>
X-ME-Received: <xmr:VFTXaTxfNVucFPrgJ-fpjSbEmXSZVmdlCuAQb3AJ7OZNZ2az6Cu1L7mHpa1_dfUXalB22mi0O49GXX6QogvYi2tfBaBbB1LpG3uP3AA3FBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:VFTXaTD4Y4XIp0dDRqlKJAgqDXcQEGdwl32Av6XjaHM14TllNBik3Q>
    <xmx:VFTXaQZILXNCn21YdwjKiD6QHyK6WIvHVSQbruaxr_e9Q5MoJ4863Q>
    <xmx:VFTXabiPFl29Xb-sJ6RB7-38gO8mX_WRpO34ehFfnog1xXlregM0cw>
    <xmx:VFTXaS6LLWPrKG4WGGrM7aAapzE6mN1La9lYPmif2ob_BmFl-KA39w>
    <xmx:VFTXaaBIsW-rGh5avZzzG99scK0-giiVtX46gAvKo1pBCJ0GbXNndkmk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:25:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e73f2ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:25:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:35 +0200
Subject: [PATCH v2 14/17] odb/source-inmemory: implement `count_objects()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-14-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `count_objects()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index a8eba373ee..f038debaa3 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -203,6 +203,25 @@ static int odb_source_inmemory_find_abbrev_len(struct odb_source *source,
 	return ret;
 }
 
+static int count_objects_cb(const struct object_id *oid UNUSED,
+			    struct object_info *oi UNUSED,
+			    void *cb_data)
+{
+	unsigned long *counter = cb_data;
+	(*counter)++;
+	return 0;
+}
+
+static int odb_source_inmemory_count_objects(struct odb_source *source,
+					     enum odb_count_objects_flags flags UNUSED,
+					     unsigned long *out)
+{
+	struct odb_for_each_object_options opts = { 0 };
+	*out = 0;
+	return odb_source_inmemory_for_each_object(source, NULL, count_objects_cb,
+						   out, &opts);
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -310,6 +329,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
 	source->base.for_each_object = odb_source_inmemory_for_each_object;
 	source->base.find_abbrev_len = odb_source_inmemory_find_abbrev_len;
+	source->base.count_objects = odb_source_inmemory_count_objects;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

