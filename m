Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD333C0
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053634; cv=none; b=tWG7Mqpely8nLYXSWwBPF0u5d0i/LBNgRWrtKjM6VydIhdqae1vr7cMWWZoyJ3tO+nm7qZf2RJmEedij+TUzSTgFTp111UEuwnp0KES6SEzFJUIkXRmySFoey4pqJQUplj4vymMKYVdeMPucb+1rSYtY0En66ON0MMOmnD8CTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053634; c=relaxed/simple;
	bh=FbHioWXJq+XqgbqH86sTYywMa7bfYsQ5H8vK1iwwxdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZzYs5Su/QeucqjMRZclWBuurxkjmIO89Ud16o9BPlse73AtVx+VB4eZBnHufZ2ZJ0aEhtK597letgwP2KU7AscO0EYU5efxalSym3qk86VIWI4mBJqhJO9AlJijswIlymnwvqMOuzeRRidWUaQSmwbP96s0Lo1tPULxOw1sWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JGmEB17O; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JGmEB17O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720053631;
	bh=FbHioWXJq+XqgbqH86sTYywMa7bfYsQ5H8vK1iwwxdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=JGmEB17OpUwz/qi7zmzXmP+LJSMze/QQtYGFNAnAvFgIxj+cYa39kirVzH4ltLt/K
	 E2mkY84eeqzaY3wl+TYpPDrHQYas//Z7C+4AWIRdFdTlcK/hyUwkQW1nuZATXSVXAo
	 eX9qG6itIerlo1ukM26uubKh/xhBTavF7AV5qi9mmyYRfVwtiqdfFWtr5AVEUMSPCz
	 CKJRTCKBvJvD+8z64hQAIu2wuGOqK3AHvn1uyn7THAhQrjpe8v+2EXcaLuy7EDRHhe
	 5ty9abP58L5Ln9DRwrEyCyLEWlytJ8uT9c4yy/KnRvV6Q6j5NH7hZp3a4hNvlA7b71
	 IlZYDK6+qIIG9Mxs3kw0wfffXDFdvjqmY8a4kEuEt4sW3iFRqcaD6/XQ/lbtrbD9Aa
	 GNPkwVH1BqaY8B1K5qZ5dwKazsm6F7cZYDeRsFzaLMhTOwIzoxJlTKprEiiLACnhf6
	 d6fz6K6EXjNEfc3y5XHEaIiYzfnkOoOf0Re9IiJb/kGnMg5utz9
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CF9132099A;
	Thu,  4 Jul 2024 00:40:31 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/4] gitfaq: give advice on using eol attribute in gitattributes
Date: Thu,  4 Jul 2024 00:38:16 +0000
Message-ID: <20240704003818.750223-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240704003818.750223-1-sandals@crustytoothpaste.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the FAQ, we tell people how to use the text attribute, but we fail to
explain what to do with the eol attribute.  As we ourselves have
noticed, most shell implementations do not care for carriage returns,
and as such, people will practically always want them to use LF endings.
Similar things can be said for batch files on Windows, except with CRLF
endings.

Since these are common things to have in a repository, let's help users
make a good decision by recommending that they use the gitattributes
file to correctly check out the endings.

In addition, let's correct the cross-reference to this question, which
originally referred to "the following entry", even though a new entry
has been inserted in between.  The cross-reference notation should
prevent this from occurring and provide a link in formats, such as HTML,
which support that.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index e4125b1178..cdc5f5f4f8 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -393,8 +393,9 @@ I'm on Windows and git diff shows my files as having a `^M` at the end.::
 +
 You can store the files in the repository with Unix line endings and convert
 them automatically to your platform's line endings.  To do that, set the
-configuration option `core.eol` to `native` and see the following entry for
-information about how to configure files as text or binary.
+configuration option `core.eol` to `native` and see
+<<recommended-storage-settings,the question on recommended storage settings>>
+for information about how to configure files as text or binary.
 +
 You can also control this behavior with the `core.whitespace` setting if you
 don't wish to remove the carriage returns from your line endings.
@@ -456,14 +457,26 @@ references, URLs, and hashes stored in the repository.
 +
 We also recommend setting a linkgit:gitattributes[5] file to explicitly mark
 which files are text and which are binary.  If you want Git to guess, you can
-set the attribute `text=auto`.  For example, the following might be appropriate
-in some projects:
+set the attribute `text=auto`.
++
+With text files, Git will generally ensure that LF endings are used in the
+repository, and will honor `core.autocrlf` and `core.eol` to decide what options
+to use when checking files out.  You can also override this by specifying a
+particular line ending such as `eol=lf` or `eol=crlf` if those files must always
+have that ending in the working tree (e.g., for functionality reasons).
++
+For example, generally shell files must have LF endings and batch files must
+have CRLF endings, so the following might be appropriate in some projects:
 +
 ----
 # By default, guess.
 *	text=auto
 # Mark all C files as text.
 *.c	text
+# Ensure all shell files have LF endings and all batch files have CRLF
+# endings in the working tree and both have LF in the repo.
+*.sh text eol=lf
+*.bat text eol=crlf
 # Mark all JPEG files as binary.
 *.jpg	binary
 ----
