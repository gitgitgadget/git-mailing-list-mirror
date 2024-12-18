Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FE2F2A
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484933; cv=none; b=ErIUBdy6DPpPqrKcFvsQ7vZ+xnV9QLrWWE5jfVG/CQRH11g5UFIE5i8VGJSgMHT87J73I/tyPjTlkQZSCPGzKAQFgj1+1ne97hPxTyoxvX2woUZfvLD7Q9nU+yYw4TPEgYTJLB9ozUkZ/zqdMLeqH4XAXJRhD4BP2QfWYDqQfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484933; c=relaxed/simple;
	bh=a1D8l/BXRgQZLbagjQoD3gYQeuZnJR6TtuovVx9opoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPGuiFXNvb8a5c+RznGSxr6DXv7oqC4a45tFgzFMn3ryj4fdhaqaRwRJcqkKdosib+GH2Am8j4s1FtehFCJZvyaKW9pIz/Ki1VTgqdtyRczExmxlkJ4sr9Ro54WQGCogZ/HP3AC3ZrN28iehkIiWmaidi9yVqR5I08R2hU0gDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fEhcO17R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Loo6Ujyx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fEhcO17R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Loo6Ujyx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EA47114015E;
	Tue, 17 Dec 2024 20:22:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 17 Dec 2024 20:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734484930; x=1734571330; bh=vM2KI+AuIy
	PxJEELA7EUhU+l84FfspvSi7aE/d5Z1WU=; b=fEhcO17RGCsdkWxIwr5AJ/aeCV
	OufvK/kyZd51OyBG7A//DClxvIDh5x9e/TWFppGBgC3Jt6wiu9M6SNctDVWovNns
	TpoQxQysbYEVZG/IkpAmISm1Iajv5HU7hl6d0YHRgxgVLJGJB+fxuxBMEMfixIBt
	pYm8wNFzd8+SQEl+jNnabIYzjep/joqTaLyMmAPWugpnfyLqyLfDPMMZWHSqPG6b
	uYT3EyET1eKV3+WzPSBSBPbybwXUI+egINOqWMu9wyCSoik2xK/9zVs5NfPmoNhm
	froBa0k10Dk7S/amnkOn4FFB9IEiA3f1Mm7xdH9M4eUr8Ca8olFaKDkYsZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734484930; x=1734571330; bh=vM2KI+AuIyPxJEELA7EUhU+l84FfspvSi7a
	E/d5Z1WU=; b=Loo6Ujyx8WVXNICLqCmra/j0P3GgOj4VVmsao65vdSyjySkvTfC
	lq8pNy+TRlAWG0fIaRZ1mNTO9JYdQQ7NUrUbF+/33s9VAAoTeHiDfVZUK/OGqEyP
	C8tDrTG8Q44hS/SAuIJ26yk0Az0OapboFAwP4dXT2zba3pDZqRvQnceb/Vn3jSzU
	dlcI3SBxMQywhkX5oVqC9gVlThzHd4OPvTudrkuFiGi4dpmsJN+39CZwN37wa7aI
	lJ0x+olxzIg8pHxRTNiE/OpqVa04Pvd/aGU7507FVTL/3UTsOcG8PAb72CPU2xR8
	nkhVs7DPiDD73YIIrqxn1S4gfOM0t8hqH0g==
X-ME-Sender: <xms:wiNiZxmMIX_nRWBdt4iutZ7kRXqroQL2t9SI6qq0UNCqE5DDi6HVAg>
    <xme:wiNiZ804KWKzomJNu4HmgKQ4ugpTLfmO4x6aso48UKrFHWk0Oe4oEyjPtg-rFSKdu
    w3kV6XPhpJ9punwVQ>
X-ME-Received: <xmr:wiNiZ3q18e6uYcMPd5NemXH1FKvUO-fn4POwVkGk55Zolohrgk_4JPPg0bo61ETcWffK6UCU5NoQs9n_N_kjiCEjw8-rcpmooQwaNGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeiudegffeihfehfedujefhledvgffgieegudek
    vefhgeekfedvhfegudeggefhteenucffohhmrghinheptghonhhfrdhinhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhpvggtthhrrg
    hlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:wiNiZxlNUUPQd2MHu-j03b4XdqE9fTJJ8vYpgHXwXMIRqLk12jvU9A>
    <xmx:wiNiZ_0NMrJzmHY9c-K6tVUZNRYHi4I432dpVcSRpikjhGQlfYI0hQ>
    <xmx:wiNiZwvfA6R5pIkNkgea1TUikP1pbMxmbIXEHXjbAXICnMa4vw-w4g>
    <xmx:wiNiZzVry-o63v4SwiNnxdVNViytXhb7aSPRx6n3yeOBbtKW6nHOpA>
    <xmx:wiNiZ6RLaVoaS5HIVWtAfdNyr1gua2Bf0RAw9AnEvwl8JWWI2sRJFH9O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 20:22:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2] doc: remove extra quotes in generated docs
In-Reply-To: <pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Wed, 18 Dec 2024 00:57:02
	+0000")
References: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
	<pull.1847.v2.git.git.1734483422181.gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:22:08 -0800
Message-ID: <xmqqbjx9yedb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> Commit a38edab7c8 (Makefile: generate doc versions via GIT-VERSION-GEN,
> 2024-12-06) moved these variables from the Makefile to asciidoc.conf.in.
> When doing so, some extraneous quotes were added; these are visible in
> the generated .xml files, at least, and possibly in other locations:
>
> ```
> --- a/tmp/orig-git-bisect.xml
> +++ b/Documentation/git-bisect.xml
> @@ -5,14 +5,14 @@
>  <refentry lang="en">
>  <refentryinfo>
>      <title>git-bisect(1)</title>
> -    <date>2024-12-06</date>
> -<revhistory><revision><date>2024-12-06</date></revision></revhistory>
> +    <date>'2024-12-06'</date>^M
> +<revhistory><revision><date>'2024-12-06'</date></revision></revhistory>^M
>  </refentryinfo>
>  <refmeta>
>  <refentrytitle>git-bisect</refentrytitle>
>  <manvolnum>1</manvolnum>
> -<refmiscinfo class="source">Git 2.47.1.409.g9bb10d27e7</refmiscinfo>
> -<refmiscinfo class="manual">Git Manual</refmiscinfo>
> +<refmiscinfo class="source">'Git 2.47.1.410.ga38edab7c8'</refmiscinfo>^M
> +<refmiscinfo class="manual">'Git Manual'</refmiscinfo>^M
>  </refmeta>
>  <refnamediv>
>      <refname>git-bisect</refname>
> ```

Thanks for filling the blanks in ;-)

The above differences however seem to be absorbed before these
strings reach git-bisect.1 by the documentation toolchain;
Running Documentation/doc-diff with --asciidoc or --asciidoctor
options do not show the difference in single quotes.

Nevertheless it is a "fix" to make the conversion a38edab7c8
attempted to do a more faithful one to the original, so I'll still
take it.

Thanks.
