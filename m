Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EC136331
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685076; cv=none; b=AOadS8vXzZK0kW/jYr1GnaXI+3bbkkj1BgtfaTZ97ZKSXmWpedL8isIlo7CqhwgKbbdjDsZ+mmbIGiMDFhSS9ShDxcU4IOw5Eb4yYsoNC0YwlMiIDBN4+kavnsWFP2A+3N7QrKvaszkimRQqhT/A0jLTgVecFIqECKBZOyrHNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685076; c=relaxed/simple;
	bh=vLMV68g0tuHRKGZvVLcdaohH85VEH0j6E34YciZCdns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNyM4XDvFNEWB0BWOXPTk3Makq36suyuhsNK9S0bzyf/S7g9os5469qsI0ohhiYGAYNzLhu1xuVS9CC1Vo8NBgPgPl5I5GjOCWijG6qRKh9+/hTCZrSX7loKqfGP8KAwIekB3GXc+1PbsOPHGbBvcnZNJj/TI7AGwpv6s4fYQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y0fwjdrg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4Rl0cqO; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y0fwjdrg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4Rl0cqO"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 244E311400DE;
	Wed, 23 Oct 2024 08:04:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 23 Oct 2024 08:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729685074;
	 x=1729771474; bh=di+dwlff0rv++alj2UtMDRS0ikjBj1t/4xaRoKLuAVQ=; b=
	y0fwjdrgSGyPFfycgTXzXuWO6bhiyPimeibtZS8Kr6vt1UJAiJ05uPGLBx/pXc1m
	d5jWuYR+C8I6DiWEYcVYdahIEMLSRTWHjLsooGIDJC6EDlWcUOgWNMCYHBNyYBzP
	JDYi6b8fIvqv89TMspVD/+pAxzJWC56D6wta/sqSC4UQUVQ568r9QX1HvWyJURWa
	e3x8tnTmgxGpIrPOp85z4GAmVJzfg80nOqaEy9/Qjutkxj01UdpG9QrCFEBbtWfq
	Gf2JtRPmOb76orAHI+Fv4L488uTmacA82xeBQAMiqpr5aG9bzggIzIsMAf+87nGt
	xLLc3op6vYmAyATGeWSZmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729685074; x=
	1729771474; bh=di+dwlff0rv++alj2UtMDRS0ikjBj1t/4xaRoKLuAVQ=; b=G
	4Rl0cqOk5BzMEdXQEmt+ZVBaLA7NuhK3w/nrhdg4v8mdxWiSWq4J9gdmOMXMGcRE
	H1iaL6MnAeCVfjX/AAspPhJxThcFPw/wXhEE5+bzKrDsuVQdnnkESlaotzSBrNJO
	Q6hBLIUGO3OVyakpnQqvNbm/NYL7P+FIbCr4c3V3/oLbfUbnuMoV5kvHvkdT3kmT
	hrZBSysvFLOZh0cdv9GLsnMTHepbSB83IHU7DKwUxwA36Bbu0whqBzIaHeuBBPJn
	LyKWgD0XmZowDCdzBDxOoHXqVSRjmahotZ5L2gAETvcm5m0sJnJ92i0+pKn589ce
	lCusJjqjERsuvgVzB1NVw==
X-ME-Sender: <xms:UeYYZ2zAUenCQ-DdStd05a1ibw3eRK3Tgt14lkJXtJNoQ59kfwVCmA>
    <xme:UeYYZyQSNh7tX19PUR55pCAcGMgNejl8lCuu1O2W-vnOoDR0n1hu7H9cQcD4WJj41
    GUghgNnO1bvliDRYA>
X-ME-Received: <xmr:UeYYZ4Vp4lk7orz11Zf4Usgxp6e0ERCo2Ch9X7H4NYDXqBCBVRVLNolGAPPA4Px7eZRHJjw2261K6cw5cXzrXKYg79vUtzDo5IrDYwWSFH0e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UeYYZ8jXs5HTO0A-Z6IautCHsmSvqoWGhpRSPvNIbO6KfvjmJVmxvw>
    <xmx:UeYYZ4BUFDbkVxJwgcGz9Orhxeth_acVqo-O1Ty1FCxOkEBABAX0Qw>
    <xmx:UeYYZ9KWebEKiZ-KROXze5utU7KFObB4169ea6V4x3zW0rtxUGknNA>
    <xmx:UeYYZ_B0e2a_zY5inME000t-WxSRQYvujzw_-KUiWMRjJ5SRytrTYg>
    <xmx:UuYYZ60YoD1E5l7E-806WGNCwGll09qsEd0fMElLv_wdsK_2DchCwHAe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 08:04:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd08a840 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 12:03:01 +0000 (UTC)
