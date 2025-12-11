Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE62FB983
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765448178; cv=none; b=ll+ufC4s0GdolZRUEHPaoQV1yP6cQggKEAZ7ASQJ3g5ncienq9efygoQolAS28oes2m7Dyc9mjLhEVZFcENvhrEtj8bJXwZwU4J7arWZfKQ0vaijNdkSruH2tPeaQRdiD5CJUCBuS0wzBSbQpWghS8oeYJjmW96s5ndxuJOBcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765448178; c=relaxed/simple;
	bh=onm/7DJiZTBxnvASWUw+q6bisU5TlBlFGnOnIgVUxwg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=laNqcbQkLspOJUoU6b2m+KDA2SmAvEbLnO6nA9vsRpmFknZeWHsdK2N1EJNRPhhsrYES0Aqa7OgOrBtteOSTiqaFCT9gkR64gu4KwbpLQI1JNUrwkCx/2NJZnzhKEMG6laKafa422QO5C831Cv4IzyCuLEbHJ0mFCpLDqJQtWqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NgD+x36m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PU21EAV5; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NgD+x36m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PU21EAV5"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A7CBEC0082;
	Thu, 11 Dec 2025 05:16:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 11 Dec 2025 05:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1765448175; x=1765534575; bh=6oNmjIw5FjIhV75ixGgKVXmSLAYyIqYH
	nQSMKGpxe50=; b=NgD+x36mP3SFMjewiBR+eRPvgRg6UHuexb1FQ/oTQRO25M1h
	pAE5vGxivIiXxNmi04P2lV3FvLBFRDyrKiZ1/BTWdoqC1NqrX0f2E7XZqOGn6j+o
	Hz7fr2NYidr1AATFN8/JzEWiJipeZuKyu7Zps7ekEYlB4tm73Q7pi0aTgkRjo7+X
	A+HtTHmy7zTx+GzmssC70YMR9LNKaViBpckoTWKcUxv5UtCwcpq6SKES6udxWmhy
	XmWrZIpXYP8XxGH+h8bxWjmT+On2aDz287RGG+NKe9JBTJRk/esZuPiL10cdiI2t
	idcYIYOXpV8pwgTggW7TZF1PVdjzlDAcg90ixw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765448175; x=
	1765534575; bh=6oNmjIw5FjIhV75ixGgKVXmSLAYyIqYHnQSMKGpxe50=; b=P
	U21EAV5MnwYE6AgEv68lR4IsV1aByjuqO1TBFh2d0T84qYvCaj/DVRU073fLR36G
	fjZl3UP6AkU0lI/n0i85z7u6wibsfAWkArvPZTKPdGazMp9yY03YIFaMMQ+j5I5D
	/G6WTa5O2xnbMj7IfrySbYO7p+nc+U1n1nJB4BNGwIk3hevamekICwSp1dWWsGQx
	o7PnhxCD7CEuziWhuhLl3QLY418YWPeXxWgLptScEM7cuOaSM11kQ6VEH5Al/ddR
	IecxSyjCd8QrkZ4qDZkXehm3rztqmzqd3WTzB1ngIqVQB09DqKYkupUYGvraWrl6
	/cZHg5eww3C+et2sGwLOA==
X-ME-Sender: <xms:75k6aS7GKMQ8tpE3rVTCwwa3p24C4egEQRvsGDX4jG9hRBClBTyGDw>
    <xme:75k6aR5VZZb0Nwwj7PGvU0v4KZTHZXB1OLYZgABZ2qEvdAYHUSdjmYqzjSGgUq9EU
    cgEmAVkgwpO9n3oYxbu_7d_THvgdGLOmRowLKpHMZEYyAwK14jRJg>
