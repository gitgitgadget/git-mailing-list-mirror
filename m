Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C641FA8F3
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876113; cv=none; b=P0pVl+yxN5z5XEf6ae8fqlbhBDXILkk8iE57KTAI6SdFbJrozgxIZMiAph2xg5BuGxm+VAWEGB75FtLFJvygdf567p3HIDpPt4ZXKlwOQDJ/DQ/NVh9bUYEbrRpDEUVXXaQHcmkhABEa/nOgw0+vGGbytmF0A+wQb6w1KbRIJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876113; c=relaxed/simple;
	bh=j5APWvMkhelGvw+o8YRql1rahfvURIayRMkkxyD1LzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aDQAc1dTX/On+GQvJBd95IJGfwjuzSFL3ymVuHhnFxgg5jUJN8kcE8EigwejNuMsvjMzAppYoclbnTLWLefE60hl/byKdn5a73LsZpZawF+D9mBD2MJ/RHUpg/MG+7+bQSYLpgwgrKJYakWWvg2aHh+wXiDxnrK/H8VOWxLfxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=5R2c02qg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIY8/xDw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="5R2c02qg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIY8/xDw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B531A2540146;
	Tue, 14 Jan 2025 12:35:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 14 Jan 2025 12:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736876110; x=1736962510; bh=zX8r3EHlA6
	hu2+v0VIlAClyoWZB5yZ8i3/3a8iIMXxo=; b=5R2c02qg8u/B3+BwxrnXZoMp9X
	Qma5+f9i2cRjOLmIlMws85JI572FthbXAfN1Bvs4h9LNDi+2yqsq/PdJBotW2rl8
	stVOHNPAXVOKt3M1OKtVBBMECshX9N9yvNZDG8iiCc51fpHpoADu4YnIigWi6kcr
	iajjg91t0S96J+khG5IL42qOazuhli5hiDKzsgMKpAPU6/MHUQYfD5+BnLncEPPs
	vJ7vI6VEV+TVdo3kV0Dc5ohIGTsXzhKgMgMJN7mcUqoJdja2b/ZCBc7HTGnkfyLT
	PgWK1lURjVS29EkQR8CiJirNmq19ewDsKRwWJpzRY5YFWt3lp7/f1VM+Rs9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736876110; x=1736962510; bh=zX8r3EHlA6hu2+v0VIlAClyoWZB5yZ8i3/3
	a8iIMXxo=; b=kIY8/xDwKjMwrj8p+QlxyQMNkKQxV0gLPZ+XGDuxQHqr4W66aVK
	S4s4B4ec7kvmO9bnG1RsdIbN4LGVzqKGy+NcR2Prcx8+itmbnLidPsUDmUNIlBFY
	tNceVe4gOmCKM9x2iA/1GA589OoBQ/NymmYrHzlTsdYxQtneL4GJU2WNpmo5IgxR
	YEsHG5emxj1WRJm0qu899d/UsppFMhNjCvt9f4ocSpLRtZcD51EYjLZ0cRccJBPC
	3uNz3ESkZoK9vOS5pmOAwqO3Ax7j06AX7wgsekEp5RN5B8HX7PKXJWOvLC98OZcj
	CdDU61xk12FLEsK19P8YduTTBnvBe+f1B7A==
X-ME-Sender: <xms:TqCGZ_Z_jrVnr6PEE4JBYd9H2oaYjq0pbh_OzLgVUw2WT3MwVbRZJQ>
    <xme:TqCGZ-abYed55rYfVuhypRwFVrsuB4pWHiRT0DNGSyBdydlOKQpfbDSZ2ExcjzwNQ
    QQsmSCidl9Tn7zyDg>
X-ME-Received: <xmr:TqCGZx9dCFo9ZjA43zPPQfgIjNqnMXlvro8k4vUKaQPYxJqOLqwffrkZJ3ijR3FhoWKNy_sIAPDlqkRhOaZzq4Bz01R2xFdSVZpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:TqCGZ1rssNhiLWzY5LcKqlcS9XY_giolSIthzmhmaSQaXQAiletl-g>
    <xmx:TqCGZ6pC6WLdRGilt-jTdWYlb79vXPdegEocViK3p-nDHrf9x1DjNg>
    <xmx:TqCGZ7S61BCdquVwHW46QW8cp_MYTTAhUFipOgUocchs4rS2WzNLgg>
    <xmx:TqCGZyrI3vLyKD34zpHJLqO4HL-zDGzf76bvSwnk8THhriCuoQO4KQ>
    <xmx:TqCGZ9VCDvlrmiXmQ3PzUshr-rN1srEnBH-YH4Kd5EKSMthrLQqewGEk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 12:35:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] Revert "doc: move git-cherry to plumbing"
In-Reply-To: <b0a3889a-9d7f-4663-bb00-b1b457931fcb@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 14 Jan 2025 11:24:53 +0100")
References: <e5b20f9ceb437a82c422136cb81b05a0521cab07.1736682716.git.code@khaugsbakk.name>
	<xmqqv7uiac0m.fsf@gitster.g>
	<b0a3889a-9d7f-4663-bb00-b1b457931fcb@app.fastmail.com>
Date: Tue, 14 Jan 2025 09:35:08 -0800
Message-ID: <xmqqwmex47ub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Jan 13, 2025, at 17:56, Junio C Hamano wrote:
>
>> It is not like it is a crime to intarctively make use of a plumbing
>> command, or we intentionally try to hide plumbing command from them
>> by making it deliberately less accessible.  "git cat-file commit X"
>> may be handier than "git show -s X" for some people and that is not
>> to be frowned upon.
>>
>> And what you call "might only be" is really the crucial thing to
>> consider.  If we want to keep a tool's output stable and machine
>> readable, we need to mark it as "meant for Porcelain writers", and
>> classifying the tool as plumbing is a pretty much established way to
>> do so.
>
> Okay.  I understand now.

I forgot to mention one thing worth addressing in your message,
though.  Making the tool more discoverable.  It is a valuable
consideration.

But I somehow think moving a tool between plumbing and Porcelain
boundary is not the way to do so.

There is a collection of "howto" articles in Documentation/howto/
that is meant to be the place to learn how to go from workflow and
objective to tools.  If you have a success story that your use of
"git cherry" helped greatly what you wanted to achieve, it may be a
good place to share it.

Thanks.
