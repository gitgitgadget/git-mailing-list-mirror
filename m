Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E79C249F5
	for <git@vger.kernel.org>; Fri, 31 May 2024 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142199; cv=none; b=QPZ6+huoUWBdgBRbUvTDoMh29fyhGv0wywNBn+nU6oEBmM6SxZWryuay9mM+yrU+WCL2MTeL0ccEV2Q2VRwnRtjOrmZXsNKdpZqgDWbMO97v01aCM5SOlIEma7/sAmonFZxlxVgQ6lbheGIrMrO5//ASwGqNqjRsrVE/vDqoFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142199; c=relaxed/simple;
	bh=1w/Xwx91LgQMkKhIgLNks3cDmYt3401euyV+nuHMgfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVGGew86E9doMV4Onc9A1oC+iorXih7X/5d7wBe6hDipK3AdL0894Jn/3u41oRbQqzXMjX1R30Dao7LSvT2f1FiM9JuYYPBQEFyY6SROebN/4xMtG+IphKx+aIGdNqmQUgn2dxPR8EjmTgfv2DC/Xx8Ts8yT7gz6hiGzkSNXZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=egyStNJZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZJHMYoh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="egyStNJZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZJHMYoh"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5E9DB13800BC;
	Fri, 31 May 2024 03:56:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 31 May 2024 03:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717142196; x=1717228596; bh=GB/7nVw+Oa
	lL3vXgDoFon2gRz/6K8R8DXJQdpgqjb2o=; b=egyStNJZyiZ/2diEAvGkWnoT5J
	D1vJoWzaMY7g7ktJxMFJRmtMq05f3YYy5DdHQT3l8Gy/XZcP3jUQbxBHfLyASOoW
	KEbzwibLOFByI370uVi4iZhjtFw0hZrVKNK2rcZJiIicuAhvWiWLwmYPNTezk5Gv
	2fiE+ReR6uWlZgkVe2WLTaCiP/EVSYq90GYEE1O4KGUH5Sxz0JZhBY4NWEC/7L2v
	QHOUem7p8hvG+WnkqsyBQ6GwYm72Sdl9iQlRxaLf3kmWfMM9UofQ5iXS0R1eXQv3
	AO7qGpqWDWJ2TGbipACtC4HtQnmRq86DuHYjdbP0Rnd8LgsY5sJ2BGxF9JRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717142196; x=1717228596; bh=GB/7nVw+OalL3vXgDoFon2gRz/6K
	8R8DXJQdpgqjb2o=; b=nZJHMYohEJST2Rh399cMOnpUkDUwN3wxaIQCcLfzBqvW
	Lq9iZ0h62UxwPycSyKNHLgpD0Sx9R0PLT8lizDmsFEtQXbYABha4SGZAz/ZOjpb/
	gpMG+H+22KPhyzJcokyX0ORRaSX3Nd8RGPxAT3+fwXFNKrZ4/e8VF3V3+Fo4gCbM
	Cpl7/d905FWRFCunX9FX9vGzo0HTIe2gSXHYoSRkwOw9x13FK2mjn7JpTfrkCIWP
	QfmFmCJnv1KSkc0JfK9GGOU9AcoLVuRF/EfFl6L3rWxL+PcwHv/GUg6pcozjQaub
	R8/55+VxrcjFdDltaTwpo8CT6bGQKegQI3XfM99oaA==
X-ME-Sender: <xms:tIJZZm16IQgSivSjxRDDZEutDFSTXOWaYaN29Nf4ozS1cVAcLhd92A>
    <xme:tIJZZpEqsTRyn4C2iL2r0_REA77rBpmvfAktdfu8CKORAOjL7_18HtH6RsteKpISI
    7ZU8K7QNyBqcBd3yQ>
X-ME-Received: <xmr:tIJZZu69uY6Mi7QZThTfB84u7r3VRoYlJsNzyDJQVCOjSYvlCv7hEo60AJyuYLatl_fNZl7CS19Vqm76Y8ZRUprVzBxU8ns0YAw4Pgys1neFKt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekhedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tIJZZn0eBWanzzT1t9VK8l2jRlCl3FSrUKd4JoBL0ytBu14lSXMVcQ>
    <xmx:tIJZZpENEsdeoxfHD4piEFnUGcMY8xZrF6YMlAdLhVhxMLzXm5bwpQ>
    <xmx:tIJZZg-pcrsvs5tMWBHNV_3rrH79VxnjbIBKfFXwket2Vm-4bU5c_A>
    <xmx:tIJZZukGJyLhgFgfNUXeqa29cr5sls-IwSlDODLcoBZNlZ2lmmSftg>
    <xmx:tIJZZg17bl9VsDfLgvwiqkQRTZODlaKPVZNRESUOPu-h3JJbvZyOVkzw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 May 2024 03:56:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1920ca17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 07:56:16 +0000 (UTC)
