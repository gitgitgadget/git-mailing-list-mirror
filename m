Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F536E497
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155135; cv=none; b=LOtnglmjJ1r9sYVzfgdT4JJ5jDBPuGlDNm8GG7tUx8k/C07Pky2ImA3rQMKZRYCZqst02g3jGIWiFBzK0M0i1PoESUG8Z01y+vGYI+iTK+n/ynkxvQDgrm9iy4GKMYHjpOz4UgGdojfLHJ+4YR5RbvliDfHqArj7JqfTSlDoTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155135; c=relaxed/simple;
	bh=u5xWK0aawjmxL1bJj5WzvqdLqwCpSJR4eKQNoqu2OkM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PzmMJzBuHWfJzvfnvp3uYRV5nNGLsONcyzPandtytKSJOh9TbdG6xBge43yRGOrEKVmoBBVqfDZGP3ye4mKew62yktsWpJJJLDpL0rgTCCyI+5Sokkf6mFpqbSprvGjN0Az4q5qKPCDGKtlkabdNIa2ES65n7SzCuxs895HjatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AZgT3DZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rLcn9O37; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AZgT3DZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rLcn9O37"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DCDBD1D00065;
	Tue,  3 Feb 2026 16:45:32 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Feb 2026 16:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770155132;
	 x=1770241532; bh=KHVlboe5hZtT5CWTU7KoiB3xo3/Gq1Ewwh6HGLKwWUE=; b=
	AZgT3DZWxof6PnKPjaI9HmgRTX3mcJqm8PgEyFTHELIPuwx8dMcvWAqG7x/uezgz
	doL09GX0uBb0pmC390xN/6P9oXEOxLpLVn4DbdRY/Q+2tn7A8kL14lG/3OVzVP3S
	+ZPY8GBw+e77cCEE8u4TJHxLONEjJH1D12347mLFwXkyCJ82wYg3rpfsOWtgefag
	gkZKcLDeaGQCtlg+2mpTw5YdAASMtraILOi2mxKVZlXL4WZzD09aTFHIrEyO7Fa2
	BLtL38KiVhDQc/KPmPyXB3/GTUVoVyduj6mawFJYNTLX20+m2198TlpZAXa7k2bW
	v0+eYzH5vtYS/bRjgBTy0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770155132; x=
	1770241532; bh=KHVlboe5hZtT5CWTU7KoiB3xo3/Gq1Ewwh6HGLKwWUE=; b=r
	Lcn9O37gJTdU3B6J8LLm9pbH0+MhkdVmnZo9hzBgHFOzLsSPvP0x39yNSNEvOz7c
	uca09aQcH5IHqqu1rMvnG/86lrIU0NCbsMHicDgGnR3uXtkTuuWKsWJvG5QS2A+p
	ZL5Px/+ppjfIf+lCtIgkwGAV+r6fx24uFFR4+rq7q+XyIqATueqiJ0XYxFzVGunC
	t1MSrbyXQIE56wY+onwIjnUw40vNnV2gIDqG3NPvwIMmXd37VAJnd0T1UqR6ikgx
	wffe7kvfT7J5qPSWiH2OhhBmcsOnOg9Ui51kearAiVPUAN7WtJavwmd/zlFpfkFc
	C4tC+NaTQ53OUFrBheJtw==
X-ME-Sender: <xms:fGyCad25RnVI02f4XnseEholR_Gtre3elw4NvcWDZR0d29xf07lHaJg>
    <xme:fGyCae6EZFO5cA7k9gGBke7901nk4PhyxvLH93mblDNNqqyaKsBHFZzVxdqcA3qn6
    WiuY_sxMuRlT4LGOY8lxE3LCKOBcjAuwNpMtPaT0KDUPrUCkK2fig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdp
    rhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fGyCaYwHGtLOmt6AQRRH77D3R6iOaP6x8WiPp7AbrUDDvUvuTZczWg>
    <xmx:fGyCaUCCtx3b40AUVZuIXhVXt6f6tYLahxJehob6O1iD0THXQCe9EQ>
    <xmx:fGyCadZwiYP6M487vLRN_0hflYzqgGSTv_PGkNlYplmTwMPTtk1IqA>
    <xmx:fGyCaUjQviBOqAVsY9W0Hn0Z_FiJr5_bU3T83KDyAiwtinlQckR8DQ>
    <xmx:fGyCaWvJg9DwaXOw1tXG95tiM3yewfV0DecTEmmJbagSKcBDEBVKRZuH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A6AA1EA006B; Tue,  3 Feb 2026 16:45:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACInDBRq-BB7
