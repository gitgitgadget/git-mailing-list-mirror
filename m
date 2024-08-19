Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0953EA69
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048255; cv=none; b=cjig2ENj/3ERQQ/cWhHsESGcSUk9czfA2+0H27IGfhIjc7DCYyOfhTnFcEQ99LDxoFdaoEdlw4WRbvw9mZ29WZP0E2Ns5AK7m/srI6vDwQQhsPPqZLmuzT9nSlQZxY3ArRPaojAmY9cLtiANeb9w8gKk5VvFYSvlC9u5syI9o5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048255; c=relaxed/simple;
	bh=3d+yuiSETvmwl0F40OXX6dxy5Oys9QrbRBCJ2vWwIfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM+tkRA6GKZDUuUInExCtphANGFvvZQue/Qz2WsjOStgTTVp1b0VziWrfFpe7v0yBEvJWneO1SzNw/dCH+MdhvpPyFOeHba37uY+2fuFzAM570pAvnKNN4bo6Te2UdzieZmQqOHEqvjHDBvdaHk26rtO1nTvihEhPOXCCoVguHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DWYW4S97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5pwLwqc; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DWYW4S97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5pwLwqc"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B84631151A79;
	Mon, 19 Aug 2024 02:17:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Aug 2024 02:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724048251; x=1724134651; bh=pjpRDjzQx5
	6+/gTYT/Qp0iF9y0JxWfXDYDgLw7EoR4Q=; b=DWYW4S97Q2gKqECylOZbW2Oqam
	30s26pbvWRG/vrp6Rm22FDqoNzQIpsLZHxtYfaQtvuN0QXaYhC5HveecVvXSYDkp
	wwJ1BOklG8Wq23ehvWHMcQoE094ZTX02XECZNYh+DGKcQ13FK6nJGwnp1vVLPkg1
	DVbADDjcFD3Y0jvvQkZtQG7MC8KHUdlgclwkv4LqrVoIXylgwM5fXYy8XhngSLHT
	uCl0L/KRjY3ChdArIbafRDYLCHs94ty7R+L2+njlRgo+yozYPYq+o6sKFyj8LRKF
	me4k2GLpie5Dcnob0wV+qe8btLACF7OxPgIvzP7GizpLRfxzSPK1TWZe22ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724048251; x=1724134651; bh=pjpRDjzQx56+/gTYT/Qp0iF9y0Jx
	WfXDYDgLw7EoR4Q=; b=W5pwLwqcDfwkb8U21f4foti7al/HhCMf6UoijBN0kxO3
	NZu1WrYqM3A2p6TsJu1k2EvOQG36/puYWC36U/aHa7O0xVORYT72oU75xWX4Ud72
	RJQPuEM9sS2ISCI5cLcc61+JpaDukg5/CHOl9m8etYz8OoGC5byV7M2uLMfjg/Yy
	YngI3dlegiV42wRfMIJ2bdzAhijdqFx+7IsjZkWWR0HmomT1xQXBlOGNzZii4xPq
	3M1zqNkMOEOqMcoqRR7di4qIah2lkkeUC79VGIKWMW8b7sPqPTfzN1ZnRYJ7mPnI
	Gv0uz9HxGIvBl5+Gj+Tz593+6X8N8ulcbfLwS7Qerw==
X-ME-Sender: <xms:e-PCZo0gzozjTEc7vAFj7EkGNtqaIOWWXYRGsicP7Z_iJ5nFHuiw2A>
    <xme:e-PCZjGm9LRrHFKoOx0Px0_ylgdFeNTV-Yxh1_4A-VgFkNJHxPNY8RxnVxAwLUboi
    uLuqmxYNupHc3TFDw>
