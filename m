Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782F7FBA2
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724698; cv=none; b=Nef2L3Bo/eOsO62LaByjpM3h2R0j49JZ67pGJVM9EpAt2SGEG5dTUOM9RrwrhGvUjovRrc1LKHLSpTsFRJdnZL4ZiHfhcPZKVPrIRPicOhw0r+hy6KbekGTB0LPF/5gv/v3rYEc/YOGeduMDpV5j2/FgcHGJUgPMA1veSFKlZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724698; c=relaxed/simple;
	bh=esUL95X2Tp2i9uQFRXTJqzouOIgk0HhhcpwEVOYx2TE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PB8n4Tw3WLQfQTD45WDdT1UPh4vr28TQEZAPXK8jym3CnLnPC2tnI9Hg9FiXWl0dYAt2U65fCn0vlS59NB4a6Jnb7148ZnEyUO+tjlBe7BWKfoNQSGzhWKgrAA5VexpgDhQVSbYOX9+pVWJczscRB9+bWAOZMQXHt9jQLZm1QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EOBl2pVF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6HvHVLt; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EOBl2pVF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6HvHVLt"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 56B055C0073
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:31:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 06:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1709724695; x=1709811095; bh=3/PBnktpd629mUFU45YAwHoN3LQHiV2Q
	sp1tZX+wdBU=; b=EOBl2pVFdZylPeQuaC9I7i9nwglmSRbejJTcQ5bdI4pDIoRL
	iaeI9AiQifmo03JTyw+Jg0BiVKQtuS4MuoDNlnpxpBu1LUcqkxPRd+ZEu3WSF03+
	k82XkzYz41QCFGVew4jUEoiZbJkkJ5NdXW5K4a8ez/Wd6RRn8U2jx7P8dSxibzAV
	3O7DvBXqdDxFn9/EyW8gt9nUDfa4jBUI4u4m2u6b5keltNedRFEoJtPpe0ozdT4B
	CVM4lNGnK0tQgKu+EMWNV1goGgHAYRoq7iy4nQqaW6gVBBDRBp6KDpB2uicREo2a
	ekuVvoc0BYHt0UHNpkSdboXKSexcoj+r+e6GZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709724695; x=1709811095; bh=3/PBnktpd629mUFU45YAwHoN3LQHiV2Qsp1
	tZX+wdBU=; b=P6HvHVLthPANSxD3jGpRUjUF/MhJnBPv1Qp3bMvyqdb8zaaWUko
	mWv9fAbbpIA1ODzLS+Ig6mX9K51s8FomP6DkOCmPQ/25KM6fM5FHt/7kb9DFgKoV
	xJrY0tb94LbUTFvIb4eE2XCNf0mzkzMkOTuKL6JggmCCYr6c//TW7Yu0jUpFe90S
	LXu7n9IB2gmckNJpLoiHQ0U5zexi1w4RF4ApsRMnePT00Q7ZcPgR9kgqllVE8ApZ
	3wY0zj/+yLJVuUhB19r1mlCF0/adbokKHllCuqYJPsRcEBcIdW4zwehz+x/7dO6r
	jw2Vvq9qEqkEJoCKY0cKdKsTr31oRr7RUGA==
X-ME-Sender: <xms:F1ToZbsMBGNzXXVwfMgRF8SEM49dx9NLhrQogAEL0k8LeJR1K387mg>
    <xme:F1ToZceJg_rz19F_yOIxjGe93APyVtedctTO6bvyGqUljr2eOARtO5gSCLoHhUw3t
    X_834Zpo3j2BS2m-w>
X-ME-Received: <xmr:F1ToZezLnmTS3IHNi7z6jOBtnVDPdWIi0jynF1wCyoEWytVTrd6qdspsvppIE1deab27JI27xrq9m4RXl8vPW6PJA691snuaxVHPYqc4GWa81Qh4ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:F1ToZaNHRm2HXvZPd8hPwTH0jO4r_8eXz01clK87UCanDCeriqXSng>
    <xmx:F1ToZb-20EtTjWG90DBuOSXjsxC4B52rrHcNmQr7nWS7hl8zp6WBFg>
    <xmx:F1ToZaUFCGccgBw4y-qV0K7pq6AWj7GN1h5eaFcjUbZ6xbnnjX-MLQ>
    <xmx:F1ToZYH6iM5tKXpjYSgKIsX-bsPiIlbxJYnaBSYI_308wRpkQyqjYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:31:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac299bc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:03 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/8] builtin/config: introduce subcommands
Message-ID: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NO+MGW/d8abR0+nO"
Content-Disposition: inline


