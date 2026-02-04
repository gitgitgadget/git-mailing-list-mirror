Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98292F83A2
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233195; cv=none; b=IRhsuHniTx6PhVC6ClGX/fwEGQxBMpgIX0ZVm2km4vCu7olc46k/01gTNf94PGEdeRYklgvF8FkCqLW0x4DUWe3bbw6aCP7n9gl+2HOEgOYJtU6LQTkuq7jqaV/mkJ5MzOwn35+zhRr2CKDspGq1X8tYGMff1ZCOI/W5PBN0MBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233195; c=relaxed/simple;
	bh=3F2qQ4UdJTDUQQF10XsXc9Axiqph+wGlfksy3jMGl78=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DrTSkHbmgVdBOfPKZF/i678H9oCibvIS/B2huTCqE3K+f5x3Q0ayr0pYEiqeaEWEMGGUHWozSBu1n2jcT31NK9omhxSYsPX61ZfKR4yOmObCxnEgNKAFYp37XgsZm93viBgKzHSuDtYU86IJIs5d3AqQ8LINfxojCOY7iIldeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ktdn3C0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLKI+Gjv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ktdn3C0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLKI+Gjv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF6E514000F5;
	Wed,  4 Feb 2026 14:26:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 04 Feb 2026 14:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770233193; x=1770319593; bh=65q8pcAUOb
	bgi2+aQysX2Tz2ryOVRitVZiHg6fT3oWs=; b=ktdn3C0X+dE2LmZopkZDIdcC1B
	t6v34T7/+AMjdHGnlDV098167m7Xax2ZEPBNb59rghPOABDCFQz/dwsB5+ZnvIf5
	BxwBP4uBzNBl0F9dIX27Nnlsp6iS8FYgTz/Sn+r1ENbYBCZlKqPFtMafySDl3yge
	RpgNwAfyRxlXRsd16eZnOAaTSDd/rEYrLVuKtb2X5S5mT3Bk5YKX/ojibkiWzqWe
	6U7r+TqoM71loNO1FWTdaCP7qfQYC87t/qjElpiBSKGux8t2HT12xFftNFcHR/Kt
	0MmL4RkZv/E6CQjODg19DAkmRe5yXs7HB87KzPAjfBtQz4JNVAW9A6HJ47QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770233193; x=1770319593; bh=65q8pcAUObbgi2+aQysX2Tz2ryOVRitVZiH
	g6fT3oWs=; b=fLKI+GjvNx0n7CAwaopc0h1PpRFm38p0zKyygiIa+zbAyMEptm5
	THLrSHEM0dNOJRMrxn8w/2mXdtITQ2nTTtNcjo5R6w/xFv8dm9FHYadGeKiFmCOY
	2CvhvGP37w46EJqhhawoNlZbWdC8fIojx85sB7RJjuV0sVoXb2nzK31e44PyphV9
	y1idVe740oH5u5mcBirPiwwmpzEdyRSIqmrSlD9W4k4/7S4yf9SvhJxRRENv8zUb
	RTRrVCGDRSJKzJ5s1vkqTOv+7iQdRisyyb21+qqpHoQLPqYQEBawC9Y0HF/LHW5H
	1doduWHqNllStiJEiHSM2Lwbp2zndhQNa3g==
X-ME-Sender: <xms:aZ2DaYjdHVZorMrC-1-hHfSfPe0-ipju9aTs1DD-mp_7GY2UKcBmWw>
    <xme:aZ2DaZOTkWsrOwANLcBcF7heG6OV4BIkc5l3LwdbyGwqaTE-CRDlVO8HerqpkbaOK
    tfqPG4mbMs66EZU5A1OBqyOUYpF5c6qoTFR09CEyFitbBBKAfxkmg>
X-ME-Received: <xmr:aZ2DabqpkKY_ogXgZxUBhc2oAfwEnIzarX1BWDV9S-6xRaP7e5xyaNSQaWNy3y72PF39sV6GLtfDAJQEN6GkpaX-qt7DjDdaLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepueeileelueegleehhfelfffgueffvdfgteeuffevjeegudfhhfevgeehkedv
    ieelnecuffhomhgrihhnpehmihhtrhgvrdhorhhgpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrg
    gssehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehophhohhhorhgvlhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:aZ2DaT7mBQrfOljmct8YV1GNCYJXIXEn1e4RV7PWOekYolabPE3t8Q>
    <xmx:aZ2DaRgA1Y3pr2NMEJDz9wa8u2D3lLNEsQMG2AMPO5mTqJIRI1GU4Q>
    <xmx:aZ2DaR5ty54Pk8QCoVYF9TiiBGSGj2UrA5tYyaLQJ746OwlXsUfpdQ>
    <xmx:aZ2DaeGEGcw0nXGFQnH1nrJ3Z0zRfXulNZeUSk-BPgPtu0GVhYcyhA>
    <xmx:aZ2DaZXHrFid_KI6xzAItQl_Ndxy2dBCIrhNxxkQ15u2L-BVISXmsSAa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 14:26:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Phillip Wood <phillip.wood123@gmail.com>,  Andreas Schwab
 <schwab@linux-m68k.org>,  Ondrej Pohorelsky <opohorel@redhat.com>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/6] Sanitize sideband channel messages
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 03 Feb 2026 10:17:56
	+0000")
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
	<pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
