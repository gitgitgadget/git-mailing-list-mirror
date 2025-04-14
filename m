Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391591AC891
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613430; cv=none; b=Hej1eZ1VJlMsvtbcjso9nBpFpZQpFWH/uSq1ZNHSSecAP2sgYckN4MiYF63ecV+drPywKM7ROAgWlR7N8qf4Uq2i8JeDpbE3/7NXmodVYd6lPS+FlryQQvNBotFgZU5bEvcHHUQ/2pBqSWQOFYzzMOj2A8dRYsXHgumeqrYYvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613430; c=relaxed/simple;
	bh=o91aEEhct5zEKWmqv7Eo89OzvKBszZDfCpJD5mvgeSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaDysCYwbvVcSTHsXjPNIOaNoulw7KScHE2c6Kz1/Bqxuk9Ec1lQSMkIY4+AqV1bGjfO5kheH8YrfwXMFZafwzII6koOWpoab5N8i5mvwtmlslCsxSv81UXE4jg1LuqGmJQjC8fyVhD94+G/mzWE/sY9bidhMZQCe93iB1RKQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XLlNtnin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g3TcVlCw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XLlNtnin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g3TcVlCw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E66DD25401E1;
	Mon, 14 Apr 2025 02:50:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 14 Apr 2025 02:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744613426; x=1744699826; bh=aaVxILn0Rv
	+IcJZKB+iOEXCCozqB0VxQzFNndu6Oawo=; b=XLlNtninnYCzxgTGjGS2uoYAMM
	OjT6T896PvFKM7nxtLDhIEKcecIqDRSFbF+rsAhnYUjOXHUpOACioPmDkxeSQfnX
	/KnMtPS58JFwKc7MDwGxKVL7UNPkCRg65u3SNiQNsNdwExQdHnBbyQJ/8iZw5nQj
	vW9CzC7CADfoETsiEdQGiBHdqcWPPFoBDLHk8gCdCcz1fKpKGfPZ1x3AQMBndgqk
	sj1c9yTHbUNOzq6Vq6bSevYrfgsnHIHbtq2CE5cLEoonu8cLvQLAgDT0GafaiuZr
	5/cRv3lDtJX0EGRXxBG9JmyMde/7NUdJMt1Dfc1wrD22rMT92GGBph7vE+Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744613426; x=1744699826; bh=aaVxILn0Rv+IcJZKB+iOEXCCozqB0VxQzFN
	ndu6Oawo=; b=g3TcVlCwzRNx74BaflBaxBa3Q0Ci/0ghhXj+SgiMKEhdm6yrn6I
	reGDqSd7cOQFcMJd5T8hq6mOPIeCCXRf6/1l1kwZ0BnbS5cUab88ZrCJFnWPps6p
	lSmkp774Ae3nFTWlTzC3mMDPecEBx+6LHkfnhs8IJTQhbycE6aH3Ww16vOV9lVYp
	5dNF5k18NHxYrTR2KNMWo7BQIr8JqUC7cuKEzYvNt0aDh8Xl5RG1mRRKOZtxvZ2N
	ke1m5Lrx17AW5FhT/05TIhXnSPaHw+SXoBHpv6FsSOaRtESloqFczlRa4NrH9Odc
	Si8/V/+2Q2F3P36f0iFCV2nDeFrP1XZapMw==
X-ME-Sender: <xms:MrD8Z-EelMt-M22V6JrN9dhtMOGj4nrAXNRtz_fDNt1PBtY9FD3EVQ>
    <xme:MrD8Z_VnMZ8lIW8Ut6JF399zVdXKD-TCWqJr-QMMi1NXikA-NyLBmfCkyQT4-t94a
    baWr0waLZex8EAYKg>
X-ME-Received: <xmr:MrD8Z4K5q255Kp-r83qFhEO_s92_HLJ-hQDg8vmBLK02mjRJoyeFGt9NRH76rHBdTx5kFziMscIP62gXf1DiIncJmxY9KRTDuRzuvFssMRJD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:MrD8Z4E0hGxLCfJSEggwws1dMc_vSFYbi9DRAwCekQXWc9Q5WstSUQ>
    <xmx:MrD8Z0UFpnz-ioWDCHSisgCOf9rR3ZfdvklLDF47zRZaSveH7xpq2g>
    <xmx:MrD8Z7PY7m0vOSVHY96Xe_NaQjgxi45b4Dq6MbFaJAAI3Qb8XFXCLA>
    <xmx:MrD8Z72nBNdOoGV3haed9I6Zi4-ttCxHnUrF8hBZ-EZE6q5HgK4b0A>
    <xmx:MrD8Z6E9T9RmVDNXGrQuCYO46O_F9aTlwgSM6rH5bXNH2HqJMpyF7CtR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 02:50:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0dc1def6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Apr 2025 06:50:21 +0000 (UTC)
Date: Mon, 14 Apr 2025 08:50:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] t/perf: use configured PERL_PATH
Message-ID: <Z_ywLLN5xj6cYFN9@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-2-b2ace85616a3@pks.im>
 <87semgdyxb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87semgdyxb.fsf@iotcl.com>

On Thu, Apr 10, 2025 at 01:43:44PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Our benchmarks use a couple of Perl scripts to compute results. These
> > Perl scripts get executed directly, and as the shebang is hardcoded to
> > "/usr/bin/perl" this will fail on any system where the Perl interpreter
> > is located in a different path.
> >
> > Our build infrastructure already lets users configure the location of
> > Perl, which ultimately gets written into the GIT-BUILD-OPTIONS file.
> > This file is being sourced by "test-lib.sh", and consequently we already
> > have the "PERL_PATH" variable available that contains its configured
> > location.
> >
> > Use "PERL_PATH" to execute Perl scripts, which makes them work on more
> > esoteric systems like NixOS.
> 
> I see in `t/perf/README` there's a mention of running `./aggregate.perl`
> directly? Shall we inform the user to run that through their Perl as
> well?
> 
> -    $ ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
> +    $ perl ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
> 
> Or do we expect users to know what they are doing when they don't have
> Perl installed at /usr/bin/perl?

Another solution could be to switch the shebang to `#!/usr/bin/env
perl`. We also do this for "t/chainlint.pl".

Patrick