Date: Fri, 31 May 2024 09:56:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 1/4] docs: introduce document to announce breaking changes
Message-ID: <993b9363484627cd828362e39f15c4905ecaf3e2.1717141598.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717141598.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5aVmb5P4O7okKhG4"
Content-Disposition: inline
In-Reply-To: <cover.1717141598.git.ps@pks.im>


--5aVmb5P4O7okKhG4
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
 Documentation/BreakingChanges.md | 66 ++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/BreakingChanges.md

diff --git a/Documentation/BreakingChanges.md b/Documentation/BreakingChang=
es.md
new file mode 100644
index 0000000000..d8a26c9bf9
--- /dev/null
+++ b/Documentation/BreakingChanges.md
@@ -0,0 +1,66 @@
+# Upcoming breaking changes
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
+  - Changes to long established defaults.
+
+  - Concepts that have been replaced with a superior design.
+
+  - Concepts, commands, configuration or options that have been lacking in=
 major
+    ways and that cannot be fixed.
+
+The Git project will thus irregularly release major versions that delibera=
tely
+break backwards compatibility with older versions. This is done to ensure =
that
+Git remains relevant, safe and maintainable going forward. The release cad=
ence
+of major versions is typically measured in multiple years.
+
+The intent of this document is to track upcoming deprecations for the next
+major Git release. Furthermore, this document also tracks what will _not_ =
be
+deprecated. This is done such that the outcome of discussions documente bo=
th
+when the discussion favors deprecation, but also when it rejects a depreca=
tion.
+
+Items should have a self-sufficient explanation why we want or do not want=
 to
+deprecate a given feature. If there are alternatives to the deprecated fea=
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
+over time. An earlier decision to deprecate or change something may need t=
o be
+revisited from time to time. So do not take items on this list to mean "it=
 is
+settled, do not waste our time bringing it up again".
+
+## Git 3.0
+
+The following subsections document upcoming breaking changes for Git 3.0. =
There
+is no planned release date for this major version yet.
+
+Proposed changes and removals only include items which are "ready" to be d=
one.
+In other words, this is not supposed to be a wishlist of features that sho=
uld
+be changed to or replaced in case the alternative was implemented already.
+
+### Changes
+
+### Removals
+
+## Superseded features that will not be deprecated
+
+Some features have gained newer replacements that aim to improve the desig=
n in
+certain ways. The fact that there is a replacement does not automatically =
mean
+that the old way of doing things will eventually be removed. This section =
tracks
+those superseded features.
--=20
2.45.1.410.g58bac47f8e.dirty


--5aVmb5P4O7okKhG4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZZgq8ACgkQVbJhu7ck
PpSpnxAAmb3Vdkn1tPitEFkxmWaizMjjS/DAZeFr7uJtOcujWKhsWhycyftWPuYS
tXIGew/3l9Ye2BuSgRotTP+AC/xhrKrcIr0B6eQyhaK5PRKU5XvKQxCQAu9V8VJd
9BG6rQzDb/VPUt7qQRHvy6pkiBTYPw3iBLp9Hd2jGmASUVaDH9mMXbuZs29/bYNd
0GMp9ExXYOg5si+QcPxM4J8lKuGit/33UFMbj6J0Os8lHBThD5lGpSqiup+Lj7wz
ZGtqwgpLCv6iQnG5HRW2OAquP6xJZfe++2FAs6QKQMvKGf8kNgNONQuGiS2OZbg4
gslC53BJ4Q0AlQ0zyPC/UcrKlGfupKCocK2JC4Ubmf9QK3ahKml2cBfvgCKKLgg4
AXiNN5CmwqdSXEYJX09YHgkaegVWIiq9Emj/jV1Xk1hEXrMNUUUTPCw3c1nUj5G2
5CS8hq5rZ9oEMtL8OOxYBTV56U7do8zSq96DC4cXXwBoJUybqO4xciunB8qVHrWE
FgTHGQh+lmAtCHqKg4GJuBLvRmhoGufIYdMna6pqVAWFGyt90XIWeOL+ljxkl0sa
J2eb1SoIwfuMu4pPoIYpjY2gOGt6ZDJ8+exyvDYlXS3GY3mPyn2qLRKFgmmAKWT/
Aw+Dd4kDJuxGQGydelQ3Za4Y4x8soHBK5Dele6ZGEPnvtUF314E=
=i3tw
-----END PGP SIGNATURE-----

--5aVmb5P4O7okKhG4--
