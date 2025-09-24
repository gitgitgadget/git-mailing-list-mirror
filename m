Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FD27381F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700552; cv=none; b=ZB7zL0Xi+BB6c6NUSEiwm1UOQ11l+2DLoDt6JcAeEi+U1L2G/NYjPL5xAuT2OFmONxt64NyDmXs1VyUmhDi4IS+vlamOAZQGJrzXt0786vvbU5UbawzTXZQ8pcOps6ZwTU+x87+QmMO+rjwezRF+JZff26vEpI7Bgx3CI1xKHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700552; c=relaxed/simple;
	bh=cbJ4qXO2q9/4p7fxfyal35dORKtWY9lK7fFsNON1pW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWt/T3wZyP7SwDMGuBt1yc9PRD8+0FCtmlN4uLDTwmwNFk2IJTwu9duKQ53+ivIwvauXoLtXTVUOBpruQO1EY3ccSfOOQcTjYZWGTWxTzCyGNmo949xrqna7qlgc4WfWhLHU7XlZuSdu9xI46VYRhhKo0pNjWSDNb4m3GSgDckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OiyQwV2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TK8OgDzE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OiyQwV2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TK8OgDzE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 508631400070;
	Wed, 24 Sep 2025 03:55:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 24 Sep 2025 03:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758700550; x=1758786950; bh=gOubJBzkNm
	pQtgTWndehEv+ijkVhw8sLH55EDs8tUwY=; b=OiyQwV2uIRE8/IaFYsz4Zi+BA7
	lKiGAO73XRngZifW7+co/n3XU7RzvCqOfISPljWz/aNgT1abgVXmztECm7F59cJq
	OBhuwpCzSkCEXmUWqe94ns6iZ5QT9s0lOELdzuSwxUM7gFQXGmVZADnQ8GlIpQxe
	5wyalyd/zQIRS/GlVfWplwVII6wGb29GXVNqxRzsfmgbCX6FO8MyaoFlHq2ApBod
	KOfXlt9mRlQPKBaCLw67YrI7dlKR1sWdM9RXrg8h6fEZTF78IoVEcfDycam4NaF4
	mho3spcV6AwQVTn4sdXr3Q1YqnARzz/N9wyHmtH0ULEGmWal44Fu7K+/oPYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758700550; x=1758786950; bh=gOubJBzkNmpQtgTWndehEv+ijkVhw8sLH55
	EDs8tUwY=; b=TK8OgDzEBCAoq8zr5+EJzxJ/+Q4pY1bBOmUyWtF0XSRebNS3IQM
	IqRo7X5L8czf2jQjkQcaWAOmQmxrCroSed1SgWeFano6wRZdUJqgveXTMbGqcBnN
	WMmiiMoUSXrmxfOEy3jtSIXCzTDBtEby0qmOF+YB4kWqoJTUvznkKreoegn3Cnc8
	aGJlLzf2OlzKsFxakeuZdg3FeDBKR+rIZvgCbIoshS9/TlmT2+6ChKmZRD5EEJ/B
	zxAWWc3caDy/FcHGtxVPddjCNdlRoB2+uYEQByIomg2rUPZAlZ488qOWlDUoaK1V
	c1ij0YJ5dgP0IgwW4UDMqanab7D7KqM+6mQ==
X-ME-Sender: <xms:BaTTaGTe0kM-xw5tT_n0QiOl-I6wGm9fhVfach4b7CV7rVS_dn9Sgw>
    <xme:BaTTaCxJ9XNb13k4CYVu-uSSNQ2khfUdvTNbos3CvsoR1kQpi3K5EyCWcpvi8zlwP
    ItCbqce5IGfZe2BJzH1EAR4lZAZ9BfZOX-KwMBRI-R59y6-ums5>
