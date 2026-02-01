Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577052F12AE
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769947908; cv=none; b=JsyHcuXddEDA6LG+Iid0yA80v/u7EYlyXTBLL5CwJN3Pa72XpDhG83yVVdZ/1M2v4fejYfJ3lBBoamS9H1Iks+4TAV3VT+QbfKJRciMHwJkcj9W48tjn3B1v8Vc0hllF/vtDPzzsuAH98dwu/iB4v0JpeqqUuFHRX37FdR5hCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769947908; c=relaxed/simple;
	bh=Nz78e43KJil7NXjKbJTpDMe/5JngU+HTc6Drcpw80M4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CD6ewwiLgPaXMjwzfCKRYorNL4QGm1LXQkuYbYYs3qs9fdSR2uEGZoa7bzq0hlhbRyIRptNVl9rUqZNRmDuck60FzUN5cHlZCr2aDFabZOjpZx3HdgRmgw1XGbDV/j9JOXb8/NqKZVlxt6Rle9ZNt6gKRbQuc7bRLdtqehQ6oiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=R16BPapp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FM+BVTdH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="R16BPapp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FM+BVTdH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F14D140005C;
	Sun,  1 Feb 2026 07:11:46 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 01 Feb 2026 07:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769947906;
	 x=1770034306; bh=ifraLszlMhNp9P6MG0wblyfLJXwblhUyjoWg/k7C1qc=; b=
	R16BPappWWBuaSozpub/zadk8HhgHCyoSt9WODZqU1BOK1Dr7sfFbdDPGduXGA8W
	gMprEMmEJC/fceLvpuib/hsG87lHY4SUnlRZdHJNV96DscmGsJBZA1FGOWSS1QKe
	l7srXqCPHQmKJppY/y4bxJbxm6Mv99aD8oikA7jR/4jtgGr9ilOz3XEUfJP77loI
	uMp7nevUlgeaLwMq1aXt0hXW7kvCWeJOai4sW1y3nEmTBoo+ByqVKXcdqS4+uRzP
	eA3wFlkIAgZTBDdgxSRC1ktISpYo+wXBaibQoCeTdpL1NSXV9oAKvWz918WWXSat
	c+JVbhJd1Q69OYKAMT4sdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769947906; x=
	1770034306; bh=ifraLszlMhNp9P6MG0wblyfLJXwblhUyjoWg/k7C1qc=; b=F
	M+BVTdHZevDw/2A2ky8m1WSPOGVVAQRfZPAzqiYrYFr+btXeke38/cRLYEhZMMuV
	NKFf89uMHNG9o+6zG864BIwD2Jr+G8SCZ3Y4AHJrmC1aVWSX/FbWYexFGKE+c/tc
	rZ33ktv2PIKBfGmXI1AYwqgEPF3KF4b6MQXNHe02UAUP9N+pUZENafz8G6CwCYxn
	ZhcbN95U3Q8MpDFAyUNCL4cQwGxaie/4DCMOGyBYvr4Gf16ZSQ687m957qTtNLBT
	wiuLNPkLPqopPwHau1o5wR3fGTkC+v75/r3VSBmBZ7SjF92KVtr4pfkn/pydpDTO
	7m+Qyn19lte6ZFmvdM6Hg==
X-ME-Sender: <xms:AkN_acdaZwT0KLn9jKPMJyWj_DxUo1MRJvkQI5hGmq5wlEhCniefdsg>
    <xme:AkN_aZBEk9gOve8ElTghXHdiJjgz3IW8M1sMMEObc-XVWlLEWBKHVVYS6Af1DJtKB
    vLk_rwwU0Mt_H99fkBlkkNp0fqwAHxrdUwgwtKj5NmrUm6o_X2p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AkN_aabLbg6J-1fpNi2CClK9olje6aGc911nlwj_GV0RvUHowKaVYg>
    <xmx:AkN_aVJd9knBCR8eiixP16aY4oejHAHFjfHe5_aAZns1E36Ga7bbCA>
    <xmx:AkN_aYDjtmO71ZGWsSaVL4KHkdMOvtdDZ9STjqoZQ-33doGh90r0xw>
    <xmx:AkN_aape1YnNYGj1db9_lO7I6q4chOrU_0YJQhmluInFWJyALevIcQ>
    <xmx:AkN_afV1F-DhZDkye8NpjbHaMVa1aG1TgeXEMbbEmktjKp-KpntlLHu7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 512111EA006B; Sun,  1 Feb 2026 07:11:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aw2akiR53KZg
Date: Sun, 01 Feb 2026 13:11:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <29bd35be-3bc7-40ed-aff5-f37da5c4eaf1@app.fastmail.com>
In-Reply-To: 
 <bcd6fcd1190fe21c667b5253a4a33b833e658609.1769202903.git.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <bcd6fcd1190fe21c667b5253a4a33b833e658609.1769202903.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 3/4] doc: fix some style issues in git-clone and
 for-each-ref-options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026, at 22:15, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
