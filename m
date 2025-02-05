Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB53723CE
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738739765; cv=none; b=LHzIyzWfiQofmVpBCaRP7KWztMcZ/1hrhQZWmoAvlEBLAPlPb7eLIcL5wmmZDIXTIQCr8ndeqb0SfIlnL5/fOv42KyQ1e3rNq7Y0wFHzwuO8zVbzSoVWUYbnVgIv0nbEsF+tgHdBlnramdxvYQCBXlVt+r6SHGU9m+kBSjP5H94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738739765; c=relaxed/simple;
	bh=T7uTWcNMUaBT8XiQHDBXJD1VHzLHYIEfABz4cfScGRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drKRLqyD6Gt0ni6e+KemrsXNUU/f/MmVpw4ifVmwTnRfrhaRc4Rsb94evYrG05RikBgSsuVcCR4F4Pacya+jLbeddd5H4xs5rCwGY5je2k9pALtUgviAbYC5oXwjVmOxqTiyOPjU8m+Z9oHr2Vzs6MAgLUZo2aROZ2jp+paaQsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hT+5QisE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGjbfYOj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hT+5QisE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGjbfYOj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C210E1380228;
	Wed,  5 Feb 2025 02:16:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 05 Feb 2025 02:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738739760; x=1738826160; bh=+kfughEeZR
	zaalZar+a3MGSqgwWNN6fWn/fZacaZfM4=; b=hT+5QisEElbIkI13MjILVNKwhF
	c4eVjFQZxfF+sS4/69BMCrLzhZWIGyfJXaC9cCh0ysizKIGnrhwupjW3ziOfEJmp
	jjvU9K5oHd8fwzmP//DGZoh5/a3QXyhgImE++LIESlFY+yqXhVJADwhuPzeFAYOj
	Js00C7LS5rokBo8f1oWpSFJWobXsbdkwValSN1HCJVFDRF1J0Zb4ERimvWQP5GwY
	FFPh/fbRsukIIzieBjnEyCa/iCM96yGrzd9blPaVWYsNFwDinFtTvwM2Dnlq8ISz
	mRiCuW4v3pArVOrKNI0CY385a+e+30EU8x+meVnIdV56kxG1mcQmDuLYbdTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738739760; x=1738826160; bh=+kfughEeZRzaalZar+a3MGSqgwWNN6fWn/f
	ZacaZfM4=; b=gGjbfYOjStaTDiP2CIZIIxOwBFCX3bqjALBsG8qaiXInSxI7lWs
	pJ7ZKcj3X4Xm2XfOrInE48BepSZNF/1zZhdxGMV3kdeG1X+y9RBE3BzAfSjxIP1R
	e3v1zkGJKvA0apGAHj6zw7mVknvPfPssKQ/guD9JdvEgeLb4eNjeg5sRitbTj3Ud
	gC7jvHWPDaNdfXgy6rA+0NcMRlRYNIOisUQBVEpTY4bXcEn9v3Ja5Mx6WGeFkwN0
	CdLJXEEnWl5VxMvmcEJzeBPXenv5eX2W4aK+VVy+L4TCU8J5vLJLrwgpUndNyQpD
	CM7pQgmH+Z5AKdqoqWlGJ3GBstEM57LoD5g==
X-ME-Sender: <xms:MBCjZ-lS7wg5xv0LloUM_Rz1anzKIVL4gWXmmPvrnNK0we6ts8r_uQ>
    <xme:MBCjZ12_JZcK6n2RGlPKuzG1WaH0TyALKCJHRYDnn-5Y3RScvpP9Q8MUoWCZ3c0pO
    R5tmfhEi6v2krJgOw>
X-ME-Received: <xmr:MBCjZ8pgHExKlTysWz49oGPJusg-iv4Ebp9Xax6k78fT3_eXR0_eOZUZn4sOc1WmBKKb0zhlbYBbrOJcYZCIwCvA3qTFFnbnfDjT_eutzPy0Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtg
    hpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MBCjZykeJpJNG0AjhYq5g49BfwzW8_vQBBlEhU8mPK90mZIQMHqdVw>
    <xmx:MBCjZ81xYxEnVrKb8BuO-qkQA3NGezM3K38M4zWQHLZGOgFDf7EmbQ>
    <xmx:MBCjZ5s-eO_3QSHUzX3xsZuUlwW8YoAq7IJYfeNSpgwP0IpbOZXVjA>
    <xmx:MBCjZ4V785F88ZGAjpMF6stIdPi6eqWrB0-CX8tdDDxrbcWa1ZewIw>
    <xmx:MBCjZ2OPllTia1TMtYW8ZJ_hirMngoAMvVK7Arsm3QtTTj4oeYiR5PJF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 02:15:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96132068 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 07:15:56 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:15:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
	christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/5] PATH WALK III: Add 'git backfill' command
Message-ID: <Z6MQK6anxpMhlL9i@pks.im>
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
 <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
 <xmqqwme6y32z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwme6y32z.fsf@gitster.g>

On Mon, Feb 03, 2025 at 04:18:44PM -0800, Junio C Hamano wrote:
> Everything looked great from a quick look.  I'll have a more
> detailed look later, but this round looks quite promising.

I didn't do another deep dive, but mostly had a look at my last comments
and the range-diff. As far as I can see my comments have been addressed,
so this version looks good to me.

Thanks!

Patrick
