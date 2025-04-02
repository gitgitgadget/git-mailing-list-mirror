Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6A237713
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592426; cv=none; b=kUWcMHFJn/7nJw24xSLtxsYHPSS90HAXHFq3MKKlTyqka1rAoSzTJWhjdwRPwP4aysKC8lpEv6GjBTSykIJF3rsOgkjzK/PfnhJEXhWsm+45efBi9JYPiJVaABRXKZcYJ0zPf/+H4RMbRuFO9oTMK+Yq/9gRusVY4EImjFY7U6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592426; c=relaxed/simple;
	bh=0NLvHYAJHvJVExVhH7kFlhUkalY5gBu2H9SneaznwJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaTmV0/iblLrJkzTYYzBsd1BnyykcU4mOZMM0bcaa7BLPM/EKEZH/yh1TFNfTjnhvBb1w7ElcMxz0m3DOlnYp80VvmCi/dCwO0066WxsfoviWyAD18W+3QXE2PB2lQTrs+pBIL/lKZT6FrUmpZRwxSUQrS7H6twaB27GDeUT//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XXgftPY0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FcFVmyJ1; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XXgftPY0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FcFVmyJ1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2914D2540170;
	Wed,  2 Apr 2025 07:13:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 07:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592424;
	 x=1743678824; bh=UtXojlC87RDtra5EnEB/n/x6GYjDIcGnIfFKJ/KAyhg=; b=
	XXgftPY0zM9dw4rbFfQoxhSAyPhJLUpVrJGITTK2TvUkMhtYT5KG3aZ4uSNk79Jw
	dquM/PY3WqDDAgJp8HwK9OL/yyuGeKY7HxCEjJnHUXz5EY5RVV4NhtJQk/+vIJoW
	oQtb+1mhmZLliC/I4S2bVknFaw/j6VV5G6ir1wB79TcnnCN0bkiuRnZiWwE/Jugg
	Iq7wqrIsPXPFioUZBC4qhfRieLmd50hKSpiBsN49A1SH+qA6zZBXfBFk7w+h9sqi
	5hKfIDugi84GIpkX3siJlUVxNrR9T1t0KgTrmyhL24v0UiDhmJWdwmpXUjfb+mwQ
	n1+fawsMIDx097IBz7FiGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592424; x=
	1743678824; bh=UtXojlC87RDtra5EnEB/n/x6GYjDIcGnIfFKJ/KAyhg=; b=F
	cFVmyJ1Wj4ySSn3lI2Lz4n2grQHgFTXiAPEP76cAAy4BKb50YinmrIb60hrJpgGm
	LVnJk4TT1afE5C1IC180IivPYrwCsk9f2NySRYeFLhC0j/FFgC4VS/ZuKryIzbTs
	4qcaGW1QAbw6C67vZ+corsUFkfxAK4W8FOxYcEAiYUZ3b16R8Z7pQXK1AZWdLQ7y
	54v1l0u3ECOwAJ3+nDLnzN9p1eqZVKKAVF1NYm1FU1ZUXZj0MxzS7mP5iDhg1y41
	pk2pkpRI0/0FLZBMjQOSDM6Otu8WOTiw/L4/mLUH1/3nQ+jco3xiBzX0aVrJEICx
	+gGJKFT9doQq3DjMheiTQ==
X-ME-Sender: <xms:5xvtZzj_CTYT0Sb-AZanUyAgTPXpQQTYb_uyiDfXrkH17Oa9IV7pyg>
    <xme:5xvtZwAXJB38VRyxThiBtmMJZyzlisdX6lH6_EC9O53wrZm7IykSTz8-eeOSHEzTf
    UnSD-uMZZ0_hhVbkA>
X-ME-Received: <xmr:5xvtZzEjaADxdMrCjSB69QHy0Ky0UTQQQU8s4-bKZVLp2h8s4c-GEqg90w-Pmxqvv6QKMupJGsbb7d45bWcsPY_WlR4Cfoo1AAjQGu2QrsNxvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5xvtZwRuBPBlBzDiZ709NG393ppaydAlr8CPhPpv3rKbsvn_xJ3Mpg>
    <xmx:5xvtZww0rkyDdAgeA3xZTXepfBwx7ybtp8ShMwDJWzJl6IIZ1pr4gg>
    <xmx:5xvtZ26N5Qz6O5npnL8RF4VmgXNvgo8TNj0XiJ4uYaXMo8PUE7pD0Q>
    <xmx:5xvtZ1yd0_JsreEDytkozTegLi2CcaFphkOVJD8wXdcXkSZn35a2rg>
    <xmx:5xvtZxjG4xqmf-qUK646N2YlvX4dsw-TziEFCda52UZgQ6DKTSnPJW_q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d85eaa1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:37 +0200
Subject: [PATCH v3 02/11] builtin/cat-file: introduce function to report
 object status
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-2-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have multiple callsites that report the status of an object, for
example when the objec tis missing or its name is ambiguous. We're about
to add a couple more such callsites to report on "excluded" objects.

Prepare for this by introducing a new function `report_object_status()`
that encapsulates the functionality.

Note that this function also flushes stdout, which is a requirement so
that request-response style batched modes can learn about the status
before proceeding to the next object. We already flush correctly at all
existing callsites, even though the flush in `batch_one_object()` only
comes after the switch statement. That flush is now redundant, and we
could in theory deduplicate it by moving it into all branches that don't
use `report_object_status()`. But that doesn't quite feel sensible:

  - The duplicate flush should ultimately just be a no-op for us and
    thus shouldn't impact performance significantly.

  - By keeping the flush in `report_object_status()` we ensure that all
    future callers get semantics correct.

So let's just be pragmatic and live with the duplicated flush.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b158b3acef9..1261a3ce352 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -455,6 +455,16 @@ static void print_default_format(struct strbuf *scratch, struct expand_data *dat
 		    (uintmax_t)data->size, opt->output_delim);
 }
 
+static void report_object_status(struct batch_options *opt,
+				 const char *obj_name,
+				 const struct object_id *oid,
+				 const char *status)
+{
+	printf("%s %s%c", obj_name ? obj_name : oid_to_hex(oid),
+	       status, opt->output_delim);
+	fflush(stdout);
+}
+
 /*
  * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
  * which the object may be accessed (though note that we may also rely on
@@ -481,9 +491,7 @@ static void batch_object_write(const char *obj_name,
 						       &data->oid, &data->info,
 						       OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
-			printf("%s missing%c",
-			       obj_name ? obj_name : oid_to_hex(&data->oid), opt->output_delim);
-			fflush(stdout);
+			report_object_status(opt, obj_name, &data->oid, "missing");
 			return;
 		}
 
@@ -535,10 +543,10 @@ static void batch_one_object(const char *obj_name,
 	if (result != FOUND) {
 		switch (result) {
 		case MISSING_OBJECT:
-			printf("%s missing%c", obj_name, opt->output_delim);
+			report_object_status(opt, obj_name, &data->oid, "missing");
 			break;
 		case SHORT_NAME_AMBIGUOUS:
-			printf("%s ambiguous%c", obj_name, opt->output_delim);
+			report_object_status(opt, obj_name, &data->oid, "ambiguous");
 			break;
 		case DANGLING_SYMLINK:
 			printf("dangling %"PRIuMAX"%c%s%c",

-- 
2.49.0.604.gff1f9ca942.dirty

