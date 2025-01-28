Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E24A1D
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052572; cv=none; b=ZmbK/LMa8gmxTe/4u8xdB7U2G16zgorxF9IWw+uKDtxpLMYGSxp2tYAoa4xCkgQlRdhaeRGQ9Wj7eOQU2IavVe4zP/1HamoNw6OXSPdzOuaXNIY0sqm6qRBG5Yom2zW5fOUL5Z8tXj45M/JQeKaabG3r3R6bGhodu+OTXIxp1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052572; c=relaxed/simple;
	bh=eQ1hxlG1tMkl4+JBkAlTeOS4hbXOuoaUrkkaCyGCYqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6WAWrPWpicBdLV9f0KIjX7HLSuUl69DcqgM1la80zEjggV+OY1un7xaVt9NrldLOm7JUIKeb4K8MaUqOBZKVH6qRwVup1x7ruIeOKrq97iTz5Q51YHcidD3gAhH2gU7S5KUt1C9T9DPWzGy5Wcr6V7HXJ8ac5y4jmaBTXLIwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IqAurYkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p7YDXT2z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IqAurYkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7YDXT2z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 025E2114015D;
	Tue, 28 Jan 2025 03:22:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jan 2025 03:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738052568; x=1738138968; bh=1U1NwnSafx
	Jk8RaXRMwvJg/BvWPUXngFNnnk/oGBYDI=; b=IqAurYkl7HzuO2bg74EexrOE3x
	OKYbO2Ujvk2oapofSmHNb8mI/BninNAphXZW2Y+Z7RQsbG0cx7m4CU+7rM6Ma3Ar
	AorDgTviwjY0geUuAnzcKEL5a/SoW+s26d9OMIrGw1tulHCjc7iryAA28hJha5WS
	XRahMlHSyec8vHtMjgAosC6A7mbqDibr+X3cDGhAflMTgBTjzlMbATYKY37PkZ+/
	+FZYQYLt3B2MLg1qT8XINsN+L5ay+5IxEgge4LN6k+UthsW4I4onhgBWVyw2f7y9
	sB4Bzr0uhDGnNbBNvMo8hhZUMXttbufI+T9XjHyXGMxxQPxCi1VZgJ2rsYiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738052568; x=1738138968; bh=1U1NwnSafxJk8RaXRMwvJg/BvWPUXngFNnn
	k/oGBYDI=; b=p7YDXT2zddE9pqCY/B3tYFF4sINpXp3pS9rG4exhlGg+5Ye6HBy
	smZnHSQeP+vtMvqoowdeVuq69KiQ3TrZhpG+btR0HCH+KCOx3sSpfUFBNEfEcv8J
	qT1tQJDHiFjw/8K5HNYnJCCxH/uE24gZp4CdI3/CZYEA3ZoQzwPD0751hvOQdmOW
	EbeeMo95EprGEl/Ivb8c1oDT5DttayoDmbCt6zWA+6TLN5OnOffqN6FKT4djja51
	UN6jot0pphjFnXBlsSsC+zj9CG5ytCzG1JyflY9GnW3UuOUPNgrNIbP3vRUHWq3y
	+bxKg9EIwWyHgS2MK1iNVoIfZ2RhZyChUXw==
X-ME-Sender: <xms:2JOYZ5MxlmM1AbBK-Gul8T03wOrM4OrnOu8YM1NrOhhdiqKDWxbr9A>
    <xme:2JOYZ79J98wFaT_jdnHzm-6VqhxCsiiqus1YYbQAnAdHwj0KH24LecUT0bPVYq73b
    QjY1Hm96ETfG_rL6Q>
X-ME-Received: <xmr:2JOYZ4RYAAflezJGq6cw9pawCIYf_YlVUXOZ_R7-KHpQpzFy7MHAo_kvHBFC9P7YNQI91wA8MPiuUILTRDE9VktF3jnGY81N8mRritFTCyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:2JOYZ1u0P6GjQp1VM6PoOdCWqi0VRPJqvP_UW23PDtOf6x_S0s5Rvg>
    <xmx:2JOYZxdRUU6snWbczMnsXoU50QXyo0jmTvp63S4yedSsCR29fiiF6A>
    <xmx:2JOYZx3NlJsg-ACxvj3swoFB0tEsttBSFaoD9LfEJSlKHuTyvmV5DQ>
    <xmx:2JOYZ9_0_J2rds-RmgYeqmaX0iLF7WOC1U8OcjYKSGrxe4iOmakrjw>
    <xmx:2JOYZ17ZbAf3uGdSUvOLFCZv2usjQxgqNN91-dk7GeqG1scqCdYEEuQT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:22:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9dc12cb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:22:44 +0000 (UTC)
Date: Tue, 28 Jan 2025 09:22:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 00/19] reftable: stop using "git-compat-util.h"
Message-ID: <Z5iTz69yq-IF9qU0@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
 <xmqqtt9krw1z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt9krw1z.fsf@gitster.g>

On Mon, Jan 27, 2025 at 09:44:24AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > This patch series stops using all kinds of helpers exposed by our
> > "git-compat-util.h" header and open-codes them instead. In order to keep
> > us from using these helpers by accident the final step is to pull out
> > POSIX-related bits and pieces into a new "compat/posix.h" header, which
> > the reftable library then uses instead of "git-compat-util.h".
> 
> Very nice.
> 
> Is there something we can also do in order to keep reftable from using
> stale version of these helpers that it copied with this series when
> we make improvements on our side to the original?

Overall the amount of duplication is quite limited. It looks like a lot
in this patch series, but many of the changes are really only a couple
of lines of code that are quite unlikely to grow stale. The subsystems
that really are complex (think tempfiles, lockfiles) use the same
underlying implementation as Git does via shims in "reftable/system.c".

My hope is that by starting to use the reftable library in libgit2 we'll
get additional test coverage thereof that helps weed out any issues we
have, including issues in the compatibility layer. But I also assume
that almost all bugs that we'll find will not be in the low-level code,
but rather in the business logic of reftables themselves.

> I think the answer might be "then use a common library
> implementation that is used by both Git and reftable", but then we
> might be in the same place as before?  I dunno.

I don't really have a good idea for how to do this. Using a common
library would likely push us into the same place as before indeed,
unless we started to split out standalone files that aren't allowed to
link against anything but the "compat/" directory. But even if we had
that it would be quite painful to take the reftable library and reuse it
somewhere else, because now it's more than just "cp -r reftable/" and
reimplementing system-specific bits in "reftable/system.c".

I guess time will tell how much of a problem this really is. As said, my
prediction is that we won't face many bugs in the low-level code, and
then the question becomes moot anyway. But if time proves me wrong I'll
think a bit more about potential solutions.

Patrick
