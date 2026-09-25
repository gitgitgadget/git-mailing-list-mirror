Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB64078E3
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360631; cv=none; b=NyeMoc8TqDNkC4sbdKes4gf3o394UjopN141+tupb00ga2wwAxtIS6OsK1CLOpJFkWpAZUabNYvj5V53IZd9VJ+NcQ6ztLYy2QPEQK+l4Ddl6BRC5M1PD4E1CJbYDrVyNd/8/qCJIcuTd+1DYJxQKJ3HuILw2lvE3yv+EK8PY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360631; c=relaxed/simple;
	bh=oFBqiBKLHpqJqBQjLmhN6dCR+MoFz+E6Lyjygvt8Cww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SG2zBj2w4+kj615tYQbk+umrNtq2J6w/jCzYQ06uDn2K98vQ7Tu9io6E9bdTl2f1O5pwCe1XRzb7LsuApNG2fZk9Ox87um15ZrVfl3OGp6ycIhmeVhlGorRnVRnjhJD9SVVbqxZY3K34in+v71Wjz8k3KMpey1oWwg42YnMT1vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SxjMrzwJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HF64xyNa; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SxjMrzwJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HF64xyNa"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35FB5140005F;
	Fri, 25 Sep 2026 14:23:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 25 Sep 2026 14:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790360629; x=1790447029; bh=TPn/iVEJ+M
	c4C0Fea1ZlumK2TKujUSXWFMu/UsP9YMQ=; b=SxjMrzwJOaxIMuXYg6UnEzK5JY
	nuq3XMEN82UpyD535R1rxjFeCD/vn95jbAWy4rkKa6QH7HFQrcr8TI8nxFZ1lqtE
	wLIF6qhw0ZwAEmSNL7Sfp1zJA4KzgoDS2O1b7BYxZpt97iKiBLYt2eAJPv1Aar86
	ammukC03wOm2yXGWff2rnm9W98aIlQN9HGFwQekxQi4XWzFrLqEppJ4pCzU1YSOR
	cczEIJ5dZfruHlsdKSmPzk/FTq36iaXLGrhanQWDTe7t9EloFvDKMCihR3SOnUMr
	nQnFfFibw3Qp8lpFuViYOSYfMBkeNVlHmJkH69bGlGjWdJOaZhKEJRVuwVdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790360629; x=1790447029; bh=TPn/iVEJ+Mc4C0Fea1ZlumK2TKujUSXWFMu
	/UsP9YMQ=; b=HF64xyNaMzK7DDvc1/mjnJ29y2/rwydQCRQbtnZJuDVXjxMMPyh
	Tggh37tMvzv8wRE5gCNtQ4uZtae1X4FhELx2H1mKahl+CYJkbRSilWwblW4pfUbe
	rUFqLzLnoMc6zwNiZu/iyceV1yRx+y+B1j1MAJwOwZN/NgCQwgijCgWu2HpKZNLr
	zyp11dqpZFuBKl4Fy6/Do/QjkLUc4scSd+tvGG8C//YgDTGhzUmPzlpbukRvWGr3
	Ae8uFQn0CQlpGZFS5MATcCLDScYcfw6oyTl60mwB0s7LMii/SAZGV2YUg+v2/zs2
	Dwl4ZxOamD5ru1iBJAfT97BZx3gplxrtVag==
X-ME-Sender: <xms:Nby2auDF_VebihYP7kBpaOqZszIVo_X5-i8oRFwFgyLiSgRBZ-zHHQ>
    <xme:Nby2av93JtNE5fWwTFM2B0GVCpEZCxI3-wWRPukBeG4quIdJfi5pGb7_sND6Ntako
    fpAIeyyJMwqhVdGoqg-jgcWS3SzhrQOhdQMcaz9QBeMXsFOurvxWsE>
