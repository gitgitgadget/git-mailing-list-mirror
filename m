Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D823146582
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504692; cv=none; b=uNKbfOzX4o7j8sKl8dVQlTaDT4EY8IY27xe6/4WVXSQYGXwFFPIZPTFlB7HUH7hTPI3mNDk4ef4iP3gvxUjIrtmITKENLH1TZFoFfmrerKXTcAtcA1W3Q429rFMadXhneZ4PdB2Sj73tGgDHEVeNy3NsQ6KkyAq23YP2BW1pI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504692; c=relaxed/simple;
	bh=f9LAP9qRws9W1APKTb4r6k5oxJFj4fDtkWofFkFCCNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q91r8SnMoAria8+F0ZyvkM2bM61doE9H+wjbXeTB+l+miiitCHZcnGaPBH1y3073YF2i6wS1szLS6A2tLjHIBC5DCrqSmIUXM+MgpzDtZ4LqzH0v5LXqRaswcoIk0QCpk4CdvMpNRc73GeAyox+D1cwPZkfE/zaN8ugyp6Sgiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f5S60x6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/ztI38l; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f5S60x6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/ztI38l"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2C0A7138015D;
	Tue,  4 Jun 2024 08:38:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504690; x=1717591090; bh=cKXdSRG7ZQ
	7lC0VjicsR5FmhgIUo1P7BCw6ra9DB74Q=; b=f5S60x6xqMZVCYnyDGY/h+ANXM
	50vsLwf3oKEpHqCeDAYJvEcGUv8ZIhpA00gciT3mVZhfcojv+6rMya+s/OV+rgdE
	iPY5hU179av7Z3qsPJIDsX3uc4FDwZsFgaO5J9UzEAPCL5vcCeqmGErYkQqV4SkD
	jeMiXyUcvGP50TXws+JsoREiyeBOZJhFashlqsFfuhC4NTcY3XWiBSKcabxEpd2Q
	bv1+l4t50/tGnEYx2rr3EeJ2WyIChj51WytPd+wF1hUDjBjYwE+dquXoH2T0kHkf
	jvZSuTHFok2cvfmHorn4Sbt8GLH/VqVg5A2pp5L6Mp5JoBdk7Yq3pBP56OiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504690; x=1717591090; bh=cKXdSRG7ZQ7lC0VjicsR5FmhgIUo
	1P7BCw6ra9DB74Q=; b=K/ztI38lk3a9cobFK/yZxft09IqPIny2fvyfotrX1TTa
	Dpqg9DTuI4oKOK5RyRoa1cW9tLemPkPGNoJzbPAovlWMgCD0yrcD5NDmfs9KTwxn
	juDJFGn7GNtRzQkyis6b6Jx1XMrUhA6YAn8jVaCzb71g7AGiwOma6/LYI4GCI8+d
	rwoEZV6VtJCK6WaBB7qLRAmMXaBIIVENxnDd/xrXKzRVgLV3K+UvOaR3ShgBzjnO
	bqWHgxuKY5Eu6Z1vFaqfCzNCnrP7yMLZg1F5iBuhnvcjy2AlDYkEWpODAHdgvEH7
	RiVQTE5zL1SjnQ16LP3rkS3TJ5URGeYRSPG042iW2g==
X-ME-Sender: <xms:sQpfZnFig8Bv19ozUXycBE67fCLF5UPjISYMxvJ9olPNBih_46keiw>
    <xme:sQpfZkWMhAgRWEJV2LKNjjEY_2cpMlt4pzgJt-U8wAECYKVlgmbaoBFsfHY_yPP4P
    bu0EKfUgAVb7Pq95g>
