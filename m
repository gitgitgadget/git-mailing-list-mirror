Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72EA14600F
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504364; cv=none; b=p9BhREuhtz6tpaPKuckdYlAUOxnUe9nqZeH+q0n/0lGJH22uXMIBAmRwEupfXSAmG0d/kHaL+11KpW29DiaQ+kRyx9QD51P0oAYg27PTvUWhsCBh8XmmzTOMvobx41c6VdCLKYVDL1uvjIuxt/r3b2/0k2dfueM6Un086oelVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504364; c=relaxed/simple;
	bh=jVaYcMs9u5o6ZhAebx0/FEFS71PCkHGQlti8sUBECFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGzUYLxivaoN/pT7dt+tK8nogAUpfegVRsLn31MA+3Qr39KG23Sdjf/Q/GGkfb9IyiE3kmaoKdTEoONW0hU+TRPOpstPA/NKioq3ob7WqK6lPTJFz0YTacUWAQZrOWJPPGa0ru0SzVvUpPxNGxyi5/4OTtup2BprXafDZZk0fRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ov0y8fBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rse8s+YE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ov0y8fBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rse8s+YE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B071A138013D;
	Tue,  4 Jun 2024 08:32:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 08:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504360; x=1717590760; bh=QPtCs0rtG0
	OsIQWeQPWIxDMgt6UbCPO5UdtGRpGKM6Y=; b=Ov0y8fBp9c/5A90U0c1C7/C1Jz
	G5xZ5oi0u6VNqYQwbUulcER8VyqzPXQbdIAApaIIi2wV97X7S5TGmumOcXeImM2R
	isrD3NuYPXMN53LDi8V96b0N0I5Jjg0YfODKUfRPDnyVlja1oCySbWln+YwAlSs4
	OcI6mXj/TIIZAGyVqVoKX2VxWiQCg1Qe+1XvnoqTXS8TcbGq8qrdjHPuQWu4gV6W
	dbz8yZOz4Ids1kOXEMmx1O5yj9LFEt3xyA4voFFTOCQ9U+fhZyBNdddazuwuKOGe
	kD21Jl5GqNRQwPIKtul8H4Tp3s8UCdGVX5PNNnzzBfW5+nwz86UZ9lmo0DHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504360; x=1717590760; bh=QPtCs0rtG0OsIQWeQPWIxDMgt6Ub
	CPO5UdtGRpGKM6Y=; b=Rse8s+YEXapFoBisydwatOedRfltEn/qcoxtgUk3TZVW
	Ysc+6G0fte5N8bjCE4hzgi5KqG6GBFCdNk3SkMyjJIeyanyCsSZ6BlL9DMFuCqLM
	QWz+/zj97uRvyXQ4+2vTdbxyJEu0Y+Tu6bO745FRezlBIWf2eHexrycosZKb+piQ
	cICcdK0DPGBzYKGp91/EeFhZnAuE0MX3rf3KPU6cCCFiuOVfbyB2BQ9mQ70zzuQk
	UZxbC1jrGKy1tltCRpxJHgdv4978ERP2B8MB9DDdiPzcYZlRi+lZY7ceMIVBnITB
	VTTOxRic2kIeXe5sTm5G14MQdm7XPITFiTec4zyflg==
X-ME-Sender: <xms:aAlfZjy33P3uScNm1UMO31v1HMTxWeTGH5Iv4jmj6aVfw4dGJNxGWQ>
    <xme:aAlfZrQI4J5Bf85I5eFy9LSb2LlejeuhAYlO4tUIm3bxy5EQQGqhH1xCYkNcXjcQU
    T8vmU6ztxrim3Gxqw>
X-ME-Received: <xmr:aAlfZtXEhQI4O-TMUftf9rrhFM3ECm7AjVqn9a-ZXTF_4gIDJJPmG8B-VkUTTANw5bjDgux0GazScLBdYUofHceauU5cNzfUvI2Jt-RcKRwMIUaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:aAlfZtiYC7HkltlxtDdvWCCA6sCmxX1toiQ_7NrQwJHaL17hiLTUmA>
    <xmx:aAlfZlDopUALgMKsGAzis-2pjBtv0HJwGdQZlaX9jvmNKJABxKKMJQ>
    <xmx:aAlfZmJmAqCi2O8W_s9mcaaoBxqY3PAaO7ioBwxQDrJBU3NOdb6Zzw>
    <xmx:aAlfZkA19xkmMc7xfK9vSHpMFS1eboAGWrDPssIy-APYaypi4vCB1Q>
    <xmx:aAlfZp2Ms_d2hUc6YKruzDdjXblZOFmHd7ymTMtxxQI8CELutpHBeZJR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:32:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f2d95823 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:32:12 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:32:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v6 1/4] docs: introduce document to announce breaking changes
Message-ID: <a260bbf281d2975562a042a71ca0dd7f88f03da4.1717504292.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U3c7pZqS38y4Fx5M"
Content-Disposition: inline
In-Reply-To: <cover.1717504292.git.ps@pks.im>


--U3c7pZqS38y4Fx5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Over time, Git has grown quite a lot. With this evolution, many ideas
that were sensible at the time they were introduced are not anymore and
are thus considered to be deprecated. And while some deprecations may be
noted in manpages, most of them are actually deprecated in the "hive
mind" of the Git community, only.

Introduce a new document that tracks such breaking changes, but also
deprecations which we are not willing to go through with, to address
this issue. This document serves multiple purposes:

  - It is a way to facilitate discussion around proposed deprecations.

  - It allows users to learn about deprecations and speak up in case
    they have good reasons why a certain feature should not be
    deprecated.

  - It states intent and documents where the Git project wants to go,
    both in the case where we want to deprecate, but also in the case
    where we don't want to deprecate a specific feature.

