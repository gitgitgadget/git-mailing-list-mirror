Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0181446AE
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205254; cv=none; b=YgKx6OWoomJEuXA49NS34Mz0omu0e8FDrvXWzbW8a7gw1y6uwt75tn4/BGltBMVowo3oTxBDw1nPHjWdlL1WvLE3rXesmlvrtDM+aMrFte0Zk++9OpzBFiA82Ut6UDWPE/kHxIZVbUmoCXhVUb8QsbWzD0hqELFthQxw0AjU/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205254; c=relaxed/simple;
	bh=+7lW5n3epzOldg3YjweXSOTzOHKbrSph9FZZj781Whw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqeI1EQUBKJ1dkDqLW0i1L4I4O2zta9S+eiO8UcKCQSxts4DIlkniEmrKsfgPjICvtAlDn4MBWBrzVwNX9VpqcAV2yZC1yZYayBzwbxjfdjWHpI8XDbh/vDsW7Sf4kJSgDsIGYF2+017xJnD36iDYXC3us8Ve1FhE/9UpexSnOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZr7m4Cg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=riAqgt6x; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZr7m4Cg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="riAqgt6x"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id EA73E3200AFC;
	Tue,  6 Feb 2024 02:40:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 02:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707205251; x=1707291651; bh=OfKgHNYD2V
	l1/YvSAkLteepQ7sczhfw/LCZDzvOFQNY=; b=TZr7m4CgHDIAgXEH/pFnnjBC3d
	1JUHJ8P+aZBbpbuNs+YYpWLGKI+Fa2MzAZs5kYbf7jALDluTLY49IzWFtReN6Y58
	kMQl4gelC83AAUJgvzPW0Mt/KBMqY23SNkVtuO4hXXOpoNkxVpQOh5F7RwnkynjX
	lxsjbo6qQGF6lZxXN4WaQ0rkt4mPKMThe3h11kZPWVBMjAMxgMil+OPLti6p70U4
	HbK1e96XLs3xwDoEikn9UGlJBJ9/kVaLWy9oeq8gqpeP8z7fK7UOgOmXXvH8HvPm
	lw6N0KAz7PfdKZk+tpdMbHkE67PjiH9O21bXn4yo+Pr49/joKAL+DHlwKQBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707205251; x=1707291651; bh=OfKgHNYD2Vl1/YvSAkLteepQ7scz
	hfw/LCZDzvOFQNY=; b=riAqgt6xhRYpwl4A1S5hiETt9d2bP6/VgORyNWOm5ctO
	jrmese5eVdwGSnQdEfx9nVK/qbqEELG/MO3N8jnufacWOvuZkkZzyxAbMmliCm+h
	oUqwl5dilOYN7i9IjucQzNuWtstd1h+W48f2KsPjQhSoN4DPpbq5hSP+UTMvngmf
	0Gyefc8clZrt7eYa2pJ8Ni0uU9AjEo5prQBclQyq8iBzrJIoq3leQhAnpibrejKK
	6WU4AksYGPExegK2HEtfgqYyA4KJ262ba5JmMQsLfri8maLsMN3RWsirVJtC+dT9
	Eg6XPcPpP0VV6da1OD9bM2qijQHrqNi6Kbx9W13jlg==
X-ME-Sender: <xms:g-LBZcCQvR8AwEPO_f_fdsrt60EB0LkjawlGBHfhXGAqvJOhOpyUTQ>
    <xme:g-LBZeg9uQw3jsdCQ1vRlKvQBBA-CsF7Q6YRE4kf-QwA9BV-VS8XMv6ChLPUd0baR
    NdXCevQYGai89vWKw>
X-ME-Received: <xmr:g-LBZfkjvhGBu9ol-vECRS8U8bUQt5B4oBjn6VF3NUTVfo_R2XVEKUTnk6tx2kwpNv01f0qDr3OgbY26ix1zcK-Rc2eX50_rFsh9tqBcQSVvVoVq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:g-LBZSxztr7OEeLE3hVr-gnu8fs0j2DrZdfABcSQkk1IuhW3dkPPIw>
    <xmx:g-LBZRRW_K9iAH07QCmzmKGjJ_RdOa81eiDKeGDbG5-UcmIFDky-QA>
    <xmx:g-LBZdY6Hddqq7HWvm5bSOs_3ONnPbhZxHUujQz-u66YI5a2zVD5Ng>
    <xmx:g-LBZceRrAL88Mu5I7atHMjk5F62YrM4cKMSV4JgI-XLEV0ky5Nzkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 02:40:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8a3ac08f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 07:37:21 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:40:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/7] completion: new function __git_complete_log_opts
