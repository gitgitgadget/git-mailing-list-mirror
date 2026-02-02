Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB8387349
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053193; cv=none; b=bEW+oFnltTiPCFv9TxZaYApFQFFr9A92mdpel3ME8DKuo/7XvkmvEP1s0/gn1yfd4pWg4OISWcIhQ3s0mTmmPD3u17Tu0f/S1zw0M7KVa0m+ceojfuS8VPTYjGNBcokm/nGQlHBr+PFbRrV/iyG40a2rpGFNG1jN1Wg4Q3UgDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053193; c=relaxed/simple;
	bh=XWZfMT7iVOd3YchlEporNCXhu5+KUb9hJnGq0P3ysOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTa7Y379TALHPYxhNvICD6oiNVaEvGJicEbhYUX50ghQzzg8J4EuwsGHanTiPjejxNtLU1zTq5rxbRvOo0E9MPvvga47madXWqICdV4IACHY6wvs1977A3YeME3IHr1Lel6DqRVuYZm4PCbnk3MFRxCCWURAE95Y8pFR0kYAenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IF4iA4tO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wy1LuU85; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IF4iA4tO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wy1LuU85"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CA2C1D0013B;
	Mon,  2 Feb 2026 12:26:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Feb 2026 12:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770053190; x=1770139590; bh=1Vgq96u9T+
	uPoZd7h45F6ENSOBNiALh61anMea/dq6M=; b=IF4iA4tOAulCrnLyqEzGmIj2PH
	INUHV384PdZLnQiu4J59hoARWUmbvbR0uY0xxZszdvMBkNMNgjAuhPGP8a/OsJqg
	Ih2znvEouNeWaHGNT3AZxHpyXn7XZCqA0MsKMb740okbLXv/rH0sOvfs8B88XHqx
	M+Hi8XVBBGzrfqY+0TxHRuRr6URWEdSq4C2Rmm0uE6+N3GBOT5xESJH9wnGQgVvV
	zWElZp5KFGOZGwTGR6lWNc4xuX4D1MZOjM3gLXT6DMutlYdn9ydTyw41xBEat8oh
	tzYh6FdJszOZDqin2jzCR/BEpQ7RPVD95rPU3tKRYQRpOhZsQ2flMlbeQI9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770053190; x=1770139590; bh=1Vgq96u9T+uPoZd7h45F6ENSOBNiALh61an
	Mea/dq6M=; b=Wy1LuU85EiS+xHiHUbxiV03kfNNOyLG9/5nnz/NHY44MqsVFv1R
	fm1q40e0vsdPcr20POlEq7jGCW12oGo0H3qkBvRoGWz+UJKbU8T1AWvvPbkWxQY5
	MZURZDuwYs0ZLmgUeOM0Eglsy5zWC6FnDjH1pKZ2v4GWYCStHXjC+Gvy7d0egk8N
	Vbu9eQ2mpFU6/yGkkdtdhoZWGMuDLafnnzjqA4rApzI3tSPwnDpFRZGSNZYt/nCm
	dEqVdieGVbSCvzzJqNYW36Ljaq01TUTBWukgPX5aWN1zLXPq07WgdgjMeicXyl+g
	1W1XveMUQWPn5vwBohPvH8vteyNf9N/SHFA==
X-ME-Sender: <xms:Rt6AaYMeuYgiWArC7u2MYtf4LInDEJOwjyr2coH8VLN4hosGle5Bqw>
    <xme:Rt6AaRiQs3XDGnFOoGH41DStR6iQxziMLwZbpCiAUGJBGOFrcvkEhWvP2VcTOxz9Z
    FugC-mczZ0dq-VXWQHYgK_GY_52CS4Op0bb2qfhM6LzjA7F7HR6qjc>
X-ME-Received: <xmr:Rt6AaS6_J56R0QcoL3VaVhiID5E-PEoslM3BuynGKAyj7BWhAFIP3MxI0_VvDz6yyKOkg7fCI_P_iM0r1QSNttDUW6UvhQ3f0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Rt6AaQ1wpDyMfQyil0IbMOVN2TeDfU1eqrJs1Qj5nV1GQ2qn3BvrKA>
    <xmx:Rt6AaVuTK6LftmrYRztKV8XckA8S9uoYoOEKpqsJjcevDxUxXqpk3A>
    <xmx:Rt6Aae41dwanUn0Fzu9AhCCTYi69eACkMvykZzaa4AGxfGZgMVwhaQ>
    <xmx:Rt6AaZfGpL9rnYoeS6xVb2eVgmwBzJGMw7WaRUnyFJtMhXbOcdyOaA>
    <xmx:Rt6AaUQ4DR_a391W3j1QYLHKD2EM-ELO86rBn0_FLyweSzyPMqZTWDOu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 12:26:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on
 all its hunks
In-Reply-To: <CADYq+fZFuvCRbFf=-XUR8TJsjW_YtjNdiXMzPv0mjMPbWcLO1g@mail.gmail.com>
	(Samuel Abraham's message of "Mon, 2 Feb 2026 12:14:16 +0100")
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
	<9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
	<xmqq7bt2g4tl.fsf@gitster.g>
	<CADYq+fYeWh0tLEepOGVa=1i9tXZfWaGfyi6H+xUB7rbdQ=t5aQ@mail.gmail.com>
	<CADYq+fbt7zHO=gAsRp=b5MTb=2aFfifCjWnW6u+58iv4dk6bMQ@mail.gmail.com>
	<xmqqqzr54mam.fsf@gitster.g>
	<CADYq+fZFuvCRbFf=-XUR8TJsjW_YtjNdiXMzPv0mjMPbWcLO1g@mail.gmail.com>
Date: Mon, 02 Feb 2026 09:26:28 -0800
Message-ID: <xmqqzf5rys3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Abraham <abrahamadekunle50@gmail.com> writes:

>> I am not sure if I would like the end result or rather prefer your
>> "all-or-none", so please do not take this as "here is a better way
>> to implement it" suggestion.
>>
>> But you should be able to keep the current semantics, if you wanted
>> to, even if you apply the chosen hunks when you switch files, like
>> the original code has been doing forever since it was written.  You
>> know which hunks you applied, so after applying before moving on to
>> the next file, you can drop these hunks from the list of hunks to be
>> decided for application.  When the user comes back to the current
>> file to decide on other hunks, you know that the already used hunks
>> would get in the way, so why keep them?
>
> Yes thank you so much for suggesting this approach.

Not so fast.  I explicitly said I am *NOT* suggesting anything.

And thinking about it more, I do not think it makes any sense to do
anything other than "all-or-none" when the command is working in
your new "you can move to different files before you decide on all
hunks in the current file" mode (which I think we agreed to make it
an optional mode).  Why?  After deciding yes, no, no among 5 hunks
in the first file (leaving the hunks #4 and #5 undecided), you jump
to the second file, do something there, and imagine that you come
back.  If we drop the alrady applied hunks like the suggestion,
which I did not make ;-), we'd then give you four hunks (as hunk #1
has been already applied), and even though you have already decided
not to use hunks #2 and #3, you *can* revisit them with "J" or "K",
change your mind and use them if you wanted to.  But it is too late
for the hunk #1.  It looks utterly inconsistent if you cannot change
your mind on hunk #1 but can on hunks #2 and #3 and it reduces the
usefulness of "you do not have to decide right now and visit other
files before you do so" mode.

Thanks.
