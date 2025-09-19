Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0691A2C25
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317618; cv=none; b=bXTfmq/WDzdmN+ufO8PRu/Eg0i7SKmCU3LmQZcfBkuEHu0/0nulLZ0L6KGl08NXnWKtivVX1M6CQqniAoJrAg+mw5dRJCifowhmGy/+joTgsLEhCHNmBzCZvrB2AyhICyTfWz+Njw+BLp2Ka84HwUOC1q+2cDho4YyjiO3FkBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317618; c=relaxed/simple;
	bh=kR7qgZH9DoKcQbR0xEVGBdXvIZ6m0uDSjIqeq+3oc7g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ibgTJdEzquCGtv0y9yu1ELIyyFjtHYRjPtCOT7WvFhBQwBhxOMON9mjkp5nNpLk+zna8Gx0xnUOyFOj7fhpUZJmtuUI0ks8aDF8aMsB0U5jrkpGIbHoGhz7EAV1NG/fKqau/G7ek0k0QgDlzJIIcJaEv/6WNOE7Xr/TGlsqhHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=az93Fhuk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=msU7pjsw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="az93Fhuk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="msU7pjsw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 104881D000DC;
	Fri, 19 Sep 2025 17:33:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 19 Sep 2025 17:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1758317614; x=1758404014; bh=rzLNcNAgY093EJgA900hdMmZZy5Lc6FL
	M56HTuancEU=; b=az93Fhukd9qzzKzYsmz5UsedKGzZvIdLZSvHZ6GI4JFCYWXC
	oFdsoq8aGi6yLweyBTL8my/oXapcKvlm8nvrIO0lfD8NuGLSu/37PgWnTMaHMi21
	qwtRHRcoLOIXGuZ0Eg7uftg9seXV4tJIoVjwCX6dz0ga+9fffJQteT6tyazsWwL2
	FO3qozFAYRm75Zf039zDln6Ju4ydvHi1W6/yv4Aa21eiYxTsLnzInSnQ0Qb0aVKm
	P5iiZVB++/8IHIQJy+5rf1ZTcM6WP4tdxCX2TKLhp2HhZks1UFnp3qT0jendpt8F
	nuG9bNm5Z8f3fpIKznW3VPrCYtBzoUw7xNa5lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758317614; x=
	1758404014; bh=rzLNcNAgY093EJgA900hdMmZZy5Lc6FLM56HTuancEU=; b=m
	sU7pjswgjZ53PQuntnqScxSKm3STLZdyg1rWqmyexJf6cBIiguj9uiSGnXnvm1X2
	wPqN9o/1raqid6yL/MAKncHHMpepU2D+ghzXFLtZv6erygXHZqVMN/JRedU1rvkR
	6R8MZqfyKRwNSwO/twVPmOWa+ubPhMCjg/RUDydoh2Y5mRQSC/F9akRupRWyoViR
	P++COJXfSkspi9IcJ9WxTlFtvVKw0ZVO0BQ/3D1NcSxA6hDfCy/ZjKEYPIK4LYzS
	EuVyrl70KH9Se5o9bfKN82A5rH5tOI5LA3TRS4T9A8HG+d+gBRkhbF9GrjrqdQ4B
	BzIj6h5Ekfm9/BnqSTFnA==
X-ME-Sender: <xms:LszNaFRsCpYRRpa05KeDrlw1YC4IY7WSC5iY8S2uCPJfcdGf9c8dhQ>
    <xme:LszNaO-NfCm8hHUzBCLF95UhdUu51x6twq_odWIL3hT_icL8fCgLrc39vy9LZpX-J
    dtD0QeZtGK7vDf1ow>
X-ME-Received: <xmr:LszNaMpxu9MUSBQlkucBtcy278_yUFQm-FOhcBHHawicY8EKSvFWN8enPy4YFi1bShQQFOZgA85-5HtTxh1yWDFtaOu08YQ3BDbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftdeftdekfeeuveelgfelteeiueffff
    ekhffgkeevheekhffgteejhfffgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LszNaLlsCYtq2jCFQa3s8VvflXxCsp_vs8Gd4xTxXUS1AbPKbY0C9Q>
    <xmx:LszNaDJs1fD9DOud8bsGth4VSURmrFPkXOqdbIuKod2oR1VH0g-DAA>
    <xmx:LszNaAywwD9jKZva8T-RxLYb0wic5BA3vNA2miCUMoItvWw42T-QbA>
    <xmx:LszNaLu0F6gaeb4EPtxuPIBerywEg4KdLBX_SaYpF1eBfbDlT0mxQQ>
    <xmx:LszNaP0hLAt8Cyp1Aju7ugSIUyA0WwdHwgxiuMGUlzrpQ80LGhTORlJZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 17:33:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFC] doc: check-docs and WITH_BREAKING_CHANGES
Date: Fri, 19 Sep 2025 14:33:33 -0700
Message-ID: <xmqqjz1u161e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shouldn't we do something like this for breaking builds?

Documentation/Makefile pays attention to EXCLUDED_PROGRAMS to
pretend that the git-$deprecated.adoc files do not exist

    -include GIT-EXCLUDED-PROGRAMS

    MAN1_TXT += $(filter-out \
                    $(patsubst %,%.adoc,$(EXCLUDED_PROGRAMS)) \
                    $(addsuffix .adoc, $(ARTICLES) $(SP_ARTICLES)), \
                    $(wildcard git-*.adoc))

but nobody seems to put the removed programs on the list.  

The dependencies around Documentation/GIT-EXCLUDED-PROGRAMS is still
screwed up, I think, but this may be a good first step to straighten
it out.  If "make -C Documentation" runs lint-docs by default, for
example, we may want to tweak the Makefile down there to make
link-docs target depend on the GIT-EXCLUDED-PROGRAMS perhaps.

diff --git i/Makefile w/Makefile
index 893070be76..711cade8fd 100644
--- i/Makefile
+++ w/Makefile
@@ -892,6 +892,8 @@ BUILT_INS += git-switch$X
 BUILT_INS += git-version$X
 ifndef WITH_BREAKING_CHANGES
 BUILT_INS += git-whatchanged$X
+else
+EXCLUDED_PROGRAMS += git-whatchanged
 endif
 
 # what 'all' will build but not install in gitexecdir
@@ -1363,6 +1365,8 @@ BUILTIN_OBJS += builtin/notes.o
 BUILTIN_OBJS += builtin/pack-objects.o
 ifndef WITH_BREAKING_CHANGES
 BUILTIN_OBJS += builtin/pack-redundant.o
+else
+EXCLUDED_PROGRAMS += git-pack-redundant
 endif
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
@@ -3875,7 +3879,7 @@ ALL_COMMANDS += gitweb
 ALL_COMMANDS += scalar
 
 .PHONY: check-docs
-check-docs::
+check-docs:: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation lint-docs
 
 ### Make sure built-ins do not have dups and listed in git.c
