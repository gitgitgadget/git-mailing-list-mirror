Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC0B28F3
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337011; cv=none; b=VVm9utD1FPcxVaG8d1xFkilNGTO0SWzaCr2kjosZ8uGdFFoScTsQc4nO3gfeVbOkQYpl13I3Qv+y9y0RYPqQlzFdtrCloHxCg8RIP+bKG4j4QqLNI4dkyB2VzXzZ+qioZG0E1E9XXKmjLU7+nKxyNVrCOLMNOvn0L4rHjKHWn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337011; c=relaxed/simple;
	bh=yNVLrZju5o702Hzs0rv9rMNridaG5C1V/lddD8+8fNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1TUilwlnc7VL83feC+sukCZJr730jZpe71aB9LgU47hlXwcMDlDQSsYRvpIKJNgFPssW2ApIr0vnL7b5wYZWWraJEi4zrLAt1EBDl9uDbb1ffb79VaMSB/sp4GVBACduoW5ScP0F+NhtFRCPU5SK1Ax4ecdn47sxxckT57Vtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F4ES207Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Coc/JeSh; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F4ES207Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Coc/JeSh"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6BC011800080;
	Fri, 10 May 2024 06:30:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 06:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715337009; x=1715423409; bh=QyjI5Ret6w
	ujypSKhG/mvuVjgkJ9denZDhdhGk0hf00=; b=F4ES207QTU3fKIUtKEV8p16/hx
	jVzETLNQ0TeE4EPWjGH9qxWQnM2Ycu6leatXVdL7uGHv/Kgwu+xEvjMVobFawDLH
	tpKx5EZ/wSCNCCx/twkRYhmgq4lB/9sjTO+Iuq+mmM17F97HO8w9I0RTV8Op5ZCK
	tHpGMV1DU3jRn7XAP1stSZW+walJMhK7VXvrrSA19Qc//LkyV5GJg6+pvTVhgL0n
	xNamj/jqo4yDPvB4UtAbJg4RglFpO30Zee+Lsu0qJv5wyTHrRDwtWzLujS8ctMn9
	81lmEOJRsXvMwcvyKYeXdpjd8Fbpsi9pD3CEuGHaYBerDq0nBrUT1ZUupDgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715337009; x=1715423409; bh=QyjI5Ret6wujypSKhG/mvuVjgkJ9
	denZDhdhGk0hf00=; b=Coc/JeSh/zAMatec+TTnsowqkOKCojU42CFv87gG6HPU
	eTXnUb5wjsYq7G7pLfF2Qr0BBlwApaZJoiADUdVYgztXywSpwW4May1E4xkMR4UV
	o19RC0SIoWkYPfjuYUA5xBaoQUEub+pe+EVl12IZIePznhLXI6OlnN5O5mAkc3dS
	HqsWb4LnIHUXwO5iKu89G/r2E3DtW8iATbr3sJ11UaKCjvZsxHrgrCyMPf0CiL/u
	8uFkK2MCB4UMEFjkiDGjCHrFtXOtZnxe/QRHxeZ1xhDI3KPPa6zB/QLtnVSL1cK2
	EjOwovnTceMyyOk3+cV39eBqbIhAKwkVIrGlyWDr/w==
X-ME-Sender: <xms:MPc9Zpg2iTSWve-8pcq3_XXvOI4RFvYctNdpkLpxxf3VyoIuo_hEKw>
    <xme:MPc9ZuDqjhF5C7VxA6G4-pVazyod6eT4q1IsFaU0vE8armTq1VAo6D_E2FyP_ySsH
    5mMeQGOW_bdfFjTYQ>
X-ME-Received: <xmr:MPc9ZpGZv576jJAjVo0Iw7EqwVE6Yl2Dj-5xjDkuIdrCV9VzI5l52VNNt0vs9_o-2q-LNTRO5PxqiJ2LfC_PlhgS61ksmJs1Ri5Z8ZLq2UyX68eNFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MPc9ZuQUHFCciBthQzAYIM1DhUKosAW30_1m6yqwVRf5ICWIung9Ug>
    <xmx:MPc9ZmyBLY3_aR1HYviD8lHI2SQyRb1BNiZcWdrJFM4NHCDswKiIfg>
    <xmx:MPc9Zk6_HXfFdNjg1sizJ0Oxs3UE3NVHzGl44kRV8HfWy7CKdsNPuQ>
    <xmx:MPc9ZrwZEOTWKrw35bx0vee4XKaoVGZnWTvJCpLn5er-kE02fOnqKw>
    <xmx:Mfc9Zq-AldLE-r-WjTE0WBHCHD4M-aF5jgJIpqJzwSVV690KdJjMAy2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:30:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 12030245 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:55 +0000 (UTC)
