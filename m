Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD628D83D
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492502; cv=none; b=RW3p1s5jP5RaLa66szUHtlbR4pWMDOowJObfQolPNTSsXQJWhIUaVdAsxx5361Mdztyd/YdWI1sfYf/H2WovAPeHs+dm4cR0HZqQIoNLIb0lg3gv5odBg+kSQfOqudq+RFp6VqsZWXZue+I9RnDvxqLdu4mRCiS1alSYgdPjyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492502; c=relaxed/simple;
	bh=OU5SNaZGQ8lhl+vjzaqy+7rztdGQ5uXE7DL6n4UtTAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXSjsWqtoIC8bSrYE7EDxMPd0jm6Ffy0dQnKas+tQI64cTKk99cjvktEzAlg37ON4B1j+GBstOE4uNF+IAYdyQHhNiDpkKa5KuuBdecujE8ZYFOE8ibuhbWjMWMpdXOBf6i2MsC836ztQaU2wKMqO/G1kv2pubqq1YCbM++s1XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GWN/oFW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XKSokECv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GWN/oFW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XKSokECv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E0CE1D0022C;
	Wed, 10 Sep 2025 04:21:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Sep 2025 04:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757492497; x=1757578897; bh=A2XUPOA/50
	oX5AbLYw8ZCavcOjktcbI7PKQN6ZU+Mtc=; b=GWN/oFW96TJETKJskuJNTqn3Qc
	1zMngGJsEa45IJ2c9X0wKPAN0lfhgCWnZdy4xEnB0vv0uLz1pPpX7cGbvDpggVyW
	Ysw4vnr1Jbjuicee/TUkzsaJGz1SPX6nu2iQBVrPk0hPMxFDqZLYu6yCqHG2qbtu
	tpdAbFj+XOCo8jFKlsmRcGh2NBrv/yga1SbotDdVWru+hYYwjKQ0eljiO9k6gAWl
	UtwON+TQhoSXRPKG1fqDiMzJ/uvANnFCdC6LdXpVs3xz0clpVWKDVEdxkFt+dnIJ
	Ui0hdMjnRAmeKl46rR5jT1j40CX/1xyY5SkbGGxascsdIdLBqCEwtxeJTEGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757492497; x=1757578897; bh=A2XUPOA/50oX5AbLYw8ZCavcOjktcbI7PKQ
	N6ZU+Mtc=; b=XKSokECve28GE5xq/urB2WCROVQBrO4aYZvyY3DsPwY7QlVk03G
	WfbLdZKbPqvoBYqRVEaoi1AZbtyj/je0GlUG4Y2ssl51VBcKFnFTmOy6z4Vkn0yK
	yUJghsbcW3TfR8zuno8wNMcBVd1QUAeEx/6mxlCpeLSF04p0YqFRhIKqzcDYtEjk
	p2j7wQjtgNsAxVdQpqgedcAF/nhBNDKCp8T3Ty4wih1VAD5vs0c9z4eRziNEm0ut
	EXzR+W+lsTdzW/0CAv0S4HWl1wE71owBXkTNfS06Rkz6S1O+KlJ8aC1P1RNcJVWp
	dKctYHg9fZnq7imVP7Wyx2msHSTgEsoSV0g==
X-ME-Sender: <xms:EDXBaIDlYXT4Ianc6CDI90b5mtrycPGk257iRI91RtRjz8YD-um9fQ>
    <xme:EDXBaGVXpsA2-JNFaJPovGi4qickU2tG5Rj9IvD42ERyfoA1sVhLc63CBUnA_iDkc
    Va3bLkMSGAe6LbFrQ>
X-ME-Received: <xmr:EDXBaCAY27sU7bY3_pqCW9fx-CWqqGvYKUw7DX1x5HcFvf65BprFcJGM2IfqZJbQIoo6zCXuBpIwglQQoS5xqysf_dr9wasXdvqHgUx-xaI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtoh
    hnthgrtghtsehhrggtkhhtihhvihhsrdhmvgdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhr
    hiesvghmsggvtghoshhmrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:EDXBaLcKoWW9Gmoziq4K3xDzFSX2LQAhneHaXoZv7Hk1G7sJYDad-g>
    <xmx:EDXBaBptkLvSn3NUTh56L_j8Z2LFfQc06ykSJeC59vc0V9AGCOB4FQ>
    <xmx:EDXBaERAXx-lsWq7j530GuSzQTZ1rTqjdS52G3SN8Q40LJx_fMoN8w>
    <xmx:EDXBaJVEjXzDlQE7s7MtMoAUjbAGucpvmJbKxvu5foP9VKkX-gTFmw>
    <xmx:ETXBaDg3WbHmj6_pMW3X_o5NqdBa0wwTrvDKebQ0U1qqEXD7KnMhbpfh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 04:21:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75ce85c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 08:21:33 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:21:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 0/7] Introduce Rust and announce that it will
 become mandatorty
Message-ID: <aME1Bfv-IPq0zRG5@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <8a5394eb-bad4-42e0-82a8-fa73123e205a@gmail.com>
 <aLrzqR2Z9jz5CuJu@pks.im>
 <7c25d5a6-1b34-485e-93f9-25bbe37d5bd4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c25d5a6-1b34-485e-93f9-25bbe37d5bd4@gmail.com>

On Tue, Sep 09, 2025 at 10:12:39AM +0100, Phillip Wood wrote:
> On 05/09/2025 15:28, Patrick Steinhardt wrote:
> > On Fri, Sep 05, 2025 at 03:14:25PM +0100, Phillip Wood wrote:
> > > 
> > > It looks like this version does include the necessary Makefile changes which
> > > is great. I do think though, that for the test balloon to be valuable, we
> > > need make building with rust the default with an error message that tells
> > > people how to build without rust if that fails. Otherwise it is easy for
> > > people building on platforms without rust support to miss that we're going
> > > to be making it mandatory soon.
> > 
> > I have a plan layed out in the BreakingChanges document that mentions
> > how I'm proposing to do the transition:
> > 
> >    1. We introduce it with auto-detection for Meson and default-disabled
> >       for our Makefile in Git 2.52.
> 
> I'm not sure how much this helps us. You've said elsewhere that you don't
> want to be inundated with bug reports which is fair enough, but I'm fairly
> skeptical that we're going to get enough people enabling this get a useful
> amount of early feedback. So I wonder if it would be better just to bite the
> bullet and enable it by default from the start. I think I saw Elijah making
> a similar argument elsewhere in this thread.

The patch series may not be ready for all platforms yet though. Windows
support is still untested and probably not working, so I first need to
get that done. This is basically the reason why I'm proposing to have it
auto-detected at first: I want to be able to iterate without breaking
any platforms yet.

How about we do a compromise: we initially introduce it
default-disabled, but default-enable it in the next release already
instead of first tying it to `-Dbreaking_changes=true`? That would
accelerate the proposed timeline a bit.

Patrick
