Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD014A0B5
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895143; cv=none; b=CLLkXQREsOLuDRFj7SrQK+MpcaNEiQTnDg3wG0zcy8ZSi47SouZ1EXcMXm6Kps9vuMnpgF5aChJKf3VAigUd0P3irfwJOqcjMays+sTelbUnsJTyHMFbfe1mJEPszmVTtJTsAgUoPOB6fxFwd7mu3B9ZkCbBYUb7HuzCukTMpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895143; c=relaxed/simple;
	bh=ru69hBNlqqkLbuPrTsYP6k7scZG+2pDnhPepq4PeNeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTBf3WLAaOzr/xRhnBeWfZK1tFPgKqkDEtivaOowu/IvDXGMZu32sYGl9B2G4ypgVi5OuOs284l3h8sTpK9V2SO1TgcxJNzVlTAH0HISVcG6fBBMJuCIYQrekw3M9Zf96mW/3WnlIqyAQyP5E1y45yA+6G2VEeop6MJ0bstOhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eT4sXc9e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NF52Q+WR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eT4sXc9e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NF52Q+WR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3303111401CD;
	Mon, 14 Oct 2024 04:38:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 14 Oct 2024 04:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728895139;
	 x=1728981539; bh=Bm3BZN+IP1P8N1lyHnPfnVm5B3zsPryt3t6uURSawYw=; b=
	eT4sXc9ePhuNZIdJNmWNrO3wEUgKIZQep95zOqad8GiI5gJFqtqo/yUudz/ovO7i
	nHlpBK56PAqVm4hd4RtY3HxJhFLuatJ9Km9UfJCpO8W+HdrymikRdorT2xV29CRP
	dgwLPoziLLX+qgOl1fAGL7Ey+taJoUjLxM6EQwYw8/8RAhMFT5YSjQQRkiqHCrVG
	44ttnm6ufNq2/nyYvNHKZsCBvqDKnVy6weFjGwAz4VEVQ9wub0M8mCfQWbu64PLk
	G13C9/HWCohvd4i+fg+UB4RfyJnY6ssxdMdwPVz1OFwybhhD2y+InXVmubj1+Dve
	nExQgm63K79NMXHAKzsA7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728895139; x=
	1728981539; bh=Bm3BZN+IP1P8N1lyHnPfnVm5B3zsPryt3t6uURSawYw=; b=N
	F52Q+WRv5fN91DaDeLT6UeguQxutNBAXkiV7UAHc8Sc9Sji6vd+sZfvUaMMjRBKD
	uD+uAAbT+6nh+vKQmKas5i1HdYKah4dnjmtCFOoYL2p4Mw6zjvSQwmnmf6+2FuRk
	JdhBF+308JJAPM4eup2wjG8oxBq1iFLNV5NJV8U231eHlwJPUNETjA2m55/zhgOT
	8ZU6lhmM1pZgsL/smAOJY80GBQ0sFGMLJgwscLcR1C6OKSY6/UWPFaYtpYABzb6N
	Wpj2q3qHcny54+Ya0JBGJ5yt4dG9ORZyvPSLRphj2hUjZdQ4vZR5CV75FYbbIq/f
	AjF7NTsQJ2k1mpGIGuJbg==
X-ME-Sender: <xms:otgMZ7Y4fM3rTCVlTvE7Bur-iCU7YVC78S-h7u7xShNvb19p-8SZKg>
    <xme:otgMZ6bFlXxGjpAkB_fbWv-0_iOwPbUzldKq2re-VLUMQCRHxMUscjUvri3YRwAeE
    mymjJOe3VBEsfgFNQ>
X-ME-Received: <xmr:otgMZ9-jwLtBbjznCcbNf4jDLRiB_5ZgNuJxwlbsF1jk6vU0s2Y2CH-30EloXvpbw1y-QQILB518iw9bxM-oy9JvvSnrAGC0T2mgtm7XgKWe_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefheffgeeflefgieduleehueeugfeifeevjeejveel
    heetvdegjefgkeeguefgtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehshhhusghhrghmrdhkrghn
    ohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:otgMZxqMt7y3J9iiquNNa-b6611K0vmIbnBNacPnigrHyW_en1HMoA>
    <xmx:otgMZ2rHQTKRr7_SaQldwN4hw6wsBpZIP5k5sSIY9hcy0SUrvuK4AQ>
    <xmx:otgMZ3TAycHWkYmqtt4DeT7T41KPF5CQEFkwmqXSWTyM13h73MHjJQ>
    <xmx:otgMZ-q6XDuSs_6a2Y3QhRaQHBY7fbtZrjPvKdfsMEuX5q0Pkh47GQ>
    <xmx:o9gMZ5VA9gvncmEbUdUsTa_5ojIA31fXhOGmsCmUu2YXdM6f2aAN9dqW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 04:38:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7145b2ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 08:37:43 +0000 (UTC)
Date: Mon, 14 Oct 2024 10:38:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia <shubham.kanodia10@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] builtin/gc: fix crash when running `git maintenance
 start`
Message-ID: <ZwzYk9dq1H9QGXBG@pks.im>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <a5b1433abfd84cb627efc17f52e0d644ee207bb0.1728538282.git.ps@pks.im>
 <xmqqcyk7lwa4.fsf@gitster.g>
 <CAG=Um+3=SQ7bZYvr4BNxWgMBNreQHgfs-0VQwkzBq=HW8Zxf=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+3=SQ7bZYvr4BNxWgMBNreQHgfs-0VQwkzBq=HW8Zxf=Q@mail.gmail.com>

On Mon, Oct 14, 2024 at 10:14:53AM +0530, Shubham Kanodia wrote:
> On Thu, Oct 10, 2024 at 10:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > +     write_script script/systemctl <<-\EOF &&
> > > +     echo "$*" >>../systemctl.log
> > > +     EOF
> >
> > Ah, for the purpose of this test, we _know_ in which directory the
> > "systemctl" will be spawned, so this is good enough for us, of
> > course.
> >
> > > +     git init repo &&
> > > +     (
> > > +             cd repo &&
> > > +             sane_unset GIT_TEST_MAINT_SCHEDULER &&
> > > +             PATH="$PWD/../script:$PATH" git maintenance start --scheduler=systemd
> >
> > I suspect we can use the same idea and add a relative path in $PATH
> > for the test, perhaps, even though it is not a good coding
> > discipline.  If $PWD, instead of $(pwd), works, it is perfectly OK.
> >
> > Will queue.  Thanks.
> 
> Appreciate for the quick fix, Patrick.
> 
> Homebrew upgraded their formulas to 2.47 rather quickly (the next day
> after release) —
> https://github.com/Homebrew/homebrew-core/commit/0435f258701abd3acb9e2f4cd758cc13aa93997c
> 
> Mac users who do a `brew install git` would now install versions with
> a broken maintenance command.
> Fortunately, `brew` auto-updates the world every time a user installs
> anything so it's likely they get to a 2.47.1 in the future,
> but that still might be a while away from when they install the
> current latest (2.47.0).
> 
> I'm not sure if Git has a hotfix workflow, but it might make sense to
> prevent more users from getting onto the buggy version
> (especially since repo admins usually set up maintenance in the
> background and the error might not be evident to users).

I'm not sure around the timeline for Git v2.47.1, and Junio is going to
be out of office for two weeks, so it may take a while. I'd recommend to
backport the patch for now.

Patrick
