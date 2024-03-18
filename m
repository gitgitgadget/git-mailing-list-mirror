Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D7374EA
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759194; cv=none; b=BOs3nI2Ou/HWceXBMnJTdpvgslmIyFfKj15n3aTGgzHXCLd1KDTzIyojgAuTV94t+0o7X6TJSnhjK5U+ozLM69RxSxVZZ7elgbKGIYFIWUbeFaVlyv+6YgP+ChlsaqqpcmNVPwjb5/8XHjLLi5jjIIEXEuLPy6NcYt9DGTsCxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759194; c=relaxed/simple;
	bh=wuAk0t3F5g6z6Z1pJHc4XbHgyoIs7lThnQxBamyTc2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbDuT2z5fH48qYGD2cd6GZoNObQsWYmqs3Z8486u/Pdi4ly2PE+tkHN6+HuxFAErYcHxyc+Sb3Lz7DkTqdES6bCMgjPdsbFrUzIgWW4WnPO1WuMnxpbk3+xNK+rUYnHLsBS6rlbpwv0yN27GdahtcvELe5fwLlDqyMhJ/xMVYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IHku+0gd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zg65xsRX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IHku+0gd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zg65xsRX"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D60E213800B8;
	Mon, 18 Mar 2024 06:53:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Mar 2024 06:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759191; x=1710845591; bh=yAtfXVjQ50
	LC4onQe5lyb8sFfUc0dHFM2vUMy5ASAUw=; b=IHku+0gdR9zyDP+EuSGLn52X+R
	fa6s2huq+HhbTAsr3bWSX4GQ0tPpKQRczULb9W0A9/0KRgtP2DRCHnprlinKtnj+
	hdAbv96uxQIxDClvMXkyCoExaeeGSjBWIEnmDMjnqN0ZRAUWEH2cls0zjh4B8c9a
	qHzPjbk7w9STeNRKnoQrISTReZ0zxaYzU9DmhUKh1eVfa+JBMmLbjsj6nI1cWPQr
	4whxQfAlhP3W9NHBIjt3OItBxXpz6Z0ZtTlpVr4oa2sMv17tvOWsGxtAiu/foRNu
	rLsNDSvz8UMShshXtnKvMG8HmSooj2XkFQYZ1HLphINWZajNKwaJc5aOCUuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759191; x=1710845591; bh=yAtfXVjQ50LC4onQe5lyb8sFfUc0
	dHFM2vUMy5ASAUw=; b=Zg65xsRXq7XVumbzZNP47CiPwY+XcFzg7XY9RyyidHCT
	avwiLSv2tplO52q3Fzh0e5IIhTd3OYvMKAn/MRVj1APX2/AS+5X5W6eDad3oYzRG
	qpgEkKRN5NYVznh43ExUh8Wh5AxKzCzk2eNc5YHeXIwLO/Plry191faFVSxtD8sD
	nSSjvcen9v91fm8LdTdPifKmcCGlOA25PsOC0Mf8rCnnkpCBj8O8rXRLZt2Za6Le
	sRXY3mAA1YrWXDyplzPzLJp1byoTjTfNim2QyP2T0V5LY2LoVPeGhEZYdwquFdP+
	+MLNtn7LsIMspWFZb7QkUaFK2zS9GtaQqs1Skch+jw==
X-ME-Sender: <xms:Fx34ZT1URrP0bzsq17u7Z1nJL40RtX99DvtIbEalHFab8zBnoHGmFg>
    <xme:Fx34ZSHI0lpyWki1ElcYfpXhhh8dlv0gCnXk1KsdOTOLTEN6WO0JO8pSRtmByg5Nf
    0MHnWRiHYKe6u4vCQ>
X-ME-Received: <xmr:Fx34ZT40WR_ERLngElJkfiksucb_84rSQtBaZhmFPbePYvmDa3QJAwKFsZkzZ4PW754vOXRlBCF2rAGdBrWqayGN_v1KJ7OeJIurzX7OUxQ9HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Fx34ZY1e9q_KAXDNcwyKhLS6e3XeghouWV9m-O6dWuG-_Hs96-8-Uw>
    <xmx:Fx34ZWG0GPGvPIBgRdr7TvcTvErAAyRgRfcquKfVgZklQ7l_9HuUkA>
    <xmx:Fx34ZZ-P5sF2wBlgB1EVeDa8d5lSz8w68vg-7X3md0VwZur9yADYRg>
    <xmx:Fx34ZTmSZW9ypAev9aLBvckEhay8yxHoZJleNpMpnseKdL7_UsZWIg>
    <xmx:Fx34ZSCqj5pmhp9NXlFA33ynYNvQi5mr7bdi5XZe6T8M7nojXmyQ_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1573318a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:19 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 10/15] builtin/pack-refs: release allocated memory
