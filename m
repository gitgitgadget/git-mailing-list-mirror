Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7B7E765
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406910; cv=none; b=rbIkDWCR+vQoSTeKmyYg3OnXevJZQEzG+myPcfMriCNiM2LIWgl68PIhn3/6C2CwiYiBGyZaah9baPgEOIfPOzK2NzU6uMXInXNIRviUKja0LArdno9q4TkU8dE3hJB8CRis1vhinhHov2FHqiY51X1hDXbXuJ6cYQMD5W2Wtfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406910; c=relaxed/simple;
	bh=6ToLD7U23rybj0mllJ4HuJ0O132cArcdpT+yK5mG2xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h89hv+RzHarSTkqiVZOJhqIGahbHQRo0RZIVpoeqAZA1mVVx+kGf2Cu5jH8Zm/cXZgsO/VjzqxuVu8NFLqfoFxQjbWktBaO4shNr6UWTvCL91U1btEw0bNuyCyaT/APmhi/tJ/KTHCm7VGVzoCDdU/gQVyJYFZilZviHAhAJL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e/XNWjEy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UOkLt43L; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e/XNWjEy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOkLt43L"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 0158D1C000EC;
	Mon,  3 Jun 2024 05:28:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 03 Jun 2024 05:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717406907; x=1717493307; bh=0TYCGHaYgf
	S5cWGQNZHx/eUaN1t5ZPoy9Q7iZc0poRY=; b=e/XNWjEyhmKnNbjIjLOBHaNPAx
	Kawuw0LZmJormj24VkIFU6dv32y6YLvQA5vQIhcphY0TFqVPVJ+3PYf59ZNdQWJI
	Swfvftg/GOS0A+LVfRjF21HCsZC2rP/iuHF6F0kI1IB434OVr0IVBZR2y4xBygTU
	tNZtLmkzO3EORRbIhs8yPR15+odVNRzqsqnj33VeV8/6PaZFGGSCriyTRGMrdloz
	SyAjI+Gf0+LS7iWUhoZ0X7B2mYxpaIfxih4QMxOKfwa09vHJ13v5kp0zfIhgbg+G
	aRG5APnnyr18Y0IAcr38oeku8kRAf+R+3PuWuCb86PVDk9kynfyYg7GnsYSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717406907; x=1717493307; bh=0TYCGHaYgfS5cWGQNZHx/eUaN1t5
	ZPoy9Q7iZc0poRY=; b=UOkLt43LX84XAnThR59DNr02dhHS4+8U4EIA2tgS9E9N
	Xi3LIwNzdNz2zweFECEdzmz0Iiw2H3mMGESUoiKqC561taTwzEtBV6CA8+GI5Jid
	r43Jnjdsg39LugzH/XFoMaZvL/h6YcQE84inqESWPkc2xOevxCn9H+PMpokGyJ0b
	q9wcYHVD+sYmRH+WBO8uOYj4B/+VOt+2OZgB6BJpwIMEnd7HP8vlHUdi0bUyenSg
	12vwgR2hXl4TfZOKkKfdWkhZx8Y+g9OpokAop5bs0SDlTzBxcUaielpwucdly3z2
	C7nEEE8bppfLnmwD0Yc05xePPz+uFpqkJHxo+bzzzw==
X-ME-Sender: <xms:u4xdZo-Q44o8kuvBrWpKkgpxXZuf3hzUw7k3RYHFnVU7NDEFxn0F1A>
    <xme:u4xdZgsjjyQMY_GUqG02IzNiDjmCUdHZ6QOAA5ykiJc3x-9F7GFq5FnVeuqwB-pHo
    9WbMiWjumV7Y42wQA>
X-ME-Received: <xmr:u4xdZuAl8vnfaqQ1gl-ysVrR71DTigF9xw0vpcXU4rjzaPyx-eNmmUBT2kjf-05Wlpfjw127qVLFPqe4C_cRzxlQWeKOB1XJkIj5cvRc2gdkDRhq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:u4xdZofMhGkmezRz3hzMcVNJoiS1lhBbRqEz9XGKnpRt_OP6n_kLOg>
    <xmx:u4xdZtMjBBiqg9U-W9MeQHCMRkvKSUTn-ikSBBYkUsU-QFKFXGfHag>
    <xmx:u4xdZilvXXNgScca-MtVLVF__Tx3XpTbzgsFWnRm_dVvoT7rCe2lIg>
    <xmx:u4xdZvu7EIttx14e-uSDS5qU1QkG8nb4Ws4FyDmcAA8Gi0BzPxEYOA>
    <xmx:u4xdZmhG9rujYW1kzR-2T4HgPr9mCwzJANTulqqt48PCis-DBgkdo4bw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:28:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ee45fcd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:28:00 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:28:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 1/4] docs: introduce document to announce breaking changes
Message-ID: <67cb4de5cbbee7f7d4e22a7223a4838551956f26.1717402497.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSjHhEHD6zjj7FQ2"
Content-Disposition: inline
In-Reply-To: <cover.1717402497.git.ps@pks.im>


--LSjHhEHD6zjj7FQ2
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
 Documentation/BreakingChanges.txt | 71 +++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/BreakingChanges.txt

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
new file mode 100644
index 0000000000..ddce7cc301
--- /dev/null
+++ b/Documentation/BreakingChanges.txt
@@ -0,0 +1,71 @@
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
+* Git 2.0, released in May 2014.
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
+make the described change. If there are alternatives to the changed featur=
e,
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


--LSjHhEHD6zjj7FQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjLUACgkQVbJhu7ck
PpSv/RAAkFgZAYucx8RftqOlUUbW+mjI9zxxN3W2v+AfzARrLRzAzhaCD0PD51Hc
4amK/q/3vuzbCxovs25+LB7GS5UU5P6CYWkB7ouUfcvzquRfP/f6ZPngz7ZAIT6A
Ooue7RdocDHfcNTSRuLWAf7wnLvfjDinu+6XiLzHzvmqWV/a28nKRhzOtERqrTdV
D95qcxHL1KawPsZI2EiUf5IRC3/ctgfy2B5yxFLYRPp1Jo/X9KenFSELEoJjAQU9
JugSu4a7EauS3/hSSaaYmjCmj9kq/P9KtreG4MyIml50QXyR96BWUOCvxyRUqAXs
o8KwEf3BQM2IcT7elZsYv1Rrs8R40oYbrIUMSxaU3UJynuq2l3c71tQ5Ji3K7ocR
yZf2vHRYrSf6umJjTDqSHLX5mnbQgAOdvCgoujiPWqQRlqyJZErxqIs45DiPBdPm
ta2xr74tEpdQrn9IVZ/jymI5B5dAGYP4IuGI2VxNTeyumHjTYQ7tX66YCyKNg/Q7
aRWZHPrYU4LrHqG/MmQiGzki0XgyyLnLQfgOcOpTA9lXZZQD8Y5Sdh7uIA2TcP4i
6wikAzYh6hrRBZrvt2Fl5v21M4fy9Kv4rf1WryJOu1XPXq3IAU3vNYv4OVGuvvtI
eOLHlsFW4kYvbbPboRfVVjOpsnfg9fgSgQ3nhKRQm+6XGd6K7u8=
=6+3w
-----END PGP SIGNATURE-----

--LSjHhEHD6zjj7FQ2--
