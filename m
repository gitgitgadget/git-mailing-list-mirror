Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9C1B86D5
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013872; cv=none; b=kWpYnYblyBJVuvm0fUG4s8wRF04xGwqRmWZQHQrfigTR+WxK5sK8e0lVjVz3olc139NeGN5hXChwrTVS+hyLmv8OiWS8Ykvbf4fj6qf2tSBVYk5Ss3h2xhVa0U53kSdpdCPd5Zw7I1HMu58SU/qa93T2hL8zsp02JxGZbeadE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013872; c=relaxed/simple;
	bh=d2SSJ0CCy1e6sXNMbn4jR8lSoVMZOaq5ytG7dyACQJg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mITjF1dOBTLhHcRL3Zg8sDLrFNy8zpv5LPp6KBKLTBo/sI3NhLRn+Qi4qRzmijVd/eSybQXF6yv2IbFJQfuhhrYbZRKbIFUKebAQVr1ePapCdxTP1s8k0JnffgSXnaNQ0uVk42fX7KuczLieLYVlfCTDtKITEU8jHmTLaQIECfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sj3eE66i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q+wsXjXz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sj3eE66i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q+wsXjXz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 12CBF1151AEE
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013870; x=1723100270; bh=rmUGikcNLo
	urq2e44V/TalVizwbgSEJ7ds5psnme3VU=; b=Sj3eE66iGgVbR7Taepe6Nfm/Ej
	RWwFAQK45TDV997y+WmvnpMk9Z3y/H75+wbW20GH3ROMp0dmHjzS+tOf+CICBbN/
	lk5kJb8Ci/jbiTRIsksNT4yiPuYd0cnrdVYV6xLy3ttnnA7AUNcK/EDvLcYihXhM
	4m9DZ++w9YKLFL9FgEOdyIRg5Ne/KdpZxf3ZGBRQuBmgiTeCTpoYU2ldyltweDwJ
	UFFiL+h55dnSqZAvuJZVom/Ob4PT/faAbFJvItaSuEA4lXvtxa4f8wPA7mIY2Hpl
	rkRZWaLUeF75lmSXKBmeNz03ja3kCI4B5s1zjzAJDJYX1dySg7miRUwaxDdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013870; x=1723100270; bh=rmUGikcNLourq2e44V/TalVizwbg
	SEJ7ds5psnme3VU=; b=q+wsXjXzdDtrVx2ocMSVOce3e06Y4u6DL2rA+bLYyBQ1
	0WIdH5BQ2VvkoHfscExIfm+STfC8bvdiqwwik6OmYW9SuJ43iIJ5zfL3abtA4nhS
	ITP4MxiKbFppW4BvOUgQxmgwx9/ivuCZP9v1ICUXEUWxJhu2mJZ56nTzT0fdeB6U
	HaK5NzNhDE8kAYft27dULTwCkL7G3XedZQ4fVK2XjBUCEnhtyPSxN3v0/VrT5qaY
	kfkzqXHfLeAFQVyuhIoyzZlueOw6tuCJgvjIBoV28Dnwc8ymotofQg8EL9iYO+wy
	MUXpFfBtFO6jqNn54IiMCX1+gQGI0we574cVgZSlbg==
X-ME-Sender: <xms:7RqzZsIte1e4zKodCKaF7hMgUGcCdon6faXrPgZQG9pX8pJTNLdvnA>
    <xme:7RqzZsLjXJ3VUpRmI5Z1aPe64PiIopM3oU0RgIi7YiLtglVDS04wmuxeKK5bT9XtP
    PIU4Ht7MqmI_evOWw>
X-ME-Received: <xmr:7RqzZsudZZ-AvYWw2ewcJ1OZaOiKra_6CkAi45-OUK8NAZ37CeClGPThw2vMadAclxa4vhIZyj8KfoCJFVYNCGtTnXocH8Kq6tQ4bp3RgUB7c0PW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:7RqzZpb9D_CtheczbRw5oqxOe0O6FvZS_u3C5qjiKRIVc-FieS8j5A>
    <xmx:7hqzZjaBL6snuz0YlhinjhwsKZRn-CpMmnZl0mBCuGlg8rP8FOlGSQ>
    <xmx:7hqzZlAk_wNBpRTUBlOscDHOjE08nQdqFW1uneyVdnTPvm_Hbp4zKQ>
    <xmx:7hqzZpbnnzo1tx1XzxydNalgTL5fWs7PAr6XDDeLwXRlfBDqDFZWnQ>
    <xmx:7hqzZqzllMxMAsvB-REYpAODLhKOjvMAsMDNM_B-pknS5n_JaUQFhyGN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea38f439 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:45 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 14/20] config: pass repo to `git_config_get_expiry_in_days()`