X-ME-Received: <xmr:sQpfZpIPctNeYz_n-tp3bwneXImpK4yrUhoThDbN6faACpmVaThThr8hxu8gCRh3MvR_Wr8h4zLfMtj6Lgl8Cqk21JOMgVfa1ic1CeA8rL97GhX_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:sgpfZlE5Cb0moJR3xTLp7TQvLsZXdss8QpKmASsYS0q6iDomJAzviQ>
    <xmx:sgpfZtXxWxd5OEiKElLsgF4ZOE6oXH-flTBa-P9wAlvFr3IrhTgdoQ>
    <xmx:sgpfZgPyrbRSk03Je7WiWS1ZST3PiLcGnnNoa0aYyoHv3DXCZVEsJg>
    <xmx:sgpfZs1O4FzbuvHiMTzKoQD1zoCTIrMww-MDfVbYr95DXKDIfGfWPg>
    <xmx:sgpfZjwKblXhXwwscYc53mGGmNxC2Ieyy9kaDr_vsSUrQ_ybiVb6HJyW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 57bcdbf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:42 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 16/27] http: do not assign string constant to non-const
 field
Message-ID: <a8ef39d73d36333685f6a79f83d73ff73470fa48.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfj+vNhv7aeiiNun"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--tfj+vNhv7aeiiNun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `write_accept_language()`, we put all acceptable languages into an
array. While all entries in that array are allocated strings, the final
entry in that array is a string constant. This is fine because we
explicitly skip over the last entry when freeing the array, but will
cause warnings once we enable `-Wwrite-strings`.

Adapt the code to also allocate the final entry.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 67cc47d28f..2dea2d03da 100644
--- a/http.c
+++ b/http.c
@@ -1974,7 +1974,7 @@ static void write_accept_language(struct strbuf *buf)
=20
 		/* add '*' */
 		REALLOC_ARRAY(language_tags, num_langs + 1);
-		language_tags[num_langs++] =3D "*"; /* it's OK; this won't be freed */
+		language_tags[num_langs++] =3D xstrdup("*");
=20
 		/* compute decimal_places */
 		for (max_q =3D 1, decimal_places =3D 0;
@@ -2004,8 +2004,7 @@ static void write_accept_language(struct strbuf *buf)
 		}
 	}
=20
-	/* free language tags -- last one is a static '*' */
-	for (i =3D 0; i < num_langs - 1; i++)
+	for (i =3D 0; i < num_langs; i++)
 		free(language_tags[i]);
 	free(language_tags);
 }
--=20
2.45.1.410.g58bac47f8e.dirty


--tfj+vNhv7aeiiNun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCq0ACgkQVbJhu7ck
PpQIrw//XBsdPTrXZ+OABsXDHOLQBMndRmePPqBLYorgxnZmVDdEBfuvhf5hP3fX
XNTpC/g6+A80BXnii6uBftLW6OMFHDsLdp+TEvbDJ1lgNqQzeB6QwSWH7Kz6FntL
WsyJb5QZJdq9AnWGiG6vHnfRJdTawPBHnA/mS4gx9BUAs+x9EaN1E4JR3RkXjIq5
5gCkuRK0208FmLyWMcJDis/hBroFG4GXRQnfkAFJ9Pcx63IhtK83eVqew62Fo9sZ
F/ZUg2La6aiYlDsg0EgcWN5EvcHdRXOO1zodoTRhOgkx6T7p3DNlnxv4ZUpPTRin
FeBOqGPv6rUhcbLdrES7eX5b88ymMs+BuWDdX/U7KPTT04hFi5FK40ibQkxdyqDo
e4wVbUc5oe4nXCYtuVv0lKMa+Xe3ajTLNd7Mt2o2DTI1TCN40Go+BShBIpM7uLA/
qCrjy0QB2BtN7OURV0CjcVrX0zLofFdv3yNHirTgSFl1K9hEUcJ6ZoQ7gnD2GC0F
EQgGVmH8BB7LXiyGPx83S7JDb9Kx3nxo6kv7B1yJiWjhA+SqLOiY0G1IDjadSG03
RvoUaU1JEyvjPTGn6zJNf171yccI55DbreNcqs1JGQJLK7haqQx3IpxBQjGfJEbx
vAcWrGQbaY1SiCaST2D9bPWyvR2tlxi+gpz5XecHeiORQMf8rHY=
=K4a0
-----END PGP SIGNATURE-----

--tfj+vNhv7aeiiNun--
