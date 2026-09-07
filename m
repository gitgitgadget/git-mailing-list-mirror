Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE553B14C9
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788805158; cv=none; b=Sb0YHIzyhZZQLJfCyETPLxLWpD0rOnxun3QDotbYbc9RsHIvJHbDtjA+hklQjaFsEkofAk5K5kBgwtQ2RGXvntGi11Zh0C9b877/XlqG8CQBRxzIy4E8K4EvUgZXCgc02ZD2bZNZfMu4S5Bprf/dPXuD1MHpC6GidxiUWQ0q2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788805158; c=relaxed/simple;
	bh=4pohO+ofMYOeDimTQ3KebEhQUnuynlQ6babD9xFQL7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UGEvEWia6uQn46FUWi994ZCLEKNfmXCsQK14dXgFcaqKhwCFPA09BALiExHMnMp3GAdQmTDd6xi/jqQJ47JAbH7uOP41uCghH/vgy9yYxsAN4Ph/D3WbAJlU83DUvIX6l2NohqBFmmnVEdSC6vkLhcmVN2NAbf6Zbpvr34HU3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Bz0H3eHB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTAZj/fO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Bz0H3eHB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTAZj/fO"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F5301400191;
	Mon,  7 Sep 2026 14:19:13 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 07 Sep 2026 14:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788805152;
	 x=1788891552; bh=4pohO+ofMYOeDimTQ3KebEhQUnuynlQ6babD9xFQL7Y=; b=
	Bz0H3eHBbtB8UyS5ccNfaOtzxnGWu1O2Nst4Txvsxr9Gq8gjcRZqbXojzeriwmRX
	th0Ii0OdoZTduI+0PSNHvOmZzjuxNNbYRTXp8r1w0QH3qvgldFadBgDJkZwjYHpK
	ervnEdHy1hevlR3QYWAdr7b9cNjlyIiYxkPn1W6sUP7BvyCguoBXnzG5mcGp1n3W
	D56CXfrXCg7entcrSKG4WpnXXUPcGvGREBYopgRGXXSxjvyDVwwvFm38ZI0KbNTU
	ulNeWU0bNAzlk8eNajWOwHh3DKeNLnSTE4wRTNXC3aaK86AFhKWcOs6VWaeNi6YC
	/+/QdArytEIGmGAefA31CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788805152; x=
	1788891552; bh=4pohO+ofMYOeDimTQ3KebEhQUnuynlQ6babD9xFQL7Y=; b=a
	TAZj/fOWEXSWuvwDiYHty/Ow1a9byeG0pGesBVKVAQYfWY0g5VTJKWayOkZsbeXT
	p9R3vjQnbPNDSnhWnOkkxtBml3BZ1/ugszHNzr9TMMkQudQPgaFcEklQB2RAhDOu
	enXjOGr/ijEKXjB3WzXVKVHSmEYAXh1ns6m+ZFGBKZrggISV81qi5bSNLcdOlMRY
	tZghU2EXEiRgfamzNDmfqmJwuPQIjWOW2idX2EQzL5ZgYqbf4WAOnHlVnJ9If4jX
	NOd477wWrAXS1QejWEZks7/szCC+d9I3MiHf7ClUrAuK3Q4YnT7/Wp1601phH9cx
	2ha4USDKAaDpCU2X11VBw==
X-ME-Sender: <xms:GwCfatP5G0VqtkCObWKjmBkSOkQ8OultaEOCk9VShHgfj4P0PWKldQY>
    <xme:GwCfaqzEb7OVu6LD9iudqOoM8aMxcQvpc5ORP8L2sYyHfGJD_4kB-OJkw2gBhpKQK
    XpcO37qmzNe7qYcvJGa2IKLyPjf2ITHl7acI8mjYTMGZZPzqew7Xz0>