X-ME-Received: <xmr:75k6afEnj8Mo3MXb_olya2RnaCsKIiTrBFQ4D52btGaLwmQqUs4fl2sTx_HPbW_ccPCEW_q-1vZ9cdTbkidhDiyqvaS8nVlDCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftdekfeeuveelgfelteeiueffff
    ekhffgkeevheekhffgteejhfffgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:75k6aaTQ3NlhQGgtT4GD-W61qqL4DCKooHLt6JJd17vf4oqJkz1kEg>
    <xmx:75k6aYurbp-WsNdeO15f3yqCcpReno1J0bBQSWAYsksXs1Si7w2xog>
    <xmx:75k6aZzX-Zvua5BgzFKumORBgyundIMtah-Xe3LsU0tLU2yrEu5LoQ>
    <xmx:75k6aS6oe8hWhfShs6NcF_9VpDlEr87ix5bRX-EXwOJRh9dbQ_uFNA>
    <xmx:75k6aWSD8nI-1XLcYXnxB38RMQoXrjfKHFl9GOf_4pQBVdlx7E-tmKAD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 05:16:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] 3.0: require C99 flexible-array member syntax
Date: Thu, 11 Dec 2025 19:16:13 +0900
Message-ID: <xmqqbjk5e32q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Before C99 syntax to express that the final member in a struct is an
array of unknown number of elements, i.e.,

	struct {
		...
		T flexible_array[];
	};

came along, GNU introduced their own extension to declare such a
member with 0 size, i.e.,

		T flexible_array[0];

and the compilers that did not understand even that were given a way
to emulate it by wasting one element, i.e.,

		T flexible_array[1];

As we are pushing more and more C99 language features, let's declare
the historical forms of flexible array member support obsolete and
require C99 syntax from all compilers that want to compile Git.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.adoc |  3 +++
 git-compat-util.h                  | 31 +++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git c/Documentation/BreakingChanges.adoc w/Documentation/BreakingChanges.adoc
index f814450d2f..81ab3cd1d8 100644
--- c/Documentation/BreakingChanges.adoc
+++ w/Documentation/BreakingChanges.adoc
@@ -315,6 +315,9 @@ symbolic links are not supported on some platforms.
 Note that only the writing side for such symbolic links is deprecated. Reading
 such symbolic links is still supported for now.
 
+* Support for flexible array member emulation using FLEX_ARRAY macro
+  for compilers that do not understand C99 FAM syntax will be removed.
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
diff --git c/git-compat-util.h w/git-compat-util.h
index 398e0fac4f..cedd022396 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -38,7 +38,10 @@ struct strbuf;
 DISABLE_WARNING(-Wsign-compare)
 #endif
 
-#ifndef FLEX_ARRAY
+#ifdef WITH_BREAKING_CHANGES
+# define FLEX_ARRAY /* C99 FAM mandatory */
+#else
+# ifndef FLEX_ARRAY
 /*
  * See if our compiler is known to support flexible array members.
  */
@@ -50,25 +53,25 @@ DISABLE_WARNING(-Wsign-compare)
  * here, we can fall back to use the "safer but a bit wasteful" one
  * later.
  */
-#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
-#elif defined(__GNUC__)
-# if (__GNUC__ >= 3)
+# if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
+# elif defined(__GNUC__)
+#  if (__GNUC__ >= 3)
+#   define FLEX_ARRAY /* empty */
+#  else
+#   define FLEX_ARRAY 0 /* older GNU extension */
+#  endif
+# elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
 #  define FLEX_ARRAY /* empty */
-# else
-#  define FLEX_ARRAY 0 /* older GNU extension */
 # endif
-#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
-# define FLEX_ARRAY /* empty */
-#endif
 
 /*
  * Otherwise, default to safer but a bit wasteful traditional style
  */
-#ifndef FLEX_ARRAY
-# define FLEX_ARRAY 1
-#endif
-#endif
-
+# ifndef FLEX_ARRAY
+#  define FLEX_ARRAY 1
+# endif
+# endif /* FLEX_ARRAY */
+#endif /* WITH_BREAKING_CHANGES */
 
 /*
  * BUILD_ASSERT_OR_ZERO - assert a build-time dependency, as an expression.
