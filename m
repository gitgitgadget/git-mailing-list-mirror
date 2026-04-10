Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5A3BED10
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823177; cv=none; b=S5KWFQ9Rnclmh435wqYd+nY0nr0g+EqtyD5MgryS3wL6PHMbzSkAbFqigHs/87dbgnwMZao39UQsuQQH+VHx/A9vWAwQFcREnaMz1k5uCe0PWNtldZR8+3/B5HiKXV3r5I6nvMpJ80pwyxoxphgmR73jrOh6kXyLnrsKBxmM63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823177; c=relaxed/simple;
	bh=1ViBqmAiJLkninU07KNO0VB9C9cG2JofaaGiiyn6uyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAnzU4DDzmHhiwnGK/qYQ6p/7mx5qTCVVUyYzr+djy13vjq5f3itf7cyxZJb2dhXkjuIzz5d85b8un6HX61UOkt/T+dURtERlRdg8+z0tsIEkS6ToSRJ/rgcfv44M2Ie2f1n1f026XA29tjzChLiW1yyQtacK7ePyYR8O3MbU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rhLr1Ybv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxmTh0R7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rhLr1Ybv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxmTh0R7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5CD07A00E8;
	Fri, 10 Apr 2026 08:12:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 08:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823175;
	 x=1775909575; bh=0CNgDHrhhjZ3e8d+TK+COnDPl7pq33LH7hH6FLIgMYc=; b=
	rhLr1Ybvk7NxaTBClXQK+vtzIRDODdECNEDsY81gV55nwvjJEGZ5sRFaHvkvlo4r
	1+4KKjkJSTvkSA0FE4jOoJ1CKIMaypkDm3Z4OmdmCAm4heJliEqAlltRhXV4CUwi
	wLEC9Sz7KfxDoK0jdL0k7fU/EwTRFNp/QLKMBOjTPVTt9CXJFmM+qG7i1wNZqAYr
	etG7uep0YnjVuHdA+Jxm+5w6xWai74kG7JBNFY2Tx35+0RfoSp/+sf88IFGP1diY
	kQdg0eJaZsdJt1lcyNflHbP1wXLqMattOgDA/Mp2lVZpyseEf70mcz2swyriO1fW
	uAbhjxhvZkWNfX3vm3L36A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823175; x=
	1775909575; bh=0CNgDHrhhjZ3e8d+TK+COnDPl7pq33LH7hH6FLIgMYc=; b=L
	xmTh0R7bo8cnVr8Dbqc3TfE/6e/YZfCPwLyMnUrhpqgHvGwKCn0THBrAfO03W8To
	+r3jt7zIDe8rplVNMD3SZMSqrPWWOSvZErs+7cB5nHm9+Kt8pCk3GX6m+jlcVTIG
	mdOuUE2EGStY2DYj5y5egrWIbqJhTsj6l/g6TrGNxYUlzjWUVqZQAspfcSAshFCm
	eDqIVVDPcIxqp4aAPyPOx69jGJoUWkexX8DJ9aPXRlHfdGagoU0Hr/NvY9R79p72
	HhBRrzTEWOwQbXeaXYNAR8iL8JdQT4YkD0Lb57mXD5UVbTdpx1ifFBKPf7p5uFIs
	7Z0kvV0j+aGtJBhDxpE6g==
X-ME-Sender: <xms:R-nYaSlwMwyZyaAEgcemUHMX0qqfmAoqiRaEVkcvd6APRCIYrsSalA>
    <xme:R-nYaRSPSQ6rAYhmtdzy1dqLabmNxdTOZEhE2YZNFK0_IHmLJsEedjU1AmpVnPrip
    QscfRolQxl1m6grllzik32EE09zfXcgwD6YP7wHl-fMaPI6FScT>
X-ME-Received: <xmr:R-nYaeDry57ql2KasPML_Wb5yGAtVeHQbK5lzVSkyCoi02WEes2TjldeI7gpu7sNxT0nguDQ8Ii-EbiPaaSOaIZmy7q5Pz0BdlzobcAQlNlOZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:R-nYaQQyCW5SR6oQNNxybVJjhlrG67jjM-gbHIC9SSag1oXx-F4blw>
    <xmx:R-nYaUpf6xpgaeSSOIROJaKSOjapDlVaWu1xoIKlgSxc2G8o5ZgLew>
    <xmx:R-nYaayPnfxZp03eDDPG2XeER-sgv_Fv_k0G9IZ6ra-J0xQqIWWFqA>
    <xmx:R-nYaRK-jSaKoilJ0f8sjHgRGHEHqQPjKo9L8FfelyF-lMvpu__F4w>
    <xmx:R-nYaWr4SZV6GpUJjoxU9SpacH6GZjIZ_dPr_xg1pVZAJSe_-NuJJzm9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:12:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0415b0ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:12:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:33 +0200
Subject: [PATCH v3 03/17] odb: fix unnecessary call to
 `find_cached_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-3-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

The function `odb_pretend_object()` writes an object into the in-memory
object database source. The effect of this is that the object will now
become readable, but it won't ever be persisted to disk.

Before storing the object, we first verify whether the object already
exists. This is done by calling `odb_has_object()` to check all sources,
followed by `find_cached_object()` to check whether we have already
stored the object in our in-memory source.

This is unnecessary though, as `odb_has_object()` already checks the
in-memory source transitively via:

  - `odb_has_object()`
  - `odb_read_object_info_extended()`
  - `do_oid_object_info_extended()`
  - `find_cached_object()`

Drop the explicit call to `find_cached_object()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index 1d65825ed3..ea3fcf5e11 100644
--- a/odb.c
+++ b/odb.c
@@ -774,8 +774,7 @@ int odb_pretend_object(struct object_database *odb,
 	char *co_buf;
 
 	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
-	if (odb_has_object(odb, oid, 0) ||
-	    find_cached_object(odb, oid))
+	if (odb_has_object(odb, oid, 0))
 		return 0;
 
 	ALLOC_GROW(odb->inmemory_objects->objects,

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

