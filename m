Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA33C4171
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909991; cv=none; b=d6DlYGDEQ8PyTYYbzy9umP99AClCbXme+ma3HBhKktxo3uRjdTFmRj5kfDGUb7Kn74yYcWy2ZLTQNcc+9zQqrXFd8+fTjzcv+26R7l8m93ENFh9hzKSmYmTY+jHZydTal+2bSq+qZbIPxtvVrvsFgshVwqNhQj6bGIcXG9siU1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909991; c=relaxed/simple;
	bh=YbjpXQavdbnU0v9cs3YTfPtp4nHOU8CG/4drVOz811Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSFLq+/1clAfmBRX1DdPxWXinm4nWqvoQ6VMGJn6aPaFyjnghGooHcLHMF+HQ00c2TFPzsPEMM21kNTqMHnFvF33b6q9kFRr+Ec30Rk6A2sGEhby38cnlHV9kfkFy3gv4ZhzOMWE556z9FeQDDKbUcD/hccg/Ae4GPX3PGktUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WBNN08KF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGXtGhu8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WBNN08KF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGXtGhu8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C12DEC00E1;
	Wed,  5 Aug 2026 02:06:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 02:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785909989; x=1785996389; bh=qLwtrnUP99
	FnnZaObprcIqOGqeN21EeW49N5iMCa4sI=; b=WBNN08KFvOBdgyzImZ09VUE7Nc
	1nfH8gknHlzNcLuGrPn2p986ctdow1zEmiXMXRyGkHxp1JaN/APRSjO2xHSQKySX
	/xNQmr8vlXQUOJn+M9X2GY+hHRmWu5/kB3t6fNMKNd/5iVFTA51+wf12WFCj4T/w
	Ry6uDIqrqOwJd/35fh06cBghrNOTy1uMIQdwjrIblc8Won5wncDAcLAB1bXrH32/
	z+kax5enE2GmRydZ1mqi7+m8McYN/N6iQBpeiCsTbuagDnFlP7jNpFXysueCtRC6
	rLnp4gLMJETXDXANoI4p8etXubPg75oEUQWtLGuNKtUohzQml7RATJcRrLtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785909989; x=1785996389; bh=qLwtrnUP99FnnZaObprcIqOGqeN21EeW49N
	5iMCa4sI=; b=jGXtGhu8hu8FvaztdjGheaP2PY6Pb93/zG9UplvolJDdTCZoroP
	wwgz8o2i795uam2VKzIMckzrPnqQzY/T21WVsFAtyRk60KGXWQ7U2paRHWm89C6j
	1sNOMgMWG/yJBtKXyQOQhb/azCR8fvfwnEZFQZoGnk3RupaFFzU3/HGX2+nG5F5/
	fIFD+kbJnL0Yt+ia0gY6dPlbDnXlLG30iH68xXCd3gs2ZSpk/zBxO8dgqNxvL5oQ
	dhP28H7OBWd+igvlgstzjgKpOXKX2U9XGThHB5Q27fTkSQPMly7dLmPcIOvTZSaO
	8LkT77ugZ4dRCNAWsii/BLJBkfsxpvkJGLQ==
X-ME-Sender: <xms:5dJyaiKSHeqVLKO8HUywNx69FsZ9PJEo_H0kJDZ_RWdIYk3N4eGvSA>
    <xme:5dJyagJkzUuxKRFqfePp3I0S_uENkceD_Wwc2nIpJx1DIC9zk7YXg35crasaxExAE
    -SHRsifuU4JOjqzzmMO12Z_XGJ_yYmxDBFDzvFw6huP5qWLQJLDTA>
X-ME-Received: <xmr:5dJyagVXbvAZiLb28slW2b-_KbqdPR6ULftlr7BMZ9CA2jBET_jnMbXpetdfe1bYGCH3JEzfb0UAwhhqb5POJyZBOZfN5e1Z9KEdRLi3rw>
X-ME-Proxy-Cause: dmFkZTGhbFmEWR3hgijknau58kJp6hvODAo0PVyEFqnrd9FQPW90Iy8itIfgRnzFoOlqGJ
    dOdkkRk/K2Hq4mqWWjqkAxEl16dHImRAp+T5VAPTcpmFGMprHtc+ULzXgbDvGSzcFe634c
    Ub0YNsSxD/FVvIjI93qD87QM12hI0HcWMjnmrFBZCokU9e11+YPJ5pHpbjjHPjndcy6gRO
    KxEuS7Knt75XR1E2JGPkdEVHLpsBdoAINlYAsc/ocsbzXA0OIspMya/LZShD5H63463XhY
    rhW2dkYpgqXssBur8TLEMB+VxtQU3QycTUcsGbZpVY9UawSdgHxlr/n7lqfZB68ZfszeSL
    z/p3624wv5ARWtnmP5xKvzU2awMiAePsf+iwtmS59lSrx9HmPTrdjLqsQW7qn+elEsm6de
    YLMrNPUTfw2MOuT82o0D+BDmk5WPVx2PMJrKB+W66abAOHJR7Lw72Dbvvzop7ARX/TYDjl
    e7roU5rku7dOFS7Oe26GNAhjSqqY0beNoD0fepDvNbC8ArNcN1N1uGh9FRcmXv6biKwZtI
    W8zmO6GJzIaWGYMjQ0WGhgzsl7DFDpy+bc8EN5eTq8kVfv5CBISPuUekkU35hRGEVxK3Tt
    hCgjB7QiUqQ3Flf5wPsO/zNFqwq8DNSr66XOJ2bTfMD2AJYBf80w7tsVbqdA
X-ME-Proxy: <xmx:5dJyaijUnzd7az4w-xwrWtZzSHBoE_NXC9fHwh_P5s4uD6ubtu6bhQ>
    <xmx:5dJyar_CT3ZEG5Sl7bDDdZrjx8GJ44EF7PDftEWqLk1s3RAxvkTEeg>
    <xmx:5dJyasBwmdAC32cy9CMnMeiNflTVV77ZDIz_2AplT7l3cRZ0d58SFw>
    <xmx:5dJyaoI0NvkQTGesZ1PvD2uAnS9XtRMmTuYtexZ2Uc8xCKnUMTlbNw>
    <xmx:5dJyaj5fWeMhBk69hcRm9OJGV4_7FTE1LhgQ2IoSRl4v1v4MkTQtIvtH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:06:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 689a6946 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 06:06:27 +0000 (UTC)
Date: Wed, 5 Aug 2026 08:06:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] odb/streaming: support streaming arbitrary object
 types
Message-ID: <anLS4CNVCQBm-2JQ@pks.im>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-3-86d70e82345e@pks.im>
 <anInniMjCtU9Qae7@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anInniMjCtU9Qae7@denethor>

On Tue, Aug 04, 2026 at 01:03:41PM -0500, Justin Tobler wrote:
> On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> >  builtin/unpack-objects.c      |  1 +
> >  object-file.c                 | 31 +++++++++++++++----------------
> >  odb/source-inmemory.c         |  2 +-
> >  odb/source-loose.c            |  2 +-
> >  odb/streaming.c               |  3 ++-
> >  odb/streaming.h               |  3 ++-
> >  t/unit-tests/u-odb-inmemory.c |  7 +++++--
> >  7 files changed, 27 insertions(+), 22 deletions(-)
> 
> Just FYI, there is also a comment in "odb/transaction.h" for the
> `write_object_stream` callback that is also now outdated due to this
> change. We may want to update that too.

Good catch, fixed now.

Patrick
