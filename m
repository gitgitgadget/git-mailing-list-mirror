Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFC21FF5F
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158712; cv=none; b=Exv0mvlDrtHgLhNbRQJFHtOItoDuHVga1OAHvXq/5g/o9/O4Iwx0Q6ttHB7JUPQ4raYflQLZYyLCxJJ3jBAocIou18UgyKER0buTSlFlIB3GV7S/R7yEMrRLXBsq/2QbzC0IC5x8JF/emQzvB1M04TrkgA+ZngIeruAm5je2l7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158712; c=relaxed/simple;
	bh=QRSMm8QPswVI2Tu43l62aNuHu5noLmXkLz28lovv9Is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MeY+S6/dk4Yi3seqzh4vlySTqSPXJkHJMkqD0vyp3foZ+AHt5NUEyPK605mdyiok8vCjsFd23zhHoZm+hj7Sgm3vVDT7/AyflNXgkqeP8LjVRUIWZeWbpcsE6PuJBydKbXtf1DOjQ/NT+unSf3hVsm0KE9IPuM31zYanqWJooZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lT0VRGUJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wFlLjLCa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lT0VRGUJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wFlLjLCa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C5DF41D0017E;
	Tue,  3 Feb 2026 17:45:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 17:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770158710; x=1770245110; bh=xB/F0toS2l
	kWLm4Pi7zBsHG22DBSJBvRy09kIRD5Tzc=; b=lT0VRGUJ1SCC0zauRJN36Szmi9
	lXQVj0qRNG5S20idjTNVSCYmZ5n3cHv5pe7QGPhnNbBXr1RMuX4AcQFI+PxHPUKq
	50ur363XYgCGyAupv6SmCYA+lw5Q2GQX+XIZAmtWcLjDah0bFQjyzoVlVKW+5Lhy
	eAQJa8/DspYzv8p3u5egOUD7q0W25GAr84hGCw715huPujSnPC7lxDEb1DjEGF42
	xlUZ63Cexj5LV6G9eOhk5dq/ZctzsyPwzU14wgWkvIGDD96QBJNaDHlbsWAMlQD+
	f3PIKokJXKbfUdGAmEiziqZwFyddzhgmKl3e8AW4zK1aDlMpx+TZCnxu/tXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770158710; x=1770245110; bh=xB/F0toS2lkWLm4Pi7zBsHG22DBSJBvRy09
	kIRD5Tzc=; b=wFlLjLCaVuaw9lA6UBZkbRhQ+daAInYI/xt/yyCrGx2Z6UYEEhL
	m0AYbkke2jj1Ttl4qQ0VzHHU30H5qQ8bMhi+Uhu83zntU0EqZ5VMAKjgCfSksAqo
	S75oGusrb+4wkp23Km9yzu+YSYJkbF/lQ/EzLTvnrzdy+AmUe229RHwr/Lglql2E
	IMPw8tzyz0rx8cJ3HTHOd3lIahWekIWxLQEmW6VsNX+8Uvaci6Em7+5d8t4evisV
	fWUOfx4xkRqNWon3KQ7ppkYm7DwXTb5EiBmwl8nuP7roVlnOW8MBrakBIpwdDGpm
	DADdY8B9YJ3lD+NZLMTTRl8P2S2f8ZAYxDQ==
X-ME-Sender: <xms:dnqCaWZEYb-qZdV6MFwfZDlJK3ps5ffASfHKIiRZDpZbWEdh6TiU8w>
    <xme:dnqCaQ27txMGKtQq9Hs3hCYhXDSmhQobppuGtgtDofrdRi2u6JhoDWoWQPF5cVVtq
    8slrGGESkMuI5kYU1g57RkeIg6LShqLGkdkfELwIUFeSsg2WjVMFRY>
X-ME-Received: <xmr:dnqCaeVawmEa9q16ADsZFSQtfPQ5RTBxBNbLfSUUq_RsKfUJiE1lDvpXFASURae_sc-Cq7cUN38Fy3wzcr-5puOp0PADdf1Zlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dnqCaSX1UIddPBw0erbHfziSZEkDbfhf3udHpFBG3ML1cFT2pD_n2w>
    <xmx:dnqCaVcaNdgNU18wNHcRnkrXtsDX21ZB0EL2s3RybgtlaJQuOWII3w>
    <xmx:dnqCaTXiC4m-R6F-EtEGq__FI1XKnLAZIVzHfZZ8zlQ6OumZcWEowQ>
    <xmx:dnqCaWf4-fPd52tpHfkZeOPX2BJMRjyc4mVLxt8PBSpCOnv_u5rQaQ>
    <xmx:dnqCaY3XizVAhBNDcwuNutqXjKEKP2CzQmhfizHCUPYGtbhPuLkJQVBf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 17:45:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] builtin/repo: collect largest inflated objects
In-Reply-To: <20260203221758.1164434-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 3 Feb 2026 16:17:55 -0600")
References: <20260203221758.1164434-1-jltobler@gmail.com>
	<20260203221758.1164434-3-jltobler@gmail.com>
Date: Tue, 03 Feb 2026 14:45:09 -0800
Message-ID: <xmqqv7gdqwei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The "structure" output for git-repo(1) shows the total inflated and disk
> sizes of reachable objects in the repository, but doesn't show the size
> of the largest individual objects. Since an individual object may be a
> large contributor to the overall repository size, it is useful for users
> to know the maximum size of individual objects.

Hmph.  It is true that a byte is worth the same amount of money no
matter what object it is used to represent, but comparing the size
of a commit object and the size of a blob object feels inherently
meaningless to me.

It all depends on what you are trying to learn out of the stats, but
having many small blob objects that add up to 1GB and having medium
number of medium sized tree objects that adds up to the same 1GB
would give the same number in object_stats.inflated_sizes for both
types, indicating that they are costing you about the same.  But the
members in largest_objects for these types would be different,
hinting (incorrectly) that one type may be costing more than the
other.  Would that really tell us something useful, I have to
wonder?

One thing that is related to "largest" that might be useful is how
spiky size distribution is.  Among many medium sized blobs, if there
is only a handful of super huge blobs, that is quite a notable thing
to know (as opposed to the case where these super huge blobs are
not so unusual).

