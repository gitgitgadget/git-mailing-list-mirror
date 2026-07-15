Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF447A0D1
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129014; cv=none; b=rEnwTbwwyqxh8Hv7Huh2QQ5KIeVpzx1RMiOgUn8mWC+0lZkUpxuaM1haN8mb4RwvD5WAXpoKvcBD0+/jDNSgVWgLp4YewipV3IXNJ1i6bPXdmW/yHTYUz4wNP6by0fUAK97zfDNQhb1WCUPK/z+UFQeQYUSjPgAYB+ZCi1K5n7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129014; c=relaxed/simple;
	bh=/pFbyDZKUhcSZCnfumkWpFqWMX1NoP8npJrLR1BJirE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKPOdpBmp8Xp+RpLc4FMtX225UA6OhL7yQEB8POdKDbpUJsWj6aVfgeu5vZibHV6k0vCf96/EXCDDOs+KXg0ADpt4OQf7W4H6WIpbhABs4LwMvcNaUH/EMYnc7vNokIg3FqjwNLAR4RDGZLSnYfw0RlrKnnuUZhw1c7BqXmAWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vGaeWa8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2fOr/cA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vGaeWa8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2fOr/cA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E05B1140013A;
	Wed, 15 Jul 2026 11:23:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 11:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784129011; x=1784215411; bh=spN2yqfCoc
	9jmrBYzFAJgpA9NKzKkEDLqqtt5NdWdq0=; b=vGaeWa8hy8Pdmawbu/HPR87VdQ
	Rujxn18ys1JFZRhtStLlwI8z5lxcduE/yEkqa5yCp0K6TSNAKJjpTX69JHpJBIAj
	5oB9MRwshftiouYcy6UKzGFBuP8PAHYs03gmRaxw2W6ZvVgq2ib5nT+ysNtper1q
	zy4lOmt4osuOUI7xBRNL7KEy3ERS/epr19H3K7To/DZGlckWLCpmrTv1qkFf+whV
	WEyvcbg08iDX+Mu1t+NEBDN9m1fuYXaXvwz7Bk893a6hspRmgrxgigl27vAq5RrM
	mKOSG78x8j7v7vtouCrVGWg2aFIMm12/a0+l/rOjZ62Wh36zmE5rRvRhSqeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784129011; x=1784215411; bh=spN2yqfCoc9jmrBYzFAJgpA9NKzKkEDLqqt
	t5NdWdq0=; b=L2fOr/cA/Ftirh5QodPaE5fSP0dCE9yhJK3jN4APv+CGjomvIlp
	6LdHtLyWIba4qdzC8vV7f2tA9rS3kYUz7qhRZm5jnFKw6x7aWPsDlOnKOzTotIYr
	yQjOVCK8pyCr715xJ6eNU5M7Mr12GYiuh+Ck0Y8RrtSK7zgrmnCpm6Yn9sIa++pE
	0K+6PrORyRMxh4GLYAKsz6+N3mFQV+HJvFkqapOANJqDYUXezewlW71oEOgc8ipn
	/jM+Rzuq/QkZlf8a9Z5hBl5BhDjlsZDoei4jQXx8b/apZjHNZLblYjdGbektg7IR
	xdmSJ3DmqIG013+fYR+wOnlm+pu4ghFKbcw==
X-ME-Sender: <xms:86VXapJ4h29__SuDHMdUVRSOC6EyLWbAHhuPO7HiP7oTYt9qvOhn0w>
    <xme:86VXahtpZW1tbCY5CC2sBbSKzrQnlg8qUCastpJ7T8UljtxAA9xBlpO_1iIkGeOV8
    PKel40qeMGfEwFeGe7PlvpeFP03fNZTOEkk7o1mGQYIaqmJ32F0LA>
