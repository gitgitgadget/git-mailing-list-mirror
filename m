Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB833D091A
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008895; cv=none; b=ngdkYrA8ZLQSdOlCsYwud6r1obTgoolReNJPJ8gZcomTq2y9yexGrphI53TjpptVcKwIedFBswEwKirL69047pptO+PhHXKjqCMXwsZ3iWOBQqDl91mR+A1dhj/rAT+HLS8mK/1aNSD1Ll0NEs5pzjGgt1cZlVPX+oLtZvqNHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008895; c=relaxed/simple;
	bh=SCpL1FUDk/BP/pmh+9BODHqJhcVN3qL47F75VDg8XZ8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lMbP5ALvhB5e8/7Hh8NPA87lF6E35qGWndJyD/j1v6KqWqPdZxakK2BR//10bkdBxH4m0rRsI3ayGxG8w8rA1HF3d9btNWO0zrg5x1eI16PKQSxPor1xAxvZ69tBQz6GasQp0+YcbnLWfCH3niW09ny8WHDLuvSLnnsUXyBQ3sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EMQR/IDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+PGK0x7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EMQR/IDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+PGK0x7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07337140003E;
	Tue,  5 May 2026 15:21:33 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Tue, 05 May 2026 15:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778008893;
	 x=1778095293; bh=p2Ddvqzy4nuDEla8s/fo+6yC8ZgyGILfSrN6dlCTZE0=; b=
	EMQR/IDzea+BB1ajiOs5sx1flZb0kkDOVM8fu5LdkOrmpdgklIZihTcqvJ5A0pLI
	GlivIAJtSvXVGWTH9Tjp9B5ABTRDmG+4V7vMZZMZqyB/RPEAyMZJ1Xr4E7GsgFIc
	3ofoG6UCp/gs2hhXfvIi6bT94laELw5MsCd3cIIKY37J59hqyUWpEwLtA5N52fPn
	TiB2cJXnzkTv32Fkwzv4bw6X8WDsNpClQadfTqfgOPCP0S9FyVOVGRvyAuxj5EJd
	8ViUNZVpCgOlTEF0PQ07thQ2MQUDZx5N62861lZPRPYscyUz93hi3WRvXbJQlrT6
	Gw9l79PyNpreUnJXssvV6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778008893; x=
	1778095293; bh=p2Ddvqzy4nuDEla8s/fo+6yC8ZgyGILfSrN6dlCTZE0=; b=W
	+PGK0x7Z4BbFb/wiA9RBs/OtjDCJOJ2+g6DhjnrLW8R4GqTbQKHTFyKXgm4ZCGUd
	/bfF5WGvyVr4XVHZ2JXkxVelu8rSzXx3dpMAC5PcUo1vbtLXRIZQUOqzYLS9yIla
	fXnofl5JN4bIy3H2dP6g7W02cJbuQVoeEhPurR+fS+nslBv8HO5IAWMhGiX11MIJ
	2+okC9024esFoX9K8XbkseRGyMVSTTYDJoFhCVZHzrxBmj9B6tc1NQuMPHT/SbHf
	w1ZH6OEalLiAcD1my/x8InaRIOunG7/FKPMT2n8CVtjoFRYm5mfs+QCrs9sz8uMG
	zNuEJQBxlH2lixD3nrpcQ==
X-ME-Sender: <xms:PEP6aVivqE0Vw0uEWUnx96DI5nGJpybhTAyFeB9tCS6JZjVJUwYCjus>
    <xme:PEP6aU2MCm8Af5aMA0jfjpVCDeZuxZH2SMJzxZ3DySehYOytkJp9MR6_Dh6VJ1KTd
    zJZNsvyaJu98s7eWQit-rjSrsD99HdgcnQ6aa9RAWJv4RTv8C_Duw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PEP6aTL4DyeExL62uqdGKIBKUleX7kuOLrlVYwyywSHtyIStCG2NtA>
    <xmx:PEP6aSnnd3OzZaBsliV420nzlHg8nZf-ISjgBtMzEkQGt0C_z4ZedQ>
    <xmx:PEP6afNVcxPOKy2xXnR7yYeySZ7Gpnzm7fPxFEqAjrLRrHz7m6CobA>
    <xmx:PEP6aQ3RhPj5oUrWQNQDOUyTyUY8cOOh9WNwfrftv766oMVFU3sKyA>
    <xmx:PUP6aaETfOLgXcudFTkJPQg0-cCTaN9dm-V9AgzvpywWHUpvvcWXs4n8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 51BC0C4006E; Tue,  5 May 2026 15:21:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ah0tHUlKqK8-
Date: Tue, 05 May 2026 21:21:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <a0712ecf-5daf-4932-acde-1a4983d2d56c@app.fastmail.com>
In-Reply-To: <65e013cd-5bca-4340-8018-bcbb44371e4f@gmail.com>
References: <8016697f-9eb7-4c75-be87-d9479186919c@gmail.com>
 <20260501172450.25037-2-kristofferhaugsbakk@fastmail.com>
 <65e013cd-5bca-4340-8018-bcbb44371e4f@gmail.com>
Subject: Re: [PATCH v3 3/5] name-rev: factor code for sharing with a new command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026, at 12:00, Phillip Wood wrote:
>>>[snip]
>>
>> Yeah, I didn=E2=80=99t want to repeat that bookkeeping but in some it=
eration it
>> looked necessary. But it=E2=80=99s good that it isn=E2=80=99t.
>
> It looks like the printing code is shared between the two case blocks =
in
> patch 5 as well so we should move that outside them as well and just s=
et
> "name" inside the switch statement.

They=E2=80=99re not shared. Both commands work the same: either the obje=
ct name
is consumed and replaced or it is written out as-is, in other words when
commit lookup fails. But somehow the name-rev path prints that *failure
to look up* case before continuing here (I don=E2=80=99t know how):

    if (!name)
        continue;

Because the printf(3) only prints when a symbolic name was found. Either
name-only:

    <symbolic name>

Or not name-only:

    <object name> (<symbolic name>)

On the other hand format-rev uses those two print statements to output
either the name lookup case or the lookup failure case.

>>>[snip]
>>
>> They looked the same to me. So I will need to think about this some
>> more. Just a lack of C experience on my part.
>>
>> Replacing the `continue` with a goto at the start of the loop was also
>> unnecessary. Of course the `continue` breaks out of the loop and not =
the
>> switch-block (unlike `break`).
>>
>> But I didn=E2=80=99t break `t6120-describe.sh`. So I=E2=80=99ll also =
take a look to see
>> if there are any holes.
>
> I think the difference only matters in pathological cases as "goto
> start" means we end up looking at the same character twice but the loop
> carries on as normal after that. We should just keep using "continue",
> I'm not sure we need a new test case.

Yeah, I have gone back to the sensible `continue`. Thanks.

(To be honest I tried to provoke a parsing bug here but I was unable
to. Somewhat annoying.)
