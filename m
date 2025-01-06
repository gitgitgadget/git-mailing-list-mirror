Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A9522A
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736146116; cv=none; b=jh4JyH6S16FE0olY4/OL2Z39Jwr/pI00yWY4MmMsKTNW+Pl7VjCITTut12m2sujo0TsK9DovnHW2x5O/Rl2nrj2yGpMYk7aH97CaeyjZV21hLFwUVQ18okUBPclBQLAsZd3H3N+ExGqcxkBEWzDivIi/XGaL6ovDYomZ9b6CAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736146116; c=relaxed/simple;
	bh=9DWDJXtXhTBzKdLmMTwdVmelX0Q40eYfYvolzxfiecA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0jDWFqbiWRha+VZZe7IRIhyO1GztmfRQZqyA2pvvtklB846NUl+ZjNm9eXTVfm2jqMFvZgjzf+M8+Asszzk334pE0eYaDBAhjTOSt7U7kX7bShzkm7NB3ciux43JSWZteRHx41dxNwgpsD5sFWX1/dD7rB0MNL1L+vrwRocgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oYFvbH1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s82G/nYn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oYFvbH1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s82G/nYn"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A788211405D9;
	Mon,  6 Jan 2025 01:48:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 06 Jan 2025 01:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736146112;
	 x=1736232512; bh=N9x1dUnNpeflQVxdYcNdoCfQwUnX6mZktyBRmH/cX9A=; b=
	oYFvbH1GnPHBHj3tB5bt3CABG5Hr7SPVVe0hxHbj0NfgNnVsCNC5MELNCSEMk1Nf
	03x4IT2YIG22cLc+oGoDYdSwgwILHCMhTugYyhiNTJ4Z5yFdgEyn4kyIpn6dlSX5
	Zc78IgerIkqgYC50dSO/dbIiDdCX62fsNjeAeVA2QPMRtBIBgHHHYInY6ZNGr94J
	c55vmrrSJ1+/y+u7IuM8ZWpNfH9fAK+g0PBslINNM7ZToiV0i6IMg+UkHoJXryda
	15nBbvIKR5Z4UrLjsoqG2Q6Cowp1O5tYQGZTLZAjRFixiFV19xdt8/5Yya6BUSpy
	0duqH1O6fVnWwGcz9KMFig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736146112; x=
	1736232512; bh=N9x1dUnNpeflQVxdYcNdoCfQwUnX6mZktyBRmH/cX9A=; b=s
	82G/nYnnpbGrVN1txg9BrOTHxNQPrmYIWDg1nd6j4X5bUxVzVtI8sYUnjRy8qjI7
	USuIsSeekrKlTEAotwzM1Np6R2RG6GFoN7gR6UIRbG5ynhkVfcj6zeFCKRX3/Cbg
	t7tvIJtC09jlC3L0WFcUHuRoeGLUoaESYQ2Ng+IcW1zFFHSRihAkktRoGwo3oT8P
	YXBIN0wLRjybJyCOCx3ArGZ3Z1l7a8cVHZvyU86UuOf3/k7xdUNkzQBmGuGsaAOY
	P7yvCuEXJH3SgQpubd943KY2lFfFWuMrgVSXQY4FCPtbhdQYVVCT4VPzI0QP/hra
	XdC9yWM/40bZfvt6oMLNA==
X-ME-Sender: <xms:wHx7Z2VXL3cXuyf9cmgH6U9wVQDwznm1qnRRivKBIc1DGCVEOJDb8w>
    <xme:wHx7ZykQv7YM6w1OBeSuFIXu2gdbBw2kim6bNOW1tOSGSXn9-hde8gcw_sj5-_w2S
    ZOW5zrvT1VTUDGREg>
