Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC123DEB6
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753430909; cv=none; b=CNYEAPSjov9tTd8x3LgyKNR4ucL6bmIT1qSfEnIyZQmP9CIJK4CNOuuYikd+StEoIAqGUVJKleWjvMl4oTN39cTkqxLcMSlaWSBl07u2ijn97NY3HM2I/R+4YLkNZZL+iJ6D9RluCfom6WJRLxg+v6yx6dgd8m4QEo3YP8YUL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753430909; c=relaxed/simple;
	bh=vp0XpgH2Y0thbbLjwplFIZwdpJRE+B/sgrd8462SBq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjJAgyJeK+J22KgAb3EkNakaI27gQ7hoG34Rh9bd3PkEj9qZq9HWuxf87/ALtxb642js6oe9uthNsZ3Aqdr1lfKhl1qJlcVCDmaj4kDn6EpXxH4UIEnL1o55jtPUdyN/vmYPsazKYu6vrZSnzxhkI51AWw1Y/pAugEoZnVjY2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space; spf=pass smtp.mailfrom=arnes.space; dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b=iXRHdGgA; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnes.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b="iXRHdGgA"
Received: from machholz.uberspace.de (machholz.uberspace.de [185.26.156.167])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 7C27D60E66
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 10:08:24 +0200 (CEST)
Received: (qmail 24557 invoked by uid 990); 25 Jul 2025 08:08:24 -0000
Authentication-Results: machholz.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by machholz.uberspace.de (Haraka/3.0.1) with ESMTPSA; Fri, 25 Jul 2025 10:08:24 +0200
From: hi@arnes.space
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
 <michal@isc.org>
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
In-Reply-To: <6A35A7CF-966B-4EC7-B575-86E6CCB68D03@gmail.com>
References: <87a54v8nmz.fsf@arnes.space>
 <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
 <xmqqqzy6omul.fsf@gitster.g> <87v7ngstc8.fsf@arnes.space>
 <6A35A7CF-966B-4EC7-B575-86E6CCB68D03@gmail.com>
Date: Fri, 25 Jul 2025 10:08:23 +0200
Message-ID: <87ldocsnew.fsf@arnes.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.468366) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.568366
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=arnes.space; s=uberspace;
	h=from:to:cc:subject:date;
	bh=vp0XpgH2Y0thbbLjwplFIZwdpJRE+B/sgrd8462SBq8=;
	b=iXRHdGgAKzkFgHfZmsk+SwhoWz7KPpv8oetxZ8UUr0slKX1CADShszlbh3RWKR9yn7+kfSOsq6
	biv3jyLmkpxLS5gfo/QnkO3KamH3ZJW0mBVKdEEcrk5WTt73ENGgImbQcyxUs9frKzj6wFq7ufOP
	Y4gWCxAk1q02DGEWb/wBn4IyCVKq8fvH95eBZPn/cCkZEPs7SbISVtGkesXo7tAvVpPI1Y36Rbr7
	dxNJ6kym/vlOHIOv/+AuU8ZsglYR9taHgW+NAJmtdH/3W6PfMLp0JpiLRK5ttfWJULX5o+zHJful
	g7YcxWly4bF7nzTv24wGnXHXpQsaJS73tWm4kl+GCXAbkCNjpVZgc4DhF4p8fcdao06lS5BjcLDd
	ZbF3XjX05lJ81AQC8JB0kWUDg4b2jK/BBGI8mv2gnxUWnyGnZjTRxz2a8ylfiP/+1ESXWpb5/wUF
	jIz3rYdC96DvQsijGi2qjBrNdHZXNlT5XKI5umwjZy6p1bBJkIhDfO/eskIOxcDmGN2xkfJWforb
	ysLzL/sq3Jds3ryoB9FewSoDxjNuwbIbjY5eX1z9yLYEBoNNr+h2KHzk24v61Pl1dWRuV1cjht3H
	Rk/2H+4YSpfF7OqrTrxqKKbLiOSWg0f8aKqPJYMg+ep6hBKUwOedcBpMggqQ0tx2Mv9rWa0gzdZ4
	0=

i understand, and i get why that's useful from a performance
perspective. but i think i'm arguing at a different level.

i'm saying: `--name-only` can change whether a file appears in `git
diff`'s output or not. that is surprising, because the documentation
mentions nothing about this, nor does the flag itself sound like it
would.

my argument is that the non-buggy behavior would be to make
`--name-only` more consistent with the rest of `git diff`, because it
would be less surprising. the fact that `git diff` does not look at file
contents when the flag is given to me is just an implementation detail. 

best,
arne
