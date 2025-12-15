Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358502C11E1
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765839077; cv=none; b=ut9rQpgqrOu9teTqbOR2XVSq2SAF8Va4LcWKyvy1gyiO4hsHZAsrW8sGSzVOhGo14kOWxPrN9UAD/2GFCVvjQbkWbpnEF8Y4aVyvjpDyyqqQnFh5RnSKF7/gQEvHfQ3d9roDPGxmIOlcOF+T4hGEmTog/pnefrnvQAftCJYmLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765839077; c=relaxed/simple;
	bh=gK7vHwm4ZyK55G0YlSlLiMlUh9W1yKO/qSbig5esQtU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DMyn/fEXAlmQb5BwC467qNWbWQSAr8JEKhj1CGpTGqu9iRDGtSFAHf7rRAaXP7J3ixGinRYVKGlmZdbzTV3ICrpfVSbujj8cFp70h1NWz+oKg0TnZdd8QopTI8lGMNakFEvSCEHwoWbBbaQKrzRya1FGE1/1Mc9Gpkm7J9b7lMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ROoCQPM9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5ncGmMA; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ROoCQPM9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5ncGmMA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7092D1D00133;
	Mon, 15 Dec 2025 17:51:13 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 15 Dec 2025 17:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765839072;
	 x=1765925472; bh=9SY9Ij1MkQ1LVXmgJEw/Cwh8dW2QAXZtnGm77cPAJsA=; b=
	ROoCQPM9HuK0Frd9OxDa5BSvptrYSBeVGUGYnjUTe7APC7Or6515FVamotQwaJPS
	507HUjlKWcF8k8wTrWMeDR9Nxp/c4tc06C2bnQ9CrrxnEnDkca0IZe1b7HidfOcX
	KG9oK0xoUinkg5xQ3gQ1yKLN0cJGXCtvq4Dqj4xwUemuzcYtHq288/5N4qrhNOPo
	XoGykl3yEFk8rH532MIG9HDmnLyNekfOKnazxo3a4uKTAJ40oHTiU20GUWURcTQB
	x8hbR1PmEIXYzoNPSCfVgE1CPfxvIF6CuiiNqpKMMKPloLaESqh1Jb2SKao9WsNL
	te27ZgtEF4+JzAEgTlHSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765839072; x=
	1765925472; bh=9SY9Ij1MkQ1LVXmgJEw/Cwh8dW2QAXZtnGm77cPAJsA=; b=R
	5ncGmMAWnpyY3uE3FrVA+7Fhi9h8PFX5gNVNKgSkf50CgpXttX8fIFK5nyxhIasg
	00UpBP/bDnIxGKR5aRoS1Ekg7Nc3CqIHXTVjbTkOxM8DKPvg9KJywuu2ygE1k53F
	P9BkEKF+jlO4mQigGETCnHmS/70cZLVaAhxliCAYp4ztRQmCNcGdlT+or2IANXFW
	QpK+n2vjod6c3HucSyjgtjCmxFYh441UriYjomaPjUsrmv4h9k0N9begsAn0kOcm
	L4tUmTVgmUx3GR9lt1cgWH1r6xYKdMMhijew6R6bzwZUK5ZmiFynq03Jpwl9mVBi
	t7EVGNRJJ2W86P0mJTqfQ==
