Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206E4A3F
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312186; cv=none; b=dULpPtdKtK9F1cJvCLzv0fchRcXZEkYbQAQJ0RrNYx6H0kUJKPzArziOOClWVnL+d23aogqh07aWhDcFJDcAQbk5UEjgJYtlh8zV3Y7sJGlkoVnaBl8jD5wxCPsKRk2fnFLC6v9A2vYrSKhIXmwFArK9AB4gC+DaylR9Qz8RaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312186; c=relaxed/simple;
	bh=R0thGV7MOwPRpTMsHyprK50fo88d3hwIsjIEQgif06U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLxuveA0cWN7rcJRFu2msusdxetz2RuBdwulMzSXH3DNKZhPr2O+12ym6fRcnQi7838mGzNNc55bGUER32V9lij7z67BqmCSFPhcq8nU9iD5+tQYPzIez17pqb+w0vUvtQvX3/5PIjxUTuYkDXhBcrvWIE6vgJdTZM7kH95tdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=djDhDumo; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="djDhDumo"
Received: from tapette.tailf784c.ts.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 541605D4E8;
	Wed, 17 Apr 2024 00:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1713312177;
	bh=R0thGV7MOwPRpTMsHyprK50fo88d3hwIsjIEQgif06U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=djDhDumoVPnKifU3i+Vu4WstPvz2g2lllFjRMPhbDx++8LxaNG6uFv820ZsunD+U6
	 TeNE+/id4apLMSAerJ9oYFIU+JKR3l80JFK3IzYHo4nnznvlMD6I8DLN9symDoqZnu
	 8TAJtqstvPXbDtOohH9QLLAlCw7aPt56m2mnmJdKiwhv1Qul4PfMk4RAAk9MeHny+b
	 zEtC8ubHLEqwh3F0/3UpCFfhC6BM4IpUuITjnGAkYoZSI50rlB46ycuUbLxKoVl+WH
	 9wOnaK1yDCg7+tt+UwhapwDCX7gOe7bW+KCdOL4DKLeRpJbec/EkdxHZRyg6iJFtm5
	 5cYUH8XXxvrU9d34JUs85t0QA5j3fHog/HrVSS44js32Fye/aCrUmmxB/MWf3q5Evl
	 pDW9iPmN29yOdeF94m9ITdcJjCql6Ze1L5+B9q/z3iXsBhtxw/pcYbrcfdYmJVPXGG
	 c13UF9k5sTQbpfnVwoeJY0Uy2t24IQfRyfW2DiXP8JEe+pVQjeB
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 07/16] docs: indicate new credential protocol fields
Date: Wed, 17 Apr 2024 00:02:31 +0000
Message-ID: <20240417000240.3611948-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240417000240.3611948-1-sandals@crustytoothpaste.net>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240417000240.3611948-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have new fields (authtype and credential), let's document
them for users and credential helper implementers.

Indicate specifically what common values of authtype are and what values
are allowed.  Note that, while common, digest and NTLM authentication
are insecure because they require unsalted, uniterated password hashes
to be stored.

Tell users that they can continue to use a username and password even if
the new capability is supported.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-credential.txt | 49 +++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 918a0aa42b..230ac4c2c3 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -178,6 +178,39 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`authtype`::
+	This indicates that the authentication scheme in question should be used.
+	Common values for HTTP and HTTPS include `basic`, `bearer`, and `digest`,
+	although the latter is insecure and should not be used.  If `credential`
+	is used, this may be set to an arbitrary string suitable for the protocol in
+	question (usually HTTP).
++
+This value should not be sent unless the appropriate capability (see below) is
+provided on input.
+
+`credential`::
+	The pre-encoded credential, suitable for the protocol in question (usually
+	HTTP).  If this key is sent, `authtype` is mandatory, and `username` and
+	`password` are not used.  For HTTP, Git concatenates the `authtype` value and
+	this value with a single space to determine the `Authorization` header.
++
+This value should not be sent unless the appropriate capability (see below) is
+provided on input.
+
+`ephemeral`::
+	This boolean value indicates, if true, that the value in the `credential`
+	field should not be saved by the credential helper because its usefulness is
+	limited in time.  For example, an HTTP Digest `credential` value is computed
+	using a nonce and reusing it will not result in successful authentication.
+	This may also be used for situations with short duration (e.g., 24-hour)
+	credentials.  The default value is false.
++
+The credential helper will still be invoked with `store` or `erase` so that it
+can determine whether the operation was successful.
++
+This value should not be sent unless the appropriate capability (see below) is
+provided on input.
+
 `wwwauth[]`::
 
 	When an HTTP response is received by Git that includes one or more
@@ -189,7 +222,21 @@ attribute 'wwwauth[]', where the order of the attributes is the same as
 they appear in the HTTP response. This attribute is 'one-way' from Git
 to pass additional information to credential helpers.
 
-Unrecognised attributes are silently discarded.
+`capability[]`::
+	This signals that the caller supports the capability in question.
+	This can be used to provide better, more specific data as part of the
+	protocol.
++
+The only capability currently supported is `authtype`, which indicates that the
+`authtype`, `credential`, and `ephemeral` values are understood.  It is not
+obligatory to use these values in such a case, but they should not be provided
+without this capability.
++
+Callers of `git credential` and credential helpers should emit the
+capabilities they support unconditionally, and Git will gracefully
+handle passing them on.
+
+Unrecognised attributes and capabilities are silently discarded.
 
 GIT
 ---
