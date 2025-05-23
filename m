Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347D296162
	for <git@vger.kernel.org>; Fri, 23 May 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011752; cv=none; b=mnH2X7gKF9QbRT4ifAcFYFT0OIEJCeTyFujbT/13Tdl1bjsce+wxs/QwCuKnSjLnxlS457yxr/QFI3Tn2EzAuIdz/EONTOjJeCDpnWDxALRdB1mfkaysvy1n1i3udLbtokebxZQGeSlkJzpVweF8h3+XLQlRNgV3szi7puj8Yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011752; c=relaxed/simple;
	bh=rCrhUi+ehWkj1Qtx/RcqDYWr5K7prgDBS2BbW1k8ZNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUOWZFvFxazzwz6NSpgx7dFmuAiCHsAiAcZvcWyzf9aIyKi1H/jDh03T0L/bleMrsLAuIDitcoIM/KC+aJML2wiP+OXLqs5ySoif/f7hqKUs/1I0jbcaUMqnY+1Q9x29KI8NEBUIMNv/xZcK8koJ9OcsaW8CUyHBtoMfE+ILBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HBJXAEN/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LXj3hVyQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HBJXAEN/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LXj3hVyQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 367AE1140151;
	Fri, 23 May 2025 10:49:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 May 2025 10:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748011748; x=1748098148; bh=nsd1fbn1hO
	jq7wqSiSEEGPTnnbaga5U4bGJ/LQmJS2c=; b=HBJXAEN/YqRhhc5wrIVxg+eByv
	n1lyKV0gE2hG+n1dLddIwONgBN4x0aob4uQrJ4J3dDhyUOaau9jal0NSFUNW31wH
	RjpDKMXsleJ9JQAkaYKMnMUzayJwJvJ5plHRG6umv073S+T/UWw503XSOI+eo3ml
	X2SwEqw5zydHHbLZi+4qj0PcBmp0nIbxi6C1buU31NbZ7Dx4iI4iM3b7bX/zWIw5
	MyQixBelPLd+Y0iXO2KablMLN3uooevZ3dRxxE1DEQxnzmHEiDEmzimwhDOA53v1
	BU5Piu1Ye3AFyGS83loGCMBtge0Amnue3yQas+uK4U5E3F8OFZxBZqe6YxeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1748011748; x=1748098148; bh=nsd1fbn1hOjq7wqSiSEEGPTnnbaga5U4bGJ
	/LQmJS2c=; b=LXj3hVyQyu9TM89XASfGYHLaKp6qLFZUNiaxGd4fd5zqpDUGBtZ
	N/IVspW64Eb466D3pjenOZANWzd/p+TUO/8vfcLrk4BqoAD1bVx+Uxf35VOVuQou
	ZhPJbOnYcqjhrJ3s79oosiXgrjdkTolDVQ/6VV92rahuTw+3iXL9h830gpnxNaal
	szkEMXIWIpWbp59AfFVSzKfaODpf5F1s6/40iekWYgWuQEb8tA6UAwC7CGhjCpUk
	iqjkFPAPbKiroKxQ0FDOHMCrZhplvZKcR1wv7jaeMOuydOyyeF6x5XINBh6Y18mK
	5cum8GpPFzWYzCm7U42l59Kxz5Gm6ElCpCQ==
X-ME-Sender: <xms:44owaNXx4zFYFR45NwfsywV3w2vn2Wu4uUR2etlroqy1idzZGh8hBA>
    <xme:44owaNlxpfe_VbkijgNSOQD2CWPvas-WleY6ThNS7pW0r3bQCF6cRpfgjmxr_VJqa
    3bs-LHYHiwFHQwgnA>
