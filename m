Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A73246EB
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769947468; cv=none; b=FH0IoQ5tX7KgSo4CR2BdNJwfUyH5HRpEYAOZAunFQUmdlFpRG5ShRpQYz3dATBO4Ub6P1Fl8SDopRSZUeF0KMNtkEV0oAcWspZC0Mf9sL6kXOrrCmnF6xFeeOpCS9REkDQ7EoNdlSp/rXNgZSsZQVpWsxunNXjMjsXhQqXWD6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769947468; c=relaxed/simple;
	bh=2Qhfo9abqXmP3DrFBdb9ikhGi1sSz/AhQGtgRarkRi0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=p6B3uaBN2VzNiRfUri7ptrK7a4emIted41AgMaA+wfzUPosk3zbLLoNSLy2hSWD4ZbsLtaLQQIDjQEqf7hmzZ+CVlFyEbE/LX7v2C9XkPgdZOxwOcUfgqcImfssetzKu0Uzc1L8WIWy8lVdhimoAg5xWTuwZGtSv3PKaiCN5kHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gULZUKpH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rI7MdUva; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gULZUKpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rI7MdUva"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 51157EC022D;
	Sun,  1 Feb 2026 07:04:24 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 01 Feb 2026 07:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769947464;
	 x=1770033864; bh=3PUpIq3prta65RpqnUUpBPit2nPm0Sz8oD5fLq/TOsE=; b=
	gULZUKpHv/iZwOSHOdnoC/SUk6wuryWDX4NN28JXMoYuvXbLcAbU9Sh5JkBxI7SV
	26ZNt4WfODd+jXPmyhuB2m8VFoyrd4IUGR89MhgrRCRVGE+Lev5+tE4YdJjpueyI
	9BOklFKQyjYiO93SMfxNd6X2bks9wlxiQw9Vo61ZN7/K3NfYQKtNE8YaWk+paJpz
	2VUhYEn22pthL9evqTpWU3/Wz39YWa3n9q02OMvYy0ezRKC9HMSynJNQ0kzdUm9Z
	SWdt54DWVc1XpmXk/vyrKFrEjYyB4M1KmLBFaLGZDMJp3dvydTYVw9yivzbkl5a4
	BQpjXXzqQWlh7t4hBObaBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769947464; x=
	1770033864; bh=3PUpIq3prta65RpqnUUpBPit2nPm0Sz8oD5fLq/TOsE=; b=r
	I7MdUva6cvoOhKknl594OHxGpet3U0th3QVr+2e/Nr7aELaTCQxGVgQ/zhmXvAa2
	yS1AoQ5CU273EapIoMlsuADXgSlR+3S4vIGrXwHtqXFNomXF9qoh14MLmRdjspxC
	a+81U49cwxqEKGVNTNSmrJ/dHLxW80jIFTnH/25mh6vsVAqn3cgahq27LZyEB+gP
	A6z2BvWTu6QEM6Rqtlzscug9LfXYGEcwy061GeoqCln0klTmgU0QBUCe1JAFFM+x
	277mfHGcoNpDsBhBDNd6T83Aidv26m8JPVaIF7KIjqKpowJl0gMTDfgrDhW605gz
	Y9MF7K4WyV2MU4uIYPPPg==
X-ME-Sender: <xms:SEF_aaBtYy6EwSY0aeK6DY1UffLP_ug329oZaMhcXCMDLA89OuxCuHc>
    <xme:SEF_afVA4r-GqaRDlYj3oh6Z5s_60203aXXUMnE7faayKHwurf87rwjQ9IknMICe5
    R2Jw3ldvnpPplDEbaPl7iq8PDSx9Xcl3eetbiBrfH-CbMk90Clm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeegjeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SEF_affV_hettIVAvDx3eD2iJhQchR9g9ZkxZqynphNBSl31jkJfGA>
    <xmx:SEF_ac-HO4aguT3QPclKBygrYZlLrstrA-LVBD7q_4fs-0w91girWQ>
    <xmx:SEF_ablIksJfTLSB_3Jc4iE93eMvZQMGVuxitRqg35nIM6dmTLYCVg>
    <xmx:SEF_ae-tvMjcv2t7GVcxD8v9kbo3B6XDJSs36QyNBZ0bEYOuBrDp5w>
    <xmx:SEF_ad62oAMZ-M8zl8nk5WvCrYFW9QXVVxgEQCnTnVSdlMnReZYfsu28>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 162591EA006B; Sun,  1 Feb 2026 07:04:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJBdjbAZCuPk
