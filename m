Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D83C2E1EE0
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879068; cv=none; b=phrP305Jx5i8/yvcGnL7P1stwH36Ww9yW0M++Zl+LF9fP3y4gNjZ9jwHKU0EUR8X8A7JgbGWBBRDBg6aKIpuGR86r5q3FofvCwMzjl34GHQz+dCMxWJcDE3gNS05MSxJ34EMPLUXCbvIgciv9pVr2nKS8+f04Dbq41QJBLFH82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879068; c=relaxed/simple;
	bh=kH3BID21jDKGwHEwtv28J/1+/9eozT11ZboV+4zOz8k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Off663TY87dVnVBRDrM4noliS52CfxiTuWXXk1rwKc+05VUKr5+U732HTzM4mkINcF+l9HVgts9+/eZiCUCImXkllG/HCrMOauByG4K7WVjqgrX5BNFb7Bx83zzmvhywpB83Q5OyJkqPnK5b7v1lRMGly1LYBSUwT96xNpWZ/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=f1qCCz60; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aGYiOh9v; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="f1qCCz60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aGYiOh9v"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 55D211D00106;
	Sun, 14 Sep 2025 15:44:26 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 15:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757879066;
	 x=1757965466; bh=bc/Fj9Kj2OB7FJBdUKu9jz2TWS5NJ/3/gLptC8Wig2I=; b=
	f1qCCz60vdYpmiAwmypGIRPKXnlviRFQOcbipEgYD4K59HuzvswUHZVSE8NVpkrl
	hgFxnbPmsrf4O1vI4uz68s9XlpJdZdaX7Pt6652uMLJOoW13PzEqoykWY5yRIjHz
	Bsw9lTsyUQ3F2+S3AGAHTZvtMBhtSSRD5VHG0qiTWuyH2+2gtAHM/cXkyPRxXT3A
	CHYyaiTl03k82fijdMm6av24BiHcaWsys+xqBRclDzImfWsOJdqGz2uTAWh7aqxb
	1+jrgupjNskEVL8/gbiPi1Cnujcd7c2ntGaPTaWDEZXwl4eGf4PEl1trOIz5pow2
	ZC0VK1XO0UtklUPENqItMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757879066; x=
	1757965466; bh=bc/Fj9Kj2OB7FJBdUKu9jz2TWS5NJ/3/gLptC8Wig2I=; b=a
	GYiOh9v52cIEK0J2q/iCVPHPqFG5kdQbwIV4eXimiddeog/uUaLvIjosLK/DvopR
	i2PUKO2G4Wr9p8kfojusKG/ht6IAolA1aeD2QyDXKX+Bss6tsWw+5RTGlCcbvG1c
	dCFsMHU7Tera/aXevdnGxQM3pjPeRd/i81Wc9fOA0wh4qvYZGcguST2kfNmqZhlY
	5naaqHvDvktZzyxeMjXBdHJPIyJdohRJI/grPNCS8/HRaxH69DhFjRyZMFr8QcSB
	Biio6CRRBueL3G625la/xIZMFf55eRNDm7EVP+Y8rSWtoxf39xxyjcDsvaEk9LwM
	55W+E0gqiYebc1PBLP1VQ==
X-ME-Sender: <xms:GRvHaAF8Ghxev1YAgf2_OOYQXmBaOVBhB-TIaBBuYM-zerWQg_3dWE8>
    <xme:GRvHaJXOkTnZmheb9ldOXA5W6VVoQf34RMyDlQCbATtdx0z3AQsxStdw2tNJ1oFal
    QGenCwGIB8EaVJ56g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhvedvfefhjedu
    gfduffeuueelhfelhfdufeehueelveeuteevtdffueefjefhffenucffohhmrghinhepgh
    hithdqshgtmhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsghjohgvrhhnsggrshhtihgrnhesphhoshhtvghordguvgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GRvHaILjkpPWMf1aTa9OPgy4BLaW_In1yWfoj1ZrL5nZzDWupDOPMg>
    <xmx:GRvHaBEokC9FifVJMCaUcX9WIoOs0c3_AcTMhyUagxt2ZWgARB9Y6A>
    <xmx:GRvHaKpApA8nMN4ZSsxW0_UM62EU2o8RE1v4btS0H9AbZYMNvfXupw>
    <xmx:GRvHaCT3VB8o0_HqtCbNmOUjeippMWZChaDRiySLRBtcQvKtMw-HEw>
    <xmx:GhvHaEHGcMNudvdpuBlGwRS_QxVr7vyB4gyEBYv61tIy6HXvt6iBsj5E>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D11F81EA0068; Sun, 14 Sep 2025 15:44:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApBtbmhnwsVo
Date: Sun, 14 Sep 2025 21:44:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Bjoern Bastian" <bjoernbastian@posteo.de>
Cc: git@vger.kernel.org
Message-Id: <9bcd2f6e-8646-4b93-b2b2-fa1ccac5442b@app.fastmail.com>
In-Reply-To: <aMcYrG3XBZc9Yu_L@eismeer>
References: <aMa5kSQVlhVX7Iii@eismeer>
 <7897d2d0-5564-4514-ab3b-7310b626f4c3@app.fastmail.com>
 <aMbIqD4c5JY60fK1@eismeer>
 <8637f911-6887-41d5-b9af-cd2376376461@app.fastmail.com>
 <aMcYrG3XBZc9Yu_L@eismeer>
Subject: Re: Usage of git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025, at 21:34, Bjoern Bastian wrote:
> Hi Kristoffer,
>
>> You can also make a Git alias.
>>
>>     git config set --global alias.wh 'log --raw --no-merges'
>
> neat, thank you, I never noticed the Git aliases.  I'll do that.
>
>> > One can live without, but the statement "whatchanged is not even sh=
orter
>> > to type than log --raw." on https://git-scm.com/docs/git-whatchange=
d is
>> > a weak one
>>
>> I have a proposal to remove it.
>
> Makes sense to me.
>
>> > that misses obvious use cases of `whatchanged`.
>>
>> The thing with git-whatchanged is that it uses the same underlying
>> machinery as git-log.  So there=E2=80=99s nothing that git-whatchange=
d can do
>> that git-log cannot do.
>>
>> ... and I guess vice versa.  But historically git-log ended up as the
>> new-and-better replacement (according to the devs) with git-whatchang=
ed
>> being kept around for people who was used to typing it.
>
> Knowing Git aliases, there is actually no reason to keep `whatchanged`.
> Without the idea to enforce `--i-still-use-this` in the transition tim=
e,
> this would allow users to continue with their habits if they like to.

Sure, you can use something like that `wh` alias.

But note that you cannot make an alias like this named simply
`whatchanged` (the same name as the command):

    git config set --global alias.whatchanged 'log --raw --no-merges'

(in order to continue with the same habits exactly, verbatim)

Because you cannot currently make an alias that has the same name as a
command like this one.  But it looks like that restriction will be
lifted for deprecated commands in a future version.
