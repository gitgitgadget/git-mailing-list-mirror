Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900551E9B12
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575906; cv=none; b=gADVUxyfZaq5A5q+M/FWqOw8QFsUB77PbbNQ3uj+sdaLQAOGlSd8Js433VT7ehyp1XCHpWKdNohprVn/Loxs5IRfsNBXt91+7QpWaU3eyupuZswJgQ1ijmhTKJ7lO2Vli8xO4P0isFPhcSKJnvrWyE4SkYiyC7Y7aigdEan/Fp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575906; c=relaxed/simple;
	bh=M10+Mpge/PS0iyp/qKUR/3L2boNVN1Urq7UmGm64DzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qPd+VrELrMK3N2ex+44Cohb6Qhb85gFaIuocsDZ/etc/msRi8EQPud0+rCn8PUMAIvqba37VedE3c343EKEA5r6fBMEOIlj1pdGhYwBnbgeAQMpIq6FvTWnqKyK5yFA1tePPrUE1gA6ymO+lgpOfXndDywYc79bicHE6V6doBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aJ+cGprY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5HwgZRa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aJ+cGprY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5HwgZRa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6BEC7A01A3;
	Fri, 20 Feb 2026 03:25:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 20 Feb 2026 03:25:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575904;
	 x=1771662304; bh=IpMwgyzDUYvF4X5IRFqUs8xOZpBRhYhyVZWxj7QeP7M=; b=
	aJ+cGprYqf7QbC9fBnrcuDMtqm4QXJYE3PHxHGdTqkhVxZw9YkbjM4c9+2aP8eLy
	4S4pXUdV2wEJY4sBOwCL979ND20MFynkCYfHOYyYLIQsI5vLxBgrYfXwD1tGaTrh
	x9MHxDh5MxlNb0amp07CCg4bYf84CDR+TKJUW4uIpSAv6HMptw+lkY9jRAfhy+9k
	VcHjL0qwbPdXkZdM06CXwoIVceEidl1ygcl5o4n2ZBza7lQMCAlbav3U5s6/QFdn
	bThAYMPklhOnbRUqg855A5Ng2fVYTHoVRgl+ub3QQRozXl/X5zubuNZTWvv8XMQT
	k8k7Tn0JcOcCmE5oVqL+wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575904; x=
	1771662304; bh=IpMwgyzDUYvF4X5IRFqUs8xOZpBRhYhyVZWxj7QeP7M=; b=S
	5HwgZRa03CS3XRu3CXGnMHMNbqcwv/D6e28zVEO7rcjL1GodFBdktz4pJv3HoB1j
	d8s81HQvqaShpXcJZ0Z8lLjhkoKWhqK1m0+8B/REjA7lpwD4kB4O6n4BFgbhfC0J
	FNsblzihrXnX4Dn3kLDUpLhvRdCSnqmTDqbmArFp3ZbEfp1b32V4/qEwVm3zRYcO
	cdDmDG96t9gvNVLu6wRJRllqxlCnVkH5hGAUKRUmMb0pePoemDfIs5qXimyOSm6H
	AzPEHCrwNRy4ix2NqIUVw38WX26JeoCJgLB3hENEn4RD+9bN99zcycicPy0cw0jn
	AFICDW6RkEQ/VE2vzaqDQ==
X-ME-Sender: <xms:YBqYaaJlLqu-HcdkJqJvIHBjGWMovAtlVhQkFVpIMCcjAjrB9uNlxg>
    <xme:YBqYaYJx_JfcRIG9tDCBZAY8SltDpm6_vAVgIQ6lJuleW-1ifVFy29ikutK_56iST
    SXJLNmvMshpJkyCoplJ3twvBQZC2DIUbJNbPnS9bXyUvIlFW3tvNQ>
X-ME-Received: <xmr:YBqYaYUWmBjt83AZhPKhwlO3iC_-CP2nYDzA10UiAVlVqfICsgA_ZFDI3cYa2foPP5nA9PUiCoe2ouMofcgqZYw39LXpLAhTfDwyIUQCJTVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YBqYaahdc12hC32nLhwnv1R2RS0JtsmM6SuzxWMwL5oLT2Jg1lExtg>
    <xmx:YBqYaT9O6mALSoGLBLJf0lg-9hy2qT_9eKKsu3k3udV_QmPGltSLUg>
    <xmx:YBqYaUDWuycj7jhJKlYdO9vw58Z_1aSvvuwzU21sU6D1V2aCOXK-mw>
    <xmx:YBqYaQJsDIy8GpgRqHgKIsqnNRIZv5A17g_7vn3qw0uifLjBYa1IWQ>
    <xmx:YBqYab5qK9oL798LKLPMcePFxthYc3b3bmpVDI01nko6dUfchMClAzJE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:25:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9690a07a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:25:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:17 +0100
Subject: [PATCH 13/17] refs: replace `refs_for_each_rawref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-13-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_rawref_in()` with the newly introduced
`refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c |  8 ++++++--
 refs.c           | 10 ----------
 refs.h           |  4 ----
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index ace390c671..0fddaa1773 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -912,6 +912,9 @@ static int mv(int argc, const char **argv, const char *prefix,
 						old_remote_context.buf);
 
 	if (refspecs_need_update) {
+		struct refs_for_each_ref_options opts = {
+			.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
+		};
 		rename.transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
 							       0, &err);
 		if (!rename.transaction)
@@ -923,9 +926,10 @@ static int mv(int argc, const char **argv, const char *prefix,
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/remotes/%s/", rename.old_name);
+		opts.prefix = buf.buf;
 
-		result = refs_for_each_rawref_in(get_main_ref_store(the_repository), buf.buf,
-				rename_one_ref, &rename);
+		result = refs_for_each_ref_ext(get_main_ref_store(the_repository),
+					       rename_one_ref, &rename, &opts);
 		if (result < 0)
 			die(_("queueing remote ref renames failed: %s"), rename.err->buf);
 
diff --git a/refs.c b/refs.c
index 5739804870..454c9dd017 100644
--- a/refs.c
+++ b/refs.c
@@ -1972,16 +1972,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
-			    refs_for_each_cb cb, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.prefix = prefix,
-		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index 7a0c9c3693..2915ff081a 100644
--- a/refs.h
+++ b/refs.h
@@ -541,10 +541,6 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
 				 refs_for_each_cb fn, void *cb_data);
 
-/* can be used to learn about broken ref and symref */
-int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
-			    refs_for_each_cb fn, void *cb_data);
-
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.

-- 
2.53.0.414.gf7e9f6c205.dirty

