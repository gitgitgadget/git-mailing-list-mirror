Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CB46AF
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647895; cv=none; b=bbRvk1AVlY088WP9gO4sYC7VSUtIaqS6tEo2F95hkK4BffeUecSsMWHgARywGafVN819padYwsCcoFuK/OuGkesyKFEhPMowJ18PCKSeyVp2hH3E3XnzSjunQ1pns/xynUYWYG5KaJg/SJ6yPnah8htYlw+u5rhG5cpMPz9ncRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647895; c=relaxed/simple;
	bh=AXfKWMxunPcHMxQfBMk39Xz/xwCP6kCE1MD7SLwnrEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jY1mcXcQ6oRXfcduj1aIWJTTJ+HlgKJ7O2yR1ugY+7AdjrzLNFc6FbzeZXyivNnrQ0h049GH36poqfI9Y1wGyfREMmuZf46fpUNlzEjSP5ylI7Uk+JOM63myJQz/i1dORG7An4tD7wgarqFtlpZYuGbtTJuNEgsv/UUbTFXd6/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ahzTe2hl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJmPtZEE; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ahzTe2hl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJmPtZEE"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 183333200AD6;
	Fri, 19 Jan 2024 02:04:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 02:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705647892; x=1705734292; bh=PQlFgjurEq
	ai+cUbfg08TntR+fssY0P2rLQxqdykNuU=; b=ahzTe2hltYKFA4AANtaaTVuLLb
	Jm7oa/5ydyn/3RdYgCP3/yFuMAUUtqcN7or/2jdlqbklCz7x8pdTmF26N1LNM6po
	44PvX2L4qCUsHnPYoHzWA6/Cfc7Y7M4O8fmQ2HRjOryhGNO39FqRunmEZ2LjPLkN
	yLb2G5xdQSn1fypaNeGBUEVxuM4icxhnu0NWCnBcQ++qmwDVTPGyHSfYPNb7lmut
	FSbOlu9AEG+x+6Mxpq3ubPm/iiVfWfje16JGJw7E8rzy+lfaHJUuWTwUh54rafY4
	j7YMXautnwZu+H0bExp1+HTx5suBxU88tiyd2LYIIYuR3UUMfIkdjvhFUSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705647892; x=1705734292; bh=PQlFgjurEqai+cUbfg08TntR+fss
	Y0P2rLQxqdykNuU=; b=NJmPtZEEpjCGjXNlS+Y8qzMSPvkCwUX/ecui+JcetvfH
	/bq1k7iS9EbUsyt6Fc7QhSI/YDXVbsJLHOrYRNfOeABspOJOiXMTMUX0BEq5m3gB
	JpJc9CVadnjihlwUomiTYE9Dtkq4vnhimK5zTIer65NnhJA/yhLPIFqQBC2iTo7b
	4VUvl7N2ex+B4J1ZBFKj0fgwgh71L7DczHlxig+9JkFGV7DdysXjppxPahBIB/kx
	WmGtYSI0ttkloUfpULtl+brJvxxO5W4HTRmIXujflOF4yMtGR8fwo7GNWx8ZbPTo
	UfcDquuSp4c76IpyA5rtTQnBk2y3Kikwolz3KY+K7g==
X-ME-Sender: <xms:FB-qZVLu-PKLI4HaroNq0jL4jM4x76MAe8Iw1quI8hDyiPC4SiXaQw>
    <xme:FB-qZRJBqTE2C_U7JkneFDU9QWZZwPoqUDtxQlQFS_j3hZdjCLG38iA7gdHbrTLvA
    91-s8J3PB90AysZvA>
X-ME-Received: <xmr:FB-qZds4f8X4nRewkpGBVdbwBgtyTo9x_LHWwjPlyJ0T-mqeqIzW0bl4OiYQvJBcsUUCigz4ylMTmub2rtY0UQiOJsgQtxDwpHMAqRb0wAJaxghmbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:FB-qZWZjB_2P6plyuHnIt7m8ieFVAIt8R2tuE7chqM0PxYR24Xcc9g>
    <xmx:FB-qZca6vrGW_Or7T-1OTe0Qe7OBcDN66NdDixP9yk5sieiEI2IUwg>
    <xmx:FB-qZaAGcm0yoJbbLJ9N87kdQk0rMPLytOXIfij70S7g1rrFr4uHsQ>
    <xmx:FB-qZXw1xQcrF7wCcc4Oq2IhjnN2gq8ENcBeTFlcqssOzEPwO05B4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 02:04:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fe2715e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 07:01:55 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:04:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] completion: git-log opts to bisect visualize
Message-ID: <ZaofEq0tqMj3kjdb@tanuki>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240118204323.1113859-3-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HN2Z9MmnNEKla1A+"
Content-Disposition: inline
In-Reply-To: <20240118204323.1113859-3-britton.kerin@gmail.com>


--HN2Z9MmnNEKla1A+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:43:20AM -0900, Britton Leo Kerin wrote:

Proposal for the commit subject: "completion: complete log opts for
git-bisect visualize".

