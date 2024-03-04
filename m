Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD41170A
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709534679; cv=none; b=IR0b9mUlwa2ownLVtWdEarrG27zwyNm4p2H2tvEWYopaeUulqlpfmMc4Pq90V4NlwHle6VlkCzBF2LhIFld4ogn/qKazRXAxLcIUtBcyMSCBmHuy+PPjxNqec+n19uCwj9ne/s24b1qmBKHZfdJUotY8LcZ93sWZA4t038USnP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709534679; c=relaxed/simple;
	bh=BPTATQUqQ9lwJrIcJUKlLEsuezwTYEDapMKZqhXzZ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teGVnU09oqQLL7qlUxU+TiEg8fseR9nPZYh2bD2qX/exGICnxXRf/ODHESmusvZLYmf8ttxg6CDXK3AM1jvW77j+CDVH59f+ukZJsyKrLUoAGdDSFya1J6C2vqTS4zSSmOjgGqEaDgnkm2fK0yGcg66kisLqxppLNKTiXsGeGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HlUcySTT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAkTnLKv; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HlUcySTT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAkTnLKv"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1CEBE18000B0;
	Mon,  4 Mar 2024 01:44:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 Mar 2024 01:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709534675; x=1709621075; bh=wkZBg5GMJn
	pF0QVdTw42OK2xshsjH5K8fj9LcYv2JZ8=; b=HlUcySTTgOqsOZn1SBth/JDe0P
	q1zoiW+3H/Nd5PfvFHzgIynxFfn3CkRgoUoP59TpKnLaVLBBY13PrAWSc804zneI
	piIb8mL1IjfQ+qWDMkwWHeF2FvIL0jKYz/aOEqzA8cyErljOTGR8Op905Lt9TG10
	UcPBLlEOzis8NyjgwePZE4GEsnV3N1+wvj2pUIDC8BWn5PqarZ7FpNv7fcr3gU+l
	ESkGIeVbInVhW29lD4rou2N2gStZc0ExQnttVJBTWTjOu0Jb/ckiDn8QREiYoiAo
	CnwD7BPkxK0il+jbLDoH0Ada8Vz6OjReSd7eUm+dE/xRAwcOmmcRMYxmiTpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709534675; x=1709621075; bh=wkZBg5GMJnpF0QVdTw42OK2xshsj
	H5K8fj9LcYv2JZ8=; b=KAkTnLKvQjtrta+Z5hmHc4TaBBRlva86NRpEl3xNbHUg
	3Za9WyJm+EuajvoIk3P/T9lJ060tUUhtvFDT0sGqxsMIs0ElIOvz9UjVMFQ+Lur/
	4KJwW1AWx5M9WjRgYU/cE8EhRji5//2Imcaqzgx6+pYQ25eP25Ngz+I1xC06ZYU/
	2S8mgjha/SWgpm38qRZRQKqPrnw8LHvpBatB2nfA+VwRLpJUmSJDzLrHViqn0zub
	W7YvfkL5CHPXvRw5i7rKPav5vPNVi3prjhw7DwaE5N8cSXjQvwE5AO6KCI/i09D8
	5DpIo2qvrTuepeX3by57Of83qZbrlN08DlNTMEs+FA==
X-ME-Sender: <xms:023lZcazSmTKBC-pAj7JPB-PFCUgGfxgRH7bwOCzEmlTiSNmZLEs8w>
    <xme:023lZXaL0IfIILq1pdSKFjlCzWUT8kImeOAp3l4Budq4u2S9smb26Jrk5_CRJTERd
    0y6PCUByrBpM1f2bw>
X-ME-Received: <xmr:023lZW-9Pw0Ozod5du48STalGh7JjcZbM7K9lQJdsSvch_McPOg5XYuMbTyYpPq2ARizvogQd5cRy4z-jA3qtCu4k5py2oiyl_SDgpNzgnTlDQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:023lZWrOjBGYWBD71k1lajRVCRsnjkURKUfYCoLlH3jhgC1lOpzHTw>
    <xmx:023lZXrjYmzmKJuli6XGo0TCgRVkfY_i99rZrITtj2fHG0omGuUgCA>
    <xmx:023lZUQT2f8A1AIzjA5KfCCwyDOtqBzaoEw3aBd9AbsUo_zIcH-F0g>
    <xmx:023lZWUdb7iFF41GGCnGwYIByE_Lsxk2QdGVM_jnznVao87wBmeKocuusgc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 01:44:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b680cbe4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 06:40:09 +0000 (UTC)
