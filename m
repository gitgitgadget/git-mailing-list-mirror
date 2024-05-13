Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A81474AF
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588324; cv=none; b=pc1yA/+f6wXRAu9QY0N5mJzMGjYf006m8w2Uiwsu4w+sTl4nE7lkq5g12UnhOQqs2+wXQ/Yboc/jAGLuaNZ7GHRoyRDKHp1JFGU4dIODraHkbDgbklzwBrCjpool7txctM+BO5r1Q7K8+1C2boJAmyfVmGXw78o3Fj/+dM3Fxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588324; c=relaxed/simple;
	bh=L0GLSaWYBGbvpW2G9xZX//MJe3gHLrKWmKxFtXH05D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM2ZuAASS7J93KQNgGKinG0A4pPlQQOgY/WCJYdweqhIX0DWvZ8mFIqhSQsDJi7FUW5x3v+wd2832myvw2FZquftUGFf9ftZuc0kOAEBymbWQuIGKWbonvFRL59A/1s1N1wmg8gkdcIQ8qA8W3fv4D54u50TFXUWzpq+s/gNBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UH8zjaCd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEW12YER; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UH8zjaCd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEW12YER"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 640DC180007D;
	Mon, 13 May 2024 04:18:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 04:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588322; x=1715674722; bh=o9XBmHAi3Z
	KCmBlkAMiA+/yxuXKy0i+3NtEzJQlxuS0=; b=UH8zjaCdqd52nIN1NZKPP1YgYH
	J2Ch1LfylBR6zfLAQMsL7OWAyzrAHyIstKK9lWO+oXxLOjw/CM0+Hn40yweQi3id
	az/BQFDMZPKwhf9j2OfDYOTjjEzu60IKVN/Eiyvcc4LVzhzRKg3ViqTJCSunM7wD
	DU3iFg/YG5Kd985hqaK96UCdY9Sp5nvhIYvnDnwWe9WZ9wg2H417jCxIULa2ALCY
	YsEsjyZwR76JTUekT2l1erEbc5hAYytedioaNAa60+boTCGSjUa/u25Iod5JPteh
	E1KymjWBMEAwGF2C/uh8xJ68iSxOmmp4yFclvsKaiJ1Fg9QCaKHSiMlLFhog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588322; x=1715674722; bh=o9XBmHAi3ZKCmBlkAMiA+/yxuXKy
	0i+3NtEzJQlxuS0=; b=cEW12YERIcGWkBSCeLSjQLfWCMmryg4kFpMft5VJhcpD
	O6KfCSCuQSP2IouOBdPLzf7xfi1l1XNqay+/dmlyQ7jCe06MJieIR1SVf7Yd3HKr
	gcCxm7d8hozZ37Bliw72B/KKJcTORCeS1R955CezO8Rn+e78W7kGS/auxNzLixEN
	4SvAH3S50wNxV7jzspmxHaJ9pa2ff5fO0jwNX1WFGU8/ew4QxiNHE8z3EYz3w3WO
	N51mAoXaIA6IukNAvop8P4V8ldCxv+3BzOU+7yNerdESOK7pJmRHyl2LkYKJ10md
	iYUcPUOj7LVyOSMgERD0RSlTNEbmFw7Z2z4L9/QgHQ==
X-ME-Sender: <xms:4cxBZuRIVd5ZGTt6C4hbX8sZhLumhusL2GErQtE7LNZdHOrLNNXtmA>
    <xme:4cxBZjz98nsdkvxYcmeTybdx0b3RrO3Nr2y9vTY6mW3ZbBYILYPWmDShvVuY2Lmr-
    new1eWm02PqpUtU7w>
X-ME-Received: <xmr:4cxBZr0SqoimUQaGNU_U_0AjUozzd6d5UDQiVRWtFiPxB48krDvX27m7Nv8WI8TR8bUAEF0H9EcRKjOccVyQZ8UokaSREcnsjKmsylGc7hqtnjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4cxBZqA0X27m9BKwl6Qc5G9tS-8yhEHPl1bhBQklfaywl1mfZ32gnQ>
    <xmx:4cxBZnjslAe_bPJFI0-48ets0JTCihxz3BDLO1AidHB3OLfLIl6hFQ>
    <xmx:4cxBZmobY5aofpSnYhyx9drgCuG83kYVG5W9qgpww5j0TojjadPQ1w>
    <xmx:4cxBZqh5Kbf0uezdLVsgZjj0mSK15cpjjfU151QfqyvlpjVTfCidYw>
    <xmx:4sxBZneVIaEPbn0mGltDkDJLjaF9wdWwnlos2PQgUWAN3y7SB_NAY9Us>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 262a4cb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:18:22 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/11] reftable: make the compaction factor configurable
Message-ID: <fb1ca02e7762f1670883e89b2f20be224f9e9706.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9QwOqbay1JROnrF1"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--9QwOqbay1JROnrF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When auto-compacting, the reftable library packs references such that
the sizes of the tables form a geometric sequence. The factor for this
geometric sequence is hardcoded to 2 right now. We're about to expose
this as a config option though, so let's expose the factor via write
options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/constants.h       |  1 +
 reftable/reftable-writer.h |  6 ++++++
 reftable/stack.c           | 14 ++++++++++----
 reftable/stack.h           |  3 ++-
 reftable/stack_test.c      |  4 ++--
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/reftable/constants.h b/reftable/constants.h
index 5eee72c4c1..f6beb843eb 100644
--- a/reftable/constants.h
+++ b/reftable/constants.h
@@ -17,5 +17,6 @@ license that can be found in the LICENSE file or at
=20
 #define MAX_RESTARTS ((1 << 16) - 1)
 #define DEFAULT_BLOCK_SIZE 4096
