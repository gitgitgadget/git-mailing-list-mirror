Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8142EED9
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999837; cv=none; b=nbcdUxHs6FF7IILKn/1wY0XSteS/NRm765QIHU0MSYYe82GNr3IyTnRVCEDKwZk8qKvrGfz3HCBfGn+noGvu22XDfTOt6lt89Ms1JR5HKhMaZ/Nvw6Ls3iVq5nWd00UGHCUxfDp9RGDeKZmT03Rd07kAq8qjIa0E+KSDWJjB7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999837; c=relaxed/simple;
	bh=J9pj0UsE6cJ1pElIurA29+w1o4xlRk/CWYqduo1PK8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mX+0OaV3JIybhVdEkfzi1ZrVi9fb33mQo08QV68yZAZFrB0dcUIGdiklazXRwL0kKLPnkCc9WNYrZRBvV6VXK5DWoEpYf8PMqg7406c792rhaD26Lko9O5+3cfgwNrWSNFF9zYTqp0P1wBdyVYHma/pa5rCv90gWqJF/zUoUGq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WQ3wVP4C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6y2G2tV; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WQ3wVP4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6y2G2tV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F0B01D00016;
	Wed, 21 Jan 2026 07:50:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 07:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999834;
	 x=1769086234; bh=+lGnCwRXIBfZPpF4G00X2HO26xJ7etwGgoR6SRNlKmc=; b=
	WQ3wVP4Ckpuo+5ZAFQ6AafPJlP1wGEPSeh8axxL5xjEm0dE3X0gr0yzwJF2KlO0d
	53WHy9TPQ5pwqFIs98tDIwcqz9X2H+TbZsUb7AapElcwB3QqeCYqFkUTHOqsOkDO
	V9nQ8VUqCHEe/ZZ23vA9aj1XNSG9BLIS7lYzOD0IUS0ys0T78Ozw82b/VTwfe3CM
	HvnIOuptqBtAtBjsfOH8XMiH01RS/0xGIq3oxu+0ZFnZdHT6WtiE69K0TcnusE39
	UPfhKIf2SOuMVgyrWEAVhMXhG1Op3kUwntIYD2LmLnM3yvofDHtmnWpIiwE87C9D
	qFHFPHcbRtU8oY6/OIzopQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999834; x=
	1769086234; bh=+lGnCwRXIBfZPpF4G00X2HO26xJ7etwGgoR6SRNlKmc=; b=A
	6y2G2tVS7nxodwczCs7LBi7Kz12xws7np3C1u9sRUN9UmfaKfmi1fY7btJCbhlFG
	q9KXDVXud1TJI0gyB1KVUcXD/sk7r60OZyQmYo5yQpXS6IcyVkfUmPEqJ/asTCPg
	/Dqi+9Nt89QEzdNZGix+8i+fOyOVC0MuZTz04/UhLKgc37paytPAkPFJlpZzZRwU
	T/c/hLf8hjU5lHKwT38bPBEDf88FJjyQ9kQQWMmWeNFBgiYPLvlzwsLehFgAqXc7
	aqWBGoZisMT8NtXKDyeR3tfpoPH5xt36x0NV+zP79mDwM6jirVcwIE1FwQWrw5+m
	C3NUIXeabZcEgYjft9Z8A==
X-ME-Sender: <xms:mstwaZ1lzIxAQdLxTS8kIxwQr5uwav4UksGZk54CnX810tDiVbcBuA>
    <xme:mstwaXESPcyLIDsYszpWqd2dk51ltgKn6EfNyUN4Qf19d_kpz7GdPNVY6En96Caam
    GXq7RMfFg6P-In12N7j845XVnrI3BQHmzV8B51djAUBwS2vjuTo>
X-ME-Received: <xmr:mstwae5tqEAsxJW47ofU3tPBzmzh0UwKueeZmxQqaY2gs7GiXnNurZ9ucIsgXyOc8wQKOVgEvvJ85UU-npWsF2robcCJKZfGflF8m4laRfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mstwaVuwAm8bX22_hXFpYHXXJN9w3HnceGQHhaMisrBYX04GF-1IPg>
    <xmx:mstwaX4OvNk_Pw2Va2l0zGTxSN5Ze6igd_Onj_-zkFD1U3ozOxpKVA>
    <xmx:mstwaYWt1ZjxP-GisX-FoQqw8L39gE4GlAnUhBe5SpYpv9iAp8j5MA>
    <xmx:mstwaR9zZ-Hz46zWioTOK_wnkQsiGYU-7iNTfLRIGetKFNyK12WQjA>
    <xmx:mstwaaYJOZrTY7NHbuRzk8QmO6jR_dZTY9IIouhWMjvV3VQTXjQKKUYt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96bd5af8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:18 +0100
Subject: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The `flags` parameter accepted by various `for_each_object()` functions
is a bitfield of multiple flags. Such parameters are typically unsigned
in the Git codebase, but we use `enum odb_for_each_object_flags` in
some places.

Adapt these function signatures to use the correct type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 3 ++-
 object-file.h | 3 ++-
 packfile.c    | 4 ++--
 packfile.h    | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 64e9e239dc..8fa461dd59 100644
--- a/object-file.c
+++ b/object-file.c
@@ -414,7 +414,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags)
+				      struct object_info *oi,
+				      unsigned flags)
 {
 	int ret;
 	int fd;
diff --git a/object-file.h b/object-file.h
index 42bb50e10c..2acf19fb91 100644
--- a/object-file.h
+++ b/object-file.h
@@ -47,7 +47,8 @@ void odb_source_loose_reprepare(struct odb_source *source);
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags);
+				      struct object_info *oi,
+				      unsigned flags);
 
 int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 					struct odb_source *source,
diff --git a/packfile.c b/packfile.c
index b65f0b43f1..79fe64a25b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2259,7 +2259,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
-			    enum odb_for_each_object_flags flags)
+			    unsigned flags)
 {
 	uint32_t i;
 	int r = 0;
@@ -2302,7 +2302,7 @@ int for_each_object_in_pack(struct packed_git *p,
 }
 
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags)
+			   void *data, unsigned flags)
 {
 	struct odb_source *source;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 15551258bd..447c44c4a7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -339,9 +339,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
-			    enum odb_for_each_object_flags flags);
+			    unsigned flags);
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags);
+			   void *data, unsigned flags);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

