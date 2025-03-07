Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7521ABAC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357254; cv=none; b=jL3Fq6dniHjrRIGIMS2XH05OCLHkhJ/mDPRHTtjkDGFnwX5ZjscGuXIvunwoBuokKeejliwjBRb1H7C4yy0DKoSFR7fJsRyqXRRvx14wf9igbRRyaSWRzrBNK12AG2G0c1mKcxWda5hv/JXA7vmX9/TmjO98M6e2w016kIbzo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357254; c=relaxed/simple;
	bh=ukd11u7pvGHaygJPxyPzILyU7Lj82GuXdI318atfRhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SITIg+D25RgZVyA4vWcdMht9fMiWlfWaeis9jJ/A28HmbtVMb0AD4bpmnmogjefK+b2ojIfVr/zSrBwhGbhkM55CUvsbkUNcBOqfe8pkqdfNj108Hg/1q+lywnqv36WQCs5mMpJsgIIwy/7eDec5XzV103lAPgwbdI00Q0hboE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NAoO2sdz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=58k5JOqC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NAoO2sdz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="58k5JOqC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C355125401A9;
	Fri,  7 Mar 2025 09:20:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Mar 2025 09:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741357251; x=1741443651; bh=StL4VzqJJ+
	jNuLAkbYlDk0gJ+8dMV11aWmBY2OAnp4A=; b=NAoO2sdzdGSh0TsC53ahBWpA0K
	QnAOMArJXX4Zh1RYWwT1qmVOax0mV6wodwFg0nTvK2/IKDtVnJyVdI+1DbD+vunl
	rqi3MAep2h7lCFsbJBLlEg/7M1jksdbHrgN+5gFlnFLZ7XH7KRnnbcsooSVWHeGP
	Yv4AUB6VnpcFz7By+HJmQVbNaLqJ6TaHLhCy/5OdtxPJ2P/Iv0JBnyZHzicjoP6y
	L8BOwNDHwhbyPmmM1aoKAs+rmVcrGPs0Dxfk3Z0K2YVYnDbcYmFZ/IA1/OA+2NXK
	8PxmzTY6m0qQFbtKaeZGBtHrrYBy2o6/QjqV7Cl3yoyCGyNvnumVj6XL7gRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741357251; x=1741443651; bh=StL4VzqJJ+jNuLAkbYlDk0gJ+8dMV11aWmB
	Y2OAnp4A=; b=58k5JOqCqB+TukEVPR3xV2yVJQ5MH6WMybnsQpepFh0rfo3b+as
	6RS9BvoOuYyt4/eYhBr7/1QDvVVyTp9ZN7COosBWTQPJGA5G0UJlAhEAww1vzt8F
	bW7xd8dLbBOvySSP8Ot26CWADmXnUW37GRvh9r8ZAqZ7SWJXmW7sDbr6RnFb0e+p
	uKJMGhDxOiNTeQLng8AN8XTXtaswfIG+jSFfEZ3uQa4tEMbHmLYvCkzw1bpTZORr
	Q7GoOCzQrKFI2gbOGEzu8whRHfA9iK2llSTRUtjxsDhtDn8adfB1rklRdPSYCmVM
	8cFxWU7syFsGHDTci7LMN1ErfxMdmup84HA==
X-ME-Sender: <xms:wwDLZ90GGMRvJ5POoMljXfGyP1Ae7kQK6cK9yhLaGF870kuxq-Culg>
    <xme:wwDLZ0GWF1bBNS5Z8pKfEPJ-pt-S7QPyJYjdbMZ3D6Vj0QZUQPCeZb-qUZ1dvoguJ
    E7QU3bEy5cPnf0DkQ>
X-ME-Received: <xmr:wwDLZ963VbJvU3761aHxlmUv7HdVEYT9QpTe8Q5HK_DpLFlY8uJsuucOE_ChedyNm_QCDTJ5nzMrlmmr3bvLYexWl3RPN2aA3CHtXFC2Yebb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wwDLZ60pPDsaqrnWqfV9yocCVQPnMT8D1WHpIE50DODRQ1xVHVFl6Q>
    <xmx:wwDLZwHxzvOzE8Og-tjwOtCYL937UnBCECN-Dr9z6OctEVnv268_ag>
    <xmx:wwDLZ78fdkeayjSbhsmk9tQCo1A9GCbZf9yPe_pbR0UfA6PjovAXCw>
    <xmx:wwDLZ9mvguYc85gZpdXhmXtNmSF2ox8B_3PTEcRsUaWUAhPMUqTyHg>
    <xmx:wwDLZ1S9TCYV-A2PSShbwnsGeM9HZvEvc2gatcVxJB1jXh-JbceKkjsq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:20:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b280f956 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:20:49 +0000 (UTC)
Date: Fri, 7 Mar 2025 15:20:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Ensure zlib version is printed by git-version(1)
Message-ID: <Z8sAwLHff3S4jF1P@pks.im>
References: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-toon-zlib-git-version-v1-0-5e8069752bb9@iotcl.com>

On Fri, Mar 07, 2025 at 03:18:06PM +0100, Toon Claes wrote:
> I was trying to benchmark the difference between using zlib and zlib-ng.
> To be sure I was testing the correct version, I was interested if
> git-version(1) would tell which zlib library it uses. After some digging
> I saw it should be printing the zlib version number, but on my machine
> it wasn't.
> 
> I discovered a regression caused by 41f1a8435a (git-compat-util: move
> include of "compat/zlib.h" into "git-zlib.h", 2025-01-28). In the first
> commit I'm addressing that regression.
> 
> But I've noticed building against zlib-ng directly still didn't print
> the zlib version. This issue is resolved in the second commit.

I've already reviewed the change internally and it looked obviously good
to me. Thanks for finding, fixing and improving this!

Patrick
