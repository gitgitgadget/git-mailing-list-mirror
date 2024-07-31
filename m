Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554B1AAE36
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421698; cv=none; b=JpE4nBRcR9oGcuPZbSSWwTkqrLgC2nKAtBgWKcJtn/4KRpcFgqf2A7QI1Xg0h/XCs68g19l87wA/FDVvRuYPxkTv0mfB0FjuPRcfqIFBl4VxDh22FXRoCXa9eabvVMBQLsIlxkV+v7cBTJZl44y1YKMVxXqu8tzB5gkHAo2Z/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421698; c=relaxed/simple;
	bh=6uiHnbVX+IR2fTFQE+GKV5VSUd4s7C82gLm0fVBel4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ekh/BK7awOf/NurhUnY82t+3OEB2DOeOOFxja+h702uL9xZIT8OZSVG66QAcBlK279/ZrRv3ghJejmCzA6/p3KNBYcNyo8fjgFyq74p78uBKVPWAEXOZwICG/wnNoj/bjnqScSgaam+TO1tVXizjU9esXxoriLUOhoyFWjdQcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dcj45dzq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ie0D5lSb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dcj45dzq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ie0D5lSb"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0465413823FE;
	Wed, 31 Jul 2024 06:28:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 06:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722421696; x=1722508096; bh=OLDLzLtyNF
	ueP3frjdNDrakiXd0Mrq4fwwGnWV2S5Jo=; b=Dcj45dzqLCUGKcvFNaafB6zWOo
	SbU1HHhQszLk3By1rswFQSqtnSZUsn1OwMSKcOpzNnf7Np3OIdDnRlq9e2mH350G
	w3VyfT6QN4xMPSIndxn4KeEaoF8hsarj/2J7f9qY0g65x1205SP6FiOoE+1Hpe/w
	UEOG84AQJvuRyKgjsz/FAh1c5jkVBjzpA2DU+IjNKNSPsTbN2dnGsfVu5lZJnRM2
	OlQCyZw8gKeu4isJFjum3TsxPRAP3ONpgRGsRkAH0JhVp6m3L7oYqSh0Us0wcyqL
	Ovc8oRmT+otHa07D0cJSUp+tIeuiL7jUrek3iQemghuQeT1K016e4L7KMa5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722421696; x=1722508096; bh=OLDLzLtyNFueP3frjdNDrakiXd0M
	rq4fwwGnWV2S5Jo=; b=Ie0D5lSbUSQk2feiyl3UM6Rl04atTIK9NaEqY6jVi4oX
	oZw9MUr9222zb7Z0P7yAt3CBwsx2iPoxHBU6ld8SJH/OiPElxdk+mSLKWKY+jIAf
	xLxNDEB9cQmlH2LsJl5T4wYObMheGFJZ5Zq/UYW9Fu/6i41UHLgpwOm2PRs6cC51
	ko6r/I+dCfe7kxXjtSq9y/qBBpreyM10alguhBKKHlH6RHidIgMboTkJ5OCHXsDb
	k8tF3T1ZhZJor6kUMjtbXrXgBao1E5ZWd71VtMGSnJnpDGFk7M59EJufg6oCAtG9
	qykeU1hgqKrFX+0Gc3unoRsc/feogfM4vnPpk7fARA==
X-ME-Sender: <xms:vxGqZpmSXm--VaJG-Mi4JGszVdr0zzTOQ544V6pyMNqS44lEWgOTpA>
    <xme:vxGqZk39-33nEo5L8tZIIuLA0knzyIe0zmZKOe_QBYPa2O0aeDWepxAKKCDYooaVv
    wClJuuCXeTuSK0CqA>
X-ME-Received: <xmr:vxGqZvpfOkr6XzD8GW7lqLTWEkfODOekVJP7JRKOdB648X0viO4WKunmX3gtYb7mjWeVjjOwWgGQmTiHH_VF_PLFgIG4BMz_4QsOObNhB1OBSauH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:vxGqZpnlcJiXpRqzwAu3i_tP4Nl11lQdN9hqeKEWEgrIITRGH508sQ>
    <xmx:vxGqZn38qOnlKCfkHfjzOcD-RfhtYgQMufch-eQsgMaoOHlYXmsjVw>
    <xmx:vxGqZotr7vmIuswUBpqdjqonVCu96YBDMtmlBLb4capXv57eozhrkA>
    <xmx:vxGqZrU95L_5J4ZB7zlFVZVAfhnkUmUhm3p0ZwwCEbi3v2NBmnbBWg>
    <xmx:vxGqZlA8dvHTUeMt5WHHS8_s48kGXhwjGpcsxFWpOdR9rCELROgH3nJI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:28:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 578a2345 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:26:44 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:28:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] t98xx: fix Perforce tests with p4d r23 and newer
Message-ID: <ZqoRvMRp5BZ2B6dA@tanuki>
References: <cover.1721740612.git.ps@pks.im>
 <f40f62f257de38c3a38e942eb9ca1d2109c2b059.1721740612.git.ps@pks.im>
 <aw2i5dz2tflrosz3enetxelnal6utk4g7kq7yos3jyssloysng@j2nqbxotdujg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QmTqMenrUoWe+K4V"
Content-Disposition: inline
In-Reply-To: <aw2i5dz2tflrosz3enetxelnal6utk4g7kq7yos3jyssloysng@j2nqbxotdujg>


--QmTqMenrUoWe+K4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 05:41:18PM -0500, Justin Tobler wrote:
> On 24/07/23 04:05PM, Patrick Steinhardt wrote:
> > Some of the tests in t98xx modify the Perforce depot in ways that the
> > tool wouldn't normally allow. This is done to test behaviour of git-p4
> > in certain edge cases that we have observed in the wild, but which
> > should in theory not be possible.
>=20
> If in theory these edge cases being tested should not be possible, that
> sounds like a bug and maybe in newer versions of p4 that is no longer
> relevant? Does it make sense to even support these rather intimate test
> cases going forward? Maybe we could instead skip these tests for newer
> versions?

