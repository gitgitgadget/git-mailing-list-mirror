Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2713156F48
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819128; cv=none; b=S3/R9Q6jHEwrFiL+0wZnIgIUjdOlCPGLipQHrM5k7HiuUSfAJvATHYc+fG39mTRQxGhx0zaY8bpTAkIPa8f42PFenWFp3Z+GUrMdD5nKoQOYXnrMcluvvTKwmNhT92ratzlwcoPQQ8kDCEJbDn8jXr0ZDcTrRqXAy6cw22HI8QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819128; c=relaxed/simple;
	bh=egUvbGY+ME57I0AcHEgBfXxcx008Y4PnUammvkuHHbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI4y2+6UMDkFGFRRBRwFPSNiAkfBZ+KkCz2faKroyOTk5NfuYwktxuJwio6mc5IFknOUXGt/dIDgeH4hcaxnNQBvnEAQnLjSFeqAi/8EMKIOjrLVwFrTka+WK1LobletTVvP6uz6ddZqZNBcTZkispctYd6DoIgJna9ViFgFzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DIzFTxmc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JI8GKDNW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DIzFTxmc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JI8GKDNW"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9B2C71140256;
	Wed, 24 Jul 2024 07:05:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 24 Jul 2024 07:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721819125; x=1721905525; bh=VkDrViGblX
	xKU5Kqnj1AFzTsw1oEgKpqoeaGw2/8Cq8=; b=DIzFTxmc0PnlPY9Q5lNjEHPZrb
	ZWns10MLxVFHFEF7+2KWiC7n2uCd43ybprG8TLNzwQd+2sMy9q2tZIDyyMOvUtZx
	vrUTsaqSCU+mr8InZu2rpj+oKvP2PeoF/LkP963+/w3+5jlkFJShhsRj60E6alxV
	7JoOIv5I+BKfjXjKQi5YYWXvaqYvGwej5dgPmxJcZsTINgvKkriq6z+HTZyJtskt
	mLxUdOVi+nqGVWwt18+/j4FCWt2w3iq6O3oCEYmgIvY3pvaJ4PCc5edVCdglN9XC
	dW1M6UJn+Ib19imtkHQhaD96hAKlwQSoE1DC2UKpUJmSn+gpoDgLi/q9IAHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721819125; x=1721905525; bh=VkDrViGblXxKU5Kqnj1AFzTsw1oE
	gKpqoeaGw2/8Cq8=; b=JI8GKDNWRTvXy82mRsFALKqMNdxwJhqzHRpodNDjEePz
	FUosq+qvMUEl3xb/1K9zi8H3L8Ox32BrwggeJY2lC7lkgTQ6FBYx0g8hQRtOyjUh
	T5P3yWmAxdgsrySJS98Pg2jGvICdYxy2ON/FPfX/E1TPVcoHKZoXUal9orTEb9UA
	+lj4jy+eSzcbTdP0hmsYUDZ2xhKK8VrQKPA1EJuB7bHHZAslrQd/XYRg3S1AyPFQ
	Hgs6bes6uHi9fyGQKGEsfanWyZqyPAmnvUUsX9lnr2YTaO3r8N85VhY5mERasM/4
	23UPSVPGEYxY/TGnEhQ7xp764AUCiLJmGyHsPZIrzA==
X-ME-Sender: <xms:9d-gZv2Q2gf28dHhyr710U0IN_EX-ohVSxR4jknlUTEjhYPKyRUaUQ>
    <xme:9d-gZuElhQ3_aiFSX_rRQa_8-VM1JTG9bQOv2NCzjb466ooia1VLrT7eukXRC6AcY
    4JmSINYhyDGhDeTpg>
