Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0330DEB2
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862422; cv=none; b=OQjPbGXir+U4fdYi+3uBXzajfuaibWQkOog3SE9d1cuiIBWubQtDqIysTMlDhCXazprLuD/8QBcgPbS69EhkJ6sAzvHZBK/ynDjU64mHxBt9QkXeNwH65t1ZoZPsKK3A30q2KXCpeRXsHBBnoDEmNUXVkEGU2Z+zv+3GFr9u5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862422; c=relaxed/simple;
	bh=flnc1F9Gybjip9tvRqcVZKX4/JPXLY2/Y2f+eZ1q+nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P90JZtYGaGEbRGtyYfmZ/i4QWxq+ZTXZjFCIE/+UZx53aM9OC42qbJdyNR4dLUVbiRs5z+8+UO2q2Grt+jlBEj5LUaG3m7U3k0wc6huuy1svyxGBdOxNVbR5N/z5InNu/RkGDWzBrObvCkoucbBA2H/M/R5j7nCzjLVNItUZNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GXk1eBYj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VC0xfMBS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GXk1eBYj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VC0xfMBS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF94A14001D4;
	Mon, 23 Feb 2026 11:00:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 23 Feb 2026 11:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771862419;
	 x=1771948819; bh=VXUrmgVphRP1HTSkkzy0TZX3W4kHuDvZh/nY2Ffoaw8=; b=
	GXk1eBYj9bGhTWCJqDmHPJZoJAEShpfSV+uyulW8yAesC6tjDLmL6th4mBK9ReA7
	TyWxSqUpK8QL7yTC8FbcUChZF8pmS8N0BuoBJfd8PL4l/gX1PH/ZvmTLzCFoJMDi
	GTR4LehBYrU32wKHREKZgWRPDPHCORAR5914bQQEHsazco4dS+nRDDQfZh0kGcLE
	zFXiJnWjoeh5/b+wm5RNa/NVWTpnaVRiaQWEq/hrZsX39P12/SXJrc0g40JBwrV2
	T4YNcRQtFcztITD3odDc+flYA6FzkYxPjjsAnXajIHMONl+gFUVgwlGMs8mEnMiq
	ooTmrQpiC2LwOQUL4i08HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771862419; x=
	1771948819; bh=VXUrmgVphRP1HTSkkzy0TZX3W4kHuDvZh/nY2Ffoaw8=; b=V
	C0xfMBSiUnhm0hmyrk6UMA1Rk/dtw3F+YlMMmXZ3bWY2gKSXIJHvSPIU3DvpDyiu
	659rsG0a7KQG3HqeYmgFl46JBZ781l1JMxMFD8sz/Y1c895KeqqR1RM+O/28RE0n
	997+ioU9pJGTXThvlSm3xXK8kuAr2EqDY6LhfWZ/HRs3HzNqXVyiwsShYpynoy79
	wQWOi79vG1idgxvYQBZy70hWULmssavvYNNYKYwSM2m6F5BDUvzladNH46bXjy20
	Qax/hK+EnmOe9ON5rfDV7EfZjRjKkZ89/pWjIW3KsLA9gS9GZ3IYk53Ca0LxpmNK
	LdQ9jKrOXVl/HVJ9mRYHQ==
X-ME-Sender: <xms:k3mcaYpFUPFEv2GZfx_3-_oyOf51FybKcMnEd03HGk494ih7qy1h_Q>
    <xme:k3mcaVh-DMDBOSRk3xkPC3QDf9cnO-e4JuYBburV9xnWuSq7lizhX21Soe4-fL0BI
    GT9mWrk0FnFuSb3Zoud3lOFJW4-rgqYF9U5OkvU3H_3HVZ53fGAhg>
X-ME-Received: <xmr:k3mcaVhuB2seTuH-61zlTLMF_gvalmbi4OTTKAthU_vMTVVjPoBT_DWdB3ZeEeWp5C6rNRlzQXdFGGTCk9VtIX5QzYaeJHW1MctFp7mSDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:k3mcabg1Ds4g8VM8yJGATGbyHKH_ksFydcnFdx2AjN56mK-1V96C1w>
    <xmx:k3mcaVLsBcsAkHEkGw_UYdJh7ZTkR7oM5qirIy_5ch9_NZUhMWAYwg>
    <xmx:k3mcaaGka78StfQ5Vkv5wcvg5WB-Yxr4KHW0pd4SZUu4HWdsU19aDg>
    <xmx:k3mcaZQGY-8UCtyfqN-HKjVKstAXovMDUjZQcRMPrENZ-EgaEidi5A>
    <xmx:k3mcaX4nPz-4aGlulGAuEoagNKriuPqsjaCMt3yY0mvTh4A6HhbW8mWv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 11:00:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70c5c5f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 16:00:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:00:06 +0100
Subject: [PATCH v2 1/4] t/helper: improve "genrandom" test helper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-fsck-fix-v2-1-99a0714ea3bd@pks.im>
References: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
In-Reply-To: <20260223-pks-fsck-fix-v2-0-99a0714ea3bd@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Eric Sunshine <sunshine@sunshineco.com>
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
argument. This function has better error handling, and it knows to
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
index 51b67f2f87..d681961abb 100644
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
+	if (argc == 3 && !git_parse_ulong(argv[2], &count))
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
2.53.0.536.g309c995771.dirty

