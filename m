Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A470830
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901981; cv=none; b=t48Hj2VyEnFVivPGJRydHmV11UaChGfODW8tKSmAxWdlH5q3T53HZS3U+QxXoH/OprJzQEW6W7dEexoDzZZxz99C06Fqecvkn30jNI9UCRTuGnwJn6da5vr+Yp+YmCXPJab6cXWulsrm60hXBZvsA3oxBrpuO6AttIS7I8KYgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901981; c=relaxed/simple;
	bh=TA0a5sKug0M2E3j3uE6rLwcyKY/D/YV/RKRQP8eSHDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnSK4DQX37phZBBak8dGiCOSBAa+QWbEQ8YLl7dPJJkm4CTmeC7mmIutVG3Pn+63WfgOL0IrUKU1ItLxnmW0vpnBpCawo9+2rZ0fxIMJyNMjVKK5wKoDxZqxohE68ls6kc/hp7ZWfdFhMF74ryXPt82GLrmrUcvD38L/iiV7R1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZiCmDCDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WuD+35lX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZiCmDCDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WuD+35lX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 65228EC0089;
	Mon, 11 Aug 2025 04:46:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 04:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754901978; x=1754988378; bh=Yj6aWNfSit
	5Z85g4Ig2z24LirFhAwRQV0KK/v9EFAh4=; b=ZiCmDCDxWWzj1Ilg7hT49ym6r+
	451pBIAWsVOKMbwS8VAH+ROJYMOkYsfoCWV7wDjoUFl7M6906QAVqU7uIZKBsXj1
	Te9WPv+cW/1Sjeq193KrTvu9OUutR9qVA3DZVqXavkBw/5LLVemxfvBxhuLo5Rpw
	f+K9LOTa8SSpvtq28v3+AzUlOHhj43LqSo51dkreJO9dKpfQ0fckfjtHcmRipsac
	Z1/m0zVS4e27U933JhzjLbW9P4yrUoGmbRsXA+9SAltLNa2nIr0BPrq3iu7h3MiS
	OTGREIYXo9MCESFZXRBrDaOoD8mGsjFlfzDvYd9r9pgm48KPPQ2EfEypXXhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754901978; x=1754988378; bh=Yj6aWNfSit5Z85g4Ig2z24LirFhAwRQV0KK
	/v9EFAh4=; b=WuD+35lXYbRKDuNBxdUBXIcnqJxfDmvK5aRI7X1rLwaEdZl5Asp
	hrSCU/5fsaKSXH1AKZy1pmWtPz84p+WOAFa6Tnjw41w7e3RMKN2CjtfcOkfnqzIs
	0kWwLrog35OXY2fRF/J4233zWqIPC8LoWCypSiVDk1P7InY0EzIPJOyi/qE7oMKf
	QGA4L8gpKOUwLvQ2H0H4dD2V/lEnQ5in7N+RRqHfNssQcvzHRC1ZHqQ7UkmELV/A
	X7XEkO8Bkgab281T7RA2qZa8Nxz71RiD6fxT4285Z8CnLHSDfvOZTNnHLhNwcKkD
	pk4Tw06AqTKL/y2OgHSsPAYhcS6s0GWzMkg==
X-ME-Sender: <xms:2q2ZaA3gJAVjPASf680CmpghR_8nzagHVbBhsFDptmQLZ1MV2E-FWw>
    <xme:2q2ZaOUbeVh2IzWwnp3mOawor0cMKXijBmaFW6-H6NK1ne9VI3tKqjX_-Q89jNrNG
    01I5oEtZ-SV6pvdgA>
X-ME-Received: <xmr:2q2ZaCUih7BFqo-ugO3MDYhcSRjG2btZGl7JylsSbmXfIAAEz4DrVLMO8B1uXI3cqkOU1LAMEh7ye-vR7SifB5hMg8u_uHGLuLuR0dRFIN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdr
    tggr
X-ME-Proxy: <xmx:2q2ZaFdDtIzqoDtgFsY0YX7G1KN8xvdyFez-hN3xmOdEz6XO-3aPww>
    <xmx:2q2ZaDVXBm7KLxAK5eS_EvsPmeUx7q3Q5gmVWCIASoleJ06fSWUgYg>
    <xmx:2q2ZaGfJu1PRz_FbbDb5CMtkybk0gvi-ZMlN0xo40n5Clj9TVSO7AA>
    <xmx:2q2ZaHMLCr5QlRdkT2CcOeDljBBTK7z3KLrrBJRdtDQakVT3VjYZ1Q>
    <xmx:2q2ZaK-ALBzGjw6cMcMvz3xGYVP5STLIVFlL9_2R_44u7a_ca7HqdpKt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 04:46:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0c0bd64 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 08:46:16 +0000 (UTC)
Date: Mon, 11 Aug 2025 10:46:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 5/5] doc: git-rebase: update discussion of internals
Message-ID: <aJmt1fv66bO_ZMpI@pks.im>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>

On Sat, Aug 09, 2025 at 01:14:17AM +0000, Julia Evans via GitGitGadget wrote:
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 50c84f138212..c16ee37b46a7 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -65,31 +65,31 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
>  assumed.  If you are currently not on any branch or if the current
>  branch does not have a configured upstream, the rebase will abort.
>  
> -All changes made by commits in the current branch but that are not
> -in `<upstream>` are saved to a temporary area.  This is the same set
> -of commits that would be shown by `git log <upstream>..HEAD`; or by
> -`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
> -description on `--fork-point` below); or by `git log HEAD`, if the
> -`--root` option is specified.
> -
> -The current branch is reset to `<upstream>` or `<newbase>` if the
> -`--onto` option was supplied.  This has the exact same effect as
> -`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
> -to point at the tip of the branch before the reset.
> +Here is a more detailed description of what `git rebase <upstream>` does:
> +
> +First, it makes a list of all commits in the current branch that are not in
> +`<upstream>`. This is the same set of commits that would be shown by `git log
> +<upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
> +list of commits is constructed.
> +
> +Then it checks out `<upstream>` (or `<newbase>` if the `--onto` option was
> +supplied) with the equivalent of `git switch --detach <upstream>`.
> +
> +Then it replays the commits, one by one, in order. This is similar to running
> +`git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
> +are handled.
> +
> +Finally, it updates your branch to point to the final commit with the equivalent
> +of `git switch -C <branch>`.

Would it make sense to convert this into a bulleted list to further
highlight this multi-step process?

>  [NOTE]
> +`ORIG_HEAD` is set to point at the tip of the branch before the rebase.
>  `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
>  at the end of the rebase if other commands that write that pseudo-ref
>  (e.g. `git reset`) are used during the rebase. The previous branch tip,
>  however, is accessible using the reflog of the current branch
>  (i.e. `@{1}`, see linkgit:gitrevisions[7]).

This information feels somewhat contradictory. Should we maybe say
something like this:

    When starting the rebase, `ORIG_HEAD` is set to point to at the tip
    of the to-be-rebased branch. As `ORIG_HEAD` may be modified by
    various operations during the rebase, it is not guaranteed to still
    point to this branch at the end of the rebase. The previous branch
    tip, however, is accessible using the reflog of the current branch
    (i.e. `@{1}`, see linkgit:gitrevisions[7]).

Note that I'm also dropping the reference to "pseudo-ref". ORIG_HEAD is
not a pseudo-ref, as we have clarified in 6fd8037564
(Documentation/glossary: redefine pseudorefs as special refs,
2024-05-15).

Patrick
