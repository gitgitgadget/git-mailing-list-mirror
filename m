Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B35946A
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772920920; cv=none; b=G7epRRnABd5n1Vlms9R05j/jyjSqzEn7TGebbVQ81IXqU2BdEXkQ/IDw5+2Wb/cBYabs166ocfOwLS5ODXEd2LQR/iozW1rAVLnIQCMmZLkyDTNHL/LIBkfEqa6s2/7MQswK5Pak0qkjwQgpL8meIuYhj7D0091ArP03WZR2It0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772920920; c=relaxed/simple;
	bh=i09kh+Bxb/wn/20bXL+6DOBkAfXFh0og7xPMhoyeo9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pnvuy9TixU2WWd1rNsCdSBiLdK1DtQLsidtttWdpXuawi44fEJjeLSK1LHm/ZEbReWneK17VegZyY6Ktajci5JBRdl8zhdxEyo+W8ZjdWzuKWm/Ttar7AY+HhiyeqvmFnXCc7bFjfFDttr+K/FBk/nSrRye55qCt1QR5Kfy7NPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SL1rLFaK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BVQNh0LP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SL1rLFaK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BVQNh0LP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 248FC140008E;
	Sat,  7 Mar 2026 17:01:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 07 Mar 2026 17:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772920917; x=1773007317; bh=WQvdaMBfeZ
	l1lg4PRi1UgQq2FdjXsJ+88L53NC60seU=; b=SL1rLFaKnrLJSJFmnxDMF3USod
	8bdxcjSdJGFHVI40ulPAWbqxp8XP2m9FSFTNiuWy+5TThrS/Vj6BBkm4oiHGkvS9
	Sw/3g42CHjqNYnKoaYZKhjLaRBg9pkoRtX6oDvQ8ycT9lNBn6lCrZlIUxaa+bVd6
	IRLBQnDpx0aautAETx6j7IVt9VcmQ7S9slYKz/BRJYh6anSui7gm0atSxhcByLSb
	cF7G3kZbOY0aneJMIBF14eLGeWIGE7TbqChtGiBaGJVX7pH+GRSyOR7DaxB567Ow
	MVPPFNIniU9hUrC8jmNKI2NhHcRoWgqyiUbiqjh511Q/QRatAgI1bHEG6pNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772920917; x=1773007317; bh=WQvdaMBfeZl1lg4PRi1UgQq2FdjXsJ+88L5
	3NC60seU=; b=BVQNh0LPwc3B56ONxC3rBWYl6I6pbvLQV5TmtoRs8w0Pw3Jird/
	QAfTVzx78jjHQC5Y2v9VwOPGd+22Y/u7JxG9+btnDLtoCi9mFA6dObTkV5Rdgmsh
	zIuN/QRdWqyTpomCVqwf0U6hiuSIXMhjzTpIMVFxCBQLd5WvRiB+aCRQOqkuRd8b
	w9/hwuicuRv8nhxZ3q9VuHtJ7+I9EBLD2b71zHlHoRYT3oJ4Ihqiuns3SB8ujhLv
	Fn/Qh7iez4EiCZdtDNKKiRAu/Tjr1wYaFm7eW8uEu2cS/oXQ4sxFoooZ5xF8SGww
	dJTluWBdhN09HIEQ3XUYe6BYv+9XHHcfHyw==
X-ME-Sender: <xms:VKCsaekHnYfFCOEr5e7YOiJEhqkjhuGjgp1KVB5ZFMcUhIyS2rVvoA>
    <xme:VKCsaYG4kSr8oSVmObi3_GLAsRwla7qvz6oyR-Df8Z0b8G4L7gHAMdlRuThuDT7Wh
    YtA7mrpfafXVOeMsfhskzgur4nhe2IAWHidHDVCh-uV44u6xxSyFg>
X-ME-Received: <xmr:VKCsae5Q_-uVUyKQTqlZiadZGRKtRYfLfP1iZPiiBWdL4k7xGj3hbfxS4WMkDlQU8rz6y0WCdxtQfcdRZnjk60D7mSWUBJnwqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeefgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehk
    uggsghdrohhrghdprhgtphhtthhopegtohhnthhrihgsqdhgihhtseifohhlfhhgrghngh
    hfrghushhtrdgtohhmpdhrtghpthhtohepsghirhhgvghrrdhsphesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmvgeshigruggrvhhprhgrthihuhhshhdrtghomhdprhgtphhtth
    hopehmrghrtghnrghrtgesgihiphhlihhnkhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:VKCsaYm3gmzqUSh7UrtZFFL-LTYF0dh8qMy0LbgCrFAe-Cz_tK8x0w>
    <xmx:VKCsaboPjuw8J0v6iO85JNyXdOvXlxez2LQvtW57Vu4cpfncL7RGag>
    <xmx:VKCsafstY3h03Czy3gLe2jQEDPfo8aYvlGXbQrBGLNCzQvs8q11Fnw>
    <xmx:VKCsaYFxyN7yDMVgih7bOk77Ckk0dnAHVDvcbmvjkoVR9vKHLu7IhQ>
    <xmx:VaCsaWuVSBELV3MdcyhKN-bBzsxkN_Vo2p2XHCfMwvCqJAa116r5JYEq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Mar 2026 17:01:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Wolfgang Faust <contrib-git@wolfgangfaust.com>,  Birger Skogeng Pedersen
 <birger.sp@gmail.com>,  Pratyush Yadav <me@yadavpratyush.com>,  Marc
 Branchaud <marcnarc@xiplink.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/4] run auto maintenance in git-gui
In-Reply-To: <e17f094f-f869-4cc9-b59c-091b7e61a021@kdbg.org> (Johannes Sixt's
	message of "Sat, 7 Mar 2026 12:32:45 +0100")
References: <091e68fa-428d-48b0-bf7d-42b01660d6eb@app.fastmail.com>
	<e17f094f-f869-4cc9-b59c-091b7e61a021@kdbg.org>
Date: Sat, 07 Mar 2026 14:01:55 -0800
Message-ID: <xmqqms0jti24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> However, the consequences for users need to be considered. You replace
> the custom implementation of `git gc` with `git maintenance run --auto`.
> The latter CAN do a lot more than the former. It turns out, that Git GUI
> already calls into `git maintance` indirectly via `git merge` and `git
> fetch`. So, users who set gui.gcwarning to false (myself included) were
> already prone to occasional inadvertent cleanups.
>
> So, users that are hurt by this new change are those where all these
> conditions are true:
> ...
> How many could this be? Not many, I guess. The conservative safe
> approach would be to treat gui.gcwarning=false as an indication that
> automatic cleanup is not desired.

Hmph, if you are _declining_ to see the warning, isn't it a sign
that you are getting these warnings and got annoyed enough to find
out about the settings and turned it to "false" to squelch?  And if
we make pruning more aggressive, wouldn't gui.gcwarning explicitly
set to false be a sign that you'd be more likely to be in the
affected poulation?

