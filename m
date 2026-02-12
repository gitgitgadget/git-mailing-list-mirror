Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687D12CDBE
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931915; cv=none; b=hLUsjikNW4Yum8PpNx8KuM+YTtz73xRsL5n4FquLocJEPWmPJDbJuHyh5hyw1Ex45RnyNb+4MxsErDxEZR6DM8Nfk5Y1CaMIQFIuewgWCMobrLZJTZ3NiNf6NUYVlQkcZjr2R/3tlAX9TRAXSCXVArzwB4XmWSrwNZYw877VQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931915; c=relaxed/simple;
	bh=mlFaov5wXvAiBFMEprbteXCVIOV56pSCFKvkmCrimwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ftZ9uWcmToFMQOlUcHHfTGAowo7lKBdDImRFO9siWlYFFAfioSQr39XnLkNgrgJFFahF38GVNkStJX7tEKbaf8tiQReEjnBUGBOVncFplniCYSmbvAQG6m+KCcbE58Ckx83/USFAAxep/9YIA8OPlbMNv9nbAmp3hkBRwnu7Q+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rF44zILp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOe32fe7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rF44zILp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOe32fe7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E8C961D000F9;
	Thu, 12 Feb 2026 16:31:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 12 Feb 2026 16:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770931912; x=1771018312; bh=JK2s2lWi8f
	fosaMycCphcv6ZGAbP8XGP1R7o4lF5+gw=; b=rF44zILpgOpjhqJMwPwXeK8YP5
	YcFIW3pAyyaLCrsP+wTECcBZ5NpILIpFhuLkiov4fzxa3Sc2V+d0qwZuBpCIutb7
	zwkJbRk2sESgX/bP1rQ/Rb5dm/kYVyDfmt/a25OudYSJfg19MiZOYtEr+XP/j8Io
	cbwNnOEkKWZLf8E38r3HawllgS2a9SjwzjIgA7g6P89BFDICAFuU6NkDmHoTYrIM
	q/yFaDLVbcAgioNa6CbkkSsKKw+gpV4EpHAYFMos2hHXEkdkt8AknTEpefGNqbev
	/SGkC6eGj5DH9Nworak3eKMPEBtftLFWTBIDQoaniIfWOzy5kpjR1O4hUuQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770931912; x=1771018312; bh=JK2s2lWi8ffosaMycCphcv6ZGAbP8XGP1R7
	o4lF5+gw=; b=HOe32fe7L+wVfSjiMBWxhY/S3YBrdMwoW+T3+WvwZK1f7xvcX01
	ankYWSzI1Y4s38QwBpNWgJuDmN6mdYhleqHSr+8gH0oPqkdCs4S+HWsLgI9ZucIk
	TZCyuhaWcDX4t4jcZtzLhkK37K98J7l/BqL+J1djtR+gDaYzAaVeCMtmoQ0TUHeg
	gCfKVlgfuBzk3Q7B6xyKE9GclayJfZbe9vUDVPjcaH1e7exjJF+HhujbeUdHLlYw
	RLA2eiTbaUO4xyAQKFOjVsrTMEVaK60huUrc1zEkzxvO9TYWs1dVdKu6b/0CuYY7
	AfizbYZadrrhZOyhtW2aVa0HQwlmUo+DWiQ==
X-ME-Sender: <xms:yEaOaaI-FxfyzVa-h2J6TUi_vRJ1p2wPVgmJkrD3S64mLB3DQvns9g>
    <xme:yEaOaesdT2jSfsJsiKhsTcJFf0gR54A1ldromqMyyg9JilMwVkY0RiBTxCeII5EPl
    RfSR1Q9kZtmVzExGodCjMbnpInXqWvOlYG2hWxG8swfIGsUFy5EKA>
