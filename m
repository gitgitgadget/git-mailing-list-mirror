Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380305CDF1
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244184; cv=none; b=tskskEzdqcGrPwJoRzP5CRiGvtkFlLAEk1vFxrp0FGltR9YfsNkczguYk05rzwUux7DHiSpA0jH+pZ6SuEohM5bFSIyt0olLQ1iZ9ibXW47T5fMINzf0xY4HaCi7v9RfD2lXPXf9Zj97/rAlJHMdNvHfrhCeqaUmneakaLYKfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244184; c=relaxed/simple;
	bh=udObIcahCGy2e9diTA4J7zCdgjfsjre6FOuDjoT0Wk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBZYDnnfwrOiqnAZYeUKTlMArmtlk6OTxdQ3T1bSO1NOxXPn3Rr4V/JoN2rWYzJS0NO+cuknhm/pGmRleA+AN8SV9h6Qsnb7ah9bOorPxLJvcKjElWpl7CXmCfIdL0w9ElB1JaZdX+ZKwMNgPXkVUxE3RxWFyRDLVkb3bGRzeUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VT1V5LqS; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VT1V5LqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=udObIcahCGy2e9diTA4J7zCdgjfsjre6FOuDjoT0Wk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=VT1V5LqS/DpWjBYuAaRgiMbXz+PnB9ATxCQ693wCEyQfOaIGrxKwFTbj365XawFGm
	 MPLVw/yiIRlRKdH1yaoXpu9+trmiN5dJTzEmVHjPibiZxGbx/tkaTyhXzJIyG4vTJf
	 rp2E28eWapUnpDJ761SLU8b7TjI31IeDFLGUMaHAehMfubhsK9WaZwPtZ3oEdaPNH2
	 Erxa/J2hXJ2Oz7fgYtjqKNnWk0YYSthz5kuxhy1Cn6wtzDs27CNdLvIXEZ9SuH5gYH
	 +n3tI+sPPLEauSH/fsOPrIE7OoZFolLMG31+eOmjiQ1qMbBjmAdMNcg14RbY+IhEKz
	 kYoGETnhUl/g1BO6iiFEGL5eWwavNCCBwzSmESSMipE0i1BD4HinHNmxC70BOCvR0H
	 cOPga5ibbHjwtzdDPF+aCIdMriC5zzbegEvj/o5imlfOHbpMPlSc808ayD4j+qlMyV
	 RmSh22bAIL0lTHtZpxozXbl3j39Llon5KixiQKYEwB8aWpBaRjH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2147520115;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 1/9] docs: update pack index v3 format
Date: Fri, 19 Sep 2025 01:09:03 +0000
Message-ID: <20250919010911.649831-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20250919010911.649831-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
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

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/hash-function-transition.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
index f047fd80ca..f2df1d618d 100644
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
@@ -276,10 +276,10 @@ network byte order):
   up to and not including the table of CRC32 values.
 - Zero or more NUL bytes.
 - The trailer consists of the following:
-  * A copy of the 20-byte SHA-256 checksum at the end of the
+  * A copy of the 32-byte SHA-256 checksum at the end of the
     corresponding packfile.
 
-  * 20-byte SHA-256 checksum of all of the above.
+  * 32-byte SHA-256 checksum of all of the above.
 
 Loose object index
 ~~~~~~~~~~~~~~~~~~
