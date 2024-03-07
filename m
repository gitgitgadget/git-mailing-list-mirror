Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41931848
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793440; cv=none; b=OfBqccyVdFYm1SnVTil/rB4FvjJ9T8RR9chJLWs9IVnslHRVEGJq15vKQSTEl3uf/ircCzrFx5qrrDOTKyI/Y1Nfm1mCrp8sGbRcWcg9Az7d0nRYFCrlt43W6f//G58zyhV5INkQp9Ch2oOTUV73uK1Efn+9oyDtxLB+MVaHKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793440; c=relaxed/simple;
	bh=kuVTgU311d3naekMmqi/5KWy8zaOxN6hJQK4gYIN4HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbaSpBmqnL74d7DemrUQIihjtuUJdAnPQySVWE+b2KGB6vS0l0yhTuMNFRg1vlqVJdaR+/VQxouJF8AmXw/2T3TgotKKy9UXL/qEuUXOHFzaZfGD6ADCU1bmKCEy5UzAk5YDGsfbXoAT/FaLXwBlzxtjszCC7Z9K5twWJdSv/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qzWEEpLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naNKBpoh; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qzWEEpLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naNKBpoh"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id C1BE51C00090;
	Thu,  7 Mar 2024 01:37:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 07 Mar 2024 01:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709793437; x=1709879837; bh=dMKCJGRClK
	+8AorH590kdbd4Qbfh95uQH5uUzZE8qNc=; b=qzWEEpLBqzCDkixfV128g7u4wv
	yFL+YY+9ivpGTDIXTyGUcsWfg3jJ8s8u0TRJv2oRE/EQ1bfzm49lHz5qNWjzxGhu
	giiYJce4HAXuvKGW2NUlUtbBRRfdxxWrWeuU03wWVV9PzNMEQcKRFlHNBGxFroma
	SjQGNlLq04/VlH2vyfnoE9PoDsKUrkfdRDSIa9rID35G33u4LsKtZW9VO/4XQ+mD
	tgLwUhmxrMKsdyh6wgwmT+qjl8aE+T0G6I8rfv0DSz4ToVLboq/s+NB6UNlO+e70
	+5Fcfa7DQO3cmP4yOMGTqlAxcEciOtesAbOoZ7Cz3ZR28J3YaAGCEpeQd3/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709793437; x=1709879837; bh=dMKCJGRClK+8AorH590kdbd4Qbfh
	95uQH5uUzZE8qNc=; b=naNKBpohz5r0TFIrqIMZv2rz8Fe7r1JFWgWOunjy0rEA
	hIUxTASRqKwC3T2UCbpDJK92v5vMErwEq9QEtjweVYH5OxfLYloH3D56i9ymZN9H
	mas64EPAifb8U2B70kQ2315iiQ41wFrujn/xSZSGBS+gipenepfT/JFDXCEvmmzz
	JUf5x3MRop4y+FY96CAgi3s4VOhaewMfmNgX+CmpzAhzK5T0HcL6PeOI7wafw03r
	O0vcTxs3DJJUPCtWQmg/FHgWKhcdZk6U6z2+qg2smKo7al6IdlPlqegvyJELFOpX
	kHeYBPBRYHl2FLXNPjH+2hHpzb1nzK02C06bwLRwFw==
X-ME-Sender: <xms:nWDpZT8cy_sCKpM6Ah9EWgtcyRLvh7EYm_VOlg1L9-vP-rSJq_i53Q>
    <xme:nWDpZfu85aQUBcdOt9ePPFKNrUoqp6AgKvQFCAgaDEJgwQJZDu2mTpnRUzk_Kizmo
    uho24bLJoLwTHU11Q>
X-ME-Received: <xmr:nWDpZRBRX3aCmwIFPIueThA112DwXYr52W1SCSFMi962GR-R3c4NR_Cf_Nj_K5jDXhw4xRmKDbzD7Mt2bptok6dk9hQ4mOYNKVHIlVJIPF0OEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvkeefgeehteehteejjeejgeetleeglefghefhjedthfffhfeffefhveevgfejkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:nWDpZfdPDek16LpShI1vauY3ftxxPfiDnimr1jAQOVK7mQX9VLIgrg>
    <xmx:nWDpZYO6elZQCIP5smJFEute_DCjDxVsMQMMa3qha7oAfSDMaPtaIg>
    <xmx:nWDpZRm4fSEDtxV2DlCMCUWRHNpkb_cIw0x-wJRk30PNisRx7zXskQ>
    <xmx:nWDpZRZ1Y26fpQRM-oWmwIWrsu4j1MI2oN5vr54sVE0mAVH1JbmqgVbfFpg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 01:37:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b80bfe95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 06:32:44 +0000 (UTC)