Message-ID: <cf7942479f75d95dcd8606b0947a8897ae60da60.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GcPIxQInqaDB5Nem"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--GcPIxQInqaDB5Nem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `git_config_get_expiry_in_days()` to accept a `struct
repository` such that we can get rid of the implicit dependency on
`the_repository`. Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 5 +++--
 config.h | 3 ++-
 rerere.c | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 4138dc50ce..33d9af29c8 100644
--- a/config.c
+++ b/config.c
@@ -2779,13 +2779,14 @@ int repo_config_get_expiry(struct repository *r, co=
nst char *key, const char **o
 	return ret;
 }
=20
-int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, ti=
mestamp_t now)
+int repo_config_get_expiry_in_days(struct repository *r, const char *key,
+				   timestamp_t *expiry, timestamp_t now)
 {
 	const char *expiry_string;
 	intmax_t days;
 	timestamp_t when;
=20
-	if (git_config_get_string_tmp(key, &expiry_string))
+	if (repo_config_get_string_tmp(r, key, &expiry_string))
 		return 1; /* no such thing */
=20
 	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(i=
nt))) {
diff --git a/config.h b/config.h
index 7674617a1d..3a5016afea 100644
--- a/config.h
+++ b/config.h
@@ -718,7 +718,8 @@ int repo_config_get_max_percent_split_change(struct rep=
ository *r);
 int repo_config_get_expiry(struct repository *r, const char *key, const ch=
ar **output);
=20
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
-int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestam=
p_t now);
+int repo_config_get_expiry_in_days(struct repository *r, const char *key,
+				   timestamp_t *, timestamp_t now);
=20
 /**
  * First prints the error message specified by the caller in `err` and then
diff --git a/rerere.c b/rerere.c
index 3a3888cce2..bdd9fb2ff8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1203,8 +1203,8 @@ void rerere_gc(struct repository *r, struct string_li=
st *rr)
 	if (setup_rerere(r, rr, 0) < 0)
 		return;
=20
-	git_config_get_expiry_in_days("gc.rerereresolved", &cutoff_resolve, now);
-	git_config_get_expiry_in_days("gc.rerereunresolved", &cutoff_noresolve, n=
ow);
+	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved", &cuto=
ff_resolve, now);
+	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved", &cu=
toff_noresolve, now);
 	git_config(git_default_config, NULL);
 	dir =3D opendir(git_path("rr-cache"));
 	if (!dir)
--=20
2.46.0.dirty


--GcPIxQInqaDB5Nem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGuoACgkQVbJhu7ck
PpSUyQ//WwoCL5qwDiA7sNPoweIwOCYmDOU9tiWjHlydZqBi0ft45UQCaCXtea17
Ou8a6msF1YKtORmq+vCvp6BKagJtqz2WPqXy+lMRp1y1OUwM9FlCbSv3O1EH9JFI
+GrEL9o25QwteXke7BDvVlyK7jN32hRQJH+fuW5czZ3VjGZcblqLsHvFOWQFmha8
rbVnd9QsY7vzRZBzb+evm2YRCLj2OxcMZ359zHU8TbQJrrYd0HzAjvXVqk+KM1Gp
79AfTgHrsfTpeXY+JntAkoEy4hZirp2mbMnClBvYmI02UuccnF0o8ehhZJKOp3wx
iBM5vKeCmc/R5i4ydmD8f4LkGSDXLeuV0sYk956BlHo7il52MeslG0VYGbMr5uRK
8L4ojvo16ib7BEYKZ+wQQesHgfqwzJssYfd7KXGvdF4OuKrIhBxHFBoT91a66seD
Leoov1uSW09oaPORygCfwmlILwirbud09oX/uM6HTSP8uA6Mc6PykUm+rn4gGe8G
US2EmiM2C7shi+UjCByGu0I+3hKH2NSo2kN5B4bcD+vVg3JmqR3KLXD1Bs2JFxLl
RDsLnM7xWAd0u+QqSl7c9UPTQoJJ7aY7LfYUalGKxLJeZMT7H/5PYcmeNfYaBxbx
Zv8bGKI/CldlXe0dVuWjfWpC0q9njBR0cgDlFjmuQye1s+UPGqQ=
=lpbZ
-----END PGP SIGNATURE-----

--GcPIxQInqaDB5Nem--
