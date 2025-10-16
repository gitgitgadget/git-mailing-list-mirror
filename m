Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F920DD48
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629355; cv=none; b=c/KVNBYTo3FDzSwBwMNuvQgrfD0OKJ5gCRNvBV6FBP/h6bvL8WF7W0kg5KkhHoos9o5Jzbc2fXC47R29FfQR2ZZeiGvvWIeDHWROhHJTAtoDftnIpBqq93FBAq5zANHDfZ9icDX+2FlIuuSekcDICLzFF+uaNoCqzgMaNI1o2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629355; c=relaxed/simple;
	bh=DB5IWSEI5rh6jdYlERBwn8sC7UUwl2avAuKi8geRgVE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DZnyFZaayT4i3NRjm54IfLR2nOjIic8VhKlNFTU44zXkkxsid/pnqL+v7VeZ1vsuKfh+adAbd7jkiH06l++RQNK4OY5gpSiUboE1ujetNET0/ds6XMQZ7/8vATY3+17VSRAmfJEsGe/nle7kP18eDQ5yB+R0DtN565t7pSWh55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eaUH6QtA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sowDmL7/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eaUH6QtA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sowDmL7/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E4BC14000A1;
	Thu, 16 Oct 2025 11:42:31 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 11:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760629351;
	 x=1760715751; bh=MGKVs1RsDZFnGEhJ4qsbfTgLbtBqUastUi6W0JlH1cQ=; b=
	eaUH6QtAe5xwUkLPDtLMsHFghch8xnOFvdiYYPovodxJ6NihQCCxziPLPSd/SOdT
	Gjgh/a6ktjvCy6uWloKwt5CcVVPpkjjS9/Pqj1uKokr05zgmV93KhQWcFL529fAM
	L2WZmQjAwztIy13BTFkR/hJVe4zdAjm7zd3N1VRir75gk5Akv23zYN+O7Wg3cty1
	mSHX6alMLmcBXNQ0PkrQhZ6E75RisSgfph00WabbO3lGSlcsBJbxY3dq07MZ94Us
	JeFCPOqAcEQc8Wwn5ZZjLLyMZwcCx7dB+McZP8nmY0e4G+P1xPJInBeM1+vNmkQ6
	80sserrkHr0ZRPHJ/ymTWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760629351; x=
	1760715751; bh=MGKVs1RsDZFnGEhJ4qsbfTgLbtBqUastUi6W0JlH1cQ=; b=s
	owDmL7/IMnnb3vE7Of/64FbhKO6wq+uxsTo9Qb3VzKJU+tHUwTzaGqhkU6vYIeNj
	wYhq3uEK/oJeExUShl6s55i9KJHm9YwutBqxC4CUU2XUBO1VS2gFLgqV8YGgJW0X
	CGbVmvLC8CJrf5J640lKfDhSrt5B8Aw6JLeMCKS67TRwKAMtqg+Mbao+RizGDGwA
	WlKJNlxQwGV/xeT7/2WTojIJM5tu8hXo5ZwD1X/oMSjTVzrtcuyTzS0RLYouEM13
	78S1Q+YyDDkADlhNNpPs8mGAfGVFPJKyBXOQoS7ODGBaI/6ebi402JeLGa2gOd8k
	g+g33yG7MnFqAKlyHmf7w==
X-ME-Sender: <xms:ZhLxaCOFK1NdFx5x_O8i1s7DODtfWPf3iGWTmczg9-qNjCr_KBN4I7s>
    <xme:ZhLxaLz193Q_jsZCylJFRYAlf78L3oN-cpd8ryNtPO2D1U9x7tLaulgu6nl7zwdGJ
    oIqgmrzNyrOcAMdGfm_YAGIWidEzYF0GrkClnX25kM2c5Kk1Qfz7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiieekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ZhLxaMUNICfemZgqktRgmCB6wWQXIcD0WTMnjfHblXZORuUjAk4YDw>
    <xmx:ZhLxaMAoN0twehpz2hWYNypVUd8ddYpu7Pnz4SuKoULMDRIYUFKPQQ>
    <xmx:ZhLxaD7tAy4zt_lqgkXIrdvlR98XfuTLVI-fCy4pO0Q75R2jL3udRg>
    <xmx:ZhLxaPydJrNs3Ia36IPvX-hC8zknX4M4JoECuabPWOXj3yal6GRAow>
    <xmx:ZxLxaK45YQqQfpjNoenZPANYksrh_GBAkPfqPgsud9P4yR3Uz9RWgBUi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A63851EA0062; Thu, 16 Oct 2025 11:42:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: And9clSpnOi7
