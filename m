Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B5172BD4
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485967; cv=none; b=cDO9yMEu3LqJkzUrPUgL6UoUr+v6XCBZWvm9l1S0I8m+r1Q8Lk6XSaiV+QzeagrXVcURgLS2m2t8/pYOB30FW2/PPZ2ByXEuY1TwWljM5R/W4ZLKLGRI75ws8E2bP0kc6bMVE8gIHqMAsILBQvEETjcAnoiTeTccz6iprIfeMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485967; c=relaxed/simple;
	bh=kJrEV35tLhmBp3ttUtWFf4qYiccohVQ0Fzk5L8nWiow=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mok6UDVLf6cRbEzNtmIVG5sVIExT0jpxkyo6D1dAEPR92i7tzst80paic5mg9tmaMCRUOxLddFIYdRwx802k+z9eBF/7jZwapQofbY3iYnRX0dLWTfv4JpOjQizyGvF5MF+nK5QK7QWT8gYBOwXPl568Fz9YJD04Poj0c6Lvubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H7rkTmuj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYITRc1E; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H7rkTmuj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYITRc1E"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 255F01C0019D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:06:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 30 Apr 2024 10:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714485962; x=1714572362; bh=kJrEV35tLh
	mBp3ttUtWFf4qYiccohVQ0Fzk5L8nWiow=; b=H7rkTmujvBMUCFW7RbIXJsH3dA
	5FbIXw2Wd2M4xikDLmGTX7GedJkWNq8sF0UckFC9+3BwjzZwfSMA11thMJUG4n19
	pBJiO94XfjuEi1GENwsm+9FfwKS1MRfxZ+/dxClwI66/uDFrLMYuJuAFQSMppMK2
	9j8xdSSLduq/JZCQ5dwSRKhPE8suCTo5suuOWHHjhJ6BaGXiV0led4hRHBOnc6qq
	OXPIgNljww9K/45ZLRdcp19yYQrVQkZHBtXuCgYc3eY8L8LXfDo6k4OU5p7A50bu
	3MSOfuxitPv9PdykRFVOWE/n5TeXIiVJcEsy09896Lpm3bxmw9XN4F1p9iAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714485962; x=1714572362; bh=kJrEV35tLhmBp3ttUtWFf4qYicco
	hVQ0Fzk5L8nWiow=; b=VYITRc1E+mmmLVNVwbmV0BvmLN92XAGLoF/ffUSqt/L9
	CZZ1A8H9X1qz76x+d9ewYJXfJLyN92F6UFGx7B5+Ye8s0NzHCaBviIaCeWkzaJlT
	woF+t57WvxumS7h2zr4etTYi5FQWgYVVs/5/KUCqvXFuLwcsAr4aD/NJ74z+kTm7
	vDTCF6wLbo30h8VclIhoGzpr/aGcpo2HrgJsr1Ppp7v+grDDpycz8kjSKQeTvJmu
	l9DO7Oa8NIhKd86t7UQJuz8VzUjD0Ua+fjHN7CmZxocLaXlZ5uR71jNuRNgUh8nG
	LZuMJPLrnSJ2ANVGBtPx2VbTwE7XAIKXdo3mhrowsg==
X-ME-Sender: <xms:yvowZvcyOuNicXHKcNchYfkJ5AxwwZr9oCuE309VIHG9k9R9riIZMA>
    <xme:yvowZlO5O3_azY7fTf5_h52U_FdPZFDI7_Y__3NDECeyodAqmWK1V00Fvv9Z_djMJ
    ST9W4vtqnLUauqOaQ>
X-ME-Received: <xmr:yvowZojS0p7FrgmbNvEsW1yczEQJfy6-rc9E1EYeosWSGvVyGYU0iDsmdHqh8AsGJYV_fZF4C8GuzRXktnbrPRP65fk9qZwbkSg73rxlzlVkfj1Qt9ry>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepjeejtdeigfegkefgjeehveevjeejveeuvd
    dtieekffevleeglefhgffgjeejfeefnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:yvowZg9ALVPTk29R8PJ7WIDGZk0gkD8Ss4X6Db-gQ_-w-VpuGXv8Jw>
    <xmx:yvowZruE6V0iAaGs4F9lYJ0AQylaiucuYMAgLuHc7Yi-4OQFtV2x6Q>
    <xmx:yvowZvEh-NAt83x2fQFcuxG-5SpsmVRmmekvCeIr6UOqsKIgr-L-Ug>
    <xmx:yvowZiOL7qIY-xiUxCQku-beG02_tTvDBsVfUP9be0SqkXFV1X1lUQ>
    <xmx:yvowZkWeIILnvdulGzMNuiQqMIbO8uSr8GOzEPdY2Sy1gchY-3GXh329>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Apr 2024 10:06:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7c2bf850 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Apr 2024 14:05:36 +0000 (UTC)
