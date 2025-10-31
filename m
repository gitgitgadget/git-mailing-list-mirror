Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6FD2F4A0E
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891206; cv=none; b=AVWY1sahq01EpsKe8FKRLD81rp2rtgz8cshd2hWOmaX/Fc2dHs1bsYoMMUuh8RpoNqaaw9+P2aJINHKa1WTJOfXp92X4zYmqoC5mogSETDGeENT+QM1/1RHdlggTj5wVsra02C8YekNn8eEivSGIz1NvCD05/670UlN+65WAlhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891206; c=relaxed/simple;
	bh=J4V9mZfHUVHiS8riF/IBNrFUEBeua5xvARjr1fl4uxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltdsSyeQEwHl/Ilflr12fJBSpQhq8B7ooPcNTh2P3omXANgBn4GELa8LtliunAuPK0KlrV++7GxYJMt//4ZwXaqjenA0uEN2OtGyyj1ASogkShoWd6waOexGMkdh4MU/KUTPDEl8fyd3rQMqBO87WVRw1dIDTq0H3xI0YMaQUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C9RhokMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnEVigYu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C9RhokMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnEVigYu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 12A47EC0084;
	Fri, 31 Oct 2025 02:13:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 02:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891204;
	 x=1761977604; bh=THKKJL0OMm2pc1uvfGRvOeO0n0ljauoSiK7zQVLxtvk=; b=
	C9RhokMaFc2zs3Sd6Zu1izl8g/hyi5PMhlVTlrp3vIG7b856lDMDThG7npv+5Sha
	A/PAxT0nID+S6yEwAvJDlH1boGuX+nYS1Hlfu191C5h+G1tNsPWWX+ZE0s2/1jk4
	lcRZifhlzsSHDlZPXp6znTSwmarWL22gYrDhbaYFAWFGFXburCFJaceoLsrM7/Do
	C1iVYlrgWdTkVH9DqBpyl8j0gB7dJOBFzV+rJH5BYKmLnyLJNXnxTnZHIoJxKdRE
	SP9tcQHNxYIK+00l+P5tz4rIl26mLa20sc/4p0w0UepzEqCgu/PxN64wuWQJywx+
	jK4iHAskgf4G5VOwW96asw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891204; x=
	1761977604; bh=THKKJL0OMm2pc1uvfGRvOeO0n0ljauoSiK7zQVLxtvk=; b=T
	nEVigYuWfbATV/V2AONXDV4tFfaeKm1BK6rVf+Apoq9+H1kwVy8VV6lCX16awEkw
	HaP0RsvTkqwXVWIFQL5i+pLrOIyKRCAn8oiTVW435J+PpBn8HewLmkNozoGT8qL+
	QKQ2aVcbPnyxsg4vhwPobYFfoiqe+svcHeXDoNlXJAANNllneA+Jm9wgAh05I1w/
	x7S9xmRgDBnpQ+7k6LeUea7VRyGj+sktCKiHNqIf3j7ykPvtEuGiiEEIl5u7rRKq
	yr6Rfj743sThxOMD4738KlBVbnD48vVbWwt3nc0TU1mZgxeiHI1FpEhrziexJBzW
	QcNy6R/qjfVs0FLHo2BKw==
X-ME-Sender: <xms:g1MEaYxAGSjTl-Pn8MYam_uwWqH8uGzub2ubLihk3B8KS7e8oA5mpA>
    <xme:g1MEaTs7oF1diWDvZnzrBqhyTJvoPj3hcNiuMabBlm36xfhowwOXX3W3yHWHUdokd
    cQXX2PslQqGV0Kz8uZH_lKKyyIdy5BW9JHqVAdUWimM2pXNhCDGdQ>
X-ME-Received: <xmr:g1MEaXtCUsskMjYLkNrnahkusf8-MVdifB8U0sslCHHgMQuKOJ9IwT1QZ3Dc2VHD24oU9SQzUo05rZXwIKBHgpkKrfjoDDRsSkzr1VJCWZuAug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:g1MEaQNU71WJuBUzaE2rOSUmcnwTzA3FdI6d361EpbZh7i3UFrUOJg>
    <xmx:g1MEad3yhhPdPwsqwG1OClohtYHYvxXRyt6nm_nmPUWY1SHok8hTFQ>
    <xmx:g1MEaUN39SJLX4_g7s3ZZkGnbPc_WoGp5fMH1byjdJV4PEiiBBOL2A>
    <xmx:g1MEaV0DQeV4GvPcNXGuHiXpLbDEgFAzoAGTPWig9ZXjo4Q5pt-dOg>
    <xmx:hFMEaTsdF47TwlNmC_Ttya3dK3-B4lKgyinRK4X3-Kc6QTZCwLW0ML8a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43df388d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:48 +0100
Subject: [PATCH v2 12/13] object-file: rename `write_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-12-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Rename `write_object_file()` to `odb_loose_source_write_object()` so
that it becomes clear that this is tied to a specific loose object
source. This matches our modern naming schema for functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c |  8 ++++----
 object-file.h | 10 +++++-----
 odb.c         |  3 ++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 5ea24de205d..d3e29e23c13 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1084,10 +1084,10 @@ int stream_loose_object(struct odb_source *source,
 	return err;
 }
 
-int write_object_file(struct odb_source *source,
-		      const void *buf, unsigned long len,
-		      enum object_type type, struct object_id *oid,
-		      struct object_id *compat_oid_in, unsigned flags)
+int odb_loose_source_write_object(struct odb_source *source,
+				  const void *buf, unsigned long len,
+				  enum object_type type, struct object_id *oid,
+				  struct object_id *compat_oid_in, unsigned flags)
 {
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
diff --git a/object-file.h b/object-file.h
index b11a9b95498..428731970af 100644
--- a/object-file.h
+++ b/object-file.h
@@ -62,6 +62,11 @@ int odb_loose_source_has_object(struct odb_source *source,
 int odb_loose_source_freshen_object(struct odb_source *source,
 				    const struct object_id *oid);
 
+int odb_loose_source_write_object(struct odb_source *source,
+				  const void *buf, unsigned long len,
+				  enum object_type type, struct object_id *oid,
+				  struct object_id *compat_oid_in, unsigned flags);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -168,11 +173,6 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-int write_object_file(struct odb_source *source,
-		      const void *buf, unsigned long len,
-		      enum object_type type, struct object_id *oid,
-		      struct object_id *compat_oid_in, unsigned flags);
-
 struct input_stream {
 	const void *(*read)(struct input_stream *, unsigned long *len);
 	void *data;
diff --git a/odb.c b/odb.c
index 6f8f665351b..432011b4dac 100644
--- a/odb.c
+++ b/odb.c
@@ -1021,7 +1021,8 @@ int odb_write_object_ext(struct object_database *odb,
 			 struct object_id *compat_oid,
 			 unsigned flags)
 {
-	return write_object_file(odb->sources, buf, len, type, oid, compat_oid, flags);
+	return odb_loose_source_write_object(odb->sources, buf, len, type,
+					     oid, compat_oid, flags);
 }
 
 struct object_database *odb_new(struct repository *repo)

-- 
2.51.2.1041.gc1ab5b90ca.dirty

