Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974413D537
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291747; cv=none; b=Abd9DPJAY0Nxc7u9S1PJXjNbQa54XtgG8OuzMv8sbBnAkcA7SKXXM2z0aIX96Zinr9X9/w/OLddGF42UC6Hx7OA/C3VWczVOmQTxaxR+V4ofqK2g6tHyJW0Y96DA5ZOwihYkb/+XFbU5yHOGxSYvYvSzvEJ0OJ9nYuv972JtI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291747; c=relaxed/simple;
	bh=ddIpTZqNjY6knMKub4hsG3Jr87ScwYOI70akfkmcxno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwPqkfhsTJcvYFCGwjWxxU4wuUZFE72KEQp+nb3CoSX4cICxtgssL19R1CzpgVKXKSZV4VTgMgj1qQG+2/AU8cUsneP+9j6G70BpGAhmJoIp1lxcb46yjZOinYZrcVM6f1R1vGcXFvpEAt6r1SB/dGecz9K3cXQJNabMDte0ufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nNwqj65s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YI7j1oEK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nNwqj65s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YI7j1oEK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D8473138020F;
	Wed, 25 Sep 2024 15:15:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 25 Sep 2024 15:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727291743; x=1727378143; bh=ddIpTZqNjY
	6knMKub4hsG3Jr87ScwYOI70akfkmcxno=; b=nNwqj65s/xCaB6k0jgJufJe4IZ
	yhVsowWQcncrtwIUsTLjUPLl3I5t7WXj0XZ8yp+eBhtKfmLRHMXlMNydQgbL6htR
	FP/V9VM6rB2+rC5v9foU066y29z4K0JrnSf5JO3t7XP4yAg3x6t9Q1R6bxBCNw0G
	m5fBgtIHiqcq0hV/dWaa+qNc8moHcknNjvu5/W7drf8ukDO6Jze3w/n0DBJ2fe05
	3ncHGBUzpjwWGVxEAWPQ8pUCT9smvRvJncCehDiPipSQWFM8pthzWp5KqW3ZpATR
	R1pm8DjjMe/HhOjbN9ONHEJcN7deFpuoUEFoYSgF7zsDa74Qmig9PsH2V1eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727291743; x=1727378143; bh=ddIpTZqNjY6knMKub4hsG3Jr87Sc
	wYOI70akfkmcxno=; b=YI7j1oEKPesZsoGQ3P8CTQXDyHZZbOmNxYboPnUydshV
	qQ4mb3IkfIk5HHgIOPQG6QEL+R3na9ZICfyPVBu8KlXyi25n9d1M4u21DKd836A1
	RSqrBkRAFDkNCO3TtwJQYGeeHHq3Hz3D8pMv8YymtVR3TuGYrfQBS5KvyYrNb3Oa
	K1Tuh8HcEyfHwtb9mfkETkFU7UM57FgrU7pf5BVh42DT1CvEaK8B8DeU9+1/D4lK
	OVIZGL/WQG+n4VVeRew4bq9jcNFrm/7X9bNHNu6cw1wSGMJIhOIO1kx34p8k4gvE
	qYJVVS0DPkfTQooMmnKtkoeH0ASCORxMLG0oYIKUsw==
X-ME-Sender: <xms:X2H0ZpuhYzX1WFfyikzcYZw-cykaAcUtbiqdRJAroUaltMNOr9SB2g>
    <xme:X2H0Zictd-uBrvYQ-0foN_FT57d7Tqz9jJXsYe4fYdQagwJg6o6xFp4J3WzrmyArv
    -L3hE_M813QKGgkmw>
X-ME-Received: <xmr:X2H0Zsybo72YEA5-ep0jZSEdNjafuWqyO-ez5-BPJCHqFyb9VfTjuWxPTHyKkx0VsNajhR2sASTi3JkwznLN-ULMSnKu-SixzWa4ftoYHhVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevhfeffedtteeluefgtdeugfdtkeeugfelkedtheeg
    ieekudduueevgeehudekffenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvg
    hstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohephhgvnhhrihhkrdhhohhlshhtsehouhhtlhhoohhkrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrhhnihgvuggvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:X2H0ZgMKlomzee_SigAsHAImjCiOTO5afWPosaM_ANGquc5VKVIH-w>
    <xmx:X2H0Zp-56HKlB4J6mU07Qec29NiC8zuCJ1rnMpuCR0r4Y3ASQEEhLg>
    <xmx:X2H0ZgV_VoWo-LNPzG7zDm-EMGa0jrR_djjSTzCNBCRqtU-bE63f8g>
    <xmx:X2H0ZqckLF34ccHsgFzsmaUbBM4bDAunnksuAyDtRBGN4YJy-4VQEQ>
    <xmx:X2H0ZiNPsr_zk3SXLd-rTp8xn5mc6MTOt8g0o1Ck3JEPYAGICKFPhbZe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Sep 2024 15:15:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d641c53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Sep 2024 19:15:03 +0000 (UTC)
Date: Wed, 25 Sep 2024 21:15:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Henrik Holst <henrik.holst@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
Message-ID: <ZvRhUWcQL2hN4rWU@pks.im>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g>
 <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
 <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im>
 <b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
 <ZvOTL0cG8qRY8OXe@pks.im>
 <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>

Hey Eli,

dropping the mailing list for a bit: I really want Meson to start become
a thing in Git. I very much feel that the current build infrastructure
is antiquated and has lots of issues. And while we do have CMake wired
up somewhat already, it neither is a replacement due to it lacking heaps
of features/autodetection, nor is it a direction I really want to go.

It also seems to be the right point in time: Junio hasn't really been a
fan of converting our build system in the past, but his response to my
ramblings was surprisingly positive. The session I hosted during the Git
contributor's summit also seemed positive overall, but I naturally still
anticipate some bikeshedding.

So I highly appreciate all the info that you've been posting in this
context, as it helps to solidify my stance quite a bit! Which brings me
to my ask: would you be willing to do an off-list review before I post
things to the Git mailing list? The intent here is to mostly make things
look as nice as possible and work out-of-the-box to hopefully sway the
list more into favor of Meson.

My current state is that I've got libgit.a set up while detecting many
of the important platform-specific bits, the Git executable links just
fine and I've got unit tests wired up and executing correctly. Still
missing is documentation, Perl modules, and fixing some last remaining
bugs around locales in t0200 and t7816.

Anyway, the current version of this can be found at [1]. Feel free to
have a look and provide any feedback, either on the merge request or as
a patch on top. It can be built with `meson setup -Dpython=disabled
-Dperl=disabled`, enabling these options breaks a bunch more stuff.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/217
