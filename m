Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1919F42A
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727517188; cv=none; b=szU7h6EmjcKInE0AcTAcU1cp5E212bn/SKTKN7HL6lYcmzkc2wTF+BNyrDQueknFD6/6o4X7NGWBCejQymRogIl6lyPUvifcyN5O8QIUWfoiwB6/xM5UXYJdMW/yl8IQg5Rjk0h4n5YVQAb25nYaPY4yLcLY6WGM5pdKzArMbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727517188; c=relaxed/simple;
	bh=tqVTv2b8+EnIDuwK/GBdp+T4d8bxfE79svyspT+Axx4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iTiittC5ZFGRLhKHZsrOc8WpnidwCc0DnG7TbJmSosVrA3vA0IHGNeIcZ68ysbSCdCo6bZAvqe8GQ4tko/Z6s8S0YHFkIJKtMMSzwkOqtQtGHyiHoQeBf4Q9+j4azTYxAY39Smf1o/J4y+ZBRur+hZJJuPxXgspZ+R5ZSBRzilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dk0fCS+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7jbqF0r; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dk0fCS+k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7jbqF0r"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AC464138069E;
	Sat, 28 Sep 2024 05:53:05 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 28 Sep 2024 05:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727517185;
	 x=1727603585; bh=QvaNuaq/wNhFau3/IWO0vb7wQDmu23jIHUKwH51p06U=; b=
	dk0fCS+kXl1sR3GZbtArKF7Atx3lz/ZBwBDgwsLiTTukcNu06riW5qkQCeg0saqx
	mvgomQl9g2m9uQ6+JnIQcg2Cvx7AQGSLDj8ddjOBGmLPODNt33CeZBEjMJLbGuBz
	00nhlim7iR9KMFGja2LWPL+QlLPzbd9O6PiUyRgNC8f753sOV2IgVBlvEsN32AFE
	pNehUAuDgWcy2aDzkf/lRJjeZUi1ofRV5InpgnryoUy8aBq68Nf/w2z0v2ZddKDy
	iUmSkDAXRrl+WUYLOt/hHeb8Fp6+5P2q7XUAbBZRA1FJ2iEZ3PXYZhVZGp6cqzdG
	+vF2R7S0Le85sqv+TOQW1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727517185; x=
	1727603585; bh=QvaNuaq/wNhFau3/IWO0vb7wQDmu23jIHUKwH51p06U=; b=d
	7jbqF0rbBIVREAQ91qlzRmsZLhRG+7QQIxAoAhn/9gD4b2En6ACWNJXbQXSdfXhH
	5VZbaVcP6eCZaq+zlWrcpW/mMmUCrmn44CZFcJtlhFWz5BgN5PjIUnpQNYHw8qeW
	RI2bpS0/rE7wltXU+7v8/eFFocH4XFAN7nOulT7CKH3nULO75PTG7bCMNxSa62jq
	HDxZEy7f4GHWZEwRrMU+C+dRmiGR3dDeOBMKDVSCsKlzkD18oDVhpLcaGIzlFeK7
	eagkzMWX2P9685lROZNzSv5afA9Gf5A0XEKB+sxR0AfFG1QDhkAKxZKBX/rFiy3o
	zPpVXFzM5COHOLB8jkYtg==
X-ME-Sender: <xms:AdL3ZiKp34gVT9v7HCfKhUGFuz2UCkGLOG1jJ9OUDf9o_1nt7hfvQXM>
    <xme:AdL3ZqKrfehATDy9qIXexnect2j9aen2_EooQOc-XKdYIiD3-MKpTJCwu3dcBpECt
    xPzzDyp-Qi6VRu3qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddutddgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehishhhtghhihhsvdesghhmrghilhdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AdL3Ziv4bZJIoByxaYmMi32jZ0kGHwyexEkfPlYsTe6H2f3WYYVeuA>
    <xmx:AdL3Zna4UHx17oq5Ox19jZY4Z4qApErJ34nZw1qqrznTTgdYi8Mj6Q>
    <xmx:AdL3ZpZSJBGIwyJWGbGIP4H0Gu-cxfkd7Pw3oeku6578gb_i2N0fpg>
    <xmx:AdL3ZjCK2KUOu7zrAsSvUlgEVcWXgHDitkYdqo7L2UFXoelYg8JY4g>
    <xmx:AdL3ZonccpsuefSsVGbcdHLKCu9f8DhoW8bM6tBwjulvr1zVNdrJjGvd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 672E0780068; Sat, 28 Sep 2024 05:53:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 28 Sep 2024 11:52:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: "Stephen P. Smith" <ishchis2@gmail.com>, git@vger.kernel.org
Message-Id: <ca632f1a-c41f-42b3-8f8d-4ef32fe18e33@app.fastmail.com>
In-Reply-To: <20240927041516.GA568026@coredump.intra.peff.net>
References: <20240925122515.14015-1-ishchis2@gmail.com>
 <6b69af87-9002-46a7-a5f3-3fa1fb7ba9df@app.fastmail.com>
 <20240927041516.GA568026@coredump.intra.peff.net>
Subject: Re: Can a note be pushed to origin?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024, at 06:15, Jeff King wrote:
> On Wed, Sep 25, 2024 at 05:29:30PM +0200, Kristoffer Haugsbakk wrote:
>
>> That will refuse to update if your own notes ever diverge from the
>> remote.  If you want to always overwrite your local notes with the
>> remote ones:
>
> There are some specialized strategies for merging notes (e.g., taking
> the union of lines). See the "merge" subcommand in git-notes(1).
>
> I don't recall ever really using it myself, and I don't think there's
> really any porcelain support, so you're on your own to invoke the merg=
e.
> But I guess the use case would be something like:
>
>   # fetch their notes into a holding spot
>   git config remote.origin.fetch refs/notes/commits:refs/notes/origin/=
commits
>
>   # and then after every fetch, you merge if necessary. By default we'=
re
>   # merging into our own "refs/notes/commits". And it should be OK to
>   # use the short "origin/commits" here, since notes-refs have their o=
wn
>   # special lookup rules. Though using the fully qualified refname is
>   # probably reasonable, too.
>   git fetch
>   git notes merge -s union origin/commits

git-notes(1) feels like the most =E2=80=9Cplumbing=E2=80=9D command out =
of the =E2=80=9Cmain
porcelain commands=E2=80=9D. :) (of those that I use)

For my needs though it is high level enough since I mostly add notes to
my own commits. Certainly porcelain in that sense. I use it all the time
to add testing/general comments to my commits.

--=20
Kristoffer Haugsbakk
