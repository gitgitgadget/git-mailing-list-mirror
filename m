Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ADE22069A
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244186; cv=none; b=TkCicGOwaBNpbN1aa2Nhg6+fqqljDkEs4QKA46md8DvZy9WuscvjDONwhqTrBhzR3r7Vz46X1OML3w07qJT3Ef9qNGXE6TzDhtfxo04XCWpKIKykqiAsha7kAEKn+vQpS3w6fmDWm+AngpemybaZwcBWaYLWYOEojCah0BlTUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244186; c=relaxed/simple;
	bh=w4TjYqQkYzw1PRvm9FGD1p5t+VYo7gjmbxOLiWatgfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGtdTyzcdtZkKl741QKDeD2G+01r0OD+TuhqUYWO1hBCWxRbimSdedrun6qxhtGp5QVk+efGH5fgUjN4Y444W1VQJRBblvxL6CLyrw8RJExM0K7Mo2uOba8N+qcC2bsSdJuu/wLrcnc73dPKrfLzWQzU3jKVfFfm6ODR8yu1coE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=H9VyS7Yp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="H9VyS7Yp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=w4TjYqQkYzw1PRvm9FGD1p5t+VYo7gjmbxOLiWatgfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=H9VyS7YpI6I5xJFb3xtXEfmo2ncnhODMhrLhChFhw5x5ujc9sz2sbN7VmQ7Wh87KH
	 ZjfejQBKjXdBfGMD8I9GORGMljcLbRNbPgwjfXOzeVAut23mDS3ZJZ8mFqgKoGdYKs
	 E5mjOrOf9syjiBdk9zyKhM1bEbl6uwF9sUnkUwVpFbjLM5ExMEmVPMfKscdCXgMesy
	 96Cvamk7bnXnOynZf/+h3yjZm7zz/aX2YjAEvjACDkUpp1QGYMt8g1lrqJFn7hi0In
	 jg7cbP8cm8IBs+aYv13jZLtV9b/5y4WUTbxD6EOyWIvGQSkndXyFsXh3DcE8LLiqeq
	 s+j8MIyT5PxYLvGoXkhiNmtlm+m/Wk0poZ8g3JmKG+/OZY82sMxMIHeYEk1XSXvpqI
	 slIP/nYNpQ63n+a83aZNVlAt/BsHAoQrhRjVzdIh6Dn6cmhvn6YERa2geyNaFJoyVq
	 kCUo7bJoa9CzNpQxs6vUfCH+Gv1GdC0ieveH+HwPQgo4XHKzLYK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 442FF20157;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 5/9] docs: add documentation for loose objects
Date: Fri, 19 Sep 2025 01:09:07 +0000
Message-ID: <20250919010911.649831-6-sandals@crustytoothpaste.net>
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

We currently have no documentation for how loose objects are stored.
Let's add some here so its easy for people to understand how they
work.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitformat-loose.adoc | 49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/gitformat-loose.adoc

diff --git a/Documentation/gitformat-loose.adoc b/Documentation/gitformat-loose.adoc
new file mode 100644
index 0000000000..c8bef606fb
--- /dev/null
+++ b/Documentation/gitformat-loose.adoc
@@ -0,0 +1,49 @@
+gitformat-loose(5)
+==================
+
+NAME
+----
+gitformat-loose - Git loose object format
+
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/[0-9a-f][0-9a-f]/*
+$GIT_DIR/objects/loose-object-idx
+$GIT_DIR/objects/loose-map/map-*.map
+
+DESCRIPTION
+-----------
+
+Loose objects are how Git initially stores most of its primary repository data.
+Over the lifetime of a repository, objects are usually written as loose objects
+initially and then converted into packs.
+
+== Loose objects
+
+Each loose object contains a prefix, followed immediately by the data of the
+object.  The prefix contains `<type> <size>\0`.  `<type>` is one of `blob`,
+`tree`, `commit`, or `tag` and `size` is the size of the data (without the
+prefix) as a decimal integer expressed in ASCII.
+
+The entire contents, prefix and data concatenated, is then compressed with zlib
+and the compressed data is stored in the file.  The object ID of the object is
+the SHA-1 or SHA-256 (as appropriate) hash of the uncompressed data.
+
+The file for the loose object is stored under the `objects` directory, with the
+first two hex characters of the object ID being the directory and the remaining
+characters being the file name.
+
+As an example, the empty tree contains the data (when uncompressed) `tree 0\0`
+and, in a SHA-256 repository, would have the object ID
+`6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321` and would be
+stored under
+`$GIT_DIR/objects/6e/f19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5321`.
+
+Similarly, a blob containing the contents `abc` would have the uncompressed
+data of `blob 3\0abc`.
+
+GIT
+---
+Part of the linkgit:git[1] suite
