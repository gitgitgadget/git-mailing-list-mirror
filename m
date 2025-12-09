Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085122CBD9
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 07:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266823; cv=none; b=HXWJHJms6fAgqatbyG6sGnTXlIrfAE9o7XziCbhykdJRkdS7CTeBX9RTsvXnBRXMBJ8zcSR85NO8Q622gaMbQW7RjjgOfHXW5CWq3s965jU+sFSqAZrHvxG7mGqogioB89VNmFqifeQU8SIxswmOqhPdZSPnShzIyoGPriNQd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266823; c=relaxed/simple;
	bh=GdLcSrXTV0EwhyKauVNlwZoFPEUwUQQ6GzBz/NKOSqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmurloIBQXxe+aoh40JWEUi6Cw0ojdT0ClCuREEGfNQCRTiP+7LMqZiwuKuOR7rdPnSo5in6/anx1ZSkAppAoVykUgabBZAqkHbymfvC7ba4P95H4CX8LDOZylDj1W5tAJ4K3TsQ093oxbSz9fqpKWBh0xucKx053jo6FlSjir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AVTAmWW6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D4gvJgco; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AVTAmWW6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D4gvJgco"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 55AB0EC0599;
	Tue,  9 Dec 2025 02:53:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 09 Dec 2025 02:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765266820;
	 x=1765353220; bh=hrZgtwhcWIGKbMleDtTU8H1d10D+fKSxJ5pmBmaYbqM=; b=
	AVTAmWW6LIy1pFW/pqCdgqsnqwVx8xeQ/WY0ds77acLGiXjSXd6+461uRCBkiUPS
	lvTlHw+kLRelEctcBB8RgZ+siABuPYFdfghLny0TBx3IoobDWB9kgHqgzmPRRxNs
	5N4bY1jf8Q2LBUJCj6p9roevjSdujPAWw+m9hXRp6oC2QNDuB/b/UdUM7vN0p3+8
	zWnkYiz5u396HmJyIZym/1RGKh0qJBR0s6TgycOP9NMWudCGsBVuRu5am0rMmOM/
	rHa69FV0mfkv8nwxtsrRrxOHu0dYac57rckwYFjA6PwhZ+vfmNAWSVkA+xkScCgd
	9FaJSv8RuhuSACPyccfMRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765266820; x=
	1765353220; bh=hrZgtwhcWIGKbMleDtTU8H1d10D+fKSxJ5pmBmaYbqM=; b=D
	4gvJgco0x2dHoMWyjnxW3PeTkxmYYHLZJTB9A5xXM2L4KSwviTvzcfjmS1aS1v2X
	9A1JmPSy+wgiRSZvHNwlx6GyWXllGo5ilHu7lPdRU2WFX3L8/UTmIzd8aQ+eRxxe
	sc+xxl/uTTnyEPkpx3wQvZKQiVL0dqJZxI2bwtHpByYHlGEyo2ZfTQo1Y4YGy/F6
	K7fTApJ3z1mQkHtAdZwUjJ8WAk3+xHw2J4Rch2bipYKQTwh0lfRawecu1dpA9iQc
	MCn/VGAnmO3QM9SZfTO1OXr0LB94GfXCMeiJ5Z05THesVAFX/OHNu71FqiCWcxHe
	OXrI9uMGF1RK4+vZtO0QA==
X-ME-Sender: <xms:hNU3aWYPS_4Pa0O3UIB6vDDRN4kXZyFy5dnDk7GAubW105KXXpJgDA>
    <xme:hNU3aV8Zn9OSl0Vxq2yzWo1s36AeaCPLY94FKug-_zprPpSsRvGT-dHUv0HMiaAi8
    MBa5k4s_Cyk_iPP2wakfhhFt1Bm77DFNXl54jvp-TDIgF2feNGI>
X-ME-Received: <xmr:hNU3aVZgw0SX41RAP9pLcOO-8KQ8C-WNfWwvoGttqq5eUBEkrJ2PdeOIrIwWCQiFlTVa2Jro4OTJ7P7tca6P7Sysf6zh6FeQIHlIuhgWzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrg
    esfhhrvggvrdhfrh
