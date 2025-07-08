Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBC1A8F84
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012515; cv=none; b=YwdJQ8EkHlJ7F6xMGkrS2ggihkYvWuai31bofRxnWaoFBpfj4AAH4wX6HVGZA688yIUgmFFJGGk02w4TGp6jT/8EjAzrLLE1icGT+20+w2GGcztsiMr33HbaVm5bc+VhEEOgLdQWT+boe5x5rHCo2p2hJJ8/kPRwpZ17zIoQcg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012515; c=relaxed/simple;
	bh=QGvUsulMuBFMTuTiDR6+MTtzwyyKrDO38Y5uSTpP30Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SYZDuQySTfCtG9ZgWJAv2ANg6NL9wId247vH/IG8weMisBBkKOLL8cy+BxDvcNKXmfH4/mDJsVPJ/KjQcxRZY1D7Qyp9ugbfWuSAnDbptE0h+HzpZhVVpXTLAQs9+4A6tTu+1qkEwmp0A8vdT5cFjtuso48rlGz8QJs4BkVMIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G+32FRt2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYB1HIzk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G+32FRt2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYB1HIzk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C59C61400A40;
	Tue,  8 Jul 2025 18:08:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 08 Jul 2025 18:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752012512; x=1752098912; bh=W3OH1KbmvM
	96eWwHZlUYbQgosO2DobYsyO9tlWXO9f0=; b=G+32FRt2LBMsF2g3JtbjcEr+hn
	S5rw5IY5EvZpdRZxs8ER22AZLolPmPDOUG1Y9wA3pKpt5VYJg9IGpgta97b7biVh
	pJi1Pu9QVnsxvDo+nyC/hBew4oMJCtQE81oJnnB4qyT4k5/XlAaz/lEk5DfMqXFR
	P0k9grlVogu/Snraj+nzMiKmwtyPjGUrRAdGjQ0nJ/HUWmjLkrXD+fFBHvDJ3J+c
	dbJT8RwO/Qp3wQbnVKrXRW8N2cYBHPA6KKEVRHSmnaF4vrHnmwF/p/XG6BvOdXkw
	3Flx01ZfVA6qHwdlp+8X8mH1q64LJYSJSTa4pIjm4LzRVdt/sUVcSP7LaSOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752012512; x=1752098912; bh=W3OH1KbmvM96eWwHZlUYbQgosO2DobYsyO9
	tlWXO9f0=; b=gYB1HIzkd3Mfy/9R6djuVf6BauXqVCuSRVO8/dxxz70W1edZ5Ww
	NSFT4OAjzkIT7EFskc7SEfIMlsgWIw0mrl804tCjyITZju5dDqS8UYKtG1VdtwTI
	EjNvfRFRup1dSyD1XDsCOcZwJ6sSzqgaUQN/97TAKbHA36LOF8Llgy5Kr1t4+Zkn
	5YOxM9fspyO8V0Eb/maXkU87RQoDZfKuamnPjiQyzocGJfPDHHANJBW7TIrfDtlh
	Bw5q53+D0f7D8/BHyfFFCfSpFrwcaQ8R2OOyuaCSwOuLFqTaVIH1/cf+kHUUVf+V
	vlikRpHTLQgR5sMBucnev4pabl2sHy3Or6w==
X-ME-Sender: <xms:4JZtaICSM6M7H0Vb3Aj6mx_3D2PYq8XkY-inedb5gsPsYDE9kGzCAA>
    <xme:4JZtaFFufk7EEDVq_qVNSO09O1k7C6xTUK_VxY0DQSrZqdFlkDvzGJa3GVAxF66jx
    mqkqbB6TJb6kXDw9Q>
X-ME-Received: <xmr:4JZtaILMvcyLc2tdnkkYejX1IvAPrRn7Pew7IFle443xknEQwAsH5IhV0jwOizYThiWXv2XJweYaa4n3rbC_I0yITgjFLWXcDbqJ4z0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4JZtaBkVpqM8molrSDPSBV9epYwxwIvB-c0aZfOdafXI_wlblbq7Iw>
    <xmx:4JZtaIS_TVQy1CqmukA5MS4cOGVd0YpjQ90MmYTM_hzvFhaWvYH4NQ>
    <xmx:4JZtaLI2xky4IfPYOXwcBD3bwD-R6qLFmG-anM2hhbJFLaV_x8Zvgw>
    <xmx:4JZtaGAczqheYBOav6Th32kV5bCyYNnNeHAjIYI9o-RvuAvvXzNXow>
    <xmx:4JZtaMzw1gcRZTB_xbDxewJ0BuhAV4uXpqhiwwPkIy--XHIm8XoYF5ST>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 18:08:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] t: avoid git config syntax from newer releases
In-Reply-To: <20250708210529.1214574-1-tmz@pobox.com> (Todd Zullinger's
	message of "Tue, 8 Jul 2025 17:05:27 -0400")
References: <aG1_eqSpH46UddZJ@teonanacatl.net>
	<20250708210529.1214574-1-tmz@pobox.com>
Date: Tue, 08 Jul 2025 15:08:30 -0700
Message-ID: <xmqqqzyqs5cx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> In a recent security release, 05e9cd64ee (config: quote values
> containing CR character, 2025-05-19) added calls to `git config get`,
> `git config set`, and `git config unset` which are not present on the
> maint-2.43 branch.
>
> These subcommands were added in the following commits, released in
> git-2.46.0:
>
>   4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06),
>   00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06),
>   95ea69c67b (builtin/config: introduce "unset" subcommand, 2024-05-06)
>
> Revert to the previous `git config` syntax for older maintenance
> branches.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> ...
> This is based on maint-2.43.  I tested that it merges cleanly to 2.44 and 2.45.
> I have only run a build with 2.45.4 so far.

Thanks, will queue.

