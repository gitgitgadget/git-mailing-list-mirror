Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D833C1A3
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941529; cv=none; b=FTRqckmuSpH2ugHucQusqDLDuCbXBkxzpR9Vy1zHKqKdP2QRetAg5DCpsPb5WsjXyDOKAFiv2eh5wYKZq7QMlScGzF0qlGkzf4UDjKOSNNVSAoSOn+8rKlkUCKaJj7BrWw2cR5cPM75nBqKYkDqmiZnJR/sgwZDo+fBioGhDvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941529; c=relaxed/simple;
	bh=A5bWBFz1rsBwA2YhK2i4XTt7uZqFTc4Yd7cuGBZvyGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Swso93weNgWi1Sbjvsm2mGEFpIAXFayDmazzDyVdKkKME7QMIY+ITZxJenk2DL0JAixTgu85dxk3RYDqlMRKecbU9NtED0P9HqnrkmkZrKAsTl2cQyjAsMZLWCovHaI1iuJ/wYcexV+o4lPrP3Q1EH4RTUWCwkyXGKi+tEAQcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FNSXCe67; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gorvZr2e; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FNSXCe67";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gorvZr2e"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AD2A41D0009A;
	Tue, 20 Jan 2026 15:38:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 15:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768941526;
	 x=1769027926; bh=+O/hEP8LPHtlfjdo4RgFplnd3blbXn7/KvgDVYfIt2g=; b=
	FNSXCe67uOqrgtKvUYgxVw2PT5rUmDPEOtd9N70sb/TgASdoGiabcF/i1hSBQFlj
	2egdKhF6gAM4SVU/jUovW3CZVg9mQB/bACyKQTkvVAmpR9lIXe9YNZ0RR7JzMf7L
	tHAXZxlAWpSgeWBHBmWJZnjTATqyI1cFZMni23VQVWEa2T9itqH8YCTwr6SKIYI2
	0Im6ywPehDzOwumjIBOtAZj2T7GFQgKp3zANOAtmdnsCd7ONmrMgN1DoQa89boaC
	HeLWLUkKOx2F2fGXNShi4EIpkxfomnvESP89117F+FV9ZMN83ei5TkGJ3EkMt/j8
	Xb53k/OH7u56sojcd06swQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768941526; x=
	1769027926; bh=+O/hEP8LPHtlfjdo4RgFplnd3blbXn7/KvgDVYfIt2g=; b=g
	orvZr2eeRV2HcG+kmMvG+tFNZE1pEl6JO3njPqpZ9oYYNig7AtQM62+u9UmUfzKh
	9bHlh862IdnzMbLE+Z8VCgd4uAo2JHVMON/FHZ0ab+QA0GSgXBHjNJhm+j2R3fs1
	E0N7iBJ6F9sea+cR592kk7/g+VRXRc0s+RemAhW0Z76BHgJpwmG12YRJMLx72xRA
	a3erzGgntj7a0yBl5Pgt+apJNJwzMfKOV75A41wzTVqJcPKVMRKn2jIq3IM0tWDd
	+4YxLICXowgfdfmccos1V1uI3xxxINKcdI25yWZV9eVtSxgJn0FpE3+7lGtRO1Si
	cnlXFq44QE5beqblPAKSQ==
X-ME-Sender: <xms:1udvabqTsBkg3pUTqR__dv1JRm3bQL5HaXcLhvPM6S1dj0ftdxcXUA>
    <xme:1udvaYPiE0N-OJwMtpc8vyir9dulQRPL7-RvZC1Ms92lWOXyyNU1mLU38j4qBYeRr
    SF-_XY10Nit2fMgMlMXXjwqyZRPU4f2rGDt7tZQW8tqEHUZ3CV8zgw>
X-ME-Received: <xmr:1udvab342l64K1eBS_1T7fV7djzdCPNtvBLq0N9GSEl36WhMfbGhhxcorGmje9g7ZNDd2Ifb9q9ZUl2pEbcRkM_zHG4o6xBeGeyPrcs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedufeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrvhhilhgrrdhjnhesghhmrghilhdrtghomhdprhgtphht
    thhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjrghsohhnuddutghhohgtrges
    phhrohhtohhnrdhmvgdprhgtphhtthhopehjtghusghitgesjhgtuhgsihgtrdhplhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1udvafBrfmD1NxLwIazJvHXEr6GDDOG0aWWkzrVgViCLxlh5RKS1qA>
    <xmx:1udvaQLFjc2YFK7ly-SduUzduSzyBbjn9MDWU1F4TlGYyzQ6Xg0n4w>
    <xmx:1udvaQlk1k8B-IV75PsCPggDZgot1qYXDsUD7FUlRolelCaAvyOMMg>
    <xmx:1udvaRaqe2uQse7bX-2s8JhSMifMoRfBWDInVvSdqRx1RexEfqp53g>
    <xmx:1udvacLUu6A11HW_RkmZGjgmvpEqzXaM6TCVDUBY0DjLErAFyrfMaqL_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:38:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
  git@vger.kernel.org,
  =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
  Sergey Organov <sorganov@gmail.com>,
  Ben Knoble <ben.knoble@gmail.com>,
  Jason Cho <jason11choca@proton.me>,
  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH v2 2/2] doc: git-worktree: Add side by side branch
 checkout example
In-Reply-To: <CAPig+cTZ4WpO--jCFPZOK6POFzrux8m7Rhw-p1FkJR+NOD3J=A@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 19 Nov 2025 02:19:13 -0500")
References: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
	<0e11e6fb394ffa3a1286deea5a8ede5ba3e4bdf4.1760115862.git.msuchanek@suse.de>
	<CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com>
	<aPtRzTwVgVfqjaZT@kitsune.suse.cz>
	<CAPig+cQoL_=WdNpcO_9mTLDRRDHCOC1-nYMwUyfaev3BZyzaow@mail.gmail.com>
	<aRxgC7TAopqsrZen@kitsune.suse.cz>
	<CAPig+cTZ4WpO--jCFPZOK6POFzrux8m7Rhw-p1FkJR+NOD3J=A@mail.gmail.com>
Date: Tue, 20 Jan 2026 12:38:44 -0800
Message-ID: <xmqq7btcyq7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Nov 18, 2025 at 7:01 AM Michal Suchánek <msuchanek@suse.de> wrote:
>> On Fri, Oct 24, 2025 at 12:57:42PM -0400, Eric Sunshine wrote:
>> > Sorry, I mistyped that. What I meant was:
>> >
>> >     $ git -C myproj.git worktree add ../feature-a
>> >
>> > which makes the worktrees siblings of the bare repository.
>>
>> and requires the mental gymnastics of adjusting the paths passed to the
>> command based on -C argument. Does not sound like a good example how to
>> use the command.
>
> Fair enough. I happen to find the above easy to reason about, but I
> get your point, as well.
>
> So the remaining actionable bit from the review[*] regards spelling
> out in prose that hanging worktrees off of a bare repository is an
> explicitly supported mode of operation.
>
> [*]: https://lore.kernel.org/git/CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com/

The discussion stalled after the above message, and the topic has
been dormant for full two months.  I'd drop the topic from 'seen'
soonish but that does not mean an improved version of this patch is
unwelcome.

Thanks.
