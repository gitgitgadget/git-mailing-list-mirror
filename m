Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49B34C82F
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072981; cv=none; b=I2R0WcTkwAVp1jh3ATTrggRBUNhT2YWosOLE/TSUBvSvZ9B/6H95pYbSzbM2jyPaFwXV4cqy3yMSe0lR3nMqkDYaBcNhM+FNw5Z4BvCNCo7meLeGBoQIECWd+0TlJ5aoS++N/cUB2GGMRUmvpBEBziHYKAOjT/Jik5Pi3Pxig/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072981; c=relaxed/simple;
	bh=o2FLSxFRE8lNzSfTmoE9ya/yWDAB9bLLjib8cPIkycs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TmIhsXfICaN0vNYGUedKETJ/5nqDBPTYRce8IGV8G7Y2X8Zdtgi1M+CoAf+EptabeQRqGobtY3hZsfAQ2M/czTFy5krMnzbJ1dQcdOZ+okMMzacAgeKqoOrh5ALACCXYSSbmBdqJcZiHP3BqwbB4eDkAsCAKEQvUe5sDMDVsHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QJTqbsXr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cm2h7crp; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QJTqbsXr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cm2h7crp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFD081400157;
	Tue, 21 Oct 2025 14:56:18 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 21 Oct 2025 14:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761072978;
	 x=1761159378; bh=AYzbNK5u1Hu8LYCuz3pptnrnUyHVsD84dMruZVzYFPE=; b=
	QJTqbsXr+arFZci1737lOFQ2+0Xb+qD27uHgS6Yhn7ph1xArMmNaIp2YxgjIRCXq
	ubML33WZFq7JRyiRRqn3/7SYFCz11D39/zk3vPKUDYf9RrK1HDekGgyxJ/UmkrJy
	/nofU/OAUsKft5FNWbRMl0oHENPvvDrYKCcCReJ99jYegokBNXWCZatsu5uTMen3
	cW1tCato8/UXA7RZbe7qr8RdGsyToMlExCTcVLLpEOm9Gp/RDc3fkviCARQC/kxy
	sanfJRo+grsOEg8dZJy34cs4UNiVKc6NhtTxJ+BCMQ6B3FITlcELpPJEkX9ZaQOU
	nynoP7Xira3YM0hxg+fgXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761072978; x=1761159378; bh=A
	YzbNK5u1Hu8LYCuz3pptnrnUyHVsD84dMruZVzYFPE=; b=Cm2h7crpGtQl0kq/7
	7AGAbfCYc2aKXv3VSwCV0wmk/h02F5ddU4PJaoSWV3qCxIxtnN+nsFVcrcEpIPoU
	cIa0oEi48onDko4mxlt52TtSrI6JkRGqBEBPpijQMKpKY9c9fAwNSvuDdH/QZAi2
	oIxAEUiBMoTh7+KSRmeCxGTVX5Iwc8QsZvd91NNpR2QF6EMCDcyjJMkDvLzQ0yO0
	vVGznPotF2HdT5ywVyC3Pd7tWdycMosq4Lqvz+dzeSiKCA6soSsbuLQNWm9EQRn0
	r2PhhUvnkroGT1qDRNygB2WDsQRTJEx3DJEi4ib30yVm9j4k75Hh2J+3IFQxjybk
	d4y6A==
X-ME-Sender: <xms:Utf3aLFJvtjLTJhz2fz1KLLjjm7CZnZffdjCAljR6nCfe_3VUxWzMaM>
    <xme:Utf3aDI69YcK52aWOM7NZI9Y6wkIf97UFbADQ9NUI2fUBBvUusB9feNxvIogIu9lp
    LHZixaSaaq6FSCcoj8XkaxR_tHtRHt84oKWoJHutUirjH0_RqZeGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejveeikeeffeeikeekhfev
    ieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:Utf3aBx_YkSYUaL4vENBBqSV0blZSWcwx0ys8dhILEaUa7h1bKvitQ>
    <xmx:Utf3aPOPzTk9eJAFgIsMe1bnq-w-FhcUOyJGG6gQjWv3Yj9A-vPyhA>
    <xmx:Utf3aC4apaPWeFNICyZ4aSxGG4eVMVNrRxKULBw1xQWjAoSVgaeD1g>
    <xmx:Utf3aANl0aYQjhfOZH7atxq0zd38vZzhXnk63mjrOuUMTqXHhxFlYQ>
    <xmx:Utf3aO72fZegIaUvzvvlVANK1EN7Ap_jafy22725gttFd7V4oM7jDIBp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 60B131EA0062; Tue, 21 Oct 2025 14:56:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2eT-0Mj25jR