X-ME-Received: <xmr:yEaOafIX21BnaG2LB7MQ-zC5lj0403DXam_m_GdIZSHPJfjepRauXGQmO44SDIJzASQzTs4hd8Fsd6CJZRHHUuXOCBfNKEABWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeigeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yEaOaWOfWWQfMv8IeLGa8ZynfCgL8vjo_g8b0AWC7AaVaJf569U7zQ>
    <xmx:yEaOaSWnvWQgLQ26io_Kp9hkkKkF4EL-Qo7QvawKHzu6niedkapzTQ>
    <xmx:yEaOaUngCU6hG14dV0oouDeeqoxQHE2PVhd3ZKKZwlQxiOl8KMC4yA>
    <xmx:yEaOaRN-wr4FgAMalmGMhPhiqsKa26Y-4gWSZKsL0ZOGU24cz7piKQ>
    <xmx:yEaOadzt-uB1mxKd2PUF4w436HoIeZyrulr5FFwJO1vc1gCJAxXngIxl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 16:31:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/3] add-patch: Allow interfile navigation when
 selecting hunks
In-Reply-To: <CADYq+fab0FKncE8VFJcaHA5VmrTJbrSo79jxA6x+Y5dkZP+2RQ@mail.gmail.com>
	(Samuel Abraham's message of "Thu, 12 Feb 2026 22:13:38 +0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
	<24692afa3f0a67d3f3eba776cc745287c5d71e94.1770390576.git.abrahamadekunle50@gmail.com>
	<xmqqikc9ekzz.fsf@gitster.g>
	<CADYq+fa81Uki0ZVta80VO=-UG-f+Z8GAyzom-FLNXULartwwXA@mail.gmail.com>
	<xmqqtsvlq3gr.fsf@gitster.g>
	<CADYq+fab0FKncE8VFJcaHA5VmrTJbrSo79jxA6x+Y5dkZP+2RQ@mail.gmail.com>
Date: Thu, 12 Feb 2026 13:31:50 -0800
Message-ID: <xmqqh5rlmywp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Abraham <abrahamadekunle50@gmail.com> writes:

>> There was a separate topic that added "(was: [yn])" to the prompt
>> when the prompt asks about a hunk that already has been decided on.
>> As we only need a single bit "all hunks decided", can we do
>> something similar, I wonder?  At the beginning of the main prompt,
>> we show which of the N available hunks we are currently at, e.g.,
>>
>>  (1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
>>
>> Perhaps we can add a third number to indicate how many of the
>> available hunks the user has already decided, or something, that can
>> be used to avoid this wasted line?  Or is it a good thing that we
>> are loud in this case using a whole line to remind the user that it
>> may be time to move on?  I dunno.
>
> I thought of a suggestion where after deciding on all hunks in the
> file, the user
> will be able to see the "what now prompt", the options for the current hunk and
> also the previous decision on the hunk since at this point, all the
> hunks would have been decided on.
>
> I tried something like
>
> What now? (was: n) [y,n,q,a,d,s,e,>,<,p,P,?]?
>
> This does not show the number of the hunk we are currently at and the
> "Stage this hunk" since the decision had been made initially but the "whatnow"
> prompt still provides a chance to change the decision, while showing
> the previous
> decision on the hunk by asking "What now?" instead.
> The options have the default [y,n,q,a,d] and the remaining options are populated
> from the permit set for the hunk. SO the user can still carry out the
> normal actions on
> the hunk.

I like the compactness of that myself, but I have to say that the
end-users may feel lost and utterly confused with the distinction,
if they are left without being explained why we switch between
"Stage this" (which by the way changes phrasing depending on what
you are doing) and "What now".

Is it so important to indicate that everything in the hunk has been
decided?  They'd lose 'j' 'k' when there no longer remains undecided
ones, and every hunk they revisit with 'J' or 'K' would say (was: X),
which may be a clue enough that they are done with the file, and
when they really really wanted to make sure, perhaps they can type
'?' and that help can spend a line to say "Out of 8 hunks, you have
already decided to use 3 hunks, and skip 5 hunks" or something?

I dunno.
