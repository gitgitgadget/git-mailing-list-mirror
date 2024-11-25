Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF51B6D1E
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566082; cv=none; b=q+D6NVORFVXYP3P3G94wE6Xv+zJeGBtGbvjM98Ch6aATvUZT5WjPDuiK5GZHYOYClohSVN35RQ5SM3fvGicEEL7smu50NhwMl88G40WDaB8qwQRivc3vOPVNOTY73cxm20OQQZa8n+o084hwQySo4xbtFGGq01ywFRzxzsML7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566082; c=relaxed/simple;
	bh=OFIPVHnicFsF9HBU+RerzCJ6PuPFmu4BEfZKq//s0XA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g4jARht/wQdBLeYXmWDDn4//2EpkVF116Q0ie6FYv+d6qQVBIuk63W4t7uXxCvFTLmn9Zd813k+VaSLI+WB9icxIfqWXy34RrxZkXT9RcdEd3HdinU3vMccNEtO8rCvp3/8jT2NtqU1pVZVzlHnUkQDnBkZMa8fhffY6d0+iIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EgwkdAz6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YNO9aH9x; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EgwkdAz6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNO9aH9x"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 83CE91380137;
	Mon, 25 Nov 2024 15:21:19 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 15:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732566079;
	 x=1732652479; bh=wl2vR/QAxvqzz1iSRERQ9IXIuMUIG/ontUESBR9F0Sc=; b=
	EgwkdAz6b77WumLpfUipUl0G12mkJwblDOPN4uSjsHKkHabFFWbS6eWUN+lZA1WY
	gqZqLH0rngrXMe9btc1pze6UBASiD3DKiO+Q5tfN14Fawgm269QwUuW83bAInMQF
	USETP2w74USGCQxPC7WFFUQaZ/znRp7sTjajgmJZWcz8JCHYbubU6nTDTeA9+acN
	Z0Zr7OoxJpUKYvjdfRYDKadTHew/T2bYT6u4tS5elftNWuGqh8kDIUV9j8WBCnYY
	3dsfk5AS3kpT/9JzIZUp5pfWz9wphfX0v18bWUqx/4C+sNnxujH2iDjqTpoJ1qWM
	2A2SPx5DYG5qrUUx9zJ9mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732566079; x=
	1732652479; bh=wl2vR/QAxvqzz1iSRERQ9IXIuMUIG/ontUESBR9F0Sc=; b=Y
	NO9aH9xlmLzCuFg1+BfBxaBm5qERfU8i1wfZRH879o056a4MVZ1jbucIWzwE+d3c
	w/qAjxkFGEynBT+KEGyQ2+o7sZT5k/Iw9YApZ/QSrG1/lHnMZK1O5sWuNmTXYu2c
	b8W5YNq3YDwJWFgQ5xw17384JOzE09M/NXp1yK6fP6LjI3T9SjBbMa6cKN3hUUp7
	3SEDPw5DU9TkPs++BtjEwMyeopzrvr5t+qSeHmgBsfGnOKGI8e9gHWt7bRudPTle
	CdV6rMv7tkFyIX5+xO3DzgZNLsioHdE9Z8meYHuUPq6IkTgGeQJL+DYSTdF6T/d0
	ebL5pcJqDiMbfc3QlN2kg==
X-ME-Sender: <xms:P9xEZ0Gi7050goK3BI34MBXh61Jb-K-6DvFm_KA7LbAD6jW_yT_wHkY>
    <xme:P9xEZ9WXsCEKmILQe9fnqr1b2IMLyqrvVJHgQ9QVu6Cu5q9LPHudzmFgMhOBhKrF9
    buNJJKQWynfezuP4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhgohhn
    vghllhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshh
    hinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:P9xEZ-JbVqZswpPQnWJKOXwyGGx5ZP8muc60hxnU5CcTgtYUWQkI9Q>
    <xmx:P9xEZ2GXjV7lJu2lrHnpgGpG2qqp1hMYy1JJoYR2OZ9pSrpZ-CsfpA>
    <xmx:P9xEZ6Ve-l-meCpk82SDhcSmWrczBrqy1RidGaNUIeEGUTThFgcoPQ>
    <xmx:P9xEZ5MmpaWYHFcAmlvlHS26ONOXhjCG5neUs4du-apU8fFhI92SMg>
    <xmx:P9xEZ3i7ssUz1Lvk-el7MSs4iLpnwndV_xYkAbgObMaPtgFRjInoxTzw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3CD3C780068; Mon, 25 Nov 2024 15:21:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 21:20:57 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
Cc: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <9ab524df-bfe0-4c9a-a5e0-d07b955dbfe6@app.fastmail.com>
In-Reply-To: <7944f06f-33d9-4988-85ab-c1cf563615f3@app.fastmail.com>
References: <20240923110343.12388-1-algonell@gmail.com>
 <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
 <85ed3ec6-fa4e-4ab8-872f-6bd500b2bb66@app.fastmail.com>
 <CAPig+cSErj4ZB9bHB8mZfzNkiaN_EpjT6b4b=cfsf_+KMqytiA@mail.gmail.com>
 <7944f06f-33d9-4988-85ab-c1cf563615f3@app.fastmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024, at 21:13, Kristoffer Haugsbakk wrote:
> On Mon, Sep 23, 2024, at 21:05, Eric Sunshine wrote:
>> [...]
>>
>> An interdiff is just a plain diff. If you have branch (or tag) "v1"
>> which is the original version of a patch series, and "v2" which is the
>> reroll of the series, then interdiff is simply:
>>
>>     git diff v1 v2
>>
>> Thus, it shows the difference between the final state of the code at
>> v1 and the state at v2. Interdiffs are easy to read because they are
>> just diffs. However, because they are only showing differences in file
>> content, they don't show changes to commit messages or new or removed
>> or reordered patches in a series.
>>
>> A range-diff is a diff-of-diffs. It is very, very roughly similar to =
this:
>>
>>     git format-patch -o v1-patches <common-base>..v1
>>     git format-patch -o v2-patches <common-base>..v2
>>     some-diff-dir-command v1-patches v2-patches
>>
>> It shows the diff of the patches themselves, including changes to
>> commit messages and changes to changes, as well as inserted and
>> removed and reordered patches.
>>
>> Range-diffs tend to be a good deal more difficult to read (at least at
>> first) but help show the evolution of the _patch series_ itself
>> between versions, whereas interdiffs show only the evolution of the
>> _code_ between versions. As a reviewer, if you're primarily interested
>> in how the code evolved, then interdiffs are much more easily
>> digested, but most reviewers are also interested in the holistic
>> aspects of a patch series for which range-diffs are more helpful. I
>> periodically include both range-diff and interdiffs in my rerolls.
>
> Thanks for that.  I love when a good range-diff falls out of a
> reroll=E2=80=94and I love the tool=E2=80=94but of course that can=E2=80=
=99t be expected out of
> every reroll.

I guess I shouldn=E2=80=99t be surprised.  But interdiff turned out to b=
e really
useful.  Minor rerolls are really easy to read.  Such a pleasure to get
a quick sanity check before sending out a new round.

And then I also get to use range-diff at the same time=E2=80=94the cherr=
y on top.

--=20
Kristoffer Haugsbakk