X-ME-Sender: <xms:4JBAacwZ71dWCeHMl3VT8PCByH-tECU3wAc0WK9Pos9wF5IBdlMShfg>
    <xme:4JBAabEXms3JD136Qm-oCDRwJZlb3wYzqqLq9NGYMyXPh8qmPkU2yXZdc1y-ykLgy
    ASyTU_YRb0kLxVX-5AKIzrm6sljdiJhORiBU4qiqMJ5h38pmnuL3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeifeeftdeivedu
    gfffgfegjeeiffetieettddtgffhvedtveehleetveegfedvheenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmpdgvgigrmhhplhgvrdgtohhmpdhkvghrnhgvlhdrohhrghdpihgv
    thhfrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnh
    drrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:4JBAacNLRit6xj5EiHEddNxIXYOkW0Wd8VaBMkPqlpzhgdBN1jCgbQ>
    <xmx:4JBAaav3jW9QhJ1v5RVhNW5_KjG2P1FD_uJ7JqAPiaWku6yGHIA30Q>
    <xmx:4JBAaWWR-xECG8RjkLWN_u0e_DhSiezadrWYF0QBPPJ9oLkdyhEBDA>
    <xmx:4JBAaSsna1Y0-WQMPEOTaR5RE6Ao2NCOHQHuGhYBQ91cFH1N7wAy4A>
    <xmx:4JBAacor5OJHDDRI0h6OdLvme9QQwiK7zwJ1AoIr0LNJ5-pgac9jxoqx>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1EDFF1EA0066; Mon, 15 Dec 2025 17:51:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7cBr0QabPqZ
Date: Mon, 15 Dec 2025 23:50:20 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <031d7b41-b6d3-450c-925e-cddaf2e7aa85@app.fastmail.com>
In-Reply-To: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: flock of small fixes to various documentation files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> [PATCH] doc: flock of small fixes to various documentation files

This doesn=E2=80=99t say much.

On Mon, Dec 15, 2025, at 21:23, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> While translating the Git documentation into French, I noticed several=
 small
> issues in various files. This commit addresses these issues to improve=
 the
> overall quality and consistency of the documentation.

This paragraph doesn=E2=80=99t add any relevant information. The followi=
ng
bullet list would be fine on its own. That it was stumbled upon while
doing X is typical below the three-dash/hyphen line info.

Any code/doc change aims to improve the overall quality.

>  * enforce consistent imperative mood in option descriptions
>  * lighten wording in several places for clarity
>  * add missing parameters
>  * fix minor asciidoc markup issues

I also use bullet-list commits sometimes. (And it=E2=80=99s cousin: =E2=80=
=9CLet=E2=80=99s
also...=E2=80=9D) But this commit does two things:

=E2=80=A2 Change prose: imperative mood, lighten wording
=E2=80=A2 Fix mistakes source formatting:
  =E2=80=A2 Correct markup
  =E2=80=A2 Add missing paren
  =E2=80=A2 Split up markup of options: `-f`/`--force`
  =E2=80=A2 Weird indent

Could this fruitfully be split into at least two commits?

I just think these are two different categories.

Is that just an academic concern? Well, in my experience it is very
pleasant to pickaxe through a snippet of text, stumble upon clearly
marked commits like

=E2=80=A2 Use USA spelling
=E2=80=A2 Fix articles (the/a/an)
=E2=80=A2 *: typos

and just race past them. Because I am looking for the original
motivation for some phrasing (say), typos and missing articles and all,
and these commits are simple to bunny hop. But here, fixing a missing
parentheses is mixed together with

    Replace: less than `<n>`, where `<n>` represents a number of bytes,
    With: less than `<n>` bytes

And now I might have to pause and think which implicated change this is
about for my purposes; a subjective-but-good change or a
fix-objective-mistake change. Because that matters when I want to know
why the text is phrased in a certain way.

>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>     doc: flock of small fixes to various documentation files
>
> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-2016%2Fjnavila%2Fd=
oc_small_fixups-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-2016/jnavila/doc_small_fixups-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2016
>
>  Documentation/git-checkout.adoc   |  2 +-
>  Documentation/git-rebase.adoc     |  2 +-
>  Documentation/git-repack.adoc     |  6 +++---
>  Documentation/git-send-email.adoc | 26 +++++++++++++-------------
>  Documentation/git-worktree.adoc   |  2 +-
>  5 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/git-checkout.adoc b/Documentation/git-check=
out.adoc
> index 6f281b298e..43ccf47cf6 100644
> --- a/Documentation/git-checkout.adoc
> +++ b/Documentation/git-checkout.adoc
> @@ -509,7 +509,7 @@ ARGUMENT DISAMBIGUATION
>  -----------------------
>
>  When you run `git checkout <something>`, Git tries to guess whether
> -`<something>` is intended to be a branch, a commit, or a set of file(=
s),
> +_<something>_ is intended to be a branch, a commit, or a set of file(=
s),
>  and then either switches to that branch or commit, or restores the
>  specified files.

