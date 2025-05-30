Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5E2288C0
	for <git@vger.kernel.org>; Fri, 30 May 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615199; cv=none; b=dIzZtg8ChG0N3DfYM2r4CaJJvq1XF/ChEj3IE6plSTiz3PKaaEfuznO3o0svlbEyubdvdQHaVg75C4IFivpHOwG9ISiwrsTOxVAj/L7/PEQK/nfnhhdJe6qaqlaIhWDUjPrGJEa9cUHFPXQzOIuanA97z7qfY9d6hNn/aqVCZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615199; c=relaxed/simple;
	bh=4ml8S0rL0uSwFzY/hNwVYX+kp0qpeEmj+iOxJ3prO0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPSVgInV/MZoVdch/P5H/p2pgQOoheQDAvV4QMgVB0PAcm7W/6HQMhMSLN3cPTxx5L6q1uqlIXr/pFtDCevFBeD99AY5R93lF1gEh8N8BY4k7NuYTPWikTl8a8pweeJokKsm5StB5zwc9G+ylCZhaBfadFjkXzXCsIWMZnYQN0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EGAdw+2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRmPTqn0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EGAdw+2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRmPTqn0"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 258B61380131;
	Fri, 30 May 2025 10:26:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 30 May 2025 10:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748615197; x=1748701597; bh=Sp7nVb3oU5
	OtUsBrGYAxMKubTb7SlxclTBl8p0YTAI4=; b=EGAdw+2tNG6sDQDJrnBsQaBVp8
	5giEFjIOwv+8DZtl5gz204D99XTBnkWxPwe1aX8P0DRpkLxKpgcvsFc7JVOtIafi
	3t6FiETxrjo9AWGpMp2MUao+Yw7Oh3idSuAiYtRc5J/pxjcQUvxqg7La6am2pPKN
	G+KP4DnjfUulp090tFK+D36dfOsGUK311oXyY54+hdwfJmeJNooosNH5RQdwu34U
	lkfr+iKiJmcicGzXg398nC1VTXxduYo/bBqg6kbifpuZLkN/ArkaVSrWlVeSp0ZW
	vcoRu5BjzA+xM0LSHNv8qvtUjtrY62lx3ReIUekKy+rEor+mXMlnsufaaZCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748615197; x=1748701597; bh=Sp7nVb3oU5OtUsBrGYAxMKubTb7SlxclTBl
	8p0YTAI4=; b=gRmPTqn0UQ1NGAktOUUWrya5mBzYwwayrILDfBXYroCHcTjXy7H
	wKxgGq/RTmBk9P/TpKFYOzNBPyPRPtWXN/YcdLsCZ1N0GBDLEBBEDonUSVdZTVQf
	ZCGHrfcADYWDl3JyBdLaRv7WooXLdKTaWoekOeSvpZt9kRKoJh7NI8TwapjsVfof
	v43V2kUkrB4z8RtCi4wigq68TN4yGxBww/8rNd50LfjcdSpIKzyrKN/D3YFvbenk
	/Y+AZLPfgQefHdh+anxNGOVN/NQTlYs/bCwgasSfEA/V5oI7erZUtq8uWnUn94wN
	mDS/gFSGPdodrb7o/wq66zIBvMv7SdC/k8g==
X-ME-Sender: <xms:HMA5aP-L_mOQLIE3DLfb0dxNGkP25aOt5NQ9YxPEeGmwJXr74UbGYw>
    <xme:HMA5aLvRMr5jAxCn6a9i7s22kdIjqmtLL_EdWXhGZyaixnewtcP6IykfYqgR4sDGv
    CKOUa6Ad3gGsVHa9w>
X-ME-Received: <xmr:HMA5aNCm1R0VkjSvUZET-kBMvBJb2mtbeoUzDw9IctE5P4Z9ruKi6II-A5gOCHMQmi1sJTiAeK6f9Dt-nsg0PyLC1mAJ5wS1VwHhdRew6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:HMA5aLdSehTYgsq3aEO2HCfjnfufHuFoVYdLl-UDGiHaYch-O-XiPw>
    <xmx:HMA5aENmXc171T_ajPWNvG6Yuxbm0sTJcyo4WaE3hu3puVX97huirw>
    <xmx:HMA5aNlYTzsyVcfpe43_chIlpckWEC-grJgj4QiewEax900aU0FB4w>
    <xmx:HMA5aOtbRRNTI_i38DWIvb0VDG2nook4US0DadFlPyDGeBVePbP8Ow>
    <xmx:HcA5aJdginO6u_n32NWFwjo4eNp_ylLD_D26JsdGtwxSWtPdRx5UMxyi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 10:26:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ab78d41 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 14:26:35 +0000 (UTC)
Date: Fri, 30 May 2025 16:26:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [Bug] Build Failure: Git 2.50.0-rc0 on NonStop
Message-ID: <aDnAGra6dsfubSHF@pks.im>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
 <055d01dbd15b$14d4c880$3e7e5980$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055d01dbd15b$14d4c880$3e7e5980$@nexbridge.com>

On Fri, May 30, 2025 at 08:04:47AM -0400, rsbecker@nexbridge.com wrote:
> On May 28, 2025 2:59 PM, I wrote:
> >To: git@vger.kernel.org
> >I encountered the following failure of rc0:
> >
> >static void file_release_data(void *b REFTABLE_UNUSED, struct
> >reftable_block_data *dest REFTABLE_UNUSED)
> >                                        ^
> >"/home/jenkinsbuild/.jenkins/workspace/Git_Pipeline/reftable/blocksource.c"
> ,
> >line 105: error(112):  expected a ")"
> >
> >
> >I am not at all sure why this is failing at this point. Compiler is c99.
> 
> Looking for help on resolving this before rc1.

Did you maybe miss the proposed patch at [1]? That should fix your
issue.

Patrick

[1]: <20250529101136.16219-1-carenas@gmail.com>
