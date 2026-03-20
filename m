Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EF8834
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773987270; cv=none; b=qWBEsepK9CzjULmBZwSOF9AVd3lcEITAQ6D78KPvfdw95USfA59Ro3+Rim9gfAxtRp/ufn/1qACQIxvOf2xwSVU48PQG4IVi9YtfBCESSQ8Vfz2xQbuGQ4hhFBdfug+xgS7WE9BDxllKd4AtLUXrtS1EwvkNGoBu0FFS2XAkQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773987270; c=relaxed/simple;
	bh=xGGPXsgRu8k+1rAalwSeuGfb7juNoXC6DMCVoDoIONs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lki3Pz/3x827/K8WwVn5XIW1I0nOIh1K2FDvZBXPbngOmsb2m3GLdQIB4x49o/1BjDT4YjwQBsdhnUQnpzkQun1103XeaO6ANEy9/4SykEpnHuSetolx+IOGSY3J1FUzW6Ei94xZf5y6jSLIvM0DiU13IjARN/Zf+NB5lN2PUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CEKn4tWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D233Zck9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CEKn4tWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D233Zck9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 738161400176;
	Fri, 20 Mar 2026 02:14:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 20 Mar 2026 02:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773987268;
	 x=1774073668; bh=zZIof15KKVAyHcBW2nbzm3lITKll93lF0m8KhOl1OpY=; b=
	CEKn4tWbMORpML01S+NIoxFElOWI3+9B22BacKrxnA13IgENJu3vjvMiV5D+74ph
	clY2PJgjLOHRrapJOk/097r04ZjEZF7WfZccPoUv3+gGvp2lio/U4j3NymvxqcUU
	ABUKVNGcxKbwJz+5T7XW53Wn3RjHkYTPDq3X1wTVh+GnJ2Uq7J3EJejfIWmspot5
	QEtWPYSIl+TTigRNHZDa4zJZd4gojJte323gUrLMGpvlpB30joaq6UnZrX/MDgoO
	ALXFFY6qzsVAkzje5zS7U1D0QA6+4VJpGHK9s1InCD1LrZnGCLlJXMGtNKtY4DL1
	wJaL6RfnYQT7i+LvQtOMtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773987268; x=
	1774073668; bh=zZIof15KKVAyHcBW2nbzm3lITKll93lF0m8KhOl1OpY=; b=D
	233Zck93qnLhZ8WjcqqLqD0JFiQFYXz9cb2n4vCDD40rjA1AzaoxAZV6Yf8Vi0j3
	Ij7qMzIlZAbbNsuK4XbVBH6ZWIEGXITno/OX/eWFmx+hIkJpfMMbpgi1mFmxuef9
	WIX/Zrsb/hCYukreTD6HmFlKHMYaS2akcPD1qf0quHT6B7T9GeFTLXJs5Gh58LLl
	g6Nb3jN/o+wfoj3J7QMFnmulVZeHKO9/DFc1K0Sq931Q2+dEyI5nEqOLYULnXke1
	zS1hf+CtiAnZTEwZWh2/GWjqiafgPjCWwOnLgXXTG30zcotyLlG/bUhOS8ikL0Hm
	fc7w4t/1cjiyhh6R/vtNQ==
X-ME-Sender: <xms:w-W8aQGeskqS-SaRWTy-Ql2Ekd3qsoOPJz2WzonZ_12vyIdaIgz8Og>
    <xme:w-W8aRGwuLfdgdhm1Zax6Yldc-UgJ7_9QrqsPq_zr_IENWvu0CBdTg9oDpLmL5SpC
    3UPnaqB6IfBoLVCdDLdnh3WBYVI1gokR3eUL5_b-EcAboLtkEjDrA>
X-ME-Received: <xmr:w-W8adO4359p240cBQ7RBpX4qzWa5BIUFo4iXCiNWOooqe7AgrL-vgudKwjbGSjnay2BAExj89mZlVdP1G_CQldlFQxI0QYFJQtOf8gX-3t7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeludegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xOW8aQHFZHnOvSUU15LlucOf8aoRlqlgfVVXA5eRij1BPR8eprSlaw>
    <xmx:xOW8aUPRpSGpiVxnLWJxTtfTObCRPKZeJHT1L07hLC1sqCL8Ksvi6A>
    <xmx:xOW8aR8Mj7TUSt7Gzw_wTj67VOX1uQNTjBEFn3l-KS2w8782xzIzfg>
    <xmx:xOW8aQQRSuISL0HVbHcui7BO3Z0JcZnxWPPEWVOZzetHGXRcHRK4WA>
    <xmx:xOW8aQXEk9DvTdljIBgqsyG0_7T7As5Au-B6njGwCz0QeBaBaX1lYuva>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 02:14:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e44f2c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 06:14:25 +0000 (UTC)
Date: Fri, 20 Mar 2026 07:14:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Subject: [PATCH] object-file: fix sparse 'plain integer as NULL
 pointer' error
Message-ID: <abzlv_6qzZcjluic@pks.im>
References: <97c623fe-4e03-4fbe-a6af-9c01c101bae4@ramsayjones.plus.com>
 <xmqqqzpfgu5s.fsf@gitster.g>
 <b2656d8c-7878-489e-a78b-ecb441570bf6@ramsayjones.plus.com>
 <12187836-0b2d-4e82-ae0c-4da972aee7e7@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12187836-0b2d-4e82-ae0c-4da972aee7e7@ramsayjones.plus.com>

On Fri, Mar 20, 2026 at 03:44:08AM +0000, Ramsay Jones wrote:
> 
> On 20/03/2026 02:04, Ramsay Jones wrote:
> > 
> > On 20/03/2026 1:35 am, Junio C Hamano wrote:
> > > Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> > > 
> > > > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > > > ---
> > > > 
> > > > Hi Patrick,
> > > > 
> > > > When you next re-roll your 'ps/object-counting' branch, could you please squash this
> > > > into the patch equivalent to the commit 2b24db1110 ("object-file: generalize counting
> > > > objects",2026-03-12) in tonight's 'seen' branch.
> > > The topic being in 'next' since March 17th, that is a bit awkward to
> > > arrange.  I can queue the fix on top instead.
> > Hmm, odd. I didn't do a 'branch --contains', obviously, but this only started tonight
> > (and I built git yesterday - master, next and seen), so I just assumed ... ;)
> > 
> > Sorry about that.
> > 
> 
> Heh, I could not sleep, so took another look! :)
> 
> 
> The problem was actually caused by the 'ps/odb-generic-object-name-handling'
> branch and commit 936c2bfecb ("odb: introduce
> 
> `struct odb_for_each_object_options`", 2026-03-19). In particular,  that
> commit changes the type of the last parameter of the
> 
> odb_source_loose_for_each_object() function from 'unsigned' to 'const struct
> odb_for_each_object_options *', without
> 
> changing one call site from '0' to 'NULL'.
> 
> 
> OK, I can go to bed now!

Thanks for catching this! Fixed locally now.

Patrick
