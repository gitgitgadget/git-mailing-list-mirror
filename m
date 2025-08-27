Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181CC27FD59
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313632; cv=none; b=iX4UGHCxpD0EJ7XMCQU5ZXelluK3VHZsMuepiwIjMLNbGZ0OOMGuv3eG4hmJ0Gw9euoh+0XvjDSDK3BgCmkct3WucCxvZA26v5CiqExLCoHMb/C51rTyW6n5pYBqh8arpXn6JVQEiSosd6E+CBDYKnpOPe3e4qbmLOGRSwCkms4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313632; c=relaxed/simple;
	bh=CWnAu3nbP3Vx02l1gd+IAlcgnG7MP8htNiPx/fUETfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nL0NKmZXwjyoTZVFRrLXaYvyjKOBIa2pK3oA8p4/NHWijUe0p8cDMdFk/LhfmIORhggyPKaEP9e5fn1MiohWMpc2jfZRgETYxCGiKfc7EIMuqxv//UnU4iY6TrsSUT7u6YTOYEEAYJwF7jfOIUNxItV9n01sQunm5p3e41T4BVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=21TpIdp+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z3gxN5vz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="21TpIdp+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z3gxN5vz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 36163EC0106;
	Wed, 27 Aug 2025 12:53:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 27 Aug 2025 12:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756313630; x=1756400030; bh=CWnAu3nbP3
	Vx02l1gd+IAlcgnG7MP8htNiPx/fUETfg=; b=21TpIdp+22pHa5OyuBb6LmqKdk
	Btwhlb0z/eOUmtInhiKz5hYk3utCuzCUXOXRtE3y4aj71KBVk1hsXarnyCXB1IFt
	Ey8bwCzp6sjzoLAbfa6P3sflsfImCt3sNuGDmT8u1om0TziGaq7ykxz5n25Tpgu2
	Gd246CHcOncSH/9OVQVXLwo9kwureO3dkM+pMqp/CqFMnqkoc0MFaNtTuxvNV6MI
	EExqMepXqHIhtafEIdXYCm9dJy7ZTtPW2oserreOjmvSnetHx5YLc8Nkl1x7GzFk
	PfUuu2wEjWq7I0ni82NhUYkCMsA1hbeTFVoo1e/F6yaybhjOgheoT/oWCCAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756313630; x=1756400030; bh=CWnAu3nbP3Vx02l1gd+IAlcgnG7MP8htNiP
	x/fUETfg=; b=Z3gxN5vzzJNPm158BWidkabXNeNLZoLOTVoWcSVs2JTGLAqv5nr
	8vaRKKTbQSMpJKzznpeNCxs7oKmy2bbm3lmDE5sZiCESFZX/+lh9LhULHQJzjJU/
	igm6c3IiWTPajhyXaC/x/s2ycDKEl6LvtNKdoqTvZ1M3CiW1APsLdkKBsLHgY/nX
	wc6WqEKWP+G5xYE8jKIQ3UkUuxotGPULJ7tBRxHK56AM+HZsROt2d6d5ZIM8kIuu
	lnoxHnl9zyPPtOjn0Feyf6AZityPafNiBJqlOuJBl5EqHeBY0zdnKVY02V7zMBMv
	MUypSg7fL7t4925PZObFRazdeN51wCr67yg==
X-ME-Sender: <xms:HjivaKp8xLsXYpqN2PlJQN0kgZDnzjuEPfdNM1rMUmMmuPm2L45BlA>
    <xme:HjivaDPeS0HdB2679Uu_3sRf7zQAfyai1NTFLCoC6oI62hSGNc8xSPam3dbo4UM4x
    5QaMsxhllCt3MjEhQ>
X-ME-Received: <xmr:HjivaLx7E-E7jZViCp9USXzpjIL7CRg8CIEZIWjtWRgCP8w_NydtXD2l7X-DhmWcKGouRgQQWdw0kLgAKktb8Ju4AFfAffvA9tyrPaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprhhpsegrsghtihhonhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HjivaMvMBx3UI-OUyMDQgVBlTSvSxOSsDho1BirrhsrM787Ppqq0ZQ>
    <xmx:HjivaE7iCoJRbhdq_r06-1WoXnbRocD70tQmBS90qLePlwhCydXbGg>
    <xmx:HjivaLSCx_Glr2IytdPpflbXr0SO3Ue8WBnn5WdF9XZp0LROw8gixg>
    <xmx:HjivaDpFfeKVyfby5mL-bgQn24xyiDtmajM56Qx-jSfspIKR7AuA6w>
    <xmx:HjivaFOPBiesGQSD071Nn14VcrLzoeuS3Z1kA-1LmEP4yBgaXVynTMmI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:53:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Rune Philosof" <rp@abtion.com>,  git@vger.kernel.org
Subject: Re: Feature Request: Add comments to commits
In-Reply-To: <a0c393df-a23c-49e0-8985-4748e1769a62@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 27 Aug 2025 12:32:56 +0200")
References: <CAL8J5gbKu7qB8Byg82CGqtrYK0gm4gf5V=qrc7npzAoF+kAXJA@mail.gmail.com>
	<a0c393df-a23c-49e0-8985-4748e1769a62@app.fastmail.com>
Date: Wed, 27 Aug 2025 09:53:48 -0700
Message-ID: <xmqqwm6o1zab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Aug 27, 2025, at 12:29, Rune Philosof wrote:
>> Git commit messages quality is very important when you investigate your history.
>> Often it would be useful to be able to attach comments to commits
>> messages for instance to add forgotten information.
>> Those comments should be shown when `git show`ing a commit.
>> Could be implemented as commits that use a new field to link to the
>> commit they should be shown with, along with some index to make it
>> performant.
>
> git-notes(1)

... together with "git log --notes[=<ref>]".
