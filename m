Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817BC1F26E3
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371348; cv=none; b=Uvp70/n3e5trpuz/iWdnk7eq+9i88m9omvaEpa0s0olGp/hc9HFjj1rwwiqCwfXq41kPMv8uVZpKGc5aUQjXWEaUaTTN0QqzEwrbtkEAETGhDaLfgC7jL0yzaRk5fy0ZrxBrHOshLAjXyltZhNl/Z38B62jwaQLP+Lmj942wLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371348; c=relaxed/simple;
	bh=1k7GNFBPPcTkumlYVrA76b/zVDD2r7HtnU1BnmUoWM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECTzAhsWUWipl9DwF2Tndzu0/63Itr9COY7QZw0MVJLx5XzJuPVTIitnRmt4jeX7LTR3YYCSw1OUb4WYiD3Ipq4M6EmnD52m4LFD/tvU4muw2Z/jsmICTgLOt516Q/canFj7wHLBMB3IRDBk+mwm5zWS3tbLUzi63iyURGezQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fgTPkCzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nHyBxbxM; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fgTPkCzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHyBxbxM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9182E13806CC;
	Mon, 11 Nov 2024 19:29:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 11 Nov 2024 19:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731371345; x=1731457745; bh=WmK3m7nEyi
	Mgtf7lJNdS2C+spg8OeJ91d8liALt0Iwg=; b=fgTPkCzgl18Xaez4+OAo8n1/jo
	zBWuaQSyqcjxaylw0e5Ds4R9C2B1j9oyOg8dOCMmohIJ3VUTms4zE4ip9NIfIyAe
	WE9O6YlAwc75E5eiF0KIjTw97f7b0XpPHHbLrUY7DJ2167SSQ02aML5EWnFEKIz4
	AEn4BLIj1sXoX2cwTda+7yI7voTmE8aS9/fsV3g4zy7Sf0P/y/KBzbXcBD1DnGVi
	/j55bvONP2mKxQUwdomgCcjj0wcz4iOznXz8t0CaTMA7JBq0SBcmFhSmkFz1gEks
	rv5PhSJ0l9L1w5O5mB0DB2e6YRxXPWFiZeDtshzOfDeuhrx0voVvJ2F1R1aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731371345; x=1731457745; bh=WmK3m7nEyiMgtf7lJNdS2C+spg8OeJ91d8l
	iALt0Iwg=; b=nHyBxbxMCGRHCvpy+QALIk5Y6+GnDvC0iZdq8kCZafCUlopOgDN
	65Lk4kuNi7AwcxJAzx29M+egwa7EyCCkm2xBZGaSjmQ+rqI1VRHbCXl+29GwPeVv
	LoaAAT42aU3qr0MHKz1R+evr5cE4IQXFyBE/+nAk/8F5YTvCwYcua4pAivDckeHT
	JnKyRnJ0HkeVM1aiV6k0A2z4UMxi85uaHu7e7MHeyaFZCmgoT151qElhQyE47xbL
	dK9tPMvGG0Fr1NBfRPcdJWPBg9btIthcDIMMww2jZ7Uih3Yzpr5KiBGzO+BWLoXK
	sRp1sIOz3aV4KxOu8p3sEN3ys1f6sZpoEzw==
X-ME-Sender: <xms:UaEyZwmdKpT8GMIc1UEJl4vnGgm-XkJ_H6NwR7Cs-8tSy0lej-xUpA>
    <xme:UaEyZ_0OfTkfWmORkcjpAuTlzSbYER_DPHlT3rOP1wH614PqRfXrgoyEvq2JNm1Pf
    w2lmNGkicuakcJkAw>
X-ME-Received: <xmr:UaEyZ-oHUwScj-XBOFk2za44B8fGrnPOdpxMHPp9hAOJQs3CI10kmOQpjdMoLUAPuJatuaKwWqUgyRXhVY9iEEH_r5GbVQqxBaQb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhgvvhhrrghiphhhihhlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthh
    hinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:UaEyZ8kGEu3CRO4N7VEJRNFXrB2V0W9jNcaUoSuChXIFeOzUbvjYcw>
    <xmx:UaEyZ-09Ve5ledzIeKq_JRt5B6Ui4mNWad6Jyv99UwK8N34hkfIkRw>
    <xmx:UaEyZzvoUC2zNsJ8t03Rlf09Wr3tATl1Frl8HOkfbYQBLumfk7VsKg>
    <xmx:UaEyZ6V0Ga-b4BiWSsnZUNJk2Dj8rRrR2K1zCefQc_RKcsxYYiRGeA>
    <xmx:UaEyZ3lS7C8Z3fYtj5IX6cTkDWKINDZhzc-4CvGRSDumSSfBgq8Gh6SY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 19:29:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Johannes Sixt <j6t@kdbg.org>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs
 in the analysis
In-Reply-To: <CABPp-BFXZ+aaTWGAUhJxh2YYZ131BNYFCyLNVbjntBmStUu0SA@mail.gmail.com>
	(Elijah Newren's message of "Mon, 11 Nov 2024 08:51:12 -0800")
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
	<pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com>
	<xmqqv7wuk3lx.fsf@gitster.g>
	<CABPp-BFXZ+aaTWGAUhJxh2YYZ131BNYFCyLNVbjntBmStUu0SA@mail.gmail.com>
Date: Tue, 12 Nov 2024 09:29:03 +0900
Message-ID: <xmqqwmh98fcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> There _may_ need a tweak of the matching algorithm to allow the
>> "same" merge on both sides to match, even if they diverge a lot,
>> though.  A range-diff that pairs a merge in the previous iteration
>> with a single patch in the updated iteration may be hard to read.
>
> Sounds like you are arguing that there is an angle/usecase from which
> `first-parent` makes sense, namely the viewpoint that "a merge is
> merely bringing in lots of changes into the mainline as a single unit"
> as you put it.  What was surprising to me, though, is that it's a
> completely different usecase than the one that was brought up in the
> commit message for this feature, namely "so-called 'evil merges' are
> sometimes necessary and need to be reviewed too".

What I had in mind when I wrote the example you are responding to is
based on what sometimes happens while I make repeated merges (and as
you may know, I make lots of them).  In the first attempt I miss the
fact that I need semantic adjustments and then in the second attempt
I know what additional changes are necessary in the same merge (i.e.
merging exactly the same iteration of the same topic).  If you run
the first-parent range-diff between one iteration of 'seen' and
another, the "additional changes" I would make in the second attempt
would be the only thing that will appear in the output, showing the
"evil merge".

There can also be updates in the topic itself when I rebuild 'seen',
in addition to merge-fixes to adjust for semantic conflicts.  Such a
change would also appear in the first-parent view.  If you used
other views, like dense-combined or remerge-diff, these updates in
the topic itself may be hidden, as these other views are
specifically designed to highlight conflict resolutions and evil
merges by discarding mechanically resolvable changes.  So it all
depends on what you are looking for and what you are deliberately
excluding from the lower level of diff generation when you prepare
your range-diff, which is a "diff of diff".  Giving an impression
that first-parent is the most useful may risk misleading readers in
that sense.

