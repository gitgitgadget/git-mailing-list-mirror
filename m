Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41226839F4
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372734; cv=none; b=hZLDcKSnq3TKDejN7YZ+ZBwF5zUViVW6F17GuMG5rgeukI8BSoxtLnFfrzWItoSko8NHrH6ymbJ3H9m8OH2GtVfWbIN2j+fgSJE48IlAkv7HJdhKWx47nhmEnZst7wT/SE+oKC295X3gpO43VvD0OnuongUuKkgijsybC4ZQpmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372734; c=relaxed/simple;
	bh=buX9ZaUDnN03afYtg9B60auuW1+ghF24CLT1JeVNIN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aKPCncrKJZqLl5u9EtS+DO9/7GDpHd92iSlHqaNiZl4KND51Wj7zFCzXSsCe5Vl830isTJpwfMTM8uzgrZFwzzaRFAWuLvElodUgPWtjMx9DQdQYdASqNtxSuOIWfY7oSlGfrdd159VB32eKUqT2spNjPAKnIl1PwG4qyFGi41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qA4oD7tR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R70oWaJZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qA4oD7tR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R70oWaJZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F12A11400FF;
	Mon, 16 Dec 2024 13:12:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 16 Dec 2024 13:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734372731;
	 x=1734459131; bh=K2Yhr138i/TS4IXui3/OignvpDVtgxO4FzRMx9anJJ8=; b=
	qA4oD7tR/izGetep3OmU+HG/AEmn1Nw+Mj/l7l2tTmOhlyV3xQAnknLc0BzrkoBd
	ayKRBPzqVz8WAO5sKrnAPsp4Lz8LG0Xq0w7UK9Tw+91p0foRCQEm9mbN39GzT/G/
	fygA4hYf0igIlxYEjM5zvuo0KJfELBB5U8yKWq4A3bT6mnLSr/IgQFNcB7Sp3FQn
	LFuUJXK+ZBNuGWU4XfMNoHzdZl0XLJ18BAM5ri0gmgTxYq6Rb62FL/kv8hoxLdB5
	NwHALUFlWUI/wk/SyD0N5AbMouctQpYKz19iHEIUUx6FvMnXzRgOFwbjrZLR53qz
	HnUzO1OtG/y8N9Zd52beaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734372731; x=
	1734459131; bh=K2Yhr138i/TS4IXui3/OignvpDVtgxO4FzRMx9anJJ8=; b=R
	70oWaJZk7R7cRhI0n5jOFTY+jvGvviF3ueu65r2RmkW6JrTmGZkpsu/3KpH9Xhf5
	jf4lmFqlYe5R4uazN/pygRLvgUBrJuZGezkoYtY8CEhO1WzGj3+zzVJHK62UaFCR
	iXGFrIAn2sBCe00evOzRXSdPizQeSoRnPqFcryjkepSpFR8fP6G45X7NvqW1vwFc
	l8xTKwlr+9xDrEjkmGJGZqEszQ0AfwF22QD2Z5gR3d2IjjqKBX2JV7A2Urt9gE5O
	md/dk0p92SMrlwqM3m22u59C46WFpglQ5Z8KnXq3pqZAl4m1uF6r/7MCYtYsyD7X
	dGiU3nRUins4x7g/YVEvg==
X-ME-Sender: <xms:e21gZ06apFBFwXC2OAllRGEg1iPmnp1KkMpU5gH9jocUWYYWDlT9uw>
    <xme:e21gZ17jlWTztAu07cSTcZiogCOaGOFPeLgycvEuJzOxMDMcl3BT2A6E-CANKNDuD
    grAxFXY01fWjFZl7A>
X-ME-Received: <xmr:e21gZzebIJRhbRtv0jC7TXb2uOL4kKqpKSK_Z8l7Dwuj0f7dHyksK4_lVWR3-1GSS_j4OQG6j4vtrF9g6OVunoXvt5rnkqoJ0wTQRqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihuhhrihdrkhgrnh
    hivhgvthhskhihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:e21gZ5Ls7Gotu9MrHGzRB47Izs9lI1hFNKxEqwcOvutCK9rfpEBgew>
    <xmx:e21gZ4KqR1Ki68Hh9-9fNc7iT1Nc_S5U2p9QVR31SILtBmrMl7k-HA>
    <xmx:e21gZ6wBc9jqqMr2P591dEkHU_PUiAv10IMFCdXnh-pibdaDMLszeQ>
    <xmx:e21gZ8LPpaHRosAVRc1VefgP3i7-tTLbPJ8LTjaZPmd5QMYwa0ut3A>
    <xmx:e21gZ81wYUwwqJiSL12lv9OyOBAmCaJQb2oNfeELyUYvepxlnI7J7vIo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 13:12:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: remote.<name>.push without dst doesn't behave as documented
In-Reply-To: <CAMhVC3b+1TWLkKGYVb6VyBRyQjsDpbKRQQNT8SUXSmrWHfPnEQ@mail.gmail.com>
	(Yuri Kanivetsky's message of "Mon, 16 Dec 2024 18:47:28 +0200")
References: <CAMhVC3b+1TWLkKGYVb6VyBRyQjsDpbKRQQNT8SUXSmrWHfPnEQ@mail.gmail.com>
Date: Mon, 16 Dec 2024 10:12:09 -0800
Message-ID: <xmqqr0674hvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Yuri Kanivetsky <yuri.kanivetsky@gmail.com> writes:

>> If git push [<repository>] without any <refspec> argument is set
>> to update some ref at the destination with <src> with
>> remote.<repository>.push configuration variable, :<dst> part can
>> be omitted—such a push will update a ref that <src> normally
>> updates without any <refspec> on the command line. Otherwise,
>> missing :<dst> means to update the same ref as the <src>.

This excerpt is for <refspec>... arguments that are given on the
command line, e.g., the command line would look like

    $ git push origin smart

However, if we look at the command sequnce you gave,

> ...
> The second test fails:
>
> @test "normally a non-matching ref updates" {
> ...
>     git push
> ...
> }
>
> @test "with remote.<name>.push without dst happens what happens normally" {
> ...
>     git push
> ...
> }

neither of the above "git push" invocations have <refspec>... on the
command line.  So the rules you quoted would not apply to the above
two "git push" invocations, wouldn't it?

In

    $ git push origin smart

a <refspec> "smart" is given, but "smart" lacks ":<dst>" part and
only has <src> that is "smart", typically local branch "smart", iow,
"refs/heads/smart".

The paragraph you quoted describes what happens with that command is
designed to be similar to what "git push origin" without any
<refspec> arguments does wrt the given <src> ref.

For example, if

    $ git push origin

is set to update some ref on the other side with "smart", "git push
origin smart" would update the same ref on the other side.  e.g., if
you have

    [remote "origin"]
	push = refs/heads/*:refs/remotes/satellite/*

which would normally cause "git push origin" to use refs/heads/smart
to update refs/remotes/satellite/smart, then

    $ git push origin smart

would do the same thing, i.e. send "refs/heads/smart" to
"refs/remotes/satellite/smart" on the other side.  If your "git push
origin" is configured to do the matching push, "git push origin
master" would update their "refs/heads/master" with ours, because
that is what "git push origin" would do to our "master".  That is
what the paragraph you quoted describes, I think.

Now, the command may behave differently from how we described in the
documentation when you did give <refspec> from the command line, and
in that case you may have found a bug.  But I do not think the @test 
things you had in your report triggers the paragraph you quoted from
the documentation, so would not demonstrate a bug in there.

Thanks.
