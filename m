Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B485659
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545675; cv=none; b=LUo+SX9EBAVHeXMdy0PZaD8WYDcuQ8m9YLMkbgFWgGpIkn91dsunVhsqgLnhiU/6BqK/lc6hA0ZyjqWrgdoTknNO+WJP/MMmvQvbk5nS22QQvkFS094CMP13MPvZgIF3j3+OoRy7LD+P5muorzUnkeZY7hjrGegEU7c2sDuw0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545675; c=relaxed/simple;
	bh=XqbeWE0+0wUg15Sw5OY0kCqP3dd56ZH0ciLt2GQF0Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNwUJS8jG+uPBK6QUfxSxnbvRKVS9nTGoEpu5uiPthUoK9WUaZGsjds9KnuYIsBh5ON4vLPLH5XXoZxUm5zbv04gISUWN89vQI/0WRq58sv+sEgn9edPnIAhNtbh42g24lN6kqtTwbFUFpFVJAMUWcR64+01sBC7duQoWuwoheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kb49RSgP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DvNFtp2Y; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kb49RSgP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DvNFtp2Y"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 594D113800DA;
	Fri, 24 May 2024 06:14:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 May 2024 06:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545673; x=1716632073; bh=Y5hZK2vs3r
	qw+cu0Fn0d2S8saugV6bBkGK40Ait2+dg=; b=Kb49RSgPcPdXQyog1ZfYkmCJOW
	+qjentYhQf0/B6QrPZbWvQECBBH+IyRzHl7hquqHZKY6AyE2+SaRTH4WXfaT+FY3
	GNwXALJHozo2C46U5mvem4+K90XGjUgl8HZROZemUQSiHSy70HlU56YaxqjuzEDI
	0tuMCWxtc1BOVBp31YOMNYu7ecmn3mOmNbJG2ayMrVqFgfQI5Yvy835lTZXn5c3H
	SHhTUPQX857MDLYSvMTcxFcC45Z8FuoMBRVO3x6G7gAyhA+DbgZIc5rmwNPR+GiF
	TOD56YUh1PfkH4npRdNar7L8fVb6DH9sARFXqm0CQmiZNGnY8B6w7oNwbc8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545673; x=1716632073; bh=Y5hZK2vs3rqw+cu0Fn0d2S8saugV
	6bBkGK40Ait2+dg=; b=DvNFtp2YiA746AdBwTlYEJFmNOEUlUvsa1Sif12zA9dN
	nnyyh9xDNC+ftJmxrZWbRSZ4X/q4892rN5kLr98DV1arMiUigB2Ll5gXhWlgBNXH
	IXYiS0Egkypk9s7pGiOR1Fy88pVLYYurgX3rJkhZXUN1/w+HsngkSirUTkwUZrWY
	e8fPTIeqHfr0c4cHZJrXNP8zFtYoFFd2yLX2ozR5S9ds4uGZpYoijWqFmpAq0FIO
	kv8kobFlXjqsuioKgZW4O0UEg2yCIce8FQYn9c43M0MoS4V2macUwxpLhtOkJeLY
	zk1KdzwcyrUrz2JnW/NfS0jfYuRLyWDImOb46OgCbg==
X-ME-Sender: <xms:iWhQZvPzet2DIrAQO8KihiiiDx1jYrUc1UGwN2zHMpdxFCX9jfQf8g>
    <xme:iWhQZp9MgKrv4SvOfoXHWzEU6nVAnApJr1aofsmpbrNgXi20V7pxEktWRNlJchCnd
    a4qOY9Qo8vUqPBN8Q>
