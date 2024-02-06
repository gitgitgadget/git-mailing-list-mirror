Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FC77F2A
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196007; cv=none; b=DONi/bVUTrgE9d5Lh72ZSjCeWDURKPXp4EOTMJ7EW3Iw2MGXI+JM1F+K2pjMPWH9E1aRQ44g/bNAr9Gxli6vvwqnZ/1VdiaRQk5O+J9H+n8P8GKukMGtLHmdEJkfVinTWe3ORnt5B1rnV6LT+sfYFWATn2ULfjyU5bv1PtXiRhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196007; c=relaxed/simple;
	bh=FqI54X0emVYbpFQWdiL5DIdhDrjhY6lWGjjxmqW0ZvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+UceYbanib+loriGwGFkDIKSy9Fi5CUa/UX2GVMmSk+b4NYRPzuXy/aDvCJuq5IDUUWRtuBJ4Qai6Lakf54d2Kr3fKiDA1U45DbwIpmLw1CzkM7uqJQtwJg5dNJ/Jh8aSgYj4g1nvVSQRBeEHxKdIx+XWaLrqhy4K/83BQufKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dv2PdQCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rr1YT6ac; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dv2PdQCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rr1YT6ac"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 03E5611400B5;
	Tue,  6 Feb 2024 00:06:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Feb 2024 00:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707196002; x=1707282402; bh=OvhtI3ukL0
	SMzXSpxf9wV5rVe+brISZqPdQ2QuTTn6k=; b=Dv2PdQCQBo4oOGzscvx2lRmH68
	IIQBCp+5wYtfKxInN6CzIyh5OjUoKcnt+r95WYW5e8vAtuoECSF4DFHGkSKxGlXl
	BXFehnIGBfDI6aLteSFTQcUfAcnMU1QNz0llnpO5Xn0hClYVdNb/xj6iE0rSUi2E
	sy/awiVynkQtpAB+n4w61IZvZ/U69j+liOvRok3NaAq6PkOf06PBBdZoTNEaCdTe
	dS6qHsoyepaYBSCkf7iTdbthsu8OZ89xSPdpIiMQsqpZRKU/rJrDToI/thRYAucW
	ZlAhpewWWgtEcTnrEjEWeFjOkT75Qpir0NKSsaqpJBqhLggHo2Ri0gZi0b3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707196002; x=1707282402; bh=OvhtI3ukL0SMzXSpxf9wV5rVe+br
	ISZqPdQ2QuTTn6k=; b=Rr1YT6ac+5ixmYloDLQcV1/baLFt0RgQQ8IrU1OSb0aD
	pzYAQTKjnggv9fZCaEhoCk1rJ7WMY6EEOakjOmgcSx17qbF4q2hnYrqxBx80fvGP
	wRsrVqX1SHUrrIEVCzEhhQcG6CTlOHgrgp1YSc/OBNtp82wT+Pc+pZKod6TTf8GQ
	qAXHxU01KH6tZZbtKnm4ONwdm1XDVIm3ZM6eNMy6Dh/re1rhjcemm4cYO/VDvRAc
	CcTvC+JgD+B8j3PdFz/+7qPaSvdIrJ1xgGQPIsWG4SVq/L4dzNsk7yEcQBp6mTWO
	AmxbA6KRJ5HN4WfZjEMuHFrjMPvK6/D9sG//H6cXgA==
X-ME-Sender: <xms:Yr7BZfc8gp2q-H73uhKbE885ovGjq8wIwISQZlBi13MIJtZSImikEQ>
    <xme:Yr7BZVP748CcXI3B_yLSHNX5I7bXF_UXaHysJhOFSIp50fDJ62OqXcul7nJzFxI04
    VnuO2DL-f5MyNY8Dg>
