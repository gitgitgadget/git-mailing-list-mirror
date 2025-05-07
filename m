Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA628B7EC
	for <git@vger.kernel.org>; Wed,  7 May 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746636123; cv=none; b=XjFhxGY+YdIagkunX2p564XLymSCEgI/qELj3G6tEg8qIDYnoF6Dxw5hpHraKDuujW8f5CO+CinV1FlU2/q/fOU/ynaedLyP4B+8eSOcRKRvxiCEBXEn2252yS5qj+8YN8TfqMbwhuIFUkco+H1VXwx/xfrJK+xYv18oJng3H3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746636123; c=relaxed/simple;
	bh=IBNQw6kBAcFU2/PkIYXHT48BrBW93NdeRjDk6rJkKrU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dweSWIQRNciAr0EdLerufp1FWFLNbFz9bj8IxXQPSFa8nDTYAXNLWJGjG+r0VxRDhb0R3ZfJu1pDc2f0plB0xl89JzUaTzsMnkugMWoTv7086WwQ7Id2jPf3Qem9l9WBg0tXqnbBGSDe+fHWuuX7nntdUHsHvLAB/FtGjQZXjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=z2J/LVJ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJgat2Ka; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="z2J/LVJ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJgat2Ka"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 341DB25400CE;
	Wed,  7 May 2025 12:41:59 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 07 May 2025 12:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746636119;
	 x=1746722519; bh=nx5/CcPSDtyU7dlXiuqODkyBE1GRygn6YDmhi81ikn0=; b=
	z2J/LVJ+0WgR/EGe2dd6dL0Dd8m+Bhh3AH2sdnHHRtCuZOCZsCTjy78yR8AVB3RM
	Xmh0AffeIvyTmO485phgeLG5QpaBnxISGoLyXb2EDK4fIBM3AENsx09YSIyNqi7Z
	9orkuAKdGQKQqJ7fA89GY0X28vXJ9/sJJyVHscnt8dybUIghp1+Z0Me2n5TBI+KE
	a/VKElTPhN0RMdaEVNkUIVuzZ9gnEj0S0JvgcMgKw2ez3ytfUSkqhZ2EUl2BEN5B
	J+BeS2rhmjCDMZ+0M10Mb7FQoZgsk8tVAxp2RbtZOMav3u8QEfHhEz5MjDDviAsH
	v2jFljVUbTIY3BT5D+sUvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746636119; x=
	1746722519; bh=nx5/CcPSDtyU7dlXiuqODkyBE1GRygn6YDmhi81ikn0=; b=n
	Jgat2KaE/PNlKFpk4bARZ/K9RKsH/a8NyNK+kWrA2qYk0EG61Yc0zwrrh4XzgFRT
	V2Gmg3vxJdjIJRT7n64Rx8q3AFeZfPZkIjhTebusN+fuPRvkApW67wsaSvydTFpE
	Bqem0x/d1++gRPldt2xO47u6rQBHJ/SwH7WXkLckuD9TKczCo+7jz7uJDudBGVyo
	sf8PGp/C3zQpFe1t4KTBo8DiAq50+GAUPMcMzgwFxpGIJvMHkzKf82BdHR/IwMOf
	t19nq8LmULQ9jtjlmQYhh3wL7O6SLAuzlwqZJyI8tNZ8w1GvuEDoBgkJPOUDUZNi
	WKlwdwJz0w3x2bVdixK6Q==
X-ME-Sender: <xms:Vo0baJRtbg_LIkorSbg2_dUDp8cWKj5K2YcHOOoJa5hXUUyGGvCU6_I>
    <xme:Vo0baCy83WygGl0h2ihHUpjAHvP0rlDZQLmxHVrSjAgjdICX_CZg_fWW4MbF3ANnj
    UsY84YNYypvU5kwSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejud
    egveefvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprggurghmseguihhnfihoohguihgvrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Vo0baO3-aClgSyWpQMuMpfGOh-jrvFsk_gAh-_TGsVA6HbB6NSQvDg>
    <xmx:Vo0baBDlHMSuIRlhPXm3f3LGcoRJw-N180pHfrpDWv5z-ONZFDJZKg>
    <xmx:Vo0baCisHb3CxMAtAq2os_wUg89Fa4ujz0WkHGLuI8C7ERyQyJ7c0g>
    <xmx:Vo0baFrZFBS890zgVQVKIEZ8mjuLdEppp9lEByLk-okpbsGHprtFKw>
    <xmx:V40baN67m5Yq-UIzukYHa5prGXh4xeB_sOo_Q6Ejzjb9oW5XyJdHe07j>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE5B5780069; Wed,  7 May 2025 12:41:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfc695154c64d9261
Date: Wed, 07 May 2025 18:41:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>, "Adam Dinwoodie" <adam@dinwoodie.org>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Jeff King" <peff@peff.net>
Message-Id: <29ff888d-9749-4fbe-9722-95dd71008a2a@app.fastmail.com>
In-Reply-To: <ae56dc14-bbae-4d5e-a890-20735131d484@app.fastmail.com>
References: 
 <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
 <71e8e44e-dbf9-482e-a351-3a82aa1ca5dd@app.fastmail.com>
 <20241019212135.GB589728@coredump.intra.peff.net>
 <ae56dc14-bbae-4d5e-a890-20735131d484@app.fastmail.com>
Subject: Re: Comment trailers vs. bracketed lines
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, this is an old thread:

On Sun, Oct 20, 2024, at 19:08, Kristoffer Haugsbakk wrote:
> On Sat, Oct 19, 2024, at 23:21, Jeff King wrote:
>>> On Fri, Oct 18, 2024, at 07:29, Jeff King wrote:
>>> [=E2=80=A6]
>>
>> I assigned authorship to Ramsay, so my name is not otherwise mentione=
d,
>> but appears in the signoff. So it was a way of mentioning what I
>> contributed (both for credit, but also in case anybody has questions
>> later).
>>
>> I guess "Commit-message-by:" would work, too. ;)
>
> I=E2=80=99ve done that when someone has given me a non-descript diff. =
:)
>
>> I think in the usual trailer order, it would be:
>>
>>   Signed-off-by: Ramsay
>>   [jk: add commit message]
>>   Signed-off-by: me
>>
>> but I didn't want to forge his S-o-b without asking first.
>
> I=E2=80=99ve seen those brackets in the log.  They used to happen with=
 some
> regularity.  At first it made sense since you need a free-form area to
> both comment and tell everyone that you left the comment.  And a trail=
er
> doesn=E2=80=99t make sense for that, I thought.[1]
>
> But thinking about the signoff requirement: you already have all the
> information you need from the next trailer, namely the signoff.  In
> other words this:
>
>     [kh: Added tests]
>     Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Has the same information as this:
>
>     Comment: Added tests
>     Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Because the signoff order tells you who left the comment.  So I was
> wondering to myself why this uniform approach wasn=E2=80=99t used.
>
> =E2=80=A0 1: Since the brackets become =E2=80=9Cnon-trailer values=E2=80=
=9D or something
>    (git-interpret-trailers(1)), i.e. the discarded parts of the trailer
>    block

I was just reminded of this: https://lore.kernel.org/git/xmqqikmce67y.fs=
f@gitster.g/T/#m68c22c9b7dbc9b295e923a913e9d67e3ab28a2a4

I=E2=80=99m just doing a little bump of this topic in case anyone has any
thoughts.  I hope that is okay.
