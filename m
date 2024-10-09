Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37A17C9B8
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458453; cv=none; b=iWbli1TBPCN/0oPTjuGe83e7enr+KPb++imIuEyB3Qw5oVC4F/NHYT6yLpYGtQ4gBHMvx33WHbmACBjzgz3GndnLakGEspFloi2SBkJMv1K+BFcKMwG+WCZ8zqQhUnWHCEOUFAhkRrc72m9xWin+xjgAHFVZgXK9cuw/x0hOo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458453; c=relaxed/simple;
	bh=9WWTj8mAvIE9KSAhHar3i1QVCHzDwHKbfRc9Vx2uw14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po8J97sRHagiVpeZhL56vzHNf3DJkkUm7VYlQ9Bu7QOiCo018A30jrCTfJ+wQK5DLoGao9NYeB1wOV+W9pzQxszX/FpA+LfeZkNiABapn8kREhxtQSmn++vv+WJKVqoAQ7ViQcmYcGgpFdlqn+zM7zJwtdEPJN5bmZQuQPtugdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lFwZswpV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VOjHVNzH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lFwZswpV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOjHVNzH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 63DA41380662;
	Wed,  9 Oct 2024 03:20:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 03:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728458450;
	 x=1728544850; bh=eK3I3MCGCuzft8e9s24HaYzZ78uHorBj+AdNy/HlO1U=; b=
	lFwZswpVl37VyBm0+nYuNBZAcFdfnMUBu32M61L6SKcLqNkdLzP5yUVrRqluBwoY
	oUvT7j3n3HO8yIkcoluLBtZqTX5DlmmCwIXoB55DXw+KE7+CCt3A2tW/irsCZGFM
	u904+bkAS+YqvO49XBb1toM5qbLhiqVyDQoRir5uzMU76wekgiiEfk2EqQCi8A/P
	VAXtOEMTQSDOhWbn8nqAoer46KND/fLMz03g8UfifpoFVGiKcvR2uau9DnFbDmu8
	peWj1q7cMi3TulKeAHgQPseogvFUnPgsFvh2qOtteWwHOxeC5eu6uD1WGD41KXO6
	FfNFFjPYFwVsK049tu/t6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728458450; x=
	1728544850; bh=eK3I3MCGCuzft8e9s24HaYzZ78uHorBj+AdNy/HlO1U=; b=V
	OjHVNzH81yynznoje2IznIqosydvKezA/Yr0ONmBswFffUhUTy5KWNPlG4AedGAG
	7RvCLU6qJHYHHbS+2p/qRL0m3TujJHj0HnEq0DIIJLsAGuUquUUchLsUpOuuB/PA
	y/fyK3TeUAFAZYCPVVcfLQbH4+NLK3Ylwy/V/ujjqzLabuStxF/LMv49TKEDjnST
	4zWre9562PeT+OQHwNPKrzPuiIc7yw268JD6fd+gXILQkZMy+foGCtOV8DS4e+uJ
	Kd1sy5nrlF0wgaox4oQ1IV/Dz9rHBd0oRFL2YN42f65uKvVMRg/ildZozwipky6Y
	6a1htArv3AhI8nsIItvXw==
X-ME-Sender: <xms:0i4GZ3ErHfF-lL64TBxfAP7AP4P7UMjHwiVKVjZh3HIKTbjzu8k5xw>
    <xme:0i4GZ0UhlTCZlLz_bPWinKhlhOZz_g_t1RrPLFcfW0affT6qV5c9X62uiYZaxY1yO
    NQLx4maD47DyWanTw>
X-ME-Received: <xmr:0i4GZ5KAXyRmP3khjn9otTOM-U6DOhqewKlycQ36aO6eXqHYPAopvk2Fup_gNPBUhJmoie3MrGu1LrlTjU2SFfJPs5CnVvSSq93EJoj-0PJHWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0i4GZ1FWqLHI6MopIhuKTyqYTKA7y5NR-3MMrIW2VVxV67dU_hl10g>
    <xmx:0i4GZ9VKKe9iEqAIGN-_fepRZvPUr1sOjaq-l5edM2KJNGWm5dN13Q>
    <xmx:0i4GZwPXEiHBb55xdhu1ydXIwAkPOGimCwNpPCvBxhBMOz1veJSSVw>
    <xmx:0i4GZ83Pk0V1vOsp7KEg0OdtESQILD9SZc3RoCEW2D3IitNVbB7VMg>
    <xmx:0i4GZ_JOYC0fTAfmHJFG834VKHVob73dTtwx8zbeCCWgm5YT7OHLfYaU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 03:20:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bdaddd0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 07:19:45 +0000 (UTC)
Date: Wed, 9 Oct 2024 09:20:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	christian.couder@gmail.com
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
Message-ID: <ZwYux_Nb9GwqPuuk@pks.im>
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
 <xmqq34l75pr7.fsf@gitster.g>
 <CADYq+fYZSGBTnO+dM+MtHj=oUMqDWt+6wu-wEzwfWQJkSomkWA@mail.gmail.com>
 <xmqqo73u1n0k.fsf@gitster.g>
 <CADYq+fb9ux6K+m-8y0owopt_zKJmXXYLh6Rswot3r7UNX30LAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYq+fb9ux6K+m-8y0owopt_zKJmXXYLh6Rswot3r7UNX30LAQ@mail.gmail.com>

On Wed, Oct 09, 2024 at 04:35:04AM +0100, Samuel Abraham wrote:
> On Tue, Oct 8, 2024 at 7:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Samuel Abraham <abrahamadekunle50@gmail.com> writes:
> >
> > > ...
> > >  This was the reason for replacing "test ! -[df]" with
> > > "test_path_is_missing" where I think is appropriate.
> >
> > Telling that concisely in the proposed log message will help those
> > who are reviewing the patch and those who are reading "git log -p"
> > later, and that is what I would want to see after a review exchange
> > like this.
> >
> > Thanks.
> Hi, Junio
> I want to express my gratitude to you and every member for your time,
>  guidance and patience and to my Outreachy mentors Patrick and Phillip.
> It has been a great learning experience.  I can see the patch has been
> integrated into seen.
> I look forward to working on #leftoverbits projects to enhance my understanding
> of the git codebase. Thank you very much once again.

Note that a patch that has been merged into "seen" does not yet say that
it will be part of the next release. "seen" is only an integration
branch for topics which are currently in-flight on the mailing list and
in the process of being reviewed. The intent is that we can catch any
incompatibilities between two different in-flight patch series early.

So declaring victory is a bit too early :) A better indicator is that
the patch has been merged to "next". This is described in
Documentation/MyFirstContribution.txt, section "After Review Approval",
and more in-depth in Documentation/howto/maintain-git.txt.

I think that your v2 isn't quite there yet. As Junio mentions, he'd like
to see an updated commit message that includes your explanations why you
have done certain conversions the way you did. The fact that some parts
of the patch required discussion to arrive at a common understanding is
a good telling factor that a summarized form of the discussion should
likely be part of the commit message such that future readers of the
patch will get the same context.

Patrick
