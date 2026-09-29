Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005B51A739
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790678594; cv=none; b=uHL19z47Me8GtEhx/ybAFxI+b3DtRFdLQKqifwiTgDgeAvIyeyUlmc6R9LFAHXUROtgyhufDz+IsKvwAqf94k1ekNasbv76SCridT4MDSPLZvc6RGU+v8aXRO3ikAJbGka4JukIbbNw8QCB1cl/YYFqEdaN27lh2IC0VIymuv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790678594; c=relaxed/simple;
	bh=UudoBIbCi/KOvAqvvQENyiFsG1s0Lye4o58mPNO8sqA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sVUnNmadE0AAlQqXHJI6sbi8Qxwriq6XEUJfnG2zFirY8X/qtgr+3cUiRarjOxh2W+OCE9pIWeyh469mvP2q/L4d8v2AA9Phx2SL4IYeD0Bvv92p5hOWORNhZy5HbEdDJzf4OiQaFFjObU+tcTUiPDNu8RNfCn4/h7zQNdTtsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=ggly1wSK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tUybAnTJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="ggly1wSK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tUybAnTJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CF881401123;
	Tue, 29 Sep 2026 06:43:01 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 06:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790678581;
	 x=1790764981; bh=E5ry0S1xrkdixvG5uYfOH9WRmS1EeU1sNERDgpYzoYQ=; b=
	ggly1wSKQVXkQl1zGbXHbmWM5VQxhAS9deS8riWwmOW4aEwpSMYgnm691r39tGtZ
	/Jrzn594ChlpR6RdEbzEF1i+IJkvEnlOmUmdVKc1l9tXW7PFLg12ENtoixJ/oGYI
	NVjn96T4+SM3DBuIBYIhw7LYbr7B3hLhm+YJtf3OKhizB5Znu7i1TceU38StP79d
	kaTCr6FpIE7U8Aig6/gPc95BBIYHNDV8EY13yu3fr8E6v05onuffrEWYyfzY1Yhu
	QV19FJKU2SKMEGjz9S1tv229EbAoILUwafiqLy8Dj3Bq+h7hotWLRPFke7tHOnAm
	lJPEAaWvcQfBFKkpjZba2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790678581; x=
	1790764981; bh=E5ry0S1xrkdixvG5uYfOH9WRmS1EeU1sNERDgpYzoYQ=; b=t
	UybAnTJRAFkVh4kbNORJHvMzWpgsV8mCjUFnVvuQS9mcG/xbJ+0v/4cMp/sCmcRM
	a9yFMaVXq4Cl+B58Hh3sIo4yCLlxdhHfO+2uCjtIMUmy9VURipeXt72g7k4MPTeS
	d5c27o6Ahl+Fmf0R0IrKmpC+8b/pDJ2jevMhTTjpOYoSJvLWzfxe3U4jrXHmasbo
	vT+OYjhibbhQJoETE9Ic9DavVdlwSOcul496F3x3ZT1V2zexPYPJySzCkgtSxgXm
	1gp5ODNCGJ19HQIre8pDRT5yCJVdPBmgKtYtZRzprwd0WBk/j3cBvRJcqih2bcMO
	IeybrB9KQb5NKaKgjqlSg==
X-ME-Sender: <xms:NZa7an8Kc1bP__SFrV47MssOxdmPgR-hOvtL4dbdsKits2Ezbafxew>
    <xme:NZa7auhlDNVbPWFgQUEKQ1SCy8K7ouXjvgYze5KkIgAU5AZ6U1raKDuDRncnblK1e
    mglaMYQ42xgEp0XSSk4Ui2SgfCB7lR6p1wr_rpYxEPRW6mtLS0ihLZR>
