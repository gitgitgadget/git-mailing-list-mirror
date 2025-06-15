Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885A1DFFC
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749948211; cv=none; b=f6IMEaqhazHnLpzcm3jEGpv9XzGHAWoF/OuJqjkplsu9yA7YAfIRRAKamkmajvrjX5l+RPYK3vEmRXV8XmoB+vZ/ijbOZjFm8f9vk3vWp9Rz50+NCjLu2+L4740Qq6DPBQCp/AhY4yOcctwZYyHHeXb9Zo9MpdOzMjAwEA/QdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749948211; c=relaxed/simple;
	bh=hFWhxJ+0ky281eVzWo1eE/pFVyBlyBnDxKhfhiDdwr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OZNHqaBpBVya26yVpY8UBMGuF1H3X8khRF0W+5N4AwyuKs6HGNEIifk2Zq4rrcjdlL9hryzNJrNVDQNWXmRWU260Hav06RTtUK1dp2u9nHYNi7CENI7z7e+5oHfA1QkmBVgrjmicpcCfItfaQxUXNkTjGgteG75NCZRkUYYHleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YUOoNEHY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5TJlef5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YUOoNEHY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5TJlef5"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D4D525400F0;
	Sat, 14 Jun 2025 20:43:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sat, 14 Jun 2025 20:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749948208; x=1750034608; bh=jbdsJ+Gb9+
	psSJyyP/lAGQwBx4OH6dS3a9R3qiRqSNM=; b=YUOoNEHYYXue+R+Ww6p/xgWrpm
	niOOXaGrik1/FjNBUvJjxBzfj9e4XOjJFSik0HFHkXJI2lmristVkel6SENTw2sS
	HevMSTelaMoDCca1pcTvYIvk8xWu3s/ED8L5bTW/MYkfsN2PWYVK1easAcTv0NiL
	+zUANQFyGW1Ta6ygbLLQdiTqIi4LnEmBT3pxJAgRTkseaSaWFZ8XoXWKhcb/j8gl
	uv6SGzBbanWRFzxngq3420sipB2PCwoI0hpp/r6NtNyIsG9+U1s4r6rYWJ+pN8rb
	laVnplThWssGaFNIuZD7jUs43fJ0f8HXyugmadXHC/GKllsk/ejT1XRbMRGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749948208; x=1750034608; bh=jbdsJ+Gb9+psSJyyP/lAGQwBx4OH6dS3a9R
	3qiRqSNM=; b=m5TJlef5QJEC/wO8ioAnB62k4xT73mbuyMV55PZdGgrZ8fVSKiZ
	kMc2Tb9SipIgZ25b6A9tFNv3ULg8vnDa5X0EUPJ2MJ/ugb+wmJE5UlqAc/CIm/bS
	DzmsSpQHhudQob2u1DKn+CJKilSDpSVEtJB3z7chLpSKSZpJbeFjhNWCg8K6ZFEW
	UTEZ27zHZ/5KBcyEH4i75U8XOzBGnaym0OMu8VlaT2/sGcG7nB+zWUgVuRgX/rrj
	S+xDnfnxHw1OmeYFieLtnTdjgZFqcyQzLg2ToJoWa61j0hwisA4hy0sQqz3zAf7f
	iD0yTtk4qQYEaBvPg6u0NUZY3qc0pAMBUNA==
X-ME-Sender: <xms:LxdOaIMxcwGIHEvg5vwcrheHZ6ZaMFHTRcJsSe7IkVN38RwanGBvuQ>
    <xme:LxdOaO_iQaNRv-mwcMpsewGKVhlZn6BHlwaL33aYCAiXjEMCU4FdaogpC3BTAXpRl
    O2J_gG2uSAtNetJGg>
X-ME-Received: <xmr:LxdOaPSxpCJbuF5Zf_3JXPaYdVQOWYH2F67BLNtfLzQw7lHW3G7J2WMNDtIAQLQfpVOiZvMylaSOjwIHbzKrS1vzGmq6xTNC22gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MBdOaAtp1KHYIEkp0DpmJhbZuc1a5zKlVu7Fjea69VuthGa4aL68IA>
    <xmx:MBdOaAdgOFp88n6brGnkcx7MXLtcvjI8WEY7WvrybEZNY_nY2Y_T_g>
    <xmx:MBdOaE3JoSkyjqOFrqm-lPCaACyZyLeNBEeXCLs9XUOM5hH1o4d2Xg>
    <xmx:MBdOaE91V-DZ0i0m130Tg2twW_FppXOMCabVQ8W254rcAWkJv9oo1Q>
    <xmx:MBdOaGqv3dofxqaWUBz72x6S829FHH8PcjnMAqyikGb6j-SsQLmEhj0N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 20:43:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Question: regarding understanding code base
In-Reply-To: <CA+rGoLehMUWPMBrZ1hOk-GBQBCvSY0_ivFCn1w1C-V_bGTDgZg@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Sun, 15 Jun 2025 05:54:46 +0530")
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
	<xmqq8qlu72hz.fsf@gitster.g>
	<CA+rGoLehMUWPMBrZ1hOk-GBQBCvSY0_ivFCn1w1C-V_bGTDgZg@mail.gmail.com>
Date: Sat, 14 Jun 2025 17:43:26 -0700
Message-ID: <xmqqldpt6dht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> What I meant was:
> You previously suggested that one good way to understand Git is to
> start from the initial commit of the Git repo and move forward
> chronologically through the commits.

Not at all.  I only suggested to study the initial one.  It is more
like biology students learning the common principles that apply to
all kinds of life by studying a lot simpler organism as a model,
instead of studying a lot higher order ones like mammals.

Moving forward is all your invention or hallucination ;-)

> - Start from the initial commit of a repository
>
> - Walk forward through history (one commit at a time) probably which
> changes my file system (I currently use a terminal based command)
>
> I use
> git rev-list --reverse HEAD | while read commit; do
>   echo "=== Commit: $commit ==="
>   git show --color --stat --patch --pretty=fuller "$commit"
>   read -p "Press enter to continue to the next commit..."
> done
>
> I wanted to know if there are any better ways

Like "git log --reverse -p"?