X-ME-Received: <xmr:wHx7Z6YPC-PmOTRX3MBh5-_CQwtNc7oExOJejH7ERpKjQ80-LZ2YxKoMXaov56eH56GBPDV9ar02lycq-PFw_7BqERB2JUmHovsDYNwLFFwdoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:wHx7Z9U5sEGAfaFzkMb5sS3HNl46cs369pcdy-PPj-KTTz0b3nqKLQ>
    <xmx:wHx7ZwnCnY6BSCpjVdupoCRDYXjv6F-ay2xHfVUcXxROQoZy0vQgtA>
    <xmx:wHx7ZydQsqQ4DaqOHsIiX9Dah6uMlDEe7RO--rB3t6AMEQXl2IbRsw>
    <xmx:wHx7ZyG8gHzglwJSGC_d1SHiZ7SnOpgrOlyAzvbe-aER4RLsKysw2A>
    <xmx:wHx7Z6jzD69FIo8taRAn23xjUzxrM1vnmo_dECBlBGqeFuml8Bn1zRPv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 01:48:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c7858d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 06:48:28 +0000 (UTC)
Date: Mon, 6 Jan 2025 07:48:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: git-restore: migrate to new style format
Message-ID: <Z3t8sjsCeiPmHffA@pks.im>
References: <pull.1847.git.1735996601092.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1847.git.1735996601092.gitgitgadget@gmail.com>

On Sat, Jan 04, 2025 at 01:16:40PM +0000, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> The git-restore manpage was converted to the new documentation
> format:

Commit messages should typically use imperative style, as if asking the
code to change. For example:

  Convert the git-restore(1) man page to our new documentation format.
  This includes the following conversions:

    - Switch the synopsis to a 'synopsis' block, which will
      automatically format placeholders in italics and keywords in
      monospace.

    - Use `_<placeholder>_` instead of `<placeholder>` in the
      description.

    - Use backticks for keywords and more complex option descriptions.
      The new rendering engine will apply synopsis rules to these spans.

> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
> index 975825b44aa..541a39b5d28 100644
> --- a/Documentation/git-restore.txt
> +++ b/Documentation/git-restore.txt
> @@ -41,79 +41,79 @@ OPTIONS
>  If not specified, the contents are restored from `HEAD` if `--staged` is
>  given, otherwise from the index.
>  +
> -As a special case, you may use `"A...B"` as a shortcut for the
> -merge base of `A` and `B` if there is exactly one merge base. You can
> -leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
> +As a special case, you may use `"<refA>...<refB>"` as a shortcut for the
> +merge base of _<refA>_ and _<refB>_ if there is exactly one merge base. You can
> +leave out at most one of _<refA>__ and _<refB>_, in which case it defaults to `HEAD`.

This change is a bit surprising to me though. Why was this renamed from
A and B to refA and refB, respectively? It should be possible for these
to be object IDs and not refs.

> @@ -122,30 +122,29 @@ in linkgit:git-checkout[1] for details.
>  	not be updated. Just like linkgit:git-checkout[1], this will detach
>  	`HEAD` of the submodule.
>  
> ---overlay::
> ---no-overlay::
> -	In overlay mode, the command never removes files when
> -	restoring. In no-overlay mode, tracked files that do not
> -	appear in the `--source` tree are removed, to make them match
> -	`<tree>` exactly. The default is no-overlay mode.
> -
> ---pathspec-from-file=<file>::
> -	Pathspec is passed in `<file>` instead of commandline args. If
> -	`<file>` is exactly `-` then standard input is used. Pathspec
> -	elements are separated by LF or CR/LF. Pathspec elements can be
> +`--overlay`::
> +`--no-overlay`::
> +	In overlay mode, never remove files when restoring. In no-overlay mode,
> +	remove tracked files that do not appear in the `--source` tree, to make
> +	them match _<tree>_ exactly. The default is no-overlay mode.
> +
> +`--pathspec-from-file=<file>`::
> +	Pathspec is passed in _<file>_ instead of commandline args. If
> +	_<file>_ is exactly `-` then standard input is used. Pathspec
> +	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be

The reflowing of these paragraphs makes it a bit hard to see what
exactly is changing.

Thanks!

Patrick
