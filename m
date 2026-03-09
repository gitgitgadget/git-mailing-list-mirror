Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CB366053
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087274; cv=none; b=lQicvFmf43t9Tv2tc4QHf5MYGQVtLuXthg8QSZEP7s1YytlGwolSEDnYra5RatxPa3rgn7CFH5BArETvNfop5Jp7Z5nHqYZ1/WX+cX915VEX6CipB/oD7SyK0k0Wcuf9B1Em0Bo4U5KLBoxyD9rYzR1fGbznoP2WUTAy34DF8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087274; c=relaxed/simple;
	bh=js6F6wNfLB+toUonhn676MHQhpW9yPoWFA1efqU+WaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9O7gvYz+Bsrxyrz9pQp/OBCD4gaPjGnuP7fwxZ4x/UsylEmqzf0U9daYuiwB56EGUFnh9HXiUN+MzdBG41bQ/WU3Kk9nnEeGNrVVQ7TR6h61zqAVf6kSZ4FrTJiAgiSjs9H/vGH+SVldCEvYplRRVoQGhKwfnPfWAp8lOZPWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G20u9zoI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFuiEMF1; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G20u9zoI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFuiEMF1"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C66F1400012;
	Mon,  9 Mar 2026 16:14:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 09 Mar 2026 16:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773087271; x=1773173671; bh=muzfkIfuun
	9WyTf61zmewi26jPmig3r+Bu0EgFucAag=; b=G20u9zoIInUm742WeYmU8dGhbb
	FVXQI54TEzksIG3KBR+kuu5ZdZVg1vwQwN/CQfdhKYq3d6+pITCyvzYL4RzANyYA
	zqjhQ7576BE5yXdA6MZqxWySmx+P94+yyJgYI8OCGrTJauTBsbxmVztkhdrEh5Cn
	Jmx6JhTIb7AtK+lMCgTAq+2hIJlkPBY/lZ/qhCeKbb5meJJEyl9l65R3z+V9PxXh
	uzi+3wdkgPUgSsmXllZ+Uq9UGrQVAuseeHwuINff1VN97wcXbCKdiOvI8TIPifnu
	cdeXYo/OX1BABxbLyIWO7PDLYNSy/2nfqXSplWMQdXJWM/0dx3BU7AQ7LUDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773087271; x=1773173671; bh=muzfkIfuun9WyTf61zmewi26jPmig3r+Bu0
	EgFucAag=; b=kFuiEMF17FGIwSYHlGZLpdrSLVDZ15iIXN8oH93HJbLQ2mR1ow9
	8fMaIsEyGEO17DFZ+IvNYUnrWgemd8k80PgjZgQN4F8pVFcbIRdzwAOC76HdWvXV
	FUIG9R1VPFSAPAPyA2n0GTX9g9MtwoXCDS3HtRZe0dVRM6a3btoHaAYrX7YBwo2N
	ujJ27HR0hx9RNQti7/X/V8xn33KHg2iocdAoa0xwkgyyEKePG7EeoJrJi+STcW4y
	Ls+4SXKt9eLd4RguOvbficRlD/LjN6HlyJrWhkQsjitBPyp7P6xx+N1ofs6OYF/o
	UAdkOB8xc4NcGmhd2TsDNZC+irEXc5Wt6HQ==
X-ME-Sender: <xms:JiqvaUeBtQv4rtIqMnRTbHEiZjplauSfPh3uuJQbDjPt-M69a83ppg>
    <xme:JiqvaZ4WU8XIwfdCPGwAmGqM5Y3F4n4AtvZLkmHFyvprb8Dq49Qidq5wktRyR9VEx
    bekg4_60s0iRNE5YysZduLJYAHFRpJnAWxQHdDIkO8r5Oi1ws3v5Q>
X-ME-Received: <xmr:JiqvafXvHdFwckIAX9CHOTZcQiF__p97iKXMaG6W8ie94_6YqL9VL5RxqqT-xPWv0BJ0jgdil22oCqQ4WwrSQ-xKQAp2_g_0Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:JiqvaQ65Hn9uBV2it6zEK_67uj5Yeq-TD2aETepLa5UGr_9dkhDrDA>
    <xmx:JyqvaSoutd2tCGKcD42RYWpgS-4TWWZNoImeeTzb92RCtsJ7KOvRRw>
    <xmx:JyqvabmChre2BG1NafxuqMucU4EI3OBs3yK3KaOI23aOXbJd_NXhvA>
    <xmx:JyqvaWNVTPzm0U6x1UanrjJai4V_V5mNiE2ALeYrl1_7En4FnPDehA>
    <xmx:JyqvaRUt7IYiGtHKAYm86x904v6CFiXFLQ2xkaJSf31n6nyC0PiQz46y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 16:14:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 00/10] config-hook cleanups and two small 'git hook
 list' features
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 02:54:06 +0200")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
Date: Mon, 09 Mar 2026 13:14:29 -0700
Message-ID: <xmqq1phs69qy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> As promised I've spun-off v3 of the config series [1] into its own standalone
> patch series after v2 landed in next.
>
> This is mostly minor cleanups and refactorings + two minor feature additions
> to `git hook list`, which resulted from the previous review discussions:
>
> 1. The ability to show the config scope (--show-scope).
> 2. The ability to show which hooks are disabled.

OK.

> This is based on next because the config hooks support is only in next.

Not advisable, as doing so would take your topic hostage of _all_
other topics in 'next', and it will _never_ happen for all of them,
including the merge commit that merged them into 'next', to be
merged to 'master'.

After learning from the output of

    $ git log --first-parent --oneline master..'seen^{/^### match next}' |
      grep ar/

that ar/config-hooks and ar/run-command-hook-take-2 are the two
topic that may be relevant to the config-hook topic in 'next', and
knowing that ar/config-hooks fully contains the other topic, I
instead did the following to prepare a base:

    $ git checkout -b ar/config-hook-cleanups master
    $ git merge ar/config-hooks

and then applied these 10 patches.  That way, ar/config-hooks can
graduate in due course, and then this topic can follow, without
waiting for other random things in 'next'.

> I have pushed the branch to Github [2] and provided a clean CI run [3].
>
> Big thank-you's to all who contributed to this up to now,
> Adrian

Thanks.  Queued.