Date: Sun, 01 Feb 2026 13:04:02 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <83cef072-530a-423b-ba89-26eb6bc63e67@app.fastmail.com>
In-Reply-To: 
 <05e68e28257cd450463d253abe9b2995759bdc10.1769202903.git.gitgitgadget@gmail.com>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <05e68e28257cd450463d253abe9b2995759bdc10.1769202903.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 1/4] convert git-submodule doc to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026, at 22:15, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
>  * convert commands to synopsis style
>  * use _<placeholder>_ for arguments
>  * convert inline lists into proper definition lists
>  * minor formatting fixes
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  Documentation/git-submodule.adoc | 369 ++++++++++++++++---------------
>  1 file changed, 185 insertions(+), 184 deletions(-)
>
> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-subm=
odule.adoc
> index 95beaee561..188212508e 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -8,19 +8,19 @@ git-submodule - Initialize, update or inspect submod=
ules
>
>  SYNOPSIS
>  --------
> -[verse]
> -'git submodule' [--quiet] [--cached]
> -'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
> -'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path=
>...]
> -'git submodule' [--quiet] init [--] [<path>...]
> -'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
> -'git submodule' [--quiet] update [<options>] [--] [<path>...]
> -'git submodule' [--quiet] set-branch [<options>] [--] <path>
> -'git submodule' [--quiet] set-url [--] <path> <newurl>
> -'git submodule' [--quiet] summary [<options>] [--] [<path>...]
> -'git submodule' [--quiet] foreach [--recursive] <command>
> -'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
> -'git submodule' [--quiet] absorbgitdirs [--] [<path>...]
> +[synopsis]
> +git submodule [--quiet] [--cached]
> +git submodule [--quiet] add [<options>] [--] <repository> [<path>]
> +git submodule [--quiet] status [--cached] [--recursive] [--] [<path>.=
..]
> +git submodule [--quiet] init [--] [<path>...]
> +git submodule [--quiet] deinit [-f|--force] (--all|[--] <path>...)
> +git submodule [--quiet] update [<options>] [--] [<path>...]
> +git submodule [--quiet] set-branch [<options>] [--] <path>
> +git submodule [--quiet] set-url [--] <path> <newurl>
> +git submodule [--quiet] summary [<options>] [--] [<path>...]
> +git submodule [--quiet] foreach [--recursive] <command>
> +git submodule [--quiet] sync [--recursive] [--] [<path>...]
> +git submodule [--quiet] absorbgitdirs [--] [<path>...]

Good.

>
>
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
> +_<repository>_ is the URL of the new submodule's origin repository.
> +This may be either an absolute URL, or (if it begins with `./`
> +or `../`), the location relative to the superproject's default remote
> +repository (Please note that to specify a repository `foo.git`
> +which is located right next to a superproject `bar.git`, you'll
>  have to use `../foo.git` instead of `./foo.git` - as one might expect
>  when following the rules for relative URLs - because the evaluation
>  of relative URLs in Git is identical to that of relative directories).

Good. There is also an "origin" outside the context lines here that you
may want to replace with `origin`:

    , "origin" is assumed to be the default remote.

