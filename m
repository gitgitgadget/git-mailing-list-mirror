Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B105467C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022117; cv=none; b=AYp3IfWnMWe5ViQd6OSiKubHqyHqKrbgE5/FpVVzEundEnNVdQrxz4Ala8l/HdaikH/HI4qSApInIemCc4VJx5qKPEdMlA0M9srIuQggtIqI90g5qh0ghf5S5Mtd9eTE4mWSaPXOEXtQAPKQIPaGif4kLkMObefyhX4DnvJN+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022117; c=relaxed/simple;
	bh=ihDLA2G7F2vxrCCHtFFmMN9RAG0SEl2NNZeMTLVhHL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdEBuqZ+G6sFaNj1HZAcOgn1ZDycEqG+HqyywmVlSIqky68+HpyZ+2/Q58ClvRsRbVw7nS1cuVlsbo+cnw0XbEq98SbbTTs0l8QD+bDjXcoM2RaTsoxyo+n/IylNh77IkCtJoLBtnAG0ck7ponxgOtuBV0/vTLGwrG2cjK4UELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ReW5ZZDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NIPSbCRE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ReW5ZZDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIPSbCRE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 71A0413800E7;
	Tue, 27 Feb 2024 03:21:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Feb 2024 03:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709022114; x=1709108514; bh=q1/Ovk8623
	Znjfwal4V5i3lxIO+5l5WA9RhWMmp8sw0=; b=ReW5ZZDZ9V5evumXXquU3W6xbR
	jg9v82TB8AuCO3CAmjQC4+yIuyypMdfFa/nuYhSmssUaZcbas/epB3b5ZQUHScvi
	guJXElLxNWNC1O/64fQFO90VRlow33LE5M6bzajFPPv5vug+YoBu/m5Tp7nRsb82
	7mxEuCtwMSYUrtOEoq/8xdKqK5J2cz/wMWJqYERaLMaN4EJW6sPT+mKCWbrIgWe7
	56KJU8fnCDy380XXmUOXqvSQlN2UScmBw7MWvj4wxzmv+2tocpO/wz4yZa6hcfBJ
	8ZaWMe1r4METDmxXJ/85A4HAUF6QyVNbfbebCjyd2Di2Gi+6oDeYgY4k5faQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709022114; x=1709108514; bh=q1/Ovk8623Znjfwal4V5i3lxIO+5
	l5WA9RhWMmp8sw0=; b=NIPSbCREEI8GvmcmlviJFttyWwtAYjnO1UPQOyhAYeLg
	31hxiHhOrTXw5AJCEpzhEnaD1pBEYC12p+xatiV3Bbh+bpb96hONOfHtUTywkkO8
	6ySkKSbbdc90uI+ZLwQiC/Oko7XveNUV4GH4WtRd8a1cR3qUF9uJAvmGJtzeumcu
	I3vkuM4zSl9ra+KNaZYcdILc2KUv+RBzkfkn8YqS7Iwk73NpeLGg0jJbQ+zFkaRX
	UF7ADr0CPdzwUCS1rXtPsKKRTPfg5SrpFaKvMquYcWIPOjLOAKVA+7vSl0isRZo6
	fyP4SU3IUUo1q1qcdH1A64XqPKNFk/ux/FZ1fPhhxQ==
X-ME-Sender: <xms:opvdZUDC5_k3aVThkhMpIFLmn14bMPzF3oDK8pEsXycudahDVmWoBg>
    <xme:opvdZWhRKXs_nOdh2zfrwdpVY5kJl8oVuj5B7-2yPp-RwNm9MJVcBCJsx6jf6kYWn
    _qhKgmj2Iuz6EPKCw>
X-ME-Received: <xmr:opvdZXlx-8LvEYf7n6uEhcIz3plmMCBiSTY5D_0IvL6mk1Q1Pn4JMYAjaQff-7tVpTI5X7bAG6gM47ApPfyj7pIGSMtyqFg2Ueaf1-65Z-YdgE5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfedvleefueetgeeitdekheelffekkefgffduhfduvdefffdtheekiefhkeejkeeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:opvdZaxycbsRlakPYTR9t7zgLI21p8dIdnVcNrbbrcHG6wlrZpwHnQ>
    <xmx:opvdZZQfKNcjQfLtrjJkAz_nIN7aL5wnBwQOnrrrA2OsyeO4pBrvmA>
    <xmx:opvdZVYGy50btS8Om7pvgK_RA6dJRPPCUK9MNS9nVr18D4Mvvi_5RQ>
    <xmx:opvdZUcL-OCea-fFuUu9CcJwgyLLCCY2r3ySUVF09VrHJJw3bLfR7Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 03:21:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7896b68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 08:17:33 +0000 (UTC)
Date: Tue, 27 Feb 2024 09:21:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] completion: fix __git_complete_worktree_paths
Message-ID: <Zd2bnJZtgW2tFMFn@tanuki>
References: <a1561e02-40dc-4ac3-ae7a-666db0f810ed@gmail.com>
 <eaf3649e-30cf-4eba-befa-5be826c828a8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gqbK8V8AKxALhPMO"
Content-Disposition: inline
In-Reply-To: <eaf3649e-30cf-4eba-befa-5be826c828a8@gmail.com>


