Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237B2505CA
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377030; cv=none; b=bb+yIeoyJ0WLBxUhPlVqK3u7Yaabf7CBePURs31iUOkYy2yLT9W6RL4n8x6A5omdY2V4+adv7lUWPuaZye45N1eIGIgJ6GZyoSHDIyUT7mG2YwR6aRyKBj/YLpk0msYbLaCmprwpWQgiDRU2IULPJ7RalPEo+l2Z0lEM3hkN0YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377030; c=relaxed/simple;
	bh=KJHl+Ktyh+2QZ0V9Aq7EMw+BJZpGiIaspnlYlygYufg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCsKmIAV3T3brun1WOT1fVf+pSpHGclyWhCJqHmpsVhHp+/2eEFePCmoacJY//jcVAuEvcU+jYlmKH9oAzF5ObcVRwFa64hAeaacDAETOsK+wsA4JUaSeCxi2p5cjjW30e/RTY9FWNHmcKZ3rvADHpzqFfDIfX7ZIcIYwFqyJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TD8PaL/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ctoG7/6e; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TD8PaL/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ctoG7/6e"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 89A7011400C6;
	Wed, 19 Mar 2025 05:37:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Mar 2025 05:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742377027;
	 x=1742463427; bh=wloUW2mrMB8xnv5OwjMCxQZCftlDpplVVvInU4vatH8=; b=
	TD8PaL/wjjF6iZ3svxf4tkDsJkaafFkCQrVGWWI34f+0tS4vjXJkT5u7ey4KZQyO
	YwokpoN1K+W1ME8L2jGE4aexbliUJBvOt73lwLr/qHZScM9n4AOSH3nrLQtevo3S
	/eaktX9+udwnE0EaooWRrxUe9d3GaQXTgF5X+07NSpwYHAsebniV/yIPjQOyOILJ
	AQNTZdctlLWWxhsITLXYWGKqSUdAlv+YHZb4DbIgfpzIwpzobUgZ914XxOxfrz9M
	GfWIibIyn6U90bBisjzVvWHWVAObOv15u+B3gECcqfPXcJVezon8kX3yG4ripJ38
	BaVb3dCYC+xsBDxKl0CFNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742377027; x=
	1742463427; bh=wloUW2mrMB8xnv5OwjMCxQZCftlDpplVVvInU4vatH8=; b=c
	toG7/6epDkVCfYo79+IwGlcYRQqQR0awbg2h2rMfedCxLwVNSS024xmURQTm5O4K
	MsFkX2JQwyaF03OgHNuewp5it5ce+UU+oXWU6ZGbQI4nkzMSegF2jfelTYfnd9Xo
	At9R46qnZ8Cz2jmSJrQSfWdODt/xuEsGz4Z5Bgzu5YuedzaD3HhF/qLkhFaSBU8I
	w+CI1y6cQiDHUFfX9tFTgIFVN3Z+mvG8xorYHRwbljURHXREnwfDUNM2283vOvFD
	IHf5lrUk2zTXyL5XgGHEZp3C7wlijVvZ9d2Q5ejnswep+CRpqlwvaR9J6lhpmlus
	5g0YkAjRAM9Kx0VncDFzw==
X-ME-Sender: <xms:Q5DaZ9tRPzrckkrctZzU-7dM1R8LoNiyJ-xaZyIXDafeyw8tmv1iQg>
    <xme:Q5DaZ2e4WlgUpx90Iv3Hs3tARpSYvRSvJKIWWDa6nz9QEuLZwyBUijX3OT8c078ls
    P5frTNWSH1VIgRiVA>
X-ME-Received: <xmr:Q5DaZwxmoWhLsF2Tgtndsuy8nk1F1nunvXxWCJuaiGTsdXnRpgisYbbfvMAj5bLukD3gabDqcUcDoKYj05a3Lhktw3REoEt8eeCP0xv9GgYBUZOV-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Q5DaZ0OnWk4zSFgcnZHjWlgOcIqIrCpPLGEsHynQELNnjAiWyZ6umw>
    <xmx:Q5DaZ98t51aqrROQjfO4cre2_ogjA-vZCJ1-uAwXNk8cHhdAhdJa7w>
    <xmx:Q5DaZ0V-H-BQDCA4W8mRCOQCL1vT4VEriFNO5TUZhzDnPfnlaqFYhg>
    <xmx:Q5DaZ-dSFGmTajj97dY3Svynlq1EDJwzSMBeViUutwsaB06RwsXjMA>
    <xmx:Q5DaZ5a3cPQWn0poJKSWYhik-VLjXiOOGAIkqRqTG_WCMKDyqu1U6DS7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 05:37:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0769feb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 09:37:05 +0000 (UTC)
Date: Wed, 19 Mar 2025 10:37:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] meson: don't install git-pack-redundant(1) docs with
 breaking changes
Message-ID: <Z9qQQAhFk-MNwiom@pks.im>
References: <20250312-b4-pks-meson-breaking-changes-v1-0-b89e9a59d228@pks.im>
 <20250312-b4-pks-meson-breaking-changes-v1-3-b89e9a59d228@pks.im>
 <44a3ad4e-fb50-447f-bb66-f43b5c5ae012@gmail.com>
 <Z9gqP3ng0a9Zfpqc@pks.im>
 <d341777a-a6e5-46fe-8004-9fe885321905@gmail.com>
 <7fee83f7-995b-4c84-9216-caa6803a69d9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fee83f7-995b-4c84-9216-caa6803a69d9@gmail.com>

On Tue, Mar 18, 2025 at 10:06:51AM +0000, Phillip Wood wrote:
> On 17/03/2025 14:50, Phillip Wood wrote:
> > 
> > Oh so if we have selected breaking_changes then manpages.keys() does not
> > include "git-pack-redundant.adoc" but that file exists and so we need to
> > add it to the list of configured man pages. If breaking_changes is
> > selected then don't we end up adding "git-pack-redundant.adoc" to
> > configured_manpages twice? Does that matter when we come to do
> > 
> > actual_manpages = run_command(shell, '-c', 'ls git*.adoc scalar.adoc',
> >    check: true,
> >    env: script_environment,
> > ).stdout().strip().split('\n')
> > 
> > if configured_manpages != actual_manpages
> >    ...
> > 
> > ? Also I'm confused as to how that comparison works without sorting
> > configured_manpages. Even if manpages.keys() sorts the keys (the
> > documentation at [1] is silent on that) we add some out-of-order entries
> > to the end of the list.
> 
> I think the answer is that the comparison always fails but as there are no
> missing or superfluous man pages the body of the if does not error out.

Yeah. We indeed may have it multiple times now, but as you noticed it
ultimately still works. I didn't care too deeply to avoid the
duplication because in the end this step is only used to verify that we
have all manpages wired up in Meson.

Patrick
