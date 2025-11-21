Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516233396FE
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710894; cv=none; b=dDmiCpc2wqJnG/7nICDrnM9L2AZr+4h+omH6i9lN5sZc7S2z5jJou1TLWqwmksGHjd+UdcY075LijtGvVjL9OVsUdOw0GQEy0Qb2p4ByMyHNnyyJcF6I//GCR6d2feHsMyggRkwDDxHzU8ZhiFRed9WyArF6ZZLulyLkZ+flvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710894; c=relaxed/simple;
	bh=mwsnL52d8Ckux+P8vXByQwgGeCatGzOz9+yXwMiANEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YScYqAg2te2bBGhomnHUCzW7q1vzCgvBqzX1XRDk4QG9DBD0MQCyKgXZNfmjTIdSi+ToyYSrKGRlEWWMUvb0a5O8tQYYbOuDRIXlXotp6W9cpT+pdYJ4xiNpx8bSOqNOhQUmW7NB5wfH31num+qz0gp2ql7pfYDSANWfjUcmbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g/KMbBQx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJ/hUti6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g/KMbBQx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJ/hUti6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 984B37A0290;
	Fri, 21 Nov 2025 02:41:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 02:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710891;
	 x=1763797291; bh=j9wWz6IH171yfXThYAstkG6tV1ALILYXoTK6pIFTDXU=; b=
	g/KMbBQxPUj8qzqTuYvu7HQWtG7B9EBAmRGWvbb7kYhZ2XVGydxYVoGbJiNdFGEv
	jULjvyWzp8RXWkEkON4FFVxVGMCJSWgKl7fcrnszUAdxHPRx4NtgYBJdFQG3PV2v
	mv0TImClbvq0ReNAP+EQK7vOuJMXGenRmCZjzjWeAqFn/ZoiqulUG+WbzgYlnh+8
	veyg+7PhO/6IZDplVf4uE6wATKi/lkSU8TbYsL8VO8JBo765M3mL55WYiAJg16Bo
	wyx/5Ono64UcKEIB0wLbxiglhT2SiIAoAOqIwSlLk27mMjMQU6htNynZHHI1RK/W
	QbL/HEFCD0sT9ko5mMCKkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710891; x=
	1763797291; bh=j9wWz6IH171yfXThYAstkG6tV1ALILYXoTK6pIFTDXU=; b=i
	J/hUti6dMg4q/hpyO2BF+2FkeqW4F6sKZfH62wTLSFMU2xEIRXydjaxbsIR/9cvO
	Op/ugIduY//zdI18DYRgpF7Ncl4dBeQ6M5BryK+bGfsBo2Ikh4cDwteYOUxwpu8a
	69G2fhgdVOKG9t1gdxmWhcx9a6C+7SVgDoUqAr5hQxIQESqLoOCC7u5rcXyJVjOa
	va16CNrCiUiPOpEHV98S7UfF+bfoi4+i9OUMm6ICR9HltwaX5qdkqpRz4O0d3zaF
	e6s8iQ63NfQvPOQ/dMEKi2/mGDVyq7SahZdZep2bGu/svw5EoL4YVNhgQGXrOYa6
	WBXCF0bAIjlDNMQNMMdSQ==
X-ME-Sender: <xms:qxcgabh8iX16699lW4QRVI6HOsyELN6kzODGak3GY2KAww-eMXMFsA>
    <xme:qxcgafdhCTXR-WOxkcIrbiYVV_dJKY9W_eFtsyWrPYmT3lFivdYYfpJgK2C6g9ucJ
    d-m_R969Z3_NZqkziDOnvJjC3JZj9GePuc1mODNZzZyR5xL1QXlAg>
X-ME-Received: <xmr:qxcgaYeoNLmSo1No84-adKccNZ33ngX69HDVaVz4KMM95MlEn0SQX4UF9ZkXJcq_MtzEY_NJxAGFSH1p1UKB9iULmier_3YmJYa0AGLPJYoT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:qxcgaR-PE4KDux8trHP5AwWPzPmmraNJ6b-kSkA99hnTb-WDF_Bfrg>
    <xmx:qxcgaclF3zEP7pmJKpwuiyMOf_b6d4Be0KYfHUIuMWmPbNrmf7c51w>
    <xmx:qxcgab_NoIKl734OZHClgK4s-L1OzDJtVuHzfhx_npOtswLFJQMI_w>
    <xmx:qxcgaSk-ONMV1u_UZKEixOCnO9g3tZ3hVF8T3J7jNM7uEhKGh5v3Qw>
    <xmx:qxcgaa5BlHHqjumKGYn98K1LAzREqNqpJZj62RxeCu_ZC5HXLE_-P7iq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:41:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a9eb6700 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:41:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:40:53 +0100
