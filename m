Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9D4440A08
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248106; cv=none; b=C/U/wH9P1JEHu8H9GftdWAa8dH3V7s+XH+hih/AaW0m8UKqJ9s40ru6H+V2G14gUJfu8U3jrPjmasHLICE0NoGWUpJoAMgXVG93JJ7A+IOdCysc+VN8VJ43VNC06kmf8Bcs+1qmDNiHTHsO239qTKe+AgXIvJC0us9iDrzSV0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248106; c=relaxed/simple;
	bh=0L5q7LBSn+dPVzgf703reEgBh8eFV2x9vp/up0eibIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCAO230/2FRGQ2vHERx3V4JnJXdcfH9uiuGKMf3jEx82FouTEvxWULeY3SCU6iAj4fPcrzfcO/Q2t9hkY+kRiliFF/+drRq0uwmCyWzqfmk5OM6N+wVc46SPQMh9GDDgqL9jK3/NbX5Wc/u/t/jyKcuBYz6l9fQsvaX4lkHnG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=blLIh0oj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnL14SmN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="blLIh0oj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnL14SmN"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A49B1400066;
	Thu, 24 Sep 2026 07:08:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 24 Sep 2026 07:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790248104; x=1790334504; bh=Xq/34F0GZu
	tjYOXxQNFKJ8gGm1HtSVxU4dBbI+qtCO0=; b=blLIh0ojC3ZlU5A6E70gi7Lain
	QHf+HzWwjSrBjFpc8P0Atd5Yzt0r7s7CuyGP9fmIVRRn5ftxmvXeYTZPAeZifuaW
	lQADb8/wmWn8jw0MTngpdeEficJyvtUl5u5wBu1B5+nt7tFu5SVbW4A5Pq6igucI
	/VNvF+O/3VLseWqSftXXQykmsI6Ir8/N/NmTl4C7d4lYecFyYeK+VFyJWMq/qAA1
	WahSfqakqRyXFlD7A9jZkYA4gypZEIBs5/myiI4a8JmGF+F1PjS4GAycA9eJtK/q
	7W3oqROUmSr+hj5DQtU8hQ8tWppXIfGQDGqV29V6YqPjpMJNEdex2xw3mDmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790248104; x=1790334504; bh=Xq/34F0GZutjYOXxQNFKJ8gGm1HtSVxU4dB
	bI+qtCO0=; b=JnL14SmN1WtyEV+qSW9blq6I3IIaJwFfNGo+HilF7HaVQ7PxGKz
	3QfeifQ4x/JEduI5E5yOjYhdXhdbMqdiwEt4fFtebg6Aq/wyYeH3t/tkHZppQJbt
	rwphx311eFeZ2gwg1/po7jMcGeX9KT2ahE425VdIMF6J72UAvFo+r1D+5xc7aKz5
	sEf0DSjPetAGn2Q8nfsEmA45/+1VIpaq5TNQgu42OUtyOtEp1VzKOCAHVa+QFqK2
	LVdvvUBXS1ljAFAAy8PjDXIcUenKmiQuTMqqQKcZ1n037VDiNKnTVM1a6PAxP+yJ
	eM5bk+MO88mSCcAZXNhGb0RI/p+MHZmF9aQ==
X-ME-Sender: <xms:qAS1as0j1dXQywPeb6NbsT4ko41oexAa_Ii5yxCu8j8_EFmPx2Eprg>
    <xme:qAS1amJnT988jhx56r2jZdfhdIxReZhx91UPDA0ioBE4D9ORB6Tt5JHLRwFWYdvj2
    _a5r_bHlPSEzg1QKN9imvbgb3VIlUj33Oem_c0_7t_tBmYKo-uVpXo>
