Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333DC1D54CE
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462866; cv=none; b=OGt4Astw/XHgwnpcwj21c6xBjy66+V0sg+xHop2I53RPAh7G40tRq01cxRoWFzFr6TNS8S5sfoAD/2i8IxJPkRjzNMI6I6WnwyvfiNGn3Mb4A9FccSLclBIv/hO1inoyJK1GsfqIEui/k1Od1d+DQGN85N90itjd8DiNe2H1PRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462866; c=relaxed/simple;
	bh=ME6R5CA5tgdW4oQrFG9B+58Aj7NNKLCO8sMMS0Wh+BA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ugdIt7UQNuTBr1m6pfWR8Q3RWMMsnJmzWVDM5ZaOYHOFvSynYsVZf+Q3VeUv482+WgjAmapM+hI3d2mBI+iumEjqP5rQCBV0LcMrMHyQk5PNWgDsbJEmP1ew7lHNz5ochVZ+Fcp+Y3c3zFy3nrlVUrD+T7U5f2nqin8SX681tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=a/M/62Qf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSMrznT+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="a/M/62Qf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSMrznT+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3560F11402B8;
	Wed,  4 Sep 2024 11:14:22 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-05.internal (MEProxy); Wed, 04 Sep 2024 11:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725462862;
	 x=1725549262; bh=LaB9AZhAHCfS4W3awqnYJTBrrcMLPAr/CxK586qfyk4=; b=
	a/M/62QfnzAYcKy9X2rjeRNw/M/QNZ4t2Q8iaK0TWtYbJiU9U9FCY0MRuE6ELuyV
	X1GVdgydY5qFN1HnEaZX23ebGM6B30mDDIag6O3m/G8xyDBSAsTRWp4wRjobEJWd
	EBCNfBOZfV7zdKs8k+6NPUJyDMZeUMzZuZxrfYSZ7w3f63Y8PXuQ+ucFGABEA7xp
	BwgLpRTDYSI9h1tm6WR6tygRWx81zyTM/f7rARfd1iiBwRm196N3+z4R7c+zRxS8
	5NUloUiGWKIwohptTYU8Dimo8LuQUr2itqUKYER3JyThCmOIdqQYrg73R4bBH8hT
	rnlD6lJ/VjKHJYZYB5w6ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725462862; x=
	1725549262; bh=LaB9AZhAHCfS4W3awqnYJTBrrcMLPAr/CxK586qfyk4=; b=Y
	SMrznT+KZgfxNa1MNjeIlb0TAG5WHmcliIjz4CSrWhy/zN8z57aS755merEpIFcl
	yQF1PvdKoMFPUVfK0pakJ4jdNQ/AINgVXuUXt9hzTnE3loBRwv9o7BzhJwAK1s0n
	ulsAEttGV9QAkCGpsAwN+WLQaolhFWukfu/Illl0n6OzCX3xMTMWAB1sRDeHP53H
	w7rPIoB+ya76rWzH7SCpkEmfnLS58uXIPqC0hkG8w8hpnk011awS5M7cZ+Wddf2L
	rkd4blXZngmMxUFWTnJa6oZQC+IsoJS4agjpeAaARDAVS09EENyit/K5lZTYy5oD
	AC3/jYJ9QEkD/y0hyFXCg==
X-ME-Sender: <xms:TnnYZkkWjREsKbSNHwCpLgecgLDceks3zkGyJBkY31Nc4eGYYANpzw>
    <xme:TnnYZj0vWlw_KvcMtbEqsGnrYQJR15FFRnjsai6xuP_dXoTYqkNG7ACMblk8jNko2
    zXm3UNvuwdPcCoGuCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfkggrtghkucghvghinhgsvghrghdfuceoiigrtghksehofihlfhholh
    hiohdrohhrgheqnecuggftrfgrthhtvghrnhepffffleeihfekfeetheeiieelueffleeg
    vdejgffhhffhheehgfethfegjeduueehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepiigrtghksehofihlfhholhhiohdrohhrghdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:TnnYZipDc8IGIiacOCBSEEwahX8dzDDkuaK3h-R5vukWVaINkjygGA>
    <xmx:TnnYZgnBBvWPlJDoHHkk8_hIiH40y1F1i3vF9GXOWKKA5jEg0fZ2Dg>
    <xmx:TnnYZi0L3mOmJvelqtn-fwmYMmfhhk7pv9ybAtuBLdt2BrZUAK5vZw>
    <xmx:TnnYZnvM99d0ndJbUn8462AjwJXUKZb-Hcx4qB01IWQ9Vu0lXCIdDg>
    <xmx:TnnYZn-EZ2CJDGLhIVGa5Z7ZzXcmjW2mX9vcVktEodIhxDeQbMOs4L1I>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E686A3020078; Wed,  4 Sep 2024 11:14:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 04 Sep 2024 11:13:43 -0400
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Elijah Newren" <newren@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <7cfe4a14-c319-4ccd-9c1d-099139a88913@app.fastmail.com>
In-Reply-To: 
 <CABPp-BFqbiS8xsbLouNB41QTc5p0hEOy-EoV0Sjnp=xJEShkTw@mail.gmail.com>
