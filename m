Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E1140E2B
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480000; cv=none; b=ivWluBQIXQ/wJg4ET1LnAPMWATi5KyMQdhLWyJU1gDXasuY9qiYoPV5Ndf10ZT/ibuClOtuawKY2e6Dafyb2Z1H1vUojVlNfhMbVEwEGzlsHur4win8scCTDFt6pLHD0zIn2Zd2BTnxEiJRf4wKfEDpYh252zW4Nbzg43MWv5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480000; c=relaxed/simple;
	bh=6v3yUM1b95Isyc3kG6N+MTUA6aTWj6VDhE/Wuf1OU/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnrThdI0sbMAVRynsGNkL9B8IlNl4CsV6ofipBJO2OLF10As85Sop4bvU7qWb80ysKCGmBUnxneNW/hw0O2BUz/C7QKaUyIGbvIc/K8FDKXnn9E/sWiTcXpEF4OsbJ3fdHEk0VmDq7t3mNMQt5ixpbCE9Nc1qEVj0eUBgEY16p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X8+tvfdO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqPAp3U2; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X8+tvfdO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqPAp3U2"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 956021C000EF;
	Tue, 30 Apr 2024 08:26:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Apr 2024 08:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714479997; x=1714566397; bh=aVEPaepXdb
	0P4qWB2nzG0hEc58QbkQpgMuIDP2IZ58g=; b=X8+tvfdOw08PEqC3uOJkgSMKPX
	LkPrQ7FvVCDULIu88Ccsko4zdGPmaEgdRr3Gud37qMitqrgcb3nuWvremnUf+T0p
	qtv3nLlyGgmKhx5nYQ4EZHOSposmibNfx0xZBd38XXRq26bEJZfWbFiY9LvUD5x4
	2zVptaZE/s0KcDdNsi6sTQJlQfhOaYj3dF4PThMSpca82WKtVBE70Q/rfKz5WC3X
	0k/cgBD+xkWehNnMCST5A0tbPOVxOKN8uSCOwkc57wDS/y7rfnjxFTYjw+7kp3VP
	dPcWoi+M96s9bkHMajTTggcYLNn+vCQ2GOCFsRoioPVh54ZQducjBPY8FFjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714479997; x=1714566397; bh=aVEPaepXdb0P4qWB2nzG0hEc58Qb
	kQpgMuIDP2IZ58g=; b=EqPAp3U2j1m5XNVSTyBaV7qRi7OTR2lh3bMONep2Uhzg
	+N0ml0axWfPUbewfcz9/Gfe1aP4TjQlZZFJj8pTOwHbtZScRqYWs7HAKxobDiDb2
	IS9j7JAqajFnfRSRgr3ZqOS37LQIjfKyFBik01OGGmO5MbBMArxKYSg9Z+VVF0vc
	1UgND5+7KPh7qDFyy2TNS7A1wEDQQFEgioIaGmMGzR3Tihn170wvzrk850rKSicB
	RA/nZTHniMw3kkGQibeqeFR92anuLEUvZAEPcvjgFjNk8/rjMInp232qAXOo91mE
	INgOYC9TKGeODOhQPpQWtDSIU8bbmz1a35Co6FM/SQ==
X-ME-Sender: <xms:feMwZrJkG4ZpbYPnYsPtHXH_8gM6lY1CW6pKzLKaYLtGc8Eo9C_Kug>
    <xme:feMwZvLnLy7IWUL1LqBCP2ajKlaUimQPgqy9_NeluJv50cSfo3CwHla-M3phz7gJO
    B4oeAd24TJVXh2uiw>
X-ME-Received: <xmr:feMwZjuGQVtDBcrtNHyACU2t0zKwQpsQ7GQ3Q3meWN6Jd7AdmX9H9ePCgBXowb7mmKQz6O-GBI0UKR0TxwOGbJtkogiBQi0LdbMVLJj3WmaXTPJ0wNny>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:feMwZkaVxuaJEMfTVMlHTeKxiMrnldhS2-K12qPJt9gV41XW4UOjig>
    <xmx:feMwZiY3djm-8csDKi4yNxjxDSLlXyBmXZfu-KDsHmIEnPnsUyehdA>
    <xmx:feMwZoA70PiSRpFEecXtqH-O7MMNk4CXQDWvgRECaGMaQIF7WtKJrg>
    <xmx:feMwZgbnu1K2qTAHfXTmlcdff9qYKAPAd9eetVr4XWd_eyq52-6y7Q>
    <xmx:feMwZnNa009R4Y-YZTtNM6Afprx1lrZgIPjdkqhGRo3dWq4b2noTDnU7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id caa4ac69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:13 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/10] Documentation/glossary: define root refs as refs