Date: Wed, 04 Feb 2026 11:26:31 -0800
Message-ID: <xmqqv7gcnwd4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Git's sideband channel passes server output directly to the client terminal
> without sanitizing it, creating an ANSI escape sequence injection
> vulnerability (CWE-150 [https://cwe.mitre.org/data/definitions/150.html]). A
> malicious or compromised server can corrupt terminal state, obscure
> information, or inject characters into the terminal's input buffer (which
> the terminal will interpret as if the user had typed them).
>
> Git users have no mechanism to distinguish between Git's legitimate output
> and content displayed (or hidden) via attack sequences.
>
> This series aims to fix the vulnerability by sanitizing control characters
> in the sideband output. To address concerns about existing hacks that
> exploit Git's lack of sanitizing, this security fix will only kick in with
> Git v3.0, where the default will change to pass ANSI color sequences (SGR
> codes) through by default, since server-side hooks exist that use these for
> visibility (e.g. https://github.com/kikeonline/githook-explode). By default,
> all other control characters will be rendered in caret notation (e.g., ESC
> becomes ^[).
>
> Users who need different behavior get configuration options:
> sideband.allowControlCharacters provides an escape hatch for environments
> that require raw passthrough. The defaults in Git v3.0 will be secure.
>
> This series applies cleanly on v2.53.0.

Thanks for an updated series.  They applied cleanly and merged
cleanly to 'seen'.

I have three problems with this round, some minor, some fundamental.

 * There is a value "default" that the user can use to configure it,
   which changes its behaviour across Git 3.0 version boundary.  I
   think this is a horrible design.  Those who do not configure may
   be showing their acceptance "I can go with whatever the tool's
   designers choose with the option, and if that changes in the
   middle, I can adapt", but for those who do, the configuration is
   a mechanism, an escape hatch, to express their preference and
   avoid getting disrupted by future change of behaviour.

   Fixing it is easy here; just remove "default".  Those who want to
   live in the fiture earlycan set it to "color" and it will stay
   valid across Git 3.0 version boundary.  Those who want to make
   sure their control sequences won't be broken can set it to "pass
   everything" and it will stay valid across Git 3.0 version
   boundary.

 * I would have preferred to see the early parts of the series all
   being opt-in, and that subset of the series be able to graduate
   earlier.  Way earlier than the default flip to prove that they do
   not hurt when unconfigured (they are theoretically no-op while
   being opt-in, but we want to make sure), and that they do help
   when configured.  And then once we are satisfied, the default
   flip can be discussed and applied.

 * The overall approach is "we know better than our users what
   control sequences we want to pass, so we will write code to
   recognize these small number of control sequences and allow
   them", which I am worried that would put more users at risk.

   But the thing is that our code may not know better than the users
   what control sequences, which have little security implications,
   users want to use in the payload between their servers and their
   desktop clients.  What happens to these users who use the control
   sequences that the code does not recognize and still want to keep
   using them?  They have to either

     (1) write code to teach git to recognize their control
         sequences (perhaps they do want ISO/IEC 2022 passed) and
         tweak the allowlist mechanism to support it, or

     (2) use the allowlist mechanism to pass everything, even the
         sequences they are not interested in passing that have
         security implications.

   Most of them I suspect will do the latter, which is not what we
   want to see.

   Can't we do this the other way around?  The code may not be able
   to know what control sequences the users may want to use better
   than the users, but the code (and the author of the code) should
   know what control sequences have negative security implications
   much better than the users.  Instead of teaching the code to
   recognize control sequences to color strings [*} that have little
   security implications, can we teach the code to recognise control
   sequences that we do *not* want to pass and neuter them, without
   molesting control sequences with little security implications
   that users may want to use?

Thanks.


[Footnote]

 * or sequences to go multi-lingual over 7-bit by using ISO/IEC
   2022 ;-)
