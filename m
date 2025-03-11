Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544261805A
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 16:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709052; cv=none; b=PZVrjV/QT+2/1yr7NxKo9MmDtP0yvKPTQFlMfCNymt7CL06efHDopB8CNaH93YjjtyQ+EZV1JsieqlbWi65PhzPYUU+ezGj2pPwcNOPVPaLNtJkxOysmHL2d6nhJDvTGJ6w5l9xeTelxGhapKkOeV6xUpM4YOdpPsAi50oJOjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709052; c=relaxed/simple;
	bh=pvHHef25WKybvCSPRtiqUmuaVrOpNASKWVLFbY9arX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC+HMd38pdcs6X5Q9d6q4LAz+QEKou66176L8OVf2C+4NUHKimAtdD43ki2rimGSMVQ5X47Ps7KoM/k412e4iu02Qeezw02WZYcfSfiLm786ZgzIj5du9kLZizoY5I+D/kv5Z9PHuHn042+5IY0XQfc/78AsS72jNpc3mIdh1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b9W7mfwL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Um93sGaJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b9W7mfwL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Um93sGaJ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36444114022C;
	Tue, 11 Mar 2025 12:04:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 11 Mar 2025 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741709049;
	 x=1741795449; bh=dcbgN4+9UYDktP+4RDI+PWvo7j/AiNNsk/KNqRaXB98=; b=
	b9W7mfwLCh1rSqXkrlACfBGe8FDofCvJaVaGeJX1tP7uz3G86CIxN9kdTSuZ8HuW
	B8+RE6xy8e3neUTgZu/XvWzBRyayvwNcmUNd//Y31+QiRf1YEjtmoK0ymXfdn7yY
	Lvm+8dprW8BvDshIp26LL8abx5GxOBU8GvM2oxxg3cm8UaXx/TgZak3BZp6FohqQ
	ZocK/81s1RNHGIxXbWPjTJBwzB+qbx7l9WQuUkCCkIaoBSA91SK5kWzOSZDA9tkP
	R2Uis0qTuABSnl8x6Pch61nC6cSA/25HiW6x/GJBGjTVy+z+bg26QboGO0/Ny9Wr
	9BGIK+N73E9T30fyjGVFdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741709049; x=
	1741795449; bh=dcbgN4+9UYDktP+4RDI+PWvo7j/AiNNsk/KNqRaXB98=; b=U
	m93sGaJcwtS7c9kxcFTb3xGMn4TIVEu2zb+WMirQcB2CFTamMLOae4VKWGhbBv5h
	OnTzPZDw68jGjhCzu3XSV7Cr0Jk771Y9ZtrOCnhp3v9tZcN/PTnryL0LouMvyp9I
	bQLCnLrxgTNU4lnr0uL40++W5d/TkSxJ9PKJgMfr/hf6mzyO8CFwRFgDtqzoV3oo
	bJiHzD+wHyHbEexriCLhXRzHvcp2MoYHloelEGAtIcJU1pFB94hcJUQiQigvd6Dn
	zBijdJwLnFdCKYXSIhj2ukIE8r1fsrRsdmnjN+GtGZ5uBXuzqGQcwwIxLN99AvCd
	hoVaJe3+DHVMAxQzY+eJA==
X-ME-Sender: <xms:-F7QZ9KCUz91hvOg3ppNZS1PVQRAOkMc_J472bNhzl_R5L3q0yle_Q>
    <xme:-F7QZ5J7pftpcmUua34MrdGMEANvWxnraG-J0RAhkGzZRR8bp5dR4V1lywh2NQqgw
    GP9Y0qcSFvjm_HrQA>
X-ME-Received: <xmr:-F7QZ1shc1DDOft-82xOWMaEHHvQcaRB026_0apnfpR73ljQu8IrXClXmS_8o5PQVFVBKUmZsA04TIpqlHp7Q_LWqsmq1CR1iSU58LfsciVDSdLXNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitg
    hkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhn
    peejfefhgfeuleeuvdehteevfedtueetkeegiedujedtuedvteeuhedvfedufeetfeenuc
    ffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrihhonecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvlhhs
    vgihrdiirdiihhhouheludejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-F7QZ-ZhxJ-dmXnNWPqYvvReAzDpsJ2Ur8iY7usOsifaVa-si4nvzQ>
    <xmx:-V7QZ0YX3maInWVeSorOH1Qipaefg4GfiyyRFbgK_Wvv-LIJF5FgUA>
    <xmx:-V7QZyBp5_5txf85GuCa7nfNjkSDyoBE9Zn9xeUU1LKKqt9sR6j4-Q>
    <xmx:-V7QZyYUGI2CQZkdgKTyL-Zmc9AL9Kn4pHwULC_vUrf_3FhHjH7VTA>
    <xmx:-V7QZzmH_sa_mchc2vf8uueA9r4ndQmHBTh1Dr2ju2RXEnEQxKR8kQtn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 12:04:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f3de066 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Mar 2025 16:04:06 +0000 (UTC)
Date: Tue, 11 Mar 2025 17:04:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kelsey Zhou <kelsey.z.zhou917@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Interest in Git's Global State Reduction Project - UC Berkeley
 CS Student
Message-ID: <Z9Be9hAGDH7lLbfZ@pks.im>
References: <CADGDkpQuygSCPt-QwTrf1bt7hU9STLO2uxzNB3s-BdZVhWtZ+Q@mail.gmail.com>
 <Z8qkAoGcpw9VRbzy@pks.im>
 <CADGDkpRfBsvpg_LzjU7+A73_dt622qsCGu_haoPtxmWvjB9HqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGDkpRfBsvpg_LzjU7+A73_dt622qsCGu_haoPtxmWvjB9HqQ@mail.gmail.com>

