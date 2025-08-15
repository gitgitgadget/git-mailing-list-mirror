Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F717308F2A
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273415; cv=none; b=Q9WiCQWWJHXjWncQ00vq+svZ+HNmpwuxYgCfHxoHdjOFNiSCjP6FBHPPPS+qjdiWKbSCSdIrKhRSVHYVr9mEVuZoXF7UOTAe0brLlvf3DEnk6kDRPrpdaS2sDsaO8CZy/ZA3eSakZXkb/SyQ7aQ1yg78aDItXMc0fQo65Nis6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273415; c=relaxed/simple;
	bh=QV1ZwxQh5GoeIe4HJVjEoVeSjojztNidSBnSira/D5c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IK4baKAnYvC0B+1ZKjJJgMBUnxGWMASBW/wsRcXys6ZY15H1R9aQ1aXLsXrVG5FW9aWqMcAVn8bajsCYKHJi+2WFsyyHdulWwJVP8KnSZWaEHPGBLZNSFu5YF5DrdWVyM31sIcaRqtaGS6wqYrDGiLLA67FALeC17F+pZzzFEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=VTAWQWya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDaUW7SO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="VTAWQWya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDaUW7SO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 245161D000A2;
	Fri, 15 Aug 2025 11:56:52 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 11:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755273411;
	 x=1755359811; bh=nYz/9m0fm/BYJSOjRyQjD6/aEMIih8faynxfiBgU5TM=; b=
	VTAWQWyaOkJw66kl2lA8WhyAewUtF/hMeHNFLbc/cqewDdGiccUCiVoLqzallCG0
	bTQM6wmHrVWUiHl6XcLh0rgjNEzQ94xIGz99BwE69vbsMDt21g9I6V7RV/xp9QGy
	U7r5ptTD2oe62buVyPGSLf3fMQFOt7u09Rx2F2U2qdBNxNvkeFVuKphUgbVqQoVp
	bNgCBoWMBvXBXCzqgyzNSWJD9AD5j9kUEOXPDT4YkGXFsVBO40ym3NOiozKmLXiC
	r7UgTbb/v4FRAMIqa7+X6V2QRoZXDdh63Vk2AssTzBeUuutalh8SfBLHFo+EMaNW
	RvI1OBJERYTGGWxx8XP28w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755273411; x=
	1755359811; bh=nYz/9m0fm/BYJSOjRyQjD6/aEMIih8faynxfiBgU5TM=; b=T
	DaUW7SOa9cAInla6HiqqGLTDfnBUmaD5f7MKd8ud+01zqs/7VN0e+FXY4x0XxP7i
	mHaRdg3otoFyydBM+5nt7WUu/wO8arE2SqVwDPVwHcV57YGa9mgzqY1cY2F3Y214
	I27V493BA6jisZxpzc8UgRdXOcE82mdQUo/skU2Txoo9oBH5V+7MX+LrUEvIpIhq
	s8z0uY0DnCEQZ78F1SblX62L/wTD3kBT8SmZ8b4kFw7Dx0swMv73AAmsc8uoZbtE
	0qwotYQ6R25U7fT37rsGy7Shzha7O3G/v3TfizCm4jcuorMF5v+L214Wp60SJi2A
	XemS3Y4CMP1wlxSLWKQqA==
X-ME-Sender: <xms:wlifaOQk02Ln5lNk_CzfahtoLFjgRMYNpXzx7PC-lxzzvVlOv3wyPQ>
    <xme:wlifaDypMcnPWD1ZjfJoi2x1795iY4jOgRIQ1SHZKkZeQEB_wK8uYKLDhigaz898Y
    PJYa4rOhSKrfuOoa5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wlifaGpCt0_ZhvYhoUqjOc3lccgZ9bK8qwvozNnnq7cQskSkGZhypQ>
    <xmx:wlifaMTeRDDM9uf60NbPIOxS8SMsi9Aay2_YeS-UYGI4KPUNPG0fnQ>
    <xmx:wlifaI3sj1DtCldsPrQ1idJraq3RUN3aRWVTN5vsBhsu9889-E38qQ>
    <xmx:wlifaAAkV4cZEGs1rhwAREH6F2mnumAWuNfDp71J4Pjnur-co9f5hA>
    <xmx:w1ifaERvJfvW4MYpsTv7aZxwuF577w7qWK1oIyJ58NcIW0Mgmrvytlp0>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67A557840B2; Fri, 15 Aug 2025 11:56:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9qJfYrKJiuZ
Date: Fri, 15 Aug 2025 11:56:30 -0400
From: "Julia Evans" <julia@jvns.ca>
To: phillip.wood@dunelm.org.uk, "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <30eabeb1-b89f-4e05-a3bd-bd24dc3a3354@app.fastmail.com>
In-Reply-To: <9293393d-e8c2-42e8-9b06-af40c576e841@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
 <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
 <52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
 <aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
 <xmqq5xepzjnu.fsf@gitster.g> <c9a4d7ef-8cdf-4d5b-b0af-f43ffc6b7450@gmail.com>
 <xmqqa540twpc.fsf@gitster.g> <9293393d-e8c2-42e8-9b06-af40c576e841@gmail.com>
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>>> Although the cherry-pick detection happens inside "git log" that
>>> command has a fast step (find the commits on both sides of the merge
>>> base) and a slow step (detect cherry-picks) so I think it depends
>>> where one draws the step boundaries. The cherry-pick detection is
>>> known to be slow when there are a lot of new upstream commits which
>>> was the motivation for adding --reapply-cherry-picks in 0fcb4f6b62
>>> (rebase --merge: optionally skip upstreamed commits, 2020-04-11)
>> 
>> Correct, in the description of "reapply-cherry-picks", it may need
>> to be discussed to guide the readers decide when to use the option.
>> 
>> But would it really help understanding of readers to give such level
>> of detail in "here is roughly how it works" description?  I am not
>> sure about that.
>
> I'd certainly be happy to see these two steps in the description 
> simplified and combined as you've suggested elsewhere.

I'll combine them then: that seems like the simplest solution.

best,
- Julia
