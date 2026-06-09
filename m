Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD92F5A0E
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 06:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985195; cv=none; b=eaK8fbRCnzRKr3+FST7oJKIwIy7NIu3yMqpntinnFYcXPu37u2uZT8nm2PJ6ZzvO2JgDSwX/AYoZmSIvCKJZVwrHzRvPeeJ2J46O1rUpEJx+3pK2/7kgTsGmE/2YKKadGPLf15yDwZJ6oHsY7vg/k7y1EMTy9ui7tJLoN4W44K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985195; c=relaxed/simple;
	bh=48KBodp5iITw8rEyJKg9w7+oJpzRdUEkOJ6mmXZ38lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHpgDXHZRryJ/PVebsxQKHJ/DKm8j6llLc8XOTjkHn3d6kXP/ll7CZLL/6d6/62APV7FfMmjUxv+23sBSzVt19d8EMC9RsJAX8nadRyCgQg6WcwVg/U/CGwthKI65kNNwGkoauRYWYVcQQhlO7vzfcojPAMyg/bFaqGNqgb5Nb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hLCnLfVB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZ8ubBSl; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hLCnLfVB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZ8ubBSl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B540D1D0014F;
	Tue,  9 Jun 2026 02:06:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 02:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780985193; x=1781071593; bh=ToZWuEaDUI
	7hb2jPpbsMXw8ljn6gUy13hHfb4ZVes8o=; b=hLCnLfVBFnPsxXf2Qlkrefar0N
	FpRickc9CyUFs0UPdWjps6f0Qms8hA/hJiOGc7cjCVkLwuLzYFs1E6LAtKqm4UKo
	c42SInztQ9UaG2EJdZRWoUcELHIJjGYEuPC/v1MP4omMDU9Vj6eWCzUP5KY7Suup
	QfB6d1vUIylMiCW7EQu4Tgamxdz1nlGYI0gYOmNE6ex0E1yLc4in96Ncf/r9mZV4
	N6ZEni5a5fRGQ8Hf3KseUROPfssk4yf7kKVbsXrUx+VXhuygAs2+WR41UjxZh+lT
	CWbkHvkX7q6uf/b6naQpsTZU9MB0UOCuYeU7arxPN9IuILF13K0o83dNT5Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780985193; x=1781071593; bh=ToZWuEaDUI7hb2jPpbsMXw8ljn6gUy13hHf
	b4ZVes8o=; b=FZ8ubBSlWuIaMqDix3RpbIeX6+oePUZQREReyH0+siSuuSRN70Y
	Cb4xVuUoTlJA3FDXOs0qOSasvVUCnsSpgnQ1MZzJ7/gHw/o7v75Ma1ZprWlQVq5R
	Rjow5Lm8qzO9zsnTWkPVKTnIpFVbPrjeVV8AbUVfRQ17RbbsaHs7FMJyGTtCS85+
	qBizVay6CpG2/9CT3eZYGwzU6vjL6sfFWwnoSR13zoj2E1YiUtMbU6dgP2GBoivD
	RoOH7WGhqAIeJz4kiHx6gj+W94/JvngTiKNWFOJbPfM927S7xK9mgnwCrRNozDao
	wkDeopkJJE6yRLPvvUYADEo3uUYxw7CK4IA==
X-ME-Sender: <xms:aa0nahRv5R4wcvgNuJ20i1wWXhKhf7P0IxbAzVq96gH1ou58WgK_nQ>
    <xme:aa0nahwEG2vFzTwUg96ikMJSp7hmn-dTXPzt-BhBZZR4s4yj7qXsWx0SXs3tpwHsn
    zmIsodHvGL4GoVaQA8D2xorBUWTv4cO6ZOpoLwIu4v60CxJmjv7zA>