I wouldn't feel comfortable skipping this without knowing anything about
the underlying bug that had been tested in the past. If we removed it,
then we'd be second guessing whether or not that bug is still possible.
Seemingly, it wasn't possible to trigger it without bugs in the past
either, so it feels like we'd be assuming too much.

> > Naturally, modifying the depot on disk directly is quite intimate with
> > the tool and thus prone to breakage when Perforce updates the way that
> > data is stored. And indeed, those tests are broken nowadays with r23 of
> > Perforce. While a file revision was previously stored as plain file
> > "depot/file,v", it is now stored in a directory "depot/file,d" with
> > compression.
>=20
> s/plain/a plain/
>=20
> This sounds like a bit of a maintenance headache, especially if there
> are not many eyes on it to begin with. I guess this ties in with other
> discussion from this thread about whether and of git-p4 should remain in
> the codebase.

Oh, it certainly isn't great. Whether it is a headache remains to be
seen. If we had to pile onto hacks like this in the future then I'd also
vote to remove or skip such tests. But we didn't really have to do a lot
of maintenance for the Perforce tests in the past either, so I rather
assume that it's going to be okayish in the future, too.

Part of the reason is likely that git-p4 simply isn't well-maintained,
and the less maintained something is the less churn you have. But for
now I only see two ways out of it:

  - Either we get somebody willing to adopt it, and in that case it will
    be their responsibility to handle such potential headaches. In other
    words, I'll leave it to them to decide what to do with those tests,
    also because they are going to be better equipped with knowledge
    around Perforce itself.

  - Or we remove it, and then it doesn't matter much anyway.

All to say that I'm merely being pragmatic and punt the issue to the
future.

> > Adapt those tests to handle both old- and new-style depot layouts.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t9800-git-p4-basic.sh                    | 13 +++++++++++--
> >  t/t9802-git-p4-filetype.sh                 | 15 ++++++++++++---
> >  t/t9825-git-p4-handle-utf16-without-bom.sh | 18 +++++++++++++++---
> >  3 files changed, 38 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> > index 53af8e34ac..4e95622670 100755
> > --- a/t/t9800-git-p4-basic.sh
> > +++ b/t/t9800-git-p4-basic.sh
> > @@ -297,8 +297,17 @@ test_expect_success 'exit when p4 fails to produce=
 marshaled output' '
> >  # p4 changes, files, or describe; just in p4 print.  If P4CLIENT is un=
set, the
> >  # message will include "Librarian checkout".
> >  test_expect_success 'exit gracefully for p4 server errors' '
> > -	test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/fil=
e1,v" &&
> > -	mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden &&
> > +	case "$(echo "$db"/depot/file1*)" in
> > +	*,v)
> > +		test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/fi=
le1,v" &&
> > +		mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden;;
> > +	*,d)
> > +		path=3D"$(echo "$db"/depot/file1,d/*.gz)" &&
> > +		test_when_finished "mv \"$path\",hidden \"$path\"" &&
> > +		mv "$path" "$path",hidden;;
> > +	*)
> > +		BUG "unhandled p4d layout";;
> > +	esac &&
>=20
> I'm not familiar with Perforce, but the test looks like it is simply
> appending ",hidden" to the file name. I assume this to trigger some
> error.=20
>=20
> We are simply extending the test to also perform the same rename if,
> instead of `depot/file1,f`, a newer version uses `depot/file1,d`.
>=20
> Makes sense to me, but without surrounding context its rather difficult
> to understand that the "case" statement here pertains to different
> Perforce versions that may be used. It might be nice to have a comment
> explaining this.

Fair, I will add a comment to all three sites.

Patric

--QmTqMenrUoWe+K4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqEbsACgkQVbJhu7ck
PpQxig/+Nt8ibdZPq/WzQiNmlBvK0fOvgETjo/0GEx5ZrLvvKH7X5TKONpjdm+RT
caR5+GwRmMhR/A2Ru8IUZkr4A/Yno5WOPRrHduUVouRK+UnIrySdwEw9KyC/7ndP
ejxFCiUUYBCm3iXCK/pxhYqTmfSF4r9oiS6/Ht3PKc7qh9I6IbiqyoM7n3vwdmh1
CzW99m5HaGjTLf71iSxQnjgq1SXnj5aY9Y3vOXEeLKkD2wN6g1AwZ0mWIuA+PEdl
Emv2gxhA3dy3IcvVrJL65C/MAmbP46U5YpiGMBbkg2muQ3jgo4tGbrk7NCKObYyu
DWj2JFnE9YDc2aADAzI6FI5XFDMemu2UIobRYJI2SQvLJiDJZcmChow5eIPW9FDO
kkGLtF6xvZ1ge2p4tLNJparY1FS56e7c/a8gvk+kat0yhxG9ZqVf+fMtfGwQjkYs
U93igNzol2NYo3uw+4OPc4IjAJg+hxL3PxJrBkza5CnFbddIePWx99PkKviiAfUj
YxcJWQXlIsTntGb+cpRqE5yYxC1YTg9SKW0AOxQkBUh6GnblpVTsZd7zoxpc6AR4
tVl8Mhh9BNv/aEO+E+47jC0iXtvEG3Neo9QC5y3GxrAJPWp800aeKpRwhwH+e7QM
yiUQXcBLhrfG14vzKAUdDyH502omShu/AqSb9uU7ixxhVqpivrQ=
=1pbw
-----END PGP SIGNATURE-----

--QmTqMenrUoWe+K4V--
