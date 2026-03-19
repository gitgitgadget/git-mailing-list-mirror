Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F90386C32
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898365; cv=none; b=f3Ct7acCARIocYGmvQDlWKdN/XS85t7DrkSnrv4FpRmfYlm8odLKFCtWbUaqBBkSKom1C/rNZi78GFoHdFaAmrEnbtjR8KDy0IjPFv4fNKKaRLhqSY20a6yvM0MOsZoIYX4k8LKF22WUqAWzEq9HS+oNuselD2z1wq+ktQq+L8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898365; c=relaxed/simple;
	bh=0ynkCnpd8kib+QomsncwtBNO8JBNIP56Qu3ZVoh7tf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2EWZOPM1dod21k/sY5kcQ3euSD9CxZ10NtrRaxopvAjaS4ePzTB1Z3ik4NzpFxsevGYkw/JF8GGd3r9VKeVe3x3gWuxPYdSa1wgnkoziqsbl4jy8RA+VzCCuqf8yK/u3WizyU8C+XnpO+OiJlvwNymK4QM8TQ10AZK+FME1TiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iWvRD2sB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Btzj1oJR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iWvRD2sB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Btzj1oJR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 26A28EC0274;
	Thu, 19 Mar 2026 01:32:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 01:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773898363; x=1773984763; bh=QyB/ig6Fht
	6Mne8nH1+3oqRAtzG9tqDnByGI22vwUxA=; b=iWvRD2sBeC1f9e83ioB+sLfkkm
	gdHq6Ohug2afE4HWf4/FQuClF3KbzENKIdhMQqqibrwVmoAEXb1rHkBRZbFjab5a
	k3c+AAWvTyjuUrYc4CSIukej+rBu31osC+oP8rE/LgS0jYcH4rozmCyiclJ3dvkI
	TCPyGamcxXAgUbDvto5r5sLowe6TSUYJgOIAc01+Wxpnf9elH/+pSzmYFmp+DN2Y
	wrYy2Id+czE2NtYJR533mEdpMsNFrNnTH+Q0hfJhxQCjGklhd0a2EBmyfHAiSCx7
	U6OxEShAmbGrDoZsAZhWPH9TYQYTVgl5Q3BN8RTrvf3gWhaLmNuF/SeTkYHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773898363; x=1773984763; bh=QyB/ig6Fht6Mne8nH1+3oqRAtzG9tqDnByG
	I22vwUxA=; b=Btzj1oJRJIE4uyhF0q8gmTBPr6E/uepvNzGZOevA6kuFBWvPIp9
	2E/c4PR/bmHUMQGUsPsXKqfhjBZEmLQ4C8JNHCcOQpnZ/b5dgUj4a/rPzYWSjz3u
	/lyLUASWTHjJjf6bL3N9ZQwoAAJKxOjdb2PnbZv8CsIazC67LBuSaeIeCbvJxbfG
	O8g5XeMH8sVYOlJ91kOAZs21Xo4lLQMbBO24mTtdkr60TJj65REoJYkeRRJi6crO
	0PvIT22vn8pH+bQG6j/wxsJ0Xdu28tMFUxdhVSJR3wB5Qz4jTtnTCADZbnZGUc8U
	fyrFhHlW9K6SQnApRf3ZHuifcx5EQbkfo5Q==
X-ME-Sender: <xms:eoq7aXRdagMRh_k5_QxxOm0kyyfSf_2gG_bTk9D6xLNhh1hw437gIQ>
    <xme:eoq7aeyhw5tOXpfmIx95vORiUiCpB8sup-gimVTx61odGKlzquSzSNm8cuYZ5m-0b
    2YzcspfY8ug0o8fmkSUtErjzoSO8n57h5EPW-3fGEmMz9HZe8qX-Q>
X-ME-Received: <xmr:eoq7aafvnjcD3xmS0e1KRFKR68iVyilMWQxN2EYixhpqH4-4LwR7zKYu_cIBQSTcziYHsmomLoGv8ALJ-yQoviFti7_WG1-_3HuB3lKUA3YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eoq7aSJdymF0h06hF4ZybWR-FfMgLYjcFZ4Y6Pwj5PiMuMOJNxOlHg>
    <xmx:eoq7aTGx9LNFR09e-2Gpe3DKh71r9IlePEUpcj6ARYDfICAbtGXRAg>
    <xmx:eoq7aUpjJesNcEtMTjgc0qPe8dq5IaT1A_u-AiKmwAOZb35Bp2k5Eg>
    <xmx:eoq7aUR17EWp9FNxxz_mnJ1tuCa19NV-CLyY0L1OFZE5bjevvkslXQ>
    <xmx:e4q7aao1n7p_kMtSl1wPvdnm3Iwz_o9pQ5hELeH4RQuJMXDvpVNgtWMf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:32:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dccf25be (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:32:40 +0000 (UTC)
Date: Thu, 19 Mar 2026 06:32:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Message-ID: <abuKb8OmcgDY1vMy@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <6b8e418a-cac4-40d0-8f1e-762b15911227@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8e418a-cac4-40d0-8f1e-762b15911227@app.fastmail.com>

On Tue, Mar 17, 2026 at 04:38:31PM +0100, Kristoffer Haugsbakk wrote:
> On Tue, Mar 10, 2026, at 18:52, Patrick Steinhardt wrote:
> > In the next commit we're about to introduce a precompiled header for
> > "git-compat-util.h". The consequence of this change is that we'll
> > implicitly include that header for every compilation unit that uses the
> > precompiled headers.
> >
> > This is okay for our "normal" library sources and our builtins. But some
> > of our compatibility sources do not include the header on purpose, and
> > doing so would cause compileir errors.
> 
> s/compileir/compiler/ (or /compilation)
> 
> >
> > Prepare for this change by splitting out compatibility sources into
> > their static library. Like this we can selectively enable precompiled
> 
> s/Like this/Like this,/ ?

Yup, both of these make sense. Thanks!

Patric
