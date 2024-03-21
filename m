Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE2125CB
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013541; cv=none; b=drzgGxNGcxHDgBys+PapGINGUo3YUTcb8M/4BZuZoxeHaVx8ox8w8B31Ozt/pg0py3tv3UFxedI7eLvztB9+V75+596MeUl20viiKT8adTNaLl9wnMojb7BmMmVsQhMjXbDdgs4qJmuJIxq1rFnf9V7qo3yE5hdB7Sai/JMEcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013541; c=relaxed/simple;
	bh=vI7wB3WH/SZd/2SWAKIi1dkC+k5znWQ5EWx8OPLBdOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klah4egTovwtIc8TtV1VGCklkxECw4cRQSVrxLNWvKQGRzRXMOlVh4u71dtW6mn0JqTtizm0eEbhpANCZeG9/ZeLzy6Ih8oq/BJutSg+J7qTGNfMD3Cn/jK13j47Kyw2Mdfo43jqEm6WwIC7Hxtj3UTQ2bW5/VSzdRHw9bXmQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m+DADlyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KimTRb2D; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m+DADlyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KimTRb2D"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id E91421380114;
	Thu, 21 Mar 2024 05:32:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 05:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711013535; x=1711099935; bh=1KlqKumisl
	ftSzdkLepFK4e2ww2jpWpX+RGgrYCYhcA=; b=m+DADlydtmqET/lhRqwsqnsBFj
	SaS+uFIVHgthYBulUTKXWc2WFrgcIiaYhfWC6dNNfAelNwfqOiZyzKJqUkC05zaI
	MbWnk9+4neVZulqC5iBiBBvI2PAYcuFlrx60+1C65aaySghhNZUxzOX+eEB51WPa
	TA3Z++dssbO4/03zQUOLxSjqwnYQwt84Jkqpn1ZHdiDdP5+zkkMy+BVw+cLu/qVX
	4K+G3xZb/IxY89fSiTCVfL7Upf81zNMuuazrDo0kqKNMC6MGMuSG23AJC+2+o4pL
	G/PMNq8O14sCcq//je10OoDQwn1MGOmZJ0hVHjefehkP7lvECoJjwRDhy+tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711013535; x=1711099935; bh=1KlqKumislftSzdkLepFK4e2ww2j
	pWpX+RGgrYCYhcA=; b=KimTRb2DSdHmvu5Dw7DmL9mcTEnd+4xoSNJPaa79r4G7
	fBz5OPMZiRWTTszoaBmT00WoH6sAtqcZ7g9meV0enEMmb/LvbCXmX7DthfLkbYCK
	xDnQyPDPgCWo2X/fR8bq36mMmVcE4WPLMQOMTX45wRtUCDM6dwAkQZA9bDjBS5WK
	ahoGROIxPJxFrZR3lslK5bTN4WEMJnBdghaVwBVLMCJkpO1eN0LQo/Fh+J1uuwYb
	SLjeww8Vch3cy+BD18ZaKZqf0aD734jWrYA1fgB/cGXpyq8ypP3OAaZ3h1zRe74P
	aUcXolFDoBt4v0QTVQrsfSTIsFzj2YvWEumYce2Aqw==
X-ME-Sender: <xms:n_77ZWXvsA0PmhB-_T_F6DNFLocaRW_q5-bRkyxgYB8i1Mo6gX6zqg>
    <xme:n_77ZSnIfFrFi47TdeYLG_ueJdjJPOC62Sic1OZjK39MlUJ9Hz8vLE0j5ppraA0Sq
    hPxsPHEYo480GxJeA>
X-ME-Received: <xmr:n_77ZaZnIq4rdl_Ily71W1uwGalMYMl_XJOv4wRcubb2bu_YnqV-xHydGIeMn8GWBLOGOsV_2llCiLQwq59Uypk_51Q-wMIUSj5zS-baEoXm-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:n_77ZdWxsNNxEHXAJuySoPif999HRrA-_XurvZAdjq17CQW92QuUEQ>
    <xmx:n_77ZQnaoMTS87OWbRbfm6QypHumrfG6tJZ86rZmZmkU7vBuZmgI5Q>
    <xmx:n_77ZSeIk4tZabeR9hR6ti286WwmRNvQVuiyz5d1McA5UK0g-FPrOw>
    <xmx:n_77ZSGUtcI1yTHTZC-khY2R_PlDd5QUkcQxDQcmOJqADzJPmqLq_A>
    <xmx:n_77Zagr4GuSHJ0XL1k_tF0sOqVTMUrWAwI-oZu4fXQQN9J6BtuQ8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 05:32:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3290f031 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 09:32:09 +0000 (UTC)