Hi Kelsey,

On Mon, Mar 10, 2025 at 03:17:21AM -0700, Kelsey Zhou wrote:
> Dear Patrick,

two asks from my side:

  - In the Git community we don't top-post. Instead, replies to an email
    go inline and relevant parts you want to quote go above your reply.

  - Please send your follow-up questions to the Git mailing list instead
    of only contacting me. This allows other mentors to chime in, as
    well.

I've put the Git mailing list back into Cc.

> Thank you for your detailed responses and insights into the global state
> refactoring project. I appreciate you taking the time to address my
> questions. I'll definitely follow your recommendation to explore the
> microprojects as a starting point to demonstrate my fit for the program.
> 
> From your explanations, I understand that while no single global variable
> presents a uniquely difficult challenge, the comprehensive nature of the
> refactoring and the volume of references (3,200+ for the_repository alone)
> make this a substantial undertaking. I'm particularly interested in the
> environment.c variables you mentioned, which require more thoughtful,
> case-by-case solutions.
> 
> A few follow-up questions I have:
> 1. For newcomers to the Git codebase, are there any specific microprojects
> you would recommend that might build relevant skills for this global state
> reduction effort?

I honestly wouldn't care about that too much yet. The microprojects are
designed so that you first get up to speed with contributing to the Git
project in the first place. So I'd rather focus on a microproject that
looks easy, and once you have finished that microproject you can look
for further projects that might already be in the vicinity of what you
want to do in the actual project.

> 2. Could you suggest some previously completed patches related to global
> state reduction that might serve as good examples to study?
> I'm excited about the potential architectural improvements you described,
> particularly the possibility of better parallelization and reduced process
> spawning. These align well with my interests in systems optimization. Thank
> you again for your guidance. I look forward to contributing to the Git
> project.

The patch series at [1] would be one such example.

Thanks!

Patrick

[1]: https://lore.kernel.org/git/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im/

> Best regards,
> Kelsey Zhou
> 
> On Fri, Mar 7, 2025 at 12:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > Hi Kelsey,
> >
> > On Thu, Mar 06, 2025 at 10:49:47PM -0800, Kelsey Zhou wrote:
> > > Hi,
> > >
> > > I hope this message finds you well! My name is Kelsey Zhou, a Computer
> > > Science and Data Science student at UC Berkeley, and I'm reaching out to
> > > express my genuine interest in the Git refactoring project focused on
> > > reducing global state.
> > >
> > > The architectural challenge of modernizing Git's environment handling
> > > immediately caught my attention. Having worked extensively with complex
> > > systems that required careful state management, I'm fascinated by the
> > > opportunity to contribute to such a foundational tool used by developers
> > > worldwide. The prospect of improving Git's maintainability while
> > > potentially enabling better multi-repository handling represents exactly
> > > the kind of meaningful technical challenge I'm eager to tackle.
> >
> > Thank you for your interest!
> >
> > > My background includes relevant experience that I believe would be
> > valuable
> > > for this project:
> > >
> > > At GSK, I worked as a Data Engineer Intern developing pipelines that
> > > processed millions of data points, where I gained hands-on experience
> > with
> > > environment management using Docker and Terraform. This work required
> > > meticulous attention to system architecture and careful handling of state
> > > across different components – skills directly applicable to refactoring
> > > Git's environment handling code.
> > >
> > > While my academic work has primarily focused on data structures,
> > > algorithms, and systems programming, I've developed a strong foundation
> > in
> > > C programming through coursework and personal projects. My experience
> > with
> > > database systems has also given me insight into managing state
> > effectively
> > > across complex software systems.
> > >
> > > I'm particularly curious about:
> > >
> > >    1. Which specific global variables or components have proven most
> > >    challenging to refactor in previous attempts at reducing Git's global
> > state?
> >
> > I think for most of the part there isn't really anything that is
> > _particularly_ challenging. It's more the sheer vastness of global state
> > that the Git project has that makes this an involved project, as every
> > dropped global variable is something that needs careful consideration.
> >
> > There are of course nuances.
> >
> >   - Projects like getting rid of the global `the_repository` variable
> >     are for for most of the part trivial, as it is merely about plumbing
> >     through the variable layer by layer. But a simple grep shows we've
> >     got 3200 references remaining to that variable, so it takes a lot of
> >     time to reduce our reliance on it.
> >
> >   - Other projects, like for example getting rid of global variables in
> >   - "environment.c", require a lot more thought because there is no
> >     ready made solution for each of those variables. Instead, we always
> >     have to think about how that variable is used and then decide on a
> >     specific solution for it.
> >
> > Another challenge in this context is that we must be careful to not
> > break existing behaviour during our refactorings.
> >
> > >    2. Beyond the architectural improvements, are there any performance
> > >    considerations or trade-offs you're anticipating with this refactoring
> > >    effort?
> >
> > Yes and no. We don't expect there to be a significant impact on
> > performance just due to the refactorings. But the architectural
> > improvements may lead to performance improvements down the road:
> >
> >   - We may be able to parallelize more work via multithreading.
> >
> >   - We may be able to perform some tasks without having to spawn a
> >     separate process.
> >
> >   - With proper, compartmentalized subsystems it may also become easier
> >     to refactor their internals more readily, thus unlocking further
> >     performance optimizations.
> >
> > > I would welcome the opportunity to discuss how I might contribute to this
> > > project and learn more about your expectations for GSoC participants.
> > Thank
> > > you for considering my interest.
> >
> > I would strongly recommend to read through [1] and start working on a
> > microproject. This is a prerequisite for every student to get accepted
> > into Git's GSoC program so that we can assess whether we think that the
> > individual is a good fit.
> >
> > Patrick
> >
> > [1]: https://git.github.io/General-Microproject-Information/
> >