Date: Fri, 10 May 2024 12:30:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/11] reftable: make the compaction factor configurable
Message-ID: <9d4c1f034038df2ae232b6665a0d9d7ee5833c5f.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9J7B1ox2vPygH+xh"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--9J7B1ox2vPygH+xh
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
index 4cd8ebe6c7..155457b042 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -49,6 +49,12 @@ struct reftable_write_options {
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
index 7b4fff7c9e..762954b181 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -10,6 +10,7 @@ license that can be found in the LICENSE file or at
=20
 #include "../write-or-die.h"
 #include "system.h"
+#include "constants.h"
 #include "merged.h"
 #include "reader.h"
 #include "refname.h"
@@ -1215,12 +1216,16 @@ static int segment_size(struct segment *s)
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
@@ -1252,7 +1257,7 @@ struct segment suggest_compaction_segment(uint64_t *s=
izes, size_t n)
 	 * 	64, 32, 16, 8, 4, 3, 1
 	 */
 	for (i =3D n - 1; i > 0; i--) {
-		if (sizes[i - 1] < sizes[i] * 2) {
+		if (sizes[i - 1] < sizes[i] * factor) {
 			seg.end =3D i + 1;
 			bytes =3D sizes[i];
 			break;
@@ -1278,7 +1283,7 @@ struct segment suggest_compaction_segment(uint64_t *s=
izes, size_t n)
 		uint64_t curr =3D bytes;
 		bytes +=3D sizes[i - 1];
=20
-		if (sizes[i - 1] < curr * 2) {
+		if (sizes[i - 1] < curr * factor) {
 			seg.start =3D i - 1;
 			seg.bytes =3D bytes;
 		}
@@ -1304,7 +1309,8 @@ int reftable_stack_auto_compact(struct reftable_stack=
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
index 3316d55f19..f6c11ef18d 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -767,7 +767,7 @@ static void test_suggest_compaction_segment(void)
 {
 	uint64_t sizes[] =3D { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
 	struct segment min =3D
-		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
+		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes), 2);
 	EXPECT(min.start =3D=3D 1);
 	EXPECT(min.end =3D=3D 10);
 }
@@ -776,7 +776,7 @@ static void test_suggest_compaction_segment_nothing(voi=
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
2.45.0


--9J7B1ox2vPygH+xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99ywACgkQVbJhu7ck
PpQB6g//fdMHg4MTTAD1E2YrFpuI8VpiMzkMsDJUmBsh93bk6aMiPQVxYpQ6tXY3
W3pLM/zG62heHQ/Ef2PKVW1dksrjixOVx5Ika3Vjh+91a6IOlSH8k9Si65ZbgxF6
ypBZK5qCJKw9IiJeV4vfHAwnqWMen8HWtFA1CZzLok0DZsRO6KeQUIk7TN0SUhSt
tewGhMyJCk+iUSnm4fT/hhp7yEKGEbmy4Q4bXBmnuqqsN47SG0rOLIvfAj8BSbXQ
+GFFYXwZcHrwIDP0lmXYXHhZminODWdOEKHt14m0QNBEiVlvmpVnQOdqhuIQd5RT
x/HHf64jvJenBL0anJzwja9Re727IdhtFuKNrHsk3vwtrnxrlJKvR2D2t83OcfVW
l3y+kdShIWJYk4TWbPf+08+JqUMYWHtOJOZ0KOF3fR8DAezodM5hbZcYBgrR4l+i
f+MPmoCzMax4h0xQWbr1hkpnxQ1t4Yvlj5byq6dfoHff39KRVOGOAbmSZTEM54+8
vdsa3FFc8nRTUrvaP5NxCUX3HYaJt9up6x8n03OlnPC+vF+amdzPc5JvA4ZVJ7cx
XeFCyfeqdVIVdaWm569KUVqmZDoNxzsm5ITTiHm+IGGII/9/KIgEiqrv8aHLtg76
0ka2bJI+BdQXGa0OGlvmf/gvIRj6AJ8GFTL3sJZGu2Kd3Oayzwo=
=nDnC
-----END PGP SIGNATURE-----

--9J7B1ox2vPygH+xh--
