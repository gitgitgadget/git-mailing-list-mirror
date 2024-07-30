Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789B197543
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328306; cv=none; b=uQa/KAuDuBA06sfBLc1BQn4kE8IxcvmbegSQiHNvJsZhRJ4lLjLHnxL+5+6E98nvktcvLAThlY24QTmnx/Bd+mBvJqQVPUL6x0Nlk90ByeFK6qgasKmK+j2+uDDomgJiGD3JeQ8tP+oN6uT/g9EGUsUA1OaGD+UQp+2JfTDgdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328306; c=relaxed/simple;
	bh=ojk6VZDPZR14/wMx/DnQGbObf0G9xDZnlP0ucD/uGII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLgVASYv1aQEwFDzC+Q+36cxviGaBOt0Y2yxCJiprClY7/r3YbHDyxzw1v7uKWzjXAWAJwmCVj9vj2QSuLUTxwgeWe2m2NEQYnmPm82/TmKrqGGOPmg5PWrLtVpNlGzzL63zf0r/Vkw+AuFz0CXmYrVP9m7TJ9uVJqIZO5ZwIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qJ2C159S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLFp2pIv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qJ2C159S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLFp2pIv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0A94711403B0;
	Tue, 30 Jul 2024 04:31:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 30 Jul 2024 04:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328302; x=1722414702; bh=6jhiKq0plc
	oR1nMvd+JMiHfl+em9XHqCe9YAxbxKZww=; b=qJ2C159SCxAqVBiNYreYb2Eylr
	KJq8oH/FcLNZplwaLvf9YuClaJrS9iQQ+wgEbwjtebxu8QYX0tyUpqF5O9lGj3yi
	kOgDfxFcYMdcOMNS0jjK39E3h+a4VOAnHbAxyFkcs5gTAb0Unmh1D30ENQy8rNAa
	x61GYd+WUvJMsTRbx+2SlJuEu0s72W2iD1/8Ns5qbKkL84MZmGuxEbDjbIfmLZq6
	/kAOy6sV8iEL099zBMexIW7BSZlpHXrsVTwJj6Ok0oWaP9dr0jxYcbHhCtGx9HKJ
	qyaTMcHcw+NY/aKuU3TqW1MuXslj7atnzDIwFRmS2VuKmTyRu1bhScXtP5Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328302; x=1722414702; bh=6jhiKq0plcoR1nMvd+JMiHfl+em9
	XHqCe9YAxbxKZww=; b=lLFp2pIv7NnNUSH7U5ffEV0ec0O2tYkDBHqH23DTMEot
	GElJ4j3Z9IhId250USqgonOYwp+sMA690+xuV7k9rG/aocctgrMPdToL2YRKdIOw
	iD/ngYZTRWzsEcgthnul7m29aq5AbxqldJDL/Wuu95Krs7JfBneH9NtvAYzgj/ry
	0n9W8WqKSsHhB1EaGMC9HV6rkaia19GTFLZFdFcTnB822WxqQwcgr3pxIhElB18T
	/+HYLLXj1l7kL5o100IQK+0Otwk6RlDUTXS6pyRZ6VKsS4oyKp4R3FTfCN4pUFzZ
	sa7V34cn41SFHjA8G9acyfV+UfZ6+220oAen3Z65qQ==
X-ME-Sender: <xms:7aSoZkd7B7XzCk4qmoJadoCkKcuDkgS14ucgONxX2sDRUJy-fT9SrQ>
    <xme:7aSoZmNjW0xwzYwc1dsylUrjjhbInIz5crBr7dCAsOFN7Aqm__e-VVhZJEJbHoTPj
    Rfjpqbv36oggv6v2g>
