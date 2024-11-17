Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184D2AC17
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731848373; cv=none; b=elUuafoEkOAzch7xijR/7SlhZE0pao6CsdzfiQCFvAR+UOdqS/yV9Uvmmne32CwDJ8AQvK5AvnetkMGrCUe/GLShTfviG3o9BxBEqRMHHKq8vRrdz+ppVnjtpjD4aFS9p/M54suU0755CkNfJ+vLIxwhYROMMN3g7AWKbV2rt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731848373; c=relaxed/simple;
	bh=iBqq4rrww5M+AcXAE8C2AsDeFxLySYojiND2dlJShDA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ui97YV8OyNE6BfRRzoudzSz4Z4hbTBUJG0xNdABBe9IkvEudjaInFja1lOaQwhhnHxvZ3KYIvsOv4F2TEz7nmYR89JvgV1wdrUaXhNjaThwJRlmmGBy+XJu9RjlIixs0MYBWvEQviN/80G/4V4WSpOyTBr8BZfiEtgWXs3ffEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mWRYAhcW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FusN4jZf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mWRYAhcW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FusN4jZf"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C61A6138012D;
	Sun, 17 Nov 2024 07:59:29 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 17 Nov 2024 07:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731848369;
	 x=1731934769; bh=2HFpcveBTBoPPFsmi+1Iex1msphrmWnA4a6LAbqAE5Y=; b=
	mWRYAhcWWy3K2nF5dN/3NxpEjVIAX25i/nxlimG0UeVzXmUX4QTFJ/T/EOXjoM05
	Hl1b8ztWwXP+zaE65Z/+ftXalnBAyjolxXFiZYSq/jCa3T1AdjXvBrw7UGmYMs1W
	O6uV2Kep2pmN6GeftW6GOv8gRSJeTTvG3x0rAR2aF9S8EcUj0LToTSsEZmcqTQOZ
	QZLfSWTYETc/YlgnZtyI2irsZb5Fk2Yt3g9iNVYXh8bZPtIEI2pghB8ZwG+0XBND
	AMyfpsV3DbNPlzSd4r4R+5hzH45cfMDE6tZqjDS/uQg+vgge3RovRKZY2WxtTgvz
	k8oxi/HW3/DcwP+gN8tq+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731848369; x=
	1731934769; bh=2HFpcveBTBoPPFsmi+1Iex1msphrmWnA4a6LAbqAE5Y=; b=F
	usN4jZfSz8sNWL7XUKGPHwnQB9shmX+1UISJNl3AoaqXMi8zuuRr9lxReOHw37mZ
	j+XXSZHBIu8kasNKSmyDo2jevrJLvLvRfVNyZS9pTb7mn0utLHpc26CCYbrKlcjp
	0XkyV6KWH9ln5TCyGNc1qlzG5adVfxIsUZBwI+HBDnfOhF4zQVBwNaPfhINdt868
	3kHeeYWEh9j43lol5XEBUPewfff16h04WyU6xjBgCwjl9nM1/DiUSvsfDxcQF9Y1
	jgol3HFkMk4G/+SgBGIVZ9q2NYLJCj+i6t/BcafVCgfhuuAwS8MSO4D0DaaHC/k1
	a6lUFIwkkNYm0cwoH+IFQ==
X-ME-Sender: <xms:seg5Zy6Mfpuw4t8wvm1hy7etBoa5Gb4M87wh-FHioVPb8Kf30je_yxg>
    <xme:seg5Z74fMU0QjVWVsffXp2G84C5HhxjmAe7fydJwyUmB9NhxlsD6jghAEr9JwubRa
    sNQRc0A6nk2k0pBDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdekgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetff
    ejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishdr
    thhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhopegrpggsuhhghhhunhhtvghrse
    hprhhothhonhdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:seg5ZxeQ9_4cOTy5sOW21X27mtD9UaVqck_iF6a3eyDcTARtAZvpnA>
    <xmx:seg5Z_Jv9AbILG5ZGh5JrMgL6iu65rhJXkPH53syPiHRhOLDAtG3XA>
    <xmx:seg5Z2LaAt6y0A_0B-qegCFp0WI6GTGtAAXtkIDvByEkRRjLzFFDdg>
    <xmx:seg5ZwykqeakdVzmjBxUwPBInArAZu6xGLt8SAugl_SBn3yGUW0sPw>
    <xmx:seg5Z9UR9o5Ad-0GaGUfzW-inJf2tBcF0tljlmrG8HY06qEYFJOlZv2f>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8925C780068; Sun, 17 Nov 2024 07:59:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Nov 2024 13:59:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "A bughunter" <A_bughunter@proton.me>,
 "Chris Torek" <chris.torek@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <cb5090a3-59a8-44eb-ba68-3a8fac58c45e@app.fastmail.com>
In-Reply-To: 
 <82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me>
References: 
 <myxdTw4K7jcrlKX-HC0edNKB3mgkjGJPAejkxWTcab03uT9uROZlO28zjhmnogOvGCJkag5q_Zvbok0VUyVjlkw5Goz3Gwe3l636lCYnGic=@proton.me>
 <CAPx1GvfT1iNnpJ0Jv0vhdHrwD-pDOK81MnUW2-Fk_zcJkW9PUQ@mail.gmail.com>
 <82f3cj_ASv_HNkdAe-1doxp6Vii0saBTB2wYbcwCEC3vDJpiwXvN6a6Agw7qNhKsGpBD8EbDC2u4VipTDJNr19nYcVV4BqV4GgNG9ysr5y4=@proton.me>
Subject: Re: What is the diff between a --soft and a blank reset
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 17, 2024, at 09:54, A bughunter wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> My reply to Chris.
>
> On Sunday, November 17th, 2024 at 02:57, Chris Torek 
> <chris.torek@gmail.com> wrote:
>
>> * With `--mixed`, `git reset` adjusts `HEAD` as before --
>> it's usually wisest to not have it adjust anything for
>> this case, in my opinion -- and then goes on to copy the
>> files from the `HEAD` commit into the index. 
>
> I didn't give any case: What are you talking about? It look's as though 
> you are pasting a custom manpage for git-reset based on keyword 
> matching. Essentially spamming the mailing list based on a keyword 
> match. Yet another manpage being written by a thirdparty when having 
> conflicting and scattered jargon makes it to where the user cannot 
> communicate in a meaningful way about using the software. You vaguely 
> show the difference (e.g. soft means job #1 and mixed means job #1 & 
> #2) however not fully answering my pinpointed question "Does this from 
> --soft: "leaves all your changed files "Changes to be committed", as  
> git status would put it.'" mean soft leaves the adds indexed but before 
> the adds were commit and without commit whereas --mixed would erase the 
> index having adds ready to commit?" conscerning what the difference 
> means in pragma. We and you need to learn English or get off of mailing 
> lists: stop spamming. I say we because you are not alone.

Do you happen to use a translation program to write these emails? 

-- 
Kristoffer Haugsbakk
