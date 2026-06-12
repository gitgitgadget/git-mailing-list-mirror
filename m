Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785238F653
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244255; cv=none; b=ewhpT1cUHggKpwtbrNoQx34qdSXjNaK9KUbU/RF34Ptkaeplv6SwGzUh/OhFrBkz1RdSRX/02YBh9nxWNihfLmPJhz3WrANlctwVkqMWZ+jUAwxGZUJ0l/fXRJ6epGa23S5JHhgiLeB8WcQZhkoxG/i+UOS/wMLKE4u7RqxLacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244255; c=relaxed/simple;
	bh=x36eJ+CbDTc6KVP2UhBcrksqxihF8XAZBtGmNhnLN3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsn2WnVRzlyhzJHx491RP3mHCK4EzWzuUCujtWsk5IBQz2Qt5ooHhlR/0Ce/CIvogLe1urlwzeYjXOBQIl45KtItGc4DXlvfQxllXODWKAdcbxolDRQ4sPBeItNJOeYF77YjFQevx15IG/g48UGohkU/OsRids8PBi3fYYEvkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RqxCHeum; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKn8MIts; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RqxCHeum";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKn8MIts"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23BD91400071;
	Fri, 12 Jun 2026 02:04:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 12 Jun 2026 02:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781244253; x=1781330653; bh=yMn2uB/bU3
	DCKjQZ9ACisJehPkkDA0CACZo7wGWMS5U=; b=RqxCHeum8vhdUnmO8vLPimHI2P
	ovu3qQyP2jprVM8wo0pcQQGg21aj47GPmv+HtpLPgKYjCBBWRdw7Q5GusHCqAFUJ
	1BZRw7z6KyIrhHJfmY6Ia9lJ9ejPqasm5VOX9OMhBd/iYEyAUQYKQ+oILojEPsrz
	BhOanviAsvPWqEjqb/j381wwwxmQorovTLgyzTuv5/rGZKTdc6Lwhd+gxSXZyLUy
	cr9R3chbOq2SEaKRQHa23mnL3nZkD5tfmztXYo72Hg9d+zVvUuvDWx2nhxFQa4Bv
	Dsqz22l3koAnOQ6nsuOszzQ6rGn9PIwXA6Ynjnps3JhHDooVkKtzHP/BJPkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781244253; x=1781330653; bh=yMn2uB/bU3DCKjQZ9ACisJehPkkDA0CACZo
	7wGWMS5U=; b=CKn8MItss45hdEPAJ+XZXJrlwsJYu5ERUuva1re4IKGd45AttJU
	oEaobEO/46OwXgom4brGb1nT/CW5a9ixQfJB+ueOYRlcC7Ut63sljgzAuD+seTl/
	6bqRCftVdDmymA/KdFlTHW6iiy/IylqoiaGGTUKxRE6S4FIpR1qdRgDrrJ7uXB6q
	CNWyW3Ybi0RD2rWhxYVveYlAMMqqTELWlxT2XRaH5aoFSMZIpzlnsyPg7o2jjZe6
	GU0XadBx0Hl0exblIGPhUB7HWTjX9cL5un6aFtXpTk9dxhu7NNbmuVhR2Q6mIqXG
	CMiQwy6stFKW1idsA+D3GBSr0R35pi3vBtA==
X-ME-Sender: <xms:XaErahKIuPfBQN0sHzUwWS71BvqITiq2RJQKZ-p12oolNY7-t3ZF4A>
    <xme:XaEratURs4SSUDcvsYHcV12wwxvaUdxazpZ2pTPwL41JpnBzytbyEoiQKbF99EMx3
    if0-51GUfY_WmEWjIP3TM3fuTRqwPhgVHk4PPsMSMkUX7EmQe9tRQ>
X-ME-Received: <xmr:XaErarg-erAFcP_b3aQqdd-0S74lATHlvjhpKWaJBhjMmul9X_U4cIu_l31SPupP76MNFqFBg4cSiAp5pkP7oKL1vf1s39sV6F_rnwjeYjQ>
X-ME-Proxy-Cause: dmFkZTFALo91SC6rV88i+Ln4TaMtQkLzKj+MWKLUqHpoGxQVegRGFCb11kw7Ci2edideJ7
    CTL0TwF1nxDPHCNmCKa6fmtNyZan+Hq5LCYSQg91OfOkP8ct843F51F/8rB9XcMxXwOUTm
    5b6aUMF04cFShkv32JIERH2Negi0YFrAZuZfl46pPmV1IW7L5z6xbI3hKKeacfFSflvONf
    a/wMUBnSF5F3h8w+C+zicAqlbaGiWBnrrffHcZIOEqx+Pdf8650jlrSeRPfSGPGa9m4tNL
    oBQstnAfxqWDoDGZDWG3wWdxg4Sa3zNWZyAKzV5O3TzopHG+j+koEIWVi2biLIo7g3oQXp
    Gkh8vh14GlAO6ZxL+kWS4tQGGrtQ9bZ7Swdv+Co2sPyVifD+QYWYFufTWWybfvI2rMTSSZ
    40oFcl4FSApGiuzqzbXQERKkzvzQwE1Yie3qzYVOKVSgJhSC4Y5AFjZuyb5jydYc19V5VR
    qWRHwFYHDN5aGzSc1nwmvcEllIyct1Jm3ZJQZv/WyJidqWoZ/UC/oe+02SiKcEvSClNelh
    yLZGq/mXeIeCUg3mUvWzMvnxFIawXzEdd1fNZvi14E+hqggkCHsvfiuEtUgM05bPGiz4gA
    g4OE3+evSlgTfY1L8Z3XQLqhU+6qB6wRUWFfUrt37Cuh4ousNvK1dabPqSkQ
X-ME-Proxy: <xmx:XaErag-CzEOMED-P7wE9c4weQHSazrg-MuqcPay5D6hfudbEc4e14Q>
    <xmx:XaEratDFWCAAllPwvO7uOjLlOY9TJDFenIZ110l3MhWs3R4tsk7a2g>
    <xmx:XaEralLM2R7iVikJlp3XN2fySdlqkGz0FPMpZxb5zbuRH7azRkgr5g>
    <xmx:XaEraomit_nAVJ7qfHLOQYySCaiaI1I_mlthURoBMI7WEvrvnjUkqg>
    <xmx:XaErarv0-HgdYjSHM2J--ZT138PIfCwbIHxWqZJlnY-BLK6eXdMn0n7->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 02:04:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a0412ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 06:04:11 +0000 (UTC)
Date: Fri, 12 Jun 2026 08:04:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] update-ref: add --rename option
Message-ID: <aiuhWIUlOVuuHSNJ@pks.im>
References: <xmqqv7brz9ba.fsf@gitster.g>
 <20260610212800.2892146-1-gitster@pobox.com>
 <aiqytJD-rcEirhgE@pks.im>
 <xmqqwlw4nccr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlw4nccr.fsf@gitster.g>

On Thu, Jun 11, 2026 at 11:47:16AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > One thing that I'm missing from the commit message: what's the
> > motivation for this new mode?
> 
> Maintenance of merge-fix database, a kludgy way to manage evil
> merges that are needed to deal with inter-topic semantic crashes.
> 
> If you are really interested, see the appendix.

Thanks for the explanation!

Patrick
