Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DAC193084
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137467; cv=none; b=UruYPf4claB3i4G/Q/i+8gchYGnvo4Jl5riahVZTvvKkmZ1prOfRGYC1GPuah1gSftDx87jJpEvqqm0ehjowAQlVQ2ZJFMFoIFe8gpGVHzO8Czi3OVMS4IJeE4PLTL6YNRnICXar4Aks+H8nGEfFAPG/68/wWgh9/ttczvHzuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137467; c=relaxed/simple;
	bh=87JadCv5Yum/H10/l1cRYqUeM1SLITcOYl8zpR7A6VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i80Ztxuj7lY4hBNP4/hKi8py0QKYihm66Mwc8I+uXzgbkgDK/stzulBCnPNBuTjgND8czLDRzktj6yu0Ka54H/tQCwPdlnwrfxwU/LSnpaRogcPvHQX8xTT5mQ2drNZU17vWmVglkUPC/HnVfvQyBivsL5AeFkt/rHQFslA9NHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VEnRRXof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xiM5aiaY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VEnRRXof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xiM5aiaY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D25D1140120;
	Wed, 29 Jan 2025 02:57:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jan 2025 02:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738137464; x=1738223864; bh=B1Dz6QahIf
	1lUvGHrkIJmyyL7NDNuuWUhvyrKY5KzYs=; b=VEnRRXofZdu3QPUMKNQjipR3LJ
	GpJftUTpiTIWcjYSkeidqX2ieCnZagCp4+Gllkie7s4p0x55LIIRkkN48kXwHr40
	BWvOdo+GlVmUNffTJhy6ygkUq4CoNUdcg47bArzcIoEAPgohpacz8MVEPov+xizv
	VftzxcMRphptqqjjw+vT88eL3xHuuqra3QjDHcQD/CtKOhD8hHqVMLMvuRj6HRe4
	RKUySRXuU14uvfKOfJeTUCgbPmlyW2EuNxNJOS9UChgWdP6nj475Oj+1lfXTKDWW
	VRYs9DPxWjG8cNJP2pL/umL/ijgg6P+s7+uAsS5D3iZpYwDgTMRPceLdnumQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738137464; x=1738223864; bh=B1Dz6QahIf1lUvGHrkIJmyyL7NDNuuWUhvy
	rKY5KzYs=; b=xiM5aiaYOOeEmLq/ucUDZkf29eo9ipxp3fpaJUTNCJC3zkUncbY
	y9A2SUJDPMTEwVYzGuIjatcJS+khWRRnUXTDg8dhYdbFLf58AJyoys45g1raQCYI
	VmKMz+WEnVFUv0AIDHbe+yd20arx60R3lJ3RO4muGjXisZYMlJ18GvOeYomsw97l
	826k5G9MA3tO64uUN3y6QrLlNZvOoypYpuIs9kKy6nqqAw5R+BhnpsdV8WkP8yQt
	zffYk1bz5Ezp4eoHBeAX6GZ/IB0DmGLNnPfECA34akjjzTL2oBOCVRK82Kmz0xmg
	+Xi1VBbk1X5i6RVCiumhnqc7vKnUpi5pgcw==
X-ME-Sender: <xms:eN-ZZ53MVf3_meZtAd1uXwHGEx90zr3QZLZ8Zb40zsJyDPXp30qSFg>
    <xme:eN-ZZwFJDwIo9U-Y2oNh8UlZF9MD79oIln-m_jsgsMkg-43v7QXX-RnFVpUei8MDY
    Ql-Z8qmPUhGm4kZ-g>
X-ME-Received: <xmr:eN-ZZ55TZb6ez84lca-2zGlrRpVlqE6reMy_OvPnJ5XzE_pvQnDP0JD7ChCrbYt4eaO09L6ZgiT-EH0YFnyeJEFng6EFgz2nc23cfsvwfyb6hE4bbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:eN-ZZ236z3glWI7fF3XkQsTq_07tNehx2q-nvA3VxfCu-Ko3uAWbXw>
    <xmx:eN-ZZ8FSS-pu1xyia1AjXGQ-hQLH7tT1M8HyFGhREK6lLyS6WXi80w>
    <xmx:eN-ZZ38-Ppcj79YdVdLCgn5n9GoOwoxRF1XoXxjHXg5HsuX-9sGq8Q>
    <xmx:eN-ZZ5lHWINvQyiQXgoBIT7y-QluMSwvBlkj-axoae6iy_Su1zGceQ>
    <xmx:eN-ZZxSXy40LISyup_QKwM9OOq1btH-meaTj2y-lSzgd9Tv1GLh_-py7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 02:57:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de69e98c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Jan 2025 07:57:41 +0000 (UTC)
Date: Wed, 29 Jan 2025 08:57:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
Message-ID: <Z5nfcAUZPNdDSI0l@pks.im>
References: <xmqqlduulbgn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlduulbgn.fsf@gitster.g>

On Tue, Jan 28, 2025 at 04:18:00PM -0800, Junio C Hamano wrote:
> * ps/ci-misc-updates (2025-01-10) 10 commits
>  - ci: remove stale code for Azure Pipelines
>  - ci: use latest Ubuntu release
>  - ci: stop special-casing for Ubuntu 16.04
>  - gitlab-ci: add linux32 job testing against i386
>  - gitlab-ci: remove the "linux-old" job
>  - github: simplify computation of the job's distro
>  - github: convert all Linux jobs to be containerized
>  - github: adapt containerized jobs to be rootless
>  - t7422: fix flaky test caused by buffered stdout
>  - t0060: fix EBUSY in MinGW when setting up runtime prefix
> 
>  CI updates (containerization, dropping stale ones, etc.).
> 
>  Will merge to 'master'.
>  source: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>

I'm a bit confused about the state of this topic. You say it will be
merged to 'master', but as far as I can see it's not even part of 'next'
yet.

Patrick
