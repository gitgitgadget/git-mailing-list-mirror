Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE5430CF9
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183054; cv=none; b=ZMQo18NKxorBV6nVyLzTtC0eL934Hn2rwrh2rR8ILYhREAX9qQKrdoqxRJszUHsThycLCQJ4jbRsxtZcVyoPyrRZs+v3H3IBMCwnfc/2JODOqRmtSsQTC9V4wjf/TAIiMTxzpAxDYnGAR1upYSFP6oqRgpqaWQNLcqrLcK2Bbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183054; c=relaxed/simple;
	bh=pTCIiWejL0lEqQ0q1KF2s3uRyd82gw1gIdeg6/ygA44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMYlXBEqeWfXbgo05E28rkyivNNL1xTDk6nafic/PFCwRAOx8kfXGraVJH7mqZ3+HKMzyxVrqUbrqTLivik7rOba1bhhqOZYam9ztvzWkVAy+kc/o0VKcOWOzFrUqh2nJ0foqTwI16vkLhOR/vRgZoxzKbudpNca8ZSzzo7Guy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oy1DjChZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrgkueM4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oy1DjChZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrgkueM4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE1FF140011B;
	Mon, 31 Aug 2026 09:30:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 31 Aug 2026 09:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788183048; x=1788269448; bh=0cdUmEGKmX
	cq+7TgRX+lgW4SsEZ92lmO2Ryz+c5ioWM=; b=Oy1DjChZLGDNz7UBgYR01p9wBB
	gxEiuJoT1olrG73c/P9mQN3AI/0mNzzU1Tvd9IPvlrBOAVdlg4ZshrXJXo4lenUR
	NuspB/95JOucjfxtqfI8hC+im8IcCnfvZRPfyH/pinr4PcZvhSwQdAXN9hJjHdzZ
	SLitxJlvf0d0wgF9ADyrmsAK4KDpMWXZi6DtKE4zOyNNs6jKUn1f+POwVhRa/zg6
	ZLgEd5LIUVqqv51baVWMFb+CBIUjseFfIpR/OiZdKgIyG/Bru11tRHfzbLqkfhXv
	Ws60sU6sKNC4p+K+yAntqbA+eUwMkPGIbm5nZANsxgyyRGL4CRfsdLbFXzkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788183048; x=1788269448; bh=0cdUmEGKmXcq+7TgRX+lgW4SsEZ92lmO2Ry
	z+c5ioWM=; b=NrgkueM4DZ1c6dyeNeG+mHLs7k8oeRj6iy69ICNEAv/0bILSW0f
	EZbvxyy6GxvJYeVkdfGWI2fAYEZPlXt4VULczZ0rvE5AHiIlbYztZULfOP9nQZjS
	1elBj5KTns4k7Fbc/k0T50/lR4PHXqKMgeM+X3OPkLwv8zJuLXxLxokvwESZhLU6
	ZTrZNVRiCiwq6EtJa0la3oDU7u38CtMtzWf72/4PbJ79OEIwNpuTQFqKAP3Wjutl
	GVGIeAwobIbElxU/qCjwz+nQQ7eG+s50bCfJ9QiMyadq1AWZ+LOJKRXe2YWg6+ri
	ZkdWDhaEiAzUOFS2QU6FG6MME9Zs59GfoSA==
X-ME-Sender: <xms:CIKVaoyvEUBlre--cQNFzVYb0htxjhbIS1KsztE66Gq4yOekRDV6pw>
    <xme:CIKVajJtfIPqTGdt6lRjzwfNuiODE0exyTcQXs5Cq8qR8GEN9Sda3LZ6zVpLU53NN
    IkJI0j_bBH-Mcg7lPkjtx6rpl4rD3hVIn2NQT80eBazb1b1wdFCRPI>
