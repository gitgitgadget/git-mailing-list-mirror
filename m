Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4914C7E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883229; cv=none; b=eJHE9CDNSAPpyCuRuP1WU2LBP8etQg525tnFrmLCzP2lk6H4LC6WBKze0xprJyiiKTUYponrKWZMUiisUOQrM3XbdVcFB6YbpUofq5mO+G/HDhJoUCz9i0v7D5DbIINKkfpNHmSAgf3K7TwpxpsBuF/N4ZekyuXwJCpnAFgRHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883229; c=relaxed/simple;
	bh=6jnKq3dUfrlBJOWJf/mYObF9arO5xQQBYZ3va1wZ2/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlJqGPQLKJARRmhNyNRRCrMUPtn0i+6O5avc8yUtzasKGmFiIzVGGMbkjuolHDTIc3mPjC0iLkwz/c/tH10B8XhkVjn0FKi+FgHJoJ/16KFIsn2Ua23djgjdEYMUowEroZCflvzvPBa2IDZaDDh+kSj1MQzsn8bFSRZjkLe5TQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dmd6PW7q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HWiN0N12; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dmd6PW7q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HWiN0N12"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 0287E1380231;
	Mon, 14 Oct 2024 01:20:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 14 Oct 2024 01:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728883224; x=1728969624; bh=1Q4g6X/Y3P
	Njqjt+PJU0PpErriaDviIhj/zP6nUQR4Y=; b=Dmd6PW7qb3yOjJzQL9ECavh9X0
	kXElKT3Wdhhik8bLi8E6/FPwDrRHSFE1XGDxNp/oN+TwQQAtFGsRfl7Abpl/mzzb
	brrYHItb2kd5LfedU11u/rosRNCC7CxropgE1sCx72KCA2CQSTS6hIt3OxFTbsau
	TbwnkSh8g7PK4OlASwAhD2r32SBOKwl8YEOslc28jQcqD6VYecTClLyK+WiIIVz4
	aj7E2ZOS4jIhkNzV6xgNbWAx7Py53P+3H9P9CKGIA3W4wBJUjl2pte+dxLUwncN2
	Y6XRJi2qNnBlA+UZdymFMKY6+y8WuYcRLxQ17spCRVyswO5ivrv7xgE/HH6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728883224; x=1728969624; bh=1Q4g6X/Y3PNjqjt+PJU0PpErriaD
	viIhj/zP6nUQR4Y=; b=HWiN0N122GdFuhvZiSnCI2IankbbUdiI1CVf9+IeI3DC
	J9IaGs6d+/CTwiHAc/qQDW1y6EZt8ew/ytORMs4qbJX/xMzGt8U0WHBLBUpP7ztN
	ED5qIEZpfjFBoOQKTZIn/DL4bmfE0uLobYnT/ZMCsM4DEPi8Y6SRH4Gp2QJLEMW0
	Xr8gHimENi70SAZFja720DUt4dc69/0O1lZRYn1fB7JP9z0rdVyzkwBiu1XGhAP+
	kuQXIeGcRV5Vjs+mzmjuBbQ/+F1b/Jeu8noa+2cgYZiUKlLE4naPBmRGJnMB1a9K
	lf1I8rRXqccz6E7efVR+xdfxzYjg7Qj1cbS5fFYuWg==
X-ME-Sender: <xms:GKoMZ0H_ITSG8rI8vgFoVn-XfG5p7jrFP75LUoG9ZHlEjkBjbVoWpQ>
    <xme:GKoMZ9UwsLPFz1xhvK_fm_G6Tegy1Yk0AG8qSwV9bcUQ3NjcKbYQopi-XVhS5VizZ
    FWwktm0icY4KjwfbA>
X-ME-Received: <xmr:GKoMZ-KAoH8iRJ-_lRLKvcUx0VqL1fe4-0m7Y6-XlFeXTEGxYSg35ToXuWsn4Iy1Jc-Mwi1xR4qS-afLUHqncbwHktr1AhAyjm1FH8Jq0VIK9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeggedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrth
    iisehgvghnthhoohdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GKoMZ2FYXZz02Bje4eTPpI09jWX0WmUA9ZWN-XgmBlcITBS3CWuNsQ>
    <xmx:GKoMZ6WL1URz9lxyUogilP4UsLrCJxM37w-t_YOqQ6-0cy7vupvDLw>
    <xmx:GKoMZ5NPZX3wXm2W2Z2_liBPbk5Ax6crT-8MhRTG52yZEJAz3PNJBw>
    <xmx:GKoMZx2FwrGIQ5H5JsL1Lb99Aj8V9ZluqXlnJ5FV-kSTVJCeWFsToQ>
    <xmx:GKoMZ8crfEyljJ0Uc266RSnmiwwVWHLJFC9PfuuLyflMWZFCxbFkA50B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 01:20:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a5ba407 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 05:19:06 +0000 (UTC)
Date: Mon, 14 Oct 2024 07:20:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v2 24/24] Introduce support for the Meson build system
Message-ID: <ZwyqEPEmZ4gXi02I@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
 <724232b0fad2cbd5602ac1e900fd5dafff666012.1728485139.git.ps@pks.im>
 <e4c99594-08a1-4b5d-b862-bf51efae410e@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c99594-08a1-4b5d-b862-bf51efae410e@gentoo.org>

On Sun, Oct 13, 2024 at 10:07:10PM -0400, Eli Schwartz wrote:
> On 10/9/24 10:57 AM, Patrick Steinhardt wrote:
> > +script_environment = environment()
> > +foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
> > +  program = find_program(tool)
> > +  script_environment.prepend('PATH', fs.parent(program.full_path()))
> > +endforeach
> > +
> > +libgit_sources += custom_target(
> > +  'command-list.h',
> > +  input: 'command-list.txt',
> > +  output: 'command-list.h',
> > +  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
> > +  env: script_environment,
> > +)
> 
> 
> Maybe I am missing something about the necessity of this setting up of
> PATH? Should these programs not already be on PATH -- how does meson
> find them?

It is required when generating the project file in one environment so
that it can be used in another one. E.g. when using MinGW64 to generate
the Visual Studio solution, where the tools are not in PATH anymore.

> > +zlib = dependency('zlib', default_options: ['default_library=static', 'tests=disabled'])
> > +if zlib.type_name() != 'internal' and not compiler.has_function('deflateBound',
> > +  prefix: '#include <zlib.h>',
> > +  dependencies: zlib,
> > +)
> > +  libgit_c_args += '-DNO_DEFLATE_BOUND'
> > +endif
> 
> 
> Probably should have mentioned this earlier on, but.
> 
> What about
> 
> if zlib.version().version_compare('>=1.2.0')
>     libgit_c_args += '-DNO_DEFLATE_BOUND'
> endif
> 
> 
> since that is when that function was added.

Arguably we can also just declare a minimum required zlib version
nowadays. v1.2.0 has been released in 2011, more than a decade ago. But
in any case, your version is certainly cleaner, thanks!

Patrick
