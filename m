Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71C1E4BE
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764381413; cv=none; b=htQMhY8INWkJyjrxTxZwtNnB6oGflf/bDg5wUiw54TE1t46nsAnaCgSAgTNoj8OE56ng/0kly+pB+Lxu9+py7EX7wMIBNeC9UFeHr79oISlZLZMJyxwqlHk7JaPy/wxb/jxRcRkDdpWwCtl62ILa/qwYaG8sq93z9xGrHKn56/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764381413; c=relaxed/simple;
	bh=mR63n1uGvsv4fKo7GoaI1MgRZDrzFxB2r4QLwGHQfYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aZiXoOhMhrHeBfRCem+3szKfGoaciNpGoYvsLrf0kmXcT9hCJgR8/p8P53fRyn3Gy7Uhq6L9y9ISwt41aM/ZkT+Y5kIbPAQRdeHalct4dVqUXBGOM0oOVDUfx5PFvkLHO9xPkuvvS5TR0rbJQngsSDQo8V4JV3noXpxxg+83QKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YVlT+HAk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6irzdNl; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YVlT+HAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6irzdNl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A5F201D00358;
	Fri, 28 Nov 2025 20:56:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Nov 2025 20:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764381409; x=1764467809; bh=kuVRVCdlYj
	xuB+bp2vUlHsflyVeXvhcGvBz0sqUivKM=; b=YVlT+HAkSe7mofsFiZwAMKb46n
	0pzFwIALjBSVvsDOkoesZXmnX6l5fHyW+kk1IKSyIW2XiZXT4/sd5R072iegxSjb
	YQQHITtjK9yxcCCoQ9teaB5bDqWdjyEO/9Xv7oAHPrcQBPXieaaehvmSq3H0WU07
	EI3ckNva4+pDue5bMsr6B1NIyUiqR1TbLboth+GwBQrdaAdYd/2UeEVs1mss29zH
	e6jREKNg+vaJyc5VjGwQssXDV1VvF7xeJBXWr5it1JbVk3zfu8qjbftE/KmdlaKB
	0p3uPnYPWMl7ZxqeXcxAOL2FeyNNoX4aG7xmqEDX/S5VihLFABE63LBqXfkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764381409; x=1764467809; bh=kuVRVCdlYjxuB+bp2vUlHsflyVeXvhcGvBz
	0sqUivKM=; b=N6irzdNlX8eYacA/XUqKKmvSNCeE/8L0UF+ssEdpGe0zYzjW3zc
	RpiMJi2CokUXJhrFFu0uZh+wCgSOnjS8Fkbrq+cm74iUyCAio7YCxSMtXPcaXIxh
	poj4ASueOawLgdXYM2xrPB/HDeUGOg2677Crpw0/azX4PNJLBhx9zOxAuLKLsTAz
	52gZj8KAjB+bj5YmI3EySKrL8U4uRYg0lvRnvlgiJCnvjJjiQD5jn2rE/R+oZgGB
	45zjtN8izYN+j2sWFJuOm67XdJIg4mJ0v4vCcG0q/pd/MN4JCTSJMSnNuOPFmJxg
	5A7GN1ZlBehOEWw5PI3HwVD2TmMwp3qwk5g==
X-ME-Sender: <xms:4VIqaShFsDYIw2N5l-hjdzONSAC9VotAEvSoM05FjNfwWRLpuagpZA>
    <xme:4VIqaaAiPnt-pTmhmcAr8hMamPUeRKr-_VZKyh2htwlnCvGLIixYjKnTcrq5d6inL
    o89V-rdfQSrUfKn8zHff1QG_LFy754LRpgId-L2icZcnTR8VY_ybA>
X-ME-Received: <xmr:4VIqafGL-mWjgibF0kWjBwrqbzkr3KduYuCF6O0G1qAWtc22kBBUjZC7k0FJK3gQcuF_HVmiqnsDMZSNTe3kscWvBCzEjGCGlFL1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheduvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeuheelfeehudduheetueeltdduge
    dthfffhfefjefhuefhtddvfeevteeuvdfgfeenucffohhmrghinhepfhhorhhmrghtrdhs
    ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4VIqaaIptF6v9i49YOFPn1CLyORvrp7BY2CTRIQTF2tG-47Wz6owIA>
    <xmx:4VIqabl7trp97kMKxnJne4VeWuoZxfnG7Axcd4OcfKpmuE6HE2vFUQ>
    <xmx:4VIqaaQx_T2TwWmAMkaO3uGYCr7lnR8dgEcfnYSfdFZmUuH93ISY5Q>
    <xmx:4VIqaVKOgmJjbC3i9PLICqsnlu_lGueWR0JBA3qmdDXKsCDH64ewqw>
    <xmx:4VIqadvMKUwQWsJ9ofi6VDfmBjadzTL3z2FZ83dpO0xavLkuew2CFC-E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 20:56:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] branch: advice using git-help(1) instead of man(1)
In-Reply-To: <xmqq345yjejo.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	28 Nov 2025 08:40:59 -0800")
References: <advice_git-help.64@msgid.xyz> <xmqq345yjejo.fsf@gitster.g>
Date: Fri, 28 Nov 2025 17:56:47 -0800
Message-ID: <xmqqcy51iotc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> In other words, "An external command" is not the issue.  Some people
> living in a man-less land is.

Another is that a user with access to "man" may prefer "html" (with
"git help -w" or "help.format").  So this is only ...

>     ... for the ref syntax rules and refers to the man(1) command,
>     which may not be available on some platforms.  Refer to 'git
>     help' instead.

... half a story.

    ... which may not be available on some platforms, or which the
    user may prefer less.  Refer to 'git help' instead.
