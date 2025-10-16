Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25264A8F
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624016; cv=none; b=Aa93YuBFjzt6xfUujP4cuqw1qRg879hYum4+jhsdPKwwsCfBTzlQ1AuVh0G1kwzYxSNiqtiDi+Au5QWEk2ux5oO9vuKgZlawJjb2CR5aux5/+1mPglvsdEWIGmZau3/a9B1125ruw5HjEwjT6qAD3qkW/3ZuFy3FOs3fJOvg/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624016; c=relaxed/simple;
	bh=Qs+9gaahLR0J9XKRVWkdbcnuQco3ursC1dEbpZEXUIk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ftVLg+3zcCvkpPzrFpJQDGseru/GKcLcQzUdWKU8Qkmk/3yEDroDNfpnxf8jeYF66fW6P1WYsOG9X3PBU7IWnhUP6RhpkZaW+YAdsFhbJHLSE998hvO+KDYp7mDMx/zRlkHxGQuYV0tsJzigI55FviFK2MqYLVinZM3AquCZYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WpEX2oBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMFV7TtH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WpEX2oBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMFV7TtH"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0551B1400171;
	Thu, 16 Oct 2025 10:13:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 10:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760624014;
	 x=1760710414; bh=HdByPfcblUSvyyshRw1OG+qxSMSDXEV7LMf+TfjYQPQ=; b=
	WpEX2oBGxdJ1OzcEhJmJz0cO4rsL3PmwecLqL1gYPpXcOGChB2cfDiO3oexyKuhC
	Rg/5C09rLv7hPPeP9wIE6aTigwiayh7ZmqFHPNorJosxgwOqz95k0F3j+62mXYGJ
	kBVHFH5TQolcCrjRSgF+K5/jGENn9kFNgN74cWleXCaLo7uYhRkkFSGQh7RHpJts
	YcxUJceEvQELC9rGCkiG0Ug8RDC/huYtWXzS1tvHP1cLLac33/dZpU3w9k3LZklg
	6cZFTwN7BVUO5w5tzaVQvipiv5gsharOCCb76rat5SzM+l5lGTleesw7lD16bUTj
	Tg52UhIj48XSsfslQeWqSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760624014; x=
	1760710414; bh=HdByPfcblUSvyyshRw1OG+qxSMSDXEV7LMf+TfjYQPQ=; b=S
	MFV7TtHMmO86E9gpCwbOEd2Oi35GeCB/y4TYwj3OJpNY7dBTbX1qu9jfLXjWWsd4
	8a4H4aPsferiyk03QlAkJ0d/+8e8lxr1LlFh9hqrO/eCcaiwCA8zybmbyijBlEwQ
	tUKyaKwsmraYAgLfoJb6FZmWk1qzKHLQh1hatnjZsQoEqZIrSDxeWFIuf1LHDng0
	tdaK9aWZvlKjV5HomgfjwHSzgtH4uRVX8pZ3UjHcGJ+xVJ8R5s2RHjymoKUXCPCg
	rwFGfKXxgWLzywInFe5+9W39zCZ1ExOvXcDqsY4qpUyIlgdproeWorb8MEqrCO5C
	eD5wkv0mEvvH5MoNcE7hQ==
