Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2A2C15AE
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711323; cv=none; b=kxG4meU9aSJkUmzTdai+E655+SGEDYv9WeWQZpNiTkQ3s0deY1zPqNT9gBhOFPll/SG3sBD+py7w59p2oLdTwgAKsnG1ZPrBpstYpFtAoBhgneZ0XpOvgCF2s+u5KihxSsY+yPUuuemZ/BRsZquTb9zbXN42hpOxsA2atYn4mDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711323; c=relaxed/simple;
	bh=3m8rR663IcRbGh7kjUzoffSfwCRC502eAtMu8dRsGiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKJ4p0AItXf5hGeAAjS/H+ECU2hcZfPxrju1LQBCjv6/RcGaSuzTasbtj9y5EcKGfwXE3kS/z9cEj7j011hz09uHPFLFTqD529Spkr0Of/lglv4KMeTyzV/gNrIrTHYmtAv8A6hlyS6aUC0GDwLFuYa6Ujr6+56dsL6vJmHZ9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ErpcClW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAT7QJOd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ErpcClW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAT7QJOd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 34ADE1D00226;
	Fri, 21 Nov 2025 02:48:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 02:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763711321; x=1763797721; bh=DRxNZrf5/q
	PNqSR6Kp9bi/BtDSRNzYaqFkLk0RgsTW0=; b=ErpcClW8O9PMpx60FE8MqRaAq0
	RsudRkDDGf0BWHOojXG8EOm9ZLUY5C6WGM85U+z4+CMCJj5qpQwDRZ0O7xWwwZT6
	d5WKhS4rosUgdNsmHOj9Hf6zeIhHGxsKy0YDbCWdHWhDJNKOKWqmpas2ghXCAbmC
	IoAWlaGhuumFll9LM+DODftue+xyKXyQBrb5oc/RD6EXd7S3dNyENJj1drRTr5fn
	VyikZpCSMGO8ofUXwFpvLMvGJwcmRJBxZtrmurTH9qiFA+duQ5UvEOx4pbt9QeCH
	MJtYIcr6G5rhN7LaZh7koA7G7nemowZXiXcvxM2fV6s9n1dYqz0gBEPIZS9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763711321; x=1763797721; bh=DRxNZrf5/qPNqSR6Kp9bi/BtDSRNzYaqFkL
	k0RgsTW0=; b=rAT7QJOdMlDFw4ZWvz3f5Er4xBPSVf+rLd1ovbQ65I/O2ZUq519
	kNyuFlCrlBjvfg4f5OeTIKvLZxa/RAxrP49jq4QIiNmx3T2YPRPYAgnQ6Q+YwzRK
	Rv8/shyVCVp+Bsy+o4JyJTSmKZ5k96MH7CL1G8JM9Z+unlEXBJuQNP+oVlf13iX2
	ZqwQ8Xfy0eQ2Uqrd7o4mQtWxNt6LGTIJ8F9RFPNsH7S32qHhoyrVyUZlCD5XoYe9
	rfHi7jqlf/Mb6QPzz4b+owzF7yuokeocfpzdYd3mJ8ZtV7e+N2wIgfsglJxCYFSc
	WaWG1Qcj3nd+2PxekAlY5DS5awdbfHKhlcA==
X-ME-Sender: <xms:WBkgab6lImELS0HQReA7ENn68E6rvivCGI33dyFSGYtGx1VVBWhBTQ>
    <xme:WBkgaW7lZOSNO_0RMqy2oj01GoeZ1tLlwMG7FF6bYXvI7d4NPRkZHxD5nLf7-PCB9
    cMa_QtZy8Rst0ygsV18_l8olDhDWhAzMEmX5mP_B5OAw9M2jZSX3A>
X-ME-Received: <xmr:WBkgaQF6x_7r-kmERg6uOx_tWK246xF2xDFkTp0j5k4qe-70GJZeRcYSsmlExPH_S9EKioN1bo13Gu_tRYusPc-f58Vu-A-0Y0pVaJ09P5Ux>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WBkgaXQhUjGJlCqVTNcm2HNkN1P-C8LR8bqWEd4y7WUrgtffnk6Wsw>
    <xmx:WBkgaRv0vCL1JrNyyJHHQsheupc_YknWFXePcaFFcTcYYcvwElVWhg>
    <xmx:WBkgaewcQJ5CSW-G70Q_Mv1FR-WzIFE6MYIUxMrj50fHehzEaRQYfQ>
    <xmx:WBkgaT4LbSglT2asa_1XsjTcUImiFmrifOCENMmtqsI01hUcKwgkdA>
    <xmx:WRkgafRqo6pBh80h1rg3XX3oda6mD3RCt75Q2fdwLQXJkhlEfXEOaEV5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:48:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9345f8d0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:48:39 +0000 (UTC)
Date: Fri, 21 Nov 2025 08:48:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/13] builtin/index-pack: fix deferred fsck outside repos
Message-ID: <aSAZU4DlJ7CS7HLj@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
 <20251119-b4-pks-odb-creation-v1-7-2b2ed2612cb6@pks.im>
 <xmqq1pltbtm0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pltbtm0.fsf@gitster.g>

On Wed, Nov 19, 2025 at 01:27:51PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +bool fsck_has_queued_checks(struct fsck_options *options)
> > +{
> > +	return !oidset_equal(&options->gitmodules_found, &options->gitmodules_done) ||
> > +	       !oidset_equal(&options->gitattributes_found, &options->gitattributes_done);
> > +}
> 
> So, if we see a tree entry for these special blobs (and remember
> them in the _found oid set) before we see the blobs, fsck_blob()
> would notice that it is looking at the blob that is in these _found
> set, and throw it in _done set while checking the blob in-core.

Yup.

> A packfile we generate has trees before blobs, so a self contained
> pack stream should still be validatable outside a repository with
> this code, but other people's reimplementations of Git may produce
> a packfile that has a blob before a tree that refers to the blob.
> In other words, we can validate a self contained pack stream outside
> repository on a best-effort basis.  And that is perfectly fine.

Yeah, that was my reasoning, as well. Ideally we'd of course do better
here and be able to validate a fully self-contained packfile in all
cases. But that's a bigger change that isn't easy to do now -- it will
become easier though once we have proper pluggable object databases.

Meanwhile, I guess having a proper error message is better than
crashing.

Thanks!

Patrick
