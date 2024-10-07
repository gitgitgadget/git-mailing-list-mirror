Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD318CC0A
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293203; cv=none; b=lKUoGlT+JrORgALTckSFBY9UqI23jDDOEvuU3g28ydnPmp0mD3TmMJ7i2V5LUmLpt+weudP8UyNLNRUfEuj8PejJNiQjIHifUTP9KPEF8svwsEw4uamUac6n8m+jB1nf5l0Pdzckqpipl4rEV6ey2NgWyjlHKQN4VLAdypsD+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293203; c=relaxed/simple;
	bh=hJdNqdtLWO454rzTPSbj/qmXDsQ4n/9AjUXpAwZJyls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C87Pt2TcwY8hOLroHcelmKwX/UlJdAgNK0BjqW01KMVlnk4VYKdYUA2B9emZPztyeEmUOhlc1kfts3MT81wLiZY/qN2190ZND5KK008kUnhVBxoeCiYZNxgIMO2HsMnBXJL1Ac/BIn3TVn2wE79TbOU8XI+SCl9f1raTKS1PhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=htmtMcK8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ViY3VmRS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="htmtMcK8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViY3VmRS"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A61EB11400DB;
	Mon,  7 Oct 2024 05:26:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 07 Oct 2024 05:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728293200; x=1728379600; bh=wOJW59YG26
	xRiu57cnZ+XyXa9PJ54h2SS+sm+CAf56o=; b=htmtMcK8e/qWgoADaZ/6J5XQ+8
	nZJ6kYfff5VhPqE9eUq3phJdaQFAWYGqc5blUPh+TMnJ9738vGAER55QnbPAz11Q
	mX1q5cGYci8rqs7YH6ZvoT+4vIk91Vf+T3Smir06DNCllz1ZQQlF+OfiMOoi+IUH
	Ey0IESZmp0pteGy160Qi9JV41cYEaS9ttul+3Ut3Js+nCXlTlR1PAnQkRSTRbxCE
	O87KQkn1E8v+7Ggbs/AdPzclEuolwPwPAsxm/ymclX2kAxTjZLq5ZxQo1c7evSlt
	NC0IlZ6IaWaclf8mjw+UX/Ob+FGyBCnS/wgfDTLQQjXa6xnNCD/QObC15eHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728293200; x=1728379600; bh=wOJW59YG26xRiu57cnZ+XyXa9PJ5
	4h2SS+sm+CAf56o=; b=ViY3VmRSG4Vd7E4SM6OWVbK39/HOecrK4dWsK5IlMSFf
	gK5T9BR5Q4r/7cjVrwOl7mMGmTFFGj6Gu4yd1pgmGxfJ0pQhRIxvPiCSni3W/aXb
	7q8ARGrm/Ji+edA7OhgedTrxGSaOPhz7nmwyQ/L7gw3SjIDuretobjsXK+foBEnv
	wPfCik0MXRFjnqahYiubFfZIoXghRB4CpqOhtKVUsA4xXhtIRm3p5ywouJz3WH8d
	Oh/w8pPujnSXHx8gv+/+bVJlwH6xjub9FTyQwdo2vqSQXlLEYGbg/TTGbf3HCavl
	NEVGyNFe1R3rqVtgx2YjngaWeeAIMokNOxcbrL+8kw==
X-ME-Sender: <xms:UKkDZ7z9bQZ2NOjaEO3Pyfr2p0-NGGphfhfvGezoyPg3fksAf7XCag>
    <xme:UKkDZzQNEsjCdLDiP0IwWQA4WZprdMgyeJWiTY_pMbMNpeOG-LQzajxb_Fs00yaxk
    xyYhCOQ33GCbfcmjw>
X-ME-Received: <xmr:UKkDZ1Wv3KIx1gtJ2L5pHNHtyMpkuFQ8v6KAttNBovnhD1JwQoJ6gxvMbIzsH3-gsq81ZnAiXGyv38dsG4cDQjmOF_LW97stbds7XLZpNyjL_UBBqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:UKkDZ1hxvDqAqfuvMs1uZuBFeiPeCXbL2bT6Md_yTv64I90s1qvfvQ>
    <xmx:UKkDZ9AWdVmkD9J0hRlfCgeQ6Nkwe0gNU7hXp08n6tpTOr4RX9vx_g>
    <xmx:UKkDZ-IyADLf7tJQlT9wp84B_Yc4YESOz8sNFq8HOchkc_Y2Ev78EQ>
    <xmx:UKkDZ8BHws5WbT24ebCwqUj44VkFbVupRj3eWaQ1uTp0JPik4qrzwQ>
    <xmx:UKkDZ48OTUVZxwm6dj4oAi-sYxP6DPhvSTflE0Luev1vfEkB2USpel-6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 05:26:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dba301f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 09:25:40 +0000 (UTC)
Date: Mon, 7 Oct 2024 11:26:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/9] ref: add escape check for the referent of symref
Message-ID: <ZwOpR2kQ0cWb_7Kq@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-xaa_j26Auig7@ArchLinux>
 <ZwOGr4Tv8K_wemtD@pks.im>
 <ZwOffN9UWX1gP0gy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOffN9UWX1gP0gy@ArchLinux>

On Mon, Oct 07, 2024 at 04:44:44PM +0800, shejialuo wrote:
> On Mon, Oct 07, 2024 at 08:58:55AM +0200, Patrick Steinhardt wrote:
> > On Sun, Sep 29, 2024 at 03:16:21PM +0800, shejialuo wrote:
> > I'd also rename this to e.g. "symrefTargetIsNotAReference" or something
> > like that, because it's not really about whether or not the referent is
> > "escaping". It's a bit of a mouthful, but I don't really have a better
> > name. So feel free to pick something different that describes the error
> > better.
> > 
> 
> I guess "symrefTargetIsNotAReference" is a little too long. If we decide
> to convert it to error later. Why not just put it into the "badReferent"
> fsck message?
> 
> So, I do not think we need to rename. As I have talked about, we don't
> need to map error case to fsck message id one by one.

Mostly because I disagree with this here. I think there should be a 1:1
mapping, and "badReferent" is too generic to provide that.

Patrick