Date: Thu, 16 Oct 2025 17:42:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Johannes Sixt" <j6t@kdbg.org>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <6a456b83-f27b-46c2-9b67-4adbac437f4c@app.fastmail.com>
In-Reply-To: <8b7df500-4ddd-4aa4-bc67-b1b345c806e6@kdbg.org>
References: <6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org>
 <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org>
 <52fd63c0-cd43-4ae8-af3e-f3fae02eaabf@app.fastmail.com>
 <8b7df500-4ddd-4aa4-bc67-b1b345c806e6@kdbg.org>
Subject: Re: [PATCH] doc: warn against --committer-date-is-author-date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 17:28, Johannes Sixt wrote:
> Am 16.10.25 um 16:13 schrieb Kristoffer Haugsbakk:
>> On Sat, Oct 11, 2025, at 11:15, Johannes Sixt wrote:
>>> Am 08.10.25 um 21:45 schrieb kristofferhaugsbakk@fastmail.com:
>>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>>
>>>> This option has legitimate uses but could create a commit history w=
hich
>>>> violates the assumption that commits are strictly increasing in ter=
ms of
>>>> commit timestamps. Warn against that in both git-am(1) and git-reba=
se(1).
>>>
>>> I think that the discussion has meanwhile converged insofar that we =
do
>>> not think that the option has a legitimate use case. Rather, it was
>>> introduced to solve one particular problem case (that is cited below=
),
>>> but with a solution that was misguided and not well thought through.
>>
>> Okay if this was the cited example:
>>
>> https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a=
247@mail.gmail.com/
>>
>> Then we can clarify with two questions:
>>
>> 1. Is the use case itself reasonable, i.e. abusing[1] git-am(1) to
>>    pseudo-import commits (modulo the committer)?
>
> The cited example talks about a set of patches and expects them to
> create the same object IDs each time they are imported. This expectati=
on
> only makes sense when the import happens on the same base commit. But
> then, why in the world would one want to import the same patches
> multiple times??

Okay, a good question. :) The part about that request that I have
thought about before was using git-am(1) to apply patches to the same
base commit and get the same hash.  Which would mean fixing both the
committer (to some dummy name) and the committer date.  Then someone can
use git-am(1) and patches for transport.

But with this scheme you need to be the same committer.  And why would
the same committer need to apply the same patches to the same base
multiple times?  Indeed. :)

>
> A mailbox full of patches is not a suitable storage form for commits.
> This particular use-case for git-am just does not make sense.

Okay, then we can scratch that idea (point =E2=84=96 1).  In turn the se=
cond
point becomes irrelevant.

Context for others: Junio=E2=80=99s reply to that request:

https://lore.kernel.org/git/7vljt26fp9.fsf@gitster.siamese.dyndns.org/

Aside: It seems like we can make a more straightforward change if we all
agree that this option does not belong to either of these commands.  I
would not mind that outcome at all.

>>[snip]
>
> It certainly depends on the case. I think I would begin by putting the
> warning last and then judge whether a better place is warranted.
>
>>> Perhaps insert "Do not use this option." as the the first sentence,
>>> either before the description (my preference) or in the warning.
>>
>> Regarding reading flow, this seems more back-and-forth than this patc=
h.
>
> Fair enough.
>
>> Like this?
>>
>>     Do not use this option. By default the command records the date f=
rom
>>     the e-mail ...
>>
>>     WARNING: ...
>>
>> In that case I think parentheses makes it read better:
>>
>>     (Do not use this option.) By default the command records the date=
 from
>>     the e-mail ...
>>
>>     WARNING: ...
> I do not like the latter. If you do not like the former, I wouldn't mi=
nd
> not adding the sentence. The warning should be sufficient.

Thanks.
