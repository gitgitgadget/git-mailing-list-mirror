Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF626E14D
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407534; cv=none; b=DcwqyTj8p3BlN/E5jcHSiVRZGkuBAYvsqf20GIwRsMqBiYAXnCJpeVUJNzVPOH8qe7GjmAqOJD37drD9LilyWx3oPo4NCsS95uVRlbw0VNTHpwIuFeTJj/lWA1jrmO6GKl4+f60q4hY6O/GgLkhL05z9mfHJsCpVzYkgKVRqyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407534; c=relaxed/simple;
	bh=JWNlM5o2XSzojxB3hGVV4gKLa2Gp2Jj3+OKWMO2XlRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB2q+UK4oATyEujbj7vHIMyxoomrKf7cx/S//R37Hqnmv2FNEpjGaBo2rJNT4SAUWdjXztIVz/+vKfozWapVPQWf5+DhAN81ES+AGztS+uLF/Ox08zqN1D15eTKo0sKZnb3rUjQw0TzFSaYSVZxiHY2M2ElWmP/+pp8b0YzGhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PPI6NDTx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DrMStqVE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PPI6NDTx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrMStqVE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E2E613803F5;
	Wed, 23 Apr 2025 07:25:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Apr 2025 07:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745407530; x=1745493930; bh=r2AQdGugyV
	RH90zz8DEG2AriT5+RuOPCfPujm0cqkew=; b=PPI6NDTx5175uik/2aAdwj7WN1
	2zV9iFDy7001vbUopS8/UoiAXTHh9kVlqEn7yIoRdH0zCWFfCm6FFxnBJspzdG/b
	l6xLBpk9ejmf2jLTejtVubAESQzC81EtT9Tcr6Pu/s1NffnfTHWaouCUpd425w/h
	hMU94U1yO42njmsEA772tMdKD1Rgi7I1L1LpZEXamBJmiK3L3uwGRnraj9tqA2WI
	h46zBiNbX2ZTFr+innUMYU81ZMU6H8vyFUHMN6/abjcuh3z3kraRbks+vZoPIi9P
	JkrA2/UQIpECXvAtLTJb+yaGssw/gVoMUNpaGn91jofTc3esy5nODYltQA9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745407530; x=1745493930; bh=r2AQdGugyVRH90zz8DEG2AriT5+RuOPCfPu
	jm0cqkew=; b=DrMStqVEbnAEokLZ+k33gftc2Bpa9pogZE32poMakNSpzYsNFt+
	E4tPrgWhcjFekQ3Q7FAcm+SXsQuUo2DRY93PtAUcMGLmhLaImSRbeqW2bnjGmZ5c
	ER6cYt55kiOEXue5aGfSx7MqyyGIbGzSnilq0wyGssLLSDcxmaPzdYIztJysD3Xa
	n8owHWN7wp3FN2vQTOWAGdrVrElMGZpfOhoLUyrAZljbCrGM6TY/GKELWyu1HWbv
	o3rCrV0Z9W2cmuEu+eG5GKtsq3+4j0n/mLWtf+uDs9orn3YaTaYCGsXYu2SQczUw
	fQlAx2ZqN1kYKKDJ85LZooPsBcAfh8JXu0Q==
X-ME-Sender: <xms:Ks4IaIpMOSLOPAQh33m5qXdlhcmpDRp5qLsRs8bA-0L1HYji5c5e9w>
    <xme:Ks4IaOquV5Ci4qmYpdaWNNgOj2xQDQCi78j2XR0RLSWafSTx8qS8jgYXs6ORaxRlj
    KerucF0ePqFM8Yirw>
X-ME-Received: <xmr:Ks4IaNMNlF9CWeukutWDzQjhOrBnCs48O7ecaGTTjGUqPfv5vz_QByNi_kI7LQC4fQm18mD29MvGrmE2ipRspA_aKyuwQMqjsSwR5phb9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeigeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ks4IaP7g3LNkIslrOfcNlF4rIPogKvFc3A6i8jYp_V4B0Ai--qSCBg>
    <xmx:Ks4IaH7Em_E32F-bDTPFGh8p6Nvea2yDV-_mc69AeCbPLjjJyQKRIQ>
    <xmx:Ks4IaPh56rrsVrW8h6me7uhMjvKj392X7RqIrEZ-iORmtlh4d2VVUw>
    <xmx:Ks4IaB5QqDKtuP9n3m4u9JJmDafFFKikW03RctEjCABiYyjPTUFEFw>
    <xmx:Ks4IaAOgDk1Oz3O2eFCcVhaih0s63gIwecfwhBuHzim_iRovZusmLOFR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:25:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a60c9c7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Apr 2025 11:25:29 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:25:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH 6/6] meson: only check for missing networking syms on
 non-Windows; add compat impls
Message-ID: <aAjOKBIJiNarzkYa@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <20250421175247.240971-6-eschwartz@gentoo.org>
 <aAdF3eu1heCycaLJ@pks.im>
 <aadfbd6b-ea1c-475e-b6a9-f1552afa06c8@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aadfbd6b-ea1c-475e-b6a9-f1552afa06c8@gentoo.org>

On Tue, Apr 22, 2025 at 11:27:03AM -0400, Eli Schwartz wrote:
> On 4/22/25 3:31 AM, Patrick Steinhardt wrote:
> > On Mon, Apr 21, 2025 at 01:51:50PM -0400, Eli Schwartz wrote:
> > We do have compat sources for `inet_ntop()` and `inet_pton()` indeed, so
> > adding those makes sense. But we don't have a replacement for
> > `hstrerror()`, so if that function wasn't found we would error out
> > because "compat/hstrerror.c" wasn't found.
> 
> 
> I don't really understand what you mean by this. Of course the file will
> be found.
> 
> $ grep hstrerror compat/hstrerror.c
> const char *githstrerror(int err)
> 
> 
> File is there. (The function name is then #defined by compat/posix.h, no
> comment.)

Oops, I somehow missed this file altogether. Please ignore this.

Patrick