X-ME-Received: <xmr:qAS1arHOlUnTi99OoJNlRMeUTNHNZDxauWa7ivmdrXol7AsABt_aFvr2DMAb6N6DC1Pyr3k>
X-ME-Proxy-Cause: dmFkZTF9ZstuWnVK3T3YLcc/btfUebBraXLVBvkiNGmd9FqPI3ZcLYgqNm3Gu/VV/4VFK8
    3E8li1+Yb2AIQTqM3qLS4LkUmH/nXULFY5HWg3BTyrX0E1B25AGSDzw9KQ+ZyPH6EqunL6
    wjvZtXeeNZWf0OdU81HUlp72NCYcCVF6qNT7QDKfrcXr355OyDvQHumDf9AsEY2Jdx5GP0
    TvIJB0KJwJi0c4ghsUwLuSD8OkteHIsq/vc4BPLTib8cIe+pkrLGnyq0tdv9Q8hdKjIFnR
    hequYQfaLDjapWu27vhO2wJeIZOtm5NDehb3eCrhlPaLiQNlwtCzZ75R2jmazdDrHWJOSM
    LURszPrHLaNuI0kBXpkJ2b/gMpkjSQnlQJjewOatKa3zM21lU3WY7gbvoJubD3M09XzZvm
    xLlkm8fzRRu4c2k6yakPnTnoagcFgZpzKdGj/k5E8d1IYfSDP6Ea2zwYOoXFn3jmSL4YzG
    MCyEBsxRagj8eqCAw6oBaycyVpLodpMeCX4deErmz5RwDizMj0UWSeQHJ59KtbqUNtrPxB
    R20xEV0FwmOXzxmBR7UcUQ9vsCLIW1TUAxRYpJkQDHZVZkPF3qRnIixA0e54E592pLi94X
    0RdAD2JGEd9VT0bMtU6rKXasAOGMOBQTZ5DXUYYM6LtUwsC2gL8X2NsqshDA
X-ME-Proxy: <xmx:qAS1aiUlkWrBNon7Q1eT0LLcWfoVr7niyIYaZbNe_PlzXKgGAjai_g>
    <xmx:qAS1ajydhkMzCNZvYU7Rsxzi7URXUc8p7e8lUC_7ojBa9ksWIkjUzA>
    <xmx:qAS1anTYnI0zQE6NH_yFuYAf9rQoF72FjYhur0VJLIeSx9tkgCZ94w>
    <xmx:qAS1avix89sWbb8vum69nRO3a3j6zUmhWapRGK7F0Ujl0e9azKM4nQ>
    <xmx:qAS1anW-iK9M9hFFxYL6BvASk9bLeRgpumdHbPElyajPRC9QILY48B5R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 07:08:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 665f2bad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Sep 2026 11:08:22 +0000 (UTC)
Date: Thu, 24 Sep 2026 13:08:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v5 2/3] branch, tag: retain old OIDs in batched deletions
Message-ID: <arUEo7bzFJfOTTFY@pks.im>
References: <cover.1790113781.git.maciej.ciemborowicz@gmail.com>
 <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
 <6a8401c448f527fd80c162908a2736811a723096.1790196627.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8401c448f527fd80c162908a2736811a723096.1790196627.git.maciej.ciemborowicz@gmail.com>

On Wed, Sep 23, 2026 at 11:04:41PM +0200, Maciej Ciemborowicz wrote:
> Before 8198907795 (use delete_refs when deleting tags or branches,
> 2021-01-21), branch and tag deletion passed each resolved old OID to
> delete_ref(). This prevented the command from deleting a ref that another
> process had changed after it was inspected.
> 
> The conversion to batched deletion dropped those old OIDs. Besides making
> the deletions unconditional, this causes reference-transaction hooks to
> report zero as both the old and new OID.
> 
> Both commands still resolve the old OIDs before starting the deletion. Pass
> those values to refs_delete_refs(). This restores the old race protection
> and lets hooks receive useful old values without adding ref reads. If a ref
> changes concurrently, reject its deletion and preserve the new value.

Hm. The motivation makes sense to me, but I have to wonder whether we're
approaching it on the wrong level. With your proposed changes, we're now
not force-deleting the refs anymore, which is a user-visible change in
behaviour.

What you're after though is to always have an old object ID available
when the reference-transaction hook kicks in. But if that's the goal,
shouldn't we consider whether we can instead resolve the old value
during the transaction and queue that for the reftx hook, regardless of
whether or not the user has asked for an old object ID? That would now
cover _all_ users that modify refs without us having to update every
single callsite.

Sure, strictly speaking it's a backwards-incompatible change. But we've
always considered the reftx hook to be exposing internals, so we aren't
all that strict about retaining its behaviour and have allowed changes
in behaviour in the past. So I wouldn't mind if we adapted the hook to
always yield the old object ID.

Patrick