X-ME-Received: <xmr:Yr7BZYjswpap-JGK2XpltBdHtzmAIep16Rm281S21RygpvfOlTNwDmxaO6Zkt1sWnd0LQ-VAePhvEszqwC69eOx3cfOQHSBR0_CexKNJhX32GXKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfedvleefueetgeeitdekheelffekkefgffduhfduvdefffdtheekiefhkeejkeeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Yr7BZQ9SxJOA-Xm7B1KlFwnd8HwhJqaFkdKZwBtLlDQCn9xA81cLWQ>
    <xmx:Yr7BZbsuaDBTIgOp0XNLKwd1kCJyr-RBh7FMgccmrgX5d511hdky0A>
    <xmx:Yr7BZfGDovXMYLuGa2sK7tH5kLNK6Mkd-9bN2rD8qcgzDWSuH-RDOQ>
    <xmx:Yr7BZbIWY0CpAFx86MPTzCBZaF2Tv7vpOeFt0AA9DmsbddIbzgTEug>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 00:06:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74829721 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 05:03:09 +0000 (UTC)
Date: Tue, 6 Feb 2024 06:06:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org, moti sd <motisd8@gmail.com>
Subject: Re: [PATCH] builtin/stash: report failure to write to index
Message-ID: <ZcG-XVZxSWKvrzqL@tanuki>
References: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>
 <2cd44b01dc29b099a07658499481a6847c46562d.1707116449.git.ps@pks.im>
 <f07d33e4-5595-43e3-838e-fd89c5621485@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xV7uJLsu+mp7jhp+"
Content-Disposition: inline
In-Reply-To: <f07d33e4-5595-43e3-838e-fd89c5621485@gmail.com>


