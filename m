Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC81422C7
	for <git@vger.kernel.org>; Mon,  6 May 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987327; cv=none; b=l504/q26mOcfEOc0IRqHkpe0jKZkoFYaU5Ran+n+O/KtXF/rom7basZjbPZikOYpLxCmyEGD7Ety9Zk+CUQWCUw3uJ3m89lJ0jBOBP9YJWLKJX/t7kxC/Qr+GlAyCtyRSpLdaJUMmqOreztyZDxyb7oT6+s8EJwPYEdvkMUkuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987327; c=relaxed/simple;
	bh=rgraZQfqPcfGmzUVkzTIZp+OCufgCF2+4nK6OZVbNR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzZiBHDaEISIBcO2JlILEzP6eSUV1BFM41aNGmBbC2PwUn6lF+QEUo1bq8NFMmSG5i5xuVa0pxUSvg5vsVcDn1iZmJ7PJvT0fx42okInTOfMENboY7vAyDYccXsyz/4yyx2G/w6bGiS/09MeVovrTzCyfaP8rFbaUUqqAsRgIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rsT3QoD2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jn4vWTLa; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rsT3QoD2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jn4vWTLa"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 8F5281C000AE;
	Mon,  6 May 2024 05:22:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 06 May 2024 05:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714987324; x=1715073724; bh=JdOMJbWLyz
	Xa4ukv/GyigkHovIRR0L60n3oRgPWhpS8=; b=rsT3QoD2MyUV6PZC8/06IDOjyU
	1SeVCC5QZZAttlcL8QRvjK5avAdwRnySxpSBUDPUWX3uoHmDA6U1ol+wnjAD42EK
	JjIgAHphocLqbfSxNcoddZMkaQHCBQe1lu5lySl2FzNualf8xFWiBFC5vNpEe/dR
	Ei3EhPCKVh5jja33xNAqoG/Q+oPmit8g8ecvc8MzMEeQV7dT9lo/O6iVvEeMuBxq
	3jAzXLGY727Rd4CH7Sbz93xytqtGZXwEnVSvpvMJJzTwuco9/6vaYybhtJYXqVgV
	yAPermtEGCZUNcCceEIjXoVMlP29CPeCvsJwOokO1arC96vaI9pDC1R2fszQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714987324; x=1715073724; bh=JdOMJbWLyzXa4ukv/GyigkHovIRR
	0L60n3oRgPWhpS8=; b=Jn4vWTLa2JEek6M+lEqR/UuxrQP16TSxJv9sucSlbMFk
	DL3Me2bkxgITkyoDf77brDpQJdD9GN/QHHqPLDg8IDwGstHrc2F2jYLymsVKm7Vf
	naw3AIdUCrxTUOnPEE5wOBJwzEnhdiCqaO5LHjxOxNTicKs5uAZ5odnzizRCWBzR
	nxsLQfPv1PXWgwNM4HqqEBV6vigSKaTcZdJao6t37yxsGefaSuHlxJijXRhhH8cm
	OIOqNCMiNpx5X3mRcA41LcQRu9Nph1tk/fH8D26ZqkK7j9wLrNvLDu2PaxwGAONZ
	fk4FR/7WvKWyUay2mghisztNFBti0gbWdQtN570Tyg==
X-ME-Sender: <xms:O6E4ZpcS5y76W-DT7NdKDQJkERqNNkhHI_YMXkFS9CNROBJK4lIj1A>
    <xme:O6E4ZnOwQPBJ5z9EDOgwednTkbXXlRurFaE6R2OwfqNsuy1Yho9u6CNgCbvCUEmzm
    WoEEfBZkZGtqHh5sw>