Message-ID: <9659d7da3f38e706af22b4cef0a3e77f780493fd.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bGfIBKhVqCDDoLCu"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--bGfIBKhVqCDDoLCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Except for the pseudorefs MERGE_HEAD and FETCH_HEAD, all refs that live
in the root of the ref hierarchy behave the exact same as normal refs.
They can be symbolic refs or direct refs and can be read, iterated over
and written via normal tooling. All of these refs are stored in the ref
backends, which further demonstrates that they are just normal refs.

Extend the definition of "ref" to also cover such root refs. The only
additional restriction for root refs is that they must conform to a
specific naming schema.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 33 +++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index 13e1aa63ab..683b727349 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -550,20 +550,39 @@ The following pseudorefs are known to Git:
 	to the result.
=20
 [[def_ref]]ref::
-	A name that begins with `refs/` (e.g. `refs/heads/master`)
-	that points to an <<def_object_name,object name>> or another
-	ref (the latter is called a <<def_symref,symbolic ref>>).
+	A name that that points to an <<def_object_name,object name>> or
+	another ref (the latter is called a <<def_symref,symbolic ref>>).
 	For convenience, a ref can sometimes be abbreviated when used
 	as an argument to a Git command; see linkgit:gitrevisions[7]
 	for details.
 	Refs are stored in the <<def_repository,repository>>.
 +
 The ref namespace is hierarchical.
-Different subhierarchies are used for different purposes (e.g. the
-`refs/heads/` hierarchy is used to represent local branches).
+Ref names must either start with `refs/` or be located in the root of
+the hierarchy. In that case, their name must conform to the following
+rules:
 +
-There are a few special-purpose refs that do not begin with `refs/`.
-The most notable example is `HEAD`.
+ - The name consists of only upper-case characters or underscores.
+
+ - The name ends with "`_HEAD`" or is equal to "`HEAD`".
++
+There are some irregular refs in the root of the hierarchy that do not
+match these rules. The following list is exhaustive and shall not be
+extended in the future:
++
+ - AUTO_MERGE
+
+ - BISECT_EXPECTED_REV
+
+ - NOTES_MERGE_PARTIAL
+
+ - NOTES_MERGE_REF
+
+ - MERGE_AUTOSTASH
++
+Different subhierarchies are used for different purposes. For example,
+the `refs/heads/` hierarchy is used to represent local branches whereas
+the `refs/tags/` hierarchy is used to represent local tags..
=20
 [[def_reflog]]reflog::
 	A reflog shows the local "history" of a ref.  In other words,
--=20
2.45.0


--bGfIBKhVqCDDoLCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw43gACgkQVbJhu7ck
PpQiSBAAiJnubMB/ytXyn9UXsPgEWdRwmebFIUpDTpy+FmFtugbp4dJ6f/Fki46D
HCyqo10lJKrSNqyHCdB7TIMHUyX/XtgCOtMDC1BnkNv7k190zoTDoGk4O5Z8lFAk
jb7jrTCvs15lDbBQPvGHifTB7J6BUQqmLdHeMtlZjEcj7o6HHRqs+1X5BO2gEl6F
Ve7HB9c5HOFqnA7wIzC7OWsbthRSwiCs6yXxbMheRXIZm8xVaAHW0XVCeLQc4mwP
LePsDhQvag+5MRV+J0xc/7dg+zu+qBxPJktUXtrUZkEbH6rE5A8qhIOKelc76Q4n
PDBHk33/c9woxb8XQUnNueCMlaDUQlEG89A2Vwo31cS0tiiL8mLR8fb+McYf4TFO
1hyqtwdvhvLp2vJ4Ya8BiZ9V9rShYX5Z/EPUwBhD3rzhR/pCT8RFsagvu1o6YSgi
C7ynN9h6wvk6vP+m0gmSsJ2o4YqlIQ6eDGk/YUXG8BbbZgJWBHFCrpHwrYpjakmm
Y5f+rmG6cYEd1omofETi6rCAdDEmgCTBN6Et4oWhLhJLUfqhMLiUaDJEph+eQVFl
z8oWqB3ZCvfZxL4O+P9XB5lrTFj+0qqUddzeASzVncU8iEtPv9K4srASCFRBYAQz
CbJ10zjEy+6PCLLNEIzVb60mOZvyLqViQvEEWAS8LQdWFi83WPU=
=cMAz
-----END PGP SIGNATURE-----

--bGfIBKhVqCDDoLCu--