X-ME-Sender: <xms:jf3waJdAyT-Cq53RxIdmkIvE56TVcw7E8KU3PO3Ak21WovKA3SXwsZc>
    <xme:jf3waCD-elHqfWZpCu5fzHtpQsz0AgigKQ8jzd27NkVFyTaz05i2Ze_tOAyhBx5MY
    X4lyTCTVGYuqpFL8cj0ycBJDWjrTsP9CRkYlqiOPeRKH-v56zkbDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghk
    khdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jf3waBnx9ptaQynPtDI-3eNRzHt7vnWwK5cFQQc71kUnuTNWEkQR1g>
    <xmx:jf3waIRrY4SzQuQi4BGRO8jtNkh5HwhK1R3Qojj2JBPuSK0uC9Jdqg>
    <xmx:jf3waLJyiM652vP5kLOfaAqT66RFL87wYS_eWD852qg1_pcYmplPhg>
    <xmx:jf3waGCoabpE12ykIYKJkM0UTZEmkIkb9HdFhYPkDEIy4OdXZP9ONQ>
    <xmx:jf3waPJbh3MP5Qx_f4i3aarE-1ozLML2Uy2wm694KHnI827fXY173Ed6>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EFAA31EA0066; Thu, 16 Oct 2025 10:13:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Thu, 16 Oct 2025 16:13:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Johannes Sixt" <j6t@kdbg.org>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
In-Reply-To: <601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Good afternoon Hannes

On Sat, Oct 11, 2025, at 11:15, Johannes Sixt wrote:
> Am 08.10.25 um 21:45 schrieb kristofferhaugsbakk@fastmail.com:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> This option has legitimate uses but could create a commit history whi=
ch
>> violates the assumption that commits are strictly increasing in terms=
 of
>> commit timestamps. Warn against that in both git-am(1) and git-rebase=
(1).
>
> I think that the discussion has meanwhile converged insofar that we do
> not think that the option has a legitimate use case. Rather, it was
> introduced to solve one particular problem case (that is cited below),
> but with a solution that was misguided and not well thought through.

Okay if this was the cited example:

https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247=
@mail.gmail.com/

Then we can clarify with two questions:

1. Is the use case itself reasonable, i.e. abusing[1] git-am(1) to
   pseudo-import commits (modulo the committer)?
2. What is a better way to achieve this goal? (assuming (1) is true)

   It seemed to me that you might as well use the author date.  Unless
   setting max Unix time would be better?  Then at least you will never
   manage to apply something on top of something with a newer commit
   timestamp.

=E2=80=A0 1: Since this is not what git-am(1) is designed for

>>[snip]
>> +	NOTE: The history walking machinery assumes that commits have
>> +	strictly increasing commit timestamps, with some tolerance for
>> +	clock skew (see linkgit:git-rev-list[1]). You should only use
>> +	this option to lie about the committer date when applying
>> +	commits on top of a base which commit is older (in terms of the
>> +	commit date) than the oldest patch you are applying.
>
> IMO, "NOTE" is not strong enough, it should be at least "WARNING".

Thanks.  I=E2=80=99ll do that.

>> ++
>> +By default the command records the date from the e-mail
>> +message as the commit author date, and uses the time of
>> +commit creation as the committer date. This allows the
>> +user to lie about the committer date by using the same
>> +value as the author date.
>
> I would not mind leaving the description first and the warning in the
> follow-up paragraph. It would make for a better flow of reading.

Okay.  My thought process was that this was important enough to
front-load for readers.  But regarding flow: the reader can see the
all-caps keyword and skip the paragraph easily if they want/on repeated
reads.

But I=E2=80=99m perfectly fine with leaving it in the second paragraph.

Note: Not relevant here but in case there were more than one paragraph
on this option already: should the WARNING be the final paragraph? Or in
the second paragraph? (Like an imporant aside interruption after the
introduction.) I think the final one but just clarifying.

> Perhaps insert "Do not use this option." as the the first sentence,
> either before the description (my preference) or in the warning.

Regarding reading flow, this seems more back-and-forth than this patch.
But let=E2=80=99s see.

You preferred option sounds good to me.

You say =E2=80=9Cfirst sentence=E2=80=9D so I guess we=E2=80=99re not ma=
king a one-sentence
paragraph.  Like this?

    Do not use this option. By default the command records the date from
    the e-mail ...

    WARNING: ...

In that case I think parentheses makes it read better:

    (Do not use this option.) By default the command records the date fr=
om
    the e-mail ...

    WARNING: ...

Thanks for the review.
