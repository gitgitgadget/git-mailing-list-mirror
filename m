Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B9136672
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280516; cv=none; b=RnBkIkIGhzXkrnhduwXuS2rvEFVJ65sBhS2857OwHjja00pD1yppsxHKU3JYgJct6wfNJifu/x1oEikgwYIRbpxoNpRQCDH+pKNzeU98zulHcyHSbZnT8X4wMq0QzaA0D1BEwnCDe/C+u5cdvhaIPafFQTYrEu/5gIIYDwr6uNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280516; c=relaxed/simple;
	bh=LSuxS/XHkxiLSN+iqDEfyPnhStJ6KuBn6t26SBWcMcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXM9/MlIs2p2vhdbTgzyMv0Ip9c1rKfCRWsSjYN6/IptDPs6znvhZ3vEoL4tR4L/DaIJCMrwGSkfwvhPSqSjd1PQ88FqhSm+XSLCSe5RqE0X2fjyFW3pVFn4Hoh2w/TWpqy4HR+Lu5bUi/TXS+wMnENJoN3XGT0Pru0t0y0/+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cWIZ56uV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nj1d728s; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cWIZ56uV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nj1d728s"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EFEF13802A5;
	Mon,  7 Oct 2024 01:55:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Oct 2024 01:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728280514;
	 x=1728366914; bh=OmZPwIKZSUt9z6DGGpya15SpzQpBrnpZTCqL89dqk+U=; b=
	cWIZ56uVfZ5SaTW3G25d76dFeO4FAtuApUF5vcWieZ3L0/3B8x8rrCcloWlSg3Tr
	BSLWENQ/JKk+6FgyLcADJcMpQ3UH7qAbtUjcKZ3YgAfM+ZHRNlTDDJjbH7qFTbpW
	Zv2ejk090/q09d6SGzmZtCekDFX3KMEaZgaKABhcvbfos+DsG3MAjJFTeKbaI09n
	c3nwHwLhkGOnQYJmTuw0+CXTh3YUaO3SrLRz0wAcrYgjuiw47MLAEuKCZ+RyUSfN
	MgmEvM0IqhpxaxmypAwvWKfulQpawzlOWcLMpOFKY0KVXgxwyUxjW3s2gMZmROM/
	U1hI+2fEZ9VOFCq+tXxR/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728280514; x=
	1728366914; bh=OmZPwIKZSUt9z6DGGpya15SpzQpBrnpZTCqL89dqk+U=; b=n
	j1d728swhBauDMhZB2d713tzt/uocAS8ouvz7nP+yUHALNjkxstsAriJ0/FgLdWO
	iDuSkc7Ursyl5pLdG8dO/EIOSZ3MJA25GnBlBxbeX6LSd9YSrM4Qte/O2YTwBbot
	LxmeCtnNaze/b+ZyYoL4ukV2A6epTRy461e/G0XKrPainZJzTifaMYXYrnfjPoR2
	fHSzulH8Ao9aJn2HKjhfVWf7lRkjIb532oGVdrMpp+AFEePZ8ftxjDrXQ5xfM7X0
	xhX61taNfPu3PpNEeYCyMMWyTbhhKDtIWCi1SFq6W9WVxHTr/XeH3ArmLEd8gI3s
	wb2sR08NBnTuk9dK3Jy1A==
X-ME-Sender: <xms:wXcDZ74TnCHMeky_HeUt5EunaeZugProh-GLVS2gPswfNJB-1WcnXg>
    <xme:wXcDZw44T8iJRwIzZSxwKybCmtR_Xv761DiZHc6-44XlEdr9IYnmh27XCwdjoBTUj
    Wlf0JomANcJcdp4rg>
X-ME-Received: <xmr:wXcDZyfKXz6KjkhxJEzZj8EUQF7jAGdmrP8rWCVx1f2uT3Yl7esSCu5Lt2Ap3qipsfCMR_DJFcYj53OyTb97tAS2VA_GYjUdH8SyYPDqhnLEqxrNOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wXcDZ8KIPxHa26wHa3r8XGsIef1UzdWNEmcFBERlgQ6dVdLFplj1Tw>
    <xmx:wXcDZ_JKB_hvO9x1zCClh1SEJUKxCnvzvhxN2PcMOOvnffiQrbXmLQ>
    <xmx:wXcDZ1zxbpxxuJymsy44LAZoPwZRR-sbZfV3TVQ34rT2TFZColfG1Q>
    <xmx:wXcDZ7L9ggNv5K5qzrom0XY2T_j47uG3lu_Y7wPBmZ4XeQnu8kl42A>
    <xmx:wncDZ2-KQQdGzFLhZCvAYw7ogPRwxpaqqpVf8nIYzg60dkBI3WlhnwFK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 01:55:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e6040dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 05:54:12 +0000 (UTC)
Date: Mon, 7 Oct 2024 07:55:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
Message-ID: <ZwN3sz_gPGqKAWqO@pks.im>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <92496582-8414-4d5b-8883-8b0a0b3c0988@app.fastmail.com>
 <CAPSxiM-jKgsuqkF_aHDJxiTz0FWwuT==FYxJPKUP0O_wwDahEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM-jKgsuqkF_aHDJxiTz0FWwuT==FYxJPKUP0O_wwDahEg@mail.gmail.com>

On Sun, Oct 06, 2024 at 04:26:03PM +0000, Usman Akinyemi wrote:
> Thanks for this. I will definitely take note of this next time. Thank you.

Please note that we tend to not top-post on this mailing list. Instead,
your reply should be either inline in the quoted parts in case you want
to reply to individual parts of it, or below the quoted part as others
are doing :)

Patrick

> On Sun, Oct 6, 2024 at 4:21 PM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> >
> > On Sun, Oct 6, 2024, at 18:06, Usman Akinyemi via GitGitGadget wrote:
> > >
> > > The root cause of the whitespace issue was quoting $count in the test
> > > command, which led to the inclusion of whitespace in the comparison. By
> > > removing the quotes around $count, the comparison works as expected without
> > > the need for tr -d.
> > >
> > > Signed-off-by: Usman Akinyemi
> > >
> > > Usman Akinyemi (2):
> > >   t3404: avoid losing exit status with focus on `git show` and `git
> > >     cat-files`
> > >   [Outreachy][Patch v1] t3404: employing test_line_count() to replace
> > >     test
> >
> > You don’t have to sign off on your cover letter.  Just the patches. :)
> >
> > Of course do what you prefer.