Date: Thu, 7 Mar 2024 07:37:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/8] builtin/config: track subcommands by action
Message-ID: <ZelgmZEQDDgeHEaa@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <e39774d6495767c6505999bdc33110678139e347.1709724089.git.ps@pks.im>
 <6044285.lOV4Wx5bFT@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k8BwkpZjW9MfVYQ5"
Content-Disposition: inline
In-Reply-To: <6044285.lOV4Wx5bFT@cayenne>


--k8BwkpZjW9MfVYQ5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 10:54:01PM +0100, Jean-No=EBl AVILA wrote:
> Le mercredi 6 mars 2024, 12:31:50 CET Patrick Steinhardt a =E9crit :
[snip]
> > @@ -851,20 +868,20 @@ static struct option builtin_config_options[] =3D=
 {
> >  	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("us=
e given config file")),
> >  	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("r=
ead config from given blob object")),
> >  	OPT_GROUP(N_("Action")),
> > -	OPT_CMDMODE(0, "get", &actions, N_("get value: name [value-pattern]")=
, ACTION_GET),
> > -	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [value-pa=
ttern]"), ACTION_GET_ALL),
> > -	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: nam=
e-regex [value-pattern]"), ACTION_GET_REGEXP),
> > -	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for t=
he URL: section[.var] URL"), ACTION_GET_URLMATCH),
> > -	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching vari=
ables: name value [value-pattern]"), ACTION_REPLACE_ALL),
> > -	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"),=
 ACTION_ADD),
> > -	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [value-=
pattern]"), ACTION_UNSET),
> > -	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [v=
alue-pattern]"), ACTION_UNSET_ALL),
> > -	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-na=
me new-name"), ACTION_RENAME_SECTION),
> > -	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name=
"), ACTION_REMOVE_SECTION),
> > -	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
> > -	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> > -	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: =
slot [default]"), ACTION_GET_COLOR),
> > -	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting:=
 slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> > +	OPT_CMDMODE(0, "get", &action, N_("get value: name [value-pattern]"),=
 ACTION_GET),
>=20
> I guess value-pattern is a placeholder. So for uniformity with the
> style guidelines, it should be formatted  <value-pattern>. This also
> applies to other placeholders below.

Ah, indeed, thanks for catching this!

Patrick

--k8BwkpZjW9MfVYQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpYJgACgkQVbJhu7ck
PpRDag//ebUiO5SHBVSpkfrrcmU1R7iT2+oG9H5bQ+um/BUJ855kK2jRIwepTSz9
XNKdm6wgVE4bHKZUx4m2zFMC+3+2VUJM0m60ZCXfmJrK3UmmDvq72AkgIJ5RdDJg
QkJWh4PUA9AMleB9CWCnYgA2ZV7V5MVoxoL7u988ocpFX1cGdOgrNjrzCYdCCUpg
86On+vGbP+6/uwDpqITthBTNCBL+fY15GhDg4oQSttglZbhV96MfmckbFbXEboIu
DoCjNwO0Z50j58whe80rveWvheULc7gYuwC7YyevM6jUTglo7FZ6I458wqiCl0FF
9XXO2PTMX3kvGHrCwMjXTFd3i4cYXsvOJ711dVJh3yG1J04ik5YT90Wf/x/OaY+B
GHnDZA5MJQtfhYM3Uqm0ZYSJFu521qGlh3Oko6Vw9URMUPc6F2/ckdKdeBxpcEt/
lIWwrJUf8p/aDMSmLxRXJVHl1+2ZIugKJWtumaN5V2gjQGqkw34DkLme4qMZChfI
NADJlAfjJdmuo6ZSdoxDspT6vEI3S4wXAeFHvJtp01IqjTOSXeDW6gS4A92SzTdo
yMYVAT6ASyunCOwEK1ENGLrBsjg9eYvygEL0TTe0BVT66W9+Gax4Tzx+RTUaZZOt
zA3OzfeKVYMZY01tmuuiSE8kE2C38I/p+ss1Fo8kGq6Kw+qL5RA=
=ONUf
-----END PGP SIGNATURE-----

--k8BwkpZjW9MfVYQ5--
