Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459902DF68
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366419; cv=none; b=CNKQvtattUkwu4JIE2xE+lUOfif2nmmjqGvPAcYvncqZGqKqXjIcTApRipD7fj96Fsu7k9nZu7WEBe+cdQSVCHsNeHik4Dt5l+PuUOuC5nSHOXgDe2cx6ISQSYws0bmXA4f+rLY4m8I/wWsrx4uOaJvXAyBR/qSOcIIv4g+XnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366419; c=relaxed/simple;
	bh=khPW3zi3tG0Sz5Fe9rMnp6FsFz+wVlXXMI+ytnSLZ04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N1pVL2szvjKAUAkcYVlBZeZdCXAFB5fx9WU26HG2xnllb2r1xWb0hEnUfo8cXNP2+kNcQ14rS+RaVT6HyWd8s0dOF7JJz/G0WC0ZJqJp0S4C2KlCHvXx9Aj6b75eDmy2QiMxqsMmGlyQZXxdvPHjX0Mc71pRn1mgCl7EhwN1NDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HlmSXvIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWxH7KDo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HlmSXvIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWxH7KDo"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B9B9138273B;
	Fri,  7 Mar 2025 11:53:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-13.internal (MEProxy); Fri, 07 Mar 2025 11:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741366416; x=1741452816; bh=t2h5QBFQsF
	cBehW+fE1XLWhWwCxCRzz9s6RZ9ujoFt0=; b=HlmSXvIgOJTVsYtfO+7BzIGAa5
	BWan5D4h+OL7Dz/BhJAxoEPeiciPbm7+M2waL6x9KXVKCxWJ0AePrYCXNmJ7zV+7
	rAyARVrNJ7jlhcI20DCPPdpc9tCyHtaXUhmt9CdQQ8Ej8RWx4BT0Gqscu+EuXn8u
	MmEBHuWt2v2mrCNKRIdkugenb3ReyD4+B6bbGUh7gZK8KqHdQmnnaDZQI6DRDCJF
	StvvUxkGtHTtTSVBETjuQu8RfAHmw0qOpLJhA8sFYOf6GFD8oHYt35HR3l34KweG
	eUnsn+CWG/mblBys4NmUrG3HK31KeFXfhjx70DcAOPCU8meTvwYJdo2yR0Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741366416; x=1741452816; bh=t2h5QBFQsFcBehW+fE1XLWhWwCxCRzz9s6R
	Z9ujoFt0=; b=JWxH7KDolV09YP9K06+bHlWjbGBAH0OGkHXYhgT5yHqfxF3OJSf
	TPB6/hZdEH3VIcrNKNzWgeTZGRO5+tqZqYfXQ3FaMx7RVk5FZSuCWpsXxnpqJH36
	FsMj5OUoKlJrRX+QhcPqe6/i6h6VsvcPpARx/OderzVUw6LORCyqyp/vIOnE5XHe
	r9rhORinSkxi5nACWKAI9NifrTJFDN8vALx/oK7zAosi2wsexeRmTy1j+FXHnzZC
	LtV7AvnfXbm/lsGZ+BjIwQpzWJhET0e3Xf59aD4KUwUIFp9in9OHxDjbm1dXdqYB
	MuTNX2J5Hf5QkVoQy9uHyS23zXVWzwpDRKQ==
X-ME-Sender: <xms:jyTLZ340PhTP6tpfmACtETAHliDOdxu22O3x1j8zB2XEFIPB-u6cwA>
    <xme:jyTLZ86pw3FFNZhPD_J6-ZZFgRw7LrP_kMfr33TEHyOLRhHyjVSIjcv89OqkRiWvH
    HYyf2UCtdMAjcjkSw>
X-ME-Received: <xmr:jyTLZ-e4JmAL-waOQHd9TaBD0kRBx2hOjRSvEMihKQXgNc13HjW7nzLTmb0Pcq_iKrERkkaIcfPZdVPHLsK4xu6svDmftjlwfPDJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgs
    lhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:jyTLZ4Kwc8Z2HuwJ_fnK8jls28iYc_mieJCjla1F5xIoTB8BI8IsnA>
    <xmx:jyTLZ7K38h9lNhJuNiERMzP29ebXf-nozAP_IwVMXRyURsO88Q0H6w>
    <xmx:jyTLZxy_YOAQ-O0vkk_14NR3eWYFQCb4zO7vflfjNHEjIfVsGxX7-A>
    <xmx:jyTLZ3IYUl15W7SUBEblR1PFvgh26VJnzcg9mm7k2dZcdKnWpLIqEg>
    <xmx:kCTLZz-1uVRTm4VZ86lTYkPGWusjYR2Ts2lxUEIxFlH2kczldLi0_ksC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 11:53:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v2 12/12] hash: stop depending on `the_repository` in
 `null_oid()`
In-Reply-To: <Z8q3nzhl3DHETZgf@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Mar 2025 10:08:47 +0100")
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
	<20250306-b4-pks-objects-without-the-repository-v2-12-f3465327be69@pks.im>
	<xmqqr03ageej.fsf@gitster.g> <Z8q3nzhl3DHETZgf@pks.im>
Date: Fri, 07 Mar 2025 08:53:33 -0800
Message-ID: <xmqqbjucg4tu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So in theory, I don't really think there is anything that keeps us from
> mixing object formats, and I even think that this is a necessary feature
> to have once people start to migrate their repositories to SHA256. There
> are people out there who use submodules, and it may not be feasible for
> them to wait until all of their submodules have been converted to SHA256
> to migrate their own repositories.
> ...
> Anyway, that was a bit of a tangent to your initial question: which hash
> should we be passing in the first place? As it turns out, we should be
> passing the superproject's null OID indeed. The object ID we pass to
> `repo_submodule_init()` does not describe any object in the submodule
> itself, but rather indicates which tree-ish the submodule information
> should be parsed from in the superproject. As such, it refers to an
> object in the superproject itself and should thus use its object hash.

Good reasoning.

So the null-object suitable for the superproject is what we want
there after all.  We've been using the_hash_algo, which is the
algorithm used in the_repository, which in turn *IS* the
superproject in this code path, so we have been correct all the time
;-)

