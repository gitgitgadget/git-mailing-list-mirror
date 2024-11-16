Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4ED79F5
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731769064; cv=none; b=m2k/DElvlCsMBii4rGeXFbDDPslMiAukEj6pJV+WpxFo1qc3JATB8J/5bUEWP6yOTwtr+MMIqPoDz+n37wbuRuEoTCJRfsXtITv0fzrZXW4M14Vy007CDdh8xqoi92JwEgaQjrJbIgITTk0YqVG5x9w0g+4l8qo54n8DnWVrlVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731769064; c=relaxed/simple;
	bh=EVJ01b1TpQ/CN8u6gxsvQnRxn0Vd3aZUwybUr3BEQec=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qDrR10h9NCv4EQOc4KyPuQRgo33OStw7309LxMG9i6iU2pCVqB/N1sBQvrx79XN69GGhCtt1qefsEr+0gHfL+2NUc+qNGPdnGr5uETzqDIoA1hOw/8NRaGmLM16rCG5m6rKHADcl7BQTjNoTBEur5t4c52RPV4iF7Lm6eIiyTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SbhFCVha; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMYIapDS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SbhFCVha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMYIapDS"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFA381140085;
	Sat, 16 Nov 2024 09:57:41 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 16 Nov 2024 09:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731769061;
	 x=1731855461; bh=CSfI6ClJdNY26C5u4gklxusQWqnrXunj5KHKz4icW9k=; b=
	SbhFCVhaLHMbZ6lCXkQ9lDrwzFjpON68q7rAKABNKsoQXzYZowESG+YozYctovIs
	yeE4lye/TVjQnuxHle8I66zdQqWF3jb1C3MyN32KqAZQY5/qipFkBofkeTcM9AhT
	ypFC/cd6CwkbWOY4NYFbE4roqDT4l4TM+ftScIYqKIF7nu49qfQ2vjJ3SM8K64Ks
	D/I+0wPcPrUI0N/a5FpUS2QKM7qFcmxkjquxZx8UU81yQ+GLPrqI6NiaqN3rmroO
	6rtCOvaCIm6ftkgnpAutFB5R1CzmD3PC86qnJgVIfIVxwAgxRBEKVViC5xGRarls
	Ji7fcM2GY9CNqeBPoQPdOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731769061; x=1731855461; bh=C
	SfI6ClJdNY26C5u4gklxusQWqnrXunj5KHKz4icW9k=; b=SMYIapDSfkwfr9q3k
	QET1JobAK6Ae6yZUIgwXh4jtv+3HjVQsMgLDXKmBvqT3ptt3G/1FJIvA9GvpkS1n
	FVRT+58ohi5bL9zMePZDQRoRXy2yMqlk94te4sTHdPYe2tne3Hlo6qWvIF3ZpGGI
	htskLesB7sDxzxID59lsC1JklcyNFoCG6Y7hzgDUSeP9a3L6Ih/8SbrEoGgWDp1E
	N9FmZxFdY/+u+cVsn+fur9nofLrVpDX1nRZbxiV14IG453BPYQ3KM6l+jicrrkmD
	gT9aqHk9gMeHOz5Iwp7OmwUy7Xhl2C4VKfOCVG3ed6puNgW2nK5iVkYbrWXuY4aQ
	dSgYQ==
X-ME-Sender: <xms:5bI4Zw-8jM7-j_sff4dN2rRBBfZd_3DeEuLCV0ifzlsEC3HTGQH-Poc>
    <xme:5bI4Z4uoqwpIWMbLsKwylXDISciIDvkGZxZPdo5tblqGQKshh09KjD3TMNbvuoT4m
    83D8jAbVjQXS6oQ_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeef
    jeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5bI4Z2D9B6Z24pnCmmv_MdgNk3cwfgD6-KB-rxRa88KMX3CeUHe-7w>
    <xmx:5bI4ZweObvjlyFyyqmVfW3fXwSJozHpMjwH9TFGsJGbw95h6SBakdg>
    <xmx:5bI4Z1OHZFfYPq35uTm4k7fJnGzQYjvIJu1IimfNRPM61zAAEkrg2g>
    <xmx:5bI4Z6nMzMKuRPhWZvQL3A7gxmZvEOpJ9MHXNFfNAqpDs551-4Eb2w>
    <xmx:5bI4Zz2z0KvFtmNdrhAZ1nkbF--sBopJtNqdVr-jURuZyDP9sZcNY1Yl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE475780068; Sat, 16 Nov 2024 09:57:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 Nov 2024 15:57:20 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <fa333343-1a09-4a0e-9624-feadf70adadd@app.fastmail.com>
In-Reply-To: <xmqqy11kys9z.fsf@gitster.g>
References: <xmqqy11kys9z.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Nov 2024, #06; Thu, 14)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024, at 00:46, Junio C Hamano wrote:
> * kh/bundle-docs (2024-11-08) 4 commits
>  - Documentation/git-bundle.txt: discuss na=C3=AFve backups
>  - Documentation/git-bundle.txt: mention --all in spec. refs
>  - Documentation/git-bundle.txt: remove old `--all` example
>  - Documentation/git-bundle.txt: mention full backup example
>
>  Documentation improvements to more prominently call out the use of
>  '--all' when creating bundles.
>
>  Will merge to 'next'?
>  source: <cover.1730979849.git.code@khaugsbakk.name>

I have sent out a new version.
