Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BBB2AE78
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911430; cv=none; b=M7h8oQzqP7bu+9pJrsi8OERtTNH2l180g4tfgePPPdn8xgnHUUSF+N3NAcusZaNhJIqPRt83vAyLtuzUr+VbqwCXbStAuSG0R7xTEPHVVZ74wBFaCPgFXth/p9znhY1eg17QEY8BGIz6KdfgplST/2le5G5YyfIGwiz8TA9c3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911430; c=relaxed/simple;
	bh=ZtOI+7XyJihloE3sBQkozXAR/0+5Ww8qAUPWN+ua8j0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LYXDdiDReJDpC5OCeg1pAZHVZIvAhbnPmLxfdLO1J0KlezO9hdlc5K4ESOFSfUQ8OGjeKu6DQ7NsbybcZYHDkb1ShrZQ2Ii3kRk0Bhp8hTgUXFstevsC0Zjha/e4gbMbzc8PIK6bvVKOhlPePryYgRLXXGxPQUJGpNu3BDhFaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ly0gpV+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DOq64Z6/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ly0gpV+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DOq64Z6/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BE171D001BA;
	Mon, 30 Mar 2026 18:57:05 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 18:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774911425;
	 x=1774997825; bh=AXAUz/UnW+ad2bPxLzt2nfcHhCDR3tjgHYVPHUZ4cQw=; b=
	ly0gpV+BPaGdeJEzYOekEV2VsIxJRqKnhwn/hf4dhjBZSaNSpgz5BT/PbbEXsDja
	b0LSgYUtnH1tazvBuaq1FnX1dXrgI85ec41Saj4ugu4w0JLnTlINq3Fg0eNZQ028
	Vy6+Heo+KI2gISPYqXPEHwALOiA+IAL+D+QeUM9tahIzhA154cYboLAkqrupf56F
	Twha/KpbmMMEmUKxeP5RqacqoovaL3CrwROgJUqI5i23wbUtanEIsPLo/tk+bQVj
	aFRoLRoJNRMh6UZUTCU4DZYhJ6ZzJQfoQv6Hjd9bC/MKZxGlvHCTh6W/eoE3PumM
	3J6el8jk0sp+nSG9wc83rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774911425; x=
	1774997825; bh=AXAUz/UnW+ad2bPxLzt2nfcHhCDR3tjgHYVPHUZ4cQw=; b=D
	Oq64Z6/V+RS+JS0mExWa+CsDynFOM1absDF06g2ay27kwLs4hKqPGhRQFDH4Y7H9
	0hyHEhGWSofEZ+Jzg1pzKfvng6bI6xNB+d1gIVLbf85pMKSUUFxc6LjpKVmnLbbp
	3Jmhuy5/oVBKznF+NaHcDig01lRQ+wJLbni0xdaN3zviMxWh3QZjWZul7kspsVd/
	b2o4Ut52LxVMY83UY2aC86p260UCuNHGTtZSz3gO3nXLxiXFmZKz5O2C4ZbiggAY
	YECFFGGwu6XFOuongOVBscCmP3bpHSRkq+CYYUOKlq1XPH6K+bE7o9M/nXKUxhpH
	RDFn+AyZSSHQTebWQxS3Q==
X-ME-Sender: <xms:wf_KaZJvrUU3oj4bYblgoOF_Dy-om1izgyvgGaIV_quEhqJhFPHgdv0>
    <xme:wf_Kaf-APM-6dA6tP0Ddm_e6nM2Ks_mxBspbFN1QzqVZgWUUZZQfEdPSJnYmDQqOr
    GY1udg3VAOkJnM2NKUzRxL-1MztW9O5ivt2RQokpdFyNs6iySWpGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehl
    ihhnuhhssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:wf_KaTMMXmtq2A0n1vKSE9UEfNipmTVwKckyKVNDLFMH_7UwzFcqEQ>
    <xmx:wf_KafctpjSrVG2p_los5vHizjJJu9DQgYf71gRFoaFrx1YeVJBb0Q>
    <xmx:wf_KaSU5135Lz-634cNqKJ7D7Q6JzOR41nxlQT3MuvFSMrZvxq83sQ>
    <xmx:wf_KaXjsEickrSxiDjVayw5I9up3aysz6ub7jrRgO-7LAO-TElz2gw>
    <xmx:wf_KaRwYzlhgSWywOqUr3X5RV4T_Y6d57R9CTj1NoUOhA_G8g7_aavvV>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4948E1EA006B; Mon, 30 Mar 2026 18:57:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Axav4Izx-b4R
Date: Tue, 31 Mar 2026 00:56:44 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>
Message-Id: <2ed992d8-7314-423d-828a-5801f4de2471@app.fastmail.com>
In-Reply-To: <xmqqbjg56jhb.fsf@gitster.g>
References: 
 <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
 <CV_doc_int-tr_key_format.533@msgid.xyz>
 <doc_int-tr_key_format.534@msgid.xyz> <xmqqbjg56jhb.fsf@gitster.g>
Subject: Re: [PATCH 1/2] doc: interpret-trailers: stop fixating on RFC 822
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026, at 00:27, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> Notes (series):
>>     The (=E2=9D=A6) is meant as a thematic break. There is too much o=
f a thematic jump
>>     between these two paragraphs without a section or something else =
breaking
>>     them up.
>
> I do not quite agree with this particular instance.  It rather looks
> more like an unnecessary hostile move against folks who prefer to
> see plain ASCII on their screen unless absolutely needed (like say
> for displaying people's names with letters outside US-ASCII)

We can use `***` instead.

>, as the two paragraphs before and after are not all that unrelated.

Or nothing.

> One thing that I found a bit wanting after this step is that it lost
> hint that the primary way to delimit between the key and value in
> the trailer lines is to have a colon immediately after key and with
> a single whitespace before the value, which is what is very typical
> to see in the e-mail headers.  Sure, if a reader has not heard of
> (2)822, hinting that these resemble e-mail headers would not help
> them at all, but those of us among the audience of this document who
> have seen e-mail headers and how they feel, the "look similar to"
> was enough to hint how a colon is typically used in a trailer.  In
> the updated text, the readers will have to way around line #65
> before seeing the official "both key and value are trimmed for
> whitespaces on both ends and then made into 'key: value'".
>
> I mentioned "issues I raised on the previous step" in my review on
> 2/2, but did not remember that I haven't sent out this one yet ;-)

Okay. See my previous email about adding the =E2=80=9Cseparated by=E2=80=
=9D part.

I only mentioned the colon there (prev. email). Not the space. The
reason is the same as what I wrote in the commit message. We say that
these are key=E2=80=93value pairs and only use `:`SP in all the examples=
. I
think just pointing out the colon at the start is enough detail at that
point before all the details reveal themselves near the end of the
Description section.

IMO it=E2=80=99s best to stick to the normalized `:`SP when writing as w=
ell,
even though you can write `:` without any whitespace. But I can=E2=80=99t
imagine readers being motivated to try to deviate from the normalized
separator form; the doc just uses `:`SP... so why not just use that as
well? Compare with the key format: people *will* (or have) tried with
dots/periods, maybe also Unicode like

    Skapad-p=C3=A5: feature-branch-something

... because that has some data content (not just syntactic variation as
is the case for the separator format).

>[snip]