X-ME-Proxy-Cause: dmFkZTGEVQErjBbaeQMN6E+J9LDZp2g2uE/Noj1NLeGT7MW1UY03W1M5sDfbpv2HOzHF1W
    USZ+lNuzYlv3nmv4JxIm0fyXn22d2lMt86SQYoknyWLy/JITY/EF0yxkQeKboUBuCocSI/
    Vd1VKnjVPx5FD0vFEq9kFK08ftbGKsq5d686OHHraz/EJAKdgajM1HvrKH2sYiBLVBkNlC
    BqpOpgo8clQgq+q6h3WbVwA/VmwyD4beHEqBkMIh4AEX3FSsl17hmb63uHnWmbWqlB6w4y
    cOq8tAiWz/mN26KWjdACLVLlQbMz94t9+nebRonMs4BijSm8Sdk/JLcAkAzFkvfIn73EXL
    W5iXVS1UpL2J5vbssgBEZInGqe2aTsL0sstc020CkE1cArCSV5s7tigJe79ri7M6fMtHBz
    ns8Nit7E6s/QO2zqzZxwwrvqWyFtLzPgywRTrNNB1UY1yIeut9Onqv+59hDERZkhb+x1sR
    04X7Wog9JwDxSJWeySBW/3fd5RiUGYcQSzBI/3upzbI0VmNvnPw0R1+rHoRlw01h/CeB5x
    FKDWA73laZ9mlSxfrpPqHDwM0U+RhHVnEsPhBUgBZCiGHxwFYyGRkj3cITbIOmxnTtlUnt
    gbqwXcydDl7S1vDa2fafnIjrTQWVRkLp460eofCaATwVoqS6bLEARtMSrKig
X-ME-Proxy: <xmx:HQCfaioyhuNVgqKMbOXyTH_IOC7k64LqDwO5Gwy5sOLMwQdm0PVgWQ>
    <xmx:HQCfalnNeSkoMY4aJ-ETaP5kEmXB9Q68CBLzn8-6AkoAPqMmpdMJWQ>
    <xmx:HQCfareU5hSleOyXhVW6dZ9IM-YQ9x8T9JJUBxxudp3ficEeWlzr8A>
    <xmx:HQCfahpyH-xbTg7tFYUlND3agOb_S-pZU9PW5zs589F1oGSgzx1KWA>
    <xmx:IACfal0QfTiwZsSYJE8Rzflc7vpbHZ-33K9lKY-tY5WZY2nEP3s4rmxm>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D408922C007F; Mon,  7 Sep 2026 14:19:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGjFKXOpCo73
Date: Mon, 07 Sep 2026 20:18:47 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Domen_Ko=C5=BEar?= <domen@cachix.org>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Caleb White" <cdwhite3@pm.me>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>, "Patrick Steinhardt" <ps@pks.im>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Alexander G . Riccio" <test35965@gmail.com>
Message-Id: <de83b791-92ae-41a1-8ecf-5abce7893998@app.fastmail.com>
In-Reply-To: <b10f2706-67bb-4657-8d7c-819a29dff890@mtasv.net>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
 <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
 <DKGE5DORETW5.1S9NXEX8KMQHH@pm.me> <xmqqtsp9tyu0.fsf@gitster.g>
 <8bd3a684-51a0-4a2a-b70d-3981cfe10e9a@mtasv.net>
 <b10f2706-67bb-4657-8d7c-819a29dff890@mtasv.net>
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026, at 16:30, Domen Ko=C5=BEar wrote:
> A gentle ping on the single "post-worktree" hook proposal below.
>
> As coding agents increasingly create and discard worktrees, reliable
> lifecycle notifications matter more because tools managing environments
> and cleanup cannot control every caller invoking Git.
>
> Would this interface address your concerns? I'm happy to prepare v3 if
> we can agree on the direction.

The problem is multiple callers invoking Git with different
intentions. What if `git worktree add` learned an option `--id=3D<string=
>`
which is then stored in the worktree? This would communicate that
whoever calls git-worktree(1) commands with this ID is the one who owns
it.[1] git-worktree(1) commands which do not get an `--id` (and
specifically that ID) does nothing to owned worktrees.

[1]: You know, among friendly and cooperating processes.

Then you don=E2=80=99t need hooks for adding, removing, pruning
and whatever else.

I could imagine an agent tool that uses it=E2=80=99s own ID to manage a =
pool
of worktrees.

I could imagine more metadata, like recording a timestamp for worktree
expiry... but you don=E2=80=99t need anything more in git-worktree(1) it=
self if
you have this ID concept. Then you can let tools implement it
themselves. They won=E2=80=99t have their worktrees bothered/clobbered b=
y other
tools, so they can manage the whole lifecycle in peace.
