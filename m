Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203D3FC5A5
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893313; cv=none; b=iJp6GlB/7mBBVs4daXuB0FoD0tYzW32ngJGF65qZ//Z92EdM642VTE7+8TRjecd0gUVz8IDvsIciArJLjDbsp25wRu34AhdehTv/zxOKXHNBpn1HLHb/7+di+FARBfNI9SCxS8F0PI4ZpNhZgYrv+J2CY/iwV0Kl8eJ041aIx4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893313; c=relaxed/simple;
	bh=sA4ullsk3TQtGjH64VIjB1C47r8MscwvLaeIswjI/Gw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GywNUlmGQRghJLpQo0qkEBT3XwJElC2Oh3HewE67Go7IoK1+35QgNRR6bclg7YmJ0PIEahDpcxxbIiGupHFZNDfDfXxZJj76aGMIuc2Tf7zwfpptICSEMjm79BwjyFbOaxDGebcG9iVQRU0SYa+t/0hNyNy0k/m3FTRjYONts3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=0cIDBoWV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sccEs+CK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="0cIDBoWV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sccEs+CK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68D67140003B
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 18:21:50 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Thu, 01 Oct 2026 18:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790893310;
	 x=1790979710; bh=5zFxqD9F/GNQ4vQ7+OPoKW+aVSTzMuSutmmN/tdDylA=; b=
	0cIDBoWVL4+9mwC3c3jENcNP2X5gSXFSe1lm70lgv7Ld8E/h4/z5oR4cIjxgwLC5
	QwL9HuGB46u88gj3h8BI3Jf2VVzMja1pOAnErBj1aHr1IISOr4qceamHtW0XsAVQ
	UfFeGDGPzfD8NE+JCt4LSIfL7UeJQUyo45UKFl45ODvJlNqcyRXhzqYcnC//Qafx
	lWYa+ALb8yDyn2Gi3a9d4MfrW0ROjSILyMgOH8Bg2k+3yyrsemD3N41lQMBO6Yci
	9UUOwfhlGVQ7ZN2GazjSpsfaS9ciTXzkZXl12LXUbrnxF5yV5QmAotKpq26rQqcR
	thB4kzbzhRnucURbG5fTaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790893310; x=
	1790979710; bh=5zFxqD9F/GNQ4vQ7+OPoKW+aVSTzMuSutmmN/tdDylA=; b=s
	ccEs+CKecc4La9gghQiFqeBkjN1VkhRYLXEMDO4BHu37+DBsAMNiqC/CjhnVlWNx
	lgH3oAdD5hhjYH5DuKPCgKfgBnGOW9r3BeTRGlX6csHhjpCy3q9l1EkQZoxg6lCq
	WUcPCLqyObr/8+ybMXkfoqGolZO5e786FW84YUpbEsYhLaoRkcezyaipqlQREwKi
	lGtg82cnqYVKTeStbC7dVXgHGTP+rwNA1oBslIMWDoCdut3Wf0oEGdo40MZz8aim
	QU/uSDDZOVomt1mXLIhU/BE5OmFp1cbtsN9H/7TYmxDEg0aVDimPT91jSxBoTFOw
	6PjesrEHH1dJ4Q3pOYmGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790893310; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:iOxLXgWI8reMY+0KntyNm4YH5e4fIZfXpUXdlt/vjI4hN8O
	GXzm3YSSXftfpJyISYkpc95uxJ/RWch2tCYFP92RuG6nFw/QwUoLKgxGT5msRdqh
	utWPCDPIJZ+7fJOK8rLcx3ll8i2/g6EkUmJlAxf/LQ9WQYswRRiRcd47QSklYp7t
	/PDCi1SHAt7Dz9G2evdeeSbNok+6ka3nGW652Sz39cSNGBIfZ1HEeS/HTNcE8qSI
	GMt6WGkpCB8PfNKYRHojWmcP9Ubklk1MFEdFurY0Crr5BYXvlkUCNx5XLs2rInrA
	a+KucPrRs8Gj2veObNhGFlbfQf2e/87D6boOEWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9xH6ZomjfI3u5LQTWKLiLvB7J0tinhtGJEDpWqjIFuU=:sA4ullsk3TQtGjH64VIjB1C47r8MscwvLaeIswjI/Gw=;
