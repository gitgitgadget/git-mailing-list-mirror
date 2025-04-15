Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483151C6FF6
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711302; cv=none; b=ok608/O50mDYgpqUHi/6uS2uwppI3tnVWEsW651zlVHEw2zTnH9S+/uJmAg0hdelUygN5URs8DpcpdBI91cH9xNyh4WNztl5/XCrIFcMzoOrf6VWtiWjKZm8GhrVuutLdOsNH+VhMcSvhAOnDRkL+bebN5oH1N07myD+4JTVqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711302; c=relaxed/simple;
	bh=LLkH96RJTspGO5W34M85ddDY/K9/s3fOiZyEiz35ASg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiD/fwK/GFz3al1DIfq9vI3dXLFMvrWv+0wYN9Oe/vWpYCz1ui4T+tggbUCZCjE87jmJXJib4+UH6hNz8cBBk+NAFCIUkQ+f3ZYZuuPWfmvLvMughcJcwj1YeQ30UHwtRmV9CVC5dDGh92iJlXR//6H/z01BqxUdsFjpKp13/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZVXL8aFZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FixRD26Y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZVXL8aFZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FixRD26Y"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 59BF4254027C;
	Tue, 15 Apr 2025 06:01:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 06:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744711300; x=1744797700; bh=zWb3ZR28OE
	Mpnog+IXZCWcJFQeX2OX9DQw0f5zhOF1E=; b=ZVXL8aFZJ69kMGf3/ckUR1NR6d
	/oB3FI1uNZtCaRsi5fWKwEsld/xNp6HWB+dNkD54oXuBzPFr3PFe9+3lQ6t5TimS
	+8HqROs4JjUFklgXGay1E7TGNJ9tuIuuKgBpMrt1Y7+Fl3UaoFq2JycZ5Ke7kM6b
	zb+L5N7gpOD4isIsDvGVPqQSmw3FErQnFuC2IkyW1Uy42lAUNmsvEQ6484L5c/hs
	PLsXHjO9A85VAarKV31sZjk9VQNPaIQGkmyekxQ74J1TLE24LTT4pI6VECJV+VlC
	bBPUJ5F+igTmoYBlY7OWvWY5weXwAN1atT0+LqBGqEx/HYQXZSOBTByHxAaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744711300; x=1744797700; bh=zWb3ZR28OEMpnog+IXZCWcJFQeX2OX9DQw0
	f5zhOF1E=; b=FixRD26Y+5D7zi/hfIuOc1A9P/CbNwQLHJhuK/ntQcYh030C3Ir
	3fSW6FPg1GCxICFdmHHVGSEakkl8xLjnDitDLtiumWoCoPAtzuqDrcrGK6S3Sqb6
	NLEFaYmOtIRPNI7kEDDa9edgc104kJjpx5TAX0Il0TR/pfwixrMgbXeZRsSuktuk
	gG4Ek3ebro++t5MOhJo0vvB/hkdTxBu6A9mkKr2ymVVYrN/mU3UXPM6HIQyuavTT
	TRdjK8eYBV6BPj6awH7tHACg/1lllBwjV7QSW4cvHIZ+oimGXL2EYpVkj8gQ71rf
	UA6fqSpB6+DaOfUfUV36sgj8EgD1NbNGQpw==
X-ME-Sender: <xms:gy7-Z8kePT83mhxedEVi8UuKY-XW2dx2LfKqL-xgQQ6fqJkU6HmNDw>
    <xme:gy7-Z73N8M1_Ky19hdyapiHrQJSlTPQD97ZhvyeBfoM5EdYyPmOMeFP63KfVrKyqD
    Ub_BQ8vCGCwuwzlCg>
X-ME-Received: <xmr:gy7-Z6q_-4-8mIZv465uLpnZcVNfk1QDlb1NohFRjHOgY6OR9UwDpaUtzJNDJlO1MmknFuGI6M61VdTaG-GFhZvbofZ2zsYXLyUBUXYcQYzprA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gy7-Z4nD_t34PL9aDSpQY4VM03AdDQhTT6q28dH6O3erbNnDvadbcA>
    <xmx:gy7-Z60btrUAvr_7ZyAte-t2l93MC4pL8agSW-DFJf2KfWolxJzmQw>
    <xmx:gy7-Z_vSyQXwDzmxky3O1-kaQEeWULyeMAiu4p6yl3GQ9Hnit8ZSdw>
    <xmx:gy7-Z2XofWb7noAME8uT0E5BFrnTFQ1SOtOObhFuW4cyMR3mmq1aZA>
    <xmx:hC7-ZzK5IGKrB2F2smbrAXeXcFEvonppJqj6MIg4syqQDBV-h7YHQ9gN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 06:01:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4a5a963 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 10:01:37 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:01:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/5] t/perf: use configured PERL_PATH
Message-ID: <Z_4ugEF1iKC5U7Ry@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250331-pks-meson-benchmarks-v1-2-b2ace85616a3@pks.im>
 <87semgdyxb.fsf@iotcl.com>
 <Z_ywLLN5xj6cYFN9@pks.im>
 <xmqq5xj6r1mf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xj6r1mf.fsf@gitster.g>

On Mon, Apr 14, 2025 at 12:20:40PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > Use "PERL_PATH" to execute Perl scripts, which makes them work on more
> >> > esoteric systems like NixOS.
> >> 
> >> I see in `t/perf/README` there's a mention of running `./aggregate.perl`
> >> directly? Shall we inform the user to run that through their Perl as
> >> well?
> >> 
> >> -    $ ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
> >> +    $ perl ./aggregate.perl . /path/to/other/git ./p0001-rev-list.sh
> 
> Good.
> 
> >> 
> >> Or do we expect users to know what they are doing when they don't have
> >> Perl installed at /usr/bin/perl?
> >
> > Another solution could be to switch the shebang to `#!/usr/bin/env
> > perl`. We also do this for "t/chainlint.pl".
> 
> When you do not have perl installed anywhere, how does this fail?  I
> think you would get
> 
>     $ ./aggregate.perl ...
>     /usr/bin/env: 'perl': No such file or directory
> 
> and compared to that, 
> 
>     $ perl ./aggregate.perl ...
>     bash: perl: command not found
> 
> I think it makes it slightly more obvious to those who lack perl on
> their $PATH what is going wrong to explicitly tell them to run
> "perl" like Toon's suggestion above (primarily because use of
> /usr/bin/env is not obvious to those who are told to run
> ./aggregate.perl script).

The counterargument is that `#!/usr/bin/env perl` works on systems where
Perl is in PATH, but in a non-standard location. So isn't it preferable
to make things Just Work(TM) on such systems instead of giving slightly
better error messages on systems where it wouldn't work anyway because
Perl is not available? I certainly think so, but if you or others feel
strongly I'll adapt.

Patrick
