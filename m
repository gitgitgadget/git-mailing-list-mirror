Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5863284891
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444751; cv=none; b=BoW3dBKuItUWeltIdmy72nPeuOyDQwPK3jAzTaFzTmFEs8e7wM3MmNNoeI+KSQJ1ibHqvZNaB83U1bK97JI1n5ydac7RIGaWNY3JydlIYzG9SDCfy1WRjwf0R1TwOGejyyh8kYzjg4qQzCoRgdhYY+O3IYR9qglm6kZmlPdTpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444751; c=relaxed/simple;
	bh=q5X3ffswJA8ylTddczm2gtyR2qhvtjcr9VM3Ct/6mmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYPzhsUEFOQacFsE+xvnKh9Xg5XpdUIWwQfvzJERrWE1DoD64ti28Y9q3hKxWUh75aGy0sgbBDvHqDL/B/JXspPypqJH1NlGRqSICitdGQ3y9RJlRk7vJQDmSWyC1zYTqmy1hlSyO3v5NdomJiGuGwqnCB/v5IjE4amX/evDJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=O8To2gd+; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O8To2gd+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759444746;
	bh=q5X3ffswJA8ylTddczm2gtyR2qhvtjcr9VM3Ct/6mmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=O8To2gd+zZdF8CRBlHYBkWw5fcPNzr+8AhQrnrzvQWxcc0HIsecmbiL7cTGCprl8w
	 kBXuXNt/L8lUYpQuk1lH6mtykOYiE46MTymxp6GQ0tF9mQco3Bhnq90P9SkpVFxMa1
	 TwUB0cktVFZE5sFHhiymD0MUrexOkXvS2dt7tmuY5Es8rDDY//j3pE0Wp2taWQ5BA6
	 c9k2MG+LTCqyg+RdJIOzVlSbkJEPyWhDJg9540+l5dA0GveRO5A1JT7Ra8r8gh6lRa
	 He2D0LH+QhQx4EeVX5J0wi4Db79KR+BfzlD1SgufGoQygdDvuwIiLCAtf893oC46Ek
	 vJ3Vs38ElUfjsPg6icbZlEsGbIpsy6GMS7U6jICRPwh1583YwVHQQx4wa0PoyZnRb5
	 FJQtxW4GmmaLSz6cHb+x6Xp3RI+EJw4HnkUNU/50BwfsIyVUrXMfcF43INKVCXozD1
	 BlKlRWw/9giuc2HHNSidM6A4S0t+moaYGAJfVpFuh2co/BKDESi
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b8e7:3022:3f31:478d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 512CF2019E;
	Thu,  2 Oct 2025 22:39:06 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/9] docs: add documentation for loose objects
Date: Thu,  2 Oct 2025 22:38:51 +0000
Message-ID: <20251002223855.1022847-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251002223855.1022847-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20251002223855.1022847-1-sandals@crustytoothpaste.net>
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