X-ME-Received: <xmr:7aSoZlib2A7lGS3BNGRitv2Ke2B5KQrafPFHUANfXg0JYxTY2YFkWkoUA5h6z8klzn2V0QkrW9FPBhgLZvYGuvfUyKG0OMTBLxQV5AbumrDMEiE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:7aSoZp-gzreKDKNxbUPkpF4rzTHkebm1bARSBj8-3wnvy6ImMcRJqw>
    <xmx:7aSoZgsCIRg7eDSz19fXnmJEIgMqlE9maeld7JTNJ6d7MtoEEItDPQ>
    <xmx:7aSoZgFd7tqmGqT7JUF7C4LKVNg8jy-5SaElgpVMq-hdQiLqmHyAYA>
    <xmx:7aSoZvMQlmwGos_IULppBwjQex-N_QP9nD0Ff6CN9Itqge9TWcVedA>
    <xmx:7qSoZkhAdi0c5FK0owF3BiyXwLt58bdfKx9B3Nux723_-gZZiX7GO2Nf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bdeefb0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:30:12 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 06/10] git refs: add verify subcommand
Message-ID: <Zqik6cgm_6HYVUKy@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeYsNtl90N1fVDy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96fWVEtn9eBaAo8V"
Content-Disposition: inline
In-Reply-To: <ZqeYsNtl90N1fVDy@ArchLinux>


--96fWVEtn9eBaAo8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:27:12PM +0800, shejialuo wrote:

The subject should probably start with "builtin/refs", not "git refs".

> Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> check the reference database consistency and also this subcommand will
> be used as the entry point of checking refs for "git-fsck(1)". Last, add
> "verbose" field into "fsck_options" to indicate whether we should print
> verbose messages when checking refs and objects consistency.

