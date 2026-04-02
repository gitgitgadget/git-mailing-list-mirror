Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD83164AA
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159751; cv=none; b=Qc0vgG4CPw+7FE9bKrxqL3Ot+IpQ7oQovlYsRHZjiM2iyqvWkYquTR5EFVxFgt9Ry/ahwpA03rltiMrJWcIlJbyOeGUg6DdnHWIYsBJ1iC1OFbO2ZdeGqndXezKTyl5TmQjTVhywoxsxV66TUwo9U6nY+QCA8qWuDzFWIUs2+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159751; c=relaxed/simple;
	bh=eshgbvTR6uZKMaygF0RLBM0vSjvx7EPXySOPNcu2BEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KpaGtsXBBt7S7LcKJTKg2i57RXvG7y7D/psXJ2lU3/gdIxEqymFtFis0DxEmFx3M+ywC7Y6aOp03XVe+YVmN5u1M/GG7Pyu1ubv4vgWTgjF6EGJhxXgZQK9LxAIW0Xx6PvGCWTEJAN7i0xogpm4FjLiYvsL8awhIs8yCGk90D/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wUEvX6cx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vL3TqRGF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wUEvX6cx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vL3TqRGF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0160CEC0269;
	Thu,  2 Apr 2026 15:55:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Apr 2026 15:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775159748; x=1775246148; bh=Oqrwwd/rp6
	1OKDjRPd2GwYf2eF1jJyhtRTedq0wNElc=; b=wUEvX6cxh6B5hX6tvfDvHJEFev
	sjdevgnfpuMCCqiXUL2mTHgZWfkAumBWAtIn3pi+EdPnOStNHvosFsUIF8vrRVI3
	O0a0iBnXB6497+y7PGu0Pd5qWfHYMNANZQ5ymj4ul85ZQdLwaRTmZU3GQbkQQjH/
	boRTmbajghSr3MbGFcN0+BJixMAKxF7EyHFkRrEEHXOyPf4pb0xtsWVHW+pFPkq5
	5mZNJy97U53B6PIL6/zwrVKMsWi2JcupY67J7IqRLOGTPl977w20AfnmZ5NpW6YA
	Y+yM7WM95W5GNGxKFb4ZOlOWcw5VOSRAzZN7gDMKMsIZhYcGsc6ynlLmCDCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775159748; x=1775246148; bh=Oqrwwd/rp61OKDjRPd2GwYf2eF1jJyhtRTe
	dq0wNElc=; b=vL3TqRGFdMRbYdwFswygdTG9zFsexoNvS4QRkqIQD45rfd3qvcM
	mznF0pc44X3xQh9HjFthV3kjRHyrPXe03HwloqNZQZvLo0cGRJo6ct+IDR1cI2vz
	2tOL0sLKBO/mC2to4iPLGGIRpdAlviPiU4XTapMPdwaLX/L/H8y42+V05Dcra2tc
	NU10rCR/kCiTG11MeMluKLDP5+3+FQ31yS+n9b5mv7EuegX0H9Fc/FjMLy0SzzjR
	KwN60QDgBEuYPnmurKyjlNKfkx38I4NLzfwFWQAQxto0Y8pBVzgVfa7cHb43tFDa
	ERhmonoMj8Fr+hx3kyRNR5O4/zzhUMSbqnA==
X-ME-Sender: <xms:xMnOaYgCnX-8wET7eEBeJZitqTjmuGFnlW7eO7mpN2bdE_JHqa65Gw>
    <xme:xMnOaZNU8m1p4EtAhDFddu5JBGDmFwRX0HV51Yus1ru2DIn0miSaYULG5NSWZ6rIe
    vF1TvX4U12RdRZu8m31XwMmFuyuAqG0FM8vOZzD6mD2AyQvYjonSfU>
X-ME-Received: <xmr:xMnOabrWKIPkDxmdZzdDvK95Y_Xbtj1N5MuoPPRaZGWCQw40rIXRRvOpqKD2RePs4pUYB_AoCmqkCNu0LhX_5XfXKw9zQRbt9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsghlohho
    shgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgt
    hhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghnughrrghp
    rhgrthgrphefheduleesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdrug
    gvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xMnOaT4PPysN2OvOQh64rR2y7HUsW9-aBoWLLWl8A82QZzJCMmPhMg>
    <xmx:xMnOaRh1AdpcOfQyemoa8lfTzBkK8tlHZYCGjiOMlOVdVe3ZbBQ1Lw>
    <xmx:xMnOaR4-19oSuBAVhutlOLxZh88xMmiJdMm5lY3JuADQ8WWaZcK6vg>
    <xmx:xMnOaeGB56bILL3NykQqbTqtGHAkbp9VQY-MulB6GuR-abj20Wl-Hg>
    <xmx:xMnOaTDZSskEMUSZkW0_jnjb_YtuZwzVrmWxLSBzHoRMVsA63Mv_Ckox>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 15:55:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com,
  szeder.dev@gmail.com,  git@vger.kernel.org
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
In-Reply-To: <CAN5EUNRvsUgZPQhk4vj-QY8k+iCkTHQsgO8RJj1gNkYBDChsZg@mail.gmail.com>
	(Pablo's message of "Thu, 2 Apr 2026 07:53:32 +0200")
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
	<20260328001113.1275291-1-pabloosabaterr@gmail.com>
	<bdff0a5d-b738-4053-9b72-08eba88156de@kdbg.org>
	<CAN5EUNR_yfkv_hC4wg-nHNg=3FnkYdvFm6FcOUNG2A=MdGs7ZQ@mail.gmail.com>
	<xmqqikaawrpx.fsf@gitster.g>
	<CAN5EUNRvsUgZPQhk4vj-QY8k+iCkTHQsgO8RJj1gNkYBDChsZg@mail.gmail.com>
Date: Thu, 02 Apr 2026 12:55:47 -0700
Message-ID: <xmqqeckxp264.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo <pabloosabaterr@gmail.com> writes:

> About other ways to draw it, I actually like yours, other way I can
> think of is to make a hard separation row something like
>
>>     * a child of the root commit below
>>     * one of the root commits
>        ---
>>     * an unrelated commit X
>>     * the parent of X
>>     * the other root commit that is a grandparent of X

Yes, this is rather an easy way out and its variants have been
attempted over the years for a few times, I think.  Marking a root
commit differently from others, like the hard break line immediately
below it, drawing it with something other than '*', or painting '*'
in red---any of these approaches will let you tell that the commit
does not have a parent-child relationship with the commit that
appears on the next line.

But the reason why the user asks for "--graph" is because they want
to see the parent-child relashionships in the graph layout itself by
laying commits out on the 2-D plane, and drawing the root so
differently from others is failing that task.

