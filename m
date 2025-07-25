Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEA1DEFDD
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421782; cv=none; b=PUsB2ghHUWUKGgPVNA8cWtxspVRKkiSR34oLCilGtcDJgUsk+bnS8kYlR99yuxeyXJ9F+XmUlFQytQEIV3cB/xzxb3m3xPKTeJ4cmVHvBAfzfb5FINCVlSzLY4m9/INTYbl0EefORbOSQ4JT2pFkJjvVQPQEbCmGkgAhqi6is3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421782; c=relaxed/simple;
	bh=VRPpG9OM7TT3poU3SvINzWozrVdnEj3yCLrpINBgrKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqSURdpT7LSdodd/EBtjNPBYqjgjZu592G6OhIgE64pqWC1HARG7BAZ7E8oMRVwncKs9nKVyKhyc7OoJvCoaKFDnoVsruO0PB4xoU1TlQd8xhWg6trFylIQQJfrqrL0e7H/GZ9ElMBHGOZ7kvAzO/M6b+n2pcopubkj4WxAmhso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W5KZvjiJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLlqRHAS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W5KZvjiJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLlqRHAS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3673DEC0221;
	Fri, 25 Jul 2025 01:36:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 25 Jul 2025 01:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753421779; x=1753508179; bh=T9wgZE950A
	gCrguE3nO+0AEZs7+MK2gg9oCywKpNCd0=; b=W5KZvjiJXQZMwlb4vSmlPnb79T
	CSyR6DxN8+TM0EoR3A1xhQnGbOZNIdQRInoNA7UsMSDW22FlkqrqkFkP9h9rmW6x
	HcQ6jtbycm7bQlm6T4R6TgrBXlKz8AHj9VoXNro/zYsFlcZZH67qMeDUuadQmTgX
	5eae8JgW/hXw7DJZajP9qgSzK+r41j2lI49n2v0onn4MTkaGDn1+ShNdWLUnAiB8
	FWWGSKPU+jeycYA9Z2JCAshg2vXJNKrt3wHWPs9J+xO4HJJXX453Z79zHxfgOam4
	X9TnnMiXo8kY2bvc5TnyDJc/qheFrvsFkJmloSVB2iErtM3eXp8RB9+QX/WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753421779; x=1753508179; bh=T9wgZE950AgCrguE3nO+0AEZs7+MK2gg9oC
	ywKpNCd0=; b=lLlqRHASqvIuKFw5PI3xJKx9RFuEOYkyPvw9Lze3egaB6i7JZiN
	KnxCvOtyAE4AzVnUoM+AbJo0W6JatmAN7oUUsSalXY41OYKpEPypI0QPhqeryrOK
	xd8tDWX4tBdViKor8AwGiz4alRpRjGW5mNnAruqR6/XGEvQh/dBAj2sFudUIDDPd
	TixU/XSJ6h1PN2zeAmP07TDC4CSbXZv11chjqEDIsDqO2khRQGIcqcjcgeUrM5LG
	uflekqhUS1t5pG2T6BIBAofX0WgDBWPSnDDKTmER+n7bGz5kZkvfzhY+8u6SVKhX
	2Zq3CkGlKJh+At6BvMHXvMRhCa9U34LqSGg==
X-ME-Sender: <xms:0heDaHmwu01r8T5f6Yyk2gXmiVoXH5imVeL-IJkEUQYqAcCB7JJS-Q>
    <xme:0heDaOHhgIshlNPvcngeJEhk_fNT264UeJM80HK-LmweMJIFL3DGiSnTevr6_JNGF
    AGmho1RIq9EyI3x0A>
X-ME-Received: <xmr:0heDaHHWBnM9JX1a_NZD6IbCIePgYa2DmMhJbWPdRo-EwVCatElxNbvPsaiiQLIiQdMoi8__jG9hxa1iz-uZ95DA0UrAaWaip_o7-rrcxb5t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:0heDaLNPIDdVhP4lkRN1UxBCctcwYK8Yv5PE3NIP_EMEiT6NFiw7sw>
    <xmx:0heDaGFC8j3741L6vdpNRSFFTj-lEL9njjfd83T9ibcwnb_9x_C1aQ>
    <xmx:0heDaCNzCMXPs5OpCC2f1iOXkjHxQ1OIEXVy1oejxBtHCG6CHGw7vg>
    <xmx:0heDaH84fV0Zz4WnhZnVGzYzPkT9TgM08e1PaHTDvP2SAPX-VFPBLg>
    <xmx:0xeDaKsZ7YCATW1mWW7Pwq3SnkzeDiQ3Kky5MzOej0JzBnTUCHdvmEhr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 01:36:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7c5524d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 05:36:16 +0000 (UTC)
Date: Fri, 25 Jul 2025 07:36:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aIMXzRESLwUVMNuD@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
 <87o6t9kaua.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6t9kaua.fsf@iotcl.com>

On Thu, Jul 24, 2025 at 02:54:53PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/git-reflog.adoc b/Documentation/git-reflog.adoc
> > index 6ae13e772b8..798dbc0a00a 100644
> > --- a/Documentation/git-reflog.adoc
> > +++ b/Documentation/git-reflog.adoc
> > @@ -392,6 +403,59 @@ static int cmd_reflog_drop(int argc, const char **argv, const char *prefix,
> >  	return ret;
> >  }
> >  
> > +static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
> > +			    struct repository *repo)
> > +{
> > +	const struct option options[] = {
> > +		OPT_END()
> > +	};
> > +	struct object_id old_oid, new_oid;
> > +	struct strbuf err = STRBUF_INIT;
> > +	struct ref_transaction *tx;
> > +	const char *ref, *message;
> > +	int ret;
> > +
> > +	argc = parse_options(argc, argv, prefix, options, reflog_drop_usage, 0);
> 
> Wrong usage string here: s/reflog_drop_usage/reflog_write_usage/.

Good catch, fixed now.

Patrick
