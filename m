Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD121474C4
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347361; cv=none; b=fM0OKyogPVz/Ecf0rMhOTAhstuCoJcwSDIC9c/d9/359Q58Se9R+zL46Su2SOEecrST6h9Z/gvNUTLX7Sams80vOD/xgmqPDz4DsDaBPY2UEB8odav1P5I4giSUMuHd1YpJJcxEB+DZVKt33KFOtg8H6GifdkhZJxPgdTqfwp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347361; c=relaxed/simple;
	bh=yjRxY865Nl3opplYGojSJv2ah0ORmST4Qa23Q46kIq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikSyYtMSs62Ye0BB+eaO1N5TzKaEnUHsahj5rvfjXeKCQiA9XnWpzylq1s9s82B5aIERMucUsj0btSS3xcWI5qhAr/Vt9hk5S9OAqu4q6AUWLkQe0Ky4PDchu7o3Z5d33kG9jQF/j9Tiwlhnji5ELY48NGITIgI7H21dys3aKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GdM6TJsV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EviMjzwp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GdM6TJsV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EviMjzwp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D96871140218;
	Fri, 14 Jun 2024 02:42:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 14 Jun 2024 02:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347358; x=1718433758; bh=F/3bikShhj
	ITOiLZ+h4O+eed0BKRB3SboZPZ994f7AE=; b=GdM6TJsViIeKMfM3Gm3j2v+VTG
	eHyUBsdYd3nQ6PIck09+iuNdMJmUBO6aOzJGdmzwPVIDsFliVrPIv5GM0pLW7ReI
	T0XuiNgZFbZQ7++3kMvloSxOyh6lBVuCvS+im9ixZ3CBSQ24EnWAM1rhGjVkoFw1
	ThBs9S7nQNTk9WW/vIKJBUqIGUxwhyv3bCW80tXWyHzPraTPI4XKu6ow0VHZH6xq
	io402iajX0yDK8kTf0l3E4OCwwIjux4VSAV8FwxUoUrSYz1JrHkR2DHVS+2MKRPg
	avCKIwOWgH5MW9OkIqFulzXNt3pBiGgEJpzzcYKZwBiskZ2vv0YLUCRDk4Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347358; x=1718433758; bh=F/3bikShhjITOiLZ+h4O+eed0BKR
	B3SboZPZ994f7AE=; b=EviMjzwprDJEAqlyglAR+z7jcOBPUbqrG6WetgppYvyp
	QE/JZJrbjbt84i6yxXbwlo/GVHYxIQ05h3dK8F/4R4QOSFjV78Yiupyjncx0sRbZ
	+zq2ffWPdfQ6vkWhjIjx5zekwM4pWLth6S+4MRxMuFDruL5+VlMf17G2v+lnz5F9
	ri7neuXPTpZHT8l9Duxrxq03IRqr/Wls3plXm53JXQaRknsY5+nzrrE+fVhwXquS
	eGBhm8roGXid2OmnAxjn7TMhqXxIhFkTrtMbWh65Euc3da3eJFWrGLjMhVcEX+k+
	bA7v2Rw9QphwM7+TNY3/j+h5pA4xYpoNUyJgD1hzlQ==
X-ME-Sender: <xms:XuZrZm4YzsrmpWmwu1o6v5AuUaiUid4FWzzdaaDKVq8hWN-2aht2tg>
    <xme:XuZrZv5WEbWH9_CK7yeGgmtRVPcwx5ZF36wkdWQXAumyaudv8HFZ3DAgsAJK2RmDH
    WqGAnfXlD3pFJqY1g>
