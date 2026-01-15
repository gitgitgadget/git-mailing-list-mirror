Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE93A1A2D
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483931; cv=none; b=B7r9iZQahqyRFX2hZbTtkpCneSEtWNs0boNuhQgBbFM911AjiITIZuW5Nz9+5bTIqIh3SlwFJbuydqAn7Cc89B3g+SGPgJsqrkh3OHM7lI7j8zYBPDPjbyR99/lmoULrVIPL+sJ4QvIgh/DXmsW8fglOB0/Lq/4H8MhkSJ2TcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483931; c=relaxed/simple;
	bh=n7Hu97RnmcLnBBEo/hAc2Vl2SSJF+w2HuiChO0k5jCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EIQiRltwNBUTSiyr7qL2RPbKzidlfZvxO3ZdwGte1bjIfF581DQM1vJDGkHQ7Ztrdhj9cYp6kJYoMdQnLhrPPzUmvxwNYMW5/0k9TbcJ2vSW7ND31lBy7NA974njZQvgB+YDtnOdxzWm0fca3AWCHIAmCAmyNBNJ4XL+vQIcbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z0+1XZ6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrPMyHnn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z0+1XZ6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrPMyHnn"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1282C1D00090;
	Thu, 15 Jan 2026 08:32:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 15 Jan 2026 08:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768483928; x=1768570328; bh=5CgdoZMhR3
	05prfLOPrPgXuAqC0Bw5x1qguzfvoesV4=; b=Z0+1XZ6T3HuUdFQB5TDUTsb3I6
	tEOmNWMyIXtGyLMWbLZdbJXE+RBsJapPHU+6GUHGzAPlHFp8hk77QBq+ovpsD+jz
	cOREbwuxrcmvraS17w2ufEGC4AYEnr/f4VYSpPYIffvvv+6vVpgITdBgZZVdHaW4
	Z8s8dvFfnfltgFagjNy3Shn0Y92m2pOghT+cwjvT4WvlqvxkG4CY5SVDPNotF8f/
	87hpBDuBeUnYUvFgEZulh/XAZqvtS+sAwGntEb3fi9PeAZXhsodqgd9qdJxT8dSk
	j1ga7eyH23NfmKwwFfLECGcOLBtfWKBByin7i13dUjLtzbdfDHNKZHuSbw6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768483928; x=1768570328; bh=5CgdoZMhR305prfLOPrPgXuAqC0Bw5x1qgu
	zfvoesV4=; b=TrPMyHnnDKQkSdWxpmfWgwErs50ZeMAHZuw5SOfPTZ7b5AxSZlR
	7BRH13laF2ZpNMC5Ty+uysrS9sQvnlERIfinn1cb440Ben4KoZxJX57SKqXqsJPD
	dfpeVrgEmckOXHZw6QkqEr1wE0rcj8rBaGIobI8Mzkj+i64scNpeXgk+lGe6uCee
	tszMn0dA3rxIOSo/EjAT/d8+yZSsuiEKDhtY3p94U6iOVmoqPL9lyfCi1WcIrVUQ
	ISrU7i9w1S63FI1mfvCkAiBQZsPzAbx57p6o18h1eSYIuhGdsQK5t5Gxx00bf14i
	QVPhF/mb0WcA5RCokp7SJI95RMVRbyb7ohg==
X-ME-Sender: <xms:WOxoac-Eib-A-WVLvS8fon0XgsjCyb1OdwldC_exKjRfzkhr4tp6ow>
    <xme:WOxoacJ9hb0PCeXrj1lCef8AvxIfVVJvZmQgv4LHj0xnCe5JeTGU-S9KaTVIQTgyf
    nGlY-3GZ5eRurpgCw9y1jUA_J9CVTBZeop4RAJzIFyCkvGPRG1wjg>
X-ME-Received: <xmr:WOxoafbfKABzUi4AqmnYkOmbcRmi18FoOKFns5RS0nOvUAIIHNQaTy9TydZ89LVzrX3OhI0wNtg0nlQ7S0sxbC_yVXUUax2kkwBOSvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:WOxoaWLjMH4J5vGrqpROKiYOkxv2JOkC9Bz_76Qxij1xYV0uNtAg8g>
    <xmx:WOxoaVBY1KvKhG1d2hbUDSQGSBDPAfWYMn5lKPzQXQwipdeT6SRe8Q>
    <xmx:WOxoaTr7EsWGKLIJkhY4kpeX_UVLTvFDLnI-Gj0XnJWYVs1Q8T8k-A>
    <xmx:WOxoaYgdFkrNehyE3R39Ik2XYf7ehs98oOPAbI-RyEZhLGTi0u9qLg>
    <xmx:WOxoacT07BKesoKCzuW_qWCcHs4hI3tydGR8P711XmLwOseaHAyVTM48>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 08:32:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] Rename commit list functions to conform to coding
 guidelines
In-Reply-To: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
	(Patrick Steinhardt's message of "Thu, 15 Jan 2026 10:35:31 +0100")
References: <20260115-pks-commit-list-coding-guidelines-v1-0-c58868dbf412@pks.im>
Date: Thu, 15 Jan 2026 05:32:06 -0800
Message-ID: <xmqqa4yfdmsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I've been working with commit lists quite often recently, and every
> single time I get bitten by the fact that a subset of its functions do
> not conform to our coding guidelines. While most of the functions start
> with `commit_list_*()`, three functions don't. This patch series fixes
> this issue and renames the remaining three functions so that all of them
> start with `commit_list_*()`.

> Note that I'm adding compatibility wrappers for the old prototypes to
> ease the transition and not make life hard for any in-flight patch
> series. I've also dropped all changes that lead to conflicts with
> "seen".

Well, these are quite well established names, and seems to have
different callers between maint and master, which means that your
compatibility wrappers will need to stay there for some time because
these three patches will not apply to maint, leaving them in maint
under original names, and future fixes that involve maint, when
merged up to master and above, will still need these compatibility
wrappers.

Perhaps the new naming rules were introduced without surveying how
established names that follow different rules are and how often
they acquire more calling sites?  Should we instead tone down the
rules so that it says something like "when you are introducing new
type S, then call functions around it this way using S_ prefix",
leaving established names excempt (which is quite different from
letting sleeping dogs lie---as long as they acquire new callers and
the code that uses them change, they are not sleeping)?

