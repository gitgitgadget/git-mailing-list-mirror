Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB90A1E8346
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903054; cv=none; b=HMcQfbfoAS5Rk63bGrYq70ejpwwk2578fZO/N5lRyzLWhu+/JxVTuinGYe1rnUdvnAWJ9C2idoXAgP8k4RDUMCFfb1tOXU/aEz+NNSeYb/IiJ1Kf791D3y5oc19otQdqxo9QNr8g2uM/iNtpOOhfFA57Z2T0kfrnzFII2qGtV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903054; c=relaxed/simple;
	bh=7zGrmskIIPAcA2hOF3N54dZrm7QkxtVOv+x91ZXV0Fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q7yQIoHHANUFr+THPgG7m7KPopjIxC0o5nyDAv5u5X5LTZrgp1HlE/na7qN9bQ71vPhv3sDiDdSPPMPUocMjlKyjwIpnYSONzBOZ6pdBsYK4eD7eH7EKzdYhLYtBgqu7HbXQIQoBhzFdIN6qVsUJ81hfyLIdRpv41x36HvjKnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JAwvnmox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fTE4DRXH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JAwvnmox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fTE4DRXH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E47161140169;
	Tue, 25 Mar 2025 07:44:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 25 Mar 2025 07:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742903050; x=1742989450; bh=53KLn6VWv/
	shxBIyqaz+Ym0dvupuMc7+amaU4L3jg80=; b=JAwvnmoxiibVd3t3he6xXXGSV9
	SeKm/5peM6Yf+Zr6YdkbpZ6u2l0uPs8A6nQoRt0ffBk4dBDWljcpOG4etYByeR9s
	jQM049PEv1wo2URatWJzVH68nF45EoDpk9hZboR0E+jT+OY02i+n/b4Iw2IOUFKg
	+4oinOxn1RecLHUTRRePVN4rxM/J20ygT+gV4L/zSvSYkL3uDxxk6HAEiIU4K82M
	+mHL408leAUlJ3yadPexqwb4oPBgVYOhtU6bKfOT/+q/BlhnJUlo+J9lcmZci2HA
	NcPoynpu8crp8GEtGuAQhvtFImuxpc+5AcywQRGQi5BAeojbWEMIxK+QydMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742903050; x=1742989450; bh=53KLn6VWv/shxBIyqaz+Ym0dvupuMc7+ama
	U4L3jg80=; b=fTE4DRXHgmAjL9L8oQQvE5nyGcyMtwe2OdSZFitdOS8k2H2ZP1u
	8BKQYRPNlzA6ZXqhBw1eI3IWn8EBurmikN2u6WqF9TTYcC+P+z56Ilhs9i5FZHeD
	P5AxG1vpnnDd4GljlJw1H4sOKr5k8FBqtPrPx/YVDySZd7mjkjo7EKsKxqEZDHd1
	6LoJoonRxshIFQn8ITnvGaT4y0uGeugDJMMzMvTwPM7fU6eRRwBhxQUa4jqOOkSm
	dTCfCnSgoe0PreNmfFSTSjQ4pkru0eyAGTrZbWX0RQuxx4USjGKASn4lAdrGzS30
	gVI2D6kMjRqXsBv2fxQA2Ioe3fi5LtBI4Eg==
X-ME-Sender: <xms:CpfiZ0dt_QWyO9C50UZEhQG5m6mrwrIQuf5z20rZThvCf8KGLTCdqg>
    <xme:CpfiZ2Ntf9Q-tKlFodi4f-oc4tc_TWab6tm0iW37-PwgjaBcqYYi1Zgwt7QkK2ROi
    ol9u8r6eJytEVHaLw>
X-ME-Received: <xmr:CpfiZ1jdLJ9lHK22PZx7OCoMddzHq5ONxOBj6p0ert55nvAwJj__SgyOWinpEw55ye5_5OO8aB3Nif-B5DO1pSyN1kJhTnSmZ73yj2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:CpfiZ5-6-rbkZk7Gll0YQ3c7JdHOq74nDGqikPc26u0HjSEH_uluOQ>
    <xmx:CpfiZwsURFWMvLnYsOc_Jd34SneI_dyGWlpSma4_0QCBbCznqqG_aw>
    <xmx:CpfiZwEHCf2mDWRxp2GmWPrRnZbQ8EVT_xDMh2DCRsPG4hfkjPWgpw>
    <xmx:CpfiZ_NyrJ4uQ_wNoQsjl0XNZOZT09I4SIzJPZqd_QiqJ89IX7UACA>
    <xmx:CpfiZ8LrUMF3Xge-nK2EydUVlvW_-Sw2uRJKtNEr91fDjpZtkO77dGRy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 07:44:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Releasing versions on Fridays, was Re: Git Bug Report: git add
 --patch > "e" makes keyboard unresponsive
In-Reply-To: <2dd6e0fa-b997-f69c-874b-f424325123a8@gmx.de> (Johannes
	Schindelin's message of "Tue, 25 Mar 2025 12:23:58 +0100 (CET)")
References: <CADs5QabwDtUpehNY3hr6BzKyfpp-Ts54TANGkygWPcN3T=OSOg@mail.gmail.com>
	<84c3ccdb-2aaf-9b34-91c5-cf5c27f53dcb@gmx.de>
	<xmqqsenb70u0.fsf@gitster.g>
	<2dd6e0fa-b997-f69c-874b-f424325123a8@gmx.de>
Date: Tue, 25 Mar 2025 04:44:09 -0700
Message-ID: <xmqqsen1mj1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I have stated my preferences previously, even attempted to coordinate
> between Git and Git for Windows, and I observe that the way I present
> arguments is ineffective. Therefore I will try something new: Refer you to
> a couple of resources that could elicit some introspection and
> (re-)thinking of existing practices:

It is even less effective.  Friday may be bad and many people may
agree to avoid Friday releases.  So what is your preference?

In any case, I'll go back to my vacation ;-)
