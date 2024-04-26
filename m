Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F3376E6
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714169527; cv=none; b=QHMAVu3lbJ5SoYrWHWwt4e0GVQ+ld3UK4T9bb999CpBhy/w3ExZuPaWz4yRKroZ6yyYj6cNspAFZ2scC0vy9xczUy+LTVaOYA7IjPFhvGcJg9Vz+O1SPnHuPy9ZRm3Y6VGfoOzNu0dXSL5lPrLBI0qFnyUF3bWHNbhr2Rut5KEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714169527; c=relaxed/simple;
	bh=6BF9oGXtrzCiuoZCSqzfsX8O731x9Qa/l9/Gq14xLaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfSd4wcbptp9mlivU3lqUzaILhgwHqsqVQ4PyTKxPRSNtVjJMFxc4zumxGjvXBn/3UTfwyx3g6oRJ1KOhQ3Xz2rH+kgcPNAGZVBq+NXSHaw+B7cUTNMYwpldD4WQ6UQUp7vM0ca9WkSUyP3Gc7i5NcdAyiJ7CZjLFoY358enUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FzL4nhgM; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FzL4nhgM"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6F68C5B2D4;
	Fri, 26 Apr 2024 22:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1714169523;
	bh=6BF9oGXtrzCiuoZCSqzfsX8O731x9Qa/l9/Gq14xLaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=FzL4nhgMcVucMcmimJ1pyo8q6SCpRl+fbfMxqQ5vjBuq+79G20osK0Iw65754heFs
	 KNUHkhyNfsGS7jo/nI/il2CRfni+YvCjC74QgISiRQGWQcn39Ilj+2La6s6GBezPIg
	 /T2h0p7rCZqEGijIRo8B9oFSAYVZz0VSqRY160WfKzbdDklyZu07uEtdRqfXsGUrbK
	 MLZRJEkGXkDnp7h9HrCbh11YS126JOC/KYgja61COeN98782u5TyoIH2YdZRCcR84M
	 kylLU98yPULsAZ2BioPi8sakdEpZV8aWX7+OqwEGN449p+4YaE/e5BVqGl2f+8YtR2
	 gYXRHTJGv57DCfxJ2op+Qgw21tTZfW3bc6R4aIimCYqZLsouqotECKUssePUSF6jDD
	 f2zIhPuCvWpfg22/NZsAWHgVwJTq7Ja1QPKdfx0262Km5nO9i/43QD6JupumuXELD9
	 AIRVMKv8wy/rfLUpT7mlKnYJB6IdoQKtWm7IMyuoDwZiWnGI0SQ
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] vimdiff: make script and tests work with zsh
Date: Fri, 26 Apr 2024 22:11:54 +0000
Message-ID: <20240426221154.2194139-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240426221154.2194139-1-sandals@crustytoothpaste.net>
References: <20240426221154.2194139-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we process the $LAYOUT variable through sed, the result will end
with the character "#".  We then split it at the shell using IFS so that
we can process it a character at a time.

POSIX specifies that only "IFS white space shall be ignored at the
beginning and end of the input".  The hash mark is not a white space
character, so it is not ignored at the beginning and end of the input.

POSIX then specifies that "[e]ach occurrence in the input of an IFS
character that is not IFS white space, along with any adjacent IFS white
space, shall delimit a field, as described previously."  Thus, the final
hash mark delimits a field, and the final field is the empty string.

zsh implements this behavior strictly in compliance with POSIX (and
differently from most other shells), such that we end up with a trailing
empty field.  We don't want this empty field and processing it in the
normal way causes us to fail to parse properly and fail the tests with
"ERROR" entries, so let's just ignore it instead.  This is the behavior
of bash and dash anyway and what was clearly intended, so this is a
reasonable thing to do.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 mergetools/vimdiff | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 97e376329b..734d15a03b 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -72,7 +72,6 @@ gen_cmd_aux () {
 	nested=0
 	nested_min=100
 
-
 	# Step 1:
 	#
 	# Increase/decrease "start"/"end" indices respectively to get rid of
@@ -87,7 +86,7 @@ gen_cmd_aux () {
 	IFS=#
 	for c in $(echo "$LAYOUT" | sed 's:.:&#:g')
 	do
-		if test "$c" = " "
+		if test -z "$c" || test "$c" = " "
 		then
 			continue
 		fi
