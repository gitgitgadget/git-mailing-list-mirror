Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1B18AE4
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488350; cv=none; b=dKEI/9ZoHc2BKgPb3Ty03eatLpztK/rGXORWyjmMZAeQ7rnbzgeZ4fMicx76tb8uKbcoUNMPC652RKwqZsrlG/xN+Lk1Bf12pWCOeyjUl8Uloavli6K5q0K0M7Z0o8w4K+ZnQtIrAXy8K6He0WaxKS4Jnc6jBUa+i3TUv2XygxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488350; c=relaxed/simple;
	bh=pptEtJI3eKnAU0GPeQhNJuXCJgQi+VXYeD2xDEw+CL8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qei1qNp3EZhCGv0z5AjGjsASisQXwRdMTFC+u8Dxe0W/Jyb/G2utuQWvs0s1KJvO2aZrcitTAUDowLg/solfJioTyYX+7pZtLx9Sh/MdSijdJAZHcK39K6pKDR5AJHFs3K+QbBhyrBOUKi/pZI39TSu5H9qOLpCI/b+hDaGqIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AS2cZyY/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDHRGh3R; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AS2cZyY/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDHRGh3R"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id D37AD180012B
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:45:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Apr 2024 10:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714488347; x=1714574747; bh=pptEtJI3eK
	nAU0GPeQhNJuXCJgQi+VXYeD2xDEw+CL8=; b=AS2cZyY/ZOtJhHTMbrrAjEmlgm
	T7nBqv7IDLnKIOgsPmBDPviLYvQAvsMoD94asqCEZwRFK6vT8ytZ/1Q5hgQT5W8R
	CWPnOyh04e/ixalxl/OuT7c+am7TnvaplF27TsO3kdDzc0aP+5UYAaoWR2NR6/VB
	N/NWIV7XkM3tAWPc5CYS7dJx7ppZFxtfSoydrXErDT0m1aUayLpcOl82zyEF+54S
	v0skhbjElMzaYZd9CvVXrx5yoxBC9gUEb3/QfMmC/TlceKaCfoNmn1wj+y3qeEuO
	9THrS728NX+Rz80mZxOv3A+fQv13Hpj4wtT7b+zn16i7Dg2A/0HJ/0qNBD3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714488347; x=1714574747; bh=pptEtJI3eKnAU0GPeQhNJuXCJgQi
	+VXYeD2xDEw+CL8=; b=eDHRGh3R4ifzShL5oxS771hDc6HkqUXAYGJVeMWCiH/y
	qGFyaKjG2AqaCwH3Ktk1zKNF+vM1iDU3pRuWlBZvnceJK259tTRHTO8hjB0lpe2t
	KwKLHfu4WuWf0nylUCkYONac2PIc5Ire5hYYTFXrzxEts9SAFfnmERht52FUxN4Y
	1BOaZhTf+2jpyU0PCBUpImLE7y4oJlo68UfdmMzrSJpN391xvVbd3egFdTR8Azhp
	vVSM6Nru7T19U+NTllOK2y/1WboHUJCLdTA6YnhUW4u7bQ1DQJFsc2TYxOMvobfh
	+TMjG5FXYsdFl5w4FiFAGjw/eJzTmWZSIlcb3XLDwg==
X-ME-Sender: <xms:GwQxZrSK-w1ntiETNQ_8Cn8pub2npDhYOUXSB6bS_uLiG8Dy4hA2pg>
    <xme:GwQxZszinTDI4olkUEH8hEOntqCTMXD7WqmGFrSqgx60ghbV8N09Wa-3ses0XfXuy
    J5JUADwM4ECbSdxrQ>
X-ME-Received: <xmr:GwQxZg0xbYD2iId4kl7sv_Fmso0WNnA2_BMs0TaCGS6q0sfuGLL4-5SY662XTYIUzxr29Kt0E6kmnRUOvOTM7_I6QkDfpn4Oa_GtXMbOmMUu44gcgZ5Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepjeejtdeigfegkefgjeehveevjeejveeuvd
    dtieekffevleeglefhgffgjeejfeefnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:GwQxZrD8bou-9591JTCgzP0V_doGpuvHCt5SJzdh3r_pDxTf7qxGRQ>
    <xmx:GwQxZkh7y-MzUgoI-8nBWP17m9KQQK5s55vu4-dqtiM83eTISYHmAg>
    <xmx:GwQxZvrJrGWfsqXWC-C9ygNLuZjLni0S2fdbJBR1n10U750hNnunzw>
    <xmx:GwQxZvgsHvkHOtEtNckJjXx_sPufqPoKX-xFfVMpej9DkXWC_5WPqA>
    <xmx:GwQxZgbuBtlxbqzC_TG5SPzZOqcrzg16JulJgMHXIyk0UpWYUNMIV9oJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Apr 2024 10:45:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 566f132d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Apr 2024 14:45:23 +0000 (UTC)
Date: Tue, 30 Apr 2024 16:45:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <ZjEEF-5xGl6tjOAG@tanuki>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <ZjB77nSMou0ssu-V@tanuki>
 <zphrzgroei4civl7q2ls5cvabyzjbexfq6tjhdy476rmaqu6m5@ik3pedton6ww>
 <ZjD6xNuncrq9fSXZ@tanuki>
 <l55hxxuv5ohtno3gfjgq6mu7cqakfohon4vd7r535ztzadarin@iz4fbuwjeeug>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q0tUzo2UtaxZm3hp"
