Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E643502B8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840252; cv=none; b=La6Jz/K5neB2TM6lgfP1VfjlunfUVyql3tstHz5XWI2+paK69ktVxIa6q0H7drnPv5HLSp6+fIloVquMfTXTIllHqdu3vdwce/e8u85t66K9xw+yN6RmUb37IQsc+pH3aWq4C3q/KSO/YhchgFPC2hf4Bdu8GX7tjdqjUKLNTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840252; c=relaxed/simple;
	bh=b4NYA9lLCIT9UFMgGAVWlemyhbzpk52pj8bedayk5e0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQmA8Sk9TlHF7byN8m7y9NhTU5eziHxPbQ+wo7pVl6raRAFVWGetPKyFR/l0YBe3TD7k5dA3bRaVcfVL0jEL+dQ2GWM/ViIQEbuw816jTEfSqOf9oISJuFhAOF4I0H/TzBYcvtmdPjpm7IEx+pVxVUpabg4cRXEg7bcXhpKt6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jxMJR5BI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dLEiD9Bt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jxMJR5BI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dLEiD9Bt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3491614001D1;
	Mon, 23 Feb 2026 04:50:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 04:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771840250;
	 x=1771926650; bh=yoQJ5kUjSpq/nFFY9Qb0h4AopyFclrdjg+nSIFvYW68=; b=
	jxMJR5BId9olNs2WmWgWM/m5eBanOe2x8mPlYgyOyg0lckGsXds8wYQLXU1kmrz0
	JrqKkbhJ44WUzD1cQxKF35vrQDJtKhI9hujz5ad3kCr/B1H1JBP5UtHL52GE52xd
	4iyMyViTzk6ZYWS7RFb+sxtwlOZr5xEba9Jlms2KWTYthUuAIG/oCkO7+yxVnIId
	2R5C8maB+K/brOE61L10kAtxsRMCEmhKf2GyQyjg84EqH1LniaOSuOGAt8K5hzzf
	lFs6d9szCuMzEK07AeQ0pxDOj7bPoBeYQGBX64iaUcDzYpaQUHM2EiOZ5XHRImdF
	8IQx6Ahkt+rYM52CGH44/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771840250; x=
	1771926650; bh=yoQJ5kUjSpq/nFFY9Qb0h4AopyFclrdjg+nSIFvYW68=; b=d
	LEiD9Btqscm599d4ODP5FEuu4wQWeKSPt8TAlRmTeT5Gl/jmCQJ9TNrlecI0crPO
	ndbgrTs7Rd/dxKhldsmmKXR+voYfvRUrrRPjvtl7ybEF2Sx00kIrYJgClAI8yLEl
	8U3Dcpulzxg81Gp9L71/z+e4RTGbPPebH2cXYwrh+o3zeeRgqaq8I1uPEfx4aysc
	VkKcqsY48Oxe3e7Cfeq/WhJ7oaewVpcf0vMwpO3FUEFZ5ESU6daGHlxeN3lpeGma
	ISOtnEG4kusrC9ksqPl7DO5s2BCnvG3nOS0Iku/KWuDw3EadRthn5SsSN1+bdtFn
	jWVwNBUdBGYpVKGE2t2eA==
X-ME-Sender: <xms:-iKcacOBloUp0ATmfg6mIwTlCbyvbGNtNxVnVWwQVA-vI63_pdpaaA>
    <xme:-iKcaZ8ynTb5MzlevZQ8sIrXvBEbCBUNMotiKsZrVgADKIDXk1fHKx_RSIeIBPM1z
    WMGJHuIGappjrkXoWzjZ_hcOiDdcv0XpACwFobW8zAnA-JH4tlnbg>
X-ME-Received: <xmr:-iKcaYR153ZSGJGZ9Cvrl1DmNXqE4EgZADqye_xRyfGEK3N876fr_kKTiJJm2Y7GTkOp2CM-cZR0Bkn4pM6k132r3iv0G2FMWhSBjWgG4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-iKcaTmv8Trf9O0d8-6rVDH-ai1QpstyLUzRMlgENmByvDrvU4JHtw>
    <xmx:-iKcaQQHIuA9eiBnIKnE-VbCwqIfao0O9-ALn21_zBh4YKiEPYbxAA>
    <xmx:-iKcaZPiED8IWZURPoQ6rHaj5cPjXrVgIrN8rxA_tb2V9ibv-9m9aQ>
    <xmx:-iKcaRWeL-dnRfmecSvU9b7mQfSwu9HDS2jUp9c3Vik82t3Ed-yeOg>
    <xmx:-iKcaVRvR17MImJXmJdBhf_J_1VDd_d6KnVfc855lV9Tzo-1iYQnwmng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:50:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be92bea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:50:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 10:50:40 +0100
Subject: [PATCH 1/4] t/helper: improve "genrandom" test helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v1-1-c29036832b6e@pks.im>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

The `test-tool genrandom` test helper can be used to generate random
data, either as an infinite stream or with a specified number of bytes.
The way we handle parsing the number of bytes is lacking though:

  - We don't have good error handling, so if the caller for example uses
    `test-tool genrandom 200xyz` then we'll end up generating 200 bytes
    of random data successfully.

  - Many callers want to generate e.g. 1 kilobyte or megabyte of data,
    but they have to either use unwieldy numbers like 1048576, or they
    have to precompute them.

Fix both of these issues by using `git_parse_ulong()` to parse the
argumemnt. This function has better error handling, and it knows to
handle unit suffixes.

