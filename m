Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0E408017
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109732; cv=none; b=K+iC9DWSxh+ykl0TGprF0W1ERyF5+2o0nT+cKKSWcZm898dk/Hr6DLn3Uur+IwblNMKUCwGfMuWMNpyqDz6QgDLvM6CJwM0tcApTP72dZvSwJKoMo65H7/7RwcSAtIZZCpniSl7Q2MRmaCsuHztgOW0exXZ+of8B6ofAzf2/mXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109732; c=relaxed/simple;
	bh=pzf/hZPf6nYfvBlZxUOVE0+ozxRT+MDtmvNHkUDVv4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUApo9evEl7rBm1N8uUJoFEbCKFlknlMaZTfexMW9JmC5ZlYUHhowBeEt6FqP57ivsLHfu3h9Efr2GcyGyRnZwNTM1hXo3zU6zY9HuX/bIKx/a1L5gb49spwikfhvOHrzgxcWxfU4nfEY9GRW+e7naIlsPxuskD/I1gwNJgHEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bMpWdjx9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aP5inqn8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bMpWdjx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP5inqn8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A74E7A0072;
	Fri, 11 Sep 2026 02:55:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 11 Sep 2026 02:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789109718; x=1789196118; bh=L/a+K/CcFw
	rwf7vf1gl2u+RPhpRAoW4LZVAzwui0uz4=; b=bMpWdjx9jY7OxBOu/5L3S1PMAg
	13nC9gpssoY9cXs3JjA+Tby/aPjzmoiTWmZWooXwvPDx8NmfP0TRjlx/Y9f1Fsge
	2rrmSNVjWfFizeujxpJJx9smAgGr0Abu3j41gwomicMoanxUoR7n+Vf91DvlLPAK
	J89Mdl1/sRqwRgFZZIxxzyiveF0nBziHIRZj9vtgQQ94KvvW+vNMUIJJycjV7IAL
	mQNGF7IOkZSZh6PgGA3C8c8gp6dk3qOhepOLRCYa0GU1H/Qlh+hL7+pWZwuuivM4
	lMwWFzTQleHtzKIkItEqcmF7Vkf39ZYXZwH7t85mSzOHA6P5fdRaEefZBFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789109718; x=1789196118; bh=L/a+K/CcFwrwf7vf1gl2u+RPhpRAoW4LZVA
	zwui0uz4=; b=aP5inqn8BfKfhBLNqy+6nSNd1bdu3uZCYm1F4RZRtgJ3yb5Hn7Q
	VJsLfPCLOU5LoKrihGuBf13USgbTMcqg5HyTN2p6IUCPp4zqxCpcwBToxj4tXFTA
	W7pKrfwfTrja0qXayjZ9JGkVLwzfEfT5QnjTsdIM5wqfgcoGBm5t/LAq31XhB/5P
	gRKuN1kD5XvrFALAHjj3dyUMRECQykrgWJFDtUPL/Qj0WqZgwEEtJdpEDI582ft2
	3ApOGvSno3//HcjEYhBc/FVS9Z2mm5WOoY6HFQ4qJKuUbZrCpLRlcREbxpgJLPU+
	T7Ft7Wiw3SVhJC9lLFCzOwM7qlmqjrX3nZQ==
X-ME-Sender: <xms:1aWjaqnggNYXvIuAlIab5mSmS8sAZ4pNKTNdQ-jIjPZohqGy4bBS-A>
    <xme:1aWjakGCUcc4pCdTF_QYe59_i9lwshyK3sgkn_qMtme0lF-XMP1_LeRnFoCpu9UhV
    SvsOMoiWhFHonvIiuaxid61SCBwN1uvjYofy7aVODhkqLazGQdAZw>
X-ME-Received: <xmr:1aWjaq636nVvfSDZLnj4kg9e2gy8yZfcRC5_jP5o-Jzap_DfyGBbXfixXShHGTWmpPRP7w>
X-ME-Proxy-Cause: dmFkZTEV+JttoCnA4V+/Z0K905orRh+b6OEc7ploZuEr1gjifMLJ/49pzYntwFHzj7xSYj
    vU/5kI2IMhZ/b4moFvB0QYVaT6ZbIAa5p1q7P4gdx/uH0xpYPiIlEIeBCxddhuaDlvwdjX
    YJiwg1i4iFMXQ5WyG1dKxNKvHuMbk+IvSrItabIxW6TJ/1S5Nh/vFcDAekj0NSPin6SnyO
    EpzR7ggeUuUQC3x+ooYVx7WZfMbC+RjJiMYzCSXpg//6TdfsnqwGcwXRfOHFTLEnc/FE+L
    ZHvdYegDNyJ0iAA1HWiewmP74ak/72guaUxC7jvDZeIv2/FaN+ACWTlt0I+t3uKmwVPrQd
    50DOgR8xuIj2+nhK4ZNYBHqfwS0oHwRh1js4fD0e8oMNe91RU5TN6Yhp7GLQNUjfxqi9CJ
    SBLyKMhKD8Wr1oMdrlNpEq1aFytijNjW6U5Dpve/GOtWUUK38eR4lCNaNXdHohw6PCRYSl
    GmpV6AqYs1Hb95CnqYa3yvHxDTOrWSUZhkUHT8o22KnV6WFh+GbiwxGiH893S6QGrRb+6R
    3EjlVY/1EDpvhTBwgl/EYZPZcIj2gK2xT67J0ASVsfYAsYnO2ilLN03nmdFvcbjH8wBwwn
    gBEVo2yiQDM+ixX24XTbLJQftUuZ5lOkslxBGNr09dXCyjjEwQ7TarXybACw
X-ME-Proxy: <xmx:1aWjakn3Dd2VYQWj38qz1qwHwRE4YnXaBtFnOA2dKMHAeLp3obKuog>
    <xmx:1aWjanq0HjiOIOl7VERKrJX22qar444WnvkJcg_hOmwp0Eh9IKOVDw>
    <xmx:1aWjarvT_fmdY8E_DbQWYv6ReauUm_zRCsDxkQeBY_NBWoeIcGqgZg>
    <xmx:1aWjakGEi0tkVVUi1w-HGjEfLVQ2CTkZvHCPvKczZIy_ZAp4xsFb9A>
    <xmx:1qWjaraLdh1K_ZDVx20V18WHEU2kOT0H3_2I9ZApRAej9j_y4pDrgRc5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 02:55:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb63b7a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 06:55:16 +0000 (UTC)
Date: Fri, 11 Sep 2026 08:55:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] push: fix --force-if-includes detached HEAD advice
Message-ID: <aqOl0SnPHa5iM_tz@pks.im>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260910230506.1631656-1-tyler@tylercipriani.com>
 <20260910230506.1631656-3-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910230506.1631656-3-tyler@tylercipriani.com>

On Thu, Sep 10, 2026 at 05:05:06PM -0600, Tyler Cipriani wrote:
> diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
> index 257db58918..a0eff8bbd6 100644
> --- a/Documentation/config/advice.adoc
> +++ b/Documentation/config/advice.adoc
> @@ -90,6 +90,10 @@ all advice messages.
>  		Shown when linkgit:git-push[1] rejects a forced update of
>  		a branch when its remote-tracking ref has updates that we
>  		do not have locally.
> +	pushRefUnverifiable::
> +		Shown when linkgit:git-push[1] rejects a forced update of
> +		a branch when we are unable to verify the remote-tracking
> +		ref is available locally.

We don't really care about the ref being available, but rather about it
being integrated, right? So maybe s/available/integrated/.

Patrick
