Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F078B5D72D
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418079; cv=none; b=pdrZOrx8ve9owht3FbgYx7Hp6qYKf0jTg7ij7b0R38Fl5s6sk830x2gMYHxG63TUif7WKIzqDkvSVNObX5ECFyxDYSVMXp4EM2r5DK9fIVuqMjwEeSQvZmeXldZU8eeOh2a/Jfa6EB5tDnCpZqJqkbNQ0FiuGE7rtmufsKBidEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418079; c=relaxed/simple;
	bh=DTgNiDxVnuBB8gtvC1u0sep2V7pB5HykDvicHzmnjLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeDeREOO+CCwBYi3j1u7kkXDvJPlGeAs3j3+QDLRDX7EuQ8NwqyLkNy73M8yv9ZYlwO5gaS9L7fARP4qEObIoe7+y4gJKiHZgO5WvIOtLsSqcSdjt2Dj5Z6bDkmEz4iJxonRbjeMGKfEaCDSfm2Zgk4De2EEzhDMG2waH1C0QI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tk6Q/G6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f3AhNfzV; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tk6Q/G6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f3AhNfzV"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 078941C0007F;
	Tue, 20 Feb 2024 03:34:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 03:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708418076; x=1708504476; bh=CLm53cD9OL
	iAhdbkGlbci1+vSFX1uxGvPpnoAZFd0BM=; b=Tk6Q/G6ipsfmTf6GAaCETtQiY6
	tAIn+r/R+7jflBox1aR2LI6eNiQqmUYeaLqgYeVbr0OXc+3wcwGJCRKxJQ/IaCDn
	j7j+oiqPSDEUJUgdxgRnHU3qz5q34wKjpjbqdJRhZAKn3INNXUVyNbCvTmbEVuFH
	AlozAbT5aXXo0NGn8XCmX8lDp8F2VW1FYFXgDVXJZFZO1Mgb1XbfUjtFJ3UHMkIp
	5TwmDA07Z8DhJwab2dHlkLR+Zowae/KZxM/HPKrhqSxwOkxV5qCfcvqv9VEyMW6D
	PN/Fzr1A8Q3cee9a2xGlPsUkp/EbCUsSgKpw6XdB0ZsejV5WF7nqmxeErI6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708418076; x=1708504476; bh=CLm53cD9OLiAhdbkGlbci1+vSFX1
	uxGvPpnoAZFd0BM=; b=f3AhNfzVvpKSTE4dK5zi9eKtXjXsyABBeFhKm0FfJPUB
	dEalU/Pk1aZ+D8bK+cVauq9M8uf6fCqDA1iDd8/dUlsBPUB8gN0QnfiIUjpe3lPa
	+rnO6prmxPpOna5KmPyIA7YDWLSTVmfJmKn0BpKjcDcuAEML08cM5sJq71l1eQtq
	VofwfJwMXlmxbdta/83BFB7OnIrddOWMntJfn3VSMwDA+Te68PbtEUBVM5Bb8/rb
	+Mtvhl0R5SXGrKA6k8fJ8uBKNbUAmhlVAzORjTqqAL9D0JeO/wGNzDTu0HGVVesO
	hBTszipanHYnpBaTwhRdP8eXrWERen0PbK9CzWXMTA==
X-ME-Sender: <xms:HGTUZVA8qM_18ACGWq22bes5Q97dBWiQ_lYD55vnWkhDmIRI8Zthgg>
    <xme:HGTUZTiqh9KswiDih-QWKt5qyRSYSgCtKJEkXKJSlpINA-liiKGV9d1psKCwA7yFo
    1QQz8KbGa2Idi7o_A>
X-ME-Received: <xmr:HGTUZQkisvkoKvZ0aHa7yMdziE5E7uH1XNh0kkS-B6ycx6uhd_HbMh2-7LOfLGqFicCrxyyETtkUmMQWe4Akyu2Vtf6gR4uOkbE-834Ect9GWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HGTUZfz_m84T2504E8UEmYIn14D61wkzNRqkYHa3_O89siAr1IldWQ>
    <xmx:HGTUZaQq_ODG_kCxjOkbbCLEhW17FgnP0Kb6dBwlHfroXh54UxSnrg>
    <xmx:HGTUZSYcxGFxrYSDco5cQvEbrljjILNBOf3RNy9YpcUuQt2Dj8ur8g>
    <xmx:HGTUZVdofGHdcDgS9Ks457XFXvJqndTcuyPgkqc4jg0Nx2MF_AoqzT5p-CM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 03:34:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b57375c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 08:30:33 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:34:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] refs: stop resolving ref corresponding to reflogs