Subject: [PATCH v2 08/19] streaming: create structure for packed object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-8-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for packed object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 75 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/streaming.c b/streaming.c
index 193405d11e..014c9b8d90 100644
--- a/streaming.c
+++ b/streaming.c
@@ -39,11 +39,6 @@ struct odb_read_stream {
 	enum { z_unused, z_used, z_done, z_error } z_state;
 
 	union {
-		struct {
-			struct packed_git *pack;
-			off_t pos;
-		} in_pack;
-
 		struct filtered_istream filtered;
 	} u;
 };
@@ -287,16 +282,23 @@ static int open_istream_loose(struct odb_read_stream **out,
  *
  *****************************************************************/
 
-static ssize_t read_istream_pack_non_delta(struct odb_read_stream *st, char *buf,
+struct odb_packed_read_stream {
+	struct odb_read_stream base;
+	struct packed_git *pack;
+	off_t pos;
+};
+
+static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *buf,
 					   size_t sz)
 {
+	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
 	size_t total_read = 0;
 
-	switch (st->z_state) {
+	switch (st->base.z_state) {
 	case z_unused:
-		memset(&st->z, 0, sizeof(st->z));
-		git_inflate_init(&st->z);
-		st->z_state = z_used;
+		memset(&st->base.z, 0, sizeof(st->base.z));
+		git_inflate_init(&st->base.z);
+		st->base.z_state = z_used;
 		break;
 	case z_done:
 		return 0;
@@ -311,21 +313,21 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *st, char *buf
 		struct pack_window *window = NULL;
 		unsigned char *mapped;
 
-		mapped = use_pack(st->u.in_pack.pack, &window,
-				  st->u.in_pack.pos, &st->z.avail_in);
+		mapped = use_pack(st->pack, &window,
+				  st->pos, &st->base.z.avail_in);
 
-		st->z.next_out = (unsigned char *)buf + total_read;
-		st->z.avail_out = sz - total_read;
-		st->z.next_in = mapped;
-		status = git_inflate(&st->z, Z_FINISH);
+		st->base.z.next_out = (unsigned char *)buf + total_read;
+		st->base.z.avail_out = sz - total_read;
+		st->base.z.next_in = mapped;
+		status = git_inflate(&st->base.z, Z_FINISH);
 
-		st->u.in_pack.pos += st->z.next_in - mapped;
-		total_read = st->z.next_out - (unsigned char *)buf;
+		st->pos += st->base.z.next_in - mapped;
+		total_read = st->base.z.next_out - (unsigned char *)buf;
 		unuse_pack(&window);
 
 		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->z);
-			st->z_state = z_done;
+			git_inflate_end(&st->base.z);
+			st->base.z_state = z_done;
 			break;
 		}
 
@@ -338,17 +340,18 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *st, char *buf
 		 * or truncated), then use_pack() catches that and will die().
 		 */
 		if (status != Z_OK && status != Z_BUF_ERROR) {
-			git_inflate_end(&st->z);
-			st->z_state = z_error;
+			git_inflate_end(&st->base.z);
+			st->base.z_state = z_error;
 			return -1;
 		}
 	}
 	return total_read;
 }
 
-static int close_istream_pack_non_delta(struct odb_read_stream *st)
+static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 {
-	close_deflated_stream(st);
+	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
+	close_deflated_stream(&st->base);
 	return 0;
 }
 
@@ -358,19 +361,17 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 				       struct packed_git *pack,
 				       off_t offset)
 {
-	struct odb_read_stream stream = {
-		.close = close_istream_pack_non_delta,
-		.read = read_istream_pack_non_delta,
-	};
+	struct odb_packed_read_stream *stream;
 	struct pack_window *window;
 	enum object_type in_pack_type;
+	size_t size;
 
 	window = NULL;
 
 	in_pack_type = unpack_object_header(pack,
 					    &window,
 					    &offset,
-					    &stream.size);
+					    &size);
 	unuse_pack(&window);
 	switch (in_pack_type) {
 	default:
@@ -381,13 +382,17 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 	case OBJ_TAG:
 		break;
 	}
-	stream.type = in_pack_type;
-	stream.z_state = z_unused;
-	stream.u.in_pack.pack = pack;
-	stream.u.in_pack.pos = offset;
 
-	CALLOC_ARRAY(*out, 1);
-	**out = stream;
+	CALLOC_ARRAY(stream, 1);
+	stream->base.close = close_istream_pack_non_delta;
+	stream->base.read = read_istream_pack_non_delta;
+	stream->base.type = in_pack_type;
+	stream->base.size = size;
+	stream->base.z_state = z_unused;
+	stream->pack = pack;
+	stream->pos = offset;
+
+	*out = &stream->base;
 
 	return 0;
 }

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

