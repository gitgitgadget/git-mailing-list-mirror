Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3540146E87
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046404; cv=none; b=Rv+R0ypUvCcsnisveiNbgjVvh3yGP69AXChZPqVv38tmZutVufUwXEtkuz+omSqyBbwLy9pCNk1PKJNp1yraLUc16VAY/1B4Pio4acYrdq8xKjFeBBU8ibL8iA3VTZf9rWczm/Sd6MQztPUYXgBNxjx4ePSeWWVN5UDlwLlynP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046404; c=relaxed/simple;
	bh=ASP4TYQKH0mJ8g4+WQ/sG1YvJXp3/6uiHqO4cgqsC1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHu91Q3Jz4gJzV6ilKeV/wRPJE7X+fYj4aUwMHE4tJ4z2mg7rOVfaYtfWqMSOhiCoXRSjMd0Ktvma3XFEAqERJgdT9zv1cQV7ugy8FAljvGbuysmkpcKinbfb+WsZcvezM6OVoqCZDDzFi+liHCc3qceEuzvaZDx0oW4tdaHZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rXyOf8AJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n77gEkgv; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rXyOf8AJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n77gEkgv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 06DFB1C00084;
	Tue, 27 Feb 2024 10:06:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 10:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046401; x=1709132801; bh=T3nibIFt5b
	VkRcuAdxfkC3JyyyQLlrrg8LYmGyM9E7o=; b=rXyOf8AJbDAkWNuKpWXDkT4JU1
	X2iVw0BYDgHxEfwtnyEFm2WiavYze3cJU46zbYXpqlctjlgf3mepTRuFb1TQSte1
	MLrxs5hIlPR2iCHlfRC4+sgVmggaqRytwS6L68HGqJnGwxAGfPAKf1qN8ZBdaswS
	6SY8WdkS4Ff2xD5bOvA5Ug3bkx0ZnqaiVERU+PXMHitIfk783D0B37IBice79Tnp
	NRAOTTmY0XGCxM5DmKhzNLbbImEHqHElnsXbCqjLo00PlZDX++doh/TL1qkBvPwf
	xvd2rR6cfz2TLyVzzWCxxwT+raI0W/YWeeICEhoMkma+F3GRzc5lSzG0L4Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046401; x=1709132801; bh=T3nibIFt5bVkRcuAdxfkC3JyyyQL
	lrrg8LYmGyM9E7o=; b=n77gEkgv2MtvWt1PoX6VD2/Coj+o67V62Ojv4/ZHRVVz
	VB7rcTAK7CL1GEICFIDQ2gfGV4jKG0csyOzAAG46Zgy0GIqPyPmTvFv/PPkzJXCL
	6AJERRvv9eQxg+76pNIy492qsx0erlksW0+2YHjWi6DDmdci4AZjwLtVZSwsK9/L
	M5IKNy36tu/8gl1G6C9MzHzo7098AihzXiAmeCHXNHRIiMBiNp0Kjvxij0hu7uKC
	nCz9GmIf0O4Sf87VJwxogJKNPN82+dJW+cmb2p5DEtPz+zcEu6t/VZuE2XrroUg3
	5TF7oLMs0I6Jph06TUPeqrMmqAToGRyGJZyajxkPUA==
X-ME-Sender: <xms:gfrdZfqQcDXUvkeeVI2SECJ4dmLDx1y5117QQ-0kMmvaRAjeZXN4kg>
    <xme:gfrdZZpynJ11xOJBArH5wffKIZ3KLOAyUB0YDq4iXAcOrKdbORtTbtJEoTeFCqBQO
    Xk5bAqykVuGIGNujQ>