--gqbK8V8AKxALhPMO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:53:31AM +0100, Rub=E9n Justo wrote:
> Use __git to invoke "worktree list" in __git_complete_worktree_paths, to
> respect any "-C" and "--git-dir" options present on the command line.
>=20
> Signed-off-by: Rub=E9n Justo <rjusto@gmail.com>
> ---
>=20
> I stumbled upon this in a situation like:
>=20
>    $ git init /tmp/foo && cd /tmp/foo
>    $ git worktree add --orphan foo_wt
>=20
>    $ git init /tmp/bar && cd /tmp/bar
>    $ git worktree add --orphan bar_wt
>=20
>    $ cd /tmp/foo
>    $ git -C /tmp/bar worktree remove <TAB>
>    ... expecting /tmp/bar/wt, but ...
>    $ git -C /tmp/bar worktree remove /tmp/foo_wt
>=20
> In this iteration, v2, some tests are included.
>=20
> The function __git was introduced in 1cd23e9e05 (completion: don't use
> __gitdir() for git commands, 2017-02-03).  It is a small function, so
> I'll include here to ease the review of this patch:
>=20
> 	# Runs git with all the options given as argument, respecting any
> 	# '--git-dir=3D<path>' and '-C <path>' options present on the command li=
ne
> 	__git ()
> 	{
> 		git ${__git_C_args:+"${__git_C_args[@]}"} \
> 			${__git_dir:+--git-dir=3D"$__git_dir"} "$@" 2>/dev/null
> 	}
>=20
>=20
>  contrib/completion/git-completion.bash |  2 +-
>  t/t9902-completion.sh                  | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 444b3efa63..86e55dc67f 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3571,7 +3571,7 @@ __git_complete_worktree_paths ()
>  	# Generate completion reply from worktree list skipping the first
>  	# entry: it's the path of the main worktree, which can't be moved,
>  	# removed, locked, etc.
> -	__gitcomp_nl "$(git worktree list --porcelain |
> +	__gitcomp_nl "$(__git worktree list --porcelain |
>  		sed -n -e '2,$ s/^worktree //p')"
>  }
> =20
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index b16c284181..7c0f82f31a 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1263,6 +1263,30 @@ test_expect_success '__git_complete_fetch_refspecs=
 - fully qualified & prefix' '
>  	test_cmp expected out
>  '
> =20
> +test_expect_success '__git_complete_worktree_paths' '
> +	test_when_finished "git worktree remove other_wt" &&
> +	git worktree add --orphan other_wt &&
> +	run_completion "git worktree remove " &&
> +	grep other_wt out
> +'
> +
> +test_expect_success '__git_complete_worktree_paths - not a git repositor=
y' '
> +	(
> +		cd non-repo &&
> +		GIT_CEILING_DIRECTORIES=3D"$ROOT" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		test_completion "git worktree remove " "" 2>err &&
> +		test_must_be_empty err
> +	)
> +'

If I understand correctly, we assume that the repo isn't detected here,
and thus we will fail to complete the command. We don't want an error
message though, which we assert. But do we also want to assert that
there is no output on stdout?

> +
> +test_expect_success '__git_complete_worktree_paths with -C' '
> +	test_when_finished "rm -rf to_delete" &&

What does this delete? I don't see "to_delete" being created as part of
this test.

> +	git -C otherrepo worktree add --orphan otherrepo_wt &&
> +	run_completion "git -C otherrepo worktree remove " &&
> +	grep otherrepo_wt out

And as far as I can see, we don't write to "out" in this test, either.
So I think we're accidentally relying on state by the first test here.

Patrick

> +'
> +
>  test_expect_success 'git switch - with no options, complete local branch=
es and unique remote branch names for DWIM logic' '
>  	test_completion "git switch " <<-\EOF
>  	branch-in-other Z
> --=20
> 2.44.0.1.g0da3aa8f7f
>=20

--gqbK8V8AKxALhPMO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXdm5sACgkQVbJhu7ck
PpQRFw/9FetCaC7p+tSxXb9XW/wFokMnqjTN3KwnmVDuWM01l9r2gvpVyxjctfzD
mMR35TftQXn53f6hzDv1MK9LfcPJl/OAx0OT13o9qonVJ2sn+PYXsOsQG9L+CTlY
eHoOa07povCbZCtZehwE0n9SMm5ntzGD81BJZ9fDUDW72/Gqe+GQY4+pwOqNskka
KKBeYiThLN14sD+l1YQwcIlDFAKhpfyZifFgpr5S+iD/wVxqvbrfO+CQN/ooNJpD
MUP7tmfUAgfVBGtXTYB8GeTN8I1g+LHkTeFWiabzPrmT6q28Gwbs2WiCQViJ+BIL
yV6f/SJIg0/lDsHCzIlcCC61xI58xsmH7H8fs8ELSe5A9KN+fd8VDSYuM+qCrK/H
ygKZy10+6GTIhYozubAaXaji0nAK4MpCNVoK/w5hPix4IL5ECeaTqyep6gyvnA56
hbCZpF5IWIHucCVebpSa5cIdIKurGqTBlAnz473Qpaudrb7nuaw/4P8YsnJhykCc
pJk2CqNFL72lA1jUzS8K8vGmVl2a7a/x5kmCkYCOLA8hhisWelV9qXEk/DQmnRL0
bDNjdmghqQ5GwvK2ORRky7uQea4W9j6thnKl9ADwa+bcI7LkBCq57DjUup+4byC7
DEyjZNGReXCkGZJkPtGu9/9atuAmSaUnbRlj+5ZjTXPkt6dQezI=
=IHTH
-----END PGP SIGNATURE-----

--gqbK8V8AKxALhPMO--
