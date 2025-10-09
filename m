Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C457283695
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046999; cv=none; b=iOoEPSflKphA9QbMJ44oIAEyy4L8pxMCS3L1LEwAvMKaYh9RMfF7bL9y3wZO8GytojvTvc+m2DlsBIupZVeebsBUVtJOqbZUpFgPQe04SwWVXsbZeJZZ8CrNq4Ynv34cTwOBYDF1WOwlIQhz1a++y1vhm4cETCHmRtVDr6ab0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046999; c=relaxed/simple;
	bh=s2oI1s/wTLtsUuMZ3fT2aXUiT4ghHJ0Zb0rkPQwITaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7/HAOHHh81ajhKFlSVDwNHPPJAQkONxm+546lAI4RvASY53EFdjlazWa+JHipTcO17fm29CPvJ4TA9YdkRA6w3KPXNrG2UfrNAcaetJFHGMILkBjPIObhFnj6IT6tcGC7+/LJKjZwROKdjcbK9ychk8WnVjNfPqAHBXsZG3rg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=0bxiiXEg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0bxiiXEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=s2oI1s/wTLtsUuMZ3fT2aXUiT4ghHJ0Zb0rkPQwITaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=0bxiiXEgR/wYuMWopjoXHZFyqC23Jdit8wMbPZPJepM+XtlztX9r8jBhoHRNo1rvO
	 3iVzmwY+8D14hsj3CvEqfctpgD1QBbExUryX2wXumTgSLXIxd6bHdxctZToLKADt4Z
	 pLaDjWn2tQylxo14y1JgvkyMlhSPSw0GOqgysKDa10LiefCjA/KikTuG9VeLW5QpCf
	 HlOvJ5H3jX2dwb643CR0TCOQzpHG/XofJ9Yjq/oFcGEApf0XBjaS76D9X+4MXQJqIT
	 3BIxLvwUeq1GiQi6yoIHI2VtL0nedSfx58nVTmr2IwDHgO6yXoGlkkd7vZmc9zL72C
	 VmBSu1XoKyfWdAI+tnUMDD04Mue/OU+Jz8yfv8niIdIT6XqPYZem9yO4UbMFYsD/II
	 /g0OYTtPkN5dwq5Ips3V3j3AkuOsLfMHh/KPLDg1ojW+/Rrfiy0fPJkvFGssiOP8EG
	 +qdS0jf1dHii2pZBMcpQ1dW3YNhiadWvUYLROz+bxS0DD8AJ5SH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 646E620123;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/9] docs: update pack index v3 format
Date: Thu,  9 Oct 2025 21:56:18 +0000
Message-ID: <20251009215626.3089287-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251009215626.3089287-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251009215626.3089287-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our current pack index v3 format uses 4-byte integers to find the
trailer of the file.  This effectively means that the file cannot be
much larger than 2^32.  While this might at first seem to be okay, we
expect that each object will have at least 64 bytes worth of data, which
means that no more than about 67 million objects can be stored.

Again, this might seem fine, but unfortunately, we know of many users
who attempt to create repos with extremely large numbers of commits to
get a "high score," and we've already seen repositories with at least 55
million commits.  In the interests of gracefully handling repositories
even for these well-intentioned but ultimately misguided users, let's
change these lengths to 8 bytes.

For the checksums at the end of the file, we're producing 32-byte
SHA-256 checksums because that's what we already do with pack index v2
and SHA-256.  Truncating SHA-256 doesn't pose any actual security
problems other than those related to the reduced size, but our pack
checksum must already be 32 bytes (since SHA-256 packs have 32-byte
checksums) and it simplifies the code to use the existing hashfile logic
for these cases for the index checksum as well.

In addition, even though we may not need cryptographic security for the
index checksum, we'd like to avoid arguments from auditors and such for
organizations that may have compliance or security requirements.  Using
the simple, boring choice of the full SHA-256 hash avoids all possible
discussion related to hash truncation and removes impediments for these
organizations.

Note that we do not yet have a pack index v3 implementation in Git, so
it should be fine to change this format.  However, such an
implementation has been written for future inclusion following this
format.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 .../technical/hash-function-transition.adoc          | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
index f047fd80ca..274dc993d4 100644
--- a/Documentation/technical/hash-function-transition.adoc
+++ b/Documentation/technical/hash-function-transition.adoc
@@ -227,9 +227,9 @@ network byte order):
     ** 4-byte length in bytes of shortened object names. This is the
       shortest possible length needed to make names in the shortened
       object name table unambiguous.
-    ** 4-byte integer, recording where tables relating to this format
+    ** 8-byte integer, recording where tables relating to this format
       are stored in this index file, as an offset from the beginning.
-  * 4-byte offset to the trailer from the beginning of this file.
+  * 8-byte offset to the trailer from the beginning of this file.
   * Zero or more additional key/value pairs (4-byte key, 4-byte
     value). Only one key is supported: 'PSRC'. See the "Loose objects
     and unreachable objects" section for supported values and how this
@@ -276,10 +276,14 @@ network byte order):
   up to and not including the table of CRC32 values.
 - Zero or more NUL bytes.
 - The trailer consists of the following:
-  * A copy of the 20-byte SHA-256 checksum at the end of the
+  * A copy of the full main hash checksum at the end of the
     corresponding packfile.
 
-  * 20-byte SHA-256 checksum of all of the above.
+  * Full main hash checksum of all of the above.
+
+The "full main hash" is a full-length hash of the main (not compatibility)
+algorithm in the repository.  Thus, if the main algorithm is SHA-256, this is
+a 32-byte SHA-256 hash and for SHA-1, it's a 20-byte SHA-1 hash.
 
 Loose object index
 ~~~~~~~~~~~~~~~~~~