X-ME-Received: <xmr:iWhQZuTRa1kcm_5W7Suc4xE7_2NSXVPa6PAfoOipQFGcKOPG-zK4vrZ5Ok22PNcd8bSnHxD4DPFRdZrVWSgiR6ytIdJB2og5YRrCQU3Mdl8aRis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:iWhQZjuijmyDl65EAhieg4_je-f1NLMYKnnU49g2n3Kh7b7y3O26pw>
    <xmx:iWhQZnfZI1OUX3AXTzqJn_ziTGrsG5K7bA6d0aaVObxyDMC7yYQaEQ>
    <xmx:iWhQZv0dP8jeL9nJOOysfj9dSs67zcjvmKvWDUrVvN0QHhXVDFPuEg>
    <xmx:iWhQZj-kqnWPftjpPEYZtoS3rHdNhjQJZJi5NH3zymtlcypDS7EFhw>
    <xmx:iWhQZj5m_GHgIRFrEpbct816q7HYM0uaprIm6gMRL7j4YN64nSOj6icT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:14:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1cd63e2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:14:29 +0000 (UTC)
Date: Fri, 24 May 2024 12:14:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] setup: unset ref storage when reinitializing
 repository version
Message-ID: <8b11127daf4c1d06eed4a0c83dd3dc981ffdc728.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cc8YleikuGxoVA7j"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--Cc8YleikuGxoVA7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reinitializing a repository's version we may end up unsetting the
hash algorithm when it matches the default hash algorithm. If we didn't
do that then the previously configured value might remain intact.

While the same issue exists for the ref storage extension, we don't do
this here. This has been fine for most of the part because it is not
supported to re-initialize a repository with a different ref storage
format anyway. We're about to introduce a new command to migrate ref
storages though, so this is about to become an issue there.

Prepare for this and unset the ref storage format when reinitializing a
repoistory with the "files" format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index 7975230ffb..8c84ec9d4b 100644
--- a/setup.c
+++ b/setup.c
@@ -2028,6 +2028,8 @@ void initialize_repository_version(int hash_algo,
 	if (ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
 		git_config_set("extensions.refstorage",
 			       ref_storage_format_to_name(ref_storage_format));
+	else if (reinit)
+		git_config_set_gently("extensions.refstorage", NULL);
 }
=20
 static int is_reinit(void)
--=20
2.45.1.216.g4365c6fcf9.dirty


--Cc8YleikuGxoVA7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaIUACgkQVbJhu7ck
PpTXJQ/+IzBKThqvIHIjudwGT7PARG73GFA/ypYWh9dTSVMEMNSzKfS6DsWUS1AS
nsY0ocvr3OkVm3xSxG3fOy/fMv8XwT3ZmbXOHQhmkW5gfeR2jS2gP1Ppqt4G1CjX
c8O+znbZ384A8P8PJ/eVZPYcXSaTxsQn8ITL1g10ahZ7oG0uK4KOByZN3umX/BPy
ViDOUPDeExwvunHfGFMApWeDg2ruExpRR3OD4cewcYwI3BXIakP0ZtGlifdkXaKY
Weh4ILyROypGBTk0b1rQAkPjlxQFbGvpCuUwcHy0OAhF5dFvtanI17cBwrOUDqg5
zunYZIiJptLb69YQ70LGA5E6pS4AOZIqZ+fuXuAd4Th8Oru2C87AYw7zSjlgkC86
ye/ShMuTz/ZyJi1Ft1E9Y8SMacmcxM5i/mSLTRrtuZwJzc/BCTnJQh5sqLzP0+KB
XorEt0MrziW9hmAFGmUhYoOBtqV+Vh57PZgbjoIl2fkMlmqt7L4OWf0B0Ztb1s8X
GoxFTAXdWuQXnFBlYSC+8+bmIFh+PUxXjDIqY7XaX7XYUuV2seA13/caSLkV/DOX
57Y7acG1Iu32NpUi74Un0OvX4S2+o3T+nKnqP4qdtFCEtAKzJAVgj26voCPJVW9k
eNWtoihVz3soPsy/L8bYedMakW3vbTsF3Pks/pZ4eOSELuWAZbE=
=OW5H
-----END PGP SIGNATURE-----

--Cc8YleikuGxoVA7j--
