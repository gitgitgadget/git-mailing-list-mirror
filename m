Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411643746A
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953700; cv=none; b=YKMPS3FwNwkjRx2bs8aKBtDlW6cDoBh+IFljP75txEMcjl2MbZx7HRjDyaD8HCPGGCX6Nm0TXwfua+LB1OdlcW3r4MOxDXojJOkqTK6zBbzMQXcSYS44P/stv55xy9Yrg8m6K0cZL8YJ9hif09mUAVXAob4p7JL3ifdzXuqViQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953700; c=relaxed/simple;
	bh=2k6eG7izsuTKtzWIWvUs2riQ5qW8MC1CZv3O72OqVWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ths5oAed7bKfAKtB5ktD8HhBYEdWifMkhBk5rn0tK7qOw0qp9zutuzxBkG/ka5GdAbETzeSwDRR7/Wr01R5JKtDsd/FCdhDF63TcV7xekPCm7uEtNe7r4wWSNCfjmlWEzspP8+aKLGjpA2N1fzxtZH2ZFd6mHGSMAD0gmNonLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVtOtrSp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfsxR39X; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVtOtrSp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfsxR39X"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B95397A00D8;
	Mon, 13 Jul 2026 10:41:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jul 2026 10:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953697;
	 x=1784040097; bh=nArudGxJoN4ZWZKhKe9nGn2oeDPxEgYaIdunfOfZtQY=; b=
	dVtOtrSp+rFnO4ZP1oYc/8Fk0GF4sGIr4NVdgVlBL202X9qHqAiBQeJs/02y6nlc
	5g1PfnLSQPqBwLDbKnEuoLQR5ndwGatWBetFy8417VkAE+OjNav/rFZPedhp8Jli
	7B51Ji5WJTyJ+ao8/4LUC0m8Bzz/1CjvK+dVx7GpPmkzz0Fc8l4sfOWo9V2KG6C8
	5Bk6qQfPgAr0DSISg6fbOrY4skhVR97EI8tLap9b7CUQ12rMRsCfcHwSPPO+QPsS
	+8OAuZE7F/UTUvDsSUw4trA2VxaKgL6QImipBtajL4N+/X9jUz0LhOdrZ1pRbYLr
	53hr1DW8a3UglLJG3+sLtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953697; x=
	1784040097; bh=nArudGxJoN4ZWZKhKe9nGn2oeDPxEgYaIdunfOfZtQY=; b=A
	fsxR39XJSJwd0o6GRj5qiDpqin3EKB9VLA8WMjblVd7xAhVZm+Bzf4j40qqRLUgR
	skUvnEpkW6PFMs4SGNjgiiRB2xgvr73XLj4TGx+LUNafqcyjOWevJHf0XQMCXF/E
	0iMBzXcaigHzEpVob4K6IDH7XFJgd/B2H7i1PDNfjHIP/H/PdwiI1lKY7tBS5Jst
	fEUHr2uFgw8kIDdoHkK/3D+YbgvVMgMuBCl2kgEtAQ69Ejg6h181wzQ/HDGFp4wT
	CnQbmRX4QBjE9XMgnfBQBHP/PLh2kS0h0coUfOCk+jIUmrhlzsY6jy8rtIJFazD2
	iV4k1dtMkwcYpJH52c37Q==
X-ME-Sender: <xms:IflUaq3S8LSj_qNdNwpdY6U7G14O9zlv5Wnp7_PQsw3AaT-8K04dXw>
    <xme:IflUaj8IesBBB43T0ttf8JPPVoVZ5Qm6zQjQccsGRl5fwlR1fLcFLcRBx8-pQx0RA
    sdnBbUq5JBsSHzbrqFfdLCy31r_5zI_caSRXENUO7MOsLnTsa9nDA>
