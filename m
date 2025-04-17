Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678C199EB2
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900321; cv=none; b=BaYpEjoiLrbup61RUu9UhR873zx/vIzeVNJE3o/7caNQDZ3PWggY+iaeNGynJ1yH4XTId36QGHRcthT8YwgSUl1LEEv3FdKyukpKjmbbz/4OfgEZjpqmcmFz/PoOaDXIJop/T65taOjFhuzIDzleLzZ2+GNFuY8ld+Nmlz7Hr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900321; c=relaxed/simple;
	bh=cy47w8ILHzCSv9PMwkA1uaSwNz1hdYIJ3qufxdNonBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L87sAeABWNT8BSreMYx5/S7x1hz0tweiBDQsCatmStRrNupeG/XTso5dIGroZPgVH8z9tVzILoL5LO8KE8ym+qlO8bLe0b/oASjwyUPUsouoX21bdOaVmmBCdDlCqA9+entZ02ILprJFBofpNPUf08OVusMAlsg22N+iwHSWKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wfVNyZCN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gTO2T6sy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wfVNyZCN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gTO2T6sy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AE242114011F;
	Thu, 17 Apr 2025 10:31:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 17 Apr 2025 10:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744900318; x=1744986718; bh=qeVS6CvZZG
	gUZaXy38dn8JdrLhhjSNbXC04W+M81yE8=; b=wfVNyZCNHCs+/Kn8BA1aGJWAN2
	KlrVgSSGLYTh5zfeVwltkylvmCqWok7wUUH8jKnzrVaX8qhbrUk3u5epDASF98cS
	F2l4lXm1r2qgO9xVjoA/RqtFmAQRB4EfLJ0Jjmh58akvAR9KBku5PTavyjCf4tmS
	DHWL0xQTCALtZSDGWcIwkvIYGtbcgh+oeDqVFqGhCv7rHLLMhgKbbKIivf6iUfyF
	GNJP9uVVnfaYAlLdmEkZzVYUUug8HBMU3ZvHgihF+7xiN6EjpvaUz1VX443Zebu9
	B5M/cXn9MncZtPI7ZtNHs2+OlB3hjc8SahSRlEC+TeHjTX6x5jh4tIfYMwJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744900318; x=1744986718; bh=qeVS6CvZZGgUZaXy38dn8JdrLhhjSNbXC04
	W+M81yE8=; b=gTO2T6syXk98VvW1sT8FrXaAr3qU98kdfJ+IQvdXmeFbXLUAt0w
	xSFaVUw0AurA2boY9UUG00okqGgXEq43MGy9yTpEj/wKeZle6jRVTA+/lC2ZrssI
	wIFZol7KjOZG2Qs9IwVJtamexVLMRIZIpt5RRV8VQ7WYxno4loyxYo1igthIeLkG
	IA0Ck1QeOb8+SmFSr9qEcpS/ThnPpzFwqTQtItQo1siuyizw7uR0bqPfsz/FQlsn
	6L5aF1yY5/R9pB/BYpyNgstxYEGF8D2wBD7X5hbX/K9OWsD92E39i70W/hCGXzE/
	TomSGN78acnEYLGo8LVY6D9s6LJuwWeTdEg==
X-ME-Sender: <xms:3hABaAZVk9UaSl_acCWidwtjhdu-qQRhUcOnH86PfztPUvUxFwGISA>
    <xme:3hABaLaznCuSU3bAeISb9o2usDozqWn37qV42Tu1gf3Xsh56NxTaxCu-_2u2DwChG
    mKmzQP2Gy3TnL2x3Q>
X-ME-Received: <xmr:3hABaK9gVtI_oXQAiqPXD4X1LIXwj3_scaEpm0U9PZZzL3yVxS5MxcTQlKvONJ8nZZLpPMgDfuOcaNII5AexFKsKLaDWFldUXe6O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepthhmiiesphhosghogidrtghomhdp
    rhgtphhtthhopehlihhsthhsodhgihhtsegrkhhshhgrhidrihhspdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3hABaKrQ21GAO3NGsZfF6EAca_3jBkpNFvt1d4aapiHCc2g5dBO6Sw>
    <xmx:3hABaLpYDF02E1CkX9kg68vrW4xhkPEmBIeAO9yDDk8_dMOzwMEfmA>
    <xmx:3hABaIR_V04XAk3n9dyFrJEnUjN_hdOzBaunDYSWkLqvUk2BUXKERA>
    <xmx:3hABaLp0H3AVPyP3kMrG3K2LPR9qZifaDEdswadRi1cZ7HKkgazMwQ>
    <xmx:3hABaOG9Vlu2ybjmoPF6YH61SourtQw8db1qVjrlWjDZOAa_bHnPrkoy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 10:31:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Todd Zullinger <tmz@pobox.com>,  Akshay Hegde <lists+git@akshay.is>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] meson: install shell completion scripts
In-Reply-To: <da10dd26-a7bb-474d-8c9a-cac32614d296@gentoo.org> (Eli Schwartz's
	message of "Wed, 16 Apr 2025 23:58:22 -0400")
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
	<Z_RnJEyvtGh_0kFo@akshay.is> <Z_SJSKrUdiWzg4pw@teonanacatl.net>
	<xmqq4iyxs02r.fsf@gitster.g>
	<da10dd26-a7bb-474d-8c9a-cac32614d296@gentoo.org>
Date: Thu, 17 Apr 2025 07:31:55 -0700
Message-ID: <xmqqzfgeeu5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> bash-completion looks for scripts in a few different places, with a
> common theme that there is a "datadir" followed by the literal path
> bash-completion/completions -- some values for the datadir:
> ...
> ... since as long as you leave meson
> datadir and bindir alone you can install into absolutely any prefix, no
> matter how weird, and successfully invoking `git` itself will as a side
> effect add the correct bash completion file.
>
> And that also means that distros automatically do the right thing --
> just configure with prefix=/usr and we get
> /usr/share/bash-completion/completions as expected

OK, so that is clear and easy.  Next to where we have

    infodir = $(prefix)/share/info

we add

    bash_completion_dir = $(prefix)/share/bash-completion/completions

and everybody would be happy.  We do the parallel on the meson side.


> With zsh, things are a lot shakier. ...
> ... (a lot of explanation on zsh installation path quirks omitted)
> So, my personal feelings on this patch are that we can and should
> unambiguously install the bash completion, but it would be reasonable to
> defer handling zsh until someone figures out how to do it correctly,
> which may be impossible.

Sounds good.  Or just use

    zsh_completion_dir = $(prefix)/share/zsh/site-functions

perhaps.  Those who are making personal installation under $HOME at
least would know that what they have under $prefix mirrors the
/usr/{bin,lib,share,....}/ if things were installed for host, so
even though zsh does not look into there, at least the layout would
be familiar to the user.  But I am even happier if we decide to
leave it out as you suggested.

Thanks.
