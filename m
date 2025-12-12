Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2129A2
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765544060; cv=none; b=iVX1I1a5x+hMANvpro+v3p/pFe461tcEM7W+JARPOLwpWrBoKXV/4Ckjwj2sh4gnAqL6+WZzPi4SanToQunMEaO3m51waXyn40NZNRxJ3y8KVIM1omhwUlNS/i2vkQKAHwgjwzOosrOCRung9sZEarCKFa0Ma6h/b4KgSwTz/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765544060; c=relaxed/simple;
	bh=emALXFSUvyAAU9FLbFIQgfJKz3yJmJoXG3wExQ6pxgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FiFmbZB/uU3r6MoviCXwl+oEYJlzhZwK8JmfJvljsGHqOi2Vulire5iVJZjIB649iGaa9baTEF19XzTzG1wUNyJc1UI8ukrfc8j1cSr8DUEUMcOY9pZ2jdWZx5fG6/qL4sf5EM2hB/LKMVL8qA5L0w4nMXo69CIKWopw/gBo/j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kgBXxYtU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hH3Gul3o; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kgBXxYtU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hH3Gul3o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 134477A010D;
	Fri, 12 Dec 2025 07:54:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 12 Dec 2025 07:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765544056; x=1765630456; bh=JDDewaJFYd
	hh8mwLMw9KsZZ/Zgi1qY5fDBwpBcg4cLY=; b=kgBXxYtUrXfDd8iYHbA5Gl4gK4
	zhf5lAKZcXQ6mOl5n/x2jucmtf9XIp1CmCaLeCDN2wuNs0QQ7mAX+g7Ikv574yIU
	CXRyWXUy3iivUbWhbw7JZiwVc0+zqqwK43sdG8yPdJ4U505BBYdx9Cb0PKTresl/
	1mmncm/RiVoVVIbSqpm/A4yFfXscMDg1ya+x7aVQFNRxB9ztQElo4wLo/iM2+sCT
	fpKePBNmURMj/54hOtHp+CGQVKNh5m6QbbiKrRrixGD8hKvSAimg9ObEwl9q62Wc
	K3YuRtsBvlkNvl0IX+1D7iseEdJvoqXzV1k/ZfaA+pbxKfUyuxvWE6tNz/AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765544056; x=1765630456; bh=JDDewaJFYdhh8mwLMw9KsZZ/Zgi1qY5fDBw
	pBcg4cLY=; b=hH3Gul3ooPChDXZh6f8dvveipEGiX2p5BbbPrjZ1jgSLz58OxR7
	4uVonodOg/bs4km8FDluk8AeDvAOe/eWz2DCeSQUvoevTiwg80xyosGk5USqpagI
	lzjUdTtYPhWN4KRonpEh7UdWfufupVhDGbcvzwW+yLmmkAz6BD2n6eYZi0T/9yLA
	6PgB7FxI2Z9rYp75aCQIwWVphPgIbGt8tQ9LovY2nk3k0e93iZDFgax1twGw01Cy
	49pZq1jJooMb+//2m8NSF2TwWIE4xssH2o2xXlbMfCIwaxQJBk3toO1ej5xirGMt
	mCqCAUEjoQq34CaHOBLunHpkYlSShvNjd4g==
X-ME-Sender: <xms:eBA8aQygLqFeBaInfXEyPUrKUdd7uJz7DZSItdwKuL9tRxJlN4r14A>
    <xme:eBA8abvkhinPxg1u3nWt8VWHu0cBQr6XcrsDjaRkVwp-ARh3GchR0nh_gaZNLHoLL
    niizBud98rOjtuQW23d8VwwB1Z6jqqcoafIMotkBO4JIaEMGuOs>
