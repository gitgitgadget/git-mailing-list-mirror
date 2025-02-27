Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD4270023
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681384; cv=none; b=DnWVWk+3sUd8xSJK0XGUQ+NtHAkOKHB+sWC4IdFym4N65JLNGXZ2+e9Hk0HOgBJDEtgRbDlWZsJtnuSNz9T6y3shrAdPSueExJuqwtiV77QkmivT5WrQ6zP0xOG4+C9qm2H0tQ4koNsYKZTDd6QnkdM1/6ZzV7yRI2f8JrICt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681384; c=relaxed/simple;
	bh=pj93efPD2M4ZsnemyRs9L3IinWGb9SYbcF9Wxgcpu00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dkbwl6JssJBUSCqzFtqb6MZ7HT40IUTqqkAUPWYlVTEagcefCta+tYuCY8cV+KxzTVc4sEPW9E3n+SCvbRe/kpRk2Yv3yBuxVYbpW9/eQ0j1Rx+mEfX0pI+CVxnyz4xrVcBXIxM8KlkLvy0u9iq6704bKkhIfyT0Ln8cmGIqeNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wr7SPxvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3h8atfbV; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wr7SPxvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3h8atfbV"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A180114016B;
	Thu, 27 Feb 2025 13:36:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 27 Feb 2025 13:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740681381; x=1740767781; bh=X4SIp5W94+
	KivX7T8w+/v4/fDn+0O8QccIE4b5Oe0Do=; b=wr7SPxvUo3PZ6hvhExCSIfuvIG
	U2YNXUud1H86Mw3G1329NqnYkeh7YB4DnMQjk9suUPHlI9HTeu812F7MQht9m0eL
	YMPHpeiFLVayyzJ93weZNzP3IT/kQaprxty0+Vz0rYvK0O3/33i9DBFlDAArBNNF
	AkvEhVlb2emLKBFNrJRG/xgftGxpnE+hGRbkMWuuNDPgth0ZezPsJLTUiBjwRmLR
	7paNUZk6GUtomA1GtERVjLryvmQZ83yS3EmJUx468HU+lA+3tynrCTdtrVJRch87
	ExgAZ8eOO4bm6Jd9WUD8wW6ns1Vuj5JC/PhZmV7v14xG1SHmDPQGxFZBj+PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740681381; x=1740767781; bh=X4SIp5W94+KivX7T8w+/v4/fDn+0O8QccIE
	4b5Oe0Do=; b=3h8atfbVygc9aaaYrStHLAKE2LvY9nqpAsoIEE7NH283x9aiave
	aySt3bjgDOdAnWBJ5lQDBCe1o4lVQdKufUtdhByb0cPTvWDX3ityj6pvtGYAuEnN
	l/Izr0ER8Ih3CTMkwTGwhmTApX098m1sZW4rbDMhcFBtjtsyVgG9at8YuC2Kq4sX
	4mTmA08YBzM7/r42L5lWjVBuAmTKewyBsJC/y2afTtOKlIYoqOnqW9Ye9k9ZEfCo
	oIc0GDoQKdXR/h/B70aJCsLLByxYeLJHb4URkAmlxBkVkNIcsRLUxrdb8X8TSH1K
	PXHbfdhqxAGu6nxxVGmsHozmjVgM+qvdarw==
X-ME-Sender: <xms:pLDAZw6ub6BC4hb-hqi11n4c1ROPjkeNhWEe-GWYYBEidSfA1XE-gw>
    <xme:pLDAZx7My4bRpTaAzIhXg7FItthe4prAZmEuYvQU5tZkElmxfCG6Uqjfae2JpP0qM
    rOXJn6tmbx5e5ZydQ>