X-ME-Received: <xmr:O6E4ZijLdsVbCyLedVswJXy1J_w4_p6CZqwB3orqohvS2sFP7hyaZuAeY4ZuMpEcTkfxndfs90YJQAXQpRs89mKiYPvQTcM46be-T_Kc6-4aZdOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetvdfghfffffdukefgvdeuvdeuleekgf
    eukeduleefheektdejffehudethfelveenucffohhmrghinhepphhkshdrihhmpdhkvghr
    nhgvlhdrohhrghdpuggvphgvnhguvghntgihrdhpshenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PKE4Zi_c3Qt14X4VQQ0JFAyNipcIcrEfnOgjYR6ccHDeV36PbpbjbA>
    <xmx:PKE4Zlu-4FrOfpoQC80vjdwNcOo_8LLx8eC-LisPhfSR3jadwDoYPw>
    <xmx:PKE4ZhFrgYOhgQ4nGKWThtc4gNcCOV_ncN7BO-k4yrS4oES-WBKa2A>
    <xmx:PKE4ZsNtlSgSNTmfAJwFsnlCR3Je6dF1TG75vxSpkCmw37ngChgtZQ>
    <xmx:PKE4Zu4bJRJptxOlqZNI5JzNCWUc3HsETyom2NrxWejUqLSS-j2JPwin>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 05:22:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e2360a2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 09:21:55 +0000 (UTC)
Date: Mon, 6 May 2024 11:21:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #02; Fri, 3)
Message-ID: <ZjihN01c8gWX0s9H@tanuki>
References: <xmqqa5l64e0i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lXqVP90Y5XAWDVG"
Content-Disposition: inline
In-Reply-To: <xmqqa5l64e0i.fsf@gitster.g>


