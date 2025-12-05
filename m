Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CC318139
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764932969; cv=none; b=qgNS98C1CURKJHt2QxqlPnz3ie02wufIBivhSQZeBnoCPj9AEUTg8p/zmesISnPezJZX9yTO+v0obUkvte5kCodDBErDQNmdisGOgYSxyNkpIoq4RNLLlcP0xPyxcz0V3mhAik46Gx9EFyJRR1fHPVqIcGYQniFvaGvkOhK/31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764932969; c=relaxed/simple;
	bh=jlJ9620geqcM0hm23kL7pn4MoxVQMrlZdyg2f9hZqwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ/WHChu45uuUmj0nFLrJHMBiqbnSv38szfrg8p/TbXkYiDsNzPVVTgdeZkm0s9Vx4HN8qRuevnIsxR1uxvjshOqD360zoE0vJ/d2O71kLf1gMSToBHSGyn1k+7cfJppgKKRgH0FFNoMB+8s70o/wrWTx8TWmHTu9YUAn/ahOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X7cHfsx4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nu0lfxUs; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X7cHfsx4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nu0lfxUs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 13E2D1D0018D;
	Fri,  5 Dec 2025 06:09:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 05 Dec 2025 06:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764932964; x=1765019364; bh=nUkylgy50T
	JbmRdO0huKHQl0tAjj6AFIAIADISG6ThI=; b=X7cHfsx4MBtLa3ULHJie/nEP9b
	28M2iKqdq+nHp123sH0lajUhDHr1tVn6GqUZ3mYS6wlMaCRuCdyVwEJckBTNp2MA
	/s63AbREMv6gC+sVK3Yc80O7lopO01ab8+R+pAJg1EKstoD+06uxlRH7crh/hDZj
	b/6209Qgy3PWVrKaZbItcZmLdV3hlHfFjdEorzs/lCbtQJW0Kbvn+g27go7in4MU
	jIrxG0ymDq2puyF1VqFJVo8gHtdpR83gka+EVdhTwQ88k2zzKlcVLtJjBW9Lb3CO
	pUL+N0k3xx0XHpbdHzYg9IePPrJrDrrL0DQcaup2BZxc8Bdlu6OhMbmapxvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764932964; x=1765019364; bh=nUkylgy50TJbmRdO0huKHQl0tAjj6AFIAIA
	DISG6ThI=; b=nu0lfxUsVY6VKFt0QbEDW6Yl45mQANpzYiA9nxdV93PlA6nbijU
	WTEIeMvu4POYjU2Zs7pmJviN3r4nV7j1aiS16DVmtC44TwZV8n2sE3tAIvG47TGr
	7BF8Y51IOn4+O0YfncBLFuTbo6x+cisj0mRILL9C9iqr10nXqOs0vW7+EEhX52t6
	JdIhQ2DNe56ZaORWKeSPmS3JKXvqCuhOTWPnriE7aHeP0fmbCLaIbRXi61di+fRd
	06C2xuqMq/YHEHeQVeFvJx6zVVL7ag3nCZASAK9ZKAo2lXUIR9Pl3SzXwCbUYSnh
	GgoSiEkr1pi66TZtTWAamXMN14/rqtz4/NQ==
X-ME-Sender: <xms:ZL0yadoFVIqU4evx6lNOhktABwPCZzGSvmFkzphx7ydhWXd3KIZgmQ>
    <xme:ZL0yaWoaLzenWcwY1IHICZx13kw3t-a4RZlRdQ3rZ62RLWfWVgBiUz2kFnEYBBoGg
    YJmzA1xthdnMZkKil-B0k4r2ei3-QcYgHSmRX2ZodKYVknM-K7A>
X-ME-Received: <xmr:ZL0yafOIa4SGLXcAdko27TPR_VT0Fi_7nRbwMt52ZBVReUkaAJ2eC48FTdcgNVadZrjHvDmcG3LO2tTQR65uuj6ZHGIdkJ-4CnKoT29S0LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    lhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZL0yaXyv99FbYwAhDFWeIQtC4Zfl8VT2MhUggLWFacSwd7yM_PT_zg>
    <xmx:ZL0yaYtVsOmyQTxp3yJ3rXkqgNOk5AgUUgGefUnVXMJ1f6r01uylTg>
    <xmx:ZL0yaQ6cqaGbP_Nqmek35SVrV-e8fawHMihBnz3KPSsApga0QJFZow>
    <xmx:ZL0yaXQZP8BmW3Vy4Wb69-jZho6UTvdV73KfZx2M5kXQqoelQlXJvg>
    <xmx:ZL0yaes8pR7NES6KTp_L5Et8voaJq11YROBdnq3SS9MsiI21Kzkr_84g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 06:09:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63ce0a19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 11:09:22 +0000 (UTC)
Date: Fri, 5 Dec 2025 12:09:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com
Subject: Re: [PATCH v2 0/3] repo: add -z as an alias for --format=nul to
 git-repo-structure
Message-ID: <aTK9X6ptrqs_9agD@pks.im>
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
 <20251204210843.79411-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204210843.79411-1-lucasseikioshiro@gmail.com>

On Thu, Dec 04, 2025 at 05:10:09PM -0300, Lucas Seiki Oshiro wrote:
> Hi!
> 
> The main objective of this patchset is to add -z to git-repo-structure as
> an alias for --format=nul. I'm including two other related patches here:
> 
> - a patch removing an extra line in the documentation, which was leaking an + to
>   the generated files
> 
> - a patch replacing `[--format=...] [-z]` by `[--format=... | -z]` in
>   git-repo-info's synopsis

This version looks good to me, thanks!

Patrick