X-ME-Received: <xmr:44owaJbHJi9ucIcUz-KbX73gUIkhMxcqW_Lvaef1yLwofL39i99s_9dCvm0wD1pEHnWGBL7uAtwAxWP2I0IM4Y0P119z5gpHNNo-hi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeludefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgrrhhksegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrghnughrrghprhgrthgrphefhe
    duleesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:44owaAUr_0FbRbEdELgIx-GGLlScF27zqj7Z2JJoUQjXexOCFuaDkw>
    <xmx:44owaHmTK5XLD2z5IpNwC8mC8r4keppuXCkDeOhfrTpY2ztSr8Grcg>
    <xmx:44owaNccfwxM7mtH98DcxaLyHuDrIRqLtYs3kZlRNhv7sIH50ngU3w>
    <xmx:44owaBED2gDgEYAuzaSFBWjCyHNfR6GYOUZxsXU2RF-ZUHnrStoiqA>
    <xmx:5IowaFcaMhifK6TlhLgRnhDpo_wpcuy4DVPQuV3_czJHOSYte5CLgz2o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 10:49:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mark Mentovai <mark@chromium.org>
Cc: Git Development <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH] apply: set file mode when --reverse creates a deleted file
In-Reply-To: <76ce493d-d5bd-fc63-8942-76d0b3cebbf9@chromium.org> (Mark
	Mentovai's message of "Thu, 22 May 2025 19:48:05 -0400 (EDT)")
References: <20250522220235.8650-1-mark@chromium.org>
	<xmqqtt5c1ccs.fsf@gitster.g>
	<76ce493d-d5bd-fc63-8942-76d0b3cebbf9@chromium.org>
Date: Fri, 23 May 2025 07:49:06 -0700
Message-ID: <xmqq1psf1ixp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Mentovai <mark@chromium.org> writes:

> Junio C Hamano wrote:
>> Mark Mentovai <mark@chromium.org> writes:
>
>>> +     git checkout -- data.txt &&
>>
>> This should be a no-op, right?  What are we testing here?
>
> This syncs the executable bit to the working tree.

Ah, OK, you are simulating a filesystem that is unaware of
executable bit, so the bit on the file is ignored as long as the
file is registered in the index, and the executable bit in the index
is used instead.  There is no need to sync, and it would truely be a
no-op on a filesystem without executable hit, but when emulating
with forced core.filemode on a filesystem with executable bit, doing
so may make test writer feel better for whatever reason, since they
can look at the "ls -l" output insteadof "ls-files -s" output to see
if it is executable.

> I found it useful when developing the test, but it's probably not
> strictly necessary as the test is intentionally independent of the
> executable bit in the local filesystem. I can drop this if you think
> it's unnecessary.

Yeah, I understand the intention.  It is more like debugging printf
left over from development of the test.  It is misleading in the
final product, though---makes it look as if the executable bit on
the filesystem must match that of the index entry when running with
core.filemode=off on executable-capable filesystems (to be honest, I
am not sure how burdensome it is to the code base to support this
mode of operation, where core.filemode lies to the system---but it
is handy so let's keep the promise, "filesystem executable bits do
not matter when core.filemode is off, even if you are on a
filesystem that does store execuable bits", which the current code
makes).

> The file that I deleted at the end of the previous (apply "forward")
> test was not executable. It's important that this (apply --reverse)
> test begin by reversing a delete of an executable file.

Yes, if we are trying to see how "removal of an executable" when
applied in reverse turns into "addition of an executable", we need a
sample patch that removes an executable.

But you can certainly flip the order in the first test to commit an
unexecutable, turn it to executable, and then remove ;-)

In any case, for a better coverage, you'd probably want to do both,
i.e. reverse apply a patch that removes an executable, another patch
that removes a non-executable, yet another patch that adds an
executable, and the fourth patch that adds a non-executable.

And the two tests that applies additions in reverse would probably
need three states to start from (i.e. the file does not exist, the
file does exist but with a wrong mode, the file exists with the
right mode).

> I wanted
> to give better coverage to git-apply setting the executable bit when
> it creates a file, whether it's in the forward direction or reversing
> a deletion, because that's the harder case (and the one which wasn't
> working correctly, and which prompted this patch).

Understood.

> On the balance, I chose to keep the tests more isolated,
> but I'm happy to revise if that's what you prefer.

I would prefer more smaller tests than fewer larger tests, so that a
breakage can be identified more easily.  &&- chaining 20 related
tests that checks 20 different conditions is rather cumbersome--you
need to find which step failed first.

Thanks.
