Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA091B1D65
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722628; cv=none; b=O6JfFeQGTguIsOpoywkqOwaxnu9h7qiKmudFYHtgC+OxZoXaSD73jmaw3dAski9nhI8GeW7I5gekqCfP0ytF6ypNyPgj2Bz2nsmbBEWBQQdAcMBzUXSz9WTYcZleNfE+waQVlfrmQtmCO177kH/gMoXRij9YRvfYaYivHOUt//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722628; c=relaxed/simple;
	bh=u8kvRUIMVLMllOU1SWuF43yrqmZC4ALzgQ0EaCT2pjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbJu+BxDRiJLa6q3c6ccahAhj7DCJoeiv4L5tDAHuQVqc0b5l/QwXAhpUm3kCEc5GRVJ7RtMke08Q1Xw463z3RBkobfmyGaitl4ph7yG7Bf+tAg7f2ImNsEQnuyv9HvvDLwxuLrCcxwzMz73BprtdeO4jrr7pRdfT45QF9qgxso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ODZ8dLt3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9DipTuU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ODZ8dLt3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9DipTuU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E74391140145;
	Mon,  4 Nov 2024 07:17:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 07:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730722624; x=1730809024; bh=fqxB20HvqA
	kFw0ati+NPgtAbqLywS8b5WHffL1A5uMU=; b=ODZ8dLt38FNDe9Tj3pndARwGQ7
	VZwwmFE5Q1hn+6PJORUdS3OV/1O2vFtwTbFjFLR1FRuJS/BD802FNj9W3euCVjNI
	WWsRRryrQEUpb+QKq1cnptrTnLdCmE4WNIEivjpj+TGoQm6qeIt7gr4Ty/L2CnGZ
	W2H0ZOCySKMZZDbaTLmtQXBN4+28Hp8zWMHqWnJUGAhDrjLQTuDS5fYWGjdPJCw1
	wsAYq4rWTBCvv4ktftsr9D/EZFkpZ/FVm1KPBhJzejyjTTFBmrodYBhy1byYTN5Q
	RojwHw6Ldf1RbXzvZejdPmWorhAOvLHg17Deij91pmI3jhfs/Fvfhs5oeMBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730722624; x=1730809024; bh=fqxB20HvqAkFw0ati+NPgtAbqLywS8b5WHf
	fL1A5uMU=; b=j9DipTuUGarQmADfrY/Y9cWj93ZP6Foc+3WZ7l9dInIT6dhIrk8
	w3+GQPv1ndv1GXTVBAgwl3XNTsC8oBftrmbFrpp+U2PyqR2uG89VC7m52NWi7LbK
	E8Cbk4xXuIq0W96lVlU+/uhl61Lo+eV8g2LZzm4pPmQgWyOexRNbYxT22evraM1i
	ctBefW4ILjZRM5Jc/Qxyk1ZSw9AMMWbQvdD2xpoWUT+LAabn9/lF+3ma07Xe5Zcj
	0gQwQ3g9v4UM3B9ADmYZHcOA6ts3DB4IramlaOXmkAuL8egYl8smVSH0b5LZW/ue
	+wdmFgAyeH2hGtGAewv9H8Ro8a9zwOZ035Q==
X-ME-Sender: <xms:QLsoZ2tIQFJEj3wUwkP6aJN6bzqQWzXSaCk4hev9QGPpH9JHg4eyrg>
    <xme:QLsoZ7cTCZuU0rbdUvkg3EkuK5qC2sxqz4MksD9CNnram4bTJ_cnGf9EnvRxIoyGi
    ph6npFoV0NT_w5KSg>
X-ME-Received: <xmr:QLsoZxwnqAB7-7PWEoaNDqZV2NKLDWotWxXQ06hGaYkycJvNjDA1xngP6Ii69kcHFZJ52aXKfzIsD7SqxZuwFaiCBL8t-Cg8wGBjdEmkdmGzcRNhIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:QLsoZxM7b_W1Pr9Hgy63RqCqjNQ9fWuOiTyFdx4O9uP-MDkG_QHQtg>
    <xmx:QLsoZ2_9NptZfT3G9C9somrEa2MpTjMfMIdYt2JAJtfuxMb2bHZ_2Q>
    <xmx:QLsoZ5U-VuOEUwuWJuZz2zLAYjQ0ZmYDhkifKrShbhyd674s1CEayA>
    <xmx:QLsoZ_cU7KGOXypC7NsmSOu9CckjlpSNJ9WKssWJ8f4fXYAg8EkGDg>
    <xmx:QLsoZ7P5yvDHfm3-M7t6ETVNlQ6I5OXaC0TG1TJoT8BUbvHh190LHdkU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 07:17:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12e38cfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Nov 2024 12:16:42 +0000 (UTC)
Date: Mon, 4 Nov 2024 13:16:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <Zyi7N5sb4rrg7U2k@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <bd6fe5c4-9c4c-4399-b44d-a57560c04d3e@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6fe5c4-9c4c-4399-b44d-a57560c04d3e@ramsayjones.plus.com>

On Mon, Oct 28, 2024 at 09:34:25PM +0000, Ramsay Jones wrote:
> 
> 
> On 24/10/2024 13:39, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this is the fourth version of my patch series that modernizes our build
> > system. It refactors various parts of it to make it possible to perform
> > out-of-tree builds in theory and then wires up Meson.
> 
> As Promised, I have tested this version on Linux and Cygwin (not full test
> on patches 1-18). When built on top of fd3785337b (The third batch) with
> the two branches merged (as indicated below) Linux (build+test) and cygwin
> (just build) work as expected.

Thanks!

> >   - I've dropped the target names for `custom_target()` invocations.
> >     Those are auto-derived from the first output anyway, so they only
> >     add unnecessary noise.
> > 
> >   - The last patch is a compatibility patch for "seen". There are a
> >     couple of topics that interact with this series, and I didn't want
> >     to make all of them a strict dependency. So I've decided to just
> >     create a fixup-style commit that does the necessary changes in order
> >     to work with "seen". Like this, you can test without "seen" by
> >     simply dropping that last commit, and you can test with "seen" by
> >     merging it into this topic.
> 
> I couldn't try this patch because (at the time) the 'seen' branch
> didn't build. :(

Okay. I'll adapt the next version accordingly.

> On cygwin, the result looks like:
> 
>   $ tail -11 meson-logs/testlog.txt
>   Summary of Failures:
>   
>     23/1035 t-reftable-stack                               TIMEOUT        30.26s   killed by signal 15 SIGTERM
>    114/1035 t1017-cat-file-remote-object-info              FAIL            0.13s   exit status 127
>   
>   Ok:                 1033
>   Expected Fail:      0   
>   Fail:               1   
>   Unexpected Pass:    0   
>   Skipped:            0   
>   Timeout:            1   
>   $ 
> 
> The t-reftable-stack unit test took just over 75s on the v2.27.0 test run.
> I haven't looked into it yet, but plenty of other tests run for longer than
> the 30s, so I don't know why that test seems to be different.

Meson has a default timeout of 30 seconds for tests. I only removed that
timeout for our shell scripts, but didn't for the unit tests. I'll fix
that in the next version.

> Also, it is worth noting that the test ran for 2hr50min. Usually I have to
> wait 6hr approx. for 'make test' to finish because I don't like to use any
> '-j' parameters (You can't do anything else on the machine while it is
> cooking the cpu!). :)

You probably know, but you can of course also pick the number of CPU
cores to run tests on with Meson: `meson test -j1`.

Patrick