--NO+MGW/d8abR0+nO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the UI of git-config(1) is quite arcane and does not really conform to
the more modern UIs that we have nowadays in Git:

  - While it does have modes, those modes come in the form of switches.
    E.g. you have to say git config --get-all to execute the "get-all"
    mode.

  - Its interface depends on the number of args. Given one arg it will
    print the value of the corresponding config key, given two args it
    will set that key. Did you know you can even give it three args? I
    didn't. Now guess what this mode does.

This patch series overhauls git-config(1) by introducing subcommands.
This results in the following UI that matches more closely what we have
in other Git commands which are more modern:

  - `git config foo.bar` -> `git config get foo.bar`

  - `git config foo.bar value` -> `git config set foo.bar value`

  - `git config foo.bar value value-pattern` -> `git config set-all
    foo.bar value value-pattern`

  - `git config --get-urlmatch` -> `git config get-urlmatch`.

Most importantly, this should help discoverability quite a lot by now
also having a proper synopsis in both the manpage, but also in `git
config -h`.

Of course, backwards compatibility is a big concern. We don't want to
just switch over to the new syntax and break all existing scripts and
muscle memory. This patch series thus abuses the fact that the implicit
modes (`git config foo.bar`, `git config foo.bar value` and `git config
foo.bar value value-pattern`) all require a key as first argument. As
keys _must_ have a dot, this allows us to unambiguously discern those
=66rom actual subcommands.

Thus, git-config(1) now supports both old and new style arguments in a
completely backwards compatible way, which is also demonstrated by the
adapted tests. Eventually, I think we should consider dropping the old
style syntax with e.g. Git v3.0.

We could of course iterate further from here and keep on improving the
UI of the new subcommands, e.g. by merging closely related subcommands.
But for the time being I think it's easier to stop at this point and
revisit the result at a later point in time.

Also, note that I see this as kind of an experiment for how to modernize
our UI slowly over time so that things become more consistent and thus
hopefully easier to use in the long term.

Patrick

Patrick Steinhardt (8):
  builtin/config: move option array around
  builtin/config: move "fixed-value" option to correct group
  builtin/config: use `OPT_CMDMODE()` to specify modes
  builtin/config: move modes into separate functions
  builtin/config: track subcommands by action
  builtin/config: introduce subcommands
  t1300: exercise both old- and new-style modes
  Documentation/git-config: update to new-style syntax

 Documentation/git-config.txt | 204 +++++-----
 builtin/config.c             | 671 +++++++++++++++++++-------------
 t/t0450/txt-help-mismatches  |   1 -
 t/t1300-config.sh            | 734 ++++++++++++++++++-----------------
 4 files changed, 900 insertions(+), 710 deletions(-)

--=20
2.44.0


--NO+MGW/d8abR0+nO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVBEACgkQVbJhu7ck
PpQroA//cA1PO3lBstjAkiDDeJIo/dXWerv3nizJNI0oqPorSRLI9NuDraILEF0D
PgzCEzDNq3NJjL22uLpdTfYZCutGyaDK1rz/nNHtNpC+cEsRdBaq/TjODH9UBOBa
w4vdlvNGXdZsAKE1zNuWT6CDUW4NRdRF1naYMFZmpzBenub4FV9z93yB1aztaMrU
gH4b2FikkgV+k4TZdPm3QaILue6Gl2HSzR7lv3FqSHSiT18kOG1vF7DFcTOjVGk1
q+FOGDOX2DIMowUb5xfIQ+Hqoqb9q2tSsVsYlNznY6+9XriDC+ucmHCOqgpEECBS
MlT21gBySYrItvaXd98VEBolBnEIDXy68k9/lGfFdcRyYvf5KbZuX4wEMW5+Jtt0
oYGyUWPo+oTi1ob4KYIfs1LivarXWOnAlubl61oABupPk3+yj8A2PgnEl1Q3dgur
J3YuZ5VARSj8WrRUiSsqkFuueoH8vuTn1Afwq62/sC4HqKYugZFCEYuOQMq4xF/9
J0gXjVMvtN4+XmDcajAmMJB6lOgOpt53ePaqFluuV8lxMDxJgbkzdDoWVQZbap89
WFbBUrENqELLBFo1XZQ4LuGuw/GVRC12Rl8bxbZxSv7dH0Fn++H+PoaJ1cuwLUq7
Zylb8TVJMvVIjRQP7YRANswzdsNhKvnGumcxyyF6mXXRk4myEcE=
=Cz4h
-----END PGP SIGNATURE-----

--NO+MGW/d8abR0+nO--