X-ME-Received: <xmr:86VXamI7JnMin8UzB8CvF_bHcsuk8HncFZCgYqFKNrMUIM9Eg7qPoc-M6p6ZVnLQfFqZ8zrkYIGCfkVV-Db2oyEsYUdmjOf1hYEL7nk>
X-ME-Proxy-Cause: dmFkZTGxY7xSQls/MzbURD0KoY445+m6n7Sw00PGmrzkt1JUsaMptLaOpdjM68Th8FLJwo
    fRSAI2sl2wyHq4MW+OW9jVAQ8vOJXUw2na/qXyNAyJyYnECnER8N9/MIxTYbr0diV3jfhJ
    jh6m3nTNpHQUlJEl07ia3viM2QJJp4jPJQxpLhnxML5Ciy/RMtbRbih+dFOj0WzG26Kj92
    EXTuevBIrcR63iJKPiglkUM5BeTOLb0V7YE7BHZQOrDfZOUFfmzMNfaauOhGtRciCW57jb
    /Zq8eoYqM9eBgAKj7pg8YVjSIn9PhjMPrrSGAEeA1nFUio3K175RL5IREr1t4odL3PBFip
    LHrWu9rPnNSjhI83rQ/jYbtB9TLUs52IpTrSGBlV7QysOgTqfCtHoJSXdif6+6OAgxEn72
    D0K9lJIIVGmHcKumOmHX3CvhWphv/9pq3I4WfX0dlSd+/q9L8htFiCxeIDOI5gQqxVmxP2
    cfGt3BEmbFM/x6gPUPtA8cv4LJVJC/DLE6wZa2wCNndIcW0JH1sXv91CpJgVdtOyG8hQz3
    6PLqC0XrHyub57YQ9zprEcWQMZHMJguerFeAzpnDeJmI/MbZuoog6xV8lIlDEsYumCA0kv
    IcqbdihKMDj5uGnpkFIZIuV0MaetngYDoHXMkW89b9WzeHrCPVttkF4Lvjzg
X-ME-Proxy: <xmx:86VXahNWbksZt433ubgkOP29JN9ZWxS7hppjj6YhWf7geEkDLyRaFw>
    <xmx:86VXahWQ8W4TF82Q7rE82142WuO0w5dK0PnwCU_mmaxD70-PZlf_ig>
    <xmx:86VXanmuqyZYmgn7FaBtEmk0Qntk-6zoUIP6dWmaxw2oOMqlz8xUpw>
    <xmx:86VXaoNoJg9HJ2zeJoKvKZCeQ4hdtj8Ag5M_VsZme1fG14NgBJy9YA>
    <xmx:86VXakSo-ZWVjO_zK3eN5iW1E25uoJ6q-6c06kLkAPtY2JEx9CSFyfGw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 11:23:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: <chandrapratap3519@gmail.com>,  <chriscool@tuxfamily.org>,
  <eric.peijian@gmail.com>,  <git@vger.kernel.org>,  <jltobler@gmail.com>,
  <karthik.188@gmail.com>,  <peff@peff.net>,  <toon@iotcl.com>
Subject: Re: [PATCH GSoC v17 00/13] cat-file: add remote-object-info to
 batch-command
In-Reply-To: <DJZ0JXIP13UO.DH1ONBDEVF3N@gmail.com> (Pablo Sabater's message of
	"Wed, 15 Jul 2026 10:48:40 +0200")
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
	<20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<xmqq8q7dto8d.fsf@gitster.g> <DJYNU7D4A7C8.3Q2Q4DX27RXC0@gmail.com>
	<xmqqpl0pqdag.fsf@gitster.g> <DJZ0JXIP13UO.DH1ONBDEVF3N@gmail.com>
Date: Wed, 15 Jul 2026 08:23:29 -0700
Message-ID: <xmqqfr1kp98u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

>> Thanks.  How close are we to the finish line, by the way?
>
> There's one month left. Final evaluation ends on 17th August (more weeks
> can be asked, if it seems too rushed, ...

That is the deadline to wrap up your work, which is not quite what
I was asking.  I meant to ask how close you assess this topic is
to completion at iteration #18.  Are all remaining issues just
minor nits?  Are there still large gaps between the desired and
actual behavior of the new feature?  That sort of thing.

Thanks.