X-ME-Sender: <xms:_ty-aipSqsEaps7Z9NIIrmorPyR2hXIhaEusEzIyc4kpSLJkKzaOqA>
    <xme:_ty-areLnYEv_snUmeB8jtRMCYko-35TyxeHR3e2Zr4kejGgu2lJ_4iZhLC7BFsHM
    fpn9ijC0WxgVyyJqv7ZmU0tIfeWH6JrJ4qZlyzQlO7ze3dSPaeGAdo>
X-ME-Proxy-Cause: dmFkZTF3noi4LLs/Qiy8VG5Gc56YGqm1iyujIFArkb7XjVH0gFdnaNb39jR6uqerGMnTrc
    VrQgCIcDzE3MgvCG4AkOIH8Yk34PjbVYZwTu6ttk79ii0XZn5Ie3Cejh4GR/Adq9jfbWwB
    PyDv3Q99YF8hmqR17Vl7MnvvrF2boGnYuqQDtNQJqUKxUsrmZPBcyCV1yiZOiFxK3qX8Ob
    blTcRoxtBneG38pMTecpWS/wvBw5FIuoWMtrjnW2iS/WA9iDA/n7Hlpmi26IrAL7BKgv98
    BUKrQ7qLszSO/c9CdWhF8nJMQWIPp6Nml+887/+xrS1Lfd6170WIFt7yBKNpO2f9lqNEk/
    NomINHk4sNhzyadwv6RKSuhNNq9HF7IT7MWY7rZQ1KHNcKkZrZmmJRAeQbtILOqimQhhNN
    w5ulgSGPtmnp9P+AOsuyvHzHe5Lk4olpv7E5UnbGJtJT6E0vIpXMNOYOHx5O5ZnI8DHGSX
    BJv4nvp27ejWfBAFtAnS2kZmi/1kX2XmnrxGovPuHnwNbRYnHsG3YFM/B25ukO2+IOHb7o
    lIDb8GaqLdQ0VPoG0SVtmV3kCr/Yn0d+EW1BiknQ6XlyVatPQa8OhfUDUs8avbSySdSSmU
    lkawxgTxD1b92CCJK2YMhsUrBvCPZkD7opnelUdtyqLusCi3nMz33YtmslAw
X-ME-Proxy: <xmx:_ty-arGoX2TpRYUcupgGa7tYfXO2oqBA7lbhGRIZcgqXS06E5ZoxIg>
    <xmx:_ty-agFdQJhho7pFruOaIL0gpApUwxNXx2R_oaNQMRIJ8ns-tqab-A>
    <xmx:_ty-agP7Q6zXiqLqFyRV6II-VJV2CdfuF6ZJ24ZsksAChsvQK90K4Q>
    <xmx:_ty-anETzHeF9XHpTu38YAsziX8XFzE5zgh1pDE_bwjUw802BDiwgA>
    <xmx:_ty-aggxrR0qtJ0VXk-WXfHLiaAEVWcHv6fZCIqv72ketzSPnfhk1kAI>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2CBA4780070; Thu,  1 Oct 2026 18:21:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqO-TNe5d1d7
Date: Thu, 01 Oct 2026 18:21:30 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <040938c6-6fc9-4727-901a-9be2b0b3a6cf@app.fastmail.com>
In-Reply-To: <xmqqzewzch55.fsf@gitster.g>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <xmqq5wzojy31.fsf@gitster.g>
 <8a5b742a-3f11-4bfa-954b-ffdd839b6d43@app.fastmail.com>
 <xmqqzewzch55.fsf@gitster.g>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> You confuse me.
