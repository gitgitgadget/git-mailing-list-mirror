Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9D190685
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759068213; cv=none; b=VrVuxsNBa0UXK+orKMs5pYEmJJaVnFJ/ly2hVMIZ5nQ6+Urb0wCe/D9kkRp5sfhXu9BuhJaz87U95736/cpR6w0Od2rLqNGE7WBDUyewnm9sND5UuLLutYCVJrur0qiZ30ucsP1p41pflF3Y5hBbpMLJMTHacsbhYEKGzj9VGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759068213; c=relaxed/simple;
	bh=/Og2tNETjR+9AZhF51Qg+kUA8BHclR9ASojEgvf3kJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2gCq+z2Mo7iR8ldQlj3MHUWg6VOz59ZyOPfWM+fi8s8G+bh9OyCKLgtgTlhyKVVEqSpMYhFQtUWPJ7ZjVlBolQX55R4V+aoByGhnGmT46C73q3Kk9uqGPsabQVtGkcFTOVrplxVEh1ShPxnrkPHvOk7zunPefFI3GZ+XZzGcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rE5u5YbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ksc/SJpg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rE5u5YbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ksc/SJpg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E9CE31D0010B;
	Sun, 28 Sep 2025 10:03:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 28 Sep 2025 10:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1759068209; x=1759154609; bh=0k
	xDz+/w3+7bUSuoojhRhqEj4QdT4yUgkchLRWSKNI4=; b=rE5u5YbRLC8frgAlDB
	tK2miDRDE73Qhm2Bf6tCGO4K9dSvvp/mQtBdy/3jj5BZNC2sKcyq2b8hp1qIoQUx
	regQQ5BTrZUOvM5z+Nz7HDqsmPCr9uGA7Rl18rbH6qfFb2wdSIRySL6JqmdiE3R/
	7+7Y5Oi+HV4YEHGH5Gc55RzqB0Ef17mfXoHcJOyFW3Y3IfqHWU2VmgUriNI87Ydr
	g8DQ/5vR30wWzK8bxPPR/UbLX+/vFIGEXIAwy4UfQXEq2wb/+8iqZfKu0Fy2G2n+
	bhpnEZ9vW6OFkQ2GWBzZGbR/QNbiPh0zl4wJ0eMJW7hmR1TKN+IDwS1tin+alGw0
	FCyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759068209; x=1759154609; bh=0kxDz+/w3+7bUSuoojhRhqEj4QdT
	4yUgkchLRWSKNI4=; b=Ksc/SJpgz50VjSORADuPiPz+X6WnMquDh6YPzz3j/LaA
	FfYhyUvc1Ic02QX3UEmcgy1eAYVqthENlktdPdjF4JLynTpOgLrimrd633xBR+4m
	hBARNsVmEyDBT9RmfcahtpSYIj0+9Ehs3Z6m5aSDNt+groQ3Y0gjT6OVHcYs2s73
	qG50p3tqg2EeW5T1y+J4A8AQcl/1y03c8H3YXee9e4EMkjbfU2MWoLlmg+3aPn5l
	xdksl17bu4aziDp/BwQk9gBO04a1Fk7Q4bhKMl4NShAO+xqQNxQIhYnMBPzk4sbG
	iUFGD9X2ezylNKqjTZjHN8mQSPugO/R2YZlySaqmnQ==
X-ME-Sender: <xms:MUDZaGy9oTifFaPb7u8uocDlC3pvp85jgMUW-TBqE2C8sgiwS1Tq740>
    <xme:MUDZaIROMI3vBfhJxLqbjf__-ZEsZnQezAuF5wwtXD-MVkZYneeChlbfr2gqIlqjO
    vnnZb_HuCDVVFbmXIlSRDhRvzNzJXSLnU_1aVhFlIWOSPUnULP4>