X-ME-Received: <xmr:BaTTaI29p8ncyfhy3Le31wuYGzGhEaGu1mbv4EvhFQu5CEM1hn46NkKeY8CHVeDKh0ajQBw8DNMyZtsO1eERvshu1S9GfnjR5qvXtSZbkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:BqTTaA5x1G2FyvmYY08E4tMzwLC-Z5AoWxUcUo-dCqkUZXqfU6cPpA>
    <xmx:BqTTaLXsL6v6LPkR1ukx2_VgMkjQxdVoWyuyTG0HyMT1Zo_L7g5DLA>
    <xmx:BqTTaPC0hG3C_wU3TIBnFOhgEe8G3wy-xMhEfc04HsEn0Wga01UTXw>
    <xmx:BqTTaK69O1ELoA7yG8TacUjrI5K_IRYyRylnTio3fjKyf2hnOTwlGA>
    <xmx:BqTTaKF5MEiy9e59cZypT-yqiDHJLxY5-F8OwoxR6ivg17YZXPRw-Y6u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:55:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7fd4412 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:55:48 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:55:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
Message-ID: <aNOkAYsqavZjnYSO@pks.im>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
 <20250919010911.649831-6-sandals@crustytoothpaste.net>
 <xmqqv7le45t3.fsf@gitster.g>
 <xmqqms6q45nl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqms6q45nl.fsf@gitster.g>

On Fri, Sep 19, 2025 at 12:13:34PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> We currently have no documentation for how loose objects are stored.
> >> Let's add some here so its easy for people to understand how they
> >> work.
> >>
> >> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> >> ---
> >>  Documentation/gitformat-loose.adoc | 49 ++++++++++++++++++++++++++++++
> >>  1 file changed, 49 insertions(+)
> >>  create mode 100644 Documentation/gitformat-loose.adoc
> >
> > Fails a build, unfortunately.
> >
> >     ...
> >     LINT DOCSTYLE includes/cmd-config-section-rest.adoc
> >     GEN lint-docs-manpages
> >     LINT DOCSTYLE includes/cmd-config-section-all.adoc
> > tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc differ: char 3297, line 176
> > Meson man pages differ from actual man pages:
> > --- tmp-meson-diff/meson.adoc   2025-09-19 12:04:55.145229743 -0700
> > +++ tmp-meson-diff/actual.adoc  2025-09-19 12:04:55.149229734 -0700
> > @@ -173,6 +173,7 @@
> >  gitformat-chunk.adoc
> >  gitformat-commit-graph.adoc
> >  gitformat-index.adoc
> > +gitformat-loose.adoc
> >  gitformat-pack.adoc
> >  gitformat-signature.adoc
> >  gitglossary.adoc
> >
> > Thanks.
> 
> Probably this should be sufficient?  Not tested (yet).
> 
> 
> 
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 4404c623f0..93fa3dee8b 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -171,6 +171,7 @@ manpages = {
>    'gitformat-chunk.adoc' : 5,
>    'gitformat-commit-graph.adoc' : 5,
>    'gitformat-index.adoc' : 5,
> +  'gitformat-loose.adoc' : 5,
>    'gitformat-pack.adoc' : 5,
>    'gitformat-signature.adoc' : 5,
>    'githooks.adoc' : 5,

Yup, this one looks correct. But in fact, we also need a similar change
to our Makefile.

Patrick

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6fb83d0c6e..e1d38fbfe6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -34,6 +34,7 @@ MAN5_TXT += gitformat-bundle.adoc
 MAN5_TXT += gitformat-chunk.adoc
 MAN5_TXT += gitformat-commit-graph.adoc
 MAN5_TXT += gitformat-index.adoc
+MAN5_TXT += gitformat-loose.adoc
 MAN5_TXT += gitformat-pack.adoc
 MAN5_TXT += gitformat-signature.adoc
 MAN5_TXT += githooks.adoc
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 41f43e0336..64f70ac724 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -172,6 +172,7 @@ manpages = {
   'gitformat-chunk.adoc' : 5,
   'gitformat-commit-graph.adoc' : 5,
   'gitformat-index.adoc' : 5,
+  'gitformat-loose.adoc' : 5,
   'gitformat-pack.adoc' : 5,
   'gitformat-signature.adoc' : 5,
   'githooks.adoc' : 5,
