Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEB84FD8
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407622; cv=none; b=WFxoPr/9jQ39RbAr56jr0swG3+Pyx6SlwsQVprw66h4lDKQPt0DBpUGp5183FSMo7mwJpw8rLsu8d9VuenUSke5C+p4ZHQLPRNFkEg5zbuSFSzLlyiEiVkgRBrvye95CF6ssK1u/p3aG8KRw+LXuxS/ocwfTVcfas9lKBnClKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407622; c=relaxed/simple;
	bh=fmB+NOIqIOHK+rraEX/al5DXXGFWCI8+zF9ljfyL7ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Qn2qNHoNyUsPXqpAJWd+GKgGhaDTCD2LzaOhDSAfXr0hLiGyTvUlXgEPEOvXA2xCH7jGlDhYX7u73GHvI84YIo55JtPtstDfppy3jQlxkXBZg3RLhkVG4geinEh+bX+aLNojGJYi/kZPnU2KOeJ72hfSJm7lXo1S0FFAyO+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C8qR8cDO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQwUXZLm; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C8qR8cDO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQwUXZLm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 97BAB18000E5;
	Mon,  3 Jun 2024 05:40:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407620; x=1717494020; bh=pUv/oCOSMy
	y8IrXUsX7YmGYR3JcbrLWSpHjkc99cJG4=; b=C8qR8cDOlSS7pplzsLO/boCK1s
	vZcHVWqAeAafwkoWhGQnnKi94dmUAt6O7fmJtzHSr+XwNLlVuhOoEy+RKr6nLQBG
	PLUKOaQodQcPR9i0paMNJgdllLT/SymZRu38lEUi1+YfkIU/29VJhPTh3P2B7SrC
	B4EEFu0PdaFz8LHqXl//IhkgaU5tYp7wiUstsW9lfJqqRdvTYnJbu5vMrU+TwcWe
	wxZGC7NFAhD58o8FcvDOs0tGY4eeK9BapE6c/3/cBNyi4GNtoaeLtKEtL/T5HFd3
	VaTbQqYRV1H3O/Wt9qIE4Rc+golCRLeoxwqJaw87lxCASK9YC2w+qXn3jvmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407620; x=1717494020; bh=pUv/oCOSMyy8IrXUsX7YmGYR3Jcb
	rLWSpHjkc99cJG4=; b=UQwUXZLmdq8mdTKVVnYqNev7fF4tioXF/JLhs8RQcINV
	AQmvuS6Ji/t4+9oAIBwyZ9rXvUOZiNLI9RkZktJ5Sn3dyndcXQSeLB/qCCAqCUh9
	XfJe06/TLBPf8jWZHPq8YW+RbUAjfa09To//CKoKFpTiTYLnWMJoXmfSLp0p+xBb
	bdpPza4v3yuJjunymaXBKSAyxIdKmAEe5zTs0/Jm1PTEyi0HtPS91kDPQH32KCV9
	XI/p3kUlF/QHmknNFxjbwBzsSx51zs50NQGDknqTNWROnwlAAhsrdm0UNakoTAWh
	Gb9olSPhbfPPBa5iRRpOyiwOZ9AS4oIONr93NjW/kA==
X-ME-Sender: <xms:hI9dZi7_d1MB3yKk0-r0759YG-C_BQ57pkqB2UWMVBqUHqqZnjyphA>
    <xme:hI9dZr4WucO_si8bRuseo8fqAI8KSiwOH3Ez9hiFXSe7TutYrDz6kSJsDzrDDWEyB
    8lymJzphkhshsCoUA>
X-ME-Received: <xmr:hI9dZhe7xVLPXS6vvP8534KvLB1QMA_WkhnWI1V3DW-fbYmWLPjyOJjf225PGMlgoueI3MX6JNZV7QqBBqspuvkR0fdq7rVRqxoIxAuCurpX32gz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:hI9dZvK-XpQPI4Q_tr-s4h8ekTk03dedmg6_kN9vkpu57N0mnmvO1Q>
    <xmx:hI9dZmJ9QGvw1C23weSNPcQYuu2rirBd03fOjDuwkFpFu6yvSIGkiA>
    <xmx:hI9dZgwLWq7rkKPTm6N3as5-faUSF5cTd9WjwupKzc2RNDLZTIlVjg>
    <xmx:hI9dZqIN8SuBYU5Xdc-4wAHuM2TWQ9kMIBInESp3_U1SqatdR8psjg>
    <xmx:hI9dZi1G3Fgc0kn031T1V-x93o6o0sJjgRN9BfPmTMcB8eDaFCUazmn4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 68099888 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:55 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/27] parse-options: cast long name for OPTION_ALIAS
Message-ID: <26c4c76c8684788e8be6e378c8eed63011050518.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K3+vEmKGmj/cZ/N/"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--K3+vEmKGmj/cZ/N/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We assign the long name for OPTION_ALIAS options to a non-constant value
field. We know that the variable will never be written to, but this will
cause warnings once we enable `-Wwrite-strings`.

Cast away the constness to be prepared for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index bd62e20268..ae15342390 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -355,7 +355,7 @@ struct option {
 	.type =3D OPTION_ALIAS, \
 	.short_name =3D (s), \
 	.long_name =3D (l), \
-	.value =3D (source_long_name), \
+	.value =3D (char *)(source_long_name), \
 }
=20
 #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
--=20
2.45.1.410.g58bac47f8e.dirty


--K3+vEmKGmj/cZ/N/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj4AACgkQVbJhu7ck
PpRsfQ/8D1RjKkV506N9eNqnOtgbNxL4GUyvrRCz4EY4dqxO1Ma7rFw8u0onCfjK
Eanvdijxf0fGsmt4K6oIyh15Lu1JSlHvxlQk+28EPYUGro9s0UI4StUdWEw9kp2C
ztx3KJDzpst1wbKwKW5iyxSTgmI1jigyGQf7XN8qrW5GJfqDQxQ1BASkbmFTWGOM
gA2Ypn+8CRWMX8mjiqFEmU1T0LnG4I0pIWOZbr/mTYXjIorAhZINjyI5pIHayInq
2NWj5YHgC6OZ8wL+wSbgIXqHzvPauu4rtYCrHOphIwIBG0F7B6slqt1VSeHkSeln
WB08x6B9pxtKmNCKxzpUt5EdG3YAucGUesJI2SzuUNCkiAMFwTtebde5Im0OdYWu
EqOc01dq/nfhDmy5JZNxl+d9tEvvpeGQ8Tk0D9lnmH4SpMnCmpTnSf73WMRMzwCL
L+b2lVKD6jk+Fy1HuD9j3kYl1+5URh0k4Av5Tgolv+v0Z079o8+hnb9l9OtHYPFP
yWbCHYKMmzEb6zeQ8SS8/xO0WyfoWURy4FbWr2vbVA+SThDKQ6hZPGw4+IC8ibJU
qNilFuDfcMxOjBBtqJF7Wv4f/kU4bMMHads6rDIFpCYv96kpGoLDooc1Pdw2qipx
altFI+49QDM/lhRXv0XfDJBsd7wuE52rd0OsiKmgQYkmJXcbttM=
=5RBG
-----END PGP SIGNATURE-----

--K3+vEmKGmj/cZ/N/--
