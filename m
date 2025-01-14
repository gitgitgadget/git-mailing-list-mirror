Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8231D5CD1
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875458; cv=none; b=CjYNHWOm6bmFotkcb05vBoz6pPd69TiQsRtKYTiVDqZGnLKILzds+QoaU0a/Kgae9aEUo0MVk0yGAkx8AaAmdXcbwS98oMsL2YFgAhQLWZZDXTDA9GQZvJ4fF2c/L2Zd/qK5fmBe2HS07NcC2jSid4fMs2RxG8gI3cP4v83pAeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875458; c=relaxed/simple;
	bh=L103rhS32nwN7keWbyauV2y6tDZAY8NWbBMd43F0D8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J3lxw12N9oIJSotUSp52oCoHkrQehqatC+2Xu6ENE/uDpM98y7AyzccVqdHk0F8RfG8WKNZdfM7jNN4oWnA8YaUTbwPy8MF5U849CSr+8lWfasOkYLYpwEZIB8ZwU+5wSpHzWLq6Q41ypVnUk+X2Na5k0CP9bvRuEiFze1NEQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=2fGag0vi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZ8gRuwq; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="2fGag0vi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZ8gRuwq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52A712540127;
	Tue, 14 Jan 2025 12:24:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 12:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736875455;
	 x=1736961855; bh=aPc8lR8AN7CTKyHei/HUjbTKhYO3EY2dtvJgQTMHmXQ=; b=
	2fGag0vi6n044oLtsIbuXlpnPXp7Y+YXCWhI50YgBJb81LfkNsaJesjs4JQYblvP
	JCk6IPqPj+TIU7oEBf5zJcIlIFBfiMuDlLeccs6P/qvuJ8KJoyVjWhfcGnzeyCYD
	aKDcC7FQpLXH2cooxuUkKd9HVj+LrKrs8H/X0zPouii40HeX5yqobScgG5OFTewy
	0T3TpUT6RP+pl3Bh29lFaY4Fdg+YNDF3S7nhF3vaEy8doqg9LTjQluE5RX+CEc/V
	M3kfvrmq9SBWxj1oAGYHAIxeWX0ORuiShds6ts4jmOgrQSLeRCRu4tuceAecOPdR
	ZiuXdCmg4xVcMkHuwuYhfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736875455; x=
	1736961855; bh=aPc8lR8AN7CTKyHei/HUjbTKhYO3EY2dtvJgQTMHmXQ=; b=Y
	Z8gRuwq1/cSQ//2H/ri2y8CVTjsGlDyAJrFGRWlv/0W/cDtzPjm468qQRo7UPjTx
	FOP9DylbYyxdIjbAFtU073j2uxQS5dm/tFvSAdzRbsXx+3JPTyuc08Nb2oD63g5Y
	n839Cbj/XImwlxo6ujs+/1xj18LNtoEp9GO0IFhNCDJOV0zsMb4ohyffFDmzgT18
	QnV6peHIono/SxsmqN4jmgU7DhoSWtGoe414Rk+clY8uQSi0+A/eRhltBYqFoK5L
	Vghlq5HJBVBdC0jNY3QQjfTI3a6bGlPPyQAU3jOSVkRHwTIawFE0OjGJDu1SlXbn
	VLCQJqejGpBbkG7HATT9Q==
X-ME-Sender: <xms:v52GZ4lssID5jNjIVBijC4iWXlARV677oJKeTUvE4Q5POie6nBd2fw>
    <xme:v52GZ31o43DxbIZnVM8P3_qRZyZ8hLUHeVKFLSVqMx6hGqmJJwZ2meYUzqboGbfbq
    LFm7u7aKE9R8pX0hw>
X-ME-Received: <xmr:v52GZ2ojUBGkNfbA6UVNENGLYpxAFi0_-pQV6ScpEd7XoY4SBH-qSXQvT_97fEH_ElbJz0IimjGmwXpByrkaYlmQQdHqHVnSdUaZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffiedtieeiieevieevteevffefgfdvudek
    jeefhefhtdevgfegleekvddvhefgudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hgihhthhhusgdrtghomhdpghgvrhhrihhttghouggvrhgvvhhivgifrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhhihthhh
    mhdrnhgrrhhulhgrvdeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:v52GZ0m8izUdg3C0-lN3BB-ELHuB_2ARNchMRO73J0cAZfIlMH0xmA>
    <xmx:v52GZ22FOHVoPvw8r7nh1Eazh_6zyoUreoJx1lqeVa1hg-e_v6VnnA>
    <xmx:v52GZ7tZU7hD9qfJ7SkpM2T_-6B16cG-18DGBSPGrmSyVfjx_nGElg>
    <xmx:v52GZyXIHLN8qr38QusIZkXi1SavqV91_mcGc4QeNGvv2hk0S6VPew>
    <xmx:v52GZ5RWTzRfZVqRvok-D8jQNBWmtDGgjccAqXHpSxaB-2r5lWxHFa2z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 12:24:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Rhythm Narula via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Rhythm Narula <rhythm.narula26@gmail.com>