Message-ID: <ZcHigQ9ZyeUjsO-E@tanuki>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206020930.312164-6-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjbUt8L+xorVvC56"
Content-Disposition: inline
In-Reply-To: <20240206020930.312164-6-britton.kerin@gmail.com>


--tjbUt8L+xorVvC56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:09:28PM -0900, Britton Leo Kerin wrote:
> The options accepted by git-log are also accepted by at least one other
> command (git-bisect).  Factor the common option completion code into
> a new function and use it from _git_log.
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 57c6e09968..8c3b1b8e96 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2089,10 +2089,12 @@ __git_diff_merges_opts=3D"off none on first-paren=
t 1 separate m combined c dense-c
>  __git_log_pretty_formats=3D"oneline short medium full fuller reference e=
mail raw format: tformat: mboxrd"
>  __git_log_date_formats=3D"relative iso8601 iso8601-strict rfc2822 short =
local default human raw unix auto: format:"
> =20
> -_git_log ()
> +# Complete porcelain (i.e. not git-rev-list) options and at least some
> +# option arguments accepted by git-log.  Note that this same set of opti=
ons
> +# are also accepted by some other git commands besides git-log.
> +__git_complete_log_opts ()
>  {
> -	__git_has_doubledash && return
> -	__git_find_repo_path
> +        COMPREPLY=3D""

Nit: this is indented with spaces instead of tabs.

It would also be nice to mention in the commit message why we empty
COMPREPLY here. It didn't happen before either, so this is essentially
not a no-op conversion.

Patrick

> =20
>  	local merge=3D""
>  	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
> @@ -2186,6 +2188,16 @@ _git_log ()
>  		return
>  		;;
>  	esac
> +}
> +
> +_git_log ()
> +{
> +	__git_has_doubledash && return
> +	__git_find_repo_path
> +
> +	__git_complete_log_opts
> +	[ -z "$COMPREPLY" ] || return
> +
>  	__git_complete_revlist
>  }
> =20
> --=20
> 2.43.0
>=20

--tjbUt8L+xorVvC56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB4oAACgkQVbJhu7ck
PpTDkA/+PDZ1TKHCvzCGt+I5fLjAa05cIcadOYy3hhZ0tUNtVkzXBRdRIvvlZ6Pp
X7xZjgSoSldX/N+pRomLe0QASb8FA8+se4iY+lF6VRvOovWSAV9OKvB8uj01UFBF
jqGsd7OPi2j/r8ufHkzAEJctbwwHt54hQYp4OYT9Yzge+SH+XFJ0eQJMSijKLJ3T
rK1e2xqp8yUEAMlyYOBUSQ21F9xS6MFt7bJHB1syfrYG5bdRbnIKNM4Geijwo4up
AMdLx8lwsDhTsn9xJUgDiAq4semsGWr7AhnE2IJ3ehFesOY+BsjmnE+jchb/nNAM
Hp3XQ1VjneFiyRX+89/YprwR/s/4HkBmaB2e3u8hEZ4wwEuA5eaooYfpqhrleZzp
BiUQBppHeDrxqrTuyEHWdoMRw8Uzn5sIsQ365cePrBA189Oex+DWTrBuFHYPk5Pi
OdL9Kyys60pttecWCqVjUq6ncp/d9GdJwLCvpsaUJHnXhIyL0ptERHbVmnHD+tjM
dZQ59e8KXeRgERm0Lu2lcbC6p+MxljA0QanehFyY40XIeFAVsMC12AmtKzKMAiJ0
og7aVNlRPvkXWBu/6AR7nyeDr9vRkEy3NcAOVcIz7NP/FIeMYPfEfTK498ppQFbn
mp9duerNUDnkalSBCmJT0OMJSpJS3hV7GUzuEPr/jkjO7lwSsHc=
=pUKx
-----END PGP SIGNATURE-----

--tjbUt8L+xorVvC56--