X-ME-Received: <xmr:9d-gZv6ehWKtlWXivODP77xdJO7ErkekxBTmE9YSHQUjpWIIEJ02LBx2MlRpQrsBHYoavSRgkpZfT8nPwZc5dgG7Lkb_v6T1yqRJtT94USvblQOv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:9d-gZk1SyBqUVpgAdDjo15X_X4uH-_0FDzyFy-Pmen1pnI4KsrLXgw>
    <xmx:9d-gZiH9e0LFdmQ8Qi5MMkQ4Kv6t6sWPF1jnV5OERweLkz23iMYxgQ>
    <xmx:9d-gZl8JiS29WIaazssI7Kt6yd6pK5uYyMK8B3lWapOPm9hcDdvI8w>
    <xmx:9d-gZvno9fnkcfRT2IUp2LZE4VzNzrhio4TUbK09rpNWg9OllfRbaw>
    <xmx:9d-gZnQtw2XckKgavOFDIQ4M04OzzCVz_dVgrToADiQhn6g8cSinmcO1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 07:05:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f93409d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 11:04:08 +0000 (UTC)
Date: Wed, 24 Jul 2024 13:05:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 3/3] Documentation: document difference between release and
 free
Message-ID: <5e1de3c3159968e897a83c05dae5e8504d37a16c.1721818488.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npYooGDYLKrnOUMx"
Content-Disposition: inline
In-Reply-To: <cover.1721818488.git.ps@pks.im>


--npYooGDYLKrnOUMx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We semi-regularly have discussions around whether a function shall be
named `release()` or `free()`. For most of the part we use these two
terminologies quite consistently though:

  - `release()` only frees internal state of a structure, whereas the
    structure itself is not free'd.

  - `free()` frees both internal state and the structure itself.

Carve out a space where we can add idiomatic names for common functions
in our coding guidelines. This space can get extended in the future when
we feel the need to document more idiomatic names.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 34fcbcb5a4..ace4c4ad0c 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -560,6 +560,18 @@ For C programs:
=20
 	void reset_strbuf(struct strbuf *buf);
=20
+ - There are several common idiomatic names for functions performing
+   specific tasks on structures:
+
+    - `<struct>_init()` initializes a structure without allocating the
+      structure itself.
+
+    - `<struct>_release()` releases a structure's contents without
+      freeing the structure.
+
+    - `<struct>_free()` releases a structure's contents and frees the
+      structure.
+
 For Perl programs:
=20
  - Most of the C guidelines above apply.
--=20
2.46.0.rc1.dirty


--npYooGDYLKrnOUMx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmag3/EACgkQVbJhu7ck
PpSTKg//RwWz2XmIbmzQna4iiu3fgfy60sP83G24i+6aJA0IynRibjVzqw2TjGG5
qg1WEfEpiwYAB5+xBy5begF93Ixl9UUZM8edNNG1JjrVd58QxILlrKeEPP06SWxX
vi4K36dh3IHL8LQgNXPukBbzw8iXqmqZ+eRtWFMF3CPe6z6keg7XbQAxPHNnpsYy
WFBeRtOqVEGN4ShEAwI5lz0msbRg98CTNy786XxxPp+cY9iD89gHFqAXdpXBowrO
d9DP8uGu4MKHyWcKFuCz/OIzACcBrDdjiuGuXwlLxLwouZKo/BZ8VymSToLv4SlT
8ainSmaI5DmRqhxnz0V8Pi+jC0ZzIUxilT1LLIm24cf4H4i08LXNx4vm9aAz8zWT
nYomu8xvWIJD1yylYseE2yEOfJ2lZ0OpDFI5/cEEU80yU14lY8ZwONqddmn8jQ/2
gSr4POlOyytmidbHMLVPbnEN1rUUSqBIlgVYjLSqCBd0lGv6LlaS43ABgZakTIeL
u9tA4fbI64VlxS0GnkzIzyDP9Ypw+5Dto8UV4tE29sxOO52xyvUxztSc+nAndlWY
bY6xrlD1vyJlH3V6I3pBc3a3K2e0bh/Ol4CkNaT5gQGZxh/frPsXgnNcrR2iNO61
sCyFtVHdpWBe4Qmf9fPEmTbqLdGGCNYzL9I9Dgo1LqBAw4arLPY=
=eJEI
-----END PGP SIGNATURE-----

--npYooGDYLKrnOUMx--
