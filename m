Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B12F4A11
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917607; cv=none; b=EeU9VdZqFYHbvNjW9d8LDCp1efS8i75mB1GC4ebR02G50eopIZ5ZbUOyvfjxPKQZwN4ZrliJ6W7iYyZfhy1BqQ2VirCl/lk+d8sPN/9LIFUncIbhDdDUOjc7wdAsuggaMHXNJVhQx1FqscvWviipSl3EaJWm5+NLErrs9jJLNxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917607; c=relaxed/simple;
	bh=i/HZxmQkq3lN+LmYXhyusDjYLV5depoHHheQdvnEbhY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kbj3DiVfqMqmH412A37wbh/7rmh37K8S+XrZ1KFrBsA9crw9O57kF+0pKLO/LxfX4J2DyQRWDBKidOjxRUNkFdEO5EY7Nr3CWsjzE9FLdKpg1fm1v7jvMyC/n+xK8xCFbInest6yvPmQvrA4kH3rzmpWCDZ2Mr3pdxIjPYAR6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BgR++kX+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXlkWkhh; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BgR++kX+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXlkWkhh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18AF07A06D6;
	Wed,  8 Oct 2025 06:00:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 08 Oct 2025 06:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759917603;
	 x=1760004003; bh=ssok1r3qSIGgxtKc23ix9QfuxBVJEXvHaDJT3RrEDrs=; b=
	BgR++kX+O/0TCQCNUxvOcItYNDZ7a1SytCLzGDFQlQKZe6dNjBx5ciZL2vBhw+sC
	rdmCduFHoXsxqmQuOZhFg3vnVLvg0u6xoRXerVU161xXn71Xd6NSxNdMkCwIKg1i
	FnbmlZXGXiFvJdZyGSQ7tv8QO9pi+eMFIpVycUXSXMRUTWOoxn+DxxvIx64GEbDy
	XTKX6RZ9Q/Qj1Mtuyfkmu8jaFzjogijJOKpt3jly2w/DTncRBdhFufnlnS9KpBF6
	r+gUmd1a1Oz/tZ4wWLXb+kL8OBtr1H7d289PSETPSBVM2coN9lK/dOPtOYHndI/p
	rITXnsSA3p/TxbIRg4sv7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759917603; x=1760004003; bh=s
	sok1r3qSIGgxtKc23ix9QfuxBVJEXvHaDJT3RrEDrs=; b=ZXlkWkhhvAmacQ/Eh
	Lfr75KNJI4MIxlxHsso9rYTIXkgWfTghRcyuc/w1Wwjm++fSq4VwQ8vmy+5K+am3
	I4dCPo7k3HeRtp4/VS/nqLBgvTtw6UXutSVAYBN0pt6KFuLli6E1l1xbwdt3+sXL
	ghnSyYiunXqzF7QuW7ETvG/ePtbCpe4OP1wkEhD/exFiMgkP7RcbFHzKD0x6sfIG
	IDPzpS0rBSMU1BPKABK4WxykK7SswzjKIn+el2/fEYUSqbbGSwGR/qkElZ66VI2W
	bZqVtxAty0vYxzbgQkhMjqrZdHHChjTXouOKKIhZREy3YFeOI4tSQ95A261gJxaf
	4eA2A==
X-ME-Sender: <xms:IzbmaJv297BKfsch9UbG6bcPV7cgncJd5Ok99SWQ_EDGuwVd3V_rIeY>
    <xme:IzbmaNQVlr1FdRlL9_E4qjSvXSAr5IpYjCxBSrkvBl8-UOB3g0BMwGYt2Fg7YNvaz
    bn4VwfAICEBUGpEh-YGCVdob0-uttAk2f7IGwa9vnohAz4yoYCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeftddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IzbmaNpdM-r22SnTNMOtt5z8vMxXMVXZctZpdDk4WhFaSHtvIlwwXA>
    <xmx:IzbmaHZV81d-NvDJSx4r64NiegQVOEKz-nagRh3K9ojgHWv6EhWmNA>
    <xmx:IzbmaNTijJiL9EU5M8XWoRMH0HZ-_1AqccnKceCEuTM0oT_TTw-Irw>
    <xmx:IzbmaG6NyIWy6s7XUjwz-L9JibF2NJafJD__v6wO1EKsNU6YXm2Xvg>
    <xmx:IzbmaAnJeDlY-xB4gnw-5DlHgzzbZhqzqm60jp477T5hQ78JOVA87zqN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8CA651EA0062; Wed,  8 Oct 2025 06:00:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Asrm_GTbWIKg
Date: Wed, 08 Oct 2025 11:59:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Julia Evans" <julia@jvns.ca>, "Josh Soref" <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Message-Id: <b0220dca-d324-49c8-af80-7b19f3b70691@app.fastmail.com>
In-Reply-To: <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com>
 <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025, at 21:36, Julia Evans wrote:
>[snip]
>>> +blobs::
>>> +    A blob is how Git represents a file. A blob object contains the
>>> +    file's contents.
>>> ++
>>> +Storing a new blob for every new version of a file can get big, so
>>> +`git gc` periodically compresses objects for efficiency in
>>> `.git/objects/pack`.
>>
>> This gets into mentioning implementation files(?) like you mentioned =
in
>> the commit message.
>
> That's true! The reason I think this is important to mention is that I=
 find
> that people often "reject" information that they find implausible, even
> if it comes from a credible source. ("that can't be true! I must be
> not understanding correctly. Oh well, I'll just ignore that!")
>
> I sometimes hear from users that "commits can't be snapshots", because
> it would take up too much disk space to store every version of
> every commit. So I find that sometimes explaining a little bit about t=
he
> implementation can make the information more memorable.
>
> Certainly I'm not able to remember details that don't make sense
> with my mental model of how computers work and I don't expect other
> people to either, so I think it's important to give an explanation that
> handles the biggest "objections".

That=E2=80=99s very intresting. Yes, maybe people need to be told/taught=
 to a
level which might be considered =E2=80=9Cjust implementation details=E2=80=
=9D or else
both neither their curiosity won=E2=80=99t be satisfied *nor* will their=
 own
sense of error-correction for the seemingly implausible.

>[snip]
>> I appreciate that this is the first version and you might have plans
>> after this one. But I wonder if this doc could use a fair number of
>> `gitlink` to branch out to all the other parts. Like git-reflog(1),
>> gitglossary(7).
>
> That's reasonable. Do you often use the "See also" section of
> man pages? I've never looked at them so I'm always curious about
> how people are actually using them in practice.

I don=E2=80=99t really use See Also when looking things up. But I notice=
 all the
mentions of other docs in running text.

>[snip]