Date: Wed, 23 Oct 2024 14:04:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Eli Schwartz <eschwartz@gentoo.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxjmTbATU7usHcqQ@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <86de131b-bdea-4c37-b512-68b8378f4343@ramsayjones.plus.com>
 <361e69ee-4491-4e2b-8edc-fdf4bcbb8532@gentoo.org>
 <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b35b6f10-ebb5-4266-ab95-aafb67cfad22@ramsayjones.plus.com>

On Mon, Oct 21, 2024 at 11:56:42PM +0100, Ramsay Jones wrote:
> On 20/10/2024 09:51, Eli Schwartz wrote:
> > On 10/18/24 12:08 PM, Ramsay Jones wrote:
> [snip] 
> > possibly because due to ninja's juggling of pseudo ttys, the python
> > runtime for "meson test" thinks it is *not* running in a tty. I know
> > that ninja messes around with this in counterintuitive ways in general,
> > but I am not sure exactly how that interacts with the console pool. But
> > regardless of the reason -- if it is happening at the python level, then
> > exporting PYTHONUNBUFFERED=1 may help. It's something I've had to do
> > before for programs other than meson, at least.
> 
> Unfortunately, the 'PYTHONUNBUFFERED=1' idea didn't work. In fact nothing
> I have tried on cygwin has worked. For example, if I use meson to run just
> few tests, like so on Linux: 
> 
>   $ meson test --no-rebuild --print-errorlogs 't000*'
>   1/9 t0000-basic             OK              7.52s
>   2/9 t0001-init              OK              1.88s
>   3/9 t0002-gitfile           OK              0.37s
>   4/9 t0003-attributes        OK              1.35s
>   5/9 t0004-unwritable        OK              0.23s
>   6/9 t0005-signals           OK              0.16s
>   7/9 t0006-date              OK              0.73s
>   8/9 t0007-git-var           OK              0.40s
>   9/9 t0008-ignores           OK              3.09s
>   
>   Ok:                 9   
>   Expected Fail:      0   
>   Fail:               0   
>   Unexpected Pass:    0   
>   Skipped:            0   
>   Timeout:            0   
>   
>   Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
>   $ 
> 
> On cygwin it looks like:
>   
>   $ meson test --no-rebuild --print-errorlogs 't000*'
>   1/9 t0002-gitfile           OK             12.32s
>   [2-4/9] 🌖 t0003-attributes                12s
> 
> Which actually looks nothing like what actually happens! The first line
> is actually the result of (*maybe*) running all 9 tests, but during that
> time the line started with '[1-4/9] ...' and they didn't run in sequence
> but jumped around ending with t0002. Then on the second line, it almost
> immediately hung, again with python hovering up all the cpu cycles. So
> I had to kill the task from a second terminal.
> 
> Actually, I tell a lie, I did get a single test to work on cygwin:
> 
>   $ meson test --no-rebuild --print-errorlogs 't0001*'
>   1/1 t0001-init        OK             32.95s
>   
>   Ok:                 1   
>   Expected Fail:      0   
>   Fail:               0   
>   Unexpected Pass:    0   
>   Skipped:            0   
>   Timeout:            0   
>   
>   Full log written to /home/ramsay/git/build/meson-logs/testlog.txt
>   $ 
> 
> Notice that this took much longer, at 32.95s, than (what looked like) all
> nine tests above at 12.32s. (although via 'make test' t0000-basic.sh alone
> took 124.13s for v2.47.0!).
> 
> Patrick, how do you run the tests on cygwin?

I didn't have to do anything special here, so this is quite puzzling. In
a fully-updated Cygwin installation:

    $ which meson
    /usr/bin/meson
    $ meson --version
    1.3.2
    $ python --version
    3.9.16
    $ mkdir build
    $ meson setup ..
    ... autoconfiguration logs ...
    $ meson test 't000*'
    ninja: Entering directory `/home/Patrick Steinhardt/git/build'
    [582/582] Linking target git-receive-pack.exe
    1/9 t0005-signals           OK              4.17s
    2/9 t0004-unwritable        OK              4.58s
    3/9 t0002-gitfile           OK              6.95s
    4/9 t0007-git-var           OK              8.15s
    5/9 t0006-date              OK             15.42s
    6/9 t0003-attributes        OK             26.84s
    7/9 t0001-init              OK             29.09s
    8/9 t0008-ignores           OK             57.17s
    9/9 t0000-basic             OK             83.82s

    Ok:                 9
    Expected Fail:      0
    Fail:               0
    Unexpected Pass:    0
    Skipped:            0
    Timeout:            0

    Full log written to /home/Patrick Steinhardt/git/build/meson-logs/testlog.txt

This is starting with a fresh repo, I executed `git clean -dfx`
beforehand.

Do any of the versions used maybe differ?

Patrick
