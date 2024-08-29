Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0EA148FF2
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914870; cv=none; b=Km1LagNOnKlt2xun7FQeqxzP6WdabQ7E/k/59qlFV+JbBCh7WK4SiqFTeW2M2OvKVvT96XE2l2FNn3hxkn3bmA07ROETe94Zn+24bM2uBpcKhgH+PlvB2i7F2Y1Aa3ZB6GHSyArmecuC198n7WVf8Zfk1qK34/5zndW+vk+UKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914870; c=relaxed/simple;
	bh=trNOYb0ouF885dLOwtJb2v4vgSL3LCj96LRTCpKGde0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urjPQdXjD6MaSDGwxAVIL0mORS4i7Pt1Zg5el/mrEljAmhf/LZQ1C1YKU7c9l5CRttVREZIWyOu+yQGrPFAjk8RTq48AYVkd/mBPaNpjrMTmboTJOB+869Pe20YsIRdYVy6o9AbnyZATT3UNmkhnCPY3HQgL/UADUaa4fFTj/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SrGArMiA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QisnMgIS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SrGArMiA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QisnMgIS"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 35C4B1151AD0;
	Thu, 29 Aug 2024 03:01:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 29 Aug 2024 03:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724914863; x=1725001263; bh=Ma92BMvInQ
	1tLJpHBra2b0u3MndXMo54p4PHDeU4aDU=; b=SrGArMiAM+8atOPEtRXrPfpuOW
	wwMWkdI1EmxEd7H6jDixA6cI1aAv3VEsAFRdmUPN60ytTY6qpCxNtN2h+3DqU4pq
	IqA2cf2LM+2mla8hSm+7xRbfRVz38z3Jmri5ehAU1Ld8jg+cbteCceQdDiIVXvLu
	EdYqbHt3MznG9z+WFddovQvBAvuUR4BYYx05kURzK3VnG8oHke9NnktBsvrmVRhx
	Hj19N0USj8vJzXwM8UjYZDsTSqjjikCP+vWhZEiIEfdw/DH2jSWGNUAvtVmM0tkJ
	r9fjNQc1cuSnlgku9yuHyUx63fo7+fERQ6wjfB4xw1Ge9k2wTF5eX7D2lnlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724914863; x=1725001263; bh=Ma92BMvInQ1tLJpHBra2b0u3MndX
	Mo54p4PHDeU4aDU=; b=QisnMgISSwBwDrIUxU2SOyZFGrFSWdcpj8AfmKKoa3FS
	8DDY4yL9cD+r2NDtSD93MhMwVfoRTXB3pPtfRqbZ1VTYaKPjzexmrFIwCKeGSMmw
	EuBhH0SB3Z4R20RUr4cK0vN/UjIxaydm1Ky63wD94L5k8Czf9tE4/xjKp1qj8ozu
	oM81XNdXwPY2QtDO6KLw6BDMGBQeKnIEFSUzwqD/Tnov/12d/ye/WIKuMtDn1cpd
	27INaBn3Vv5UVDlp2WOjidwYOHKzUksrknfUC0XpGnY9FYsEGVpD8sbR5oO1v/ow
	xfBPwbTHOWRBaXgQdYAyZyWWG/PUxXOYNKz2rEK5PA==
X-ME-Sender: <xms:rhzQZvocvYd0sDuf4gvWx0Ves5JKmNMJcoKfNBkEtHLc-rWT7ru1HQ>
    <xme:rhzQZpoO_H1cj8MgTDdyOyNm3F93XBz_UZJPkBm6zBPPW9bCbZ5UWVrhgUI81pTPC
    edpBvK0vahX4ekD7A>
X-ME-Received: <xmr:rhzQZsPryBJdFpHXm15SEeJA70ktJzQD-ZeiOGSLeiSqmgK231LZvQeshvLwXEdIkVnsY6AVdDIX5OzpmwU2mw7SfLkiJTIzY6Y42xMd20DTVYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeffedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rhzQZi4ABTosXg59L5YKTR13uNW1A4kQpJcY8RLoonL6ihE5IiBiqw>
    <xmx:rhzQZu4r9nzGbZ4pNRTAcPlKIDIa-1CeemWs_XCuOlqEbI_tyuVUhg>
    <xmx:rhzQZqgkl8R2qjYMI-22kGd6CCJA8kaoTzkNmt2Srp87Z4vAL3PmEw>
    <xmx:rhzQZg4dx2yKvbrqlSGfeC5Tz9Yj9Lk-wsmn7gmQdEzbOkrjQHPsyw>
    <xmx:rxzQZp3_rerz4xum2t49f1wz6gKUQUWFGtJT2n5vg8kjy65uP-Gw7cZ9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 03:01:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c627e7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 07:00:51 +0000 (UTC)
Date: Thu, 29 Aug 2024 09:00:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, shejialuo <shejialuo@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
Message-ID: <ZtAcowXWinP2Iguj@tanuki>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <Zs348uXMBdCuwF-2@ArchLinux>
 <xmqqbk1cz69c.fsf@gitster.g>
 <20240829040215.GA4054823@coredump.intra.peff.net>
 <xmqq5xrjzzxt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xrjzzxt.fsf@gitster.g>

On Wed, Aug 28, 2024 at 09:59:58PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > As an aside, I wonder if we should consider deprecating and eventually
> > dropping support for core.prefersymlinkrefs. I can't think of a reason
> > anybody would want to use it, and of course it makes no sense as we move
> > on to alternate backends like reftables.
> 
> Yup.  Perhaps add an entry or two to BreakingChanges document?
> 
>  Documentation/BreakingChanges.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git c/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
> index 0532bfcf7f..2a85740f3c 100644
> --- c/Documentation/BreakingChanges.txt
> +++ w/Documentation/BreakingChanges.txt
> @@ -115,6 +115,12 @@ info/grafts as outdated, 2014-03-05) and will be removed.
>  +
>  Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
>  
> +* Support for core.prefersymlinkrefs will be dropped.  Support for
> +  existing repositories that use symbolic links to represent a
> +  symbolic ref may or may not be dropped.
> ++
> +Cf. <20240829040215.GA4054823@coredump.intra.peff.net>
> +
>  == Superseded features that will not be deprecated

Yes, I'm very much in favor of that. As Peff said, I don't see a single
reason why it would make sense to use symlinks nowadays. We have also
supported the "new" syntax for ages now, and I'd be surprised if there
were repos out there using it on purpose.

We should probably do the above together with a new check that starts to
warn about symbolic links in "refs/" such that users become aware of
this deprecation. We'd have to grow the infrastructure to also scan root
refs though, which to the best of my knowledge we don't currently scan.

Patrick
