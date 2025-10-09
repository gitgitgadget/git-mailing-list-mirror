Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D63283C93
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047054; cv=none; b=rb1GfFJXGJqhAEKrf7vbjCaZfqVvSfZ2Ioby4K9/Lodh4JYROqOuw1oYhwWD9Oucpv5aEgcJNohNnu7Uj+2nmRWMFTi/tESrOU0FsZ7u401nVHOgGCbCpZLhccfJetsgwyXLOAh42CZwhdBIiN8SnwwcT9db6kCQ4u1n93TOrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047054; c=relaxed/simple;
	bh=PZQhS5Sz+QvjB5ZWz9Du5j1N1akDw/3cLRKdZOtfqV0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JQJ8oVMnmh65SPo9BG3/qKc5v03UO58DsNLq0UxH1lr2i+gwIZSTCGLH9TEG/WGHJcRMkDqc1gcB0n4UssyUUDySeyyCy+cF6KBurkkYRbHt4fx2ayEpsGIhxpRLVLsozRlJp1D/9Z6CVlWjC55a32q4VZp1EF//W6AWtdnpMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ctlhjne8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l8b4aP1s; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ctlhjne8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l8b4aP1s"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CF7BEC0018;
	Thu,  9 Oct 2025 17:57:31 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 17:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760047051;
	 x=1760133451; bh=J3exVR3BkT+iLR0RmAKgyJmbi/U+NdPiV3wQTAW96BY=; b=
	ctlhjne8ev86Y/L/0/Gnt5r+CrEbSJVDilalbxEqvxL/ekNsjm2dDP+lWIIazQuZ
	zJ1PV3dyzOMGORNWqE7ceNXrwJEXYCAGDbMeulHUCAn6N8XGGT1FfTBaEYTL565e
	Hzjxr/J89JFAklFc1PN72+69FP0taYRrNaOjH/9aUz808kRQVekmoGMko63uZjAr
	PSnuXrUv+OhhvEj5MYcI8ENZRrdkWhe5dCS0EkGWsvsNn4xPLdhPkJc2rTdsQHUd
	sQmgU3fa9GZUw9CD3QXFjePWK6lkR0hFQQmxmw8+sjJRnU7CWuZ0Ylm126ojh6rW
	2QYbuZiLcHs74VhpQ/AuDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760047051; x=
	1760133451; bh=J3exVR3BkT+iLR0RmAKgyJmbi/U+NdPiV3wQTAW96BY=; b=l
	8b4aP1sGSLpL0Mj7MxXSmIH6X0UdweWeL1UVPkqsYBD3y9Bsags+23ot/k3z2Ue0
	konrjYI/IGJL5d8bfFPRm7+oG5uxUd4sw0tM/J0YUiIG2fmY6d7d9Ye+4f2DEU5k
	Y5pqVTyu9upZCYV6BBxpj8YIqAWhkoMdEJEhZC0gwfHX78CpJuJFvOuFu6l82I+o
	GTuenbKoiVLWiv+URutf8MK4fkKMjIyiTNCW8ruEYm/5PHrtVlGCFgXZhcd7hsDU
	5/LbVRLUHI/XiSMngDvkp3W1UlEFk4waRJUm/ofF7/yvYoBZ6LIHjRUAJoVH4+qJ
	7xHNtINMpTh/SODyYGKrA==
X-ME-Sender: <xms:yi_oaKbzD4qZ3tbzLX8dVmfNQa-v31V1SWnt1zQHchJU9FHK4trmgDo>
    <xme:yi_oaIO1SIp1VaaKpAP1jJpIM2LJbOHCFTc-xqjAY3L0uWCJwy8CdmjdGmo-4Gjf9
    Z8cxlGqRgfwWyr85a9V-ysCkEf2Ni6qLUUd9WpFVyIoZAY0r109HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    iehtsehkuggsghdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrd
    hnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yi_oaDYqOKhoTXsiZKxQwudlUjBGSJF5RENENBTqMmsygtUUGp_Nug>
    <xmx:yi_oaNWbzmKG_eZcNOBVEIwMnkVPbq4WtRcnh7h3KEFP3XSYL3w1PA>
    <xmx:yi_oaE8uXh6rJ6smnmzzdm4HKXB6xV1x4rpu2T5hmBuCCadvEH7UAg>
    <xmx:yi_oaO-1Vr0XAvhvsAQVD6VncOqwhdde1QQoTEGjOCf3sApCCOyGoQ>
    <xmx:yy_oaOQpL0D5V0cARLl26xkW5elS0PmWu0vZlM6y_bm9Rn8A4-p72eOU>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0DD9D1EA0062; Thu,  9 Oct 2025 17:57:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Thu, 09 Oct 2025 23:57:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "Johannes Sixt" <j6t@kdbg.org>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <6a921119-6fba-4f82-916f-d80d3f46d54d@app.fastmail.com>
In-Reply-To: <xmqqo6qfda78.fsf@gitster.g>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com> <xmqqo6qfda78.fsf@gitster.g>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025, at 23:41, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>>>  You should only use
>>> +	this option to lie about the committer date when applying
>>
>> s/lie/override/ ?
>
> It cannot be "fixing an earlier mistake by overriding the correct
> data".  It is deliberately using a data that does not match the
> reality to replace what was recorded, so in this case, "lie" would
> be the proper characterization, I would think.

Okay. I don=E2=80=99t think he was saying =E2=80=9Cfix=E2=80=9D but just=
 the more neutral
=E2=80=9Coverride=E2=80=9D.

I was more confused last year[1] about the use-case here, in turn more
dismissive; I thought that it was just a vanity thing. I=E2=80=99m all f=
or
dictating what the author date is since that=E2=80=99s my judgement to m=
ake, and
moreover such fiddling is naturally tempered by common sense. (Did I
author this between one month ago and now: yes, because I originally
wrote it one month ago and then amended it three times in this
timestamp. Did I author this *three months* ago: No, I hadn=E2=80=99t ev=
en
thought about it at that point. That=E2=80=99s just a lie).

It=E2=80=99s easy to have a common sense for the authoring date because =
everyone
knows of =E2=80=9Cauthoring=E2=80=9D. It=E2=80=99s more difficult for pe=
ople to have common
sense for the commit date if they don=E2=80=99t know what =E2=80=9Ccommi=
tter=E2=80=9D is for.

I guess I like the pointed =E2=80=9Clie=E2=80=9D in this case because un=
careful lying
can cause technical issues. So you better sharpen your senses and have a
real reason for doing it.

=F0=9F=94=97 1: https://lore.kernel.org/git/93041214-4774-49eb-b8bd-2464=
8134cded@app.fastmail.com/

>
>[snip]