Date: Tue, 03 Feb 2026 22:45:12 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <bd07e62d-b185-4d1a-9bb5-7c075d6508c2@app.fastmail.com>
In-Reply-To: 
 <8d22e6952a3c0e20d9cc797e2dcc216591b10e6b.1770138215.git.gitgitgadget@gmail.com>
References: <pull.2036.v2.git.1769462744.gitgitgadget@gmail.com>
 <pull.2036.v3.git.1770138215.gitgitgadget@gmail.com>
 <8d22e6952a3c0e20d9cc797e2dcc216591b10e6b.1770138215.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3 1/4] doc: convert git-submodule to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 18:03, Jean-No=C3=ABl Avila via GitGitGadget wro=
te:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
>  * convert commands to synopsis style
>  * use _<placeholder>_ for arguments
>  * convert inline lists into proper definition lists
>  * minor formatting fixes
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> Reviewed-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>

`Reviewed-by` is a special case. It=E2=80=99s the only trailer that has =
to be
given explicitly by the person.

(trailers that credit other people should also come before the signoff)

Thanks for the credit, of course. :)

> ---
>  Documentation/git-submodule.adoc | 389 ++++++++++++++++---------------
>  1 file changed, 196 insertions(+), 193 deletions(-)
>
> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-subm=
odule.adoc
> index 95beaee561..e581b0c7aa 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -8,19 +8,19 @@ git-submodule - Initialize, update or inspect submod=
ules
>[snip]
>  DESCRIPTION
> @@ -34,16 +34,16 @@ COMMANDS
>  With no arguments, shows the status of existing submodules.  Several
>  subcommands are available to perform operations on the submodules.
>
> -add [-b <branch>] [-f|--force] [--name <name>] [--reference
> <repository>] [--ref-format <format>] [--depth <depth>] [--]
> <repository> [<path>]::
> +`add [-b <branch>] [-f | --force] [--name <name>] [--reference
> <repository>] [--ref-format <format>] [--depth <depth>] [--]
> <repository> [<path>]`::
>  	Add the given repository as a submodule at the given path
>  	to the changeset to be committed next to the current
>  	project: the current project is termed the "superproject".
>  +
> -<repository> is the URL of the new submodule's origin repository.
> -This may be either an absolute URL, or (if it begins with ./
> -or ../), the location relative to the superproject's default remote
> -repository (Please note that to specify a repository 'foo.git'
> -which is located right next to a superproject 'bar.git', you'll
> +_<repository>_ is the URL of the new submodule's `origin` repository.

This (`origin`) is new. I have never used git-submodule(1). Is this
*code* or is it jargon for something like =E2=80=9Coriginal=E2=80=9D rep=
ository? It came
in commit ec05df35 (git-submodule - make "submodule add" more strict,
and document it, 2008-07-09):

    With this patch, the URL locating the submodule's origin repository =
can be
    either an absolute URL, or (if it begins with ./ or ../) can express=
 the
    submodule's repository location relative to the superproject's origi=
n.

The "origin" that I referred to in the previous round was this sentence
a little way down:

    If no such remote-tracking branch exists or the HEAD is detached,
    "origin" is assumed to be the default remote.

And here I read =E2=80=9Corigin=E2=80=9D as a real, concrete name. Which=
 is why I
thought `origin` would fit instead.

> +This may be either an absolute URL, or (if it begins with `./`
> +or `../`), the location relative to the superproject's default remote
> +repository (Please note that to specify a repository `foo.git`
> +which is located right next to a superproject `bar.git`, you'll
>[snip]
>
> -status [--cached] [--recursive] [--] [<path>...]::
> +`status [--cached] [--recursive] [--] [<path>...]`::
>  	Show the status of the submodules. This will print the SHA-1 of the
>  	currently checked out commit for each submodule, along with the
> -	submodule path and the output of 'git describe' for the
> +	submodule path and the output of linkgit:git-describe[1] for the
>  	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule
> is
>  	not initialized, `+` if the currently checked out submodule commit
>  	does not match the SHA-1 found in the index of the containing
> @@ -95,7 +95,7 @@ submodules with respect to the commit recorded in the
> index or the HEAD,

Nit: There are some remaining =E2=80=9CHEAD=E2=80=9D without backticks.

The phrasing =E2=80=9Cthe HEAD=E2=80=9D does also keep recurring. Might =
be worth
replacing with just `HEAD` at this point?

>  linkgit:git-status[1] and linkgit:git-diff[1] will provide that
> information
>  too (and can also report changes to a submodule's work tree).
>[snip]
>  +
>  `git submodule sync` synchronizes all submodules while
> -`git submodule sync -- A` synchronizes submodule "A" only.
> +`git submodule sync -- A` synchronizes submodule `A` only.

`A`, good.

>  +
>  If `--recursive` is specified, this command will recurse into the
>  registered submodules, and sync any nested submodules within.
>
> -absorbgitdirs::
> +`absorbgitdirs`::
>  	If a git directory of a submodule is inside the submodule,
>  	move the git directory of the submodule into its superproject's
>  	`$GIT_DIR/modules` path and then connect the git directory and
>  	its working directory by setting the `core.worktree` and adding
> -	a .git file pointing to the git directory embedded in the
> +	a `.git` file pointing to the git directory embedded in the
>  	superprojects git directory.
>  +
>  A repository that was cloned independently and later added as a submo=
dule or
> @@ -279,72 +283,70 @@ This command is recursive by default.
>
>  OPTIONS
>  -------
> --q::
> ---quiet::
> +`-q`::
> +`--quiet`::
>  	Only print error messages.
>
> ---progress::
> -	This option is only valid for add and update commands.
> -	Progress status is reported on the standard error stream
> -	by default when it is attached to a terminal, unless -q
> +`--progress`::
> +	Report progress status on the standard error stream
> +	by default when it is attached to a terminal, unless `-q`
>  	is specified. This flag forces progress status even if the
> -	standard error stream is not directed to a terminal.
> +	standard error stream is not directed to a terminal. It is
> +	only valid for `add` and `update` commands.
>
> ---all::
> -	This option is only valid for the deinit command. Unregister all
> -	submodules in the working tree.
> +`--all`::
> +	Unregister all submodules in the working tree. This option is only
> +	valid for the `deinit` command.
>
> --b <branch>::
> ---branch <branch>::
> +`-b<branch>`::
> +`--branch=3D<branch>`::

Stuck form, nice.

>  	Branch of repository to add as submodule.
>  	The name of the branch is recorded as `submodule.<name>.branch` in
>  	`.gitmodules` for `update --remote`.  A special value of `.` is used=
 to
>  	indicate that the name of the branch in the submodule should be the
>  	same name as the current branch in the current repository.  If the
> -	option is not specified, it defaults to the remote 'HEAD'.
>[snip]
> ---rebase::
> -	This option is only valid for the update command.
> -	Rebase the current branch onto the commit recorded in the
> -	superproject. If this option is given, the submodule's HEAD will not
> +`--rebase`::
> +	Rebase the current branch onto the commit recorded in the
> superproject.
> +	This option is only valid for the update command. The submodule's HE=
AD will not

I=E2=80=99m sorry. I missed these two before: `update` and `HEAD`. :(

>[snip]
> ---name::
> -	This option is only valid for the add command. It sets the submodule=
's
> -	name to the given string instead of defaulting to its path. The name
> +`--name=3D<name>`::
> +	Set the submodule's name to the given string instead of defaulting to
> its path. _<name>_
>  	must be valid as a directory name and may not end with a '/'.

nit: `/`.

>[snip]
>  FILES
>  -----
>  When initializing submodules, a `.gitmodules` file in the top-level d=
irectory
> -of the containing repository is used to find the url of each submodul=
e.
> +of the containing repository is used to find the URL of each submodul=
e.
>  This file should be formatted in the same way as `$GIT_DIR/config`. T=
he key
> -to each submodule url is "submodule.$name.url".  See linkgit:gitmodul=
es[5]
> +to each submodule URL is `submodule.<name>.url`.  See linkgit:gitmodu=
les[5]

Replacing `$name` with `<name>`. Nice.

>  for details.
>
>  SEE ALSO
> --
> gitgitgadget
