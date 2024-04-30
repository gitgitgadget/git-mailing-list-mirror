Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47840BF2
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462208; cv=none; b=qP/oPpCeD22Qm9cyRAMq172J8RW3geV3ySA5DBtcPtB5JpQapXwT6g2OM338Ppzn2g7JsdQ9Sv/Czd8aC8aPVMiSceCcEWsKpktZScxxR3N6tY5I046Uv+BTqFcUy37w7klmU3T/aKaP/XmTf+3bbArNvvzga6F1DakEOKI7SDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462208; c=relaxed/simple;
	bh=VMxPvEVuBDsG0TBU6qV+imyBH6VnpfZ1GnCXxyuSiwQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd87HsyeY7uwQdRvLbnV/EwUkbiQEfGYMC9qLQo4LBDrw8Awsd4sHvVA/SFE0tc92ZZhAt3sZ5kJALC+BB6IVNvvpt5RxGVUXjNzKaFiYAmD/wk1LiVtQeXNgjEXIxTcBIcahe2Fl/jKJi9LetBdkA3xSWofoxX2ogYa0EDR/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aMjv7ATe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQrL6r/a; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aMjv7ATe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQrL6r/a"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C02D61140085;
	Tue, 30 Apr 2024 03:30:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Apr 2024 03:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714462205; x=1714548605; bh=jgCHPhiRxb
	5JxD5e3Ja/c6No79vL9t1BwGuMmRb3Bxc=; b=aMjv7ATexPpOWE3tkeUYL1VtMc
	jKdZ/nEI5WE5J/vgCYht4B46IpEzYYa/cGSRts4ul1lKiIfzXr3EBaLwfjN3zSbg
	yjyXfALT6n/UVQOB5LiYqVbERzugxpsZdbJQ5q2gQFXZqDgeiiF2PqK1O60QQElm
	+rJGQOBQQMQZVnpPnA1a8vl7A97kFGDLPtblpDxrvJXkxwyY/caAaGWKN4fk4zWN
	dKWLbjTTeWRUnzzQX38gg0/HkXv2oBn6HQ0ZMGar87fHpZ297HwqBkC/g8TqQhc9
	S7qMgYy6ej06EwyP7jGy6IyxFDdclAEsoKwxigeUvrHvyCihxFUi/JWUZ/+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714462205; x=1714548605; bh=jgCHPhiRxb5JxD5e3Ja/c6No79vL
	9t1BwGuMmRb3Bxc=; b=XQrL6r/aT08rDsMPAV9VniyfxpfoxIFqPsf95pZwzlRb
	Z5V+x6q+T4ivU3paaBPcC2JBps8vgh3O8ZYqfw8cqmTrvaWnwjetwq7S/T+K0EKX
	eBwU+lJqj2I2vjfT1leuKRFu0tWfy+UO5FOYWFKeJBkQYp7fyTNxOp4tqSNq2yW0
	wixOhc44EP3IU1sMVIJy7Vx51udMJjxdPaDXfKgZjtzXcTrS7kLxCq1AJY+y88SE
	OwIsLLLYecsyQhZA1ljmOv515TILYFq872kxTRXVzuz5OM8ijMX9IA0YQnXUuEBh
	fxe5wNh3o9/RGAJI4Nrvcp3OrsrU0a5Y9OpzAlsTig==
X-ME-Sender: <xms:_Z0wZrDClpY1W9qXdyk1j5w0y7aaYYvZlBD4Ipx0oSPiFeNnQ6UN6w>
    <xme:_Z0wZhghUfP6g6urX3W7RDbk17lCLVH9hxLz7JvM-9etAJIq-oqlsBDGecasNO8YP
    NTcE_vQ4QGuU-5k7Q>
