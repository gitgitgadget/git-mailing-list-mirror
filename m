Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B32417C6
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198603; cv=none; b=cTbm/ohX3DaSeKLdzKb2pOey9CDOJqzZ6zmmaM4hpZRq8jK9LdHdITh/Aoi5PAvTTZ2qkUQ+JLtysiA8Sfd+taKEnMLko7NL2N5wsbcWDpTLMeQRD8ou9gl0dcXZDFP+3e2aEPRWThBHM0/rtnvDDlYTeViXR0qrS6PIMUsIO0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198603; c=relaxed/simple;
	bh=ucei4NbTcFSbctjqoKcItjlv6WGfA8aD+9zKbXxDt94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxtyXqW2Fp1j9slpx0mYj+Pz4DhT5KR7tQGf4z79Jo4QD0affhvtOm3hULGCa5fo2OY8qcn8E94OcNz6Cc/Tfw8ow8KS7qe2Lx0MFZVKSuOwh8VS32mVTr601rUmKM2TnM2ntFFuJLGb0xALJdniytMCsHBZE6GmkNj9+vLDoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NBf1skSm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kuTM9BuB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NBf1skSm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kuTM9BuB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 363E2140011F;
	Thu, 23 Oct 2025 01:50:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 01:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761198600;
	 x=1761285000; bh=YHVwZ2FmSHcR1evYA7gTanYWUYLNy7XTecaaQoDMwt4=; b=
	NBf1skSmmHoZYGXk/1BUbg8npT3j1bCwulAnYPNuvjRwxe1cBFPOr2mY6fq+yeAG
	8dKJJEaXnOSbhvdNAR/TWnBkhJxAAhGA3vNgdnmBlwUN7nys5whr2AaExdPYuBd2
	SJzebKpAa2WS278pglzPS1TAEw873Z/hGBAxqDcoBNC8uIEHLAoEkhzhLVdpX6Zi
	kPY+kWCAj6QI2cnBc6HawzzfzDkS7dce/zIVL4VcqZPn+gsy6mMuHT+WxZZhnp+u
	BWXxdszGZ5het1iOcVBBjDoXNtO/wKlhb5YYeLzNt/RFcn8QGw2iDjKvBxVs38qQ
	bzdrIXK1aItkgfbla8QlJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761198600; x=
	1761285000; bh=YHVwZ2FmSHcR1evYA7gTanYWUYLNy7XTecaaQoDMwt4=; b=k
	uTM9BuBxp3YzQ8vhwJD2xHeAV5mlaEgRhi5Vd7S/EqrBo8z2DtwVqhTajyP9v76/
	thV4AlGAuxqKYRrK0a9BzS7RV0wIkKw/CQqogxzDLWsr5McIciaX9vpTRh79WAv0
	dT2wjD89yY4dbWDBCYAiLlDNbfoElvc9GsCTlR2yjdaU5gtU4rZxPuOxWil7FdLB
	L4UMukVQA0PBn1hM0sebDt1OgnfusthRy7mxZrr2S+sYrf5khBgcHx4+rmGWBs2k
	GlwndT3nQtLIYrkLyK8Ur8zXAzDSwi0jeC+UyCs8in/fNnFUqtKg1kSCBqnWHTMV
	MeT4ffBIW2g/MamSVCNDw==
X-ME-Sender: <xms:B8L5aERzw9kQl65xsoMYvDfgt8k-dWnaSlqMEpZariUxpKLLtuxPMA>
    <xme:B8L5aJMjST58wKA_Hh9ChiC2jmVC73aFCZCqfuzVeoMz0gwKZl94p8aPurmG_r8ZY
    b_uVF7vhOAQu1tPqtDx2WhqHkUnBJY_76BgexHNiq75CP2BrUSMGg>
X-ME-Received: <xmr:B8L5aPM_HLW6hdCvt9ro7li_vqXTr2RVjWEsFFPWAfALbPk6YlyeCah7yAkdewqoZeMbGljuTf2LqP0VFgkHoZ6f7kU15Wff-_Z7vYqSjZPi-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CML5aBsQShVQZpPjQWyvn-kQq8dV672eAT94OEhS1l9WVMyDKmI5cQ>
    <xmx:CML5aBWZRkgUEGVPonS_TQ8FQcFHlTnLQKUttrNZts5F4ec64NbtSg>
    <xmx:CML5aBuNhZMI0i6_z75vCZ5AuX7nLQbvUGHsW2oQTOBYaNpJwnJGjQ>
    <xmx:CML5aFVgWrnxqLSefN8Vqb7kasK_GJ9YZR39w3l4GRxAlzoEoO5V9A>
    <xmx:CML5aAq9PdQF4o-x42Qe6dnM4PN7md2cus8eYH5-WF2XRDD-on60Ion4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 01:49:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 435b416d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 05:49:59 +0000 (UTC)
Date: Thu, 23 Oct 2025 07:49:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 8/9] xdiff: change rindex from long to size_t in xdfile_t
Message-ID: <aPnCA7lzREhUETKc@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <6dca5e6222e1d02092d4ba8296b757b123b85afa.1760563101.git.gitgitgadget@gmail.com>
 <aPdFeHZKEsRw1cTX@pks.im>
 <CAH=ZcbBbnoiBndEYryMpDzav+-iHFA7_3BPNw8hgOBiaFjCq0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbBbnoiBndEYryMpDzav+-iHFA7_3BPNw8hgOBiaFjCq0A@mail.gmail.com>

On Wed, Oct 22, 2025 at 04:14:42PM -0600, Ezekiel Newren wrote:
> On Tue, Oct 21, 2025 at 2:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Wed, Oct 15, 2025 at 09:18:20PM +0000, Ezekiel Newren via GitGitGadget wrote:
> > > From: Ezekiel Newren <ezekielnewren@gmail.com>
> > >
> > > rindex describes a index offset which means it's an index into memory
> > > which should use size_t. dstart and dend will be deleted in a future
> > > patch series. Move them to the end to help avoid refactor conflicts.
> >
> > In a patch like this I would appreciate some explanation why we can
> > change the type without adapting any of its users. So basically explain
> > why this refactoring is safe to do and won't cause any issues.
> 
> The values of rindex are only used in 3 places. get_hash() which was
> created in [1]. and 2 places in xdl_recs_cmp(). All of them use rindex
> as an index into another array directly so there's no cascading
> refactor impact. get_hash() was created precisely to reduce refactor
> churn. How about a commit message like:
> 
> Changing the type of rindex from long to size_t has no cascading
> refactor impact because it is only ever used to directly index other
> arrays.

Sounds good to me, thanks!

Patrick
