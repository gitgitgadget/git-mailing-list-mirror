Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263B8310762
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509509; cv=none; b=ZVHj2EQNY4rZD9Qc0TuZlT23CeGm/bEz9g/ufhiitzxLM6wXyL1tVkEBcoYO92FGhXnnwG3KMzdP4NazNrwuDBMarY0D+gBy6I/z5C+fEoNkh0x8IWYJ2uORSYRwK2PyFZ9l+8wDsPnmXQexmREi3KGMob5PGYIzlrv1sG9SvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509509; c=relaxed/simple;
	bh=VDz3z0IbOnf18QjikJVRATHPVbZOgFL/+Mo8jh0Se28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF1psAcUpNMAqb4T1SRI9y2RO0q12bddCqiFLOHqhh+p1kLx9V9orv0H/eCX8fHyCs55gfuGLpgQclJEdS53OvUsKYvwjdmPMZ9bcWVGV0VrI55dSXDwCjYVy4anUgb33dg/7n8Me3p5SCLdJMl64mTJ7O3sak8JKaqug+/F6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eEH74lqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/xAZUgZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eEH74lqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/xAZUgZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74E217A0158;
	Wed, 15 Oct 2025 02:25:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 15 Oct 2025 02:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760509501; x=1760595901; bh=bYdDxLhfjT
	Tgv30Kx2iNY9oUaprkqttgzngO/qXUPLA=; b=eEH74lqvH8Oc4lvACgmHPsqvpI
	RvSfcOYBJi280AV70k9pFr2zPvsZE9gbzDypgk9f1r/W2h6ymO13wcirnL+q0h3s
	qQ+ESnYBOg9WFqul6A7e+4MvNpTRM1vVbsThl8XxvOYP6RcqHKhExTjImorSiU0A
	MzeZUghORIktHYhUSSEcbdAOf41iiu5HoW/cE22QLetqDgNW+EoX6qltddKOkFiN
	biXrstt+0bEA5CwUjMsMeU2Nm+WeBjdFe4Llxz/z3wgYqqrvLWek28wM+wkeAkR7
	YxHy13WTrgYJEYYXi8S8YeZwyds6n3GZYd2ty+zc19rfE0NBtUwooynZYOHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760509501; x=1760595901; bh=bYdDxLhfjTTgv30Kx2iNY9oUaprkqttgzng
	O/qXUPLA=; b=c/xAZUgZhq3rj1ZTY2bCAQNEDfSgfEKgcfq+oe0P5JNU/+O8gL0
	UTW3fcrbJO0uOejxtEdCHxgyjGsvamHl0Htw3LYhs1MuJOesA/swB5yigJ1sE/qM
	oVwGQEqJrtKgfZ8lL76fY3XpmyMd55qP1QHcmJUJjh/hbe6FEFdc03ZFmEEYdxW2
	ykoMagY9siu0+80ZtHmdbIb1j40AjlckEGM33WcBzC3Wtut1B9ExyiEug5/Or9Jr
	N2tniF++jjGenR7wqYTplljeg2yDeK8CSzMT7rVTVsYN4dHFTNt2ngXgD3qADlJ8
	2bY+znzKByv9dnlsxOrrsJpw1404pqgRGMw==
X-ME-Sender: <xms:PT7vaOcnjYhs4Mrp5LpxqrrOmcAPqkziodwEDYEacDPd9DMZGX8TMQ>
    <xme:PT7vaPFtFCyzQAWSOKhSF5ucP0DFtdxuUPGVrTZ_U8qpFAPixI51K1CkuGxZ-MPae
    mWz3mqYhNesn6XAmQvSviLC_v6P03oBRSSUCdSgzpCDKAvHrMQD>
X-ME-Received: <xmr:PT7vaH3otxpiQ8I3OfJqSfV7MpczQ4cKQEBCioxpu1bcImj0M2k_miMqRSOOHR4XVn3ncc8FBnEgKlq-cQYe05sLXm34r23gfpgyN5QRN41v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirg
    esjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PT7vaHl1C9rtUnIjmBHrgUljCriAd5a6-iQK4UDxeLXPDCH_PWUmuw>
    <xmx:PT7vaH93DZEmDXaRXyrZGjqObNMN6shagKhz5ftxKoOLQ2S_7XzHTQ>
    <xmx:PT7vaMpUKCvyigBRPHb-GtFYaC1ds8jJRssTkwdLyelWqQ39xhIg8w>
    <xmx:PT7vaAneykhncMgsHs41Ekj-bqoEQXkLGXHMs8EMiij39NaYTxJd9g>
    <xmx:PT7vaO0I7RYh_h7e-xLqtWljgFZVKdJo6KxBwcbc7OyiA5_5zp08DxTP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 02:25:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 848d0b1b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 15 Oct 2025 06:24:58 +0000 (UTC)
Date: Wed, 15 Oct 2025 08:24:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
Message-ID: <aO8-NtJPNBAM2tVn@pks.im>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>

On Tue, Oct 14, 2025 at 09:12:26PM +0000, Julia Evans via GitGitGadget wrote:
[snip]
> +[[commit]]
> +commits::
> +    A commit contains these required fields
> +    (though there are other optional fields):
> ++
> +1. All the *files* in the commit, stored as the *<<tree,tree>>* ID of
> +   the commit's base directory.
> +2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
> +  regular commits have 1 parent, merge commits have 2 or more parents
> +3. An *author* and the time the commit was authored
> +4. A *committer* and the time the commit was committed.
> +   If you cherry-pick (linkgit:git-cherry-pick[1]) someone else's commit,
> +   then they will be the author and you'll be the committer.
> +5. A *commit message*
> ++
> +Here's how an example commit is stored:
> ++
> +----
> +tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
> +parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
> +author Maya <maya@example.com> 1759173425 -0400
> +committer Maya <maya@example.com> 1759173425 -0400
> +
> +Add README
> +----
> ++
> +Like all other objects, commits can never be changed after they're created.
> +For example, "amending" a commit with `git commit --amend` creates a new
> +commit with the same parent.

Let's say "parents" instead of "parent" here so that it also works for
root and merge commits.

[snip]
> +[[other-refs]]
> +Other references::
> +    Git tools may create references anywhere under `refs/`.
> +    For example, linkgit:git-stash[1], linkgit:git-bisect[1],
> +    and linkgit:git-notes[1] all create their own references
> +    in `refs/stash`, `refs/bisect`, etc.
> +    Third-party Git tools may also create their own references.
> ++
> +Git may also create references other than `HEAD` at the base of the
> +hierarchy, like `ORIG_HEAD`.
> ++
> +NOTE: By default, Git references are stored as files in the `.git` directory.
> +For example, the branch `main` is stored in `.git/refs/heads/main`.
> +This means that you can't have branches named both `maya` and `maya/some-task`,
> +because there can't be a file and a directory with the same name.

Hm. I think mentioning this can help, but it may also creates questions
when someone has a "main" branch but is unable find it in
".git/refs/heads/main" because it has either been packed, or because the
repository uses reftables.

I don't really know what to do about this. I think the most sensible
thing would be to introduce two man pages gitformat-reffiles(5) and
gitformat-reftables(5) that we can reference here for further reading.

[snip]
> +[[reflogs]]
> +REFLOGS
> +-------
> +
> +Git stores a history called a "reflog" for every branch, remote-tracking

I think it's a bit unclear what "history" means here. Maybe:

    Git stores a "reflog" for every branch, remote-tracking branch and
    "HEAD" that contains the annotated history of all updates for a
    particular reference. This means...

Other than those handful of comments I'm happy with the current version,
thanks!

Patrick
