Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1B54907
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137824; cv=none; b=Fl9KOV9aXOLD33sPArMmhfzRll2efW6o99tG82mQX1q1eN8i275TGtlaG/yFdPDoTd7DXw5vTz3gW2WfwaULwAOUP7DBWryjtULs5r7YMx1CDCbfGLPqCvcuqBDRTDQQAngYrXTCBNkpBUwz2LfX9VHORxz1in2/bUKOL/n0mgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137824; c=relaxed/simple;
	bh=pBrxfS1n9WTsanOWhlCXONmypq6jB88OoeyotbM7z4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSCli9z7BM3orPoPS4Z6oW/QPrU640RfqdmA5ZsuG8v+bnqM+t0kddBknwGigA12nSLpxdHLDvFe3qJYvN9su58jiZw97Y+a3xgIC6GSF1f4TjW7ENvbC7IJWMloviRXCsSXvqeq5QcrHnUtzo2ycAS5BPoNoMIeq62QdGwoipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kzTzgCBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eL9zpS9U; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kzTzgCBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eL9zpS9U"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C245513802C1;
	Thu, 17 Oct 2024 00:03:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 00:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729137819; x=1729224219; bh=eJraRdCv+Y
	SRazV0kISFhtWMqUpw3qcaX7yxd9bf1JU=; b=kzTzgCBYdFjAnqGeBpJ1feg/Sd
	v1MJWst6sMIZW1h/9P82zHOADzdEnJIzpd4RkRSyyLSDs8w6Dgc/gdYJs2MFNUy5
	YGPoFHYnV/Appo8xGXLxPvyEKXktQl0Fx3DfQB0pr1pt0hbgv9q3uLFhveo9J2cf
	EkaZ3TOXQKW6Kz/GQX+vpbkFJ4H2WNCwxwPTU5/lwj/cLtTWjlTz4907DdHPUWk0
	bZkDBRNupPWXQewEKmI2tpjp2F4bxVMYFJcsr3rdF+woWwbdMExemfg77MVF5WPQ
	3dSDzSHPy5jJs9HRvx8NLsg6/ObkBXZ0/ziPQmP4guvM4Q4L9M9+lQnhzYRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729137819; x=1729224219; bh=eJraRdCv+YSRazV0kISFhtWMqUpw
	3qcaX7yxd9bf1JU=; b=eL9zpS9UyMSW9lYozknBr2ox45A2mBtbpdMTu80umvFC
	5omPafcbENgjj526vFaEwJYNbDa6Ehuhb4LhytpBwfNlBnd2jrHFUsITqyBhgZ7R
	CGyIxUaxlySdHUz6jA0WgH5mJp5zgDtYZ09m3Fzwemr3LLMXfOGxiCJpWF/VHcg8
	dHeHcve8Jmnjc5sH85bbCGLgkJdd+L82ESnmTksshVHbh1E3ZR9nNDc2CrahCS6d
	TaRejD5+KTbqnSPtccYnjUjDo3Wtg5l4wVgBUQcjPkVKgLoGiwE2g1AVUMwmPRI8
	IDtXY8q8e/amvI86Q0Ra7xo/6xzmi+sfbNVQVi0QCQ==
X-ME-Sender: <xms:m4wQZyTbm4R7mquIlzRHbl9gxcw2zLYqyH3XUhxnYX9xsxvCzIhW8g>
    <xme:m4wQZ3zCZAI-JtGIC5uEamLVn6JtMfihJaFMRAEyGoPiZj6zFmSV6ufvBSAEYvyvI
    er5reAsw7Wc8nSTiw>
