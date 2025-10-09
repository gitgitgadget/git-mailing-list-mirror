Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A63283FCE
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047000; cv=none; b=ZBYkg430/FSpvJbEU97/ObeHSf1fb3sBg3nOpyr1PJwRhIzOUEkZyRvfEpNYiDMz8SOgwOnd53op9W1OJEawFIivnC7eqceY76W3JeMGyiYpThNFmJq9fslz8KwVPsVJrsATBdcJ0kLpby0R27755bhAYZ9olVQM96RQHpzqsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047000; c=relaxed/simple;
	bh=q5X3ffswJA8ylTddczm2gtyR2qhvtjcr9VM3Ct/6mmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1yBO/+oemmaUhCaDpJPNwzpiESe+CUHxHIvR9jj1gBfd9be4A2o1PxvNA0X7yWCXka19QwYcksIXHhubHTFGmitT77KbsUtz7dz70UnkZ8a/gMiJIeTh5G7fKWQJVMFXr3ndJ96ctrj21JbxR3clSffJWld9JwwC5YU4Er/0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IGvwdC4X; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IGvwdC4X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=q5X3ffswJA8ylTddczm2gtyR2qhvtjcr9VM3Ct/6mmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=IGvwdC4XssaZa3at73DHATVcG2fiwRIsZZXeLDgotWxKozkowlp041Zd74RCkDUEW
	 vo9gnIcoQ9TsaBQ31WNwqSCOq6tOYtmyyrEPM2mWZjnN6SFhMNbpJEw8LdcCUp+fiQ
	 8xzxmwjJd/92sKsEBrABkX+KzHlWnQVIVFyHwOYm82IYxdUL6F6IC3eg7ngNirZCS5
	 cGcq4zb3yLX1MnzkYlKiuQrGC+6yGpcFTRa/O/vqv7ebL04M1az3024E/Si37R/icT
	 NJtuiFvhAYdYU2A5Qh3TsZfTc1eU6aceHYIzkik5bOnvuOYDvX8Ufuo8MmPwBlSa1V
	 ohq/KZZLkFkaW+0AaJqydIJZ67pqrK6jJy8Ki92S6ozCqodPteucTyBCdHlu1DVaO5
	 MWucnDTfl4vwfNpDlUkRHYWsYY0S8mso2UVM/YNhzHU9HdvElhZZlXcYi3H41AQ8ZW
	 8G4W+D+c84S3bTOkW8wXnkxLvt4fntfhAhwPaqoUQ/W4kn+AY39
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 81D222019E;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 5/9] docs: add documentation for loose objects
Date: Thu,  9 Oct 2025 21:56:22 +0000
Message-ID: <20251009215626.3089287-6-sandals@crustytoothpaste.net>
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

We currently have no documentation for how loose objects are stored.
Let's add some here so it's easy for people to understand how they
work.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile             |  1 +
 Documentation/gitformat-loose.adoc | 53 ++++++++++++++++++++++++++++++
 Documentation/meson.build          |  1 +
 3 files changed, 55 insertions(+)
 create mode 100644 Documentation/gitformat-loose.adoc

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..e1d38fbfe6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -34,6 +34,7 @@ MAN5_TXT += gitformat-bundle.adoc
 MAN5_TXT += gitformat-chunk.adoc
 MAN5_TXT += gitformat-commit-graph.adoc
 MAN5_TXT += gitformat-index.adoc
+MAN5_TXT += gitformat-loose.adoc
 MAN5_TXT += gitformat-pack.adoc
 MAN5_TXT += gitformat-signature.adoc
 MAN5_TXT += githooks.adoc
diff --git a/Documentation/gitformat-loose.adoc b/Documentation/gitformat-loose.adoc
new file mode 100644
index 0000000000..947993663e
--- /dev/null
+++ b/Documentation/gitformat-loose.adoc
@@ -0,0 +1,53 @@
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
+
+DESCRIPTION
+-----------
+
+Loose objects are how Git stores individual objects, where every object is
+written as a separate file.
+
+Over the lifetime of a repository, objects are usually written as loose objects
+initially.  Eventually, these loose objects will be compacted into packfiles
+via repository maintenance to improve disk space usage and speed up the lookup
+of these objects.
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
+characters being the file name.  This is done to shard the data and avoid too
+many files being in one directory, since some file systems perform poorly with
+many items in a directory.
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
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 41f43e0336..64f70ac724 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -172,6 +172,7 @@ manpages = {
   'gitformat-chunk.adoc' : 5,
   'gitformat-commit-graph.adoc' : 5,
   'gitformat-index.adoc' : 5,
+  'gitformat-loose.adoc' : 5,
   'gitformat-pack.adoc' : 5,
   'gitformat-signature.adoc' : 5,
   'githooks.adoc' : 5,
