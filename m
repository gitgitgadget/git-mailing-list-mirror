Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C81B813
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713847826; cv=none; b=QOCoT+V9JCJqJIADXzVID64YnCetD/Sxh3ywK920p9f+LxLxKUT8SFGCsVAt4pOHZWzh9Mr/8GadCLc2pEs7FkKxJzmxj5cjmU6hZqqJTe00djIJias57CFq2mbjbqxmgiImrXIkAIg+Tvtgps58TOnhgRgx4/NzZPToUArZafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713847826; c=relaxed/simple;
	bh=OUYMwQEcw8jRLubxwoHEgjyGqmp1ewBUUMjfS8pGZks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8YTaNe8j82GhOUT5q2vQTI6gZa11KoB+XD2I0P/d/GV2vPBZ9xng52vtEYWRujyXOXcM+QT/C5dbT32VUaSve/aT+pf5gm49D5kPvx2fzG3nUjn7dPLzQceITOJFNlFzRPoiCWwBgXiP6EMU1Ts5HVDy4fIld+UZPnZrhCiIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OoiuxPmF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdNYG65F; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OoiuxPmF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdNYG65F"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 30D411140166;
	Tue, 23 Apr 2024 00:50:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 23 Apr 2024 00:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713847822; x=1713934222; bh=5XnWGt9xY8
	swUzOfDFEhBnSV7HtLWfqUwcDLWVogAsI=; b=OoiuxPmF4DO14Z2Dnsy7jd8r4I
	8vIaY819esVx9tFqC8ljTf2W3yyZJrx4Sy9GsZVAI41jSqnlesWps8ZspWeKAHgi
	SZoqfd9YHhBAffN6CevU2jARhedxZFpSmzvbY5FntL2/kQaR1+oBUmynUDUD2/Pd
	IjTwlXgl0Nhs2MTTbXHtlcLYN9VovzCiQsN/s3WSYNvVluhIkTTkcG0psNAzCm6N
	Mn8iymoYOXUdTJzi0zBuBTRvTFysvyZN3W5N84AGk9syhS+xbErUdqbwHXM1QzBe
	2VXn4k9+vW61aa8IHjcGEo00ga3wvNJx3/hQboR3Nht2xM0JU7jbvScb49/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713847822; x=1713934222; bh=5XnWGt9xY8swUzOfDFEhBnSV7HtL
	WfqUwcDLWVogAsI=; b=IdNYG65F1SRXvoh0OGR3Zzg5tt5xNx0MN4/rxwtMwQT2
	LxRUwuchuSxS+KVBFsxph8yjrRcZkB7+U7eqkRVh4M+bFR7s1vjghq36BX7DOQTU
	L/DH0af6J/XeuwU0n0gaSQFULYo/EZLgiBt1sPNZPzeMXkk7TDyappgV/3Lac1QO
	cr371mp2LBnnVhtfYN2vViZVx7kswRTnuf9Q0XKizysDOG5bF65SGNdLj1BGmwgo
	QstwV3sENMwv48s8SQVAEPNUOLM5BTXz3HJt8eP0Hxs5mk+wYrMRD60XACiKmD4Y
	DlnliY91U6/kGEjZEw4yHTRMhKI3TXp8rSOziVFUhw==
X-ME-Sender: <xms:DT4nZn51hVFF9USanSmI09CUEhvkHKYIhmwi_EezD9yB39f2wfvRUQ>
    <xme:DT4nZs5WgHkTl_KXn8OewKWnLBiFIim--T6XlqYvjHDtIkRotFzYHMoY8Adw48Dc-
    qKan1aFBrh24bH-8A>
X-ME-Received: <xmr:DT4nZudh6qox2SCDLkxaLqN24xqvQ91szH-wCFMOsMal8nIwfFfreqCKOB05vWYlR6hHnQw5nJ74hH_zAlczXMxPWESdz8ZDW80gX0h3F5SnXJB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DT4nZoKlmDHsSauS_jV_KCwF_CMUzU0E98IqiiYfFmiq2Mn-gh0mqQ>
    <xmx:DT4nZrIIzc4vq1IZ0uWn41bXi3i1Dorfw1m1GJY8i1vYo02WRYD4vw>
    <xmx:DT4nZhw8GySBgAQypiHSnup9e5I7-AT1xSDVdIVaG33HSjTdmNuC7Q>
    <xmx:DT4nZnJRB_xcEC6CsABBjq9yfBDkGmV5nF-ERgB2aRStNOenRyT7PQ>
    <xmx:Dj4nZiW6WY2xZNpf5WrID8IfHvZWegp85UcJKd3A5Fwf3BwFwUUubp7t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 00:50:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 40887fa4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 04:50:10 +0000 (UTC)
Date: Tue, 23 Apr 2024 06:50:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] path: harden validation of HEAD with non-standard
 hashes
