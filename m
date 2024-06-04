Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29F14600F
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504360; cv=none; b=CklH65j0n72FY2omcENJLacBaHWDYUSFupCf9FqQIA+yKrX+KTi7ab+1zDApdwZlwm6yB5jXSoNchpj9rxl5k6vlKwn2yUbFLh4o7fSqK0/FOGy957WTLe+HZq1Q/ztPuMdckcIFW3mHM0Wc/Cr4k1+iFXu0MOYngGYerTXp1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504360; c=relaxed/simple;
	bh=rYSqrbu47GgyPJj55rSFOTilhphbqiXJ+yYSFmntxTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ5al9t1L4vT2TpQl9ZROL+WnZAkmNi2aEuYK3sS+KfM23I+iwoXfjrxA6JlgKbbb0Wf4+ucGo2Tu+P52lUiu9tt4t7cHBSMT8AlLQ/1KcZulW4hQiBF7bCZbckCCszDwO5JwbYsy6oh5w+iKNm4vqfaUIjMi7cgIX2N+dHPF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzTPhRND; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfrkqyQi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzTPhRND";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfrkqyQi"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C9C711380143;
	Tue,  4 Jun 2024 08:32:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504357; x=1717590757; bh=9SvrAFHgcT
	8GcPoy+2ZvAKSeBbpzzsLKJJKB6MazGqU=; b=hzTPhRNDwW6D6VL202GbORx49K
	/n93pt2SPmLSAzhkBFpcXkAdFXPTSjHo7u33QekpcjHdLFRx2j65ApDRFiWfbPGh
	SKdYHSm9yqvdY8/Pno7B9N5FU0ZkwR8iQ9SmeP1EpPIVY7WiwyBFieB98LHZPWSQ
	dHA3UVQ7+bF5884/pVYKdTAc+RT1aSl0QS6QYRl3xR9ugBn6AlsqQyKNQLilTRNF
	cQi6labJZviyAm3KQ0R5m+wjlFcyYLiN4Xa1UCv9o/m6CKIjC33no0gos+jmReQD
	XYKB+2h9NJNaB7WVH055mRM3cIjVs4ygGQfvCSCug2VbzdrU7g5gYnqTRTgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504357; x=1717590757; bh=9SvrAFHgcT8GcPoy+2ZvAKSeBbpz
	zsLKJJKB6MazGqU=; b=QfrkqyQi0Pwk1HAyWoTo/54MmnMPtAzQjr5nOqxxWra+
	q9jbZXHR/qr/FTOXCt2Uh+JQYrW37PGjCqRHcRAsW/slq7lXy4Nlp9EQ8klVmLDT
	7KyxJ7AAOpzeLXVqu/54FhJRyNPQo01Ti4jEUu97Hf7I1sxVt+rqHB4Xot17of4l
	d3+Z9XhNOrK3kOPNHHJU0DgcEW00F25LcUUnw/qdLb9suERwAUZGgSAMBCaqWYx7
	6uJptS1uYuMYcVKO5GNGGH/iDt18O/gBrN5aOCdIbwjqzX0sFVbHoaqC+GADuSoR
	9ehTbCUDKvyfbO2WtP5/hSA4SeglLcmb9M5Xvgb8gA==
X-ME-Sender: <xms:ZQlfZocwj2AfO5HYt6NPWDpsCQ4m3MpacDKPC6owXAcqn0bsy9hZ0w>
    <xme:ZQlfZqMP-9huxcjt1fd5c170K2ZlDxswSGZF07xr3_OYVYSd5mcAfj-26TvXxjVsE
    ET_Fo-HkQ0o3E0_vg>
X-ME-Received: <xmr:ZQlfZphylq5uLeSeikiSIpdLqq1BdCaZdrY9uEjcPXXIguZVLYEzROuIx2h9jeM4r60kRD9cHdtbPaAcHNtj_OCf1TCYNoTlRtqYK-MOPWNx_o5->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ZQlfZt_GBjp9fyeCeJG31gbmue8w6Zr3GfBbHJNdvFkkjPgt0n8JYA>
    <xmx:ZQlfZkvLZr_V8n-Lo5KlL9k-EOoDOD0WTTOtZkqaEO7EJA-0dDVWRg>
    <xmx:ZQlfZkGNdM2wgcDX4huKlaXVKDuXZrCZAxNznWaTydaZ09OVJO5FDA>
    <xmx:ZQlfZjMcEjqvQ0_xlr6hLqYY7TpfCVhx9cGtQCl8DbdNqEDkJbjxDw>
    <xmx:ZQlfZiAxp6WmBKULMqSb-Dj39--GTcIqr2FApGbdhUT8oER_Kk7GIJt8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:32:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d88b9aaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:32:07 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:32:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v6 0/4] docs: document upcoming breaking changes