Date: Tue, 21 Oct 2025 20:55:47 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
In-Reply-To: <xmqqldl4und1.fsf@gitster.g>
References: <xmqqldl4und1.fsf@gitster.g>
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025, at 20:21, Junio C Hamano wrote:
> A good default matters, and people who find out how useful a rerere
> database is would say "gee, that sounds great but why they do not
> enable it by default?  It is too buggy and they wanted to reduce the
> number of support requests?"  Yes, the reason it is not enabled by
> default initially was exactly that, i.e. those opt into the feature
> was used as guinea pigs to polish the feature.  But we forgot to set
> the graduation criteria and never said "ok it is mature enough, so
> let's turn it on for everybody".
>
> Perhaps Git 3.0 boundary is a good occasion to do so?

This sounds nice.

Sometimes I make bad resolutions and my cache gets in the way.  But I
know it=E2=80=99s a directory or file somewhere that I can delete manual=
ly.  So
that=E2=80=99s nice.  And if I didn=E2=80=99t know I think I could have =
found it on
StackOverflow.

I don=E2=80=99t think the =E2=80=9Creused resolution=E2=80=9D is super c=
lear for things like
rebase and merge.  I will get output like

      CONFLICT
      CONFLICT
      CONFLICT
      Reused recorded resolution for ...
      Reused recorded resolution for ...
      Reused recorded resolution for ...
      YOUR STUFF IS CONFLICTED
      DO THIS AND THAT

      this is from memory :p

And the =E2=80=9Creused=E2=80=9D messages are kind of =E2=80=9Crandomly=E2=
=80=9D placed in the stderr
stream of consciousness.  Could they be colored maybe?

The biggest usability problem for me is when I have a cache, I want to
keep it, but I want to remove a few pathspecs.  I=E2=80=99ve made some n=
otes on
this to myself.  Apparently I tried to `git rerere forget` on some paths
but I got not output.  Then I did it again and it reused it. According
to my notes I had to get into that conflict resolution state and then
*forget*:

(this is straight from my notes, I didn=E2=80=99t try this right now)

1. I did the wrong thing for `file`
2. I reset the merge back
3. I did the merge
4. *While resolving conflicts*: `git rerere forget <file>`
5. `git merge --abort`
6. Do merge again
7. Now I can redo the merge conflict for `<file>` while keeping the rest
   of the resolutions

I don=E2=80=99t know if all of that was necessary but that=E2=80=99s wha=
t I did to make
it work for me.

In short I guess I=E2=80=99m saying that git-rerere(1) isn=E2=80=99t that
straightforward if you want to figure out what is in the cache, if you
can delete things from it in your current state, things like that.

(Contrast with git-reflog(1) which is great to always have available;
copying hashes from the reflog to reset or something might be obtuse to
some people, but the reflog is never in the way, you can always look at
it, and you don=E2=80=99t have to worry about selectively deleting/pruni=
ng it.)

I=E2=80=99ve tried to read Junio=E2=80=99s old blog post about rerere pi=
tfalls but I was
never able to understand it. (I=E2=80=99m not soliciting anyone to expla=
in it to
me, just saying.)

For people with *my* biases towards rewriting history it sounds like a
good default. But I think for those users who make twenty merges in
either direction before they land their changes in the =E2=80=9Cmain=E2=80=
=9D branch it
probably won=E2=80=99t matter at all.

Just some thoughts. I won=E2=80=99t be able to follow up on this thread.

--
Kristoffer

Probably away until 28th October