X-ME-Received: <xmr:CIKVair9P2_UhMzTSzOcpiWcSfF-AyuoA02OWb9sJEhKwvSmxXSY4DvYmSdt5K4JfebPFQ>
X-ME-Proxy-Cause: dmFkZTENf3x9BrTUuGSnvX2HtfyVqi/FCK05b69t+wnA1g1x0fndk61/2ari7KrpmNIsfl
    xl+WnQZHRjnJv9NI07S9jqs9g44GDCVAw+RdM6xEN9DKjD4wPagCemaLCuapiscu7lbjvO
    waPncT5Bf/NDbhCOIh1RZJ5J1hydEjJZSwtFrtS0PaQMOJEG3xdtQls03TfeDJE5Q36kuL
    ljUZaqgArlaGIQNamfkU2tGlzzOvP1RX99qspLPstRDBddf61Yu+era/GT1ROsj1NVxfMq
    bfV5sfsll/NSrIkLzLQzui5ZiGgJ86Il+E72X0Wq+5iC7Ma3e3lu5IfVsmQ99REi4uWnIE
    vzCaCdEU7AH81i4i7SRnPu7Fb2aJReeJCPgiFdSKIUUtG7pMa0o0Xd9Iqsn4iI0outxecP
    wgzeFuqCB9Tc1REqU9IWXPu2/o3qtKa7p66f/PKbOuelB2sCSDv9WGIqpZRuPktobRptIx
    WYMggS21sDm/NFTfGP2FoVIquxoeMZQgNbetaRA3ck5w9PVHwLqOC06l40kx5zCeMX46rM
    6Ownh+GWsYM70n11VrPVe6DFuCNoStrhRa9kHD+I3It8CubjE41ww1NwnHoiQ9N+gyBmMU
    IFpYdWQnGUVESVBWoR5Wl2/4aY6wGVZ8TZnqBC7hYek49FtL85+aK5CzSRzQ
X-ME-Proxy: <xmx:CIKVaiKxCzBtjO8n0hi-Y5xHvrdMyc7I-uGXQWlnIUGE3evJ09jj0Q>
    <xmx:CIKVanS0jPLK0XOudPOIPLb2lN7L_MjeB1x4ouKU6QmvsN2IAeBLhw>
    <xmx:CIKVahtn9aaycq0iBC79yRYakf2eIBtYCLTKTA_DRQoOdEhkk_4R-g>
    <xmx:CIKVaoZwPF76XyskSIpxIsRn85hutAfsM-zsgyhobqXjXHVspqvCMg>
    <xmx:CIKVaqee5fMLYWQOoT59i-bxb-9oO61GMUhjfk_atmVt9XpcSI_ofi2a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 09:30:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c122dc86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 13:30:56 +0000 (UTC)
Date: Mon, 31 Aug 2026 15:30:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Taylor Blau <ttaylorr@openai.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 1/7] banned-die: create header for banning of functions
Message-ID: <apWB_D9oivo56vcw@pks.im>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
 <xmqqh5kikkgi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5kikkgi.fsf@gitster.g>

On Tue, Aug 25, 2026 at 01:34:53PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Derrick Stolee <stolee@gmail.com>
> >
> > We have universally-banned functions listed in banned.h since
> > c8af66ab8ad (automatically ban strcpy(), 2018-07-26), but some layers of
> > the code should be more strict than others.
> >
> > One such example is the trace2 API which runs during atexit() and can
> > prove to cause die()-handler recursion problems if it calls die().
> >
> > Create a new banned-die.h header file that will ban some Git methods
> > that call die(). Include that in all trace2 API implementation files.
> > This currently only bans die() itself, and that was already not used.
> >
> > It would be reasonable to name this file trace2/tr2_banned.h to be
> > specific to the trace2 API, but it seems like such a restriction would
> > be valuable to put in some other areas of the code, so adding it at the
> > root of the tree seems like a good long-term approach.
> 
> In other words, the functions banned by including this file are not
> listed because they are banned from being used in trace2 API, but
> because they may lead to die().  There may be some other traits that
> we might want to avoid in certain subset of our code, and we may
> have similar banned-frotz.h header to prevent direct or indirect use
> of frotz.  Which makes sense to me.
> 
> Would the same approach work for the_hash_algo and the_repository, I
> wonder?

Don't we already do this? If `USE_THE_REPOSITORY_VARIABLE` is not
defined then we hide several function declarations where we know that
they depend on `the_repository`. It's not perfect as we still expose
functions that do rely on it implicitly, but it's easy to remove more
function declarations over time by just adding another ifdef.

Maybe we should follow a similar approach with functions that die?

Patrick