>
> What do you mean by "it" in "keep it around"?  gittutorial.adoc?
>
> If so you said it yourself, that we want to have a tutorial that
> covers the basics like `git init` etc.
>
> Or do you mean some other document, like gittutorial-2?  It would
> have made sense to keep it while a replacement was being written, to
> make comparison easier, *if* the goal were to make sure that the new
> one covers everything the existing one covered, but we already
> agreed that it is not the goal to salvage what is in gittutorial-2
> (and that is why I personally feel it is OK to remove the old one
> first).

Here's another attempt to explain! I think this whole sub-discussion
is not very relevant to `gittutorial-2` (the subject of this patch serie=
s)=20
which should be deleted in any case. I would move this out to talk
about it separately but the mailing list is still tough for me to naviga=
te.

Everything after this point is about `gittutorial.adoc` and about how
to manage the process of improving it.

Here are some facts, some of my opinions, and some options I see.
Apologies for the length :)

Facts:

1. The current `gittutorial` covers git init, git add, git commit, git d=
iff, git
   log, git branch, git switch, git merge, git clone, git fetch, git pul=
l, gitk,
   git remote add, git show, git reset --hard, git tag, git show, and gi=
t status,
   (and potentially more commands I missed)
2. My current `gittutorial` draft covers fewer topics: just
   git init, git add, git commit, git diff, git status git remote add, g=
it push.
   Basically just how to make commits and push them to a remote.
   These tools on their own are enough for a user to back up their code =
or use Git to
   publish a website (for instance with Github Pages or Heroku RIP)
3. 22 people who are new to Git have tested the new draft so far
3.1. Several of the testers said in the post-tutorial survey that they w=
anted more
   information on branching and collaboration with Git. This was the mos=
t common
   "what do you wish this tutorial covered?" request.
3.2. Several of the testers also said that the new version is a lot of
   material, and they were not able to finish it because they didn't hav=
e time
4. Writing tutorial material is a lot of work, it will take time to do a=
 good
   job of covering branching and collaboration

Opinions:

It's important for us to cover branching, collaboration, and how to rest=
ore
old work in our tutorial material. There are other topics too but these =
are the
most important.

It=E2=80=99s not realistic to expect new Git users to be able to learn w=
hat they need to
know about branching and collaboration from the =E2=80=9CMANAGING BRANCH=
ES=E2=80=9D and =E2=80=9CUSING
GIT FOR COLLABORATION=E2=80=9D sections of `gittutorial`. Two of the man=
y issues are
that it starts talking about branches without explaining what they are, =
and it
teaches collaboration in the context of a multi-user system which is not=
 how the
vast majority of users would collaborate. As far as I can tell it never =
explains
what a branch is in any way. My impression is that we all already agree =
that
this tutorial is not doing the job it needs to do in any case.

It's also probably unrealistic to merge a guide to branching at the same=
 time as
the intro to `git commit` just because it's already so much work just to=
 cover
the first parts effectively.

All of this together means we=E2=80=99re not in an ideal situation.

Options I see for dealing with this:

option 1: Refer folks to the contents of the current `gittutorial` (in s=
ome new
location?) to learn branching and collaboration. I think this is what yo=
u are
suggesting (?). I am not willing to do this because (as mentioned) the c=
urrent
gittutorial is not a good way to learn those topics.

option 2: Ship the new tutorial without a guide to branching and collabo=
ration,
with that to come later. Not ideal, but I think this is better than opti=
on 1,
since at least we are not pointing users to a tutorial that we know will=
 not
help them.

option 3: Recommend some kind of external guide for now. We talked about=
 this
before and I agree there are issues with maintainability etc.

option 4: Wait until we have a new tutorial on branching to merge any new
tutorial. This will take a very long time and it=E2=80=99ll be a lot mor=
e to review at
one time.

Right now option 2 is my preferred one of the options (which all have di=
fferent
drawbacks)

best,
Julia