+#define DEFAULT_GEOMETRIC_FACTOR 2
=20
 #endif
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 94804eaa68..189b1f4144 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -45,6 +45,12 @@ struct reftable_write_options {
=20
 	/* boolean: Prevent auto-compaction of tables. */
 	unsigned disable_auto_compact : 1;
+
+	/*
+	 * Geometric sequence factor used by auto-compaction to decide which
+	 * tables to compact. Defaults to 2 if unset.
+	 */
+	uint8_t auto_compaction_factor;
 };
=20
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index d2e68be7e8..0ebe69e81d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -10,6 +10,7 @@ license that can be found in the LICENSE file or at
=20
 #include "../write-or-die.h"
 #include "system.h"
+#include "constants.h"
 #include "merged.h"
 #include "reader.h"
 #include "reftable-error.h"
@@ -1212,12 +1213,16 @@ static int segment_size(struct segment *s)
 	return s->end - s->start;
 }
=20
-struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
+struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
+					  uint8_t factor)
 {
 	struct segment seg =3D { 0 };
 	uint64_t bytes;
 	size_t i;
=20
+	if (!factor)
+		factor =3D DEFAULT_GEOMETRIC_FACTOR;
+
 	/*
 	 * If there are no tables or only a single one then we don't have to
 	 * compact anything. The sequence is geometric by definition already.
@@ -1249,7 +1254,7 @@ struct segment suggest_compaction_segment(uint64_t *s=
izes, size_t n)
 	 * 	64, 32, 16, 8, 4, 3, 1
 	 */
 	for (i =3D n - 1; i > 0; i--) {
-		if (sizes[i - 1] < sizes[i] * 2) {
+		if (sizes[i - 1] < sizes[i] * factor) {
 			seg.end =3D i + 1;
 			bytes =3D sizes[i];
 			break;
@@ -1275,7 +1280,7 @@ struct segment suggest_compaction_segment(uint64_t *s=
izes, size_t n)
 		uint64_t curr =3D bytes;
 		bytes +=3D sizes[i - 1];
=20
-		if (sizes[i - 1] < curr * 2) {
+		if (sizes[i - 1] < curr * factor) {
 			seg.start =3D i - 1;
 			seg.bytes =3D bytes;
 		}
@@ -1301,7 +1306,8 @@ int reftable_stack_auto_compact(struct reftable_stack=
 *st)
 {
 	uint64_t *sizes =3D stack_table_sizes_for_compaction(st);
 	struct segment seg =3D
-		suggest_compaction_segment(sizes, st->merged->stack_len);
+		suggest_compaction_segment(sizes, st->merged->stack_len,
+					   st->opts.auto_compaction_factor);
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
 		return stack_compact_range_stats(st, seg.start, seg.end - 1,
diff --git a/reftable/stack.h b/reftable/stack.h
index 97d7ebc043..5b45cff4f7 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -35,6 +35,7 @@ struct segment {
 	uint64_t bytes;
 };
=20
-struct segment suggest_compaction_segment(uint64_t *sizes, size_t n);
+struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
+					  uint8_t factor);
=20
 #endif
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d15f11d712..0f7b1453e6 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -729,7 +729,7 @@ static void test_suggest_compaction_segment(void)
 {
 	uint64_t sizes[] =3D { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	struct segment min =3D
-		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
 	EXPECT(min.start =3D=3D 1);
 	EXPECT(min.end =3D=3D 10);
 }
@@ -738,7 +738,7 @@ static void test_suggest_compaction_segment_nothing(voi=
d)
 {
 	uint64_t sizes[] =3D { 64, 32, 16, 8, 4, 2 };
 	struct segment result =3D
-		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
 	EXPECT(result.start =3D=3D result.end);
 }
=20
--=20
2.45.GIT


--9QwOqbay1JROnrF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzN0ACgkQVbJhu7ck
PpTGYRAAkchBlRIrZZJnL1LbVWYXEpgij1MM+WveaoX6gOqo/daHCrY5WQTyNcV5
/+B9a1O9mXXBaOKRq7d/x9sCE64+GqJ4qBP0d7kBDCsFZqiH6z0jI0bKnqCKdJ/9
U6w9Q/RqPvQNWzy0oU252DKAsQN8pfitI3a+tkECyY2yB95JYH6T1DeI4uw8I9W1
ZQUuyPtGgWxOAIq9GmzSuqSBIWERhZ6xL7t1J9ZNVCJurc8yqzQ4LizTvnnU2u+P
7Vf/7ZW9QlkAo8AlTaNI8BmYHnowXp8jf8RFe7wklp5ClGbMvt6PWfTQ+bdZjxMm
38oGOuTxlWcE2t9P2vV7ZX6+pLOodm6cQpLKWwCeR2yZNmyAMw43Vv9Sl42CUGtJ
5BntuxvwTKh1lGkQkn76dngKQfK9S6YTjSQJPjM6liISc8/WEr0NI+WimgYejQcF
TR9xgmOH3D0z9qLWbUYqdW/yuTbRcc3uTIecQhDz3EsI6t6X4iyUDcYHcdK/MNns
wdVaQvfCmj8dhVyBZTpSh6v4/f6+4nd4b6+/TrXFwtWfr2EgtaZgoT3PbOzFlvII
Kfta2R4KiiVOw2BMGwnOWpb7jhBc1tv1fLOUfcfaWwCsLlQmZlzbyTIB3tNZnpCP
kjQlM5kNAHbXWjBlTkNV4MeWW9BNV1cMjnwk+9Sk9DeLgMEIWi0=
=i9bR
-----END PGP SIGNATURE-----

--9QwOqbay1JROnrF1--
