Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CAA34C81E
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570244; cv=none; b=pQBu2Ac4/JNer4PRT/aLIu20nSaW8FD4wuTqf71cC2aQh61wsdblMVty/ybXnWAM195ndERsIZXwYC47sXtZ7OPGr8Ypz0Vjzq+ED7cXPOyuYPbwP2zvO/32BRcZKwp6vE3hAC1LXAmC//QJzWRbvml548rCrAKrv5G/zHu7VWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570244; c=relaxed/simple;
	bh=WpB2EcP68O63iL2P9hdv5B8k0qcG7Ut5pu5MrV6O+r8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q95uzl/USRPqtUJGot0GzKa+mEMq8hdIx3H9xwghMKFbye5N2BRJxZqMi1e2Xbwt+qgHTurZws+lxN54+o1zPDhMJj0XZIHsZvCRFOcGCtOIGpE4TwAZPiahgbq5Qh6BC1XzHFy+HhEH1tsVfl4PuUhoi8z8NvK5LYSq6j1xGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZD8DAkE6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ybr3ayW+; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZD8DAkE6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ybr3ayW+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1700B1D00091;
	Tue,  3 Mar 2026 15:37:20 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 15:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772570240;
	 x=1772656640; bh=WwdLO7dWl3FlRCoeIm7dBqst2HUoPwK58r/ubHwAhGQ=; b=
	ZD8DAkE6szAF3jnttwHMFxjQHFxCEZ0Au5xkkuWnRLORmJ/pEupX91IxJ2kM666H
	6+v2wUH4PJWglEAwIRTUMUpYX/GtqZcWLqb3B9XK57xbn7vdo2a9lcYNDUkU9pfi
	7zQb6IoBzofhncp0RuaQuZUk3byLaFZJEjAt2kDbmaoUfSi6mhm10OvAlVdTVJTe
	T5RllXSYqyhJ5qwNby4xiy3YbwQZFiBsVaTEE/jLN/qmz+ZWEeBjfxS9OB9IsUUY
	bdsGhmuh0TJ4PJuUHnZv0HYUYNXkkxpdFJbMWiSR7W+j0ZJcIdsLqyRtAJjKRXXv
	AWpuJ3c5eYxdgVPiJXvbXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772570240; x=
	1772656640; bh=WwdLO7dWl3FlRCoeIm7dBqst2HUoPwK58r/ubHwAhGQ=; b=y
	br3ayW+6FzOofYrB4oZMNck+1P61CGn4JmQ2WtBUITzDSJiGHydmdm6UaAbNluP2
	8pp9i+IwWczB9w33kdamn87tFnORQfsf0Eij9nX0hmdx4WZA1+zRu9sRHeVfPCDc
	DQ1ORelnTGlOGyF5JAC04t63ma2h/hLo4WlVR7xrVwLyUq7OkOk2mRvdek8QIxGw
	E3HhIM7v/wivYO02E7BmoSzJC66Yd/2ur1aGWk9ON1w3c9ZhW7ED0+wGmoW+LZgn
	iG/sDiUThn/fH8a6dwMvvgCEfcZ3g+KEvOOVn6pDaeiFEkxR3kYgM8v2ROfrJn4e
	Th0Q0mH0wSXBv0pV3W3GQ==
X-ME-Sender: <xms:gEanabALcK6OSv3rJ03aa-Gqj1-k2M-F2Kp0AeqghEcX_vN3GLH0T-c>
    <xme:gEanacXtAzIWGl5GEb0GuK8b7dtUmi37uDKHVMb2ZrVqyuzMbzhfTue3txN52jQvc
    rPWdQUD8v8r8g4AUK07BgSC0Hz4JBPsOeEcWQjzDnCpgzJy8MHULw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukhdprhgtphhtthhopehmvgeslhhinhhugidrsggvrghuthihpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gEanacoiEYfarPf13l9iiSYs_nrbnriOiKB3s9d0kVEVI8SGAAAl0w>
    <xmx:gEanaeGZW3ROp_0ESf6C6VrHfjyIqqbM5ejqlJVEhUrYTUHRU6Yj8Q>
    <xmx:gEanaUu-l1iUFYSbSAiWOvmR6KyYLlGbXCKq-MS2Fw1IRvb3mcla5A>
    <xmx:gEanaYVO5J-mj6JNG0HvNPNdeS-STI4uXKS13HByzSzWKAnQ-yra8g>
    <xmx:gEanaSxfHLwe1PSm7znOh6X_sSodzwtXAEjWuSwVhiKFOLUZiCrf6rwL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2D17B1EA006B; Tue,  3 Mar 2026 15:37:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Am6sP3XKy-Q3
Date: Tue, 03 Mar 2026 21:36:53 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Li Chen" <me@linux.beauty>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>
Message-Id: <22e1de8e-935d-4efa-9fa8-ef8d9b4ffc6a@app.fastmail.com>
In-Reply-To: <824809c3-72ac-43fb-8a93-4f48e0727e6a@gmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <20260224070552.148591-6-me@linux.beauty>
 <824809c3-72ac-43fb-8a93-4f48e0727e6a@gmail.com>
Subject: Re: [PATCH v7 5/5] rebase: support --trailer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 3, 2026, at 16:05, Phillip Wood wrote:
>>[snip]
>> diff --git a/sequencer.c b/sequencer.c
>> index a3eb39bb25..a60c2a0cde 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> [...]
>> @@ -2025,6 +2027,9 @@ static int append_squash_message(struct strbuf *buf, const char *body,
>>   		if (opts->signoff)
>>   			append_signoff(buf, 0, 0);
>>
>> +		if (opts->trailer_args.nr)
>> +			amend_strbuf_with_trailers(buf, &opts->trailer_args);
>
> I wonder if it would be better to add the trailers before the signoff so
> that "git rebase --signoff --trailer='Reviewed-by: ...'" adds the
> "Reviewed-by:" trailer before the "Signed-off-by:" trailer.

Why is that? Is that because that is the practice in this project (and
maybe others)?

I would expect it to act like however `--trailer` already acts on
git-commit(1) and git-tag(1). I would have to test that.

In any case these `--signoff` options are considered a historical
mistake now (since they special-case one key).

The logic for before/after and so on are supposed to be handled by the
trailer config, it seems. But last I looked that was only for same-key
trailers and duplicates. Not for logic like keeping your own signoff
last.

>[snip]