>  * spell out all forms of --[no-]reject-shallow in git-clone
>  * use imperative mood for the first line of options
>  * Use asciidoc NOTE macro
>  * fix markups
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/for-each-ref-options.adoc |  4 ++--
>  Documentation/git-clone.adoc            | 30 ++++++++++++-------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/for-each-ref-options.adoc
> b/Documentation/for-each-ref-options.adoc
> index f13efb5f25..54e2fa95c2 100644
> --- a/Documentation/for-each-ref-options.adoc
> +++ b/Documentation/for-each-ref-options.adoc
> @@ -30,8 +30,8 @@ TAB %(refname)`.
>
>  `--color[=3D<when>]`::
>  	Respect any colors specified in the `--format` option. The
> -	_<when__ field must be one of `always`, `never`, or `auto` (if
> -	`<when>` is absent, behave as if `always` was given).
> +	_<when>_ field must be one of `always`, `never`, or `auto` (if
> +	_<when>_ is absent, behave as if `always` was given).

Good. I also checked the placeholders in this doc (by searching for `<`)
and couldn=E2=80=99t find any others that need updating.

>
>  `--shell`::
>  `--perl`::
> diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.ad=
oc
> index 7a0e147384..fceeb43475 100644
> --- a/Documentation/git-clone.adoc
> +++ b/Documentation/git-clone.adoc
> @@ -84,7 +84,7 @@ _<src>_.
>  	with the source repository.  The resulting repository
>  	starts out without any object of its own.
>  +
> -*NOTE*: this is a possibly dangerous operation; do *not* use
> +NOTE: this is a possibly dangerous operation; do *not* use
>  it unless you understand what it does. If you clone your
>  repository using this option and then delete branches (or use any
>  other Git command that makes any existing commit unreferenced) in the

A nice Note block.

> @@ -104,7 +104,8 @@ If you want to break the dependency of a repository
> cloned with `--shared` on
>  its source repository, you can simply run `git repack -a` to copy all
>  objects from the source repository into a pack in the cloned
> repository.
>
> -`--reference[-if-able] <repository>`::
> +`--reference <repository>`::
> +`--reference-if-able <repository>`::

Proper split between the two variants, both spelled out. Good.

>  	If the reference _<repository>_ is on the local machine,
>  	automatically setup `.git/objects/info/alternates` to
>  	obtain objects from the reference _<repository>_.  Using
> @@ -115,7 +116,7 @@ objects from the source repository into a pack in
> the cloned repository.
>  	directory is skipped with a warning instead of aborting
>  	the clone.
>  +
> -*NOTE*: see the NOTE for the `--shared` option, and also the
> +NOTE: see the NOTE for the `--shared` option, and also the
>  `--dissociate` option.

Good.

>
>  `--dissociate`::
> @@ -140,14 +141,14 @@ objects from the source repository into a pack in
> the cloned repository.
>  	to the standard error stream.
>
>  `--progress`::
> -	Progress status is reported on the standard error stream
> -	by default when it is attached to a terminal, unless `--quiet`
> +	Report progress status on the standard error stream
> +	by default when attached to a terminal, unless `--quiet`

Imperative mood. Good.

>  	is specified. This flag forces progress status even if the
>  	standard error stream is not directed to a terminal.
>
>  `--server-option=3D<option>`::
>  	Transmit the given string to the server when communicating using
> -	protocol version 2.  The given string must not contain a NUL or LF
> +	protocol version 2.  The given string must not contain a _NUL_ or _L=
F_

Using emphasis for these ASCII char names looks much better IMO.

>  	character.  The server's handling of server options, including
>  	unknown ones, is server-specific.
>  	When multiple `--server-option=3D<option>` are given, they are all
> @@ -158,9 +159,10 @@ objects from the source repository into a pack in
> the cloned repository.
>
>  `-n`::
>  `--no-checkout`::
> -	No checkout of `HEAD` is performed after the clone is complete.
> +	Do not checkout `HEAD` after the clone is complete.

Good.

>
> -`--`[`no-`]`reject-shallow`::
> +`--no-reject-shallow`::
> +`--reject-shallow`::
>  	Fail if the source repository is a shallow repository.
>  	The `clone.rejectShallow` configuration variable can be used to
>  	specify the default.

Spelling out each option, good.

> @@ -214,10 +216,9 @@ objects from the source repository into a pack in
> the cloned repository.
>
>  `-b <name>`::
>  `--branch <name>`::
> -	Instead of pointing the newly created `HEAD` to the branch pointed
> -	to by the cloned repository's `HEAD`, point to _<name>_ branch
> -	instead. In a non-bare repository, this is the branch that will
> -	be checked out.
> +	Point the newly created `HEAD` to _<name>_ branch instead of the bra=
nch
> +	pointed to by the cloned repository's `HEAD`. In a non-bare reposito=
ry,
> +	this is the branch that will be checked out.

This looks better. Leading with what the option does instead of starting
with a whole =E2=80=9Cinstead=E2=80=9D clause about what some *other* op=
tion or mode
does.

>  	`--branch` can also take tags and detaches the `HEAD` at that commit
>  	in the resulting repository.
>
> @@ -232,9 +233,8 @@ objects from the source repository into a pack in
> the cloned repository.
>
>  `-u <upload-pack>`::
>  `--upload-pack <upload-pack>`::
> -	When given, and the repository to clone from is accessed
> -	via ssh, this specifies a non-default path for the command
> -	run on the other end.
> +	Specify a non-default path for the command run on the other end when=
 the
> +	repository to clone from is accessed via ssh.

Waging war on the =E2=80=9CWhen given,=E2=80=9D introduction. Good.

>
>  `--template=3D<template-directory>`::
>  	Specify the directory from which templates will be used;
> --
> gitgitgadget