X-ME-Received: <xmr:MUDZaF_8FJLAj4c_zmJyoDxP0rNUoVeL6aZcKR1VgRcO4k7hVJrfsYNTFYsx8q34TUR9IuNC6HV3jnHqFskOCjMzzZ4eLRxDCcZI2pvw3r15f2bTOliD8Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeigtdertd
    ejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhenucggtffrrghtthgvrhhnpeffffehteegkeefieejffevkeehfefhteduue
    fggfehkeefkeeugfdvhedukeejkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtoh
    guvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:MUDZaHoXGz9BVKbkqdKDzTO67DFsr5uMf_XhwjD-TA4ioLDItcvmlA>
    <xmx:MUDZaKkY34_OodOwHPS4qCALC4ywLIKWU-FoNum2mLUsRHKfS7rwtQ>
    <xmx:MUDZaGJBiZmx3i2z65_g-wl6kg8cy-jXkQZ-XEC-blxam03Wt0t_lQ>
    <xmx:MUDZaHyVG84HNRQhQxGO9P_Wcavx3J0Z0BCss67ge9ytKYWd_67yqA>
    <xmx:MUDZaKLxnWeUt27dmvR7p6q6w1xdBPSjHcJxsxTaVA3Zzc9V3Wpc1w0n>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 10:03:28 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: patch-id: fix accidental literal blocks
Date: Sun, 28 Sep 2025 16:03:08 +0200
Message-ID: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.327.gddebdc8c038
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The options here are apparently written with the assumption that you
can continue a block like e.g. a description list by maintaining the
same indentation level.  This is not the the case; you need to use list
continuation (+) for the elements following the first paragraph if you
want to be guaranteed a predictable output

This is kind of subtle since only the last paragraph of each option gets
rendered in an unintended way, namely as literal blocks.  This is easier
to see in the HTML output since the man page output just has a slightly
larger indentation on these paragraphs.

Let’s use list continuation throughout, collapse the indentation in
front of all paragraphs except the first one, and wrap the unordered
list in an open block (`--`).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 43 ++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 1d15fa45d51..45da0f27acd 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -33,27 +33,30 @@ OPTIONS
 --verbatim::
 	Calculate the patch-id of the input as it is given, do not strip
 	any whitespace.
-
-	This is the default if patchid.verbatim is true.
++
+This is the default if patchid.verbatim is true.
 
 --stable::
 	Use a "stable" sum of hashes as the patch ID. With this option:
-	 - Reordering file diffs that make up a patch does not affect the ID.
-	   In particular, two patches produced by comparing the same two trees
-	   with two different settings for "-O<orderfile>" result in the same
-	   patch ID signature, thereby allowing the computed result to be used
-	   as a key to index some meta-information about the change between
-	   the two trees;
-
-	 - Result is different from the value produced by git 1.9 and older
-	   or produced when an "unstable" hash (see --unstable below) is
-	   configured - even when used on a diff output taken without any use
-	   of "-O<orderfile>", thereby making existing databases storing such
-	   "unstable" or historical patch-ids unusable.
-
-	 - All whitespace within the patch is ignored and does not affect the id.
-
-	This is the default if patchid.stable is set to true.
++
+--
+- Reordering file diffs that make up a patch does not affect the ID.
+  In particular, two patches produced by comparing the same two trees
+  with two different settings for "-O<orderfile>" result in the same
+  patch ID signature, thereby allowing the computed result to be used
+  as a key to index some meta-information about the change between
+  the two trees;
+
+- Result is different from the value produced by git 1.9 and older
+  or produced when an "unstable" hash (see --unstable below) is
+  configured - even when used on a diff output taken without any use
+  of "-O<orderfile>", thereby making existing databases storing such
+  "unstable" or historical patch-ids unusable.
+
+- All whitespace within the patch is ignored and does not affect the id.
+--
++
+This is the default if patchid.stable is set to true.
 
 --unstable::
 	Use an "unstable" hash as the patch ID. With this option,
@@ -61,8 +64,8 @@ OPTIONS
 	by git 1.9 and older and whitespace is ignored.  Users with pre-existing
 	databases storing patch-ids produced by git 1.9 and older (who do not deal
 	with reordered patches) may want to use this option.
-
-	This is the default.
++
+This is the default.
 
 GIT
 ---

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.327.gddebdc8c038

