Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B082C237F
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823425; cv=none; b=vFBPu5D5RokpGGRkInprg4Y8my7DMsP6YvpapfT37aScv1kVHyhU4GRz4DxqlqEnHTCzHbVsv5BBgZ39lYN2bu7KUcIirTi2IL1DbyftI6KkPlHM5i4npRUBwdOuDCIAtleqmQKcP0hZauAah7Uv+a199zgzVKOD0VpsTQvEjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823425; c=relaxed/simple;
	bh=vTq8SgbfH5EthxSZn4c/6nmT2nBb2gStjnWOvqJZzsc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cDUvqk09yuapifQVo94Ij44JFW086RRZ3L2r4mloLj5IiWaxMPPH5Bh0U8yP6QDybnW3ReULXVbtPn7WxMaXopB4Pe6n2K+msxn+QBvCFdPuxxU9z6KPWtdgb5+haq1B+mP+VOQ4Toa/F+MT70Gtu0XydsHufNLvyO8cOFzHPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=I+mjjQzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ESrN4bWm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="I+mjjQzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ESrN4bWm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B76F140014D;
	Wed, 11 Feb 2026 10:23:43 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 10:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770823423;
	 x=1770909823; bh=vTq8SgbfH5EthxSZn4c/6nmT2nBb2gStjnWOvqJZzsc=; b=
	I+mjjQzwymqerxIDLSE8xuRZ886zZb7H5/YbYN5N73jJnKe2iynH73C//XcWgE3l
	2ytrLGvk9PJDegk0PoZ0vdonJRReHoXrAlkm9vufxCdtWvOfrpLo+GZy9c9QJxKs
	d56QTIldb/MZdli96Mq6nz4+ga0H2lDWMBFxGLl62NxHIUnB3RLEz2YNx3RkDaRl
	fJn+0BIQeHs/CJUlGGhW7taoo6Q12zs/TustS6plYUH8JUQadUiQiQkIdnXkCSEy
	wjkrVPIHLntX4FtLSQAmvvWloCWU+v/bN6Fa9DAKBuYJVFsPK/FBk6HhXf81lUi5
	0RXKoimM8IfAjlRUlyA6HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770823423; x=
	1770909823; bh=vTq8SgbfH5EthxSZn4c/6nmT2nBb2gStjnWOvqJZzsc=; b=E
	SrN4bWmKdqNODUtr8KzdbizfwKY7pqvd4dCal/yJMp9PKbQejUIfFmcMKNgP+cm8
	/FVeqX1PpGlV5CbQxhdtP+Na36211p0eO7xKJkEnFD17KspngXOov0tJrxQRUOeD
	1zyU5jyv9TzWIqvF4H63JZnwbSuTFkRBuFKB8jrqcxoWIvhajfKHzxxi5a4f8v3V
	IYJUGOju6oIXdYaszQWbIFh/0XfngjLRXP2fy1Fp7xGQUPpTGEXdRuyb4zHUra1X
	229lwF/tX9WaGda6cLO8W0B6m2ZoHPM3u7vSZYlu+zFfSTGHsTil3//GY0EGoGY6
	kB67HyiAgmlCXca7W8BLw==
X-ME-Sender: <xms:_p6MaVY8WQFW_q-jzGjqVPD7QC27wgIrR7Xs7uFOKzowXO4rlcJwYfs>
    <xme:_p6MaXPICs74S4VqQQ7agKD7QKTg4sQBuYT_0Cov8H4hH4NSwamgom4yPE8iJ9_XY
    PayYld7bRZZ6aMpbscfu3nysHHxJ-ZHfrPrO5aMvtLkpRczdmxXFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeduuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhi
    ugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepthho
    ohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_p6Mae_zc-UXXR9nUKYa2BAw6nz0IxxTr2VlJLdM6uUZylD5mCYqeQ>
    <xmx:_p6MaalpwPg2arGM8MKtN4XABnuojN7KnkhLZog0FJxmQ1WeatEH2g>
    <xmx:_p6MaRDucY5LfIkBPVZCUpChYkrh4qD7CXuD9zKZENSRegJpx0BUwA>
    <xmx:_p6MabUnVhaLo-LsgTCmtiaMpCzBxMN9GJC0TH9Wn5AZl0gZebU18g>
    <xmx:_56MaaddgtX1zGATQszTuITwS5fUAv4-kaCarFJxJ-xECeqGufL5JX_W>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B3FC61EA006B; Wed, 11 Feb 2026 10:23:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5TvX4iFuPHV
Date: Wed, 11 Feb 2026 16:23:22 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Johannes Schindelin" <johannes.schindelin@gmx.de>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <a4117ddd-1cd1-46d6-978b-b946f0199ef1@app.fastmail.com>
In-Reply-To: <87bjhvqvol.fsf@iotcl.com>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-2-siddharthasthana31@gmail.com>
 <aTLDA11AKs0jlxFJ@pks.im> <ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>
 <aTZ5RrjnwJ2ZnT7A@pks.im> <87bjhvqvol.fsf@iotcl.com>
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting into shared
 function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026, at 14:03, Toon Claes wrote:
>>>[snip]
>>> In replay.c, we always use the full OID via `oid_to_hex()` since it's
>>> designed for non-interactive server-side operations without the
>>> `replay_opts` framework.
>
> Even if it's non-interactive, I wonder if we should make it obey the
> config 'revert.reference' as well? To me it makes sense git-replay(1)
> and git-revert(1) give the same outcome if that config is set.

I don=E2=80=99t understand the position on plumbing commands. Should plu=
mbing
commands ignore user configs so that results don=E2=80=99t change based =
on that?
Or should implementers that use this command set the config files to
`/dev/null` in order to opt out of the behavior?

>[snip]