X-ME-Received: <xmr:XuZrZleWEhoNtL1l0f8uSjyCpDMbpr_Ebeoot4nO39aDRxqZzdi22yYtTlba0LoyIHlevuN2T6p40nBrHB9DdxTFDdcHFAu_da0hy7uUaAfhow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:XuZrZjKZExw4lA8Rh_UuKQM2wGwO8gOXfwpRR0t-iepSwim29qWYtA>
    <xmx:XuZrZqLqVmJQpsBlvu8O5q0wV-gDy4t6o5NIH2IUFsxBjKo_yKOZmw>
    <xmx:XuZrZkwPDkBPq4zhqSKNumIGb5hFwN8oMbLtD2NBpWCRK2g1yMe7_g>
    <xmx:XuZrZuJcaFwGXSSI0ABIr88dRYnXKOMOv9bBjx9QkYCB0e__WC6OBw>
    <xmx:XuZrZp_C_7pF7nZ7BOqzuxzNGZXKMfz5ZU2WYKEwQszdvb0gkqXl_sdS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:42:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b6ce7653 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:42:22 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:42:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v7 1/4] docs: introduce document to announce breaking changes
Message-ID: <6348f27b591f306d79c69594ed3157e22ac4774c.1718345026.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1718345026.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ox3NCOa4t9C/KKRC"
Content-Disposition: inline
In-Reply-To: <cover.1718345026.git.ps@pks.im>


--ox3NCOa4t9C/KKRC
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
 Documentation/BreakingChanges.txt | 80 +++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/BreakingChanges.txt

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
new file mode 100644
index 0000000000..cb7e30312f
--- /dev/null
+++ b/Documentation/BreakingChanges.txt
@@ -0,0 +1,80 @@
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
+breaking versions is typically measured in multiple years. We had the foll=
owing
+major breaking releases in the past:
+
+* Git 1.6.0, released in August 2008.
+* Git 2.0, released in May 2014.
+
+We use <major>.<minor> release numbers these days, starting from Git 2.0. =
For
+future releases, our plan is to increment <major> in the release number wh=
en we
+make the next breaking release. Before Git 2.0, the release numbers were
+1.<major>.<minor> with the intention to increment <major> for "usual" brea=
king
+releases, reserving the jump to Git 2.0 for really large backward-compatib=
ility
+breaking changes.
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
2.45.2.457.g8d94cfb545.dirty


--ox3NCOa4t9C/KKRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr5lkACgkQVbJhu7ck
PpQUtw//S8utceywURtmnzu5Uy67Tp03rJIqTQY25EFmIOnv9hrL0nx1ri9/L6yc
+tRclN7CuSRcfMpJ2CrPr3EsHo1jS7xMIn71uyqVMoptxg0oMtcK/w7QlKq6YS1+
WsuAN9niysXu0eCqA1l+MO4a7Xv3brw+n11gizqmkQeBowXj3qrphGIUV91k5kEK
EQVmzbX6GnY33hS3gxvmjmfl5Y8O79VB00VRAPoNHFx4iUT+jLqY0F5+fbXq4N4j
B0oFOzwg3MsRh+Mr/pQ2QkwZxRVUhfDNFSG+gpr8e2NlirHZ8cqoPUyUWAqKPTOd
iSXAYW1VdLyQv9dZK/Rd/qhupevJ3s0s+0RDePSIqfykn2o6/hQAs8aSF3AZnlpv
kMMsev1/DNxqdU+4963LwuSp2P03DoeuhJjb33Yc8UfFYdFa4VbsyaLCyaWdavl9
/W2/kwd4Aq+uiBh56vf2ORN6gZIInBn4rTpKnUKJJ2LeuShzJghD1Ptn5sAdkYk2
hwJ0kzb6qW5PLvkwofQfhQPiIgUmbk2VxlgWyCQlXYRJpSFHJtxfoky/GAPzP+0D
kxihlNyxgIcFDxNxG8Xj2sW6prQsItTTI4SvNWJeigmmHySkrWTida6ZN/HTs1XK
IP8byfy2XYUJZkHus/IH1IyPrTLPMFJsY8YnEu7f06cevKBV2iM=
=aJU8
-----END PGP SIGNATURE-----

--ox3NCOa4t9C/KKRC--
