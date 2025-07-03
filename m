Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D30254B18
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542326; cv=none; b=KPuy0Kpc204RRNfAsV6y85KijuH6LcxpjoKDWJHODg8SjjnC7+JuvebTp9ImzWIrwJhF3J62PGALaXvMz3s55+yrUuAprWsbxqzRJcRBQyc05wT1O+ot2Q67XiIO+WTY82+3GQODTDi1CEcr9Az+ByMWNqIF9Z4N+mFv9DdCE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542326; c=relaxed/simple;
	bh=ozUAgm4jugsnkEFswvEiUYwW3L9yiUobho+yEyqKNhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBkS3nYUVeF8QwstSW/dnuDKDi4TRqC9srpdrMF4PZyZRYlfTHJHncCkf5seCDFO+U0HrLzeKGRbHx1XaLucz24vdhzRpTo7Me6BU3XBt0qBePhzSrqeyZNvGcPbNrPVa6RcNnWn93xJrxTIY9ejg7uDRYW5h8dI5vY05Fmhd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F3hiqyPO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCRuzlXn; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F3hiqyPO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCRuzlXn"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADFAC7A0163;
	Thu,  3 Jul 2025 07:32:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 03 Jul 2025 07:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751542321; x=1751628721; bh=IUi8RaW0mo
	NdKg0ZfMHJmkL6pCbMvqJ8MZLndYfzI+I=; b=F3hiqyPOKVtAUgA7cWsGN21xFE
	9vGSMPCQKiI46yejETkf7OI87oGKGYZWZ0SQjKUuzH+TQ1NAYQuDIgUHP8sDAxVx
	cLqlZipGJJgRJuOAlAeH9BeN8b4lyFn+KO/VpW3To4L1wDEu/ccv451M3EFPkFBR
	vKu0FjkIsj9gs4npAVJH2jPc27RvboisluPxuZ3ARpF6Dj+H4buPWLla7aTZdqIK
	Fs3vjknS24c9yUmWmCxtsDThNIYmNYz9zEuc/aGKMj8g/iOCmelm+8CO9vgCn9ZF
	jeMaYTTzbb40MIdKiqa95vcF6prkw79AGN6oQM//Za/eIeyz+j0gNSz+LPiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751542321; x=1751628721; bh=IUi8RaW0moNdKg0ZfMHJmkL6pCbMvqJ8MZL
	ndYfzI+I=; b=bCRuzlXnZ3SWm2EQ8R7z80+NJmzOLta9ogJcEOFhS8X4Mc/7hxo
	/gmEaPPXFYK895u72kME/3KFcxO1J7PTd6qsVn0XeKS0JLMo1oKVWLRQ3Pf2hW4A
	rupsVuI+llr+EisgFLhgU/YhZvAQTOFShAo5wKnSry1t7MQRSPcMSrfn6YDoKm1R
	BI5XfdDPsAS63y4doZmtJPqkFntqFwGIoilUFutqy3K21JYjKNiZZiPZwTBZJvLA
	uars5e2P3mQWB0u0w5iEqnBct9hGrWe84wCAIOV6xyWwL2pD1yK7JHgTt35L8Bqb
	Pn3W+RZBLw1EBb0r805GwtDAyUpJiVywAeg==
X-ME-Sender: <xms:MWpmaE9EW13Tc7RPhzOWm6Z9CMdkBqO8moXBP-wyHazFvHvvQ0ATvQ>
    <xme:MWpmaMsrBYLJbRKFWeQSFEdqvxxpuXwh-YOc4E1zk3jaofWsG1xMZSIiKGLKOAwU3
    PlaK9ug-zSEQVT1jQ>
X-ME-Received: <xmr:MWpmaKBfEGKLVUY4WmTkM4aSg2s4ywUdIfQ6UQkf5cOVzKzUFAG1hCs-kFGeS5d8XI22S-TGGPFNHmrgZYQtKO9RpNWSYboDHlfBZt3yrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MWpmaEfjRaPM_x9ubvLq2nUpce8sx-Rt6RQdC33BYM3rcIx7aKKSIw>
    <xmx:MWpmaJNTq6IH4yO0kKtjasQjoEeMJpK_8LSDYHwcuyL8bVXgUmSVuA>
    <xmx:MWpmaOlDczbE_HV9lARaHGqp47ueVchZZCPY6MRC_5qOw_ULR1zDzg>
    <xmx:MWpmaLvRgNkdW-fSWSQkFWbSrGWb2h9KooPl9HnQeAlrtg35l2x-CA>
    <xmx:MWpmaF40Lo6vunW0bzui03riJWO2q6iC4qvABSM_u6__t-P8fN2hXDMN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 07:32:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c7a9670 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 11:31:59 +0000 (UTC)
Date: Thu, 3 Jul 2025 13:31:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com, Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
Message-ID: <aGZqK5eBA18vHAa_@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-2-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619225751.99699-2-lucasseikioshiro@gmail.com>

On Thu, Jun 19, 2025 at 07:57:45PM -0300, Lucas Seiki Oshiro wrote:
> Create a new Git subcommand called repo-info. `git repo-info` will query
> metadata from the current repository and outputs it as JSON or plaintext.

One thing I wondered: Justin is currently iterating on git-survey(1),
which is the command Stolee proposed a while ago to gather repository
metrics. Would it make sense to maybe have such whole-repo commands
grouped together in a `git repo` top-level command? E.g. `git repo info`
for your command, `git repo size` to gather information about the repo
size.

> Also add entries for this new command in:
> 
> - the build files (Makefile and meson.build)
> - builtin.h
> - git.c
> - .gitignore
> 
> In option parsing, use PARSE_OPT_KEEP_UNKNOWN_OPT to allow the users
> specify after the flags the information that they want to retrieve.
> 
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by Patrick Steinhardt <ps@pks.im>

Nit: missing colon. It's also present in subsequent patches.

Patrick
