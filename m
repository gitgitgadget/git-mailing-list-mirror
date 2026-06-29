Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D33F86E1
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723752; cv=none; b=BkcuJkgvNDLV5l5MsM4t4TqhuNzHNkUnQzpQhEU/X5nW71HzycLPcZlTfhpmHxKrDHpBYcztTNi0LCaigkbhe/oINr6Oq9i73GNUv1NgI1dv9K3ir/6iuFoGq1XfzKod74V9rw66jE8HH6Fy1c4S+Tuy1BeHoLHv7rR093gNrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723752; c=relaxed/simple;
	bh=XizypFPuvYKH1wjXm4831R1VMpMB5tpCSFOT+/3OXTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TlBUcaBAmi5eDJR9EKnTca4VQyniYWdhU0uEki4aJPwk2+4T7DrVko3vUqHD36OzrBjynrtngZj17wnXPsbcq/UclLgcq30pVE9WpPC9Bo6kpFfNR+LTJHlngsFJeUsyiafr/P2b1Q+in6dQETDY76Dde5aBEAkGby3aLI92Jvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uOfKHWKg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvxP+k7o; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uOfKHWKg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvxP+k7o"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 616571D00085;
	Mon, 29 Jun 2026 05:02:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 05:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723750;
	 x=1782810150; bh=6IMMFB7aYhF1eS43dLAcdaFhvNojVx9QY7kxC0+klW8=; b=
	uOfKHWKgLH9xNGmiqzKifCg/hLHRij76G/mQO8l2d67t+KXZHcJHQWyyUAPldZkd
	o5XGh7uPrFLmDq0rGN5jd+Sfg5pvCVZQa/1GFjamAuKWrulLQhwAXlU09xXakNOY
	zPdlDqdoDjvY+dIzIMUlDz+gJN7WXSjyS91bvU9C66SmxK+qlIKDp7yZNy+q1vDd
	7DbMGFLCT6G5rd7cO8gXBP2TyncbJehOMg4aDv7dIVBxvcJWRTp/GmqxzV3EOHKU
	XiTY0293Yq+1gcGdxewK9eKLK4bC7YIYl5vr9mwrG8D05MDA/ZB/Z2KxWuHhLzS9
	dI1SiHP3GKSNIOw3R1GqFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723750; x=
	1782810150; bh=6IMMFB7aYhF1eS43dLAcdaFhvNojVx9QY7kxC0+klW8=; b=b
	vxP+k7orLolrJ7EkVDld0YDTnmk/AqUpqu5Z0vPgyPDdWToz1n+vhJtKPj2La+o2
	hPoB9aiMX2Sr+NLuxHL1D8EAft3BknPHshHHCTTxaHHPIclcIf8xoshaREKvGvhU
	WmujqujyJQYfr/tFO0QnUiIFjYmlawPJ5M/+G99Sut/xQe88hwf4J785wYubaDW8
	bZHopMpGfnM5DC+SypUei+kC8TBj7+Gx1EcuZbWMyrlT+/2ghbjftXZDDunm+64H
	XUOZbewkrDrAahYbm3ir2bNo3cec6065MqlYDFFG0TjB1neppQZimpTAX3PnQ0Ow
	892rHlA4aODvqczGxx7zA==
X-ME-Sender: <xms:pjRCajsCGU8sfrxvvx3VtxkpqVkhQ9T3Dh1-eqfWvHH_EsmiM1FHCw>
    <xme:pjRCar7s3A8vHU9ASTm67sCSoEWs6k-2kQH7aXVW2RhTHnyi9rKmKgCMY6OSYCFhf
    1mtZbq5gGBkNschwF43MtdgA5S3XgUwzhRHc7jzO9I3CiVo0pMcPbQ>