X-ME-Received: <xmr:gfrdZcN_69PIp-5n1XTW4te-qBGdgHYu2ot8e1ft-M2Yr1b6twaWIUD0FRUgZX0m5xO_wl5TXdRtPsouyLUyZor17KKeoOWpHiJ4T2NeuKO0K3qH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:gfrdZS4EtvaY--8LQsuOkqcS9VW55-XjL7rkNZGPLSp3A2T7PgjrQw>
    <xmx:gfrdZe7f7I25ewW2UHMyxnHFqbGgwN04lW7WlSdFKbg9mZNq8usnIg>
    <xmx:gfrdZajIWZPgYzozNvHM5LFioaMoFSaU_4CQX4KoDC0m7dFlYoPesw>
    <xmx:gfrdZeG8zlZ3bD3g_wI64XF0tluDuWOfUiOKL9iMgUpXmzr6U8Fw5i9CohE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e90875b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:23 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/13] reftable/merged: handle subiter cleanup on close
 only
Message-ID: <01152ce13072429f2047cc874b182c2938ab49fd.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mm4z18pZMhEOOyRt"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--Mm4z18pZMhEOOyRt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When advancing one of the subiters fails we immediately release
resources associated with that subiter. This is not necessary though as
we will release these resources when closing the merged iterator anyway.

Drop the logic and only release resources when the merged iterator is
done. This is a mere cleanup that should help reduce the cognitive load
when reading through the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 29ad09f3d8..d9ed4a19dd 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -46,11 +46,8 @@ static int merged_iter_init(struct merged_iter *mi)
 				    &mi->subiters[i].rec);
 		if (err < 0)
 			return err;
-		if (err > 0) {
-			reftable_iterator_destroy(&mi->subiters[i].iter);
-			reftable_record_release(&mi->subiters[i].rec);
+		if (err > 0)
 			continue;
-		}
=20
 		merged_iter_pqueue_add(&mi->pq, &e);
 	}
@@ -79,13 +76,8 @@ static int merged_iter_advance_subiter(struct merged_ite=
r *mi, size_t idx)
 	int err;
=20
 	err =3D iterator_next(&mi->subiters[idx].iter, &mi->subiters[idx].rec);
-	if (err < 0)
+	if (err)
 		return err;
-	if (err > 0) {
-		reftable_iterator_destroy(&mi->subiters[idx].iter);
-		reftable_record_release(&mi->subiters[idx].rec);
-		return 0;
-	}
=20
 	merged_iter_pqueue_add(&mi->pq, &e);
 	return 0;
--=20
2.44.0


--Mm4z18pZMhEOOyRt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+n0ACgkQVbJhu7ck
PpQC4BAAov27tDgZsdyj7kM1qlPJXlAWzJUWaEeq4/nBSckF/rTsMiKrk7vs5p61
FnShYxzvnMsnP9Pv17EPCx29T3ezK7D/pFOvv/z2mslRAv2xAnlm/pBTtehW4iyV
qM50nvPRuQbSB4YBvHImpE7BmDIrn1uc952zLxnFPlNyBETuC6yo3FA+LkykIdHW
9ieW/0hnBOxWZdvs5XLYVEro8EjzfMCagoLI2pG4Zn+nFPUlN345wLl0m/0j2siH
17yYqyLJiP4X/G129NqenX8ibbp4V6Cl7ZxzeNSOVlLRSHQL/vIHiZOtGBNcd6Iz
wxszOPrzeVB3oJNLBQV5CkqEkb0Ev1gNWP/pWvIK2a7Lqu1vbHMFyy+YqHEmE512
aC2v4XTF6urksj6Kq3Qp/HL+9zFDmScAGQ2i2hWF+wQxAM/5xLz/wYZ3cwPuoZrr
/1ZwrCUXzpezNWTpEIw+MgqDmCFC0b8ncx7y3Vefx8lVeTiNFrj9Nc2LWm6/UCQq
bZUvSf+uBRn8czPUmyaTkJ4pzMDPn4i0M2cBOvhgAu7oT1PNq/sGFh7khPeMdiuv
smrndJMg1PBN2SrPT0jxjhVf8wvtEYSgNqYvHo/D2ZmEK+TvhGRGdD3eyf96LHAL
C1pg16JJsW+vavTdSpmbpdqs91jJ8/os4OFiJMkN/uGKOyLXK9g=
=ULsQ
-----END PGP SIGNATURE-----

--Mm4z18pZMhEOOyRt--