Date: Mon, 4 Mar 2024 07:44:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/2] builtin/clone: allow remote helpers to detect repo
Message-ID: <ZeVt0CAfpYFZqT2i@tanuki>
References: <cover.1709041721.git.ps@pks.im>
 <9d888adf92e9a8af7c18847219f97d3e595e3e36.1709041721.git.ps@pks.im>
 <xmqqle75ppa3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="daMdD3hvgJtcQas3"
Content-Disposition: inline
In-Reply-To: <xmqqle75ppa3.fsf@gitster.g>


--daMdD3hvgJtcQas3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 01:31:48PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Instead, fix this issue by partially initializing the refdb up to the
> > point where it becomes discoverable by Git commands.
>=20
> As you mentioned earlier, this indeed is ugly, but I agree that
> there is no other reasonable way out.  I am also unsure if this is a
> viable workaround in the longer term, but it should do for now.
>=20
> > +	/*
> > +	 * We have a chicken-and-egg situation between initializing the refdb
> > +	 * and spawning transport helpers:
> > +	 *
> > +	 *   - Initializing the refdb requires us to know about the object
> > +	 *     format. We thus have to spawn the transport helper to learn
> > +	 *     about it.
> > +	 *   - The transport helper may want to access the Git repository. But
> > +	 *     because the refdb has not been initialized, we don't have "HEA=
D"
> > +	 *     or "refs/". Thus, the helper cannot find the Git repository.
> > +	 *
> > +	 * Ideally, we would have structured the helper protocol such that it=
's
> > +	 * mandatory for the helper to first announce its capabilities without
> > +	 * yet assuming a fully initialized repository. Like that, we could
> > +	 * have added a "lazy-refdb-init" capability that announces whether t=
he
> > +	 * helper is ready to handle not-yet-initialized refdbs. If any helper
> > +	 * didn't support them, we would have fully initialized the refdb with
> > +	 * the SHA1 object format, but later on bailed out if we found out th=
at
> > +	 * the remote repository used a different object format.
> > +	 * But we didn't, and thus we use the following workaround to partial=
ly
> > +	 * initialize the repository's refdb such that it can be discovered by
> > +	 * Git commands. To do so, we:
> > +	 *
> > +	 *   - Create an invalid HEAD ref pointing at "refs/heads/.invalid".
> > +	 *
> > +	 *   - Create the "refs/" directory.
> > +	 *
> > +	 *   - Set up the ref storage format and repository version as
> > +	 *     required.
>=20
> "as required" by whom and in what way? =20
>=20
> "The code to recognize a repository requires them to be set already,
> but they do not have to be the real value---we just assign random
> valid values for now, let remote helper do its work and then set the
> real values after they are done" would be a plausible interpretation
> of the above.  Is that what is going on?

Partially. While we cannot yet determine the object format, we do know
the ref storage format as it is specified by the caller when invoking
git-clone(1) with the `--ref-format=3D` switch, not by the remote repo.
In that case, we'd have to set up the ref format accordingly and also
set the repository version to "1".

Patrick

> > +	 * This is sufficient for Git commands to discover the Git directory.
> > +	 */
> > +	initialize_repository_version(GIT_HASH_UNKNOWN,
> > +				      the_repository->ref_storage_format, 1);
>=20
> OK, so we start with "we do not know it yet" here.
>=20
> > +	strbuf_addf(&buf, "%s/HEAD", git_dir);
> > +	write_file(buf.buf, "ref: refs/heads/.invalid");
> > +
> > +	strbuf_reset(&buf);
> > +	strbuf_addf(&buf, "%s/refs", git_dir);
> > +	safe_create_dir(buf.buf, 1);
> > +
> >  	/*
> >  	 * additional config can be injected with -c, make sure it's included
> >  	 * after init_db, which clears the entire config environment.
> > @@ -1453,6 +1498,7 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
> >  	free(remote_name);
> >  	strbuf_release(&reflog_msg);
> >  	strbuf_release(&branch_top);
> > +	strbuf_release(&buf);
> >  	strbuf_release(&key);
> >  	free_refs(mapped_refs);
> >  	free_refs(remote_head_points_at);
> > diff --git a/setup.c b/setup.c
> > index b69b1cbc2a..e3b76e84b5 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1889,6 +1889,13 @@ void initialize_repository_version(int hash_algo,
> >  	char repo_version_string[10];
> >  	int repo_version =3D GIT_REPO_VERSION;
> > =20
> > +	/*
> > +	 * Note that we initialize the repository version to 1 when the ref
> > +	 * storage format is unknown. This is on purpose so that we can add t=
he
> > +	 * correct object format to the config during git-clone(1). The format
> > +	 * version will get adjusted by git-clone(1) once it has learned about
> > +	 * the remote repository's format.
> > +	 */
> >  	if (hash_algo !=3D GIT_HASH_SHA1 ||
> >  	    ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
> >  		repo_version =3D GIT_REPO_VERSION_READ;
> > @@ -1898,7 +1905,7 @@ void initialize_repository_version(int hash_algo,
> >  		  "%d", repo_version);
> >  	git_config_set("core.repositoryformatversion", repo_version_string);
> > =20
> > -	if (hash_algo !=3D GIT_HASH_SHA1)
> > +	if (hash_algo !=3D GIT_HASH_SHA1 && hash_algo !=3D GIT_HASH_UNKNOWN)
> >  		git_config_set("extensions.objectformat",
> >  			       hash_algos[hash_algo].name);
> >  	else if (reinit)
>=20
> Here we refrain from writing extensions.objectformat in the
> repository when we do not know what hash function is being used.
> Without this change, we would instead remove extensions.objectformat,
> which does not sound too bad, as "reinit" is passed by the new call
> we saw above and this "else if (reinit)" will do exactly that anyway.
>=20
> In any case, after we finish talking with the other side over the
> transport, we make another call to initialize_repository_version()
> with the real objectformat and everything will be fine.
>=20
> The ealier description of the implementation idea made it sound
> really yucky, but I do not think the solution presented here is too
> bad.
>=20
> > diff --git a/t/t5801/git-remote-testgit b/t/t5801/git-remote-testgit
> > index 1544d6dc6b..bcfb358c51 100755
> > --- a/t/t5801/git-remote-testgit
> > +++ b/t/t5801/git-remote-testgit
> > @@ -12,6 +12,11 @@ url=3D$2
> > =20
> >  dir=3D"$GIT_DIR/testgit/$alias"
> > =20
> > +if ! git rev-parse --is-inside-git-dir
> > +then
> > +	exit 1
> > +fi
> > +
> >  h_refspec=3D"refs/heads/*:refs/testgit/$alias/heads/*"
> >  t_refspec=3D"refs/tags/*:refs/testgit/$alias/tags/*"

--daMdD3hvgJtcQas3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlbc8ACgkQVbJhu7ck
PpTNfBAAi3LfCwc+/Mtw9wvm8zV+w9jh+eWatlOJJjNKshyq5ztzzt+ESsGlyene
lFsaT/28X5tdKnCkD1UsBUSbT6elw8gfMbMZE0dk5VZzU5Sl/q+rlgMkyNzjZRGI
2NeJTZAyccBDa8XsKhwfckoHnE8f51uLIJK6lYJHzVqwcgZCHUw+KIVes5369HT9
v9mt/fyV/EWAWHDbHLg0KM9/hZhM8vjdcDggqFFTg7uTxZS3nPkLWN6dORX8jkcX
YqIjEnBpjy6QpeUSWvmMzLQdAPaUH8SJ3OTF7tT0mkdLwteml5Gu8L7y8ZxYg7Kr
WIuv0133Ovtk/5CZzp4h7l0hoqyBhzzMB5UN46iX8onD4YdVAw/Oz+eRZYR9RvhS
pt1bzfzkJWtedmvvQ55hEA238EmQSj+uqNJnyM1iolSurhlzvPnWkN+Isd/r5QAV
SdEMg6cdicTu2rObxqqvZnaax+4fFVsQeHTdKZ+ypBxdqegkW0CfML98MydwLxKR
FC85VwjLwp9mR1/IWq8LhInbkj2cTfspC/vsXowpw9YhilznC6vTcl5dugFgyVfi
hEfxluVjYW/4VnNR5dsZNlijQXXMx/skUdlOLW1DlmfLcXJC3TIacMqC+ClKW+jR
Po3Ph6Z4PZ6wQEe2gBuZoVwV65+Sn7HEPArb4KUsIedCbrRyCKc=
=NYtg
-----END PGP SIGNATURE-----

--daMdD3hvgJtcQas3--