X-ME-Received: <xmr:e-PCZg4hB4SDcHJNRRtEfIJpk3qnsvj7A4tFvRF3GK9d4kPsNM_SJRY0_FAufVYzuWvvo1ldfWxaTuXatEllEeMH91tp2mfja6cjFwoBv6h-XWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeelueffgeegheevtdetkeeiffdttdehteekuedtkeeg
    iedtvdfhueevudelkeeghfenucffohhmrghinheplhhoohhsvgdqohgsjhgvtghtshdrrg
    huthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:e-PCZh0Th4DLP4L2jvlJzDl4thlhB2Q37w86ZLGK0hdTLEV-2WFJmQ>
    <xmx:e-PCZrH1rhULXfPjuz77Z41De4UQQ-tW6grAhCOE1hZl8MQHJta_xw>
    <xmx:e-PCZq8-TuqVHrNBW7VmoXyJPT6Dg3mDp7aptm7MB4KdfQi879HIhg>
    <xmx:e-PCZgl8kw2T39tGpC1gaHwgyUUoyybW-9g_79TSkEymk0OERWQ67g>
    <xmx:e-PCZq0eCHwH0hYRC8LT4lLjG1cdMeLLIXQQ6BmtPd-0ywunTVajApse>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 02:17:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 97a089cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 06:17:00 +0000 (UTC)
Date: Mon, 19 Aug 2024 08:17:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] builtin/maintenance: add a `--detach` flag
Message-ID: <ZsLjeDtV9Gt3kbhH@tanuki>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723804990.git.ps@pks.im>
 <347d0a200201ce215f5b2c46d23de0cdd0181956.1723804990.git.ps@pks.im>
 <20240817070924.GA1438563@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817070924.GA1438563@coredump.intra.peff.net>

On Sat, Aug 17, 2024 at 03:09:24AM -0400, Jeff King wrote:
> On Fri, Aug 16, 2024 at 12:45:15PM +0200, Patrick Steinhardt wrote:
> 
> > +test_expect_success '--no-detach causes maintenance to not run in background' '
> > [...]
> > +		# We have no better way to check whether or not the task ran in
> > +		# the background than to verify whether it output anything. The
> > +		# next testcase checks the reverse, making this somewhat safer.
> > +		git maintenance run --no-detach >out 2>&1 &&
> > +		test_line_count = 1 out
> > [...]
> > +test_expect_success '--detach causes maintenance to run in background' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		test_commit something &&
> > +		git config set maintenance.gc.enabled false &&
> > +		git config set maintenance.loose-objects.enabled true &&
> > +		git config set maintenance.loose-objects.auto 1 &&
> > +		git config set maintenance.incremental-repack.enabled true &&
> > +
> > +		git maintenance run --detach >out 2>&1 &&
> > +		test_must_be_empty out
> > +	)
> > +'
> 
> This second test seems to fail racily (or maybe always? see below). In
> CI on Windows, I saw:
> 
>   'out' is not empty, it contains:
>   fc9fea69579f349e3b02e3264cffbef03e4b1852
> 
> That would make sense to me if the detached process still held the
> original stdout/stderr channel open (in which case we'd racily see the
> same line as in the no-detach case). But we do appear to call
> daemonize(), which closes both.
> 
> Curiously, the code in gc.c does this:
> 
>           /* Failure to daemonize is ok, we'll continue in foreground. */
>           if (opts->detach > 0)
>                   daemonize();
> 
> and the only way for daemonize to fail is if NO_POSIX_GOODIES is set.
> Which I'd expect on Windows. But then I'd expect this test to _always_
> fail on Windows. Does it? If so, should it be marked with !MINGW?
> 
> While investigating that, I ran it with --stress locally (on Linux) and
> got some odd (and definitely racy) results. The test itself passes, but
> the "rm -rf repo" in the test_when_finished sometimes fails with:
> 
>   rm: cannot remove 'repo/.git/objects': Directory not empty
> 
> or similar (sometimes it's another directory like 'repo/.git'). My guess
> is that the background process is still running and creating files in
> the repository, racing with rm's call to rmdir().
> 
> Even if we remove the test_when_finished, it would mean that the final
> cleanup after test_done might similarly fail, leaving a crufty trash
> directory. I think to make this robust, we'd need some way of detecting
> when the background process has finished. I don't think we report the
> pid anywhere, and the daemonize() call means it won't even be in the
> same process group. Maybe we could spin looking for the incremental pack
> it will create (and timeout after N seconds)? That feels pretty hacky,
> but I can't think of anything better.

Oh, good catch indeed, I can reproduce this on Linux with `--stress`.

I think we can use the same workaround as we do in t6500, namely open a
new file descriptor, inherit it and then wait for the child process to
close it.

Thanks!

Patrick