Correct markup since this is a `synopsis` document. Good.

>
> diff --git a/Documentation/git-rebase.adoc
> b/Documentation/git-rebase.adoc
> index 9742833ebe..e177808004 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -87,7 +87,7 @@ of the to-be-rebased branch. However, `ORIG_HEAD` is
> not guaranteed to still
>  point to that commit at the end of the rebase if other commands that
> change
>  `ORIG_HEAD` (like `git reset`) are used during the rebase. The
> previous branch
>  tip, however, is accessible using the reflog of the current branch
> (i.e. `@{1}`,
> -see linkgit:gitrevisions[7].
> +see linkgit:gitrevisions[7]).

Add missing end-paren. Good.

*Could* maybe also replace the comma with a semicolon?

    i.e. `@{1}`; see ...

>
>  TRANSPLANTING A TOPIC BRANCH WITH --ONTO
>  ----------------------------------------
> diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.=
adoc
> index d12c4985f6..673ce91083 100644
> --- a/Documentation/git-repack.adoc
> +++ b/Documentation/git-repack.adoc
> @@ -77,14 +77,14 @@ to the new separate pack will be written.
>  	Only useful with `--cruft -d`.
>
>  --max-cruft-size=3D<n>::
> -	Overrides `--max-pack-size` for cruft packs. Inherits the value of
> +	Override `--max-pack-size` for cruft packs. Inherits the value of
>  	`--max-pack-size` (if any) by default. See the documentation for
>  	`--max-pack-size` for more details.

Imperative mood.

>
>  --combine-cruft-below-size=3D<n>::
>  	When generating cruft packs without pruning, only repack
> -	existing cruft packs whose size is strictly less than `<n>`,
> -	where `<n>` represents a number of bytes, which can optionally
> +	existing cruft packs whose size is strictly less than `<n>`
> +	bytes, which can optionally
>  	be suffixed with "k", "m", or "g". Cruft packs whose size is
>  	greater than or equal to `<n>` are left as-is and not repacked.
>  	Useful when you want to avoid repacking large cruft pack(s) in

Here drop a wordy =E2=80=9Cwhere `<n>` represents a number of bytes=E2=80=
=9D clause in
favor of just =E2=80=9C<n> bytes=E2=80=9D.

> diff --git a/Documentation/git-send-email.adoc
> b/Documentation/git-send-email.adoc
> index 263b977353..cdaf421cda 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -208,7 +208,7 @@ Sending
>  	for your own case. Default is the value of `sendemail.smtpEncryption=
`.
>
>  --smtp-domain=3D<FQDN>::
> -	Specifies the Fully Qualified Domain Name (FQDN) used in the
> +	Specify the Fully Qualified Domain Name (FQDN) used in the
>  	HELO/EHLO command to the SMTP server.  Some servers require the
>  	FQDN to match your IP address.  If not set, `git send-email` attempts
>  	to determine your FQDN automatically.  Default is the value of

Imperative mood.

