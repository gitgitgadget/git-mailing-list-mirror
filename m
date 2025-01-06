Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F31E511
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736149106; cv=none; b=IU+6bQCJRlocbhrVkw60czTDoGS8AD509V4kSEumTRCM+rwK9rAiR1EohpxjCMTGuPULOeVVNL0nyNPiV6+PlfLu64ABmKog34C8PF8R4BNNNUXJJt5QMv+MJUkUUg+e4MZ4936mpj9+PNZn5IYw5wA6/bOi8u+WTfifpIvaS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736149106; c=relaxed/simple;
	bh=lm+KOtUaI5ibwXsJXVG5StGS8yvUjuifUSGWZWCcwSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtYcjgIRJcTI00guer2uZwWdQRtBkrhIvh2tZyY6dxf8CGF0U0xTm2EWAe87jjiAKYbOWIYkJEX28Dxk1+AV043+SWTfEKzRQSATXtfCLrKlj1oGegYqzZLXjv94BoiC75E2ySb80neZISFOqJQrR5vTlv0eyoyWPfJtzJVmGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZKwasmql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jvcIWKeW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZKwasmql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jvcIWKeW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 208581380949;
	Mon,  6 Jan 2025 02:38:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 06 Jan 2025 02:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736149103;
	 x=1736235503; bh=zR+0FhdSgNlytVF4B5Y1EcdifxWWznlm3Qn/FYiC6O4=; b=
	ZKwasmqlL4kP4RGdqv/HkZAKBdrTXKDssHhkjUC1NNZw/0P828tI4CE2P3SKWgvn
	p0OiTtfecHq/sG+xgN90aY39iLSrh4LP/E9uYnTdIAOAKHG6C26QTsVUFsClH2H+
	qxO+kkCbjBDo43eY0HN7gsmBqJ4gIVIJS7ckHzUNwXZMu0tX0M0LFySr2gJFoE2o
	Zwxju1rn2KPS79ip9dfnRQfpicfvqrEBREzFPYyX1zHVDhDm5L18NZJ88g0H2m3+
	XTt6m7klF6QerQr0klA6TJJjNwRgtaR9E8RWUQTFxZYPF+O+aLlkYneXIMGIS6oO
	Eahq/ZHRjMDKVEgkVQiNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736149103; x=
	1736235503; bh=zR+0FhdSgNlytVF4B5Y1EcdifxWWznlm3Qn/FYiC6O4=; b=j
	vcIWKeW53eBelc6fYy3/GsXMZEj30X2LKk5sra9ptJHOWN3dF5SnkhhLUpHiizUQ
	yo4c4niE7jR2zS++1Lc7FTpJXdaiOW0RRp4ZyypY2SN4O2bpt2xA5KF1K5M+ufBC
	t4htOvFun6mp0z6/aINdGBZkXs1FHhcIkW2ELWww70u2FrIOHEJzn0CK0ea01fxQ
	d2OLESp2tXQ3PJ+P0DROinIFt3SbZ7a53wPSMPOwh+wJ+N/g6aYxB89eR/E2zhXD
	sUbtkEQASGMKMX6lVTYUqQrNvgvkl9h+G27Ji6L53a5HtAmRrvhqnlT6VcJEIRhK
	LbJXOWRmaG2rb2P1HLrlw==
X-ME-Sender: <xms:boh7Zx2nvbtaqKvKY10RN7AVTYqaMZdGk784kJoLKgMs_9AFBgFcvA>
    <xme:boh7Z4FRltDpyaA7lHnXQEIR4q5SCS6_fRACXImz1FHKBIeuUclp5pcDBUvRoaWb7
    uEPHbYje-wbIeTjXA>