References: <20240903194244.16709-1-zack@owlfolio.org>
 <CABPp-BFqbiS8xsbLouNB41QTc5p0hEOy-EoV0Sjnp=xJEShkTw@mail.gmail.com>
Subject: Re: [filter-repo PATCH]: add --callbacks option to load many callbacks from
 one file
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024, at 6:11 PM, Elijah Newren wrote:
> On Tue, Sep 3, 2024 at 12:43=E2=80=AFPM Zack Weinberg
> <zack@owlfolio.org> wrote:
>> If you are trying to do something complicated with filter-repo,
...
> If you want to do something complicated with filter-repo, you can just
> import it as a library.

I should have said up front that I see this proposed feature as
filling a hole in the power/convenience tradeoff space, between the
individual --foo-callback switches and using filter-repo as a library.
It facilitates doing things that are a little bit too hard if you want
to use individual switches, but not so hard that it feels worthwhile to
start reading the "using filter-repo as a library" examples and braving
the internal API stability warnings.

In particular, it gives you the programming environment that you're
accustomed to if you're an experienced Python coder -- "this file will
be parsed as a Python module" is much more "normal" to such people than
"this file will be parsed as the body of a function" -- but stays within
the lines of the official stable callback API.

It also works without setting up the _capability_ to use filter-repo as
a library, so that saves at least one preparatory step.

>> Or, if you are trying to do something simple but long-winded, such as
>> replacing the entire contents of a file, you might want to define
>> long multi-line (byte) strings as global variables, to avoid having
>> to deal with the undocumented number of spaces inserted at the
>> beginning of each line by the callback parser.
>
> Yeah, I can see how the added spaces would be slightly annoying for
> the case of multi-line strings (though simple callbacks like `--name-
> callback 'return name.replace(b"Wiliam", b"William")'` require that
> some kind of leading whitespace be added, and the command line --*-
> callback options are targetted towards the simpler usecases, after
> all).  However, even in that case you can just use textwrap.dedent.

textwrap.dedent is great, but you have to know that it exists.  If
you're staring at the filter-repo manpage and trying to figure out how
to replace a multi-line string and you haven't memorized the entire set
of capabilities of the Python stdlib, "oh hey I can use --callbacks and
then I can put big strings in global variables" is an easier cognitive
stretch than _either_ "oh hey I can use textwrap.dedent" or "I guess I
gotta figure out how to use this unstable library API that's only
vaguely touched on in the manpage".

I should also mention that I started developing this feature before I
knew about the possibility of passing a file name to --foo-callback.
(The present state of play is that this is documented in --help but not
in the manpage, and I was only looking at the manpage until I started
coding.) The thought of trying to get an entire file's worth of English
text through both Python and shell string quotation was too daunting to
contemplate.

>> The callbacks file is loaded as an ordinary Python module; it does
>> _not_ get any automatic globals, unlike individual command line
>> callbacks. However, `import git_format_repo` will work inside the
>> callbacks file, even if git_format_repo.py has not been made
>> available in general.
>
> What is this git_format_repo thing you speak of?

Doh! I meant git_filter_repo.

> Anyway, separate from that and given the above comments I made about
> importing git_filter_repo and textwrap.dedent, I'm a little unsure why
> this new callbacks command line flag helps.

I hope I have sufficiently explained the rationale above?

>> Also document (briefly) the existing feature of supplying a file name
>> rather than an inline function body to --foo-callback options, and
>> the availability of an unspecified set of globals to individual
>> callbacks (with instruction to see the source code for details).
>
> Thanks for being helpful.  Do note, though, that different logical
> changes should be in separate patches.

If the overall change is approved, I can split it up into a series. I do
think that the --foo-callback <filename> feature should be documented in
the manpage regardless of whether --callbacks is added.

zw