X-ME-Received: <xmr:pjRCakKJaXVJCsHTO4kxODI6mY6zROqkWqEBGPnoh5nA6KEeG_M6XlcU0dtYZP7SiGPrlbHfBQKTPTMvU0nCJ9J8VXKQrojlsD4aDMEpx5VV>
X-ME-Proxy-Cause: dmFkZTEzzUNbHKrAoRnFG7kjb5PHBSC5DilZz9DuQvxIOUZK07OO1xbaJfnu6bePy3X3q2
    iXvXY+ShX2OmKk7EMyN1A1TvhJzgAhe5VAUAtU3qGvJ1eWTEoDM+tyIbzK22RYocoDHkej
    2lRJkCqF78CHAWByBYmXM08LAKFvHr6wMqb3ptpr7IDKcqd95Rt8Qeh47VWARMfZ/9AOdU
    MZ2GBBoxjzN1dwTnv/IJ6bTeWw10ebN1zZgOHu5jtxpaSxVO5LqMTzt8+YG6biYnm0ilFF
    eFN84Q8o/xqJ5OjhKcA0ouA2NFyCZ7bm5xWnZ9E7Rt1F8el5ZnyON3XMIfMjJJcEfBwUi9
    Xnc3OqDvHEdDkZ2YA/xSoxqFw9HAG9QnKhonOdbAgQoIYmSgjDefih+pGRyGy83mU6coNp
    VXj6j2lcJ+7UwSn1whgTR1KAzeexHAw9TLGoIxDs3aX1t1SCHrpQYc924nepcITYo+e6KQ
    dvx8AWmQ7dQ21VzPZuUIkhj8J2eB9QHyIIfxAVyOp/tS2XU5DqGxkq+pwwaxYolAFu3BeF
    la9sOKIBq/W9ovapwpO0D+5z6dMSZwO7vR2zgfOV61sd+jTDivpZs72oxuHzJAZ3h5utCj
    OaHiK0YXqjqNNT4XY+IaCpJKijb35ab56rFnTPwXxS8sZulXrXs37dGhqWdA
X-ME-Proxy: <xmx:pjRCar5A43w5ekyq1o2CqZk1OX8YoPBFXj7sTZO676D6iqlzt9iBgw>
    <xmx:pjRCanzAdjbKkSM7dC_jczvgWqxJdNfyNUAqVfzdD-EAEWZpLYQTEA>
    <xmx:pjRCavbdYOad-Kj7_6S6etYeObFKQPfw5h5VD2-IxCR3L6qUK0oHfA>
    <xmx:pjRCapSPRH9Ac53INgTYp93B_6UIyIFOYtpQiCqKgtvmakyM_uSPNg>
    <xmx:pjRCau0_ZZJxsj42qETxsBL9FPtCABTd5uWAXV2t4p42OEiZZ4UWpimL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f75ddc4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:17 +0200
Subject: [PATCH v2 04/12] reftable/record: don't abort when decoding
 invalid ref value type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-4-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When decoding a ref record we read its value type from the block. In
case the type itself is invalid we call `abort()`. This is rather
heavy-handed though: the data we're reading is untrusted, so we should
treat the issue as a normal and not as a programming error.

Fix this by handling the error gracefully. Note that this also requires
us to set the value type later, as otherwise we might store an invalid
type in the record.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c                |  6 +++---
 t/unit-tests/u-reftable-record.c | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index fcd387ba5d..1fce441930 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -388,7 +388,6 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 	r->refname[key.len] = 0;
 
 	r->update_index = update_index;
-	r->value_type = val_type;
 	switch (val_type) {
 	case REFTABLE_REF_VAL1:
 		if (in.len < hash_size) {
@@ -426,9 +425,10 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 	case REFTABLE_REF_DELETION:
 		break;
 	default:
-		abort();
-		break;
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
 	}
+	r->value_type = val_type;
 
 	return start.len - in.len;
 
diff --git a/t/unit-tests/u-reftable-record.c b/t/unit-tests/u-reftable-record.c
index 1bf2e170dc..9c95083ef4 100644
--- a/t/unit-tests/u-reftable-record.c
+++ b/t/unit-tests/u-reftable-record.c
@@ -11,6 +11,7 @@
 #include "reftable/basics.h"
 #include "reftable/constants.h"
 #include "reftable/record.h"
+#include "reftable/reftable-error.h"
 
 static void t_copy(struct reftable_record *rec)
 {
@@ -202,6 +203,29 @@ void test_reftable_record__ref_record_roundtrip(void)
 	reftable_buf_release(&scratch);
 }
 
+void test_reftable_record__ref_record_decode_invalid_value_type(void)
+{
+	struct reftable_buf scratch = REFTABLE_BUF_INIT;
+	struct reftable_record out = {
+		.type = REFTABLE_BLOCK_TYPE_REF,
+	};
+	struct reftable_buf key = REFTABLE_BUF_INIT;
+	uint8_t buffer[1024] = { 0 };
+	struct string_view dest = {
+		.buf = buffer,
+		.len = sizeof(buffer),
+	};
+
+	cl_must_pass(reftable_buf_addstr(&key, "refs/heads/master"));
+	cl_assert_equal_i(reftable_record_decode(&out, key, REFTABLE_NR_REF_VALUETYPES,
+						 dest, REFTABLE_HASH_SIZE_SHA1, &scratch),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_record_release(&out);
+	reftable_buf_release(&key);
+	reftable_buf_release(&scratch);
+}
+
 void test_reftable_record__log_record_comparison(void)
 {
 	struct reftable_record in[3] = {

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