Message-ID: <cover.1717504292.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="USBt4PJivht83nKN"
Content-Disposition: inline
In-Reply-To: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>


--USBt4PJivht83nKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

another day, another version of this patch series that aims to give a
framework for documenting upcoming breaking changes in Git.

Changes compared to v5:

  - Note that Git 1.6 was a breaking release, despite the fact that its
    major version wasn't bumped.

  - Several smallish rewordings.

  - Note that items on the lists should only be discussed anew when
    circumstances have changed.

  - Add some conditions to the move to "sha256". Also, note that we do
    not plan to deprecate "sha1".

  - Note that replacement refs are also superior over grafts because
    they can be carried across repos.

Thanks!

Patrick

Patrick Steinhardt (4):
  docs: introduce document to announce breaking changes
  BreakingChanges: document upcoming change from "sha1" to "sha256"
  BreakingChanges: document removal of grafting
  BreakingChanges: document that we do not plan to deprecate
    git-checkout

 Documentation/BreakingChanges.txt | 128 ++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/BreakingChanges.txt

Range-diff against v5:
1:  67cb4de5cb ! 1:  a260bbf281 docs: introduce document to announce breaki=
ng changes
    @@ Documentation/BreakingChanges.txt (new)
     +breaking versions is typically measured in multiple years. The last b=
reaking
     +releases were:
     +
    ++* Git 1.6, released in August 2008. In retrospect, this release shoul=
d likely
    ++  have bumped the major version.
     +* Git 2.0, released in May 2014.
     +
    -+The intent of this document is to track upcoming deprecations for the=
 next
    -+major Git release. Furthermore, this document also tracks what will _=
not_ be
    -+deprecated. This is done such that the outcome of discussions documen=
te both
    ++The intent of this document is to track upcoming deprecations for fut=
ure
    ++breaking releases. Furthermore, this document also tracks what will _=
not_ be
    ++deprecated. This is done such that the outcome of discussions documen=
t both
     +when the discussion favors deprecation, but also when it rejects a de=
precation.
     +
    -+Items should have a self-sufficient explanation why we want or do not=
 want to
    -+make the described change. If there are alternatives to the changed f=
eature,
    ++Items should have a clear summary of the reasons why we do or do not =
want to
    ++make the described change that can be easily understood without havin=
g to read
    ++the mailing list discussions. If there are alternatives to the change=
d feature,
     +those alternatives should be pointed out to our users.
     +
     +All items should be accompanied by references to relevant mailing lis=
t threads
    @@ Documentation/BreakingChanges.txt (new)
     +described item back then.
     +
     +This is a living document as the environment surrounding the project =
changes
    -+over time. An earlier decision to deprecate or change something may n=
eed to be
    -+revisited from time to time. So do not take items on this list to mea=
n "it is
    -+settled, do not waste our time bringing it up again".
    ++over time. If circumstances change, an earlier decision to deprecate =
or change
    ++something may need to be revisited from time to time. So do not take =
items on
    ++this list to mean "it is settled, do not waste our time bringing it u=
p again".
     +
     +=3D=3D Git 3.0
     +
2:  b36ffcbaa6 ! 2:  f7c6a66f71 BreakingChanges: document upcoming change f=
rom "sha1" to "sha256"
    @@ Documentation/BreakingChanges.txt: be changed to or replaced in case=
 the alterna
     +and will thus change the default hash algorithm to "sha256" for newly
     +initialized repositories.
     ++
    ++An important requirement for this change is that the ecosystem is rea=
dy to
    ++support the "sha256" object format. This includes popular Git librari=
