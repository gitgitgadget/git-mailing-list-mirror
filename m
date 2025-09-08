Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC41A262A
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757313646; cv=none; b=hNr3h2pySH32Y5eh4WLd+HXtb/YEAV7HSxsspzyvy2Za5C0uG7kfCXSfcLEoZVFYWOEJEOBbMPT0nEU0218Ic3pVlC6wwH11R9tGamP1ImPkswYT4uIl+Iwutn8keoeW++BtrN6wSZKXJt3UcwIMX+pVzBQ0eXvYpZZGXaeLaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757313646; c=relaxed/simple;
	bh=hN5Z5TCAksx57Pg+O8k45Cm9WmfaJwVEObNZZ35djlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvhBJSKjsytvRA89hZmOoHDocCPjPpOWSxCnHzuva5gb4gx1Z8VkN6sHPCcGKCR57MwuHRKVdEAZ/KtnLNNk6+t9xkQSewEEPhIRqGveesdM4ou8oaqzEwD0TM2H32G6Oq9cJQXsPmFPShZyW5l0ht+vLh0DtZKcPZKsef1eX+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PUUxQwls; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ji1gXmcD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PUUxQwls";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ji1gXmcD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 179071D00128;
	Mon,  8 Sep 2025 02:40:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 02:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757313642; x=1757400042; bh=6TCqbtRpMs
	Zdhlr5jchiCxOps+ut/z6QEpHZfdxXvv4=; b=PUUxQwlsPMjJztsUIb85nVZNxh
	6tDdYdTJconG+y2GISGb2uoALCEY3o2VKLq9r289/xQtXbULejrRuxq23EVXhBxk
	0++LL5SwoFVqW1kExIUocV5VvAYwhjkndmlhQDg+WFTnYLKIor5bskwQzKSE+Zdd
	kRlAyOKK7grikOhrkgYNCkL/zo38gBWGgbvObVh2LiLTZfew3KOqVPkAuWDeEwrv
	fE+KZHPuWSHTP5Mfsf6TLqCw2tEKJKBqJCoR9cVB1ENcb3Xkoz0wB5m9kmouNBmN
	FoaXymHtDo+MBtyNnSFp15giDLcxakuuBV6fFq/mvmvPrdD2NI46lmx0jk6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757313642; x=1757400042; bh=6TCqbtRpMsZdhlr5jchiCxOps+ut/z6QEpH
	ZfdxXvv4=; b=Ji1gXmcDUQHGgak8bf6ZZVU5IhR73ujASN2anyIknNxuZ7YKVQA
	QVIlNzzJCjHSYrZtaBgbu6duzT+5xXAEBKRbk/tWVQudJEKPuFSsRsKr6M+tmnzi
	rav9MiVz4N89eBQVoyF8vHJMPQW4acbwHP9Vp+olV/cQ72SqsqYY0eLA830d5R8r
	OBDhPoPbewrKm+Hvuf7eOr8SPkvY51S22wdpk/qoyGrpPMR3xnd4dJ/3DVF7Dck8
	qYEd9mk5rmBm6LSM+bRJKM42Pb6NJngf2jd+ZuOjWD0esC3HtLDA/mMXxvKFqCdy
	KA5sRekIXSz5hDyfB6/dB3zZvVpEAQV2dsQ==
X-ME-Sender: <xms:anq-aCI1X-1Uu_CZBCZceb-z9-r2MSK5MBnG3BK_fHtbc_Xa4H3bFA>
    <xme:anq-aKS8WVUfIJOTgnPDIyZn96_L_5tmqKe94JwcNxJ64JI0MOYpXhcZyZ7HIiaZH
    mChFbjwjQMVotNcmA>
X-ME-Received: <xmr:anq-aKK-FZ0U5xlPu-evLF1YEJeNcCOdNbW4-YOUo7FXlIQ2aWorMF1wxc7HOnW0OsQLcmKf9vAWYZ1slJ80twYF0mhd144pCJOobwVTAK53iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheptghonhhtrg
    gttheshhgrtghkthhivhhishdrmhgvpdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrgh
X-ME-Proxy: <xmx:anq-aN9WplELMN-p3Iyuqzmqv5hbn7QgbMmP28VOlvgea7rUzD-VSw>
    <xmx:anq-aBJ72siXy36Q3Cu3Rk8NrwiVo1pDcw05QVLcARS4FikUVlsj6A>
    <xmx:anq-aMGXW3T8sAc2SdGESfov-2B8v6ngte9q6RbpmsGhhuo8rwAemQ>
    <xmx:anq-aFx27Uw32zflnvoHCd2HvDjnkZQ8Xez4q3bWgaUFULtnAXiZMw>
    <xmx:anq-aNevmdtrIhkg4KNuzfVi0X7ov8Ac3B2D-fZCcUawp1yDAmN41kxy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 02:40:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0541d961 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 8 Sep 2025 06:40:39 +0000 (UTC)
Date: Mon, 8 Sep 2025 08:40:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
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
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 7/7] ci: enable Rust for breaking-changes jobs
Message-ID: <aL56ZIxSTJFNemvH@pks.im>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-7-6939cbf4a0b8@pks.im>
 <xmqq8qis399g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qis399g.fsf@gitster.g>

On Fri, Sep 05, 2025 at 02:00:11PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index 3680446649..c718bd101a 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -9,7 +9,9 @@ case "$jobname" in
> >  fedora-breaking-changes-musl|linux-breaking-changes)
> >  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> >  	export WITH_BREAKING_CHANGES=YesPlease
> > +	export WITH_RUST=YesPlease
> >  	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
> > +	MESONFLAGS="$MESONFLAGS -Drust=enabled"
> >  	;;
> >  linux-TEST-vars)
> >  	export OPENSSL_SHA1_UNSAFE=YesPlease
> 
> This had a slight interaction with other topics in flight that
> targets 3.0 boundary.  I believe the resolution I did was correct,
> but please double check for sanity.

Yup, the resolution looks good to me. Thanks!

Patrick