X-ME-Received: <xmr:pLDAZ_c0MaXYsqJuCLKZqYB4rVvl58PhhZZpFLq0VIJmrWZzfovfI2Xy3ocq5rltmKdEXKUsImd3jfkb-lfuij6KEXh8oS4xDyoi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pLDAZ1LjINbAwnt3YKzZQ39MoNLgdq7xL6QycQFuftASISmxSoHUyg>
    <xmx:pLDAZ0I6GKB1HzPhvRNmllWfk7X4wPs3g63yyJX7h3wiFjJYdlfR2A>
    <xmx:pLDAZ2y2ZmAxakSw0APOGqzjdylzRy7ilrH-i3EkEeNE752wke1G4g>
    <xmx:pLDAZ4JFzpnOxX534msGLSS75-zw0MukJYXYuBr1EJdgxwvqp7rheg>
    <xmx:pbDAZ-iThVjonCe7f9nymgnNdfnGAE0g7oP1fFM_-sSRHr-gV8_th6k3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 13:36:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
In-Reply-To: <180271a6-eb0e-4c15-9916-b2ab5760f4ec@gmail.com> (phillip's
	message of "Thu, 27 Feb 2025 16:22:50 +0000")
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
	<xmqq34g79e8k.fsf@gitster.g>
	<618d4a61-7480-46b7-8563-221264290ed1@gmail.com>
	<xmqqikowejmb.fsf@gitster.g>
	<180271a6-eb0e-4c15-9916-b2ab5760f4ec@gmail.com>
Date: Thu, 27 Feb 2025 10:36:18 -0800
Message-ID: <xmqqjz9b6xr1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

>>> Currently after a selected hunk is split we always prompt the user to
>>> make a decision on the first mini-hunk even though it is marked as
>>> selected when it is split. This seems inconsistent and confused me
>>> when I first tried splitting a selected hunk which is why I wrote this
>>> patch.
>> Hmph, so there is an obvious alternative "fix" to the inconsistency,
>> i.e., after splitting, move to the first unselected hunk?
>
> We could do that but I think it would be even more confusing than the
> current behavior as it would make it harder to change the state of the
> mini-hunks. At least with the current behavior one can use 'J' to move
> through them immediately after splitting the original hunk. If we move
> to the next undecided hunk one has to know where the newly-created
> mini-hunks are relative to that.

True.  After all, going back to an already selected hunk and then
splitting the hunk is a clear indication that the user wants to
visit some of them to change their state.  Moving them back to
"undecided" (not "deselected") instead of leaving them marked as
"selected" (which is the current behaviour) looks like a better
behaviour and I wish I knew about the possibility in late 2006 when
I added the hunk splitting.

> I'm not sure either. I dislike the way it works at the moment and find
> it confusing but if there are a lot of people relying on it then I'd
> be reluctant to change it.

I share the sentiment, especially the latter.

> Unfortunately we don't have any way to know
> if anyone is relying on the current behavior without changing it and
> seeing if anyone complains. Given it is a bit of a corner case I'm not
> sure whether it is worth spending much more time on it.

Given our user base has grown quite a bit over the years, it almost
is a given that any change to existing behaviour is a regression to
somebody.  Certainly a safe material for Git 3.0 but I do not know
if it is safe enough for 2.50 for example.  The strategy to leave it
longer in 'next' did not work well to catch potential issues for
another topic during this cycle, but we could try it out again.

> I can see the problem and asking for conformation before quitting
> would have been nice if we'd done it from the start. I'm not sure it
> is worth the disruption of changing it when one can re-run "reset/add
> -p" quite easily though.

Yup.  That matches my assessment of it.  I brought it up because I
see this "selection should not stick across splitting" falls into
the same "it would have been nice if it were that way from the
beginning" bucket.

> I guess we could add an opt-in cofing that
> eventually becomes the default.

I'd prefer not to add configuration for tweaking such a small thing
(this applies to "should selection stick across splitting?", too).

> While we're talking about tangential issues it would be nice if when a
> user revisited a hunk we told them its current state. At the moment
> there is no way to tell if a hunk has been selected or not.

The user came back with 'J' or 'K' probably because the hunk was
skipped in their earlier navigation with 'k' or 'j', so users may be
using it as a workaround, but I agree there should be an indicator
for the (unselected, selected, undecided).

> Related to that the help for 'J' and 'K' talk about leaving the
> current hunk undecided when what they actually do is leave the
> current state unchanged.

Nice catch.

Thanks.