> To do this the majority of _git_log has been factored out into the new
> __git_complete_log_opts.

We typically do not continue the commit message as if the commit subject
was the first line of the message. An introduction like the following
would help to set the stage:

    Arguments passed to the "visualize" subcommand of git-bisect(1) get
    forwarded to git-log(1). It thus supports the same options as
    git-log(1) would, but our Bash completion script does not know to
    handle this.

> This is needed because the visualize command
> accepts git-log options but not rev arguments (they are fixed to the
> commits under bisection).
>=20
> __git_complete_log_opts has a precondition that COMPREPLY be empty.  In
> a completion context it doesn't seem advisable to implement
> preconditions as noisy or hard failures, so instead it becomes a no-op
> on violation.  This should be detectable and quick to debug for devels,
> without ever aggravating a user (besides completion failure).
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 30 +++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 15d22ff7d9..c16aded36c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1472,6 +1472,16 @@ _git_bisect ()
>  			;;
>  		esac
>  		;;
> +	visualize)
> +		case "$cur" in
> +		-*)
> +			__git_complete_log_opts
> +			return
> +			;;
> +		*)
> +			;;
> +		esac
> +		;;

Is this switch even needed? Can't we call `__git_complete_log_opts`
directly?

>  	esac
> =20
>  	case "$subcommand" in
> @@ -2074,10 +2084,14 @@ __git_diff_merges_opts=3D"off none on first-paren=
t 1 separate m combined c dense-c
>  __git_log_pretty_formats=3D"oneline short medium full fuller reference e=
mail raw format: tformat: mboxrd"
>  __git_log_date_formats=3D"relative iso8601 iso8601-strict rfc2822 short =
local default human raw unix auto: format:"
> =20
> -_git_log ()
> +
> +# Check for only porcelain (i.e. not git-rev-list) option (not argument)
> +# and selected option argument completions for git-log options and if any
> +# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
> +# and will be empty on return if no candidates are found.

Why do we need to enforce that COMPREPLY is empty? None of the other
`__git_complete_*` helpers do this, so I think it's fair to expect that
the variable woulld get clobbered when calling the new function. Thus, I
don't think there's a need for this precondition.

> +__git_complete_log_opts ()
>  {
> -	__git_has_doubledash && return
> -	__git_find_repo_path
> +	[ -z "$COMPREPLY" ] || return 1   # Precondition
> =20
>  	local merge=3D""
>  	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
> @@ -2171,6 +2185,16 @@ _git_log ()
>  		return
>  		;;
>  	esac
> +}
> +
> +_git_log ()
> +{
> +	__git_has_doubledash && return
> +	__git_find_repo_path

I was about to say that it would make more sense to call
`__git_find_repo_path` in `__git_complete_log_opts` so that all prereqs
are fulfilled whenever the latter is called. But `__git_complete_relist`
doesn't know to find the repo path in all cases, so that wouldn't quite
work alright.

Patrick

> +        __git_complete_log_opts
> +        [ -z "$COMPREPLY" ] || return
> +
>  	__git_complete_revlist
>  }
> =20
> --=20
> 2.43.0
>=20

--HN2Z9MmnNEKla1A+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqHxEACgkQVbJhu7ck
PpRDmRAAqIxvxVEJMxrYFWkXTuzUJmo3QnVhQAGRVo54SCSiaUjG3BLsiIm6AE/o
bUY0O6+9h9BOwkjKiTHTXZKjU6yGxbRxl/SoXQ65TB/OqxBDt4BvZSNdYEw/1Vrq
XQ10szr2qRY49VUl12LUY8tzIidGB0DuDqYyaWeMIhfrdmz+nhormtC1/sB59Gqj
xWwhmSfNFnPRpLW8wOxO58AbaY32I8Sh57Zf3eWM9fykmMZ6AR0PV7r5TNoA5Osl
XzHWnnBBdTFHLuh02DQK9yPxIq2fHIJnZQOIf2On7Gwte2c9K7b96YDofDNxXjSO
KiaLl87QvGRD6dlLfePBLE+I+FLFzKCBJoA4qlt6E/a2GX4NkKLNn1HIGkT8gpGb
hqxL7NQW/YVwtWe34/geM/q63Jse1UR5ZC/OGRlnwlZXV3+p3Ie7EbsUdAnjTFgR
b4bU6c/6LMILir5s2qNWpTVWL5s8NXwI1Z7/i3wHLBth6Ljom9UYT+rbs7dHJcl+
nWrrBduzTRypNo8+0JKu0o5LReu5JLuYurwy7pXgcINMgpJuxvdrL+0xQtK68kAb
zBLeiBDNpKIrdA24ZH3jaAzq0myp6D+EKenvBmBwtmC4kNAL2ld1Cv1GZe6WzIa7
o5GItSNmV1Ag2L5WXDve3+78BTMx2SYHKmx6miGcSPmaCRP/ffw=
=1o1i
-----END PGP SIGNATURE-----

--HN2Z9MmnNEKla1A+--