X-ME-Received: <xmr:aa0nar3161_Af2K_iCZOkF7f5SK0H-mw0k_8OAcFxWh-CcC7t7dzrJzyMtYprH22MKk09y-44KvHzVovW21pdDHPxW60TfIsd3iIrgJ77BM>
X-ME-Proxy-Cause: dmFkZTFWkp3MfqtT4ckQFOSIYbM6Jcybu9iUM9DKcl7l02nkWJlcFdNivY9aTPIB7u/Xvi
    InyqaiKBHU7Q+/CPijzLnh6pSy7PfuiGETQilhCn4FTpH8RBKqyrwOkMrGogmApHrKHUjm
    pdcqh/HpycTjz25Gab0TW/4xoJBKakXCDMAF+rw21NE10s0kMo5clUcS0ZvS54vlgSREIO
    x4JvaATakqXohgmofY74PS1PfJ9P/NOHJP1vE3t+QLaHtMvW6ZaMLYtHlFX2KvREn9raFR
    2SGjcCzrp5lglzLYGk5LzyQPPDgy5FFCtg+8HgXA2S0QWE6u4546Lg+zPdaqeBK/C34HEI
    fiRfDmb+wyQnxZGqs/+NAfoH8VASJM0Hg7N1EzY4y/iatFbS8/nB+kXG9QsfhCZcU1PQQy
    nohmbJeFM2no1HbPT/4rYIW5/V1vDQkQlN3lbpRZ3fe84NJiArBFZVdlFPLyDCmPbBo1z1
    1+O+ZrbOvSmayONGihTDO2lkCNwm6pQqRYawdTzYa40k4NKj4gUgJagImlTlow6cSb8gtY
    1yvCMrLR+0nwkiY/Cheoi8Ys3eX7/QS/+a86jp7srdM2xG7rdxmAKlYwhW6kM2jmxB4z5T
    FbpPp9XOh/YSCoXR9ZhTB2Pl2uuc9eLP8wwzi2e2EaBKl3bk3E61oXWiwwvg
X-ME-Proxy: <xmx:aa0nan59mx89I6MNu1YYMVsW2MgmkYjfJYQEIcieBfaDLgVX4ptbWw>
    <xmx:aa0namXYXMmHF3GwTf0TBlW0tbP9agXpEmvChyc0CNBMEDCsYIOohA>
    <xmx:aa0nauAupYgTxIg_onZl-tQrlV5689DKUtsQkU_9DpgFdRcGwqmUJw>
    <xmx:aa0nat5I3ZRhGbaPYJv2cjl-mYAGfadtY6JnsONhNPDHt8zwj-H_5g>
    <xmx:aa0najXKF3dWQNkeaB_JrV0Ac7Ulw1pZfaQ113z6tyigpMOvL1Ec7-7x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 02:06:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e38f6788 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 06:06:31 +0000 (UTC)
Date: Tue, 9 Jun 2026 08:06:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/3] config: add GIT_CONFIG_INCLUDES
Message-ID: <aietZKn2-nUKpeQz@pks.im>
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
 <b48fe9f7abe794864ac4470c2620048c2e5e6b53.1780927027.git.gitgitgadget@gmail.com>
 <aibTAOrcSvTOtv78@pks.im>
 <dd971b9e-2c13-4521-b991-b9bee1c5bf5b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd971b9e-2c13-4521-b991-b9bee1c5bf5b@gmail.com>

On Mon, Jun 08, 2026 at 03:38:55PM -0400, Derrick Stolee wrote:
> On 6/8/2026 10:34 AM, Patrick Steinhardt wrote:
> > On Mon, Jun 08, 2026 at 01:57:05PM +0000, Derrick Stolee via GitGitGadget wrote:
> > That raises the question whether we can introduce the configuration in a
> > way that it allows a bit more flexibility than just "yes"/"no", like for
> > example an allow-list of locations that should be evaluated. But maybe
> > I'm overthinking this.
> I see. So we can say "avoid including into the repository worktree" but
> that will probably be incomplete.
> 
> There is room for nuance in future expansions, if we can find a creative
> way to handle that nuance. For now, I think I would still want an ability
> to turn the entire feature off, at least for certain tools that care.

Yup, that's fine with me. Thanks!

Patrick
