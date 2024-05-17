Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE231426F
	for <git@vger.kernel.org>; Fri, 17 May 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715927394; cv=none; b=f33Qmdd+x1cMMSOLK+hG1owBPkuVWVYEXg6wa+6BwiobBxmLCw3eyyyK0VwLqoNEY4hd11e36N9DS64JwE8rGvCt1V2e4TR4jRZ6SiGaOee7qdhgA04r0Lz8llzJraSgHFGo3+VCdeRcwQRrcir+ygn5E+Dw1Hk1cgbStrJzNlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715927394; c=relaxed/simple;
	bh=Ig+5li/lSfuzlZzySKlGq148zk2NiJMRWieqyftCSn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRX+LwgrOJVhOEW26k6jbowd5rtvRN5IgeTJDlBhwAQGy7oKqD+OYD1XWv4orhJQ8uBVHWTBW4dOi5VknWx7GdhFPvP0pwdDCFleWtFtQHyH9lEC8XAFcEsxVj4sNVevEYlNu035F1l6LcyaA9TuMaO/BVB5o9FrIigFbifIj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nJgzKMg8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MrIr+4cL; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nJgzKMg8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrIr+4cL"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 890471C00102;
	Fri, 17 May 2024 02:29:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 17 May 2024 02:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715927391; x=1716013791; bh=Ig+5li/lSf
	uzlZzySKlGq148zk2NiJMRWieqyftCSn0=; b=nJgzKMg8nYfopHNXNsTYYa/VHy
	CoZG8V8gTbV8eruF3utOi/7kv3RchDsEHZLCRAw1nKLqqPcW6UzYTkhS6nrv5KUY
	e5XrXqWUvldrieJFm8ZXMO6QZtvfRradTiVcUET+8+Gk9d5pSWe2LA3zPDekTFDH
	1RPKrr8ta+T5wztjB4LPCb3Hq3WyMj6V2nXM2hsIWRXNeWoBmbBp4yCBgvUncBgT
	U1LC/rzLjxYW19lvTzGvk09Xe5DCBe3ABkgDisQfF/Wu8D3d3ppNZ9aRRrqhbXfQ
	dHUUdqYC0AE94tE5vECyRaMi1sQJNND42A8KjDjtSWWhJedZnRzte5j4mmIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715927391; x=1716013791; bh=Ig+5li/lSfuzlZzySKlGq148zk2N
	iJMRWieqyftCSn0=; b=MrIr+4cLMsXJFVdkBkCE57huqStaR4GUkI/QDUfS7wxj
	RQBUCNJeyKPYSYC6i31IEigs0oeqBkvoHZKlLtXH/KC1+JMSPON2FZmJthz0P2JC
	DcPLuP7DAB+jMYrNUWNcjaofQl058fAmQmxvC0w/3JlbO4rc5SDD2J9y4WvgjceQ
	7HqVGci61xG1FdNBHOiSWSOx1mxKkK/QOAkKNMxFtnPRae7WxkCBznFqNJ605fF9
	J/uNTgahpDJDUY9tb45WbE38anXr6anudpsQbInNmo1YyV0T+2QD/kbKpRfYk3cO
	5Zq4pKblHW0rIeVnVQJMsuCXGghnMG5MEcylTeIViw==
X-ME-Sender: <xms:XvlGZkrvrYn4Ijlny-yCcBAo1TsbqkJJ5jMWFaWPananaGyJYp62OA>
    <xme:XvlGZqp6OfBscu-hpZvgz33Bp61Nrf7J5mfAyL4IuVlYE-YSaZG2cmVllQfUWHpmV
    5hobr-_NuT4PNkxyA>
X-ME-Received: <xmr:XvlGZpNOxmTh19p-aGGXXNTdqhx-zPLUwAJ6YPASNVVPp5KOAnRJhZepUUKIAbCG725s-ck-yBQvrQNAOtHZ8JsKpJ0Faw-dZ3rwTZr3QvSIwE7now>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:X_lGZr7ybkG1VJ7RvzYkFkcFHsHsgezthgtnybTut8B4_OkPyidvxg>
    <xmx:X_lGZj7Tv1EHbnrEemzWwpIa6xYqXMlqqvSfk6ccefq_-81AFmWAtQ>
    <xmx:X_lGZrhBhSh9yAyjtu3-OioaXT5EM2UXW_DDrsL8QyuOj0LUNpTjCw>
    <xmx:X_lGZt7cBZL8FDI4591ei7GtU-rJU5eDQSiXvQ41-ihfrCCtaGUXKw>
    <xmx:X_lGZmYD_7iGr1pOfMJpcxmkO_cINRzGwet-eq4YEk3I2u1n8oM5Oi-V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 02:29:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 61d0e52d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 06:29:20 +0000 (UTC)
