Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733252264B0
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836281; cv=none; b=VYh+8QnlO4GjEE5bWGdR0oEw3iesVEts+dKglXQSxfbfqiNSZA+E/n6G7Fg3WzIC61354FMcAKoBjSlFpT5pnwCgI+4w8imudT5sCWqVy03wSjr36vPAq8jnKcREPDo/5RfrlEsjsO1b+mSSpLHIptyVBwvvWfsLkop/F4jtr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836281; c=relaxed/simple;
	bh=PuYh3cS+bjrBiXc9onbtxKON2nFpbEVVHbGg8Etmn0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjRVh2Kyhak9cP0mWQ1z/jEs3fARhQJIoKNyZgpXKqPts6m7RnwewW5kw5xu5lcSYnmdVA7Ul1cA9bVgF9tUclF6Z0ZZYQe5jaP6PCsbmKYzX0BfW6nGERmEdKXQVJ7/jZYxZLs2aj6XOH1Px1zilRp2zTrdjnzfmOfo/zGtPjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OmD9ty2I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1rdTj4Kv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OmD9ty2I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1rdTj4Kv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE903140013E;
	Fri,  6 Mar 2026 17:31:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Mar 2026 17:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772836279; x=1772922679; bh=ABfjuYkUqq
	DuxEjS1JQjK+NswjiRVNDQwZX+YcoyZIs=; b=OmD9ty2IJDHERMpMhl4+Lve8Kv
	9Jc/lrxraO3Psp4Mr+9u/LcYbYbdNL3emfUK01O1Pqtkj9/aAiD5HhhUnxFk96io
	qVr63xxiQHmwWjoVo1qN8jJRNrfoLtPiLj4rFQ0FMllO4DHQIjkP8/0ehaDcCf67
	SRbcr0DOSqcj9++Y9GGy0euOCIwTrsh91vRQxIcXFGrxyVFjlE8BlRYIoMgzofKs
	oiUzJUlXilOCFiieDGJkEVKzeeTzz1BwOcRoGQDf1Hy9+mXrm0aIwCnMs9QLkQpy
	mWzEBvAf5sygCss1xa4FH3+b7EzanIHQ2raQm6BpfkoX7LzlyKHCQ4iIMQog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772836279; x=1772922679; bh=ABfjuYkUqqDuxEjS1JQjK+NswjiRVNDQwZX
	+YcoyZIs=; b=1rdTj4Kv6FynTeFBMfsQrtFNqoAimBQXHNd6ui6FjjN61WxyCsN
	kjQORWNSm7REENtnF0ZUBp3KlSdva8NO+xIIluq5UtWZzUqiQ7KUHAhxBtj/IPC3
	vaOvbyoXP/oi+b3nD0XmNKt1XvlkQ5sfskrQgllITmCg4ALyEIDWNA0U9wxgFvr9
	NQu4ZQku9ybu3pRWPS9qn9c9pvnMs8ZrxfofXydnAH/m4gbqzISOw/s8vZn8Niw7
	aTCs1wVRB+dhwqEMgVgRxLymk6eKu1/MrzwWMeExp5ki7GZ61QTXCX74/6QcDZiM
	sUkeyNGU4EnNlPm23CI7ZJsq6tZS9/cwzew==
X-ME-Sender: <xms:t1WraTYzgvtAwkqEa5qLCMF02ADo4VPQ2PKAGt7LjiLIOAo_Gwnv4Q>
    <xme:t1WraZQ4ZzXR1-p2DeI0zEQXJN64-axeb7VsP__12FgXauxB9q9tMZy1PnuqkWcDV
    Ryku26H47Ztd-lXKWhUGholhbA5elcTWnl4RDv1FAS0nPQWWmSLxDM>
X-ME-Received: <xmr:t1WraeShSp0SM947Hnx6uXxBy_zc0YtOXZ1IdP5sqtsIMRZyUgjurjnpvFLJhuaYSLBUlQp6bYQFRoCq0XIU2iVWuSFarAdDpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:t1WraVTwCoIzQ88yGhjBMRr0hg1cgFtqEKlcrA8hr6XP0XWccyMYYA>
    <xmx:t1Wrab6IGc1Ms73n2zFJ6KFs2FpaJBEzLZ4TzX2Z4eCjeWll_KK9PA>
    <xmx:t1WraZ1G3htQ_MPj_ucOvOQ8Ezl5p0ibM_KuWLEI6z1ZadMg1Dikaw>
    <xmx:t1WraeBmCiZvoZ3Jbzl0WQ1MJpRZN7lozeTT-bgSFs77s-p6KC_1IQ>
    <xmx:t1WraYiDRdGmAcHSTHJYKWVs66wCtA6o_MROxHcxqJbWCg-10Hjoh5m9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 17:31:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH v5 0/3] wt-status: reduce reliance on global state
In-Reply-To: <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Wed, 18 Feb 2026 23:23:39 +0530")
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Fri, 06 Mar 2026 14:31:18 -0800
Message-ID: <xmqqbjh0y4i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Changes in v5:
>  - Added the usage of struct repository *r in addition to adding it as a parameter to the functions,
>     in patch 1/3 instead of doing that in 2/3.

We haven't seen any reviews on the latest round, but the previous
iterations all had good discussions.  Is everybody find this round
satisfactory?  If so, let me mark the topic for 'next'.

Thanks.
