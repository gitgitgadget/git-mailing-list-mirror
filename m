Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD65D256C9E
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531677; cv=none; b=PoNWT/8nPU/Kld8BcsCMI6wvc/lPIC6RXjpJixl9mCDYWNlr3zd2vgoKbY4vBzDUMoXP+1v3L+U67TwIql8pH6bQ275YB1eQ7WHU9ClI2qX3Lk3AT59F+YjAedzBZ4Yxdp6tRcRcCSKr07PQvUZ+qlzZlnpQlEEZ+2Lk88gQmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531677; c=relaxed/simple;
	bh=+9fLvA1yf9sBcjylH4SfcMcI0CAxr3MEs4/uLqo/AEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=leRCb9l3CU6QNi5b+9MKAz7qKIW8JcKqTUsI/3eauKcH2CvgpR2zq44NagY8wAnCjf5Hdi8zlwxd1HFT4s5C9E7VA96IhtG3qEetDE99XbRsuudrIDw2LkPvJgfvycMblsyLsUf2Jb5I0/eamQZrIk+WRhrtx+hnrTEAMiH287Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MZ/A4hZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3LBaDo+1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MZ/A4hZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3LBaDo+1"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D11167A016A;
	Fri,  7 Nov 2025 11:07:54 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 07 Nov 2025 11:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762531674;
	 x=1762618074; bh=L+hYmLyGJd4Q0EMzA1XvLHlRM2K0eFwlG1svIzZ19qM=; b=
	MZ/A4hZEQdQGS6/2qHelb+Lm1o2/PcEexy5dD7Oy8bwAG3nBCW7kW5CC0vXL1xA8
	cBhTZzRe1MrD28eLpOSd1lbUGNfndam60eG0k6NHUrZ7063UZ/rWhBx8KxSIRwVo
	q3p7cdLDIwnATrQ9jLgexqlu359egqwRbaNb3tNSQB5A0mEvKcpr+l3duAnkxm39
	D9X3/X0PCnmNcn5qf5Y8as+AM4y2d/2hQHBvzgWHgdng1FNdoE+Hx+8JTOecTy6C
	mxoBlJO8G7u1fcX4dJ9ZoWTs50O7zIP2kA0S7kQvTxVp7qwgTH0smUt0GuQ0GV81
	87ZIpseO7z8oJPRO6XyOBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762531674; x=
	1762618074; bh=L+hYmLyGJd4Q0EMzA1XvLHlRM2K0eFwlG1svIzZ19qM=; b=3
	LBaDo+1CmAmsOD5j2MGCooi4O1eFOBPr1uE3JvUXoOlEPsc6SbaO04ruDY7NBLm9
	5F9FBBPkXGVSw0NS16Jtj2LMM1tVx3gtzFXDoNqSH0d8afPzBRsqm0wRKyl92enW
	rvjLZj3nIy4slnu9nY4ilIJf/8kPZyq35o/H1jKgy7X4JJKXrd2fzLS8KBfyrizY
	urFVJLK53EIRJH0xZ3ptv2fCVfPFJg7BI0o6BoEBYNeOhDcbuUApyK5/OzdTTofA
	S28dwyNM36x0vqIb9Y3dAIH7s/2myErPVnlfqSIKm/QAzbOu6KmJbjOJjtLfZIwj
	eNFse38fTZ/dapP+UNQFA==
X-ME-Sender: <xms:WhkOadbE2gZSM0_7NExj3tJMMKaIjuaxQCOUjdiZzz1YtrsZon2Mdw>
    <xme:WhkOabT5cpzfog6dpppmDaIb7xno8PppzddGfSzO7fgpNeb3ECD7F-RB6kCpcjGT-
    vpv5JlKGeC7Qxpm8jPrj6mgJUJkAHQsCsvp3UkeUdVzu16QpFMOFwc>
X-ME-Received: <xmr:WhkOaYScTtbbqQAUIyaplp1GNBAXx36Dfzt8shsjrK4JMuvMjpCPfjRNOcs_Zpk4t_uS4-wgIk4SBBecwoEXEdjyNQ_J13IRhloI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WhkOaXRmaCeKQLy2G6orGrUHzCQ_KqDRcWyYB0kDvtmRzBsRbGwrpw>
    <xmx:WhkOaV6UhdNd7bxYXvDm4wrCq6Jk5cbeJXKZF0HxY7JesbwLT2XzEw>
    <xmx:WhkOab350GGGOHdCPVZFaidPDxRWkbYLfn4Nk70L1CJbI6ggwKQblQ>
    <xmx:WhkOaYBrz9y7nY2Am_HQm9Q6Fxpq8freLdKFoUSihTAyEUDh2OCGSw>
    <xmx:WhkOaSuBY-Gup5we5laFYKQEu2jhIyzaNAQl-oURgy26cVu9Ftf7nn23>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 11:07:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
In-Reply-To: <20251107083015.GA18670@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Fri, 7 Nov 2025 09:30:15 +0100")
References: <20251104021455.379807-1-jltobler@gmail.com>
	<xmqqa512sfcj.fsf@gitster.g> <xmqqzf92quen.fsf@gitster.g>
	<nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
	<xmqqtsz8nbwv.fsf@gitster.g>
	<z5mkdl67vx47na5critwtyz7cacvhs6iixy46ia3svdoq7xui5@ckpfnjw3dkoq>
	<20251107083015.GA18670@tb-raspi4>
Date: Fri, 07 Nov 2025 08:07:52 -0800
Message-ID: <xmqq7bw1hllz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> git ls-files --eol option someone (Junio ?) convinced my to
> use a TAB as a seperator.
> In this case just before the filename:
>
> git ls-file --eol | xxd 
> 00000000: 692f 6c66 2020 2020 772f 6c66 2020 2020  i/lf    w/lf    
> 00000010: 6174 7472 2f20 2020 2020 2020 2020 2020  attr/           
> 00000020: 2020 2020 2020 092e 6369 7272 7573 2e79        ..cirrus.y
>                          ^^
> 00000030: 6d6c 0a                                   ml.
>
> This makes the output both human readable and machine parsable:
> All info is before the TAB here. (And may be parsed again in a second
> round, if needed).
> Thoughts ?

This brings up another interesting question: which command should
learn these new classifications.

The original desire "when I diff A and B, I cannot tell which one of
A or B had binary when I see 'binary file differs'" almost suggests
to me that 'diff' is a wrong place and rather they wanted to know "I
have A; now who is binary in there?"  Or "when I diff A and B with
pathspec P, I cannot tell..." is probably a wrong question to ask,
and the question may be "I have A; now who is binary in that tree
within pathspec P?"

IOW, "git show" or "git log", when showing a commit C in the
history, would give "that one is a binary" information as if it is
an attribute of the change between commit C and its parents, if you
tuck this new logic into the "diff" machinery.  I am not sure if
that is what we really want.  If we do so in "ls-tree" and allow
"git log" to show characteristics of each tree it encounters while
traversing the history, on the other hand, "that one is a binary"
would truly become an attribute of an entry in a tree, and it is not
affected by what is in the trees of the commits that are adjacent to
the commit in the history.