Message-ID: <ZdRkGWhUrHQgWbxy@tanuki>
References: <cover.1708353264.git.ps@pks.im>
 <a7459b9483660d1a44df500aaee85ad38146eb02.1708353264.git.ps@pks.im>
 <xmqqjzn0yote.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mJFNCw6ymDzYVQz"
Content-Disposition: inline
In-Reply-To: <xmqqjzn0yote.fsf@gitster.g>


--5mJFNCw6ymDzYVQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 04:14:21PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Refactor the code to call `check_refname_format()` directly instead of
> > trying to resolve the ref. This is significantly more efficient given
> > that we don't have to hit the object database anymore to list reflogs.
> > And second, it ensures that we end up showing reflogs of broken refs,
> > which will help to make the reflog more useful.
>=20
> And the user would notice corrupt ones among those reflogs listed
> when using "rev-list -g" on the reflog anyway?  Which sounds like a
> sensible thing to do.

Yeah. Overall the user experience is still quite lacking when you have
such "funny" reflogs. Corrupted ones would result in errors as you
mentioned, and that's to be expected in my opinion.

The more dubious behaviour is that `git reflog show $REFLOG` refuses to
show the reflog when the corresponding ref is missing. This is something
I plan to address in a follow-up patch series.

> > Note that this really only impacts the case where the corresponding ref
> > is corrupt. Reflogs for nonexistent refs would have been returned to the
> > caller beforehand already as we did not pass `RESOLVE_REF_READING` to
> > the function, and thus `refs_resolve_ref_unsafe()` would have returned
> > successfully in that case.
>=20
> What do "Reflogs for nonexistent refs" really mean?  With the files
> backend, if "git branch -d main" that removed the "main" branch
> somehow forgot to remove the ".git/logs/refs/heads/main" file, the
> reflog entries in such a file is for nonexistent ref.  Is that what
> you meant?

Yes. Would "Reflogs which do not have a corresponding ref with the same
name" be clearer?

> As a tool to help diagnosing and correcting minor repo
> breakages, finding such a leftover file that should not exist is a
> good idea, I would think.
>=20
> Would we see missing reflog for a ref that exists in the iteration?
> I guess we shouldn't, as the reflog iterator that recursively
> enumerates files under "$GIT_DIR/logs/" would not see such a missing
> reflog by definition.

No, and I'd claim we shouldn't. The reflog mechanism gives the user
control over which reflogs should and which shouldn't exist. For one,
`core.logAllRefUpdates` allows the user to either enable or disable the
reflog mechanism. If set to "false" then no reflogs are created, with
"true" some are created, and with "always" we always end up creating
reflogs. So depending on this setting it's expected that a subset of
reflogs do not exist.

But that'also not the whole story yet. Theoretically speaking, reflogs
have a subtle opt-in mechanism: once a reflog is created, we will
continue writing to it no matter what `core.logAllRefUpdates` says. So
it's feasible to have `core.logAllRefUpdates=3Dfalse`, but then explicitly
create a specific reflog so that you log changes to a specific ref.

With this behaviour in mind I'd say that we shouldn't log missing
reflogs.

> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 2b3c99b00d..741148087d 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -2130,17 +2130,9 @@ static int files_reflog_iterator_advance(struct =
ref_iterator *ref_iterator)
> >  	while ((ok =3D dir_iterator_advance(diter)) =3D=3D ITER_OK) {
> >  		if (!S_ISREG(diter->st.st_mode))
> >  			continue;
> > -		if (diter->basename[0] =3D=3D '.')
> > +		if (check_refname_format(diter->basename,
> > +					 REFNAME_ALLOW_ONELEVEL))
> >  			continue;
>=20
> A tangent.
>=20
> I've never liked the code arrangement in the check_refname_format()
> that assumes that each level can be separately checked with exactly
> the same logic, and the only thing ALLOW_ONELEVEL does is to include
> pseudorefs and HEAD; this makes such assumption even more ingrained.
> I am not sure what to think about it, but let's keep reading.

Yeah. This code here is basically just copied over from
`refs_resolve_ref_unsafe()` to ensure that it remains compatible. In a
future patch series we might include a new option `--include-broken`
that would also surface broken-but-safe reflog names.

But going down the tangent even more: one think I've noticed is that the
way `check_refname_format()` is structured is also wildly inefficient.
It's quite astonishing that when iterating over refs, we spend _more_
time in `check_refname_format()` than reading the refs from disk,
parsing them and massaging them into their final representation.

Overall, the whole infra to check refnames could use some improvement.
But this has already been discussed in other threads recently.

Patrick

> > -		if (ends_with(diter->basename, ".lock"))
> > -			continue;
>=20
> This can safely go, as it is rejected by check_refname_format().
>=20
> > -		if (!refs_resolve_ref_unsafe(iter->ref_store,
> > -					     diter->relative_path, 0,
> > -					     NULL, NULL)) {
> > -			error("bad ref for %s", diter->path.buf);
> > -			continue;
> > -		}
>=20
> This is the focus of this step in the series.  We did not abort the
> iteration before, but now we no longer issue any error message.
>=20
> >  		iter->base.refname =3D diter->relative_path;
> >  		return ITER_OK;
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 889bb1f1ba..efbbf23c72 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -1659,11 +1659,9 @@ static int reftable_reflog_iterator_advance(stru=
ct ref_iterator *ref_iterator)
> >  		if (iter->last_name && !strcmp(iter->log.refname, iter->last_name))
> >  			continue;
> > =20
> > -		if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->log.refname,
> > -					     0, NULL, NULL)) {
> > -			error(_("bad ref for %s"), iter->log.refname);
> > +		if (check_refname_format(iter->log.refname,
> > +					 REFNAME_ALLOW_ONELEVEL))
> >  			continue;
> > -		}
>=20
> This side is much more straight-forward.  Looking good.
>=20
> > =20
> >  		free(iter->last_name);
> >  		iter->last_name =3D xstrdup(iter->log.refname);

--5mJFNCw6ymDzYVQz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUZBgACgkQVbJhu7ck
PpSbsg/6Avds0QZL5dP2qFo+FQURyUhjEFRQLHFbzqcL1SIJLYZWRnKCFpFOgHQF
ZmkfwcF+30APAlBjoMIMLDVbyiye7KOFbibMnqCgt5laaFxsMx+M25/orfYc0Djr
g7PlQSE64/fig7FIaLFNtzvpazdytTaTUtWB6JHo+BD59zpkcaQXhe7AkGqptuUA
TjVLh9WpuUkvY0bMCXWlGTMlqeWkStNBpyK5i3E5ocIRNm6pAijqYFrhB/cdGAw1
YQCyH7KSsaESsibutGAPGs5JtaXfzegte5sNDn8VGh6zzra8qr/bS26uDoA0HKF5
UHDZa7lMrUyYxGkm5ODLijvZHxJ7Wy8kCXO0AqMIdCMqCrSE48HAj0QwempCDC6/
rFoe2bLE9eW/4JuGV3h4k+NQvteiiMT06Gq44krKHLHFJOtAHGZwY8YTAMU13hl9
GKBay4ZOnc73EZyK1odtIMWHD05zTFgf8zcAh+z5plgbfhZTEybI1cP74p8lggbt
WqFbW8O7307N0tSli6CDDoYvpzXnSBFPlUdptoiTDYfhFCAJrVrjEJ9QtAxJOsit
qF/SRITC/HQhzNi41wmLGY1rwEVNfFTMLMj1IIynoWFwxFM6VLyZbUbrTd/ORHqb
/ulzS8gIIkyGhdS72b7dR4b89l/TrLroZXXgXC2x/WwN0ckaIbk=
=EKL/
-----END PGP SIGNATURE-----

--5mJFNCw6ymDzYVQz--