es,
    ++applications and forges.
    +++
    ++There is no plan to deprecate the "sha1" object format at this point =
in time.
    +++
     +Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
     +<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
     +<CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com=
>.
3:  4142e472ac ! 3:  b25b91a5e7 BreakingChanges: document removal of grafti=
ng
    @@ Documentation/BreakingChanges.txt: Cf. <2f5de416-04ba-c23d-1e0b-83bb=
655829a7@zom
      =3D=3D=3D Removals
     =20
     +* Support for grafting commits has long been superseded by git-replac=
e(1).
    -+  Grafts are inferior to replacement refs as the mechanism can lead to
    -+  hard-to-diagnose problems when transferring objects between reposit=
ories.
    -+  They have been outdated since e650d0643b (docs: mark info/grafts as=
 outdated,
    -+  2014-03-05) and will be removed.
    ++  Grafts are inferior to replacement refs:
    +++
    ++  ** Grafts are a local-only mechanism and cannot be shared across re=
ositories.
    ++  ** Grafts can lead to hard-to-diagnose problems when transferring o=
bjects
    ++     between repositories.
    +++
    ++The grafting mechanism has been marked as outdated since e650d0643b (=
docs: mark
    ++info/grafts as outdated, 2014-03-05) and will be removed.
     ++
     +Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
     +
4:  9ff94b6f32 ! 4:  4fafccc3b9 BreakingChanges: document that we do not pl=
an to deprecate git-checkout
    @@ Documentation/BreakingChanges.txt: Some features have gained newer r=
eplacements
      that the old way of doing things will eventually be removed. This sec=
tion tracks
      those features with newer alternatives.
     +
    -+* git-restore(1) and git-switch(1) have been introduced as a replacem=
ent for
    -+  git-checkout(1). As git-checkout(1) is quite established, and as th=
e benefit
    -+  of switching to git-restore(1) and git-switch(1) is contended, all =
three
    -+  commands will stay.
    ++* The features git-checkout(1) offers are covered by the pair of comm=
ands
    ++  git-restore(1) and git-switch(1). Because the use of git-checkout(1=
) is still
    ++  widespread, and it is not expected that this will change anytime so=
on, all
    ++  three commands will stay.
     ++
     +This decision may get revisited in case we ever figure out that there=
 are
     +almost no users of any of the commands anymore.
--=20
2.45.1.410.g58bac47f8e.dirty


--USBt4PJivht83nKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCVoACgkQVbJhu7ck
PpTqOw/9HxVVy7/+maIbT/EtXhkLDCUvwjUEQxgEhr0grhwHGwrjT4GUHPo8ReWW
HEXkOECa9LVtoqPNaqNiyxnQaWqgkoy7SefboW+b8AMYVMKoRHQ2B3omAnsQYm8I
ok5bcsCp7EWfeF8v41ShrJg+1u4+d+vJ816y+JVe/GQCks238ekhJGO/bkTmCLml
D+oPXvd8RLfrIqY0HoF3XHHUzubG8gqWS0JNYjUs3A6ZzRN8o4inYfx/QSjqlQsu
criDdXGFJ8AddOpWDPcNLgMPJWZ93rf0S1wlfFoOzXGyNigrCxsjwWCUeW/O5H4y
AsPxhGwd9b1VbdMx4DTXtN+ULhNC0n9DAyVmhvk1wYZ5nKAYMIQSgpVW+6Xor6Zf
SRr+n0VaSFySAqHQNZp00hzfckq6E9DJgPn7emnCL+Y3lXPiTfYtniLpzbAuOQO5
9G40XMTKdTM2j9bAcw618ipnMjgKeBHFfOQ7SgDb3a4jIL6+UpmmTxiTWXJqUCyH
PUr/sWvdKLTN0gKE+MffDHyc7fB63JXb0ycBEMJjg2xWW/23nsrHvKSOES3c3Ay2
7zZB4fJQZty0S7fkVHOT05NyJdtw2sv4h3Z6GropTAQheeHj7pqyfFmaCYtJLME7
gVhnIoF5FMC3NgGo4t8GMlbK5R9DrVZ4/EFs3b+jX1QDnBDmKls=
=P/Qk
-----END PGP SIGNATURE-----

--USBt4PJivht83nKN--