> @@ -55,13 +55,13 @@ If the superproject doesn't have a default remote
> configured
>  the superproject is its own authoritative upstream and the current
>  working directory is used instead.
>  +
> -The optional argument <path> is the relative location for the cloned
> -submodule to exist in the superproject. If <path> is not given, the
> -canonical part of the source repository is used ("repo" for
> -"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
> +The optional argument _<path>_ is the relative location for the cloned
> +submodule to exist in the superproject. If _<path>_ is not given, the
> +canonical part of the source repository is used (`repo` for
> +`/path/to/repo.git` and `foo` for `host.xz:foo/.git`). If _<path>_
>  exists and is already a valid Git repository, then it is staged
> -for commit without cloning. The <path> is also used as the submodule's
> -logical name in its configuration entries unless `--name` is used
> +for commit without cloning. The _<path>_ is also used as the
> submodule's
> +logical name in its configuration entries unless `--name <name>` is
> used
>  to specify a logical name.
>  +
>  The given URL is recorded into `.gitmodules` for use by subsequent
> users

Looks correct.

> @@ -75,10 +75,10 @@ URL in `.gitmodules`.
>  If `--ref-format <format>`  is specified, the ref storage format of
> newly
>  cloned submodules will be set accordingly.
>
> -status [--cached] [--recursive] [--] [<path>...]::
> +`status [--cached] [--recursive] [--] [<path>...]`::
>  	Show the status of the submodules. This will print the SHA-1 of the
>  	currently checked out commit for each submodule, along with the
> -	submodule path and the output of 'git describe' for the
> +	submodule path and the output of `git describe` for the

Maybe `linkgit` for git-describe(1).

>  	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule
> is
>  	not initialized, `+` if the currently checked out submodule commit
>  	does not match the SHA-1 found in the index of the containing

Good.

> @@ -95,7 +95,7 @@ submodules with respect to the commit recorded in the
> index or the HEAD,
>  linkgit:git-status[1] and linkgit:git-diff[1] will provide that
> information
>  too (and can also report changes to a submodule's work tree).
>
> -init [--] [<path>...]::
> +`init [--] [<path>...]`::
>  	Initialize the submodules recorded in the index (which were
>  	added and committed elsewhere) by setting `submodule.$name.url`
>  	in `.git/config`, using the same setting from `.gitmodules` as

Good.

> @@ -103,7 +103,7 @@ init [--] [<path>...]::
>  	the default remote. If there is no default remote, the current
>  	repository will be assumed to be upstream.
>  +
> -Optional <path> arguments limit which submodules will be initialized.
> +Optional _<path>_ arguments limit which submodules will be initialize=
d.
>  If no path is specified and submodule.active has been configured,
> submodules
>  configured to be active will be initialized, otherwise all submodules
> are
>  initialized.
> @@ -116,12 +116,12 @@ that is set to a custom command is *not* copied
> for security reasons.
>  You can then customize the submodule clone URLs in `.git/config`
>  for your local setup and proceed to `git submodule update`;
>  you can also just use `git submodule update --init` without
> -the explicit 'init' step if you do not intend to customize
> +the explicit `init` step if you do not intend to customize
>  any submodule locations.
>  +
>  See the add subcommand for the definition of default remote.
>
> -deinit [-f|--force] (--all|[--] <path>...)::
> +`deinit [-f | --force] (--all|[--] <path>...)`::
>  	Unregister the given submodules, i.e. remove the whole
>  	`submodule.$name` section from .git/config together with their work
>  	tree. Further calls to `git submodule update`, `git submodule foreac=
h`
> @@ -139,7 +139,7 @@ If you really want to remove a submodule from the
> repository and commit
>  that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for
> removal
>  options.

Good.

>
> -update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow]
> [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>]
> [--ref-format <format>] [--depth <depth>] [--recursive] [--jobs <n>]
> [--[no-]single-branch] [--filter <filter-spec>] [--] [<path>...]::
> +`update [--init] [--remote] [-N | --no-fetch]
> [--[no-]recommend-shallow] [-f | --force] [--checkout | --rebase |
> --merge] [--reference <repository>] [--ref-format <format>] [--depth
> <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter
> <filter-spec>] [--] [<path>...]`::
>  +
>  --
>  Update the registered submodules to match what the superproject
> @@ -148,38 +148,38 @@ in submodules and updating the working tree of
>  the submodules. The "updating" can be done in several ways depending
>  on command line options and the value of `submodule.<name>.update`
>  configuration variable. The command line option takes precedence over
> -the configuration variable. If neither is given, a 'checkout' is
> performed.
> +the configuration variable. If neither is given, a `checkout` is
> performed.
>  (note: what is in `.gitmodules` file is irrelevant at this point;
>  see `git submodule init` above for how `.gitmodules` is used).
> -The 'update' procedures supported both from the command line as well =
as
> +The `update` procedures supported both from the command line as well =
as
>  through the `submodule.<name>.update` configuration are:
>
> -	checkout;; the commit recorded in the superproject will be
> -	    checked out in the submodule on a detached HEAD.
> +`checkout`;; the commit recorded in the superproject will be
> +checked out in the submodule on a detached HEAD.
>  +
>  If `--force` is specified, the submodule will be checked out (using
>  `git checkout --force`), even if the commit specified
>  in the index of the containing repository already matches the commit
>  checked out in the submodule.
>
> -	rebase;; the current branch of the submodule will be rebased
> -	    onto the commit recorded in the superproject.
> +`rebase`;; the current branch of the submodule will be rebased
> +onto the commit recorded in the superproject.
>
> -	merge;; the commit recorded in the superproject will be merged
> -	    into the current branch in the submodule.
> +`merge`;; the commit recorded in the superproject will be merged
> +into the current branch in the submodule.
>
>  The following update procedures have additional limitations:
>
> -	custom command;; mechanism for running arbitrary commands with the
> -	    commit ID as an argument. Specifically, if the
> -	    `submodule.<name>.update` configuration variable is set to
> -	    `!custom command`, the object name of the commit recorded in the
> -	    superproject for the submodule is appended to the `custom comman=
d`
> -	    string and executed. Note that this mechanism is not supported in
> -	    the `.gitmodules` file or on the command line.
> +`!<custom-command>`;; mechanism for running arbitrary commands with t=
he
> +commit ID as an argument. Specifically, if the
> +`submodule.<name>.update` configuration variable is set to
> +`!<custom-command>`, the object name of the commit recorded in the
> +superproject for the submodule is appended to the _<custom-command>_
> +string and executed. Note that this mechanism is not supported in
> +the `.gitmodules` file or on the command line.
>
> -	none;; the submodule is not updated. This update procedure is not
> -	    allowed on the command line.
> +`none`;; the submodule is not updated. This update procedure is not
> +allowed on the command line.
>
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in `.gitmodules`, you can automatically initialize
> the
> @@ -195,20 +195,20 @@ If `--filter <filter-spec>` is specified, the
> given partial clone filter will be
>  applied to the submodule. See linkgit:git-rev-list[1] for details on
> filter
>  specifications.
>  --
> -set-branch (-b|--branch) <branch> [--] <path>::
> -set-branch (-d|--default) [--] <path>::
> -	Sets the default remote tracking branch for the submodule. The
> +`set-branch (-b|--branch) <branch> [--] <path>`::
> +`set-branch (-d|--default) [--] <path>`::
> +	Set the default remote tracking branch for the submodule. The
>  	`--branch` option allows the remote branch to be specified. The
> -	`--default` option removes the submodule.<name>.branch configuration
> -	key, which causes the tracking branch to default to the remote 'HEAD=
'.
> +	`--default` option removes the `submodule.<name>.branch` configurati=
on
> +	key, which causes the tracking branch to default to the remote `HEAD=
`.
>
> -set-url [--] <path> <newurl>::
> -	Sets the URL of the specified submodule to <newurl>. Then, it will
> +`set-url [--] <path> <newurl>`::
> +	Set the URL of the specified submodule to _<newurl>_. Then, it will
>  	automatically synchronize the submodule's new remote URL
>  	configuration.
>
> -summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--]
> [<path>...]::
> -	Show commit summary between the given commit (defaults to HEAD) and
> +`summary [--cached | --files] [(-n|--summary-limit) <n>] [commit] [--]
> [<path>...]`::
> +	Show commit summary between the given commit (defaults to `HEAD`) and
>  	working tree/index. For a submodule in question, a series of commits
>  	in the submodule between the given super project commit and the
>  	index or working tree (switched by `--cached`) are shown. If the
> option
> @@ -220,27 +220,31 @@ summary [--cached|--files] [(-n|--summary-limit)
> <n>] [commit] [--] [<path>...]:
>  Using the `--submodule=3Dlog` option with linkgit:git-diff[1] will
> provide that
>  information too.
>
> -foreach [--recursive] <command>::
> -	Evaluates an arbitrary shell command in each checked out submodule.
> -	The command has access to the variables $name, $sm_path, $displaypat=
h,
> -	$sha1 and $toplevel:
> -	$name is the name of the relevant submodule section in `.gitmodules`,
> -	$sm_path is the path of the submodule as recorded in the immediate
> -	superproject, $displaypath contains the relative path from the
> -	current working directory to the submodules root directory,
> -	$sha1 is the commit as recorded in the immediate
> -	superproject, and $toplevel is the absolute path to the top-level
> -	of the immediate superproject.
> -	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
> -	variable is now a deprecated synonym of '$sm_path' variable.
> -	Any submodules defined in the superproject but not checked out are
> -	ignored by this command. Unless given `--quiet`, foreach prints the =
name
> -	of each submodule before evaluating the command.
> -	If `--recursive` is given, submodules are traversed recursively (i.e.
> -	the given shell command is evaluated in nested submodules as well).
> -	A non-zero return from the command in any submodule causes
> -	the processing to terminate. This can be overridden by adding '|| :'
> -	to the end of the command.
> +`foreach [--recursive] <command>`::
> +	Evaluate an arbitrary shell _<command>_ in each checked out submodul=
e.
> +	The command has access to the variables `$name`, `$sm_path`, `$displ=
aypath`,
> +	`$sha1` and `$toplevel`:
> ++
> +--
> +`$name`;; the name of the relevant submodule section in `.gitmodules`
> +`$sm_path`;; the path of the submodule as recorded in the immediate
> +	superproject
> +`$displaypath`;; the relative path from the
> +	current working directory to the submodules root directory
> +`$sha1`;; the commit as recorded in the immediate superproject
> +`$toplevel`;; the absolute path to the top-level of the immediate sup=
erproject.
> +--
> ++
> +Note that to avoid conflicts with `$PATH` on Windows, the `$path`
> +variable is now a deprecated synonym of `$sm_path` variable.
> +Any submodules defined in the superproject but not checked out are
> +ignored by this command. Unless given `--quiet`, foreach prints the n=
ame
> +of each submodule before evaluating the command.
> +If `--recursive` is given, submodules are traversed recursively (i.e.
> +the given shell command is evaluated in nested submodules as well).
> +A non-zero return from the command in any submodule causes
> +the processing to terminate. This can be overridden by adding ++||:++
> +to the end of the command.
>  +
>  As an example, the command below will show the path and currently
>  checked out commit for each submodule:
> @@ -249,10 +253,10 @@ checked out commit for each submodule:
>  git submodule foreach 'echo $sm_path `git rev-parse HEAD`'
>  --------------

