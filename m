Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5740FDA8
	for <git@vger.kernel.org>; Fri,  1 May 2026 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660066; cv=none; b=PySZaysjwbGjlkbsESCfdTCrMkrr51eodAl5JNRje08ejW8SDQf87dOOGJXVM7/5IvEFOjXRSaY+L+ERD+ybomYLnXkNoejSpJ21GFag6h8kIYraHofox32uadTAHybRhtN1eRv7Ww11oFwMVqu8PTLuQYswJNn1F9jp7UolS/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660066; c=relaxed/simple;
	bh=jiuAMPhveb6F0CFndRDI1UHQV9Mo1LroUYG2YvE727w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEXwFaGbqLzzrpmewhATk+sl91/c0cEu2eDJxg75l+EaL7PPVDfKl/Ntv0T8w88jwcwK17kHU7wQUvaYSrioufRsy2Y5zKkWNpKiCRLkuA8yiFBcTwikuKXPeOqdMYVzbpPH0ArzGePOK371dac/lsNbdhagtqQFhLkKX3xZMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IAaDE9+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hvNFPNXA; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IAaDE9+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hvNFPNXA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 86748EC0093;
	Fri,  1 May 2026 14:27:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 01 May 2026 14:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777660063;
	 x=1777746463; bh=WU/GqtFSciB9olYiIX+WFVawGFpyXupFv2pEB+bm4cM=; b=
	IAaDE9+YOCSdVbj7oZ5YHFTZT4gMD7z6A2RCFTQyFd1Ki/dMBqnGF+g8d8yyYhsl
	sE0MWp1hHMb6sK3y/+f5M5CyoxXnB222IfAHhLlqxvW/g3Yby9mE+wXQkjsGKsx+
	W8JeYIhKJMW/kYk/TGYQKrJ0swdnqPlBbQCK1yvQaOM8YbLM8DTRruGjReXHRdQa
	lS0aPaj9D0eNXJLY8aiERzyjcvJrmJ9NdER39ToSerjDFUnbquThZKznE2dczAbD
	7ymdnAV0jaB33tASfQxJHlPgV+4dRW9kjCoVhMjdV5DyXF08JrvyzwqFrWUDSEPs
	CITllZ9YuHuRfV7zjUJp3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777660063; x=
	1777746463; bh=WU/GqtFSciB9olYiIX+WFVawGFpyXupFv2pEB+bm4cM=; b=h
	vNFPNXAC5Za9PJxbzCOLvc4pGpeT/oxaLjhvgNVbO19HJeCMSorkZgaD/WNTibCh
	Ovltt+Q4PN7tP+Xrs9anl6MB6OvycS3qjozVKnzpfRu9/DBAASg2zdN0nRoM1Y4S
	8RxlRIQdcku7crN0sIwYDXCD2RwJbcu0AkArZ5/g6gliZuf8EeVxzQR/BorlZQgI
	jxa1knEfDV4Urzlg4s+jP+5OmQEwW6OaL+I1JkGMY2cjunr4f8GMZYFjC8nATo1/
	eqoOQRrL4Ui5qrliVMEsPl1Losze2f7z4HwnDs1O8ePGNKQIUD+8oR5ySYsy52I+
	f+r4poKcJqbKSC417oLbw==
X-ME-Sender: <xms:n_D0abDmPCRYIv_RJ7dwEhMWe3lPP2V3afY6ddWaFMTGlYC0EInAWhM>
    <xme:n_D0aYgZn9IZYpy4bwP_o-JiLrNphExcH7asgtslovORMs_KliK8GEiZ-daEvwfuQ
    tVzCbDnEV2uFcj_v9ahl40-lKAFlZIV-WetDhDpvAl4gG8n_rQDOA>
X-ME-Received: <xmr:n_D0abkc-IUbK_4F3a_fLbu4jMrsFVBWcFtR03ujtY_7zhWp5ibKST5JzpWTa6-6Tp-a4xDnKSNdRV3UlxFsPjjK-5Jkmyc0gL57yLSv_QObsAWNtdTQlSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertd
    ertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeihe
    egfedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:n_D0acp-HrY4n2oh0i6qYVjmK2C7EXGYeJ8vD5tytoo58wPKrPHcAA>
    <xmx:n_D0acGtXqz818i77bOE9Mnf3seV7c0G-O4kDshQAqBgs4k-3aHf8w>
    <xmx:n_D0aQyv7U77EXluwLTl8M-iBbL1CBnSqwXw-3hRTj_F5tJLCTLXSg>
    <xmx:n_D0aZpjc3X3hm6L4coiEpvNxXIMdpuRm_HLE0rALxn8_oh76IWiIQ>
    <xmx:n_D0aTEEwBq6bQDcd5iS7HRxXXyE9wyw47oEFIoVl9orLaeOB5vrF4Lm>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 14:27:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: phillip.wood123@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty formatting
Date: Fri,  1 May 2026 20:27:16 +0200
Message-ID: <20260501182718.27853-2-kristofferhaugsbakk@fastmail.com>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <e8bb57a2-8eff-4f72-96ca-72d8880901e0@gmail.com>
References: <e8bb57a2-8eff-4f72-96ca-72d8880901e0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, May 1, 2026, at 12:16, Phillip Wood wrote:
>>[snip]
>> • You can’t feed commits piecemeal to these commands, one input
>>    for one output; they block until standard in is closed
>
> So you can feed them piecemeal but you don't get any output until you
> close stdin. That can be helpful as it means the calling process can
> write to "git log --stdin" and then read the output without worrying
> about getting deadlocked.

Okay. I don’t have much experience with concurrent programming.

> The Implementation below works fine if there
> are separate processes or threads writing to and reading from "git
> format-rev", but if we want a single process to be able to read from and
> write to "git format-rev --stdin-mode=text" there will need to be a way
> to delimit message boundaries so that git knows where the input message
> ends and the caller knows where the response ends.

Okay, so I guess a null-terminator mode for output.

> We'll also need to be
> careful about flushing the output at the end of a processed message.

I don’t get why this takes special care. I’ll think about it.

> For "--stdin-mode=revs" the caller cannot know how many lines the output
> will span because formats like %(trailers) will produce a variable
> number of lines depending on which trailers are present. It is also
> possible for a rev name to span more than one line. The following
> example finds the most recent commit that mentions 'cherry-pick' in the
> subject line
>
> :/^[^
> ]cherry-pick
>
> so we need a way to delimit the input and output records there as well.

Okay, so a null-terminator mode for input as well?

> I think the functionality implemented here is useful (transforming the
> output of 'git blame' or 'git-last-modified' are convicing examples) and
> it is probably better to do it as a command rather than adding a
> "--format" option to name-rev.
>
>> • You can’t feed a list of possibly duplicate commits, like the output
>>    of git-last-modified(1); they effectively deduplicate the output
>
> That is definitely a problem

Great, thanks.

>> Beyond these two points there’s also the input massage problem: you
>
> s/massagge/message/?

No. I meant massaging the input so that it can be processed by whatever
tool you have. :) In this case splitting the object name column and file
column because tools like git-log(1) can only deal with revision input.

Thanks for reviewing the usability design.

-- 
Happy May Day