Date: Fri, 17 May 2024 08:29:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com,
	me@ttaylorr.com, emrass@google.com, nasamuffin@google.com
Subject: Re: [PATCH v3] doc: describe the project's decision-making process
Message-ID: <Zkb5WeaTOLg9b5p8@tanuki>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eXAfp2XmRC/pAzCz"
Content-Disposition: inline
In-Reply-To: <5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>


--eXAfp2XmRC/pAzCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2024 at 02:20:53PM -0700, Josh Steadmon wrote:
[snip]
> diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
> new file mode 100644
> index 0000000000..274ddfa62c
> --- /dev/null
> +++ b/Documentation/DecisionMaking.txt
> @@ -0,0 +1,74 @@
> +Decision-Making Process in the Git Project
> +==========================================
> +
> +Introduction
> +------------
> +This document describes the current decision-making process in the Git
> +project. It is a descriptive rather than prescriptive doc; that is, we want to
> +describe how things work in practice rather than explicitly recommending any
> +particular process or changes to the current process.

Nit: I think we _do_ want to recommend a process, but don't want to cast
it into stone.

[snip]
> +Larger Discussions (without patches)
> +------------------------------------
> +Occasionally, larger discussions might occur without an associated patch series.
> +These might be very large-scale technical decisions that are beyond the scope of
> +even a single large patch series, or they might be more open-ended,
> +policy-oriented discussions (examples:
> +link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducing Rust]
> +or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving submodule UX]).
> +In either case, discussion progresses as described above for general patch series.
> +
> +For larger discussions without a patch series or other concrete implementation,
> +it may be hard to judge when consensus has been reached, as there are not any
> +official guidelines. If discussion stalls at this point, it may be helpful to
> +restart discussion with an RFC patch series or other specific implementation
> +that can be more easily debated.
> +
> +When consensus is reached that it is a good idea, the original
> +proposer is expected to coordinate the effort to make it happen,
> +with help from others who were involved in the discussion, as
> +needed.

One thing I want to eventually propose is to go further here:
documenting the outcome of the discussion, regardless of whether we
decided for or against it, in a low-overhead format. This could for
example be a small paragraph in a "Documentation/Projects" file that
points to the on-list discussion together with a small summary of why
the decision was reached.

In the case of the Rust discussion for example I think we ultimately
decided against it due to platform limitations of the toolchain. This
limitation will potentially go away at some point in time, and that
would allow us to revisit this discussion. Now if we had documented
somewhere that the decision against Rust was platform support, then it
is easy to revive the discussion at a later point and point to that
exact reason, arguing why it's not longer a problem now.

I don't think that this change needs to be part of your patch though, as
your intent is only to document processes as they work right now. But I
wanted to bring this up regardless as a foreshadowing.

Overall this document looks good to me, thanks!

Patrick

--eXAfp2XmRC/pAzCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZG+VgACgkQVbJhu7ck
PpTkkhAAnwdQYSXiGIyEcSTT34Cg4M97HVqCV3BbDX+Lce5tY9o4hUoj1WZgDkys
sj9QDtJmrPDQgml3OAf7FuzAF4iuh7i8oMqcX2i750pQrbE+/tg7YLXcUaURWpUW
+NWOa/hdJgvPFyXF5OG4RrdrewKSdJClXRQSSuplBr0JHiKPRvqsO16QiniB2WMk
KXkfnFg8XZwmarkjjk2Kptksp3o/XPy/VVFeMRi76Cpk0aTZRiMNavkn1j0/nyPy
u+CNrHqVW+wr83NvzqcvXqNn+S1q1NTtood/Kpr7QEQNSwwm8FS6OiQMtPF8iNWD
NJm47oDaJgz7e+6Z+J5EdluIvPFiWeJQrRWFtJXHC7M1sFiqS1ZXT65SNsA1BaA/
PCx/V3mdH3ZhWFDKzpy0IrOcZZXbBgqNMC90rZ9AazKZVX3jCqJN3rWiCLIvRdbJ
ZPbCODf2ib6DvzZ32NFnxRJYMdY5HgKY1jWh1g67w7gRRKFR2R9dj3hq/6c+hJM4
VJymZ6hT544EqCgRiitdcyhDvcrH/M674pcZrOUXYuFxKvLgr4ca6A8K59cVPH0M
/gKgl3tYow36EW4DMXqxO72nTgxSEdTzzNXv/C61OQYWNB4FlDwxw173KIvC/Yo0
NJHRaQhPjdApMngf4FqEI4NPNpalQE6eo+6SzY7cQcB7f1B/HJ4=
=jIxU
-----END PGP SIGNATURE-----

--eXAfp2XmRC/pAzCz--
