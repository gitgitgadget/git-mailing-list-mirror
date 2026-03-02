Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4278C357A4A
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452422; cv=none; b=aopED3sE+aHLfn/dqolv1hNwooeXnMd2LQKkH3r6CjM7N5ZwYosJdHNXn5t3mgMtMTYfM+gnIOqpARBfcA90bKIugjd1uwzZK3xGMCdCcx/zXOdn99nsqKF1MNJhURFQ07GOYgjOndYAnfXksKRbH70qrhh5BRWMFvawAJ06YVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452422; c=relaxed/simple;
	bh=EdCi0wqpGHA/+MbxNW5A79aNxF0DVMeRg/a8CNUcINU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd7R9HvGuIxS/C4/ztuZmRHau3mTbiUxmBnscor7uw3LeTmEVAvOftvbYxLgmbhfYRKTmSBq2T/erU+l/ADfSYrDq0YW7lMYmhUXjPe8iDkcmtXmJkeuze8ubIu8aKUXLSgoGip4SS4Eea7wGOgO6rJM6j1jC6TfYTVDhQWA5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CyI5dLFy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VO6/fxii; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CyI5dLFy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VO6/fxii"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 48B78EC059A;
	Mon,  2 Mar 2026 06:53:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 06:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772452419; x=1772538819; bh=J7OLgIl+Z+
	j5aECTHVKfhZOYM/GYB7fucoZL3GLeoiY=; b=CyI5dLFyDe3H4vkC6m4c4R+Om1
	fY7VpUk7y+dKiUvohYsScgOY42C8qlepQJBsDZmlxMZkiUFqfTos+N/BlKVAjfXv
	f4HzS1bHsxRSJjzmgrv0dq17WZNa2CeHdivyBkvHpbhwGCwcnCERNscd+j+i2/ac
	JgLh+V4HAs0Iyx2JXrRmOfzNKbR2PI99srbPpmCI5Ztxwr2Z8f7P+YwMZYvnAvZE
	uptXmocgx+oLhFgWRGM3R1URRaZXTUB0QBRhPB74PJA4xqI4z9LQgQARBj6asl4Q
	COcqRFMCssIWM5bpG2Ab8bEJpIxXu6QRiDvmb8eSB+uFltpARTbXW/gqN/XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772452419; x=1772538819; bh=J7OLgIl+Z+j5aECTHVKfhZOYM/GYB7fucoZ
	L3GLeoiY=; b=VO6/fxii9M2hSxcxwqjDiHx4U2+HA7QvoS96pabyCDlMSbvcCDq
	NUl62UWf74emWtIUTiDOf63EDDjdMTuyg2BiHLBkNWvMHDj+ZHZx094MhgqTskdD
	ENjCXWi+ePAFCXloQ//aMp7lvznMHgMr39glk84bVg5wKT3MQQMsa7xrnWtC9hoT
	o7S8cnatpmR13RtytfLiN93He+JKwDaO5jpujYFl6Hvf6OWE2DJ056JFNvWB+EFw
	/8+2tsH1VwDv+skB09rgV73TiFfzHJbsyPWDNW8MqSI8S1iDodsyLn9DdMqQV/UB
	PYkyyOPZ7+fhlnXbUUtl8FL/Vg/0lbwSE7g==
X-ME-Sender: <xms:QnqlaXxrX9Er-g-xj4GoCG6ray1mrH6MjZKUZ1sr9umkRCdlVuZUIQ>
    <xme:QnqlaRgwUH21FOZgaDrfD0bTIy4ZCFG5eEDjP2UFo-V0Arptu4lHUvWVzzVQR0JoM
    Yq3A4c_uGvBFjzKmKGwDqBFN0Gl_gWIxZktIn3E-BzhMf2ITg6i>
X-ME-Received: <xmr:QnqlaTnmvXdixI9OcVD2ZbwfksGK03XXgGWi08EoZrwaQgrLEWkZ0b_m4zjMl-F0HWxVfWr_JHXaA2K0dVx8hLh7Reb7rpqywfl7fVTx2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtoheprghlrghnsegsrhgrihhthhifrghithgvrdguvghvpdhrtghp
    thhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QnqlaXiq7dFmuwDpA2lHokOWdzJQL-HL621UjgSLH6kmr1CRKBi-BA>
    <xmx:QnqlaX05rmdQJcDgcQYw9DJ5PAw1UZ35sUAfOpoH39m4D6vSI7beBw>
    <xmx:QnqlaQIoXmTw7ewfZEgXIMZZR2ImioYlQnULpl6KZIS3iE-nfeHUkA>
    <xmx:QnqlaXwwu2WRfJWlDp9VJUCswiXexRHqb16qhTVkV3upqLyKW3iz9A>
    <xmx:Q3qlaRYcMFDYxrM0OonYE2Z5nZ6QMJlYsawCpCvEX_UIb0oj9JPKcXCs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 06:53:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b3fc927 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 11:53:35 +0000 (UTC)
Date: Mon, 2 Mar 2026 12:53:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com, gitster@pobox.com,
	Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Message-ID: <aaV6PLJCrpb2mQnq@pks.im>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>

On Sun, Mar 01, 2026 at 04:44:59PM +0000, Alan Braithwaite via GitGitGadget wrote:
> From: Alan Braithwaite <alan@braithwaite.dev>
> 
> External tools like git-lfs and git-fat use the filter clean/smudge
> mechanism to manage large binary objects, but this requires pointer
> files, a separate storage backend, and careful coordination. Git's
> partial clone infrastructure provides a more native approach: large
> blobs can be excluded at the protocol level during fetch and lazily
> retrieved on demand. However, enabling this requires passing
> `--filter=blob:limit=<size>` on every clone, which is not
> discoverable and cannot be set as a global default.

I'm not sure that we should make blob size limiting the default. The
problem with specifying a limit is that this is comparatively expensive
to compute on the server side: we have to look up each blob so that we
can determine its size. Unfortunately, such requests cannot (currently)
be optimized via for example bitmaps, or any other cache that we have.

So if we want to make any filter the default, I'd propose that we should
rather think about filters that are computationally less expensive, like
for example `--filter=blob:none`. This can be computed efficiently via
bitmaps.

The downside is of course that in this case we have to do way more
backfill fetches compared to the case where we only leave out a couple
of blobs. But unless we figure out a way to serve the size limit filter
in a more efficient way I'm not sure about proper alternatives.

Another question to consider: is it really sensible to set this setting
globally? It is very much dependent on the forge that you're connecting
to, as forges may not even allow object filters at all, or only a subset
of them.

Thanks!

Patrick
