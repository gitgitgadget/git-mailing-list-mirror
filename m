Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0D1D8E10
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755986768; cv=none; b=FAy6IEip8MzDDXf5wR8FeyEjvWQzehIs1mDJqebGdylL4aG+AmSruotOtUO8ZGe+YIORczkbekCgsV3nyT2x+MIJGSHM51LOxmHmGExVwmF6c/xYGRT46OWlCHJSWBzQqv99uTynPcREl+AyTDE4VMtJLDpGAkTtnnU6pW3msKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755986768; c=relaxed/simple;
	bh=O8spWKLg/ji3SKF47Bg7sSO7q03PQj8T7QmO7EZ+dE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnPN40nzjrlf3KPbNTwiFQLUUlnHkSTW/SvhCqrw+QqqoF3Z85/dhNdGtEKMYh88T/fBpevnFTaZY4v60VlA+pkM4oq6cDV9OID4X547nMcn7HCbmDkV6hJ1S/fJcZUt95/oNHupAxcd9bMzxJGAvl9EpY8LzdDiZS2BYcZYGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=pb8QCsQg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="pb8QCsQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755986764;
	bh=O8spWKLg/ji3SKF47Bg7sSO7q03PQj8T7QmO7EZ+dE4=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=pb8QCsQgA3rcMrWWUigQC6BAS5M2wEjp82pB+DROYKlRx7z7FmIYh93eT4Mnjxk35
	 jhSRcyMHWKviQmbE1KOsT4SC9S2fW/FuLFBjuimD0dgoKF6+bBP36gz79dWMdthdB9
	 +kEYrxCx86DAZG1QsajN6D9qhkbfwjR0sIC9FEjLzWTEAd1ecx9bktI/4IP+O2YUR0
	 6NbikEep8+uUjrae1tyjVy8hgk2Gm/qW6NgaqnEEKrDdGVFT8p0tkFDnKBiqlOv+0j
	 ySCq6J1rmpPZgBvqEbNPC/tiewDuuQmjfep0eCI5QZdGUA1XufaZOmlStkqIKeEyGJ
	 qtdau3Tl9FUEPS9JMnvKEp8QEG1c9KdwCiaWCfagJo1JRFR4Z642wkSlRioY5iBHuD
	 ANOuY+EFFTpdCB7H1g1l5IoiH1aEjviRkFDbDbXqgluc2PigZRwhJoqnRwM1M96pu1
	 CurUgOPefD2mekwtZl4cFvj9Edkz//w/bOLLtUL8M9cDjYo3m6x
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4bca:b344:de61:b896])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 3E515200B4;
	Sat, 23 Aug 2025 22:06:04 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] docs: note that extensions.compatobjectformat is experimental
Date: Sat, 23 Aug 2025 22:06:01 +0000
Message-ID: <20250823220601.336079-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compatibility object format is only implemented for loose objects,
not packed objects, so anyone attempting to push or fetch data into a
repository with this option will likely not see it work as expected.  In
addition, the underlying storage of loose object mapping is likely to
change because the current format is inefficient and does not handle
important mapping information such as that of submodules.

It would have been preferable to initially document that this was an
experimental feature, but we did not do so.  We hinted at the fact that
this functionality is incomplete in the description, but did not say so
explicitly.  Let's do so now: indicate that this feature is
experimental, incomplete, and subject to change.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This was spurred by the fact that I saw Gitolite had added SHA-256
support and then that users were expecting extensions.compatobjectformat
to work, when it clearly does not (and, in fact, in some cases breaks
pushing into the repository).

I know that some people will not appreciate this feature being
retroactively marked as experimental, but it is definitively broken for
real-world use cases without the rest of my sha256-interop branch.
Technically someone could always insert loose objects and then pack
them, and because the old loose object mapping was present, the mapping
would work, but, as mentioned, this would perform pathologically with
even small repositories, so it's not a useful configuration.

 Documentation/config/extensions.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 9e2f321a6d..292e95ddae 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -14,6 +14,9 @@ compatObjectFormat::
 	compatObjectFormat.  As well as being able to use oids encoded in
 	compatObjectFormat in addition to oids encoded with objectFormat to
 	locally specify objects.
++
+Note that the functionality enabled by this option is experimental, incomplete,
+and subject to change.
 
 noop::
 	This extension does not change git's behavior at all. It is useful only