X-ME-Received: <xmr:_Z0wZmn_xsZganqhUSJDBZBLC5UvNDoiLOBBrbhyNfV2y3wSQ7VlEOmVkB5ILVbBHgzAKFCBWfklyw5zz2kcEsIC8-iuRoHFfxsqxYbp-TLSSIv3DnUS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_Z0wZtyB4jOMySjd5h-TAucVdfpGemElFKcAs28OaZuPC8fBdMCDwA>
    <xmx:_Z0wZgS3MFO48JjsuPO2wZKEARf2ZxuGNSbtVxsus2forZjlAEh2OA>
    <xmx:_Z0wZgYhwuB1sxNH4ML2Ge0_mnOggT1dSWgqRDHjU3_rnluDgysr0g>
    <xmx:_Z0wZhQFeTQQi75YlL5RcK9zjgP5Qj-7AOao0r4BtbqwRC_ZxxUW4g>
    <xmx:_Z0wZmdhD_HB595oL_sH4dWGfnZYDzKfc2avDWtT2scyUPn_POp4roQN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 03:30:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3d377547 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 07:29:40 +0000 (UTC)
Date: Tue, 30 Apr 2024 09:29:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <ZjCd97dqiHfkm1UG@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <5322n7eqkov3fqw2zw2seiqyqcmmrlo35camq76n546dkgycru@njuj32gmbogh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fjILm1XicTPsoZeV"
Content-Disposition: inline
In-Reply-To: <5322n7eqkov3fqw2zw2seiqyqcmmrlo35camq76n546dkgycru@njuj32gmbogh>


--fjILm1XicTPsoZeV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 05:52:41PM -0500, Justin Tobler wrote:
> On 24/04/29 03:41PM, Patrick Steinhardt wrote:
> > diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
> > index d71b199955..4275918fa0 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -497,20 +497,28 @@ exclude;;
> >  	unusual refs.
> > =20
> >  [[def_pseudoref]]pseudoref::
> > -	Pseudorefs are a class of files under `$GIT_DIR` which behave
> > -	like refs for the purposes of rev-parse, but which are treated
> > -	specially by git.  Pseudorefs both have names that are all-caps,
> > -	and always start with a line consisting of a
> > -	<<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
> > -	pseudoref, because it is sometimes a symbolic ref.  They might
>=20
> We remove the example here about HEAD not being a pseudoref. This
> example seems helpful to indicate that a pseudoref cannot be a symbolic
> ref. Is this no longer the case and the change intended?

I just don't see why we would want to have this restriction. Honestly,
the more I think about this whole topic the more I want to go into the
direction I've hinted at in the cover letter: drop "special refs" and
define pseudo refs as either FETCH_HEAD or MERGE_HEAD. Everything else
is just a normal ref, even though some of those may live in the root
directory if they conform to a set of strict rules:

  - All upppercase characters plus underscores.

  - Must end with "_HEAD", except a list of known irregular root refs.

I feel like the world would be better like this.

> > -	optionally contain some additional data.  `MERGE_HEAD` and
> > -	`CHERRY_PICK_HEAD` are examples.  Unlike
> > -	<<def_per_worktree_ref,per-worktree refs>>, these files cannot
> > -	be symbolic refs, and never have reflogs.  They also cannot be
> > -	updated through the normal ref update machinery.  Instead,
> > -	they are updated by directly writing to the files.  However,
> > -	they can be read as if they were refs, so `git rev-parse
> > -	MERGE_HEAD` will work.
> > +	Pseudorefs are references that live in the root of the reference
> > +	hierarchy, outside of the usual "refs/" hierarchy. Pseudorefs have an
> > +	all-uppercase name and must end with a "_HEAD" suffix, for example
> > +	"`BISECT_HEAD`". Other than that, pseudorefs behave the exact same as
> > +	any other reference and can be both read and written via regular Git
> > +	tooling.
>=20
> Pseudorefs behaving the same and using the same tooling seems to
> contridict the previous documentation. I assume the previous information
> was out-of-date, but it might be nice to explain this in the message.

Yes, and I actually want to change this. We never enforced restrictions
for pseudorefs anyway, they can be symrefs just fine. And neither would
I see any reason why that should be the case in the first place.

> > ++
> > +<<def_special_ref>,Special refs>> are not pseudorefs.
> > ++
> > +Due to historic reasons, Git has several irregular pseudo refs that do=
 not
