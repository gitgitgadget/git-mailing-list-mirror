Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C42836A3
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046998; cv=none; b=K1KUG4r+AYOnP44+iIgXWIyRQsEKcvfkZ0Pt++Nmqv9HNkMdkpxK1DzS9cpB3VeyVupK3Fuj5PU8SNxqpiipC3WQxIJG5d6FEKd8TXZrN7Q7M0dl4Gm54/G9m/gp1T2FEwh6OPmvFV1fFBpJcbbyB2MwyA9NjDIDPtceretc+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046998; c=relaxed/simple;
	bh=KtPkOLlb+8P4xgThQdLsHBoT6Q9OIPYAoQiHjtLn+VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuTg0Vn/7Fc7GDFvZwCqV1fQYlzlzngz4SmDLwz75ysb5hcbjoi/bjAEaNogHlYYRO1LgxHWfxmgc96TymLV3Tgx/FREAZ+5mRXCJg381VifDXLZkHhywUCXNI3gZByDssDRlTN4oD/bv/H0bwoOFpNTGbs2sCDt+n00k7czreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=E2CrE5fY; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="E2CrE5fY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=KtPkOLlb+8P4xgThQdLsHBoT6Q9OIPYAoQiHjtLn+VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=E2CrE5fY4xeRCSyPe0K2Xote/B1urRwj7Rr6ialj+KjatlYmqBPGanmLFeSOW8xJt
	 TCoOw7HIeuKYDHE/l4doczH4Gugvrw70ZdENtNn1Uq4Lmi1mdgm0aG87lCeMaSi8Xe
	 Lwlpv1grK0d8WfC6jMou4tCklKyYywzX3y2A932OIjUnHwaWSYBqilNiiO/ZJW8y4X
	 lge4/zpc/YYgsZmc9Q7Z6hMq5e9YoQaSP4ELUoDELKl7O5ik4VATRjBykp0ZaQScoh
	 3ZWGevSmzbh3SW5x/grDbKzHEZSJXY8Y1fXY5cjuUoAKX2VDeb5kVwSp+KzNPVZkQx
	 hYnL6i6hHzYyRVImdDTShmMfhmnGoybmZXjXAYEYCdKrSQFt3gXvSvHjYDiEGK50sn
	 z48Pah2Kpcu3JEgypxXlcxUKnDanHGSsAg+WzlsZbHsxtwQQ9CNQNDCv3FHYRuaWoV
	 5jK2fa2bq2Jo4tMjf2na5H4/ENbP8RA0G+lOra5gPII43or7/UF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7A8542019A;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 4/9] docs: improve ambiguous areas of pack format documentation
Date: Thu,  9 Oct 2025 21:56:21 +0000
Message-ID: <20251009215626.3089287-5-sandals@crustytoothpaste.net>
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

It is fair to say that our pack and indexing code is quite complex.
Contributors who wish to work on this code or implementors of other
implementations would benefit from clear, unambiguous documentation
about how our data formats are structured and encoded and what data is
used in the computation of certain values.  Unfortunately, some of this
data is missing, which leads to confusion and frustration.

Let's document some of this data to help clarify things.  Specify over
what data CRC32 values are computed and also note which CRC32 algorithm
is used, since Wikipedia mentions at least four 32-bit CRC algorithms
and notes that it's possible to use different bit orderings.

In addition, note how we encode objects in the pack.  One might be led
to believe that packed objects are always stored with the "<type>
<size>\0" prefix of loose objects, but that is not the case, although
for obvious reasons this data is included in the computation of the
object ID.  Explain why this is for the curious reader.

Finally, indicate what the size field of the packed object represents.
Otherwise, a reader might think that the size of a delta is the size of
the full object or that it might contain the offset or object ID,
neither of which are the case.  Explain clearly, however, that the
values represent uncompressed sizes to avoid confusion.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitformat-pack.adoc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/gitformat-pack.adoc b/Documentation/gitformat-pack.adoc
index d6ae229be5..1b4db4aa61 100644
--- a/Documentation/gitformat-pack.adoc
+++ b/Documentation/gitformat-pack.adoc
@@ -32,6 +32,10 @@ In a repository using the traditional SHA-1, pack checksums, index checksums,
 and object IDs (object names) mentioned below are all computed using SHA-1.
 Similarly, in SHA-256 repositories, these values are computed using SHA-256.
 
+CRC32 checksums are always computed over the entire packed object, including
+the header (n-byte type and length); the base object name or offset, if any;
+and the entire compressed object.  The CRC32 algorithm used is that of zlib.
+
 == pack-*.pack files have the following format:
 
    - A header appears at the beginning and consists of the following:
@@ -80,6 +84,16 @@ Valid object types are:
 
 Type 5 is reserved for future expansion. Type 0 is invalid.
 
+=== Object encoding
+
+Unlike loose objects, packed objects do not have a prefix containing the type,
+size, and a NUL byte. These are not necessary because they can be determined by
+the n-byte type and length that prefixes the data and so they are omitted from
+the compressed and deltified data.
+
+The computation of the object ID still uses this prefix by reconstructing it
+from the type and length as needed.
+
 === Size encoding
 
 This document uses the following "size encoding" of non-negative
@@ -92,6 +106,11 @@ values are more significant.
 This size encoding should not be confused with the "offset encoding",
 which is also used in this document.
 
+When encoding the size of an undeltified object in a pack, the size is that of
+the uncompressed raw object. For deltified objects, it is the size of the
+uncompressed delta.  The base object name or offset is not included in the size
+computation.
+
 === Deltified representation
 
 Conceptually there are only four object types: commit, tree, tag and