Date: Tue, 30 Apr 2024 16:05:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <ZjD6xNuncrq9fSXZ@tanuki>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <ZjB77nSMou0ssu-V@tanuki>
 <zphrzgroei4civl7q2ls5cvabyzjbexfq6tjhdy476rmaqu6m5@ik3pedton6ww>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RYrr4g3lEdiv8U3e"
Content-Disposition: inline
In-Reply-To: <zphrzgroei4civl7q2ls5cvabyzjbexfq6tjhdy476rmaqu6m5@ik3pedton6ww>


--RYrr4g3lEdiv8U3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 09:00:59AM -0500, Justin Tobler wrote:
> On 24/04/30 07:04AM, Patrick Steinhardt wrote:
> > On Mon, Apr 29, 2024 at 07:33:23PM -0500, Justin Tobler wrote:
> > > To check for whitespace errors introduced by a set of changes, there =
is
> > > the `.github/workflows/check-whitespace.yml` GitHub action. This scri=
pt
> > > executes `git log --check` over a range containing the new commits and
> > > parses the output to generate a markdown formatted artifact that
> > > summarizes detected errors with GitHub links to the affected commits =
and
> > > blobs.
> > >=20
> > > Since this script is rather specific to GitHub actions, a more general
> > > and simple `ci/check-whitespace.sh` is added instead that functions t=
he
> > > same, but does not generate the markdown file for the action summary.
> > > From this, a new GitLab CI job is added to support the whitespace err=
or
> > > check.
> >=20
> > I still wonder whether we can unify these. Yes, the GitHub thing is
> > quite specific. But ultimately, what it does is to generate a proper
> > summary of where exactly the whitespaces issues are, which is something
> > that your version doesn't do. It's useful though for consumers of a
> > failed CI job to know exactly which commit has the issue.
>=20
> Just to clarify, this new CI job still prints the output of=20
> `git log --check` which details the exact commit and file with line
> number of the whitespace error. The difference is that it does not write
> an additional markdown file with links to the commit and blob.
>=20
> Here is a failed execution of the GitLab whitespace check job:
> https://gitlab.com/gitlab-org/git/-/jobs/6749580210#L1289

Okay, fair enough. I'm still of the opinion that the infra here should
be shared.

> > So can't we pull out the logic into a script, refactor it such that it
> > knows to print both GitHub- and GitLab-style URLs, and then also print
> > the summary in GitLab CI?
>=20
> We can do this, but for GitLab CI there probably isn't a point to
> generating a summary file since there is nothing that would pick it up
> and display it. Having links though directly in the job output would be
> nice. I'll give it another go.

Well, we could print the output to the console so that a user can see it
when they open the failed job. The nice formatting may be kind of moot,
but on the other hand it doesn't hurt, either. I guess most people are
used to reading plain markdown-style docs anyway.

Patrick

--RYrr4g3lEdiv8U3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw+r8ACgkQVbJhu7ck
PpTgSQ/+L7op8PoTrA3MtG/Ll0bN8AddfIK6Pxk2VyRvejhh+TpUgS0XH+1+WPgt
RVlGDFj04H/9yKyDSLYn1IFgJmr4zxVzVc/VY5tnKZCwSQ2+8PJQh/N/d0DnheRK
pc77eAjZ1re7ueGAcB6ADSZh4BpUMChx1cAlsr1bEI+HofBoUVJ5u/qOE45mjY7T
wSoqsrAGA4MuW+yQXUDENrtdHmCfwLOinpqHFsk1eVwVPSRrh27m3c3vhbAmBuUM
pIC7nAR/h2sqVay+EtZya+eGN/jCPW/GWaOGxAjT6lI1HblNARm7rhuNh5KvwJBE
xes/lzbNaBYFt12gaUwxnmvZaGJaoy/Utz1hFk9vPmeQaAe0dtqaOo8FFE1/+DOL
Rl1hasUEbYiQCV1MTS36jHA92AaOHxmuD7Gd0YWV3DJVEhCxV/y18ij9D4HPibID
ctkn1/SotudXuuxBUxiC/up8uCO8Xqs2GEhQerBnbi3mD+csbZqwjmMG0A9tn8B5
/8gRXKBM3qdChZSJCUIClwCpziICYUeWWyNFuZTsXWZazxUeYYboz7zQm1lrrmwu
h7qCqsQv3G9uPgFtrNO1kXcQ5yqO7ue60KfkgRRljc6/mWl8BwWITV9TxPe1A+FW
BYaQcbQPjvpH6wV1Yi/vWRv9pjI/VtZ3i+7QvNUFF/ttmPbYnDE=
=Ho5z
-----END PGP SIGNATURE-----

--RYrr4g3lEdiv8U3e--