X-ME-Proxy: <xmx:hNU3afdJemNHrPVRVwLlRuuwiD0foCHJjtT0uoDjOPcSn2kD_hhfsw>
    <xmx:hNU3aSlAV_eAe07E7ucdvn3qugnycU7b_CeyGQtNwNUG0GV-TDI8Hg>
    <xmx:hNU3af2emUD9RJFZV7IcACHJAZ7WUdMBW4xPoONXZ02lVCHVmV5B5A>
    <xmx:hNU3abdoPBENebW2un6-0g3YyWpju2I3xmX8e3_vlsC5ALnKJKTcFQ>
    <xmx:hNU3aUriYYP8dPn0nJE3TBrbMWs3mDlU4bEk0w8AlFY5o8Q1T8eVvx8S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 02:53:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1276e968 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 07:53:36 +0000 (UTC)
Date: Tue, 9 Dec 2025 08:53:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aTfVfenbwY685fDZ@pks.im>
References: <CABPp-BGLrVv=maEqhs=j9MmST-F=K=XN6gGqmd9Hox5QRDMiHg@mail.gmail.com>
 <xmqqbjkw78jj.fsf@gitster.g>
 <CABPp-BG+2+vanKAS-cwAD2XZxwx=PPcu5OG58ys+8O7rfZEhug@mail.gmail.com>
 <xmqq7bvk77lr.fsf@gitster.g>
 <CABPp-BEyMFiRdHoseTaYG9rUFO6Ta=dBG88CGRb3CfNf8aSAkg@mail.gmail.com>
 <3fb47b15-ed43-4137-95f8-cee97ab5e44c@gmail.com>
 <xmqq7bvj5q8m.fsf@gitster.g>
 <CABPp-BEVX85xZ7_1fSfW4-xJod13p2-HvQ-e5ga+m9-Sq7mbdw@mail.gmail.com>
 <aS80z0DxAEBLba-M@pks.im>
 <CABPp-BFtx7-vLFbVqbHar=UZb1CGX5=ufMA4hrJRkSYuB14_Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFtx7-vLFbVqbHar=UZb1CGX5=ufMA4hrJRkSYuB14_Tw@mail.gmail.com>

On Fri, Dec 05, 2025 at 12:49:04AM -0800, Elijah Newren wrote:
> On Tue, Dec 2, 2025 at 10:50 AM Patrick Steinhardt <ps@pks.im> wrote:
> > Consequently I'm leaning more into the direction of doing nothing. It's
> > not really clear to me that this is a bug, and we still can introduce a
> > flag in the future that opts into the behaviour of rewriting relevant
> > branches. That behaviour certainly can be useful, but I'd claim that
> > it would be rather surprising to the user if that was the default.
> 
> Well, as I stated above, this is basically copying what I view as the
> fundamental design mistake of git-rebase.  The many other points of
> feedback I had on this series (e.g. extended headers, reusing replay's
> walking, etc.) are things I could easily negotiate on; this one
> bothers me much, much more.  To me, it ruins the command and makes me
> feel it is unsuitable for inclusion in git; this is, after all, the
> kind of thing that made me decide to write yet another command to
> workaround such a flaw.  If the series is merged with this behavior,
> I'm going to be in the awkward position of feeling I need to actively
> recommend against its usage unless _and until_ we either
> 
> (a) check that a commit is only part of one branch before proceeding,
> (b) always require the user to specify with a flag how to handle
> commits that happen to be part of multiple branches (even when a
> commit only happens to be part of one branch, in order to allow us to
> not bother checking whether it's part of more),
> or
> (c) rewrite all branches that contain the given commit by default
> (with an option to only rewrite the current one).
> 
> That said, obviously the choice of whether the series is merged isn't
> up to me.  And maybe I'm in the minority, and others don't care about
> this issue at all.  But it's how I feel about it.

I guess it's a matter of workflows and tastes, and there's never going
to be the one correct way of doing things. I don't think (b) is a good
option as it makes things more complex even for the simplest cases. But
I wouldn't be opposed to a combination of (a) and (b) if we can
implement (a) efficiently.

Do we already have logic like this in git-replay(1)?

Patrick