> > +follow above rules. The following list of irregular pseudo refs is exh=
austive
>=20
> We seem to be inconsistent between using "pseudoref" and "pseudo ref".
> Not sure it we want to be consistent here.=20

Makes sense.

Patrick

> -Justin
>=20
> > +and shall not be extended in the future:
> > +
> > + - "`AUTO_MERGE`"
> > +
> > + - "`BISECT_EXPECTED_REV`"
> > +
> > + - "`NOTES_MERGE_PARTIAL`"
> > +
> > + - "`NOTES_MERGE_REF`"
> > +
> > + - "`MERGE_AUTOSTASH`"
> > =20
> >  [[def_pull]]pull::
> >  	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
> > diff --git a/refs.c b/refs.c
> > index c64f66bff9..567c6fc6ff 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -905,6 +905,8 @@ int is_pseudoref(struct ref_store *refs, const char=
 *refname)
> > =20
> >  	if (!is_pseudoref_syntax(refname))
> >  		return 0;
> > +	if (is_special_ref(refname))
> > +		return 0;
> > =20
> >  	if (ends_with(refname, "_HEAD")) {
> >  		refs_resolve_ref_unsafe(refs, refname,
> > diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filt=
er.sh
> > index 948f1bb5f4..8c92fbde79 100755
> > --- a/t/t6302-for-each-ref-filter.sh
> > +++ b/t/t6302-for-each-ref-filter.sh
> > @@ -52,6 +52,23 @@ test_expect_success '--include-root-refs pattern pri=
nts pseudorefs' '
> >  	test_cmp expect actual
> >  '
> > =20
> > +test_expect_success '--include-root-refs pattern does not print specia=
l refs' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit initial &&
> > +		git rev-parse HEAD >.git/MERGE_HEAD &&
> > +		git for-each-ref --format=3D"%(refname)" --include-root-refs >actual=
 &&
> > +		cat >expect <<-EOF &&
> > +		HEAD
> > +		$(git symbolic-ref HEAD)
> > +		refs/tags/initial
> > +		EOF
> > +		test_cmp expect actual
> > +	)
> > +'
> > +
> >  test_expect_success '--include-root-refs with other patterns' '
> >  	cat >expect <<-\EOF &&
> >  	HEAD
> > --=20
> > 2.45.0-rc1
> >=20
>=20
>=20

--fjILm1XicTPsoZeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwnfYACgkQVbJhu7ck
PpTUGQ/8D7sWjBxKy3mEwAjnx8W6SvbQvzx/7a/HHhoXmn5kIE2SPTosWWFLeO/u
ZGtXTptWmw1PQcZYJEHX8B1Ge8xAStX68Y6Kj1lLwYA+mfJeIIz4BVnfgTKpZQEB
4kXKNT+yNPfhR2j7A0nkj75U/0rg45YWQoF/iTIEYXGohwIw9d0vZfQAlKHF6UiP
uMI2QrqtcQhtTAAmVjx+Rcz0hI2un4+L4MV8T//IKBGtpN0TjvizZkDel+s6RHxS
Opdw8UEwMPrYGuqGsEKQ3iav7uSu5UCNLpgptR3eQnZf7LdsfRuB6bUO/9DPKmk4
TLg4VaX/3UNZoamZIs1ivyy9h3iUjaSY2sgiexvIpRA1xZHXOt32B8yZ/4edNrKW
pydAI6NCl81p+HU5DogogfnE6FPdiJY3jhbdolQIgPsrFck//RYXNd/5UuerrlL6
MCsWu3mOVqnmHm0up4ZF51MMpxLErr3b9zdcFFjO2JQ50q7ABRHWMLy5cK1H/ZwR
N/JFsMQx9LelIeABqUGKHU6ksiLFDDOfdK7FEeadMo8p5/FFzD3BjD2CMTPRW9WP
HB8+cLD+YDHG9EHmPXwonf4uu2ND+a8bWgmrlLLL3X6H+V300AAii5GZA6GcKLg+
s2hzgiDoi6NIbU8Mi0A26JkkGmFOn6LjEU5m0dgikOqGfNbT244=
=+RHf
-----END PGP SIGNATURE-----

--fjILm1XicTPsoZeV--
