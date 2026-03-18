Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847B2ED860
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861391; cv=none; b=kAi2EDC8STiTa8Uv3/iZTcbZi+NKZIP0EckFR45V95JC+Pa4cBSXaEInvayGDcMUOE9o75VOC5DbYn9/V8gmQyZ1yNLCEDhPBcN9JNK9jt2YKpH4CNqqyWZw9WYf3zfJmRaEGfxbCoqnPLEzhw93f98KjGfnP3mOFoHuyjnJosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861391; c=relaxed/simple;
	bh=dTzzPCgCfhJYK+rsh8oD4ngdLz4mmbfXRxHsjf7jLdQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NSTzMG4S9MDKkSzAki0XMfYruUq2buTz7B/VfNmLPowWaVUVW5jdYVyb6K7lpXfrlxVl8rmOUdjG2YRT2AooeMlttnxDXHX8Df64k8+24WCLeIaLllLygE4ZN/pmEL2sJ0QHsTaeVh7x2ZEW/x5StVaDdksZbK2eWuHVHooPV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk; spf=none smtp.mailfrom=git.strova.dk; dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b=kz/qxvs3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3kAmNtgR; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b="kz/qxvs3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3kAmNtgR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 043337A0038;
	Wed, 18 Mar 2026 15:16:27 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Wed, 18 Mar 2026 15:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=strova.dk; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773861387;
	 x=1773947787; bh=TImljnVj3eg4dnuyYgzWtEl1Ldf6oNe3VOB3wuHZcKo=; b=
	kz/qxvs3ECIU05fhABX+Dc/YahxN+wg6aW3+Ayn3m6lMznYxNpJKSWzYEUITmBjS
	+8iKBYZ1Iedq1znzhaNS1Xp19DP+YuykgWg/cbp0hbgERoJNDst1Dit+uY84GlYj
	jg+lgFdezkjk9I/yONGMwaypqIKBEppeuh6Qh5BSD7adiU9gnawg8d2VUNngxQXQ
	8/pTPwGLhkz72CJLyNch6DzpbKXW7fKrUzXCDxwE4JntX9cqNnx1+BBWB/5xhi9D
	yT7X3jH5PrxGIx74pjLwsraqN924HLaGdYSgxVVeX7so2qL7ogR+LYtx+f2/Jc5n
	6bXgx4tAVSq00ulQd1Ou9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773861387; x=
	1773947787; bh=TImljnVj3eg4dnuyYgzWtEl1Ldf6oNe3VOB3wuHZcKo=; b=3
	kAmNtgRHbpWpn3Af/w1Iw77EYbnAErbLk6buyld/JrEu4Wou1JXovZkq/z8cl5Qv
	g/dGDCD+WUP+uYeZ1tCmYkqZJf96+43pokJrrQrRFMN+gre64N9MmqeG8r5I9DNN
	mlKniqSbZisbOUz49FP6wKikh/vzPf7ZQ0cJPtwYxZ9OCbsN9Hn5LZAS5fN6EDhq
	xJ/PUcW8yADnHEQPAT0pDUA2CdZUSHNYK2PjfUTatRxWOgkeb3L+4mjddhW194Vp
	XJobxd6P+LFZV1/mOaOkAlvMfH17ZUW+U7zDfjlBX8A2xCUpJXG0BUt/H7EVMksr
	nJEF87juqSJneTgyB/32g==
X-ME-Sender: <xms:Cvq6aRzU0_dpASMhFM6Mvwafoj8VZjF_j40EFaHpjIYQPQEx3beVmg>
    <xme:Cvq6acFLIYPENqL7xbruKqr4DTJDIqtcmQQEz5ZQEOcpbOOPAAoWLINdrFAgyknmw
    fW5xOWQolwC7eRkVbFRPJCO7HEvmlx74FGinmQ1kOn79rQIXLHGfOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrthhh
    ihgrshcutfgrvhdfuceomhesghhithdrshhtrhhovhgrrdgukheqnecuggftrfgrthhtvg
    hrnhepffeggedtgfehheefieejfeduhfejgeefuefghfevgeeftdehleeitddvgfefhfdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesgh
    hithdrshhtrhhovhgrrdgukhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Cvq6aXAt4j9gEznnHFBmOsfE82uVEQ6K4sU20l-9GXJngjQni2-2UA>
    <xmx:Cvq6ad-uAX1uWokQQUlgVPAbpQEA8iDd9Vcnm9XOWdNqauu_kjwq4w>
    <xmx:Cvq6aTTLbh0_A8xtqhqqFdL_yaN7YPjWG0sXQ6CYifCIA6J5opoR1w>
    <xmx:Cvq6aRUkefYC6VU2nGPrgA04RumTsGkKj-tDh05jn2EKDju6wElSqw>
    <xmx:C_q6aScEGDDHAwu9D0UT-YIFxB58OUyIoUxeJhj-Ri98XH25Kpc6VOMu>
Feedback-ID: ic5d648a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B40CC700065; Wed, 18 Mar 2026 15:16:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaOh3R4_o__g
Date: Wed, 18 Mar 2026 19:16:06 +0000
From: "Mathias Rav" <m@git.strova.dk>
To: git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "John Cai" <johncai86@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <94dd3222-42bc-42af-8d97-5bd471a86fcd@app.fastmail.com>
In-Reply-To: <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
 <abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
 <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
Subject: Re: [PATCH v2] merge-file: fix BUG when --object-id is used in a worktree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 11, 2026, at 6:44 AM, Mathias Rav wrote:
> Thanks Karthik, Patrick, Kristoffer and Junio for your feedback.
> I've incorporated the sum of it all in this PATCH v2:
> 
> - Check !repo before object_id and add a comment
> - Use term "linked worktree" instead of just "worktree" throughout
> - Use git -C instead of a subshell in test
> - Remove gitk's quotes from the commit references in the commit message

I'm unsure of the process from here for a small bugfix like this.
I believe I followed the SubmittingPatches document
by sending a PATCH v2 with To: Junio, Cc: list and others.
Do I need to do anything else to see this patch eventually land in Junio's tree?

Cheers,
Mathias
