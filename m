Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79B4F1EE
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755332; cv=none; b=VAdK9rggKw0wyRAswaH3CXsVpLEGcWmVs6xB+4J877wFu6eE+PpxfRAAw2oZFF8CcLu6rUJnxJDube+NB/ElNI+BmOMKZZ0wL4ZcHbnCpsO7bsm3jc8ldmYmuPilU31vK3UbcfrTyNtTvzDycewka1IiTBOgyoiiJYIZ7idvDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755332; c=relaxed/simple;
	bh=aLFVda5epiDPugnLxRhwOLAMrKY3C3ofWWcdnCZiPHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvlgvq903l+MqIT7tK87/DhEz4wnE0mLZ+u0KBlVUgpCR664W5+aFZZyLAlbvYxsKieJmQzoimCKpSQnkpKykmxU+W5pq6iwkTN22Cx9DVm45EqVRtYXdrjqeMiJKqwFY+dVaYjCci3IYzAulkZlL3VWNTUY9P5YH6xQScR/GuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WYmdK8+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLok6yKq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WYmdK8+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLok6yKq"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5EE4A1380251;
	Wed, 15 May 2024 02:42:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 15 May 2024 02:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755330; x=1715841730; bh=sprCNmcXek
	5scsGPEJcEbQwV9k8FEO9WpLAKn2OM4MM=; b=WYmdK8+8/Gq00YndCFN/7785KL
	73RlIMbKN5tf9hdq+a4D/WLqxzqYC8+MoHjHmQt769WsdwwZ+9DBh9oqQZEjuApk
	yziMJEtSeNQI1lsRJ2qQRq4wpRWHsgKJTi9omf3aHVF0hvCODGMjpWZ8iKoqm4m9
	8gfHNExrVSWR/+fAQ08P9drbrorLtmmqOIGCKZzwgdtKDy973EpnObSBfzQATY2W
	pf8rVeVy90u7R1kOTfZXtAzo4CszIlqTdmzxt2Kj/EHPbodCtgKuoW1RRvAPwKrG
	Alqj5r0/HYqeJNAMReLvT9O7fWKYOmV8DUG+ZqWK5dloQoHn6cyt/HIlTlUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755330; x=1715841730; bh=sprCNmcXek5scsGPEJcEbQwV9k8F
	EO9WpLAKn2OM4MM=; b=kLok6yKqN6cFV89WilYYZhXHs3SoYSwsoOs91NvPSIIG
	NhmTV29UG1jUfXMoFFPVDJFDagln9nQy+vA+nwekS5fr3wCbSX/yAnFSSTCWJubQ
	VW7YD0T6Fdnili0UYW1E/UxAMmVlpSBonKql5oleWiTIbDtG03gncJ26avEOLO8j
	DRsgOjN/nivFFby91vRCfinGaAJmms5N1V1eBJPp04mONzgirK8dWnj3piyMNZP5
	d74jutMh++EYOJIrOr/rbRhmdXhDDf2G1VZD9twhCYIUFmpRd16rwEWjuPtcvNKL
	RA2JHoBHah0RwzA7kfnko7HE/k8u4KYfgwep05iGUA==
X-ME-Sender: <xms:QllEZhNOztHT_xR8OFROkCkq9Wo088q1FAt4Ly8v_jqg0buJ7rH9WQ>
    <xme:QllEZj9sdmrWcdMP8dCK7_ymdHXlNJrya1rl49Yfgmsmow-UaMz8xW0JqZqC4labp
    qHYtPY7HHlGikPltw>
