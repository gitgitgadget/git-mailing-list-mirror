Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15C1DDC07
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307094; cv=none; b=E4ujRLdgYJ7vMVvM252/bEkaYlVrju5unGLdCYSZH8QsOiz632vH6MNjidUsDRC0pdFXo2+zNoLMvnL/7Z/4jNBaGiFNQCrtG9d1r+pTASTQ6r810q/lmP9qWboJNTXgUhzwsLKyrKckngPE/ulRHynGegOmSPioD5H+WfVgNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307094; c=relaxed/simple;
	bh=Re3/fgbPk37gl916szsL2z//yrtSqt/IkNx51O4sLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4jIDhWYBGzNh0S1AKaeiCAk0NassswKExb9z/3U50ihxBJruk3SHn5XwfR//svSjrJOqwsslxgnf7tBmtM9quHDiJw0rQneYB4PMvy2OZe90HdtMisFusBQ01eDOFZyd3FZ8JzOX7RTdWJ1SkVFsUZGuDJZETwX2xB8wwypkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J1roQUdt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=trfaKhpL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J1roQUdt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="trfaKhpL"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 95A2B25401B0;
	Tue, 22 Apr 2025 03:31:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 03:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745307091; x=1745393491; bh=3ThWadb5Yh
	252e54C35N1TLzK7awsi1ATjZA30m7F2s=; b=J1roQUdts5CzdYlqXEI8IpfhV0
	W1/fsxwuW9Ouypft53xUf+rp731aKiJk5dR16K0S2ECAmVubVgt5dqQ0iUr44PCL
	L1s5Iy+2nq+LV44gcfx/H7Qw53TCiL97gikNcI5rFPIg6ibdO3TQdYA93Zo1izfU
	Bcj/bp8T59EluCdmwy82kgr8zdkTRwCauln5f2gBzL0b5T/qsBIlmYb0qZ1tg90d
	RCa7g/Pdg4oWK3tC+A002DMCKb9nVU5tMNM6JQ67/azCHb3jImhn8OetsHgm6Wgf
	NC5/NTuXgOHxGI4LcgyKIqPkO7XGpb2InwQp1oWxQnEO2+rtUkxna5gYhEFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745307091; x=1745393491; bh=3ThWadb5Yh252e54C35N1TLzK7awsi1ATjZ
	A30m7F2s=; b=trfaKhpL/UBubnkNeok51ewocqRqAckds1ohIjqQnPDk1SwMRdk
	AGt9p5hnFXr5rGjK5j120awWd+rXdKpnrJE3LhDFZHNAo248KHfb5Pjcvl3yr5Hc
	ImsX0LK2wDJa2SqIauxZ7vhltKby4vVoQhkOHRFIwd94mOyiBNLCr0fUsW/AsnMo
	VK/apMgvOUxFig/EE++JDs2HlSKf+6R+BA+AHV3ZzRSZdU6pwufOW0GTi6wy5FVC
	Dd5KuVMgNUFbjJ05f3Bhl+8THd6thbTdkyEKYNmNI6m84SBxo5B9HCkPzOjpaLpp
	a44oCjKLh2o7y8oUQI8YtX2O/2xiZ12mNsQ==
X-ME-Sender: <xms:00UHaGMDMCSAb7s2aT4Kx866s8iYUl0lkKna8HFWVnxjWfVZEFAxgQ>
    <xme:00UHaE9_tsz7jESe3PF7xe9NP_kxyfVA2j5njR7otW1HpjBNWXbstiqoeEoctzTHw
    AxfEdEf0QGaNj5C8Q>
X-ME-Received: <xmr:00UHaNSGSfYbbdHQpRqmlCCSY2HbNyJS9N261B0LEGoc0CJuqC7D5B6_nMMbNb2ryRQ80VmwIMWF05Y63sHXb0mz41QId68nU_ns9H-0dEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:00UHaGtMxFT_fDzqkF8BfofAbFwaEWTIbta2aJ5Gb5TNsEJb5X6P7Q>
    <xmx:00UHaOdvJO3jUx5k8s-3mqrECNoz6eOWod1hb0DFlKLlTVOUvleO6g>
    <xmx:00UHaK3L57BaKaLgsgMz5csRV_tAhdA902S_TxQk0itR5LiZo9_l7A>
    <xmx:00UHaC-4yM9PW5cA2ELuAtEhRRNPpBCMEP8z6chwe3WuuzwXVZrJig>
    <xmx:00UHaFBJ_MZeVkHD2j3a5Fe1aMDnAqujn5SLMTnm0ZLBy0BB4hzBS4B0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 03:31:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e251fdb8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 07:31:30 +0000 (UTC)
Date: Tue, 22 Apr 2025 09:31:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 2/6] meson: check for getpagesize before using it
Message-ID: <aAdF0XH2evrJ4ZQL@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-2-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421175247.240971-2-eschwartz@gentoo.org>

On Mon, Apr 21, 2025 at 01:51:46PM -0400, Eli Schwartz wrote:
> It is deprecated and removed in SUS v3 / POSIX 2001, so various systems
> may not include it. Solaris, in particular, carefully refrains from
> defining it except inside of a maze of `#ifdef` to make sure you have
> kept your nose clean and only used it in code that *targets* SUS v2 or
> earlier.
> 
> config.mak.uname defines this automatically, though only for QNX.

Ah, interesting. I mostly went by our autoconf infrastructure when
converting the checks, which didn't have a check for `getpagesize()`
either. We might want to teach autoconf to check for this function while
at it.

In all honesty though, I rather hope that we're soon in a state where we
can just drop autoconf altogether in favor of Meson. The only two
blockers I'm aware of are wiring up git-gui and gitk. The former project
has already been adapted upstream, the latter is still in review. But
once those have landed, we should be ready to mark Meson as stable and
then we can start deprecating autoconf unless there are good reasons not
to do so.

Patrick