Adapt a couple of our tests to use suffixes instead of manual
computations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-genrandom.c             | 5 ++++-
 t/t1006-cat-file.sh                   | 2 +-
 t/t1050-large.sh                      | 6 +++---
 t/t1450-fsck.sh                       | 2 +-
 t/t5301-sliding-window.sh             | 2 +-
 t/t5310-pack-bitmaps.sh               | 2 +-
 t/t5710-promisor-remote-capability.sh | 4 ++--
 t/t7700-repack.sh                     | 6 +++---
 8 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
index 51b67f2f87..77dc31a315 100644
--- a/t/helper/test-genrandom.c
+++ b/t/helper/test-genrandom.c
@@ -6,6 +6,7 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "parse.h"
 
 int cmd__genrandom(int argc, const char **argv)
 {
@@ -22,7 +23,9 @@ int cmd__genrandom(int argc, const char **argv)
 		next = next * 11 + *c;
 	} while (*c++);
 
-	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : ULONG_MAX;
+	count = ULONG_MAX;
+	if (argc == 3 && git_parse_ulong(argv[2], &count) < 0)
+		return error_errno("cannot parse argument '%s'", argv[2]);
 
 	while (count--) {
 		next = next * 1103515245 + 12345;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 0eee3bb878..5499be8dc9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -643,7 +643,7 @@ test_expect_success 'object reference via commit text search' '
 '
 
 test_expect_success 'setup blobs which are likely to delta' '
-	test-tool genrandom foo 10240 >foo &&
+	test-tool genrandom foo 10k >foo &&
 	{ cat foo && echo plus; } >foo-plus &&
 	git add foo foo-plus &&
 	git commit -m foo &&
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 5be273611a..7d40d08521 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -104,9 +104,9 @@ test_expect_success 'packsize limit' '
 		# mid1 and mid2 will fit within 256k limit but
 		# appending mid3 will bust the limit and will
 		# result in a separate packfile.
-		test-tool genrandom "a" $(( 66 * 1024 )) >mid1 &&
-		test-tool genrandom "b" $(( 80 * 1024 )) >mid2 &&
-		test-tool genrandom "c" $(( 128 * 1024 )) >mid3 &&
+		test-tool genrandom "a" 66k >mid1 &&
+		test-tool genrandom "b" 80k >mid2 &&
+		test-tool genrandom "c" 128k >mid3 &&
 		git add mid1 mid2 mid3 &&
 
 		count=0 &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3fae05f9d9..8fb79b3e5d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -918,7 +918,7 @@ test_expect_success 'fsck detects trailing loose garbage (large blob)' '
 test_expect_success 'fsck detects truncated loose object' '
 	# make it big enough that we know we will truncate in the data
 	# portion, not the header
-	test-tool genrandom truncate 4096 >file &&
+	test-tool genrandom truncate 4k >file &&
 	blob=$(git hash-object -w file) &&
 	file=$(sha1_file $blob) &&
 	test_when_finished "remove_object $blob" &&
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index ff6b5159a3..3c3666b278 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup' '
 	for i in a b c
 	do
 	echo $i >$i &&
-	test-tool genrandom "$i" 32768 >>$i &&
+	test-tool genrandom "$i" 32k >>$i &&
 	git update-index --add $i || return 1
 	done &&
 	echo d >d && cat c >>d && git update-index --add d &&
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6718fb98c0..3e3366f57d 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -242,7 +242,7 @@ test_bitmap_cases () {
 	'
 
 	test_expect_success 'splitting packs does not generate bogus bitmaps' '
-		test-tool genrandom foo $((1024 * 1024)) >rand &&
+		test-tool genrandom foo 1m >rand &&
 		git add rand &&
 		git commit -m "commit with big file" &&
 		git -c pack.packSizeLimit=500k repack -adb &&
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 023735d6a8..66af84cd56 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup: create "template" repository' '
 	test_commit -C template 1 &&
 	test_commit -C template 2 &&
 	test_commit -C template 3 &&
-	test-tool genrandom foo 10240 >template/foo &&
+	test-tool genrandom foo 10k >template/foo &&
 	git -C template add foo &&
 	git -C template commit -m foo
 '
@@ -376,7 +376,7 @@ test_expect_success "clone with promisor.advertise set to 'true' but don't delet
 
 test_expect_success "setup for subsequent fetches" '
 	# Generate new commit with large blob
-	test-tool genrandom bar 10240 >template/bar &&
+	test-tool genrandom bar 10k >template/bar &&
 	git -C template add bar &&
 	git -C template commit -m bar &&
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 73b78bdd88..439ab24d23 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -319,7 +319,7 @@ test_expect_success 'no bitmaps created if .keep files present' '
 
 test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	test_config -C bare.git pack.packSizeLimit 1M &&
-	blob=$(test-tool genrandom big $((1024*1024)) |
+	blob=$(test-tool genrandom big 1m |
 	       git -C bare.git hash-object -w --stdin) &&
 	git -C bare.git update-ref refs/tags/big $blob &&
 
@@ -495,9 +495,9 @@ test_expect_success '--filter works with --max-pack-size' '
 		cd max-pack-size &&
 		test_commit base &&
 		# two blobs which exceed the maximum pack size
-		test-tool genrandom foo 1048576 >foo &&
+		test-tool genrandom foo 1m >foo &&
 		git hash-object -w foo &&
-		test-tool genrandom bar 1048576 >bar &&
+		test-tool genrandom bar 1m >bar &&
 		git hash-object -w bar &&
 		git add foo bar &&
 		git commit -m "adding foo and bar"

-- 
2.53.0.414.gf7e9f6c205.dirty