Good.

>
> -sync [--recursive] [--] [<path>...]::
> -	Synchronizes submodules' remote URL configuration setting
> +`sync [--recursive] [--] [<path>...]`::
> +	Synchronize submodules' remote URL configuration setting
>  	to the value specified in `.gitmodules`. It will only affect those
> -	submodules which already have a URL entry in .git/config (that is the
> +	submodules which already have a URL entry in `.git/config` (that is =
the
>  	case when they are initialized or freshly added). This is useful when
>  	submodule URLs change upstream and you need to update your local
>  	repositories accordingly.

Good.

There is also a "A" that you might want to change to `A`.

> @@ -263,12 +267,12 @@ sync [--recursive] [--] [<path>...]::
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
> +`-b <branch>`::
> +`--branch <branch>`::
>  	Branch of repository to add as submodule.
>  	The name of the branch is recorded as `submodule.<name>.branch` in
>  	`.gitmodules` for `update --remote`.  A special value of `.` is used=
 to
>  	indicate that the name of the branch in the submodule should be the
>  	same name as the current branch in the current repository.  If the
> -	option is not specified, it defaults to the remote 'HEAD'.
> -
> --f::
> ---force::
> -	This option is only valid for add, deinit and update commands.
> -	When running add, allow adding an otherwise ignored submodule path.
> -	This option is also used to bypass a check that the submodule's name
> -	is not already in use. By default, 'git submodule add' will fail if
> -	the proposed name (which is derived from the path) is already regist=
ered
> -	for another submodule in the repository. Using '--force' allows the =
command
> -	to proceed by automatically generating a unique name by appending a =
number
> -	to the conflicting name (e.g., if a submodule named 'child' exists, =
it will
> -	try 'child1', and so on).
> -	When running deinit the submodule working trees will be removed even
> -	if they contain local changes.
> -	When running update (only effective with the checkout procedure),
> -	throw away local changes in submodules when switching to a
> -	different commit; and always run a checkout operation in the
> -	submodule, even if the commit listed in the index of the
> -	containing repository matches the commit checked out in the
> -	submodule.
> -
> ---cached::
> -	This option is only valid for status and summary commands.  These
> -	commands typically use the commit found in the submodule HEAD, but
> -	with this option, the commit stored in the index is used instead.
> -
> ---files::
> -	This option is only valid for the summary command. This command
> -	compares the commit in the index with that in the submodule HEAD
> -	when this option is used.
> -
> --n::
> ---summary-limit::
> -	This option is only valid for the summary command.
> -	Limit the summary size (number of commits shown in total).
> +	option is not specified, it defaults to the remote `HEAD`.
> +
> +`-f`::
> +`--force`::
> +	Force the command to proceed, even if it would otherwise fail.
> +	This option is only valid for `add`, `deinit` and `update` commands.
> +`add`;; allow adding an otherwise ignored submodule path.
> +This option is also used to bypass a check that the submodule's name
> +is not already in use. By default, `git submodule add` will fail if
> +the proposed name (which is derived from the path) is already registe=
red
> +for another submodule in the repository. Using `--force` allows the c=
ommand
> +to proceed by automatically generating a unique name by appending a n=
umber
> +to the conflicting name (e.g., if a submodule named 'child' exists, i=
t will
> +try 'child1', and so on).
> +`deinit`;; the submodule working trees will be removed even
> +if they contain local changes.
> +`update`;; (only effective with the checkout procedure),
> +throw away local changes in submodules when switching to a
> +different commit; and always run a checkout operation in the
> +submodule, even if the commit listed in the index of the
> +containing repository matches the commit checked out in the
> +submodule.
> +
> +`--cached`::
> +	Use the index to determine the commit instead of the `HEAD`.
> +	This option is only valid for `status` and `summary` commands.
> +
> +`--files`::
> +	Make the `summary` command compare the commit in the index with that=
 in
> +	the submodule `HEAD`.
> +
> +`-n <n>`::
> +`--summary-limit <n>`::
> +	Limit the `summary` size (number of commits shown in total) to _<n>_.
>  	Giving 0 will disable the summary; a negative number means unlimited
>  	(the default). This limit only applies to modified submodules. The
>  	size is always limited to 1 for added/deleted/typechanged submodules.
>
> ---remote::
> -	This option is only valid for the update command.  Instead of using
> -	the superproject's recorded SHA-1 to update the submodule, use the
> -	status of the submodule's remote-tracking branch.  The remote used
> +`--remote`::
> +	Instead of using the superproject's recorded SHA-1 to update the
> +	submodule, use the status of the submodule's remote-tracking branch.
> +	This option is only valid for the `update` command. The remote used
>  	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
>  	The remote branch used defaults to the remote `HEAD`, but the branch
>  	name may be overridden by setting the `submodule.<name>.branch`
> @@ -363,7 +365,7 @@ SHA-1.  If you don't want to fetch, you should use
> `submodule update
>  --remote --no-fetch`.
>  +
>  Use this option to integrate changes from the upstream subproject with
> -your submodule's current HEAD.  Alternatively, you can run `git pull`
> +your submodule's current `HEAD`.  Alternatively, you can run `git pul=
l`
>  from the submodule, which is equivalent except for the remote branch
>  name: `update --remote` uses the default upstream repository and
>  `submodule.<name>.branch`, while `git pull` uses the submodule's
> @@ -372,51 +374,51 @@ to distribute the default upstream branch with
> the superproject and
>  `branch.<name>.merge` if you want a more native feel while working in
>  the submodule itself.
>
> --N::
> ---no-fetch::
> -	This option is only valid for the update command.
> +`-N`::
> +`--no-fetch`::
>  	Don't fetch new objects from the remote site.
> +	This option is only valid for the `update` command.
>
> ---checkout::
> -	This option is only valid for the update command.
> -	Checkout the commit recorded in the superproject on a detached HEAD
> +`--checkout`::
> +	This option is only valid for the `update` command.
> +	Checkout the commit recorded in the superproject on a detached `HEAD`
>  	in the submodule. This is the default behavior, the main use of
> -	this option is to override `submodule.$name.update` when set to
> +	this option is to override `submodule.<name>.update` when set to
>  	a value other than `checkout`.
> -	If the key `submodule.$name.update` is either not explicitly set or
> +	If the key `submodule.<name>.update` is either not explicitly set or
>  	set to `checkout`, this option is implicit.
>
> ---merge::
> -	This option is only valid for the update command.
> +`--merge`::
>  	Merge the commit recorded in the superproject into the current branch
> -	of the submodule. If this option is given, the submodule's HEAD will
> +	of the submodule. This option is only valid for the `update` command.
> +	If this option is given, the submodule's `HEAD` will
>  	not be detached. If a merge failure prevents this process, you will
>  	have to resolve the resulting conflicts within the submodule with the
>  	usual conflict resolution tools.
> -	If the key `submodule.$name.update` is set to `merge`, this option is
> +	If the key `submodule.<name>.update` is set to `merge`, this option =
is
>  	implicit.
>
> ---rebase::
> +`--rebase`::
>  	This option is only valid for the update command.
>  	Rebase the current branch onto the commit recorded in the
>  	superproject. If this option is given, the submodule's HEAD will not
>  	be detached. If a merge failure prevents this process, you will have
>  	to resolve these failures with linkgit:git-rebase[1].
> -	If the key `submodule.$name.update` is set to `rebase`, this option =
is
> +	If the key `submodule.<name>.update` is set to `rebase`, this option=
 is
>  	implicit.
>
> ---init::
> -	This option is only valid for the update command.
> -	Initialize all submodules for which "git submodule init" has not been
> -	called so far before updating.
> +`--init`::
> +	Initialize all submodules for which `git submodule init` has not been
> +	called so far before updating. 	This option is only valid for the `u=
pdate`
> +	command.
> +
>
> ---name::
> -	This option is only valid for the add command. It sets the submodule=
's
> -	name to the given string instead of defaulting to its path. The name
> +`--name <name>`::
> +	Set the submodule's name to the given string instead of defaulting to
> its path. _<name>_
>  	must be valid as a directory name and may not end with a '/'.
>
> ---reference <repository>::
> -	This option is only valid for add and update commands.  These
> +`--reference <repository>`::
> +	This option is only valid for `add` and `update` commands.  These
>  	commands sometimes need to clone a remote repository. In this case,
>  	this option will be passed to the linkgit:git-clone[1] command.
>  +
> @@ -424,53 +426,52 @@ the submodule itself.
>  for linkgit:git-clone[1]'s `--reference`, `--shared`, and `--dissocia=
te`
>  options carefully.
>
> ---dissociate::
> +`--dissociate`::
>  	This option is only valid for add and update commands.  These
>  	commands sometimes need to clone a remote repository. In this case,
>  	this option will be passed to the linkgit:git-clone[1] command.
>  +
> -*NOTE*: see the NOTE for the `--reference` option.
> +*NOTE*: see the NOTE above for the `--reference` option.

Asciidoc NOTE macro here?

See also that NOTE:

    *NOTE*: Do *not* use this option unless you have read the note
    for linkgit:git-clone[1]'s `--reference`, `--shared`, and `--dissoci=
ate`
    options carefully.

    `--dissociate`::
            This option is only valid for add and update commands.  These
            commands sometimes need to clone a remote repository. In thi=
s case,
            this option will be passed to the linkgit:git-clone[1] comma=
nd.
    +
    *NOTE*: see the NOTE above for the `--reference` option.

>
> ---recursive::
> -	This option is only valid for foreach, update, status and sync comma=
nds.
> -	Traverse submodules recursively. The operation is performed not
> +`--recursive`::
> +	Traverse submodules recursively. This option is only valid for `fore=
ach`,
> +	`update`, `status` and `sync` commands. The operation is performed n=
ot
>  	only in the submodules of the current repo, but also
>  	in any nested submodules inside those submodules (and so on).
>
> ---depth::
> -	This option is valid for add and update commands. Create a 'shallow'
> -	clone with a history truncated to the specified number of revisions.
> -	See linkgit:git-clone[1]
> +`--depth <depth>`::
> +	Create a 'shallow' clone with a history truncated to the _<depth>_ r=
evisions.
> +	This option is valid for `add` and `update` commands. See linkgit:gi=
t-clone[1]
>
> ---recommend-shallow::
> ---no-recommend-shallow::
> -	This option is only valid for the update command.
> +`--recommend-shallow`::
> +`--no-recommend-shallow`::
> +	This option is only valid for the `update` command.
>  	The initial clone of a submodule will use the recommended
>  	`submodule.<name>.shallow` as provided by the `.gitmodules` file
>  	by default. To ignore the suggestions use `--no-recommend-shallow`.
>
> --j <n>::
> ---jobs <n>::
> -	This option is only valid for the update command.
> -	Clone new submodules in parallel with as many jobs.
> +`-j <n>`::
> +`--jobs <n>`::
> +	Clone new submodules in parallel with _<n>_ jobs.
> +	This option is only valid for the `update` command.
>  	Defaults to the `submodule.fetchJobs` option.
>
> ---single-branch::
> ---no-single-branch::
> -	This option is only valid for the update command.
> -	Clone only one branch during update: HEAD or one specified by --bran=
ch.
> +`--single-branch`::
> +`--no-single-branch`::
> +	Clone only one branch during update: `HEAD` or one specified by `--b=
ranch`.
> +	This option is only valid for the `update` command.
>
> -<path>...::
> +`<path>...`::
>  	Paths to submodule(s). When specified this will restrict the command
>  	to only operate on the submodules found at the specified paths.
> -	(This argument is required with add).
> +	(This argument is required with `add`).
>
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
>  for details.

Looks good.

>
>  SEE ALSO
> --
> gitgitgadget
