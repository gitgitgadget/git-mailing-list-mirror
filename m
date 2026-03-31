Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588A3C872F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995278; cv=none; b=iBtECNpwQ9kph8iWMvSOk77kjkp1ZbhvOx8vLpELu/FI+w2HhRTsnGMm6E/PRfqeiqNqHP47xsm/ylnAYY8RCbnNR567X4mtlXuOGHs3GuV8sxo8b5jsu4FFtBb8RH3lG9VjrjYth+U52+3jEWflYWZ29sUNiRTRF0RadE7HNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995278; c=relaxed/simple;
	bh=e231eCP7+gOvnwEG6KjPMWizwPStCEfDJ9erfZ8dHcQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXZlTBc765vpWssZhrGTjNU6Hbofj9dr59G7ghZ9flFeyx/lGA2T1Dg8IS5l5Xd1XkSf6WycBJ1OALaZc4DTBGkPmcCWI/Q6Ds4ffXp/z7uVkBkeKPRjyV+f4CY9i+FEuAkGax8fLpJEFb9va92OMt4+vnoddsmJcAqTV0cYXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y58PQk0S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jRnK7dd+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y58PQk0S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRnK7dd+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C6107A00BC;
	Tue, 31 Mar 2026 18:14:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 18:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774995276; x=1775081676; bh=LFVmPixgNa
	CtQnIL2hejmrY1Vv6x2JJfdJnDJzgzDRY=; b=Y58PQk0SdM2OVUrJQoI9tQJkjO
	C77j36j7mbpwHUEGOiK+3Oer4UQ5zq434Cq42CuktD+bNmVUvrvJIa25QbM+DUQJ
	1pf6XeTXvGzZ/dUKi2xMlk8siiZyyS7LBD+8dI1ZWg13OBojxPq+aShVkJhl854c
	WpGAIvuotYAU2BH/7UvE7W273zNth4Vh4kgWYFRtfqCzzNiRIiKe6b46X0o6Lxeg
	C2LSjpI8TU49wly5jU68av6MgKLNTEpkoNQz5bI5XargE1MWi5l8cbnugkr+H+qh
	Rf7xYXgHC5tj0qKcqm4d6I1t2hZ76JnzJokZA2ZwJOg+6LXiYtx+EyiALnCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774995276; x=1775081676; bh=LFVmPixgNaCtQnIL2hejmrY1Vv6x2JJfdJn
	DJzgzDRY=; b=jRnK7dd+mcVXLbxwBEExZuivUMU0H030E5ApDfHBqtq+2zfwH8S
	qgDdM+v3oIqef7qMyUPvKSVADT7TEIH2H4nx1ULHbxPfTukJjlCcKpd9HP5kzItB
	yJFqmg8qUGu9v7OGkYZpaXCI6Ui+WqHWwczq7a8NeJKRA6pNT32OY57ZmDAdhbGW
	Lv89v0/O7qNQJQMFvrhpqPt46HAsI7yn8SyMfwlEV9fyyFa9SFqdbCVP1pKbozbf
	8qaonTMsuJqoRMuLDQEbE0QcDe6ihj5yzqtZQDxP2/28lj5mn1zjFhj+qXXK2BhW
	KOBgM7JY0NrLgKhaNIEbrFeRq9wMgSEZjKw==
X-ME-Sender: <xms:TEfMaQUyEnM920VD8K9S7t4DAM-76FjuSatusUpriHYgv1XYkFhxpA>
    <xme:TEfMaczavYyxbX6CkX0Xizf9JZFT2M95ZEGaufd5kw-74vCUJ77nLvvpwFA0uBpN0
    Wuw48Sm8pkUJgLyeK3nqbFJiY-m8K0MzHqI2s7I3PDs9hbs7cvClg>
X-ME-Received: <xmr:TEfMaf8y9KTPsa9icEWZBmQJr-W4etlpLyRU1mf-ihuk2KbNXgkvu305vnpoL8xSVJFLy2Bs3IlJbx3hv-UH_t0WhQkwrO-Bxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsghlohho
    shgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehsih
    guughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopegt
    hhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    eitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:TEfMaZ9WVymMZBxvY86vBkiUXoN8pTyYLrjvkcmQ8099KXeau-UoMw>
    <xmx:TEfMaWX_5MU0l2Nb8buyD6GNRTY7bgFKle3ibBAPs06ou1cR2bIk3w>
    <xmx:TEfMaedO9v2p_S223xWOswXhF1UiMKvkV2m5DsYqtwIJYUMvodSmyg>
    <xmx:TEfMaXY9gks1aE2C3EvIQ1UOBSRdaD97jsyruYIcQlFQi_Xr8qSvMQ>
    <xmx:TEfMaQGSt0cbvqVFZ8X0zboNwqaFtaVoUNs-FQpS-ijfntIWGE62pJsU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 18:14:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com,
  j6t@kdbg.org,  szeder.dev@gmail.com
Subject: Re: [GSoC PATCH v6 0/3] graph: add --graph-lane-limit option
In-Reply-To: <20260328001113.1275291-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Sat, 28 Mar 2026 01:11:10 +0100")
References: <20260325174401.217577-1-pabloosabaterr@gmail.com>
	<20260328001113.1275291-1-pabloosabaterr@gmail.com>
Date: Tue, 31 Mar 2026 15:14:34 -0700
Message-ID: <xmqqpl4jwss5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Changes since v5:
>
> - Changed patch structure
> - Fixed octopus merge truncation check to commit_index + 1 + i.
> - Added check for first_interesting_parent() NULL check.
> - Shortened variable names.
> - Added clarifications when converting between lanes and columns.

The updated series structure is quite unique.  While it is a bit
counter-intuitive to first hardcode the limit and then start lifting
it, it does make the presentation really easy to understand.

Anybody spotted problems in the series?  I couldn't find any but I
admit I did not look very hard.

Thanks.
