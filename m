Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1028AB1E
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865309; cv=none; b=UFdgvwLB4gLDcAqUG2HKEy6tioIO6Sb/XuA8b11N8Xk4ppovdA3FE+3Z/Em09N8e85bvxxjyk6FKZ6iT7KZvchPKpUF3pZFZVkxZ1JZUrL7E6+rl5oU3M2+ePBg9nFl/ovY/IbZFU1G4h0fpijORP8vKZrFZtwCyAPOLsXV++XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865309; c=relaxed/simple;
	bh=pYB+xQuxvxFxnNHhQLVgVs+J235n9q+SAET81Xwkg4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKIpiGloXAFh5aYlx1AsOVRE445vSHe7c6pL7XrL7sYohxM1vAMaQhDR7aFrb/UgApvPPP5OFHlgTLf8ELSm2z/eGiaV/V6MrKPp7NIoWj6VSQ3nrNqzdeQhSn491T9AiG8I/wwp7HjG6xCd1o+ZUNYISR08BMNoy8SedKKSIos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H7hB1Lmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3aKWPAR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H7hB1Lmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3aKWPAR"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C68CD1400898;
	Fri, 22 Aug 2025 08:21:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 22 Aug 2025 08:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755865305;
	 x=1755951705; bh=AAHKl4JhSUkExZXbXnWFKmumZdstoZg/8SFc/lXLGc4=; b=
	H7hB1LmmhN3P3btJTgY9PGR5SzvtVMTsRlhVij851xco7l8XvI0USea2xF5zXVSE
	Kh2aN46dFwVCuiERe7vjKazIWcdOtWQCN9+mAAwy4SxY1JqxkI0MQ2Sg2cHbz9Hy
	TEJXFth7rnhje5VkpS0ZrdRpHB0KLWr4QQO5rzaetsqxMnJr5phmgVWKkDoRa+B3
	vXPzF8CBEtBButoVLjEQSl0FKgBC3AejqRUzJfUS8gEIEG+I+WLzSx1LJV4H38b2
	W5AIWyrMPsn4ir1hTAhcCaRm2D5VaAj5OjkOM73McYtfSVN1PUggQ33xkUjNdSRJ
	v/1/1fFodzWL1xzxcvaonA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755865305; x=
	1755951705; bh=AAHKl4JhSUkExZXbXnWFKmumZdstoZg/8SFc/lXLGc4=; b=W
	3aKWPARpOUh6Womtox128nQI/tkno0qd/686i5+d+k/PJPz1khFUvH2mmR7D4Jhv
	7CjS9+RSrAc4D0+Ct11b/ZQ4us2pTNi/1kXWvEAjftGn0Hb4Y65+yHOgdbxYsRd5
	9+WPFMtrBmRfUJP9bvnGoPXUMnWMLCHjyJNS4qDvJCl/HZD48HXcLDOrxD4k3DYq
	zoaShYsQlPRvek97yQOj6nuiCfOcO0eQcX7nkLC3zgRfutzZb/ZlhJ6YCKM2L4MW
	JHFZPCpLJPcOwd+kfmf/LIPH4CxchE6agho7+P6Phmy38YQGpfhtlneFJRDomMLM
	k4YTtloQvVwY54T0h7sRA==
X-ME-Sender: <xms:2WCoaKtRuG2-AUf-BW2Ir0e5o6IvVidE0LsoPqXOQXH0sSO9y5reXg>
    <xme:2WCoaCtw_BiFfcKsINiH27M-jb3bstS2OHx6erFZyi6yJkJRxbk_RG9RrOWLgHh_r
    gNjCA17aSJOrRVYAA>
X-ME-Received: <xmr:2WCoaPPnsAqL3Hb-nV1hnWLS00tDkuV_zcGPBCDxdzhKa7482RFcfZL4ybq43sP6exfN5KfQV_ul4eGItrFj92R2xxult9Px6TaEWvNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:2WCoaA2QHHajR7wDSZqQqMRsYVzUBf44--mD2a-zih2l13nJpPq9eA>
    <xmx:2WCoaLOEIhCeGZhRzeCqk2GS-eOPzbKuooylPdSkEdTUHNg2ZC802Q>
    <xmx:2WCoaA1cwt7CqASKmKEPSH4BvYAkjNQObm2ZTvlPnjsA2OUcvTIdPA>
    <xmx:2WCoaCGgn_w0tqRZVOwqw6SaBcTi-Qsf6wmDq9myUOgX1XjJYhyw4Q>
    <xmx:2WCoaHWog5bb2fWlruqwydxw1T-vA8hjfqkVfGoBTgvvCcTnTY5FSy24>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:21:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb630ef6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 22 Aug 2025 12:21:42 +0000 (UTC)
Date: Fri, 22 Aug 2025 14:21:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aKhg0NBb1usxw-dq@pks.im>
References: <xmqqms7tao9o.fsf@gitster.g>
 <3600D877-4999-4EE3-8C1C-893E12D35B6A@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3600D877-4999-4EE3-8C1C-893E12D35B6A@gmail.com>

On Wed, Aug 20, 2025 at 01:49:40PM -0400, Ben Knoble wrote:
> 
> > Le 20 août 2025 à 13:39, Junio C Hamano <gitster@pobox.com> a écrit :
> > 
> > ﻿Patrick Steinhardt <ps@pks.im> writes:
> > 
> >> In the end, I'd like us to learn from what people like about Jujutsu and
> >> apply those learnings to Git. We won't be able to apply all learnings
> >> from Jujutsu, as the workflow is quite different there due to the lack
> >> of the index. But other things we certainly can apply to Git directly.
> >> 
> >> Note: This patch series currently builds on the cherry-pick infra.
> >> As such, when one hits a merge conflict one needs to `git cherry-pick
> >> --continue`, which is quite suboptimal. I didn't want to overpolish this
> >> series before getting some feedback, but it is something I'll fix in
> >> subsequent versions. Furthermore, the command for now bails out in the
> >> case where there's any merge commits in the history that is being
> >> rewritten. This is another restriction that can be lifted in the future.
> > 
> > Two comments.
> > 
> > - You would want to honor notes.rewriteref yourself, as cherry-pick
> >   does not and that is deliberate [*].
> 
> Seconded

Okay, I'll have a look at that. I'll probably not do that in v2 yet, but
will try to get it into v3.

> > - It is a sensible design decision to limit it to linear single
> >   strand of pearls history.  "history reword <commit>" when
> >   <commit> can be reached from many branches along linear history
> >   that rewrites all these commits on these branches would be handy.
> >   There may need some way to say "these branches are protected, if
> >   'history reword <commit>' needs to touch commits on any of these,
> >   abort" and things like that.
> 
> This reminds me of looking at rebase’s update-refs through a mirror,
> and I think is similar to what jj actually does. In particular,
> editing a commit that is reachable from multiple non-overlapping
> branches could update all of them.
> 
> A reasonable heuristic for safety is “pushed,” but I would also want
> to be able to edit something in @{u}.. even if it’s in @{push} so that
> I can force-push a new version. I suspect jj might also have
> heuristics we can borrow.
> 
> PS thanks all for being willing to borrow improvements! Reminds me of
> Neovim inspiring improvements in Vim, which I get to benefit from
> without switching :)

At least initially I want to keep it simple, just to get this in at
first. So I'm trying to be quite defensive overall and die in all kinds
of situations that require more thought. That way it becomes way easier
to eventually extend the different subcommands to maybe lift some of the
current restrictions.

Patrick