Message-ID: <ff163a621d3b55924882cea1d1c51c074ce2cae9.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+gn22jVnk2a/9UOe"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--+gn22jVnk2a/9UOe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the command line options in `cmd_pack_refs()` require us to
allocate memory. This memory is never released and thus leaking, but we
paper over this leak by declaring the respective variables as `static`
function-level variables, which is somewhat awkward.

Refactor the code to release the allocated memory and drop the `static`
declaration. While at it, remove the useless `flags` variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-refs.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 97921beef2..ea2baeec76 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -13,15 +13,17 @@ static char const * const pack_refs_usage[] =3D {
=20
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
-	unsigned int flags =3D PACK_REFS_PRUNE;
-	static struct ref_exclusions excludes =3D REF_EXCLUSIONS_INIT;
-	static struct string_list included_refs =3D STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_refs_opts =3D { .exclusions =3D &excludes,
-						 .includes =3D &included_refs,
-						 .flags =3D flags };
-	static struct string_list option_excluded_refs =3D STRING_LIST_INIT_NODUP;
+	struct ref_exclusions excludes =3D REF_EXCLUSIONS_INIT;
+	struct string_list included_refs =3D STRING_LIST_INIT_NODUP;
+	struct pack_refs_opts pack_refs_opts =3D {
+		.exclusions =3D &excludes,
+		.includes =3D &included_refs,
+		.flags =3D PACK_REFS_PRUNE,
+	};
+	struct string_list option_excluded_refs =3D STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 	int pack_all =3D 0;
+	int ret;
=20
 	struct option opts[] =3D {
 		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
@@ -45,5 +47,10 @@ int cmd_pack_refs(int argc, const char **argv, const cha=
r *prefix)
 	if (!pack_refs_opts.includes->nr)
 		string_list_append(pack_refs_opts.includes, "refs/tags/*");
=20
-	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts=
);
+	ret =3D refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opt=
s);
+
+	clear_ref_exclusions(&excludes);
+	string_list_clear(&included_refs, 0);
+	string_list_clear(&option_excluded_refs, 0);
+	return ret;
 }
--=20
2.44.0


--+gn22jVnk2a/9UOe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HRMACgkQVbJhu7ck
PpQn4Q//cNh8sZU8FNor0DEJ5d/fzgsDsMmtRYYYgvpZyhp/HB+Xuh7UbVE6c8cJ
14XrUB2tqBBfeoEblgB2a2to5Ox21ETFT2QOfiT+mG0/8q57jGGZL0t+tEgX3dEr
O4foM0+bdbzAxC7iNd5WyB0+k+zt0Z5CQCFvjPEy1lLaJ5CpkqcACZVzNRgqlwHO
5c+PkdmZ+jlPMGb9U8wQeLhpgfuxq5TLaXfCXmiFea0+o1t9YD4w4/5CD6N+GejE
a9+9Es0W9Na13djrDGmzewLKS9U1Y7uMddRLhId294GzRBubLUbWZc064ugjT7xY
szF4YM/Q2BLXyI/fdoI7N/nwWeMOqia76QNqIVabCYgB+ZsEwyZOg7xBm6x6mlBU
ybd3qvK2iSDKKgmxI2RTOSSJByiwKAdGddqPLYZhd8TyP2lqUdiXRdE3Zat+45JP
pjADlVtLQMNgpfzOxMJLeexUJEFglET/C+GLWBDYcS0TB7Y/1WhI9/fkdopCq2+1
ZmhhbA7eYmU79frdRv4GrcDGhhVwpFDMj6dZcHG+r2ufS6zBrSBUIKUubBHkkayL
tvM3NmsBlv1LSvHLqpKNmPzNf5ScDig/oHVJy4cFLhamodCbSUPiDEi66fbYfCOI
54vO5UUf6OG3kR75FsCR/ayXEDeX0kOM5xjFElX8NTzw6LCCdZs=
=r8MN
-----END PGP SIGNATURE-----

--+gn22jVnk2a/9UOe--
