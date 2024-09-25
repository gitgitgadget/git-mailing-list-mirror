Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94381AD2
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278193; cv=none; b=QZfFlhS7g+e4QnWmNH4h50AfLcFFwUCl2geWQbDnblF2XdE88jx99SRMIO9W8YnUFnCBwGKYDaOGRq3K5IUXKjxMfezdCTSiljITlc62lsUTZV3Y6DO/mI9r5YGAMoItGsuqCEm2VusQrNOsnWu3sePya4j20qQnxcEC4N6sKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278193; c=relaxed/simple;
	bh=lCyjYvPuiHwdtByw3v/8xjbA5Cyr9lrYIMJrqlB6fGg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DW0J1T7YX9Nb5eosg7QJSqSuVAFe59wGTGdx0vtHrcwNZ6YxgrFg078n4LOpp0DNbIKXe4E/K05oItmBAXGNalsaQn4OnmcP31JteoMdjSV4B+HarYw/+mWVhfCchiAfkgRoueN3a3x5N0U6LHbCvdQixsNS6ahDcvezzZcK9eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=tYoBWeOn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nbsWJTOl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="tYoBWeOn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbsWJTOl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A88FE1140259;
	Wed, 25 Sep 2024 11:29:50 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 25 Sep 2024 11:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727278190;
	 x=1727364590; bh=h2jpAKnZ2J424lX0SHSv9oiwRPBKnZAjAv6c8wdfqAQ=; b=
	tYoBWeOnsjSRSTcbCqkVjptW4EZ1lmg+QoEDpskZIqs2vIZgVBbDOiIgN9Z2Kc0l
	N3GJbwk4Sfsl5G4Gg4Qputm46EuTnNpditr2VLurk2+UyO/v7wyFIv7ehsOmKPDc
	qrkbgou6P4CTlbxhj011ZhtCfxPNNx/yqDWHx+GeHeiprTNqVPhVU76/7Q+N32mH
	leqfrSFN39AaTvdiB27di1T5q3g60Me4XCPaM7Z/2ZANeXuv8pZM7Krn0+Y74Msq
	LvUjUegnvzc4ba10+V+XvKhiKIIvIjfEI6Plt+5tfuVA4VQVn3y5meloK3xEOunq
	vF+X/8s48R0hDQuVtS9WuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727278190; x=
	1727364590; bh=h2jpAKnZ2J424lX0SHSv9oiwRPBKnZAjAv6c8wdfqAQ=; b=n
	bsWJTOla46tHSDczILq/BCbBLZ4+CzaKAg6syPa+VDtCfV828y7ubrhRQGUvF005
	krIX1nU4vP5hfC0xAVUVmeCPhx1PCHshg5HIOWUd38gkoegEka1RG139qGXXLmdD
	EYQVxa5aecKDASEaIo+/OmGwwh9oN9P7U6aNrBLMhKsWIvvGrHxdMbZE0uGmjJlp
	x74Zx0tnU7e248kPIGV6zZvHrYIC4q3eCyzeQWrMCaGtQvexIYVqWnWaKS5MKA7M
	Ik19Mf7BlTEx6naBi36pGiO4Er92bMQvl5aoI+2UE0jsndMdScSQej5V//f87aVt
	IJvJUJlyaMgUudeFGD8Jg==
X-ME-Sender: <xms:biz0ZrYf4OZLCZ9ySQwrnOV2W2eA3ZzYTOiql52gAnylgptXFm3ZIQg>
    <xme:biz0ZqYgqQH33BJdhUDCyTE6k6i911GDHigenCILOiLYMkZFFDDhrfkeLqg-rJJHl
    7NdPd7fo7t6k7GdUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddthedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeej
    keelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepihhshhgthhhishdvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:biz0Zt9iwKyEDDnnhgJJbP7CSw66-sjMbA98NGMr6mi__xtAduoxgw>
    <xmx:biz0ZhrfNTNzlmW9KjLYfxqepNj583mP7_HL8ol8X1kBawg40K9WFw>
    <xmx:biz0ZmoenagQIdnZKRNzlNIWvxVigOEKASfd6hBfni-kamgTljtwIg>
    <xmx:biz0ZnTL12ramrL8D7PJQc0eMraVWOoCjMngNN7FMCZsZJZoyrlHbA>
    <xmx:biz0ZrDzm4_0k19yhd8cBaTG1x8Yxipn-jp6yqtLTPWLSOzYFU6ZnLpT>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 66DCD780068; Wed, 25 Sep 2024 11:29:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Sep 2024 17:29:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Stephen P. Smith" <ishchis2@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <6b69af87-9002-46a7-a5f3-3fa1fb7ba9df@app.fastmail.com>
In-Reply-To: <20240925122515.14015-1-ishchis2@gmail.com>
References: <20240925122515.14015-1-ishchis2@gmail.com>
Subject: Re: Can a note be pushed to origin?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Sep 25, 2024, at 14:25, Stephen P. Smith wrote:
> In a project that I am working on, some metadata is currently embedded=
 in some
> source files.  The question was asked yesterday if there is a way to m=
ove that
> metadata a git specific file and link it to the source file or commit.
>
> I remembered that git has notes which can be used to add such data to a
> commit, but I don't believe that such metadata gets pushed to origin n=
or
> fetched from origin but another user.
>
> Is there a currently implemented way to do something like this?

You have to do it manually.

In `.git/config`:

```
[remote "origin"]
	url =3D <url>
        [=E2=80=A6]
	fetch =3D refs/notes/commits:refs/notes/commits
```

That fetches the default Notes ref on `git fetch origin`.

That will refuse to update if your own notes ever diverge from the
remote.  If you want to always overwrite your local notes with the
remote ones:

```
[remote "origin"]
	url =3D <url>
        [=E2=80=A6]
	fetch =3D +refs/notes/commits:refs/notes/commits
```

But then you should also enable reflog updates for all refs:

```
git config set --global core.logAllRefUpdates always
```

In case you do a fetch that you want to undo.

--=20
Kristoffer Haugsbakk

