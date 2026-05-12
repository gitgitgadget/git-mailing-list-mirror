Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5814E378D
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567202; cv=none; b=svF/c8aODNW9283rHYskcaJd0lphVxflAEMpi0dhtOMoFUkMTPkx6whUmTMWAmQCc+My74kjwvG5uc8Yrl4dJ+A+uaa9C42vWCtKdgTNRZFg3o+WNRWgPHIlQRd4ZMo2xusKm3GRC+YtG3OtlFk0duUz0uKOGQqs6HuLKSsJcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567202; c=relaxed/simple;
	bh=xK1kwNSimkLUPSn5inJnQDH1vk7/1oMZEr5q/NghHx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YoeoeUiCjlvRh89WJhq8hM07WOErcqNPOC6j7o5J5t7uTM3D82309U6M/P4n1FH9idHpgcsh2l4Cnxg/44+agfqpe/nVSP8xsdxKo4qs9GejUAuwBFqva0yv1kMSbNVk9bzQAZbOXdhoydgZnSzM8oflwjTPTGVG8kWJ/ql54aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BP2D6PeG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SK8pLrN1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BP2D6PeG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SK8pLrN1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 27B73EC01D4;
	Tue, 12 May 2026 02:26:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 02:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778567187;
	 x=1778653587; bh=GVWSamrWtUG90sBF9nej1EMWGfk5WgQ3w5xWBPyKr60=; b=
	BP2D6PeGH22TujHvd+SlV64Hdq2H0rGBrqHGGXekD8jun8PQmL6A5lAWLbafQwxP
	iHMwIY4hF2MhB0LOnFJa9PHwn7EVzsEfQRKpsZ5H9TElNcsPHNVQWqP2cmfRzRoJ
	NOF2AGJmOBcV/WPH1JtmBWPXo//HgEY8qq+LwfMGFEC6jR5cr04D+1VwhmFKRKnc
	JzulbEfkwyImhESMTWp3Un6DZQyUlsG8OQfdHXXwK5PXPMNWyOtcTNbeP/28EqEx
	yy7DTbkQzxWcDl9DHuTeHvGrEU9+/+r3onlLuvx8pLOmaXKPym91c02d3xROA6/I
	SToAw0TiGbxiis9hq0aWTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778567187; x=
	1778653587; bh=GVWSamrWtUG90sBF9nej1EMWGfk5WgQ3w5xWBPyKr60=; b=S
	K8pLrN1gWg9+O+aORZGPg7VXysN0hT+teu2fWXTQUNwL5jnKK7ZuZCVWHxG6jlvT
	Bmx0v+yHNToIGO+wE2zYsJjmzUVUpj2HQnuZCEYbrXONIMpiP+wRnT5Sv+2+vqys
	cx5Yt9QubAAiZsrYCkVMk4U+mxuBI+oIbldAzQoh9+njo8YKlpFIynCQ2ya3QdIu
	5NfsRBsL4AwhbDmmxcdrJQKSCoiKqaDQWAhbSZ2OGuFCs0l5mCIHfxVp+ZlYPfhU
	OtlgSq/bsrg+5iC8xHqYENmCKyUyJS4dUBZu3VeDIR0mIsAZR/xMBxi0E5i8wEBi
	iKjE8aqCA0KRIt7E6w+fQ==
X-ME-Sender: <xms:EsgCaqOoMo3QAq5KZfpPytGGHxIKan7ebSGCNyJtukwnxcL5I50nhw>
    <xme:EsgCargfDKVFu98onLEJXc_4I1YG_XjjmfEBo7o-NR9B0jWuNWUah0kB01Aph7Lla
    _BpACvfxSVfK4ZSVa5SyzxIa8JZQn_Cyv6LGyxDjY3RP67v0TJS>
X-ME-Received: <xmr:EsgCak6mZn9BM_oTpSouilaujtoSMe_qEJEIWXqz1qmS-RxxsmLVJJgn48VPO6K9blekhPtlwcVzUo9CxBWeTtepfzUO5qWM0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehprghulhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghp
    thhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhthhhusgesphgruhhlihhsrghgvggv
    khdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EsgCaq2Yk3nPufp8JW08lOwXZ9sD5hptl-OjbefIDN24X83ycigWUg>
    <xmx:EsgCanuf_6UzBeS1_Ss6Wps-UnL2PHcx_XqCgqcBQu4E4FTmFLdo1w>
    <xmx:EsgCao4fJRjSkADuAxObFFK_NQ21NWzCUB9EdEx3SL2uuFVqd-sWqg>
    <xmx:EsgCarf_FqbI0PShltiapNaw5xSFfVxp-_pSF7Ia8yntlBZuZeK9qQ>
    <xmx:E8gCalzY6wp0bFqaLvNw4QlxnVOMgLnvg5oXirPW8xih02PVnfNQMjeN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 02:26:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  =?utf-8?Q?G=C3=A1bor?= SZEDER
 <szeder.dev@gmail.com>,  Jeff King
 <peff@peff.net>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v15 00/13] fsmonitor: implement filesystem change
 listener for Linux
In-Reply-To: <487628C4-596C-4870-A652-E1670C700AD7@gmail.com> (Ben Knoble's
	message of "Wed, 15 Apr 2026 13:50:19 -0400")
References: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
	<487628C4-596C-4870-A652-E1670C700AD7@gmail.com>
Date: Tue, 12 May 2026 15:26:25 +0900
Message-ID: <xmqqa4u5nnxq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> Le 15 avr. 2026 à 09:27, Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com> a écrit :
>> 
>> ﻿This series implements the built-in fsmonitor daemon for Linux using the
>> inotify API, bringing it to feature parity with the existing Windows and
>> macOS implementations. It also fixes two memory leaks in the
>> platform-independent daemon code and deduplicates the IPC and settings logic
>> that is now shared between macOS and Linux.
>
> Troubleshooting a Gentoo build failure of next has me pretty
> convinced this topic is in there already. Junio should probably
> check my math, but I think that means we want to see fixes on top
> of that base now (unless we are reverting this topic from next and
> queuing a new version?).
>
> (The failure is a Gentoo-ism; we carry a patch that stops applying
> with this series. Not anything this project needs to worry about.)

So is there a verdict already, which this project may not need to
worry about?  This has been kept out of 'next' after getting
reverted but if the breakage was due to Gentoo-ism whose workaround
does not need to get upstreamed, and if there are no other reasons to
block the topic, I am inclined to mark the topic for 'next'.

Thanks.