X-ME-Received: <xmr:IflUarOvhHZDHCkEPKzgYn_dzg6GZ29qblecflLUqwQubZbH7dMXO9v5sSusNihM1F4hepL58BUPN-WaIKHL-12Murr68cW09O9bD5f2>
X-ME-Proxy-Cause: dmFkZTExU3AaOgeG5BObJ1W8JdQQ7fecPK0PCMuQHCnglnCgDOzkQC0YGMEj1qcLJSgMeY
    LASbvC4Tndv63coRGptPYG0Us/QPdorbjTjJ5eG4DbvGXhIArpLYSfP1Equ8XG1heJbryq
    UDpFgrp5VTZtDpEG/07Jwy4Ag/vYtEFOYaVrF84nTGMkk2meJjHZ4oqMYl9DO/bcxScRj0
    raM+378SqfjY/MjDn56wLasjqjj0AnRoiM+HE2+qWeFjm8zVJqFwrMNDwJJ51dMxeJILN0
    DY3JMGfUUBMmVXNdlp1KiUwRzg3BnBn+tX0Xx+zOe7dMF8plSZ04smH2o1tFL5zomOi5IZ
    /9u6/0gJ2mup7gbIb9KmHMWjOjELO17HXK7wEaP0Wi3fpYr10rJJet6nxJLxvaZCJhQFoD
    6lMrroPhup9lpCjuWVex29BqN1IpzBPkPxw8Qg7lp5xKxCQI4n4VGnl1qKMdZF84EvIvDi
    uUxA9KEij/03XEtTMLeCd7LKr/rpqnQirb+9i2L2jagEOCq418XhjtupD6K27wn/jdmHj/
    fF28WSNwhX7P1Qx+B3TtwI4kuWo6i2157GU4urEp8o35qMCxnPwx7T5fnLfTBzenuvqiGR
    eyhwLN071QcxgeJJ8muWdunCNwCagLnhDcB1S+4rRrRUa+ZzUPz8Oj3w1XqA
X-ME-Proxy: <xmx:IflUanfL_mRWyh577SKAhgK2p5MvKTYg0HuFIpYZHtQxlIql1fVuTg>
    <xmx:IflUaqVIE-S8Ce6p2_uRWopUcOjDG41lAuB59NGHvOGZXglmTXeQ8Q>
    <xmx:IflUaviFkoE9ai6QaJWaI6zQu_kDGu3lBdySWVq4lzpeUkpLdHOMxw>
    <xmx:IflUap8imbZI3qcOeRlM2WyzCJlHDY7SR4vFVCD7vMHAQ1wqLaLiuQ>
    <xmx:IflUapwQuvDzKEvieGDjlhQ4JSLZwj7KWeAMo4Didt4G7vYkV1zj_1-1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef2ef249 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:26 +0200
Subject: [PATCH v3 2/9] pack-bitmap: mark object filter as `const`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-2-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
X-Mailer: b4 0.15.2

The function `for_each_bitmapped_object()` accepts an optional object
filter. This filter is never modified by the function, but is not
declared as `const`. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 6 +++---
 pack-bitmap.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 35774b6f0c..a47c231632 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1976,7 +1976,7 @@ static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
-			 struct list_objects_filter_options *filter)
+			 const struct list_objects_filter_options *filter)
 {
 	if (!filter || filter->choice == LOFC_DISABLED)
 		return 0;
@@ -2027,7 +2027,7 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int can_filter_bitmap(struct list_objects_filter_options *filter)
+static int can_filter_bitmap(const struct list_objects_filter_options *filter)
 {
 	return !filter_bitmap(NULL, NULL, NULL, filter);
 }
@@ -2058,7 +2058,7 @@ static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 }
 
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload)
 {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 19a8655457..47935eb24e 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -96,7 +96,7 @@ struct list_objects_filter_options;
  * not supported, `0` otherwise.
  */
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
-			      struct list_objects_filter_options *filter,
+			      const struct list_objects_filter_options *filter,
 			      show_reachable_fn show_reach,
 			      void *payload);
 

-- 
2.55.0.313.g8d093f411d.dirty