The document is _not_ intended to cast every single discussion into
stone. It is supposed to be a living document that may change over time
when there are good reasons for it to change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 74 +++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/BreakingChanges.txt

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
new file mode 100644
index 0000000000..36327b13b8
--- /dev/null
+++ b/Documentation/BreakingChanges.txt
@@ -0,0 +1,74 @@
+=3D Upcoming breaking changes
+
+The Git project aims to ensure backwards compatibility to the best extent
+possible. Minor releases will not break backwards compatibility unless the=
re is
+a very strong reason to do so, like for example a security vulnerability.
+
+Regardless of that, due to the age of the Git project, it is only natural =
to
+accumulate a backlog of backwards-incompatible changes that will eventuall=
y be
+required to keep the project aligned with a changing world. These changes =
fall
+into several categories:
+
+* Changes to long established defaults.
+* Concepts that have been replaced with a superior design.
+* Concepts, commands, configuration or options that have been lacking in m=
ajor
+  ways and that cannot be fixed and which will thus be removed without any
+  replacement.
+
+Explicitly not included in this list are fixes to minor bugs that may caus=
e a
+change in user-visible behavior.
+
+The Git project irregularly releases breaking versions that deliberately b=
reak
+backwards compatibility with older versions. This is done to ensure that G=
it
+remains relevant, safe and maintainable going forward. The release cadence=
 of
+breaking versions is typically measured in multiple years. The last breaki=
ng
+releases were:
+
+* Git 1.6, released in August 2008. In retrospect, this release should lik=
ely
+  have bumped the major version.
+* Git 2.0, released in May 2014.
+
+The intent of this document is to track upcoming deprecations for future
+breaking releases. Furthermore, this document also tracks what will _not_ =
be
+deprecated. This is done such that the outcome of discussions document both
+when the discussion favors deprecation, but also when it rejects a depreca=
tion.
+
+Items should have a clear summary of the reasons why we do or do not want =
to
+make the described change that can be easily understood without having to =
read
+the mailing list discussions. If there are alternatives to the changed fea=
ture,
+those alternatives should be pointed out to our users.
+
+All items should be accompanied by references to relevant mailing list thr=
eads
+where the deprecation was discussed. These references use message-IDs, whi=
ch
+can visited via
+
+  https://lore.kernel.org/git/$message_id/
+
+to see the message and its surrounding discussion. Such a reference is the=
re to
+make it easier for you to find how the project reached concensus on the
+described item back then.
+
+This is a living document as the environment surrounding the project chang=
es
+over time. If circumstances change, an earlier decision to deprecate or ch=
ange
+something may need to be revisited from time to time. So do not take items=
 on
+this list to mean "it is settled, do not waste our time bringing it up aga=
in".
+
+=3D=3D Git 3.0
+
+The following subsections document upcoming breaking changes for Git 3.0. =
There
+is no planned release date for this breaking version yet.
+
+Proposed changes and removals only include items which are "ready" to be d=
one.
+In other words, this is not supposed to be a wishlist of features that sho=
uld
+be changed to or replaced in case the alternative was implemented already.
+
+=3D=3D=3D Changes
+
+=3D=3D=3D Removals
+
+=3D=3D Superseded features that will not be deprecated
+
+Some features have gained newer replacements that aim to improve the desig=
n in
+certain ways. The fact that there is a replacement does not automatically =
mean
+that the old way of doing things will eventually be removed. This section =
tracks
+those features with newer alternatives.
--=20
2.45.1.410.g58bac47f8e.dirty


--U3c7pZqS38y4Fx5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCWQACgkQVbJhu7ck
PpR9DQ/+MYhDpKBGlSWmDbUXuCIfujzgvGIPp2jIabQ+3g4YydB1pglBal+wqna8
Pv4lTTs2zqnbFACzDw3WoYYjZEOIQwqk2iovKKryBnceshyYHGUhOS1pYL9NpXyV
CbOpW3jv6E556FXwiY9Cpi1B12DxddomQEq+8YzSpLA6GVBKtCyjpKgZaM6MFUVv
DoPEqiNoyW93VvagoNXc6pvtOZl+KQR8cH/0Vdy+W8TQ0JQTlG2bCzhFPhvB7pxW
AMfHW5HIn587lylxx/EZFIuwDq2eL4jREDniYC0RCAGlURzDRaAOunAInOmoEWvq
z8t/Hutmt5o8luNtxWXzQKABzbTIk+tRyfOAt4j7SsxCvHu1GA0LOD8c6eR8kxLB
f721ySn28oN3WVy6T3knMZoZQoDMKljaEHOffEXQwn271X2UJslPqtfnhoY1VyKE
mNjberKuVs4zmm+U2vLWjHD32t9ziz5LsNKYDyJSllLDRMYMd1LHG6wC0YW8B+Qq
u0pjMBqXp3ra4UlRFbkLWXifDSQ+Ha689QTBHHEunRHPmP8qRs02TW9QlNJf+L8s
2QGNH5BNvIBjl3UfEp0B36rRITvzwUJ6EaDQaBp093ZBAxlzPCWlHXn/X5RtF5w2
TGPZO90eZ2UGFRdY8TWzjzU+Rhwxf8IzSrgBDqRS/nm3d7ATkOw=
=EpD8
-----END PGP SIGNATURE-----

--U3c7pZqS38y4Fx5M--