X-ME-Received: <xmr:Nby2au85wmxQ5qerlBLbo2nebNj-zmdLVC9dYGQvexzl0XH-HJwGjCEmFwafvNmisYywz9vkhBmLOplIUubfpPwlaLhQF30dHFup>
X-ME-Proxy-Cause: dmFkZTFqOpLEYezn7o1SODS8TxduD3m8gEomiycW4XO9v32PQCCOGfZCAWkgDxxgxJCtwy
    ETqwNQOqFBsVeaVaJZDmN4oeVqJCYlo1OcqgEgN+g+ihgckursrnZZNs3I/9ekmZi+wwjP
    NOycmlWnGLnP+EjIw4nwMfbS3sVJQ45z6Crvq5O77SGtG1hnXL78b8rs+Qg6awm09ICZg0
    1UsMu94vTOZRk7WzMuOMOSbk5ZwehtLQrxa2k2q5CnYOoEBb44UewjZD5YkUYnBVXewFCK
    kh0cWiqAi9YJQrLaMw4fS379yu9rWWze/DZj8abEEGqykZ6QUmLZ2+30byJSi1aWMGFThN
    WNAl8xOPx8FVCO0CGnAltQseoQFBjP42is3wwd0LnboK7JX8nbWJXmEWZ7xaPEF5Mqa/SO
    DvufLDTWjVnK3qZYp+FhIA0pVSo+QYfKcAWdn7ApZBMEWyEc/OaQMWEGlfGmSMsZf2O3n1
    ciJ+b5GTaojnDxZvL+013N9jncSK/8RuWDML+/z8HlcYYffWyVnrAIZIzWFAhpb3pD/nji
    UnJbNlHheIfCP7CVG27A1HqJg/MyQjlo4stW3gkakw4w6ebhmZ0mUE/6PzFqB+JiypN3jF
    umy+MW72ERv1gBvVmh23JeEhaj5uVW5hn/H8wST4EkLfS5t3yOsRCrICyZDA
X-ME-Proxy: <xmx:Nby2amfo3WEfT1zcx_0s3TBaWkiC-esmWaYwb3eAYiMJ5lOInXQB2g>
    <xmx:Nby2anH5nQWLygPYkQjFOBv8_YICxxZMN_2q02JGMg-a8Z24ZqYkCg>
    <xmx:Nby2akc8HE8sN_cAUzEmEGsNXANEA6qHCy8_6jHoluEuhA4LIczqSA>
    <xmx:Nby2ahF-dJ4b7pvPZTXmHUMitZzKJ6nFwK-QQtzV5k23cw1y_sQu2g>
    <xmx:Nby2aoHREFnoFO2c3e8sKqc79ElozY9vCYfK1ixu01mxzmlPAuP__CJO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 14:23:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: git@vger.kernel.org
Subject: Re: Rewriting the Git tutorial to cover less content
In-Reply-To: <4c9f0480-768a-48ba-9753-b4d34188b1a1@app.fastmail.com> (Julia
	Evans's message of "Fri, 25 Sep 2026 13:25:10 -0400")
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
	<pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
	<20260925082723.GB1493716@coredump.intra.peff.net>
	<bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
	<xmqq7bk9wa4y.fsf@gitster.g>
	<4c9f0480-768a-48ba-9753-b4d34188b1a1@app.fastmail.com>
Date: Fri, 25 Sep 2026 11:23:47 -0700
Message-ID: <xmqqh5jdur4c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> See gittutorial(7) to get started, then see giteveryday(7) for
>> a useful minimum set of commands.
>
> This is a nice friendly statement, but in my opinion `gittutorial` and
> `giteveryday` really do not live up to what it promises, ...

Yes, it outlived its time and the world has moved on.

> I see a couple of possible strategies.
>
> * We can write new guides which are clearer
> * We can link to outside resources (via https://git-scm.com/learn)
>   which we think do a good job. Right now that page is pretty
>   out of date and it would be very easy to improve.
>
> I think a mix of both is probably most realistic right now.

Whatever we do, it is not enough that new guides are more clear than
the current one.  The goal should be that it also is sufficient to
replace the current one.  Removing the stale and unuseful document
can be made the primary goal, and a new document may be a means to
do so ;-).

I do not know if we have bandwidth to keep external links fresh, and
having a set of links to stale pages ourselves may hurt more than
help.

Thanks.