Date: Thu, 21 Mar 2024 10:32:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Edward Thomson <ethomson@edwardthomson.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: repositoryformatversion and extensions
Message-ID: <Zfv-kpa4CJJvop2j@tanuki>
References: <CA+WKDT0fAASYE_ZhSxATv2NUnYceOP-_EF1kqKNFSOWU4QdPVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AzC5b4an1/Zv9QEN"
Content-Disposition: inline
In-Reply-To: <CA+WKDT0fAASYE_ZhSxATv2NUnYceOP-_EF1kqKNFSOWU4QdPVQ@mail.gmail.com>


--AzC5b4an1/Zv9QEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:54:55AM +0000, Edward Thomson wrote:
> While looking at worktree configuration, I realized that the
> extensions.worktreeconfig configuration option was honored even when
> core.repositoryformatversion was unset, or explicitly set to 0.
>=20
> Re-reading the docs for repository-version, it doesn't explicitly state
> that extensions _require_ repositoryformatversion >=3D 1, it instead
> states that:
>=20
> > When reading the core.repositoryformatversion variable, a git
> > implementation which supports version 1 MUST also read any configuration
> > keys found in the extensions section of the configuration file.

Yeah, indeed. As far as I understand, the major difference between
version 1 and version 0 is that version 1 asks the Git client to bail
out as soon as there is any extension that isn't understood by the
client. To me this behaviour is somewhat surprising because it doesn't
allow for in-between states where some extensions are mandatory whereas
others aren't. It would have been better to have a mechanism that
disregards the version but makes each extension itself highlight whether
it is mandatory or not.

> Despite that, at least one extension (objectformat) does require
> core.repositoryformatversion >=3D 1. Though, do note that objectformat
> is not mentioned in the repository-version documentation.
>=20
> What other extensions require repository format version >=3D 1? Is
> core.objectformat the outlier here?

In any case, there are two extensions that make us set version 1 right
now: `objectFormat` and `refStorage`. For the latter it is quite
important for any client to bail out if it's not understood by them so
that we don't accidentally start to write e.g. loose refs in a reftable
repository.

> Is there documentation on which extensions are supported at which
> repository format versions?

Not that I'd know of. Right now, it includes "noop-v1", "objectFormat"
and "refStorage". But I only derive that info from `handle_extension()`
in "setup.c".

> Are there other extensions that are not documented in repository-version?

The only extension I'm aware of that is missing is "noop-v1". That
extension is mostly just used for testing purposes though, so it's of
rather dubious value to document it. On the other hand, the "noop"
extension is documented, as well.

In any case, the policy of the Git project is that any new extension
should only ever be understood when the repository format version is >=3D
1 from now on. At least, that's what the code tells us:

```
/*
 * Do not add new extensions to this function. It handles extensions which =
are
 * respected even in v0-format repositories for historical compatibility.
 */
static enum extension_result handle_extension_v0(const char *var,
						 const char *value,
						 const char *ext,
						 struct repository_format *data)
```

So it's probably safe to assume that every new extension should be at
least v1 from now on.

Patrick

--AzC5b4an1/Zv9QEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX7/poACgkQVbJhu7ck
PpQQBg//VeQljagWprgKWLkz+g1kjLcxYG2sBCA5yMcgjq3u201RN6yxOuL9cHEX
Sq6veu05vR2v5Y+tDl452f0o3R6y+BUL6QFRK+WL0+O+faU1gAmETtOWel4qtg58
gUXvDZH/m29hpNlOA58gJizHKxP9xiagEz1XBibxMxEaGQh+TfXQjAzyNpAo1MrU
PwSGi617AzLlcZ/pUuGXxTeazqXzdmRAYoTn/OCeMNnt/KhkkErY8fXkKFKpOec1
HoXfZt9XvaL4xwMaUjesKUabGxHKzculZa6hp4b3RD3cotVyThT+114AGez+Nvgu
FW5Kx/FGkhfGvq7RrAPlEtvAb3yIL3n/AM2pSx7yBtmbcQl2SIDmMCKmP2PaDJ+X
mD+FOEufVUerjj7gdVe0eByUe4zVL+UWIOl7PoAj7113zw8bkvTlpANEC39acO8d
RLJ/KHRfwidGP1zJBiI9k/uNLHei/UgvzDVx8lFqBh3L7/wqcrnfugUOkaeWMUa8
AyCNHWOwqbejFiBB9cM8OFr3djSIBlRCx7QfuDNW8yBGjXpd20HYVpKCMn7+PScW
GOkT6o04e+SAcrXRIGb4PckW6XQTxobEjfZ/FilAxDv4qpA4QDfgmQ3ibt4om9Sc
UlXkphJbZ/tLPviKWFN0tWk0wfqvSJXkwxYmDEz0VwSGg8Qzync=
=ZPFk
-----END PGP SIGNATURE-----

--AzC5b4an1/Zv9QEN--