X-ME-Received: <xmr:boh7Zx7yhtW9WZHxECBFt_qPLPlqIME9_DM4pxcLLnINzkjmIhjMwoxBOFtdV13cVUULQjlrIC5s_uV-ylaliLqliZtNF48mHXsnfgVaPmTPZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:b4h7Z-12h6SlwMo2-74fM8jqxSzFT-mnaQdAO4rWd4GUlmEmLtvJog>
    <xmx:b4h7Z0FVRiecb30htnKf0j0je2hrSFKzp41RYfqm7UO0KoWeO0Io2g>
    <xmx:b4h7Z_9OXWDgtu_t6CVDIA4gxc-RwXHSAy2OykfTpidjvlrBogr6Qg>
    <xmx:b4h7ZxlOZURwrd9nC4f4OKxW4kSUV0yQ24kp_P5e1SMaOVk3Mlg6_g>
    <xmx:b4h7Z4D1mhFUbPys3Ys-VBtJPpCB3z2IdMI8tPVMdEdAwM7dG0ldnK0U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:38:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 099836e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:38:20 +0000 (UTC)
Date: Mon, 6 Jan 2025 08:38:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 1/3] doc: git-commit: apply new documentation guidelines
Message-ID: <Z3uIZA0bIXzaUxlH@pks.im>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
 <dfd907fc3147b438222bbfad9b0a7ca61df642a5.1735912046.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfd907fc3147b438222bbfad9b0a7ca61df642a5.1735912046.git.gitgitgadget@gmail.com>

On Fri, Jan 03, 2025 at 01:47:24PM +0000, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> The documentation for git-commit has been updated to follow the new
> documentation guidelines. The following changes have been applied to
> the series of patches:
> 
> - switching the synopsis to a synopsis block which will automatically
>   format placeholders in italics and keywords in monospace
> - use _<placeholder>_ instead of <placeholder> in the description
> - use `backticks for keywords and more complex option
> descriptions`. The new rendering engine will apply synopsis rules to
> these spans.
> 
> Additionally, some option descriptions have been turned into
> imperative mood to make them more consistent with the rest of the
> documentation.

Same comment here regarding the commit message as on the other two
series. We should use imperative mood for it, as well :)

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index c822113c111..b08a398e31d 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -58,139 +58,139 @@ summary of what is included by any of the above for the next
> --z::
> ---null::
> +`-z`::
> +`--null`::
>  	When showing `short` or `porcelain` status output, print the
> -	filename verbatim and terminate the entries with NUL, instead of LF.
> +	filename verbatim and terminate the entries with _NUL_, instead of _LF_.
>  	If no format is given, implies the `--porcelain` output format.
>  	Without the `-z` option, filenames with "unusual" characters are
>  	quoted as explained for the configuration variable `core.quotePath`
>  	(see linkgit:git-config[1]).
>  
> --F <file>::
> ---file=<file>::
> -	Take the commit message from the given file.  Use '-' to
> +`-F <file>`::
> +`--file=<file>`::
> +	Take the commit message from _<file>_.  Use `-` to

I think it would make sense to move changes like this, where the actual
wording changes, into a separate commit. That'd make it way easier to
spot the non-mechanical changes from those that may require some
discussion.

> @@ -257,19 +256,18 @@ default::
>  The default can be changed by the `commit.cleanup` configuration
>  variable (see linkgit:git-config[1]).
>  
> --e::
> ---edit::
> -	The message taken from file with `-F`, command line with
> -	`-m`, and from commit object with `-C` are usually used as
> -	the commit log message unmodified. This option lets you
> -	further edit the message taken from these sources.
> +`-e`::
> +`--edit`::
> +	Let the user further edit the message taken from  file

There's a double space here. I was also wondering whether this should
say _<file>_ here to further clarify that this refers to the same
placeholder as the placeholder in `-F`. Might be confusing though, I
dunno.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index ef5e622c077..a7315ed67cc 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -44,7 +44,7 @@
>  #include "trailer.h"
>  
>  static const char * const builtin_commit_usage[] = {
> -	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
> +	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]\n"
>  	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
>  	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
>  	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"

I guess this change is required to make t0450 happy?

Patrick