X-ME-Proxy-Cause: dmFkZTFL7MmyOYzPQF5JkvMtUVVC0K1whMZ/0l6lYfRZ1rUemVJGAxI3R+fW8b9+4UnFZZ
    at1fWMTZcuKaxFc7aX77Gd6sLRRNRJySR8CTiOY4Gji7TGAlecCcq9MqOr3AKSAqksHgzy
    qq20DVUjyXFvJMGNe8Jl6XostLuQ7oBTZg4zov5XC86T6i+4XjTT3/dDx4X466N9l+eK+0
    U4y55ntOGRXWnqIkKkNQJRjFM2hEUOKxQ5QAuOiCDFMIkhkyrjbQm2ClIqwMOV2WuE1J1d
    ms0ryt1qaQD33d/DqbrRKcDLaySrNDpkGO3xP3oWbp9lK3F3BCDmUnzglUJ2WmIXDj/+Me
    cEM84NvdscPtIF4XOV4FSuYX6ZUEfyT9CAeZk25kfb81eEqFuY4rM/YrvHgt9+0S9kjkeF
    dqjlRKRjxaAthcZSt556MNB2SKajrcRCe4eQHTJocEhDb4/QuXuLzUj9aYudTUn7D76WiU
    sLAsb80D/KgRyjpGr4cuWL9dm5fP2US5yYXuB7BbGZn3i/45k6zZi9XzZKL+Vzr1x8Fvid
    vNhFEFN5gadQYIzVUJ2VFrhILfVQMkO38zIG3J3EM0zzxC0Ci17MpdwCzUK8MpUXggx2LZ
    n5LcmrVDYWvb586wPsBeMbqjSX7n7NLaGXNJ/wvLeqP02qDaIAUq6lpjHbvg
X-ME-Proxy: <xmx:NZa7ap4r5s6Cnf0PC71HSHBBxFVqcW9R6jUxpF5kj1_t8GaB5S4LjQ>
    <xmx:NZa7auoJowWRSA2uNkYzU2hXhzHPbn9jmB3pSzoofaPQk7myjVLtYw>
    <xmx:NZa7ajjwbFvq0XZXkGIEJ06mtvs_qseO-BSpGpB6gBITkMiwOcL9Kg>
    <xmx:NZa7agIZZtvYXeNvWtKeenAK4kGSGS-0Q57wwSctCe7e474o65fYPQ>
    <xmx:NZa7ai1dM7EtpuFEB9rH6TWPNXfh6dH_ynwLy8H2S1jqdyBctBR7igYO>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F276D780070; Tue, 29 Sep 2026 06:43:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqO-TNe5d1d7
Date: Tue, 29 Sep 2026 06:42:40 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <8a5b742a-3f11-4bfa-954b-ffdd839b6d43@app.fastmail.com>
In-Reply-To: <xmqq5wzojy31.fsf@gitster.g>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <xmqq5wzojy31.fsf@gitster.g>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Is this the "two series" approach you mentioned earlier?

The idea is that:

1. we delete gittutorial-2 (this series)
2. we delete gittutorial
3. we add a new gittutorial

We could also combine #2 and #3 into a single series.
I don't feel strongly about that and it might (as you mention below)
be better to wait to delete gittutorial until we have a replacement
ready to go.

> There is no need to ensure that the new document that replaces the
> old one covers everything the old one did.  After all, giving us a
> clean slate and letting us choose what to cover (and, more
> importantly, what not to cover) with fresh eyes to match the needs
> of today's world is the whole point of redoing the tutorial
> document.
>
> So I personally feel it is OK to remove the old one, without
> promising or even hinting at what in the new one that replaces it.
> But we would want to see its replacement in the not-so-distant
> future.

I'm not planning to replace gittutorial-2 since the material in it
is already covered by gitdatamodel and gitcore-tutorial.
Let me know if you disagree!

> Also, we may want to decide what to do with gittutorial.  It is
> short and reasonably sweet.  One old-fashioned thing that does not
> exactly match today's prevalent usage patterns may be that it starts
> tracking a new project from a tarball, but other than that, it may
> not hurt to keep it around.  I do not know.

We definitely want a tutorial that covers `git init`, `git add`, `git commit`,
etc. Any replacement would definitely cover those topics, but 
I don't see the value of having 2 such tutorials.
Why do you think it would be valuable to keep it around? It seems
like it would cause a lot of confusion to me.