Subject: Re: [PATCH v2] docs: mention source of tasks in MyFirstContribution
In-Reply-To: <pull.1867.v2.git.git.1736844538005.gitgitgadget@gmail.com>
	(Rhythm Narula via GitGitGadget's message of "Tue, 14 Jan 2025
	08:48:57 +0000")
References: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>
	<pull.1867.v2.git.git.1736844538005.gitgitgadget@gmail.com>
Date: Tue, 14 Jan 2025 09:24:13 -0800
Message-ID: <xmqq1px55mwy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Rhythm Narula via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Rhythm-26 <rhythm.narula26@gmail.com>
>
> MyFirstContribution guide lacks clear guidance on where to access
> list of bugs or feature requests. Improve visibility for contributors
> on where to find open issues and features that need attention.
>
> CC: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Rhythm-26 <rhythm.narula26@gmail.com>
> ---
>     docs: updates MyFirstContribution guide to refer current bugs and
>     feature requests
>     
>     cc: Carlo Marcelo Arenas Belón carenas@gmail.com cc: Emily Shaffer
>     nasamuffin@google.com

Let me remind you of Documentation/SubmittingPatches[[real-name]],
in case your name is not "26".  We want to see "From:" (you used
Gitgitgadget, and it placed an in-body "From:" at the beginning of
the message, which is expected---there is a name there and we want
it to match the name used on the "Signed-off-by:" line below) and
"Signed-off-by:" use the same name that we can say, when the court
asks if we stole a part of this software from somebody else, "no,
we didn't steal it. this person (with his or her real name) sent a
contribution to us and here is our record".

>      -    docs: update contributing guide to refer current bugs and feature requests
>      +    docs: mention source of tasks in MyFirstContribution

Nice.

>       
>      -    The contributing guide is updated to include references to the current
>      -    open bugs and feature requests. This update aims to improve visibility
>      -    for contributors on where to find open issues and features that need
>      -    attention.
>      +    MyFirstContribution guide lacks clear guidance on where to access
>      +    list of bugs or feature requests. Improve visibility for contributors
>      +    on where to find open issues and features that need attention.

"MyFirstContribution guide" -> "MyFirstContribution" would be
sufficient; it also allows us to avoid "guide ... guidance"
duplication.

If I were writing it, I would also do "access list of" -> "find
unresolved".  We do not have "the official and curated list of bugs
and feature requests", so such a thing by definition cannot be
accessed.

> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index e41654c00a6..630a68b650c 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -109,6 +109,16 @@ of invocation during users' typical daily workflow.
>  (We've seen some other effort in this space with the implementation of popular
>  commands such as `sl`.)
>  
> +:mailinglist: git+subscribe@vger.kernel.org

I recall seeing that Emily asked about this line and do not remember
ever seeing an answer to it.

https://lore.kernel.org/git/CAJoAoZmzLOMNCNP-X-=QTSb=ed0GOkhx7w0PhVc2FmcbVL6jWQ@mail.gmail.com/


The paragraph below is overly wide.  Please make sure that the
resulting document _before_ passing AsciiDoc can comfortably be read
on 80-column terminals.  We usually try to limit the line width to a
tad shorter than that limit, because we review via e-mail ...

> +For future reference, here's where you can find bugs and feature requests existing in the system:

... and quoted lines will be indented to lose a handful of columns
on the left edge.  From here on, I'll liberally fold your original
before commenting.


> For future reference, here's where you can find bugs and feature
> requests existing in the system:

It is a bit funny to phrase requests to "exist in the system".  It
is still outside of the system and that is why they are requests.

Since this is the "my first *contribution*" document, phrasing it
more like "unresolved bugs and feature requests you can work on"
would fit the purpose of the doucment better, perhaps?

    If you are interested, here are a few ways to find unresolved
    bugs and feature requests you can work on:

or something like that.

> - Git uses a mailing list for discussion on bugs, features and
>   patches. Search for relevant topics or tagged issues like
>   #leftoverbits in the archives: https://lore.kernel.org/git/.

I am of two minds about #leftoverbits.  It certainly is an easy way
to leave notes for later investigation for writers, and it is an
easy way to find them later when somebody is bored enough to find
things to work on.  On the mailing list, however, anybody can say
anything [*], so an ancient uttering made by somebody with the
"#leftoverbits" mark may just be a feature request that turned out
not make sense at all.

>   If
>   you encounter a bug, have a feature request, or wish to discuss or
>   share suggestions, please use the mailing list. You can find more
>   details in the <<getting-help>> section.

This is great.  We should also suggest "search the list archive for
similar issues", but that needs to be phrased with finesse, because
it probably is not useful use of potential contributor's time [*]
and may raise the bar to report potential issues if we require it.

Making it entirely optional, but still encouraging, to dig in the
archive, here is what I came up with, but it is overly long.  If
somebody agrees with the direction, we need to spend time to make it
more concise:

    You may find a bug or have a feature request.  Since Git has a
    huge user base, it is not all that unlikely that somebody else
    has already encountered the same bug.  Looking for similar
    reports on the mailing list may even find that the bug has
    already been fixed.

    But looking for similar bugs and feature requests on the mailing
    list take certain spelunking skills; do not be afraid of sending
    a bug report that turns out to be a duplicate.  If somebody
    recently worked on the same bug or a similar new feature, they
    may respond a lot faster than you can dig recent exchanges out
    of the list archive (in other words, inadvertent duplicate
    reports are encouraged).

> - Unofficial bug trackers 
>   - https://github.com/gitgitgadget/git/issues [NOTE: This is for
>     feature requests only]
>   - https://git.issues.gerritcodereview.com/

OK.

Thanks.


[Footnotes]

* Of course, community guidelines apply and rude folks may be kicked
  out, but it should be clear that I am not talking about that kind
  of "can say anything" in the context of this message ;-).

* But if we say that, a new question "is it worth the time for
  established community members to do the list search for them,
  then?" arises (and the answer is usually "No").  But if somebody
  already knows that a similar issue was reported, or better yet,
  that the issue has already been resolved, then exposing the
  duplicate issue this new person found to the list and let the
  duplicate report noticed by that somebody would be an overall win.
