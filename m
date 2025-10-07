Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D31DAC95
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866932; cv=none; b=gAv32SzrngHwK/hZsnqBvvxYBL+IGyzlDYCg4k23xgzYIE5zNjVlohboRX6dZ16BER1ymtl6kVQt/D8mpaSaVDkhAnvVL6avmDlbHKksiFPDwmwy02PYwUSPmnQdo7+qpKo54rjHZ+eod3I/EZtIAmEKYVxkPClee1fsh2y/Njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866932; c=relaxed/simple;
	bh=By9UHhrIWWGosvgfeboKOi8RG5hbT5cfYn2njKT6KnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TbfUJy8AHy9pNNe8e+vgjmxygxU1rriLDaso+4tUWlRr3queysuiJb1wFcMH9HkwVl9INW+1OK2qRXbulpVJ5IXa3wmia/ZSQ8enXUUim7SfAGSfi9gW/z74AalwdqYfHHlgxgHOvfbrRnVc3oaYCL+dtnXMrqUAOzYVZAB5PS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AogXkXl8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKODBoT9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AogXkXl8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKODBoT9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 99C1F7A012F;
	Tue,  7 Oct 2025 15:55:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 15:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759866928; x=1759953328; bh=1SX1Qn0nWN
	6g4RyJbGyXuXHfQWiEzCigEY/l+HWVy0M=; b=AogXkXl8d4Lf5HsgWtz6TKTSTz
	/MypRO9EzIezO3eJH8DN5DIYO+eMDGr7nQSDplduYhQy0icS/CFGwqHNGe0oeALL
	veG8b1LbVXSzAJ+ox8J9A96OWsi/1O3yFyAxIVUm/ghgkTIthagxvd5nEFxWNmPv
	vr7MzPNFIGQlYPlFbehfwLQn6WkzKrWvcHVLw6+W69Eg7Jne1f3YEj+VTbbB2MoM
	hQBVTBuiyRbrY+PcUpe8s8yNVBKBQtJ6vKwXtJLo7F54ogphpHYBL60j+XF2jw03
	M9Arnl3TUrhlpwJkISTNpA8LTraG6ppnL9mewZrqPAB6CKgnXZ6bgVVaMibg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759866928; x=1759953328; bh=1SX1Qn0nWN6g4RyJbGyXuXHfQWiEzCigEY/
	l+HWVy0M=; b=NKODBoT9DZdr78Da5FqsEEBBq2XOkZZVZuDxDlvmgTTo9x4oMug
	iqy+RwTcpvh5zimQcTPlTzl2GNnFF4pGL1+BDYREw85GIro4/fc/u3LPhOn4tR+l
	zqo4n7UX8sF9nNZ2IlhT6K1EZUiOViG+ThoSbdTGGNcfMEoCzrZIba3aX+AtT7hr
	igMM4ZDL6vXHKf6TUsqmMowJBm9SPvC1ZhaOAfGT/8dv+hxSOfzb51exsfh1661J
	RajsfZ+GPyuCdZEqbUqFjYW68r7cE5zaJ8K2fEj/FTM4IcFMfV2s+4DmxR1ZNn4/
	SHSJRzOCGVcwiP7kqYuRDnzlgyGuDpsHi8Q==
X-ME-Sender: <xms:MHDlaE0BA5OFpc14XsY0gTkkZ2MaWwhvDD32U3_X-iC43acN1vvLpw>
    <xme:MHDlaK4moAHeQC2B6H7z1vgSvvvj50CsAO0gVcagAgLysbmtRIql1fRzueX7hrb4J
    a8jSM8QYKSIbUKNCIZIesixYh06iNGnEjgSi8OgpG8a8GdwPWqk>
X-ME-Received: <xmr:MHDlaIQFqujZL2D0QC5dxEBKSc2vPsuaceEhs2akl1LXXrJtwfpF7_NxTHAwLoTQSoni6xS1RiyNkk0WKHePCf3c2R0ootiFeLrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:MHDlaHUut5EeeP_-PcUqXqEx7mc7aQxeXIinOzZNoVcRntsQm4hcZA>
    <xmx:MHDlaFF8Ii_SzsJqphZ_CHINDwKqIAGmL6YNtwLQ3X7sJL0oliJAtA>
    <xmx:MHDlaCeGChEnJFgryhr8MndnuJyP7O42ugHgbP9zO1vdOnmDuum7HQ>
    <xmx:MHDlaGo2j_3a-UWLyv3u_oKKk0h2v1L7DDXMC8WF5HsPLSg4aA_85A>
    <xmx:MHDlaPRqpJatyh7N_G7R5sCahRvWN45hU37njsliKi8Ix05KdyHszuL_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 15:55:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 4/5] submodule: encode gitdir paths to avoid conflicts
In-Reply-To: <87347u4nkh.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	07 Oct 2025 20:41:02 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-5-adrian.ratiu@collabora.com>
	<xmqq347wq87s.fsf@gitster.g> <87cy6y4xb4.fsf@collabora.com>
	<xmqqo6qik4r9.fsf@gitster.g> <87347u4nkh.fsf@collabora.com>
Date: Tue, 07 Oct 2025 12:55:26 -0700
Message-ID: <xmqq347ujxld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> The problem becomes how to detect (1) and (2), for example: a 
> specific name is filesystem-friendly or is case-folding happening 
> or not?
>
> (ext4 for example can be mounted with casefolding on/off)

core.ignorecase is dynamically probed upon reposiory creation, if I
am not mistaken.

But other things like "I have this name, transformed to avoid
slashes and other problematic letters and the result got this long,
would it fit or would I get ENAMETOOLONG?", I think the code may
have to be prepared to try-fail-adjust-retry.  We come up with a
proposed "munged" name, try to mkdir() with that name, see that it
fails with ENAMETOOLONG, shorten the munged name and retry.  And we
ensure the name we propose is unique among submodule.<name>.gitdirpath
paths in use, then hopefully we find a good name that fits, recognisable
by human, acceptable by the filesystem and unique among submodules.

Even without consulting core.ignorecase, I suspect that the code can
do a similar try-fail-adjust-retry for case-insensitive or NFC/NFD
clashes.  We try to mkdir() with a munged name, and if we get
EEXISTS and submodule.<name>.gitdirpath would not have the path we
tried already registered, then we are seeing another path that is
not byte-for-byte identical to ours conflicting, so we can adjust
ours and retry, for example.