--2lXqVP90Y5XAWDVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 05:27:57PM -0700, Junio C Hamano wrote:
> * ps/config-subcommands (2024-05-03) 14 commits
>  - builtin/config: display subcommand help
>  - builtin/config: introduce "edit" subcommand
>  - builtin/config: introduce "remove-section" subcommand
>  - builtin/config: introduce "rename-section" subcommand
>  - builtin/config: introduce "unset" subcommand
>  - builtin/config: introduce "set" subcommand
>  - builtin/config: introduce "get" subcommand
>  - builtin/config: introduce "list" subcommand
>  - builtin/config: pull out function to handle `--null`
>  - builtin/config: pull out function to handle config location
>  - builtin/config: use `OPT_CMDMODE()` to specify modes
>  - builtin/config: move "fixed-value" option to correct group
>  - builtin/config: move option array around
>  - config: clarify memory ownership when preparing comment strings
>=20
>  The operation mode options (like "--get") the "git config" command
>  uses have been deprecated and replaced with subcommands (like "git
>  config get").
>=20
>  Will merge to 'next'?
>  source: <cover.1714730169.git.ps@pks.im>

I have just sent out a new version [1] that fixes a few commit messages.
Other than that I think this version should be ready to go.

[1]: https://lore.kernel.org/git/cover.1714982328.git.ps@pks.im/T/#u

>=20
> * ps/refs-without-the-repository (2024-05-03) 5 commits
>  - refs: remove functions without ref store
>  - cocci: apply rules to rewrite callers of "refs" interfaces
>  - cocci: introduce rules to transform "refs" to pass ref store
>  - refs: add `exclude_patterns` parameter to `for_each_fullref_in()`
>  - refs: introduce missing functions that accept a `struct ref_store`
>=20
>  The refs API lost functions that implicitly assumes to work on the
>  primary ref_store by forcing the callers to pass a ref_store as an
>  argument.
>=20
>  Will merge to 'next'?
>  source: <cover.1714717057.git.ps@pks.im>

It depends. Personally, I'm fine to merge this as-is and make this a
hard breakage. I don't really feel like it's worth it to have extra
compatibility macros or something like that.

If we want to play nice with current in-flight topics I'd propose to
just drop the last patch and reintroduce it in the next release cycle.
The downside here is that we may end up adding new callers to the old
interfaces, which may make us work against a moving target.

> * ps/undecided-is-not-necessarily-sha1 (2024-04-30) 13 commits
>  . repository: stop setting SHA1 as the default object hash
>  . oss-fuzz/commit-graph: set up hash algorithm
>  . builtin/shortlog: don't set up revisions without repo
>  . builtin/diff: explicitly set hash algo when there is no repo
>  . builtin/bundle: abort "verify" early when there is no repository
>  . builtin/blame: don't access potentially unitialized `the_hash_algo`
>  . builtin/rev-parse: allow shortening to more than 40 hex characters
>  . remote-curl: fix parsing of detached SHA256 heads
>  . attr: fix BUG() when parsing attrs outside of repo
>  . attr: don't recompute default attribute source
>  . parse-options-cb: only abbreviate hashes when hash algo is known
>  . path: move `validate_headref()` to its only user
>  . path: harden validation of HEAD with non-standard hashes
>=20
>  Before discovering the repository details, We used to assume SHA-1
>  as the "default" hash function, which has been corrected. Hopefully
>  this will smoke out codepaths that rely on such an unwarranted
>  assumptions.
>=20
>  Seems to break t0003 with a NULL the_repository.
>=20
>  Ejected out of 'seen' for now.
>  source: <cover.1714371422.git.ps@pks.im>

Interesting, I couldn't reproduce this issue when rebasing the patches
onto "seen". There were merge conflicts though, both with
jc/no-default-attr-tree-in-bare and ps/the-index-is-no-more. So maybe
there was a mismerge involved somewhere?

The first one looks like the following. Given that this merge conflict
happened in "attr.c", I strongly suspect that this one was mis-merged
because t0003 is about attrs, as well.

    diff --cc attr.c
    index 6af7151088,9d911aeb31..0000000000
    --- a/attr.c
    +++ b/attr.c
    @@@ -1223,8 -1224,15 +1224,8 @@@ static int compute_default_attr_source(
            ignore_bad_attr_tree =3D 1;
        }
     =20
    - 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_sourc=
e))
    - 		return;
     -	if (!default_attr_source_tree_object_name &&
     -	    startup_info->have_repository &&
     -	    is_bare_repository()) {
     -		default_attr_source_tree_object_name =3D "HEAD";
     -		ignore_bad_attr_tree =3D 1;
     -	}
     -
    + 	if (!default_attr_source_tree_object_name)
    + 		return 0;
     =20
        if (repo_get_oid_treeish(the_repository,
                     default_attr_source_tree_object_name,

And the second conflict looks like this:

    diff --cc repository.c
    index 2118f563e3,b65b1a8c8b..0000000000
    --- a/repository.c
    +++ b/repository.c
    @@@ -17,35 -22,19 +17,15 @@@
     =20
      /* The main repository */
      static struct repository the_repo;
     -struct repository *the_repository;
     -struct index_state the_index;
     +struct repository *the_repository =3D &the_repo;
     =20
     -void initialize_the_repository(void)
     +void initialize_repository(struct repository *repo)
      {
     -	the_repository =3D &the_repo;
     -
     -	the_repo.index =3D &the_index;
     -	the_repo.objects =3D raw_object_store_new();
     -	the_repo.remote_state =3D remote_state_new();
     -	the_repo.parsed_objects =3D parsed_object_pool_new();
     -
     -	index_state_init(&the_index, the_repository);
     +	repo->objects =3D raw_object_store_new();
     +	repo->remote_state =3D remote_state_new();
     +	repo->parsed_objects =3D parsed_object_pool_new();
     +	ALLOC_ARRAY(repo->index, 1);
     +	index_state_init(repo->index, repo);
    -=20
    - 	/*
    - 	 * Unfortunately, we need to keep this hack around for the time bein=
g:
    - 	 *
    - 	 *   - Not setting up the hash algorithm for `the_repository` leads =
to
    - 	 *     crashes because `the_hash_algo` is a macro that expands to
    - 	 *     `the_repository->hash_algo`. So if Git commands try to access
    - 	 *     `the_hash_algo` without a Git directory we crash.
    - 	 *
    - 	 *   - Setting up the hash algorithm to be SHA1 by default breaks ot=
her
    - 	 *     commands when running with SHA256.
    - 	 *
    - 	 * This is another point in case why having global state is a bad id=
ea.
    - 	 * Eventually, we should remove this hack and stop setting the hash
    - 	 * algorithm in this function altogether. Instead, it should only ev=
er
    - 	 * be set via our repository setup procedures. But that requires more
    - 	 * work.
    - 	 */
    - 	if (repo =3D=3D the_repository)
    - 		repo_set_hash_algo(repo, GIT_HASH_SHA1);
      }
     =20
      static void expand_base_dir(char **out, const char *in,

I'll maybe just revise the series and pull both of these topics in as a
dependency.

> * ps/ci-test-with-jgit (2024-04-12) 13 commits
>   (merged to 'next' on 2024-05-01 at 35e293e618)
>  + t0612: add tests to exercise Git/JGit reftable compatibility
>  + t0610: fix non-portable variable assignment
>  + t06xx: always execute backend-specific tests
>  + ci: install JGit dependency
>  + ci: make Perforce binaries executable for all users
>  + ci: merge scripts which install dependencies
>  + ci: fix setup of custom path for GitLab CI
>  + ci: merge custom PATH directories
>  + ci: convert "install-dependencies.sh" to use "/bin/sh"
>  + ci: drop duplicate package installation for "linux-gcc-default"
>  + ci: skip sudo when we are already root
>  + ci: expose distro name in dockerized GitHub jobs
>  + ci: rename "runs_on_pool" to "distro"
>=20
>  Tests to ensure interoperability between reftable written by jgit
>  and our code have been added and enabled in CI.
>=20
>  Will merge to 'master'.
>  source: <cover.1712896868.git.ps@pks.im>

I have sent a follow-up here [2] that unbreaks the "ubuntu:latest" jobs.
The breakage is caused by the release of Ubuntu 24.04, where there is no
more Python 2 anymore.

[2]: https://lore.kernel.org/git/cb8cefc20f373a3516695e7cbee975132553ea95.1=
714973381.git.ps@pks.im/T/#u

Patrick

--2lXqVP90Y5XAWDVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4oTYACgkQVbJhu7ck
PpSAKA/+ITXzUVWfPDRbEKVpwzb1MLxp3FQ1nK0lx+4eYYbE3PZPTVMKGaWhy1iM
Ma3QcCz3hDIlJRc3rciYpcYVjw6OFkGyMj2agH4+rkuXXTd09TJiJGmX56fsh9ND
iIVhoGaeolrxzgkzvONcn6/18mT2j51BWGL0Tqb9P+A0ldme0NjhGHK7bZX4oOsS
E9AN+1yjxZc6d+Fxhw7g8Bg3uX2pCcQ74/X9HD3K9l+3BwxCpWisIXigKwoxxAvE
SiNoVRVpRa/PELfrjHaSsJJKsbfCZWoctBOaWzDXGf71KKABXqwxXFRaSqkWywUc
wBj9hQofh01gIzmvxaS/SehPKQx3rJrnCT6bxNpNa0wSsqdfksSyMtGrGeCWmTxY
zXFDQGoo+l529StHeGfiU9DU704sgbkr0fhzv24vqOsTK/cj5VQJZG86IzUOQjly
P8Jz9boWK0DR8BplLwYIxolEIG+XHRyYwPlX/wbWa4dhsX7JEfL988OMmpNY/9gG
gBRUEO5eXuJvrPtC1Zqw3VrL0pZa44AqzJ4lB6Z1CwNKDgQKSVP3sym3YNNpjcgi
vKZKuWgBheCNapfCTbPNf7lg5DVnNJ6LD5bJeVzVmbVYzlWTPBJbAF1Gfn+KhWqv
vBUUWjMojBdi2HWeWgHbqEXEloUSrwiQGgKLIRRW8uFxx0CSAK0=
=gTdj
-----END PGP SIGNATURE-----

--2lXqVP90Y5XAWDVG--