> @@ -245,7 +245,7 @@ a password is obtained using linkgit:git-credentia=
l[1].
>  	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`.
>
>  --smtp-server=3D<host>::
> -	If set, specifies the outgoing SMTP server to use (e.g.
> +	Specify the outgoing SMTP server to use (e.g.
>  	`smtp.example.com` or a raw IP address).  If unspecified, and if
>  	`--sendmail-cmd` is also unspecified, the default is to search
>  	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
> @@ -258,7 +258,7 @@ command names.  For those use cases, consider using

Imperative mood and drop =E2=80=9CIf set=E2=80=9D.

We can see in the resulting file that many commands use this =E2=80=9CSp=
ecify=E2=80=9D
start. Not a mix of =E2=80=9CSpecify=E2=80=9D and =E2=80=9CIf set, ...=E2=
=80=9D.

Although see also the positive/negative options that start with =E2=80=9C=
If this
is set,=E2=80=9D. Maybe unrelated to this change, but maybe they could be
rephrased with less =E2=80=9Cif set=E2=80=9D ceremony. Relevant:

https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

> `--sendmail-cmd`
>  instead.
>
>  --smtp-server-port=3D<port>::
> -	Specifies a port different from the default port (SMTP
> +	Specify a port different from the default port (SMTP

Same.

>  	servers typically listen to smtp port 25, but may also listen to
>  	submission port 587, or the common SSL smtp port 465);
>  	symbolic port names (e.g. `submission` instead of 587)
> @@ -266,7 +266,7 @@ instead.
>  	`sendemail.smtpServerPort` configuration variable.
>
>  --smtp-server-option=3D<option>::
> -	If set, specifies the outgoing SMTP server option to use.
> +	Specify the outgoing SMTP server option to use.

Same.

>  	Default value can be specified by the `sendemail.smtpServerOption`
>  	configuration option.
>  +
> @@ -277,7 +277,7 @@ must be used for each option.
>  --smtp-ssl::
>  	Legacy alias for `--smtp-encryption ssl`.
>
> ---smtp-ssl-cert-path::
> +--smtp-ssl-cert-path <path>::
>  	Path to a store of trusted CA certificates for SMTP SSL/TLS
>  	certificate validation (either a directory that has been processed
>  	by `c_rehash`, or a single file containing one or more PEM format

Add parameter. Makes sense.

> @@ -347,11 +347,11 @@ Automating
>  --no-to::
>  --no-cc::
>  --no-bcc::
> -	Clears any list of `To:`, `Cc:`, `Bcc:` addresses previously
> +	Clear any list of `To:`, `Cc:`, `Bcc:` addresses previously
>  	set via config.

Imperative mood.

>
>  --no-identity::
> -	Clears the previously read value of `sendemail.identity` set
> +	Clear the previously read value of `sendemail.identity` set

Ditto. And these two look like the only relevant `--no` options. So this
looks consistent.

>  	via config, if any.
>
>  --to-cmd=3D<command>::
> @@ -510,12 +510,12 @@ have been specified, in which case default to `c=
ompose`.
>  	Currently, validation means the following:
>  +
>  --
> -		*	Invoke the sendemail-validate hook if present (see linkgit:githoo=
ks[5]).
> -		*	Warn of patches that contain lines longer than
> -			998 characters unless a suitable transfer encoding
> -			(`auto`, `base64`, or `quoted-printable`) is used;
> -			this is due to SMTP limits as described by
> -			https://www.ietf.org/rfc/rfc5322.txt.
> +* Invoke the sendemail-validate hook if present (see linkgit:githooks=
[5]).
> +* Warn of patches that contain lines longer than
> +  998 characters unless a suitable transfer encoding
> +  (`auto`, `base64`, or `quoted-printable`) is used;
> +  this is due to SMTP limits as described by
> +  https://www.ietf.org/rfc/rfc5322.txt.
>  --

Non-functional change it seems. This looks better in the source. 2=E2=80=
=933
tabs were not needed here.

>  +
>  Default is the value of `sendemail.validate`; if this is not set,
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-workt=
ree.adoc
> index f272f79783..d74ad7b0e9 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -104,7 +104,7 @@ associated with a new unborn branch named _<branch=
>_ (after
>  passed to the command. In the event the repository has a remote and
>  `--guess-remote` is used, but no remote or local branches exist, then=
 the
>  command fails with a warning reminding the user to fetch from their r=
emote
> -first (or override by using `-f/--force`).
> +first (or override by using `-f`/`--force`).

Fix inline-verbatim since you are quoting two options/switches. So the
`/` does not go inside the (`). Good.

>
>  `list`::
>
>
> base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
> --
> gitgitgadget

`doc-diff` also looks good.
