Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA3A50
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711242796; cv=none; b=KwkJiQazcYZvAeFmIrdzUh1F9gkTckZTNpJraaxhYbNDqr9MPeTsOIPjf7OsM8/Lzu0Ej2wCGvAK11DnH4cVZJ5Pe37U+7PbCa3yfmbkwvCl4u8fcuRiYNJFsnGTnH9Ut60dX+OE1epTLPbhG7zq/yCpcQ7prtB1sNfcV/kPptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711242796; c=relaxed/simple;
	bh=qLzO/NbZzNv/1q25jhvmykDRs0zvl+THgoHuoex+vZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUUsIMjhBDP8CItH+iFxUqu+BUyKbxQYuyexwQ+ETINZvOnj+mDFP/brB3+U/elgs7Y8L56w/i/cCuHgMFoKpeyUk3jFVUZYkf/y4UH25/dO/Ozx1usJuKy4zd4k4IWcHGerORYKBp0afxDxI/RCennMs7gOeH3pVfEN7xGr/hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Xizja4LH; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xizja4LH"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 507A05D414;
	Sun, 24 Mar 2024 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1711242786;
	bh=qLzO/NbZzNv/1q25jhvmykDRs0zvl+THgoHuoex+vZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Xizja4LHk9lrdJHqbAiwQvsfZJ7mN56fB38mukw1Ocq9bfkGy4ax0iDJtiPVo0Sad
	 4YcDgWqS2uBxHmeAbFKuPDlMqRXDvHGB7Evqh7ry2j0Gq0yt8qfUQmRtgl4mzXzEAu
	 NnaFFYi2Z43CfJdVDr1I+suKUhXnv5Dash08LkUlA7F24jK5X23rUCYsxScqsA6abC
	 5LptKCpsrH1XMrUFyRsqMCy/i97l9c5s1PC2rq1dYglg74FKa6g4wLlWrkBaxzZfvm
	 F2ZOBS+JVAemEml6kewkng5gtvBCTZXGIlUjPX0BNxUJ1ouMvkXaB1ajEPeGEAmXIN
	 tlAHSw09yrs8EzSJdk9TZnDQCdN8SHqX7I4tw8oYzmQ+tEQcqsPYptSclThezbf53R
	 6EZh0ChAHNzjGB73oM5OZkBc/G7P08WpVDCs3+yo3uWqFKih/8GNOkm5v/cIJP9owi
	 uFjt3yRluqgGW75fM0FKb5ugjGGc5Vlch9LFldYpE3rB1ZWv1jJ
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: [PATCH 10/13] docs: set a limit on credential line length
Date: Sun, 24 Mar 2024 01:12:58 +0000
Message-ID: <20240324011301.1553072-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently introduced a way for credential helpers to add arbitrary
state as part of the protocol.  Set some limits on line length to avoid
helpers passing extremely large amounts of data.  While Git doesn't have
a fixed parsing length, there are other tools which support this
protocol and it's kind to allow them to use a reasonable fixed-size
buffer for parsing.  In addition, we would like to be moderate in our
memory usage and imposing reasonable limits is helpful for that purpose.

In the event a credential helper is incapable of storing its serialized
state in 64 KiB, it can feel free to serialize it on disk and store a
reference instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-credential.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index ef30c89c00..6b7e017066 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -111,7 +111,9 @@ attribute per line. Each attribute is specified by a key-value pair,
 separated by an `=` (equals) sign, followed by a newline.
 
 The key may contain any bytes except `=`, newline, or NUL. The value may
-contain any bytes except newline or NUL.
+contain any bytes except newline or NUL.  A line, including the trailing
+newline, may not exceed 65535 bytes in order to allow implementations to
+parse efficiently.
 
 Attributes with keys that end with C-style array brackets `[]` can have
 multiple values. Each instance of a multi-valued attribute forms an