X-ME-Received: <xmr:eBA8aftt0Rqa9t6dgeffVQ2RhO_rBx-61yr0W1dE8MFXs39TStg9tHy5YrRnIL0PyUk8ysnuSPHBVhNB9aCGOYlwh0at4c9LYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:eBA8aYPZKYr2pFhbe4Mbkj-_Slpu0i_1OXzFnJuddILnBs61JjeZDA>
    <xmx:eBA8aV3KYvbxpYT9TV9er5qVJQoITDAlJkzEawkjNMo16ZfspIOCJg>
    <xmx:eBA8acM4Lehta_LHkzrzJAoCuqROMF3MyTkezyurJlkXubGjq7q-uA>
    <xmx:eBA8ad1m11c7KunIGNjHGjuYb1XUxyXB4funZnaGTTAIm_aQnhqktA>
    <xmx:eBA8aT1MMmpR-B35P7MUjfkN6ejkxQ60qGfNEj_fRLScejzcRe86gO5I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 07:54:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] 3.0: require C99 flexible-array member syntax
In-Reply-To: <aTvT8A31tQFvCvtL@pks.im> (Patrick Steinhardt's message of "Fri,
	12 Dec 2025 09:36:00 +0100")
References: <xmqqbjk5e32q.fsf@gitster.g> <aTvT8A31tQFvCvtL@pks.im>
Date: Fri, 12 Dec 2025 21:54:14 +0900
Message-ID: <xmqqqzszc13d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> As we are pushing more and more C99 language features, let's declare
>> the historical forms of flexible array member support obsolete and
>> require C99 syntax from all compilers that want to compile Git.
>
> Is there any specific reason why this is tied to the 3.0 breaking
> changes document?

Convenience, mostly.

It is not like we weren't allowing use of an advanced syntax and
then trying to see if everybody can use it, which was perfect match
for our past "weather balloon" approach.  Rather, we know that many
platforms did not know how to grok fam[] with an empty brackets, and
have workarounds fam[0] and fam[1].  This change proposes to break
the platforms that has to rely on the latter.

> So I wonder whether we should instead convert one of the sites that
> currently uses FLEX_ARRAY to use C99 flexible arrays unconditionally.

OK, that is easy enough.  Or just remove it altogether and see who
screams, like the attached.

----- >8 -----
Subject: [PATCH] FLEX_ARRAY: require platforms to support the C99 syntax

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

As we are using more and more C99 language features, let's see if
the platforms that still need to resort to the historical forms of
flexible array member support are still there, by forcing all the
flex array definitions to use the C99 syntax and see if anybody
screams (in which case reverting the changes is rather easy).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * In the longer term, I'd love to import the fortified memcpy()
   invented for the Linux kernel project that takes advantage of
   advanced compiler features like __builtin_object_dynamic_size()
   and friends, and use of C99 flexible array syntax is a good first
   step to make it happen.

 git-compat-util.h | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git c/git-compat-util.h w/git-compat-util.h
index 398e0fac4f..8e3f3a58a3 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -38,37 +38,8 @@ struct strbuf;
 DISABLE_WARNING(-Wsign-compare)
 #endif
 
-#ifndef FLEX_ARRAY
-/*
- * See if our compiler is known to support flexible array members.
- */
-
-/*
- * Check vendor specific quirks first, before checking the
- * __STDC_VERSION__, as vendor compilers can lie and we need to be
- * able to work them around.  Note that by not defining FLEX_ARRAY
- * here, we can fall back to use the "safer but a bit wasteful" one
- * later.
- */
-#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
-#elif defined(__GNUC__)
-# if (__GNUC__ >= 3)
-#  define FLEX_ARRAY /* empty */
-# else
-#  define FLEX_ARRAY 0 /* older GNU extension */
-# endif
-#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
-# define FLEX_ARRAY /* empty */
-#endif
-
-/*
- * Otherwise, default to safer but a bit wasteful traditional style
- */
-#ifndef FLEX_ARRAY
-# define FLEX_ARRAY 1
-#endif
-#endif
-
+#undef FLEX_ARRAY
+#define FLEX_ARRAY /* empty - weather balloon to require C99 FAM */
 
 /*
  * BUILD_ASSERT_OR_ZERO - assert a build-time dependency, as an expression.
