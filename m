Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAF193409
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729545950; cv=none; b=OhanC684VMp8Zd2OUG13f527yeLY/wVCdXl6bBgg3aeznN1Hxc33yhEQEA430bdV8XEHDLsy7uMSNYRT1cWMmn9hY9As5Hu/43p9uvaVEw2TqyB1Nc0K9n6e/QnpZCflWBqH1EJwwqiXL5u2bVxkFOqP3ygzixGEUW3hf9T1EBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729545950; c=relaxed/simple;
	bh=HBdr+DRIC9oF98jaQk9s6yb4ZG7zhxkRPyJzlOpflKc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kujRrAoL/2LA2MTYqPvBgrQMh4Ytp2Gym9asuEAQ4yPf7tsZ8qQuxA08Cr6HhTsN+k56WCX/gfLsAVEh2ExOWKwIIyzqXFMOrbfB9Gj8TQv7HqljWZ9buCveKpK1G71bBtfL4cWK/TFuu2H9MZtBBsX9qG8lScALWAKdmkdrCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kcT+V0fc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZ9R2CLQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kcT+V0fc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZ9R2CLQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C738D13805F2;
	Mon, 21 Oct 2024 17:25:47 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 17:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729545947;
	 x=1729632347; bh=DmPLMuv+qF0T1AJdyiB1A2tviv4DWnfamNcOW5LrVBE=; b=
	kcT+V0fcp1sC4VEgjaGO0MJpk6MwvHjYWbznxAlzjpJ/l6awBW8sBimcrsHyiia8
	aQvzuDjYeWt7liTAewilnWzjdQjrbsz7YOW3Qfscnqpv0MteySWVZ6K/Ysp30dYF
	JVdYxKOz4oMxZqMsjz1XcgcLmgUXgsDO2VhWCB0+yXgPaN7zo1KO/xkcX6mp0vsL
	wANsdV7PWbmXbkDEdyTkyKJ9FQGS3Gh+miOwrzR4N17UymbwgaCNGsjiXeo22VCc
	gyr/1i0+yVb9y00hvJNXySw79w/pZLZGW17MsraU3y6rB33fhtjRxVBbKs4r5Nv1
	sgF7S8osikSfkTrrgNWtYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729545947; x=
	1729632347; bh=DmPLMuv+qF0T1AJdyiB1A2tviv4DWnfamNcOW5LrVBE=; b=U
	Z9R2CLQkjxBfQWcogZcOwTDR1Jiy7jFuf/YW7OlzH70VLi4V1BaRaxYWmQtfaY5Z
	v2loALfj5BRaB5B2DTlu9Uf9w8AZQLY08gkotkRvgdJ8oQjjlg98WMH1PlyH6SJk
	EGrt4sP1gABrZoj0srHu7quPBzd9JhQCcIrfMk4VzTpy3z2I0pAqB4RIT0g8P51R
	NpHP/XspRbylyU9kPgYxghJ+C9Y9GFkAU2wL2f2RFmeK382uwtQvgna+kDiLK1c9
	50qtGxQMfnmJV7i/FL3ZL8/N2mrNITlN8mKgboTgCzvx2ykuUU9oAmaMwE+8bNJj
	LpDGNBmMg02TtDc1rMfQg==
X-ME-Sender: <xms:28YWZ5w9aMjoeU-p6tHWlbBTr3WLkNy48H_Etgux2imkGnVQgtKq3Ew>
    <xme:28YWZ5R_glfgL3WfZrH7tE7lh0EEGI-Q0C7h9R_OzzSpAyto79yIolm1Z9zrXvkbX
    4Wovxt0-ni5odxjXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepughsihhmihgtsehmrghnjh
    grrhhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:28YWZzWi_2xa_GP_-I2UVTFA9nipYE936W2uMH6FBc4kmkA--5n3Ow>
    <xmx:28YWZ7gaU9iqfu9t53edY6bXIJVUO2Tpp3a1G9Oyp9ljTZAMU-IlYw>
    <xmx:28YWZ7B0RzOH1Ep9On_H2mw5uyIcIocNtZt8sORGWPYOXuo9adrBtQ>
    <xmx:28YWZ0Jrabu0X2B0mSW-ScRZWjjAvdKhKypl4CARCpwK7zBGIcay3A>
    <xmx:28YWZ2-LU3zopeeSUY5Zz4UT0N7A8dEmvd4uPVrX7y5Y0NBY9le5k5A2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 43A04780068; Mon, 21 Oct 2024 17:25:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 23:25:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Junio C Hamano" <gitster@pobox.com>, "Dragan Simic" <dsimic@manjaro.org>
Message-Id: <1f3b62bb-7c3a-4bac-8995-8df417228ed2@app.fastmail.com>
In-Reply-To: <ZxbF2xxqh3rTgXvN@nand.local>
References: 
 <ce1b5ae24ed8356b9beed340fff61e96f7c1d549.1708259215.git.code@khaugsbakk.name>
 <29d71db280c972c91174bd0a501af66be72643af.1729462326.git.code@khaugsbakk.name>
 <ZxbF2xxqh3rTgXvN@nand.local>
Subject: Re: [PATCH v2] t7001: add failure test which triggers assertion
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 23:21, Taylor Blau wrote:
> On Mon, Oct 21, 2024 at 12:14:46AM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> git-mv(1) gets very confused:
>>
>>     git: builtin/mv.c:506: cmd_mv: Assertion `pos >=3D 0' failed.
>>     Aborted (core dumped)
>>     test_must_fail: died by signal 6: git mv a/a.txt a b
>>     fatal: Unable to create '<path>.git/index.lock': File exists.
>>
>>     Another git process seems to be running in this repository, e.g.
>>     an editor opened by 'git commit'. Please make sure all processes
>>     are terminated then try again. If it still fails, a git process
>>     may have crashed in this repository earlier:
>>     remove the file manually to continue.
>
> There was some good analysis of what the problem was in the earlier
> parts of this thread. I think it is probably worth capturing some of
> those here, too.

I will try to incorporate Junio=E2=80=99s analysis into the commit messa=
ge
tomorrow.  :)

>> +test_expect_failure 'nonsense mv triggers assertion failure at built=
in/mv.c:502' '
>
> Do we want to be so specific about the line number that the assertion
> failure occurs on? The actual coredump triggered by this test will tell
> us that information. But in the meantime this line is likely to go sta=
le
> as builtin/mv.c changes over time.

You=E2=80=99re right, it=E2=80=99s overly specific/volatile.

Thanks

--=20
Kristoffer Haugsbakk

