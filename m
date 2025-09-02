Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571462C21C9
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818056; cv=none; b=OS48/5ttsXyXbDkUsIhV++Mtob480iaV5oseoaRWO2cqULRD7BKsLLo5AB2coOIjUvUw9+D/ij3gPAzE/maI88JZx0rFDrN9V1pTBjG8w5x75qYOTJnEUpWo2HW6PRPAFdkflGzRFvflCkUQM3Cs6CTVKm+MnqANuEwJrqk+BCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818056; c=relaxed/simple;
	bh=rv8PFXBEr5E/Y3cQvJVUi9GuNsmC81so5wDN71E5Ugw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoclH3xnxQCkj4yqdDKUXNWmXxK2VTFhRPZHOqlJ5ssMNuMMtB2lzZr2pmaFA/y8lhr8E9Cy2Xo4qoLkXFapqtGf2DBBKzCAVezxbW6pB0wnY2+a46r1lhiCK/eM5p/6i1C7Ox0cHz/9oSyg7d2IatM2X+YhYxnJo/ptOKkYbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WhiZ76Oc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iPCVAlYe; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WhiZ76Oc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iPCVAlYe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F8CC7A02E7;
	Tue,  2 Sep 2025 09:00:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 09:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756818053; x=1756904453; bh=/sFknjRbWP
	GvEYjL/eOnHMzAn1Pgkz+X08FtoYYMBm4=; b=WhiZ76OcNcGB7JRX6qq6LRU6ab
	bFxM1fVM0PgOmVYFZaGEsAAgUzFaZxjAHnmIUeeNWSZFlXzk6dzoyf89fmnkR4Yg
	3wxpfkyKSTwaFKMluSgSKo8fsToYw55FzbRcTG4QUitjDIxd8clsaHx2CJqaCLne
	02LwsYgeL5rdmxczOxQLperwVfF9taaFjaimp+QDj4JBuo7SqLOoMyUeHjT7f5Ni
	e0fdwu+VXVERj1cAfACoWFChjLTBG0faGJ+ICo/qNBXUN0URC7d2Y9VZijZI1/y/
	p9f68y9ps35XvCXUse6W8zyeSPWWaXuKcRc+lSRyqbEZE1U0F+4eknOzYFQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756818053; x=1756904453; bh=/sFknjRbWPGvEYjL/eOnHMzAn1Pgkz+X08F
	toYYMBm4=; b=iPCVAlYeZY3jIwapre/mXnRFG0U7KRwKeMTjFoM5totZ2SV8vKc
	08opdBG8a10YkvnnyVsGozqCK5O6Q+gO5T/9PnGL0EFagR21nxPQmkTJ/I+L9RHq
	EUgoSzn8qNIdRFetQd6sQ8UE2y/cyTshZ/OfwJN8H3nc0sjeIsYsbFkiS3exd2I6
	K02dkO3VtQsJpIdgpIZKnnt0oOrgbHhzE9rj8ZaQjjoqBNXSvlqByBEfXW6ubLdK
	S09zBsiQUBnc+jC+ukB3YBk4bH0hBEnNwyTxtGX6Zs6DIW0CbX2rOOH/mud7nqt4
	Xnr2osbS/dSvwiN+SNWGaFlB/4Eakkj87AQ==
X-ME-Sender: <xms:hOq2aCGf2Bu-P1fKe4bQz5XkkYv5-JHJIramaQaTPKpjxP9PKrqfxQ>
    <xme:hOq2aGlvHf-BWEW1hn_iFsyLurAbcdBayma4cJ3ssERYg176vl_RngdyX5dphImHg
    WSviYPUrs_E4XwNqQ>
X-ME-Received: <xmr:hOq2aFlJN72aWoNssX137OU3-vWdiof9GGbg8eW9AXuby61NoEVDR_V9wzCe_fLtMiiPzKhRY18-XaxH5Q8hqY9Kwz83_1JyhWmH_RZYcRee3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvd
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgue
    egudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hOq2aHus3XImMyO5ibe2NxZlbix20aMhRlQvW6Z-GZ_KKtT2ymty6Q>
    <xmx:hOq2aIlzTsdvZOHaAa6lm5cJt5ynP3vEOScNXQkb9ubPDhZ-2XXEbg>
    <xmx:hOq2aCtRUxaKbfTvbVeRXS5kHUA192K7halaxCcBSZnYk6Oa24uilA>
    <xmx:hOq2aOfxON2RcN70ki99tGZvBv-BRmxw64N0FhsLkJatM9I2UGHhvA>
    <xmx:heq2aJYRJxKfUlGo-MeQikvdy7TP-wQzCu2gOB-z0j400EmaY_iwn5Zi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 09:00:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1691dcfc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 13:00:49 +0000 (UTC)
Date: Tue, 2 Sep 2025 15:00:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/3] meson: wire up gitk and git-gui
Message-ID: <aLbqeL1X5CajH-Z8@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <xmqq7byzfh0w.fsf@gitster.g>
 <aKtLCAq9Y-59cIbc@pks.im>
 <xmqqsehencem.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsehencem.fsf@gitster.g>

On Mon, Aug 25, 2025 at 05:40:17PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > If this is proving to be a blocker we can also change upstream to not be
> > a separate project.
> 
> What do "upstream" refer to in this sentence?  Meson?
> 
> If you are talking about "gitk" and/or "git-gui", then such an
> alternative version of these patches would not change the picture an
> iota, wrt "the limitation of the tool should not force the sources
> that might consider using the tool to pay the price---which might be
> proving to be a blocker", no?

gitk/git-gui in this case.

> Not that I am saying it _is_ a blocker.  But the above sounds like
> making things worse for no gain, so I must be misunderstanding what
> you meant X-<.
> 
> So, ... confused.

So, to hopefully alleviate the confusion, there's two ways to include a
certain directory into Meson:

  - `subdir()` includes directories at arbitrary locations. The
    directory is treated as part of the project that calls `subdir()`.
    This is mostly done to segregate the project into multiple different
    components to keep things more maintainable.

  - `subproject()` includes directories in a specific location. The
    difference is that these are treated as separate projects, so there
    is a certain boundary between the top-level project and its
    subproject. Things done in the subproject won't taint anything in
    the superproject.

Right now I'm using `subproject()`, which has the effect that both gitk
and git-gui can be compiled standalone with Meson, but also as part of
the Git project. It does have the limitation though that the project
must be in a specific directory.

What I was trying to say is that we could convert the build instructions
of gitk and git-gui to not be standalone projects anymore. This would
mean that we can include the subdirectory from any arbitrary location,
but they cannot be built standalone without Git anymore.

Using `subproject()` is a much better fit for our specific use case,
even though we have to move things around. I'm not particularly fond of
this limitation, but I haven't found a better way to achieve this until
now.

So yes, it's a limitation we get from Meson. But it's easy to work
around this limitation by moving the projects into the "subprojects",
which is a one-time cost, only. I've said for a long time anyway that I
think our top-level directory could use some cleanup to make things a
bit more discoverable for new contributors, e.g. by move all the code
files into a "lib/" folder. So that's probably part of why I don't see
this refactoring as a huge downside, even if it is working around a
limitation.

Patrick
