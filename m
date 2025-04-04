Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B601C68F
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758018; cv=none; b=oFtMJEd3W9VLdQ2qLSV2enPjkCdUJiAPBHwYKf30G5WzN1vNFs0QmrL5gHbLLMj2s7/CWUXxWxZsWfNeqi8Dvz1SLPyX8ayCAxZrdKVdzpJq+rHZ1lim0lxQPTvEmhn6VHRK1C1aSymF+7ujOUtkDxnPVkdSECkoOu5G24egdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758018; c=relaxed/simple;
	bh=ozyL4jHJ60TQLBsVxG8rX637VOh7gQyeX/DmxKAtPxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN+QMFKL3sS5o4OBevfKRiQrXgcAaj5IL/Uk1RgFsmxvRKU8ohdlqtz/7ERA1eEIAx0yhH0mQd05M7l78gkOuuWE/9KKtzNwA2uWJT6qJnz5aZjzqYF4DMpapr/rtPyQOrclWo2Fn4WcePk8WRWcLyI2r6mljF5/tOU5RVaoEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ymhko5RN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GV0cEebA; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ymhko5RN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GV0cEebA"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8D3F254021A;
	Fri,  4 Apr 2025 05:13:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 04 Apr 2025 05:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743758015;
	 x=1743844415; bh=QjqrBkluDvKkAS35/sy+CCi7XBMGuRV3T+3cs3rj/yY=; b=
	Ymhko5RNgRKLfNtu233hlFHe3F2nAD+PkFGrkgr/qqoBeLT5InRG3H2R6ixXYzSd
	z2na9P4fDv32PGc/ACaDPDgl4ii1LqIFIGczgLOaAszxkkD+GiaWMzLIxaRJZZql
	gamI0f4fTXuNlUmtxs+j6yPIINU9iFYmSVBxRYBFt3DDJu1P1ZRpK6JgdC8WxFKT
	aUKdFIojLXsxEN6C3dP48F+o2N3iYpyCBjEwDUiDy2vaaNzN6pGu266JLbEhQHvc
	jx0WvYOaYaUh3FuBwxD+hH1ckFmQYIJx7pNwmIHiqvuOBM04nhWdMyQavuuukK3g
	5JzGjanJgpOKh2deGud66A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743758015; x=
	1743844415; bh=QjqrBkluDvKkAS35/sy+CCi7XBMGuRV3T+3cs3rj/yY=; b=G
	V0cEebAZEFjbDmvJ/C8FU2saXWZWSrRwjypFy/yBIYRnORstpm1wykvJRAoEup3x
	MAS8J8njDMTPY/9buOZRJG7yUNCbhdDDLqI2OT4PamBgTrBW/3ncYMgUfO1A+DXK
	0eOoryCP736ZifQXPwdrHnIbx6bcHxfc9T8Z8Hm97b3WKPe2ROHqI5X/B+yTYdla
	53pHLmyI2S6wZvGzZUOZooNPp57jBsGo5prOAMc4+Xb3UzNOSNdUCl//Qx2At7h+
	nC29QLa6iDZppDjWBKpk9vc/4YoUJEietm7pRJyi6xsbfCXOVBz0CKtMkeQ6cnEI
	jCUDKr9dcakYcSDGL1hAw==
X-ME-Sender: <xms:v6LvZ8RvbFWliLBesiKoOuLHBTALYmntKh7yQygNl2u1BozAlcIbcA>
    <xme:v6LvZ5zKOxR2KhvSDE_u_90A1pfKeDwmNuV8bB2JZj6VhB2JqL3l9nWVthn8zVB3A
    IolXQvV5YVnthwkwg>
X-ME-Received: <xmr:v6LvZ53ErVzSKL1tTguP47gEvq7AZ6QogXY_TZvagpkBKJ7odpUA7on617wmMpv87kjtnqrlK972WO5nerdircEWGkiVHRoUmV6DIRrJGvulnmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetheffvddtleettdetueeukedugeettedutdeg
    ueeukeetheefueevvdeitddtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhihrghmthhh
    rghkkhgrrhdttddusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:v6LvZwAxQUBv_-FYKIvsYaYrKjZd9FV6O6BcKlw5-WqSNp44A13NKg>
    <xmx:v6LvZ1ihC1Ya3Hd7SG0qtsmbegSI7pRUgVx6p6JJZT5ma8ssatJ9xw>
    <xmx:v6LvZ8pe76PW_DTHB-FWcrdrm_HevzJgBigxFwE3u1CP3JftL1S-Pw>
    <xmx:v6LvZ4hp6tyWGLaoO26gFvfLk0zTtfP6KavsDpoI7hcmg2KmI_6QXg>
    <xmx:v6LvZ9oUgd07rOufBhqDyThV5Tcd-sMiyyF7U4cC3laWtxzDPClOxjKQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 05:13:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 169f3966 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 09:13:33 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:13:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
Message-ID: <Z--ivMYyD63JkTyH@pks.im>
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
 <Z-5hlL1Gk0oi4fX2@pks.im>
 <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+rGoLfCTzNTcGXG5py6oHQazeE8Vj0fLsR4KUTJ6rSRFnT_Vw@mail.gmail.com>

On Thu, Apr 03, 2025 at 07:40:33PM +0530, JAYATHEERTH K wrote:
> On Thu, Apr 3, 2025 at 3:53 PM Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Mar 31, 2025 at 08:21:27PM +0530, JAYATHEERTH K wrote:
> > I already saw this in another proposal, which indicates that the project
> > idea might be a bit underspecced. In any case, the goal of the project
> 
> Hey Patrick, thank you for letting me know
> I actually have been working on this proposal for a while now.
> I also sent an e-mail regarding this specific project right before
> GSOC proposals started. As far as I can see this project was not
> previously discussed therefore I picked this.
> 
> https://lore.kernel.org/git/CA+rGoLdvY+JdgdzgE04EJoF9KGUpd39+2S_AgpFyucP38mdFgA@mail.gmail.com/
> 
> I'm not sure how to proceed in this situation. I think I need some
> advice from your side on this.

I think I don't quite understand what "this situation" refers to. Do you
mean that there are multiple proposals for this project now? If so, that
is perfectly fine and expected. There's only a finite number of projects
and a larger number of students, so some of the projects will have
mutliple applicants.

In the end we will pick the student who seems to be the best match based
on both the proposal, the microproject and any other interactions with
the community.

Patrick