--xV7uJLsu+mp7jhp+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 11:22:01PM +0100, Rub=E9n Justo wrote:
> On 05-feb-2024 08:01:04, Patrick Steinhardt wrote:
> > The git-stash(1) command needs to write to the index for many of its
> > operations. When the index is locked by a concurrent writer it will thus
> > fail to operate, which is expected. What is not expected though is that
> > we do not print any error message at all in this case. The user can thus
> > easily miss the fact that the command didn't do what they expected it to
> > do and would be left wondering why that is.
> >=20
> > Fix this bug and report failures to write to the index. Add tests for
> > the subcommands which hit the respective code paths.
> >=20
> > Note that the chosen error message ("Cannot write to the index") does
> > not match our guidelines as it starts with a capitalized letter. This is
> > intentional though and matches the style of all the other messages used
> > in git-stash(1).
>=20
> Your message made me curious, so I ran:
>=20
>    $ git grep -E '(die|error)\(' builtin/stash.c
>   =20
>    builtin/stash.c:168:               die(_("'%s' is not a stash-like com=
mit"), revision);
>    builtin/stash.c:214:               return error(_("%s is not a valid r=
eference"), revision);
>    builtin/stash.c:261:               return error(_("git stash clear wit=
h arguments is "
>    builtin/stash.c:303:               return error(_("unable to write new=
 index file"));
>    builtin/stash.c:487:                                       die("Failed=
 to move %s to %s\n",
>    builtin/stash.c:523:               die(_("Unable to write index."));
>    builtin/stash.c:544:               return error(_("cannot apply a stas=
h in the middle of a merge"));
>    builtin/stash.c:555:                               return error(_("cou=
ld not generate diff %s^!."),
>    builtin/stash.c:562:                               return error(_("con=
flicts in index. "
>    builtin/stash.c:569:                               return error(_("cou=
ld not save index tree"));
>    builtin/stash.c:610:               ret =3D error(_("could not write in=
dex"));
>    builtin/stash.c:630:               ret =3D error(_("could not restore =
untracked files from stash"));
>    builtin/stash.c:702:               return error(_("%s: Could not drop =
stash entry"),
>    builtin/stash.c:721:               return error(_("'%s' is not a stash=
 reference"), info->revision.buf);
>    builtin/stash.c:872:                       die(_("failed to parse tree=
"));
>    builtin/stash.c:883:               die(_("failed to unpack trees"));
>    builtin/stash.c:1547:              if (report_path_error(ps_matched, p=
s)) {
>    builtin/stash.c:1763:                      die("subcommand wasn't spec=
ified; 'push' can't be assumed due to unexpected token '%s'",
>    builtin/stash.c:1773:                      die(_("options '%s' and '%s=
' cannot be used together"), "--pathspec-from-file", "--patch");
>    builtin/stash.c:1776:                      die(_("options '%s' and '%s=
' cannot be used together"), "--pathspec-from-file", "--staged");
>    builtin/stash.c:1779:                      die(_("'%s' and pathspec ar=
guments cannot be used together"), "--pathspec-from-file");
>    builtin/stash.c:1785:              die(_("the option '%s' requires '%s=
'"), "--pathspec-file-nul", "--pathspec-from-file");
>=20
> Certainly, there are some error messages in builtin/stash.c that do not
> follow the notes in Documentation/CodingGuideLines, but it does not seem
> to be "the style of all other messages" in git-stash.
>=20
> However, your message is clear ...  What error messages are you
> considering?

That's because many of the code paths don't use either `error()` or
`die()`, but use `fprintf_ln()` instead:

$ git grep 'fprintf_ln(stderr' -- builtin/stash.c
builtin/stash.c:		fprintf_ln(stderr, _("Too many revisions specified:%s"),
builtin/stash.c:			fprintf_ln(stderr, _("No stash entries found."));
builtin/stash.c:			fprintf_ln(stderr, _("Index was not unstashed."));
builtin/stash.c:		fprintf_ln(stderr, _("No branch name specified"));
builtin/stash.c:			fprintf_ln(stderr, _("Cannot update %s with %s"),
builtin/stash.c:			fprintf_ln(stderr, _("\"git stash store\" requires one "
builtin/stash.c:			fprintf_ln(stderr, _("Cannot update %s with %s"),
builtin/stash.c:			fprintf_ln(stderr, _("No staged changes"));
builtin/stash.c:			fprintf_ln(stderr, _("No changes selected"));
builtin/stash.c:			fprintf_ln(stderr, _("You do not have "
builtin/stash.c:			fprintf_ln(stderr, _("Cannot save the current "
builtin/stash.c:				fprintf_ln(stderr, _("Cannot save "
builtin/stash.c:				fprintf_ln(stderr, _("Cannot save the current "
builtin/stash.c:				fprintf_ln(stderr, _("Cannot save the current "
builtin/stash.c:				fprintf_ln(stderr, _("Cannot save the current "
builtin/stash.c:			fprintf_ln(stderr, _("Cannot record "
builtin/stash.c:		fprintf_ln(stderr, _("Can't use --patch and --include-unt=
racked"
builtin/stash.c:		fprintf_ln(stderr, _("Can't use --staged and --include-un=
tracked"
builtin/stash.c:			fprintf_ln(stderr, _("Did you forget to 'git add'?"));
builtin/stash.c:			fprintf_ln(stderr, _("Cannot initialize stash"));
builtin/stash.c:			fprintf_ln(stderr, _("Cannot save the current status"));
builtin/stash.c:				fprintf_ln(stderr, _("Cannot remove "

Overall, "builtin/stash.c" is a wild mixture of error styles. Some are
likely user-facing, where it might be a good idea to use `fprinf_ln()`
instead of `error()`. But some of them are closer to what we do in this
patch and likely should be converted to use `error()`, too.

I dunno, I find this to be confusing. But I spotted that there's an
instance already where we say `error("cannot write index")`, so I'll
just use that.

Patrick

> >=20
> > Reported-by: moti sd <motisd8@gmail.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/stash.c  |  6 +++---
> >  t/t3903-stash.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index b2813c614c..9df072b459 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -537,7 +537,7 @@ static int do_apply_stash(const char *prefix, struc=
t stash_info *info,
> >  	repo_read_index_preload(the_repository, NULL, 0);
> >  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
> >  					 NULL, NULL, NULL))
> > -		return -1;
> > +		return error(_("Cannot write to the index"));
> > =20
> >  	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
> >  				NULL))
> > @@ -1364,7 +1364,7 @@ static int do_create_stash(const struct pathspec =
*ps, struct strbuf *stash_msg_b
> >  	repo_read_index_preload(the_repository, NULL, 0);
> >  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
> >  					 NULL, NULL, NULL) < 0) {
> > -		ret =3D -1;
> > +		ret =3D error(_("Cannot write to the index"));
> >  		goto done;
> >  	}
> > =20
> > @@ -1555,7 +1555,7 @@ static int do_push_stash(const struct pathspec *p=
s, const char *stash_msg, int q
> > =20
> >  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
> >  					 NULL, NULL, NULL)) {
> > -		ret =3D -1;
> > +		ret =3D error(_("Cannot write to the index"));
> >  		goto done;
> >  	}
> > =20
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 3319240515..770881e537 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -1516,4 +1516,56 @@ test_expect_success 'restore untracked files eve=
n when we hit conflicts' '
> >  	)
> >  '
> > =20
> > +test_expect_success 'stash create reports a locked index' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit A A.file &&
> > +		echo change >A.file &&
> > +		touch .git/index.lock &&
> > +
> > +		cat >expect <<-EOF &&
> > +		error: Cannot write to the index
> > +		EOF
> > +		test_must_fail git stash create 2>err &&
> > +		test_cmp expect err
> > +	)
> > +'
> > +
> > +test_expect_success 'stash push reports a locked index' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit A A.file &&
> > +		echo change >A.file &&
> > +		touch .git/index.lock &&
> > +
> > +		cat >expect <<-EOF &&
> > +		error: Cannot write to the index
> > +		EOF
> > +		test_must_fail git stash push 2>err &&
> > +		test_cmp expect err
> > +	)
> > +'
> > +
> > +test_expect_success 'stash apply reports a locked index' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit A A.file &&
> > +		echo change >A.file &&
> > +		git stash push &&
> > +		touch .git/index.lock &&
> > +
> > +		cat >expect <<-EOF &&
> > +		error: Cannot write to the index
> > +		EOF
> > +		test_must_fail git stash apply 2>err &&
> > +		test_cmp expect err
> > +	)
> > +'
> > +
> >  test_done
> > --=20
> > 2.43.GIT
> >=20
>=20
>=20

--xV7uJLsu+mp7jhp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXBvlcACgkQVbJhu7ck
PpS7Bw//STtugc2JAt18NinuuOz4pYNXxuKWgXmg4joWYMhJ8R4zySq6zbhlmgr4
mqURUnOSVZLEbQDuC+RDvP14HIBWlUqiPQUXU1oODkjB74F1ZHX0RMaGxCkLm0Xt
gCsjxQLRugPiTSjo2KYUPibJLddXyWWrb+iCkgGb/cUJOJZjQr/mh/Xy/RpiQ20L
890CHNGKRiEcqwcAwQTdJnRiEQBmxagHjfH8K8t3aJiFiCgfmSJ2OL18XAXDDyMz
jbVsw/toRZs2jdyjkP/SHcoXhtdiZzbTWUXullTBcqPSJ6Wpym8pNiiNqjcs7zRb
JGvIa+jspkGqzV+ntNU9TknIv+uGjSTker5QlZGsdJ7oqrv9yL6Sg2LBEfEfBXu4
7L65h8/JzS46SXAe69iJ/8427doGUkHHKe/+llixcy9cZZGp1YONYr3wn3HonSNR
l3UE6rTCp2PGkg80QoGoW8/y3FhE+R9LSmTP2NpKRZlYfJqXmXD/lL+VqMdO0KHf
xSI2ktR1uKd5bjI0mwPQ4JFEoUPcdbW3JGlLKilM8cJ1JNkZPilKyVs+OdPSwHm+
yCUY5zCfFOKxJ9l5/5PWVvBXZr4F4oZ0RGosliEsODdl/giUdOQ7nAtoSKDbcNaD
akiKqngTM4k+M7O71vqTuiZlqWwOvO/ESeTkyS9fLvB8O/HAkcM=
=UYJl
-----END PGP SIGNATURE-----

--xV7uJLsu+mp7jhp+--