Content-Disposition: inline
In-Reply-To: <l55hxxuv5ohtno3gfjgq6mu7cqakfohon4vd7r535ztzadarin@iz4fbuwjeeug>


--Q0tUzo2UtaxZm3hp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 09:41:47AM -0500, Justin Tobler wrote:
> On 24/04/30 04:05PM, Patrick Steinhardt wrote:
> > On Tue, Apr 30, 2024 at 09:00:59AM -0500, Justin Tobler wrote:
> > > On 24/04/30 07:04AM, Patrick Steinhardt wrote:
> > > > On Mon, Apr 29, 2024 at 07:33:23PM -0500, Justin Tobler wrote:
> > > > > To check for whitespace errors introduced by a set of changes, th=
ere is
> > > > > the `.github/workflows/check-whitespace.yml` GitHub action. This =
script
> > > > > executes `git log --check` over a range containing the new commit=
s and
> > > > > parses the output to generate a markdown formatted artifact that
> > > > > summarizes detected errors with GitHub links to the affected comm=
its and
> > > > > blobs.
> > > > >=20
> > > > > Since this script is rather specific to GitHub actions, a more ge=
neral
> > > > > and simple `ci/check-whitespace.sh` is added instead that functio=
ns the
> > > > > same, but does not generate the markdown file for the action summ=
ary.
> > > > > From this, a new GitLab CI job is added to support the whitespace=
 error
> > > > > check.
> > > >=20
> > > > I still wonder whether we can unify these. Yes, the GitHub thing is
> > > > quite specific. But ultimately, what it does is to generate a proper
> > > > summary of where exactly the whitespaces issues are, which is somet=
hing
> > > > that your version doesn't do. It's useful though for consumers of a
> > > > failed CI job to know exactly which commit has the issue.
> > >=20
> > > Just to clarify, this new CI job still prints the output of=20
> > > `git log --check` which details the exact commit and file with line
> > > number of the whitespace error. The difference is that it does not wr=
ite
> > > an additional markdown file with links to the commit and blob.
> > >=20
> > > Here is a failed execution of the GitLab whitespace check job:
> > > https://gitlab.com/gitlab-org/git/-/jobs/6749580210#L1289
> >=20
> > Okay, fair enough. I'm still of the opinion that the infra here should
> > be shared.
> >=20
> > > > So can't we pull out the logic into a script, refactor it such that=
 it
> > > > knows to print both GitHub- and GitLab-style URLs, and then also pr=
int
> > > > the summary in GitLab CI?
> > >=20
> > > We can do this, but for GitLab CI there probably isn't a point to
> > > generating a summary file since there is nothing that would pick it up
> > > and display it. Having links though directly in the job output would =
be
> > > nice. I'll give it another go.
> >=20
> > Well, we could print the output to the console so that a user can see it
> > when they open the failed job. The nice formatting may be kind of moot,
> > but on the other hand it doesn't hurt, either. I guess most people are
> > used to reading plain markdown-style docs anyway.
>=20
> I'm thinking we can generalize the summary writing in some manner. When
> run as a GitHub action, the summary can be markdown formatted and
> written to `$GITHUB_STEP_SUMMARY` with no output to the console as done
> today. When run as GitLab CI, the summary can be written directly to
> console with links. All other runs just output normally to console.

The script can probably be generalized to take a file name as argument.
For GitHub we'd then pass `$GITHUB_STEP_SUMMARY`, whereas for GitLab we
pass in a temporary filename that we than simply cat(1) to the console.
That'd allow us to move the CI-specific bits into the respective CIs
whereas the script itself remains generic.

Patrick

--Q0tUzo2UtaxZm3hp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYxBBYACgkQVbJhu7ck
PpSbqw//ZErBD3M0Hy/gVjqsPrLlIVOu7jOBpLz6JaouIgcWjjlIKUFZwaJfQU8Y
2PivbgaIMYAeFzVfvBS8kMw9Ar40w/pbymmRWwH6FRxlDlKMZZ0hfm3nJ3mm0eFE
e8zyp67UjXutnW0m8yzkf4Hf1P3Or1GqLf4uTMARKSEYnFXvqfbfeVl2SmSM/EyP
eYO+iNNs1HR+4yfmtTkzZKrvOkZBRlGn8JbVIlgqihMwE2EhSkenb3pMKLphMJNH
v67fRsbOYMm43wUazu2u4/tva9gXiqXhoUvtt44ga8kGRDqI+Bx6iFn2W1UQikMK
lHBrHq5/qOlu2StQ3LJu42Z8KsCHt4MMYmik/iMvvCZ8Pzv2km5lJB9U0gwKgku3
yqX+cT4J2n6f0FJYJ1kyK9zduFrucm8bKBqsVaGhTc1wKjNj3TCfF2aTA5KFRAkg
1/09TrKuyzLa9EjhkRSLZU9WRwUDL0PV0qDYW7sC8BHNVGpAsphWk1qvZfLBG6SL
lvKHeEjREqd35XghmeFW5vYVJOZhkJ3uPNAxqykLJJRN6rjr8krQul3pVGVSTAPk
GBiVLdhWrxbCeowxwCBcYtGvb1WkLxXnuIZwqFejPpvA0SHMIY00yjHpSnD4/ibk
zGG//wCDqSbnSMVQ2rIwGni8jnrlTfR4Rhd4OhO7rq6tyiuLosY=
=dCAr
-----END PGP SIGNATURE-----

--Q0tUzo2UtaxZm3hp--
