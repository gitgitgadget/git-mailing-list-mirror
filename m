Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AF84FD8
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407617; cv=none; b=td+QZeis8txaz3fjc5J/soNXQOKcp7ATWPRoLEtmUxN6a7v0nOD8KhcAwHjBLuuAjTrdOJcSP9L9WifsfT/NZ7gWguihlwDHrDddfug/SakBCBIIclbI3vGRk+Cppkpo+hD87Mmdn52noktNlds0ATU7qDtvkGlN+2TDWuiLHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407617; c=relaxed/simple;
	bh=MXHFWumRg9u5BG0kUz37Su5UsPkVNB5/OTyE3VuXYMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBFA3CSuEBv4GpeVojCeFVvb9N33linISqs9g9t0fss36YiHCSnMs2n5htRs4YjRTEngS3fQOhvVINyv4bKljIfrRFVskAje0HZx83EhXyCQah/9sXS5vCOqYKtVVTSGHN+bVJyfhBNWnm1NylaFL4Qk9EBb17eoK7DO62qFdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LXU1Me/b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m4QHbua0; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LXU1Me/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m4QHbua0"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id D1DA91C000CF;
	Mon,  3 Jun 2024 05:40:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407615; x=1717494015; bh=vAG9cWaBxM
	I5YuYcOGYnbLpQlE/orV8XmSgOAPNQgos=; b=LXU1Me/bu7/k6+FeJR+xoU9Rut
	jUN7FirfNHT6EOi/6+Cri4+0FZtOI5cT2LIq7P2uIfNv/GBvgxJL7C24WfTdnBNF
	kQ3JH6h/2Y8r43Y4rUZVaA7kyigHHrtGnatNJskPDYAOrjFsOi8Qj5eJ+z8i3fiF
	qb6uFQIsy0nMstXQx8IqyLn5PtqJlnm7iC1l0N6Hfoob1BbVPvreGfjDunN1Njiv
	AlyI8t2GiqyIcbVgBG1KMVOaT2IdH3rE/9uuEM8IMoY3nkKVyWlNokZXoOxDpZ9D
	Fgbdi/cTBEncs/ZBSh8B+DyusZQBzvZzLENxl2A9WS0OIO76ERVEIf1us8Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407615; x=1717494015; bh=vAG9cWaBxMI5YuYcOGYnbLpQlE/o
	rV8XmSgOAPNQgos=; b=m4QHbua0R/7j4YOQLS5F9aeGJOJ2jfa12jceCRUaDXp0
	ocxh6NXiPYBXgs98DZlXQxQRDvlRRbGq5/ExirwOMR6Fvl5S6wcimwUViCJ4lly1
	zz6wDwshAaHpsYT4EkKU4HR1rVfe3MEmlSc/aSMETWCvXYH/5jDH884CUqxjvKJ2
	1p/6pC9aMdFEgSQ70xUSpukYTFwXfC8w3rjMBf6uBIa4AV7xC6vejWb/zR7WICn+
	0yknwByr6+uzCNUu+T2/MoVJ5Nb0PWXM4elBL0/H36og+KhT6WY0wGMaxdcUpALJ
	SkF6JbzGzk+nla4qi+NdU9i7JgQnx+znIXwDjCZ7qA==
X-ME-Sender: <xms:f49dZgvIEoE70ekmOBP9sxPkHYs0sKLI0Pb5gKvI8NsxYmhzetj_SQ>
    <xme:f49dZtcq0xB4WU6d97_ynhbN9OPMa7u19hq8E0JAfrF50u07jyzChhDlapXTo_830
    0HwT5YPP8HD3l_Tvg>
X-ME-Received: <xmr:f49dZry_-sn1CEuzyoM6R0bVU5qe-oOzRuYNvwqif96fM1veZJfU8jiujgufSY-FmfzgWzded9zKQanNdt7RffmNFhyEq26vNTfRV597EmB-m73V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:f49dZjP3OVb2zv2NgyzKkZAiA1QdM-lH2I9KxO0BkrRjpZ-z9w_rIg>
    <xmx:f49dZg_XDSTCzZIS8vvgeWaNb90YDlh5XBf3eOXi8avAdn6E9Uetag>
    <xmx:f49dZrWn1o0sxhrhpYpUsRtc6gm3MvO5xO0YQbfinCoL_JbPPnnOtA>
    <xmx:f49dZpeXi0I5W5j2AZxNhlJHWXO3wDZw6GeatwagLasFD6IYqSvZXQ>
    <xmx:f49dZvZupih_ex_t1XYDwAwL5hlGwF2OivuZPxJyh7NZ3azp1pDX8au4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7636fe1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:50 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/27] http: do not assign string constant to non-const
 field
Message-ID: <8a98078439163f8af7ad537bc4a010043f758a2c.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BKaPSIP9dG2JUKq/"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--BKaPSIP9dG2JUKq/
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


--BKaPSIP9dG2JUKq/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj3sACgkQVbJhu7ck
PpTR8w/8Clv9xDvhy/OpfVUead5B/IsS5orDqbGllPhH3IBCHcMaXj/oNOjvIpCQ
Ki08jDHQLKEqDpVFnnVLByR4sl+ueJM/HmFBP8sVpYy4glyhelf3moJtJi2qIR9N
K6wpzWWHWUS+Pok/G1/nOk8G+TFnLV7qQowdBeIswybRgFxhdQuIscQyXRmSzc9X
dPXKiBUmR2baYgPRpQPyDw7BEOgDCAOsRXT0u4KrTaUVKOhnx3JPoABDcUlSU9xQ
+wwE91w7MRFNjY//qW/SX7TxNxYzmG5bocRo0GnyqzPNW+P+epWyitbPJ5fujwTT
BeQCekU2CfMwR1g6oH2EN7n+FHVFZBpE+HVdDKzuVt1CbN3KWWMZokftn5LJnfk6
vBI1+znlhpK8swrWCUuhQ207raoid2fHd/csrqxQGtaoVTm+FS9m+WEWlnIMvJJb
Z2mgQ2ijACVwQ6dMGXBiXYsR0Fp75vqZlRjkTqsC2C3LS0ZfeoZQhzcZDASDTC+G
Z1HFMzqVaO4CrN7seWl7At39NkxkEhLGtu/KreSHXTKyftiEmIEESLcSr4Ya+wym
EDN3XC7bSCpG8JJXLwh5jSsu0ZS1uUpb2bpYheA6kaMcQTf9zKJ7y1us5XY4oaa+
8JlMDIIsJgUBsMP1gsuO5hZ123KA7DxmRr1n6Xm18mCz7cjZr68=
=5hc7
-----END PGP SIGNATURE-----

--BKaPSIP9dG2JUKq/--