X-ME-Received: <xmr:m4wQZ_2OUlV2b54ZfoWZGQo2I3Aiate0bJPZX0hQkf8wwVfD21Ocw-Y9K6bsPP-PO0SQhx1-NBh26rEawBemqH02kN9AvOpaTO9S1MlRDS9Wng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hm
X-ME-Proxy: <xmx:m4wQZ-CbvfyPp5plxvBRC1B9RkDmF4uawT2SpeRcJN5xUR_-ATew9w>
    <xmx:m4wQZ7hiiiUIR4NpJ7TnyoizyE2AKB3GCVhD8_08NhffCgghEy_h6g>
    <xmx:m4wQZ6r0I2OGFhrA5dM3fuHavXMB3HNOvWRgRTpYYb2L3UEBd8-_CA>
    <xmx:m4wQZ-h5de_yyDhYRWVMpJGXemXbmlVLxwnmdm6fZHSgrNaFjHkjgw>
    <xmx:m4wQZ4uF0vTk_-X2tDNtdTLBBP_lm16fujAvMBVYR00QgfGfU5EX0Nzx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:03:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f7bd343 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:02:20 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:03:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] t/test-lib: wire up NO_ICONV prerequisite
Message-ID: <ZxCMmT7tg0tz-ncM@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <f6a8582c34a7b77aa3e2e45298208050333c384a.1728992306.git.ps@pks.im>
 <Zw8AaF4VOaQO+P2M@nand.local>
 <Zw85joY3Hqzx23xc@pks.im>
 <ZxApLn9Qf4hdAlBL@nand.local>
 <ZxAqA+iyz8EIOeNC@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxAqA+iyz8EIOeNC@nand.local>

On Wed, Oct 16, 2024 at 05:02:59PM -0400, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 04:59:26PM -0400, Taylor Blau wrote:
> > On Wed, Oct 16, 2024 at 05:57:10AM +0200, Patrick Steinhardt wrote:
> > > On Tue, Oct 15, 2024 at 07:53:12PM -0400, Taylor Blau wrote:
> > > > On Tue, Oct 15, 2024 at 01:45:11PM +0200, Patrick Steinhardt wrote:
> > > > > Further note that there are several "!MINGW" conditions in t4201, and
> > > > > all of these fail due to iconv-related errors. This is quite likely a
> > > > > leftover from times before dce7d29551 (msvc: support building Git using
> > > > > MS Visual C++, 2019-06-25), which switched Windows-based builds over
> > > > > from "NO_ICONV=YesPlease" to "NEEDS_LIBICONV=YesPlease". Consequently,
> > > > > adapt those tests to also use the new ICONV prerequisite.
> > > >
> > > > This appears to break CI on Windows when I merged this into 'jch':
> > > >
> > > >     https://github.com/ttaylorr/git/actions/runs/11355564982/job/31585450667
> > > >
> > > > I'm going to temporarily eject this from 'jch' and 'seen' until we can
> > > > properly deal with this.
> > >
> > > Ugh, I'm looking forward to the Windows jobs for GitLab CI being merged
> > > down to next so that I can finally see such regressions before they hit
> > > our trees. Anyway, thanks for the heads up, will have a look.
> >
> > It's OK. Ejecting a topic out of 'seen' is relatively easy as it
> > requires the following (after removing the line out of Meta/redo-seen.sh):
> >
> >     git checkout -B seen jch
> >     sh Meta/redo-seen.sh
> >
> > I was mostly confused why my build of 'seen' passed 'make test' locally,
> > but failed CI when pushed to GitHub. Of course, I'm not testing on a
> > Windows machine, and you didn't have easy access to Windows CI runs on
> > GitLab (for now), so the result makes sense.
> 
> Speaking of... I have 'ps/ci-gitlab-windows' tagged for 'next' in the
> next integration round. There is some duplication of patches between
> that topic and this one (as well as ps/build).
> 
> How do you want me to handle the dependency?

I'll soon reroll ps/build to depend on all the other series, and will
evict the duplicate patches from there. I'm happy to send another
version of this series here that depends on ps/ci-gitlab-windows, but
wouldn't mind either if the patch landed via both series.

Patrick