Message-ID: <Zic-B7oSlv1PwvOL@tanuki>
References: <cover.1713519789.git.ps@pks.im>
 <aa4d6f508b4af3923813e19ff82a4e8484d5ff11.1713519789.git.ps@pks.im>
 <xmqqjzkpxtjm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z8hetfjgzd0sl/42"
Content-Disposition: inline
In-Reply-To: <xmqqjzkpxtjm.fsf@gitster.g>


--z8hetfjgzd0sl/42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 09:15:41AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The `validate_headref()` function takes a path to a supposed "HEAD" file
> > and checks whether its format is something that we understand. It is
> > used as part of our repository discovery to check whether a specific
> > directory is a Git directory or not.
> >
> > Part of the validation is a check for a detached HEAD that contains a
> > plain object ID. To do this validation we use `get_oid_hex()`, which
> > relies on `the_hash_algo`. At this point in time the hash algo cannot
> > yet be initialized though because we didn't yet read the Git config.
> > Consequently, it will always be the SHA1 hash algorithm.
> >
> > In practice this works alright because `get_oid_hex()` only ends up
> > checking whether the prefix of the buffer is a valid object ID. And
> > because SHA1 is shorter than SHA256, the function will successfully
> > parse SHA256 object IDs, as well.
> >
> > It is somewhat fragile though and not really the intent to only check
> > for SHA1. With this in mind, harden the code to use `get_oid_hex_any()`
> > to check whether the "HEAD" file parses as any known hash.
>=20
> All makes sense, and given the above, I strongly suspect that we
> would want to make the validate_headref() function a file-scope
> static in setup.c to make sure it is only called/callable from the
> repository discovery codepath.  Especially that if somebody calls
> this function again after we find out that the repository uses
> SHA-256, we would want to let the caller know that the detached HEAD
> records SHA-1 and we are in an inconsistent state.

Fair enough, we can definitely do so. It only has a single callsite
anyway.

> > It follows that we could just leave the current code intact, as in
> > practice the code change doesn't have any user visible impact. But it
> > also prepares us for `the_hash_algo` being unset when there is no
> > repositroy.
>=20
> Or perhaps we use get_oid_hex_any() !=3D GIT_HASH_UNKNOWN when
> the_hash_algo has not been determined, and use !get_oid_hex() after
> we have determined which algorithm we are using?  It may be what you
> did in a later step in the series, so let me read on.

I didn't, and given that it's only used from `is_git_directory()` it
would probably not make much sense, either. I'll rather add another
patch on top that moves the function around to clarify that it is only
expected to be called from "setup.c".

Patrick

> Thanks.
>=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  path.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/path.c b/path.c
> > index 67229edb9c..cc02165530 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -693,7 +693,7 @@ int validate_headref(const char *path)
> >  	/*
> >  	 * Is this a detached HEAD?
> >  	 */
> > -	if (!get_oid_hex(buffer, &oid))
> > +	if (get_oid_hex_any(buffer, &oid) !=3D GIT_HASH_UNKNOWN)
> >  		return 0;
> > =20
> >  	return -1;

--z8hetfjgzd0sl/42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnPgEACgkQVbJhu7ck
PpS0/Q//c1X1iMfarJdwy+MEK1k5HuF5iHb8V+/j9+yUetROQcX8PbGMZrZEd75o
5ubvU+ouOwyPF3xG/D8z9EOg3yrRyGU3mscNXVBxsT+GNMYewTXNpoh1N3Bf1p4i
env46PDs/dpQqQpZQDashdn3U4maXQe8pvTqHDQKEI1Oe0bReW3tFzGng41p10f+
FmRPvuUjIR9RV4w6VxL+dFdbIeKu22vu/gMzYo338RFbCWteoCnxQplKk9r35H+m
lL5JUGvFFJSCpQ4SmYzCUKPjOmlK86Jf3y3c8HXP/dr2Vy6ly4IA0wN+npJfIxWp
lLbyq6+iGnU1fmc9jpWlhxC4CHuVXBx2PeNJopG6sSjLVs4FnPNFGzwicXbkBXNv
vFrLhMII3XvCNd29hES4ZZgU0YNDuyDbo+pjc8AGk55BU/FlGeSFHlf3ZJOg3UYl
VML0A45fI7qDNpL/QBW7rc+ATcjKnHVbkCgSCX4kP28qU8EWAIpgB2MLFE5IRQub
kbBZz09/SXQN+OYt8AoYREMnKaBtlZ5EoWOPmXJPNHuAiJM1Z8fzoSTGlgZnldd7
BeX2EW9Yk5nI8fY1QIo46s1484tTDJzaIhAD6Ih4HksLecK1IWSJezspxLqYVf3e
u6EGK5a/eMrs8LaLemFx5RExjtcYKuPCq5xVoUkv2z9BIa6/HWM=
=SKwz
-----END PGP SIGNATURE-----

--z8hetfjgzd0sl/42--