X-ME-Received: <xmr:QllEZgQJIR0iGDOP5HE-rx-NHevumyW9916s_K60ccSbUR9YPiU9swUIH9y4X7Nz_jBm12tmB0rizGs5YTMz5oOCh2IQAwfb4Nt_TI5-LH7aFIF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:QllEZtvavSECQatyWUYS5rWMcUmoR64op8cx3tmgzEmepwHByI0tsA>
    <xmx:QllEZpe1ntjNO2HvQaXges9t4sK8a0sC1BmvaKc2W4LTXjlper9Ifg>
    <xmx:QllEZp2X06y-PP8ZsPRBlnk1ltqt9JxiiAetreZAXe_72eKZtZiy7A>
    <xmx:QllEZl8tqA2t9pvafdJQcP-Y8XkRF3S1rZkWYhmSitahoKIoYDMEhA>
    <xmx:QllEZg5piBtFLp-uQORRq6FRSiOVARXAjfh3-kSdhFYSfWHMApEVOtKU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2fc334a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:46 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/21] config: make the config source const
Message-ID: <24053f8f4fcd89406cefa5fd289097b9cea29405.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Qvqpx7ct+y25pDI"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--+Qvqpx7ct+y25pDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct git_config_source` passed to `config_with_options()` is
never modified. Let's mark it as `const` to clarify.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 4 ++--
 config.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index a871c7729e..ca6dac6e23 100644
--- a/config.c
+++ b/config.c
@@ -125,7 +125,7 @@ struct config_include_data {
 	config_fn_t fn;
 	void *data;
 	const struct config_options *opts;
-	struct git_config_source *config_source;
+	const struct git_config_source *config_source;
 	struct repository *repo;
=20
 	/*
@@ -2116,7 +2116,7 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 }
=20
 int config_with_options(config_fn_t fn, void *data,
-			struct git_config_source *config_source,
+			const struct git_config_source *config_source,
 			struct repository *repo,
 			const struct config_options *opts)
 {
diff --git a/config.h b/config.h
index db8b608064..e66c84520b 100644
--- a/config.h
+++ b/config.h
@@ -232,7 +232,7 @@ void git_config(config_fn_t fn, void *);
  * sets `opts.respect_includes` to `1` by default.
  */
 int config_with_options(config_fn_t fn, void *,
-			struct git_config_source *config_source,
+			const struct git_config_source *config_source,
 			struct repository *repo,
 			const struct config_options *opts);
=20
--=20
2.45.GIT


--+Qvqpx7ct+y25pDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWT4ACgkQVbJhu7ck
PpR96w//TtQ8rGldXC7I+nD+hwtkO3SanSAfxfvcxm8IEqoaer35gsZ1UCalsELb
0deS0JZyCgMN8Y1Ebmn9TSld3+KSEamVaCCYUWFyYVWY7QPTzjC/I7J9tKjnvZr5
KsIsAvZSfBvmlGLZ/MdbpyRn3WBBusonObI2n8BUrXTE7Yiox6kxnnVYem/tm+mm
sOV0sboWlldHfy/owI0iilI+5jkihfiYBLHf/h39yFvLmIG/RkvM6ZizU6HFUJvd
QUeGHkZIi6QZox9xdjMpQTO7DlgPu6oVqbWCT0sPgj4nMqOYJv69NZSV2jkW9RZS
8BCOjuZxWDPua3iEx5ZkHOwKPSuJIqj33AGLyTWavLtX4VGqruk5GPe3IpClsjio
EZP/rjemxFIhoIY7naufyFNslAXQAPgjQHUcmHwqa6/hakzOecZM049/LxHaAJOW
ijef+JdHu9GJBKjtMVEiv6z2jaovheeklxWE7q58PdeiG3/YQu1odYL49UnN6TGT
xEW4FGsFVa4DzxPleCCl6NJvYmUtCSXRvZgHP0+iVadxmE3/FJeDGHfXI+efDnNq
o+dMSs0tquTM65VX/4oDeIN0yvXd+Lfwi6NLacSrzZ9OJeNMQmHx3PDBdpeGL7x1
TUT8ehEzOSfnhlgAgW3WRAGZrHwQ3s7+K10S537hmXMNQAlvGJw=
=/Smn
-----END PGP SIGNATURE-----

--+Qvqpx7ct+y25pDI--