Nice. I very much like that we now have a common home for such low-level
ref-related commands. Also, "verify" is neatly in line with e.g. `git
commit-graph verify".

> @@ -39,6 +43,15 @@ include::ref-storage-format.txt[]
>  	can be used to double check that the migration works as expected before
>  	performing the actual migration.
> =20
> +The following options are specific to 'git refs verify':
> +
> +--strict::
> +	Enable more strict checking, every WARN severity for the `Fsck Messages`
> +	be seen as ERROR. See linkgit:git-fsck[1].

How about:

    "Enable stricter error checking. This will cause warnings to be
    reported as errors. See linkgit:git-fsck[1]."

> +--verbose::
> +	When verifying the reference database consistency, be chatty.

I wonder whether this really helps all that much. It doesn't really say
what it adds on top of the default mode. So unless we document what
exactly this changes, I rather think we can just leave it aways as
basically everyone knows what a "--verbose" flag does.

>  KNOWN LIMITATIONS
>  -----------------
> =20
> diff --git a/builtin/refs.c b/builtin/refs.c
> index 46dcd150d4..4831c9e28e 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -1,4 +1,6 @@
>  #include "builtin.h"
> +#include "config.h"
> +#include "fsck.h"
>  #include "parse-options.h"
>  #include "refs.h"
>  #include "repository.h"
> @@ -7,6 +9,9 @@
>  #define REFS_MIGRATE_USAGE \
>  	N_("git refs migrate --ref-format=3D<format> [--dry-run]")
> =20
> +#define REFS_VERIFY_USAGE \
> +	N_("git refs verify [--strict] [--verbose]")
> +
>  static int cmd_refs_migrate(int argc, const char **argv, const char *pre=
fix)
>  {
>  	const char * const migrate_usage[] =3D {
> @@ -58,15 +63,54 @@ static int cmd_refs_migrate(int argc, const char **ar=
gv, const char *prefix)
>  	return err;
>  }
> =20
> +static int cmd_refs_verify(int argc, const char **argv, const char *pref=
ix)
> +{
> +	struct fsck_options fsck_refs_options =3D FSCK_REFS_OPTIONS_DEFAULT;

So we don't ever end up using `FSCK_REFS_OPTIONS_STRICT`? If so, I think
we should just drop that declaration in the preceding patch.

> +	const char * const verify_usage[] =3D {
> +		REFS_VERIFY_USAGE,
> +		NULL,
> +	};
> +	unsigned int verbose =3D 0, strict =3D 0;
> +	struct option options[] =3D {
> +		OPT__VERBOSE(&verbose, N_("be verbose")),
> +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
> +		OPT_END(),
> +	};
> +	int ret;
> +
> +	argc =3D parse_options(argc, argv, prefix, options, verify_usage, 0);
> +	if (argc)
> +		usage(_("'git refs verify' takes no arguments"));
> +
> +	if (verbose)
> +		fsck_refs_options.verbose =3D 1;
> +	if (strict)
> +		fsck_refs_options.strict =3D 1;

Instead of manually setting those variables, we can pass pointers to
those member variables in the `struct option`s directly.

> +	git_config(git_fsck_config, &fsck_refs_options);
> +	prepare_repo_settings(the_repository);
> +
> +	ret =3D refs_fsck(get_main_ref_store(the_repository), &fsck_refs_option=
s);
> +
> +	/*
> +	 * Explicitly free the allocated array and "skip_oids" set
> +	 */
> +	free(fsck_refs_options.msg_type);
> +	oidset_clear(&fsck_refs_options.skip_oids);

Should we provide a `fsck_options_clear()` function that does this for
us? Otherwise we'll have to adapt callsites of `refs_fsck` whenever
internal implementation details of the subsystem add newly allocated
members.

> +	return ret;
> +}
> +
>  int cmd_refs(int argc, const char **argv, const char *prefix)
>  {
>  	const char * const refs_usage[] =3D {
>  		REFS_MIGRATE_USAGE,
> +		REFS_VERIFY_USAGE,
>  		NULL,
>  	};
>  	parse_opt_subcommand_fn *fn =3D NULL;
>  	struct option opts[] =3D {
>  		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
> +		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
>  		OPT_END(),
>  	};
> =20
> diff --git a/fsck.h b/fsck.h
> index a4a4ba88ee..b03dba442e 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -155,6 +155,7 @@ struct fsck_options {
>  	fsck_walk_func walk;
>  	fsck_error error_func;
>  	unsigned strict:1;
> +	unsigned verbose:1;

Okay. Let's see whether this field will be used in a subsequent patch.
If not, we should drop it and get rid of the option altogether, I guess.

Patrick

--96fWVEtn9eBaAo8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopOgACgkQVbJhu7ck
PpSfvQ/+PAM/DoFUdUsn0P2mZibI23i8ggavLmtzv7iVRriglJ7YZgfuWUJuuFDS
uDPqm4kse9+b8LbOQDvAjgk1eJgLr+2ah5XxCBNJFvooZFFDftXdzX1aYxStsdP1
48zMQU13cdb8IbrkGyoKOEqpMEncxOD0KA7qo9DFKvTft7cxfIZripxGJ5jFR+Pb
KoSdOvDHjyAZsUQCv6A5A6/WudaPFD3/eXNeC/TzUJ/ELlJmmm9sksdcZlHoxK0f
cf+3zzIAHLNXBz03Fb4gTY+ROMHnh5ZPsXXxpjZy7yDPA5CAn3yiAadONzxu2XVf
llo12TpjA1qxPK7uHm92Y5WFlI+O/Sr3tXxuSpI9JUdf8Y3XgZCk5zgXIxO2na51
ktMLeOsBcpbQWu+Io+VK+0c3V7zm3TKrV8/N1l1GLmgDIvqR1XshM2c7XNXJ2tHa
+yF7Bv+EVrMDLo7Z//tRuk6NoTE3qx4H//Jl9+PwaVQbJd3usn4gVnqtSJWRIeqn
+gb3fuym680Pl3PHLvevGLIoe5xnA28l4iqjpwx0aMmg+R6e3+GqKxg9P5A+vTIu
YX8weYrWZxWn+Nc9vsuImrf14dW7/ynBmfwSCb4P8yNExgls5sPqhdecgGDgTsRc
rm7Rj1rnivG4EyqvVe+FFsikMJnaEJRe/C8dU4Mh5fTIQKwPFCk=
=uYay
-----END PGP SIGNATURE-----

--96fWVEtn9eBaAo8V--
