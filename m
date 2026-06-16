Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97F282F2C
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640189; cv=none; b=Xpt+vTmlAHb45/8qfLdzLiC0604/U/AG5NHhAC5OwkLsFw2nlUndFRGK3lcb7T7epTQu4HIwBF0q7aUSOhqt8bp78KKCWocEuDv3BcP0xLY+UP6w6DRG21ivFSF90N/S+iIJa6xZQ707VoPXbTSfnOVCiqPOrPEOC4z5m1Fs90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640189; c=relaxed/simple;
	bh=LJC2YFetp9EZo5EzTY9B8ZodvIlQADyOj+w0Si01EBA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ALBs5CKzWk6ZpRUvEcAmrguI6CIdx/oZeheFLaWa2TehCMJGaHWQ5+gWXhOBQmMNFRsVtHSjds51doErKNwcMbJvTkVmmOBpyiazw2ymg7mKFS1gUbhSQEBYN/jikGeRzk0nSch5gOG/GSnU3SuvvKEC1BnFyK7tbGfqI/4Pwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TBxUCX2W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnmGoK7c; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TBxUCX2W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnmGoK7c"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7547214000EB;
	Tue, 16 Jun 2026 16:03:07 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 16:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781640187;
	 x=1781726587; bh=LzL0iFx76OWCcDyEnU1AMyXOKZ1hH+LY4nUzP/7NEUE=; b=
	TBxUCX2WDreJUm8ElqdIRaz10f6z9TtxwvxirEn/tgwVM96jk1Z9DusQX3HF8J3G
	y8/Y4mth5Nhi6VWraikN+Uj+93fXkk3hkmoALGJ3AzByis1jdT47WuZpgvMKyyTl
	rCYWVlhD3AC/PfIntLr4Sa/f00G/BxQt0WcQWl6DSbl2/K+1VHDr3N8qqyftTyE+
	EnrggxrX695vjipvLYAFlWJKSbv2TWxE/9UEMjv5KVBFOQKmQXsiz639tb/wG09m
	P0LO4nuYxDsuR6HzRwDGxBjtTQZgr+iroATtj+5DlNyYWsXDXGPeV72d34pbuxMH
	lQenTyQv92jhnnChTmUSZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781640187; x=
	1781726587; bh=LzL0iFx76OWCcDyEnU1AMyXOKZ1hH+LY4nUzP/7NEUE=; b=C
	nmGoK7cQfwg0zsr9f4NUjE/YVffiu/HQz6W8V3gPMICOgRmc0SCawy5GZVmim6AY
	alkqK2whwptGhWtPOUKvJElwX0LB8K3snJtbw4ofaFrIIegva3IOZ5xsHvcgptHA
	NuVrR4hsh54aeL/DROdT8C+byeSXYKc+8aR6v3fXtDhIB+EBt/ofYlH8w6xxbz++
	YkwjahZmKS6txAtvacJykj+MXDPYtgf54ribhRTUWIyUepRAdwJuLLDBRdH6yHVp
	IouXNU9dd8QXopRNVyzqTrtovPy/dRGiu+I6cJQM8gLp8K/G4tI8GUJVUFoN2R4q
	jlGto7ZqvgdKTiBQrQhxA==
X-ME-Sender: <xms:-6sxar6y8Q6bbo9BZjFLcBguisDrltt3glXxgtCHh0KmMyuYEDhxIjw>
    <xme:-6sxaruiNuqHXu2neeC_qFZ4_5BkoJHfzxv-kEynG8bIwXm9m3WpMbRzqmTmzFW71
    wTBCqfYHzF5_WIfAmco6bz0OFKK7xwQ4l49K_sa8KoFWjq7-yRn>
X-ME-Proxy-Cause: dmFkZTFQg89f42Jo/Kf5NS6pWKtfJi0P6PjlpCHh5iROBukkdTmuhMGovCVRqPKf57UXWe
    Ue+83ZzcSKXp2v8YYrsco0uFHLVfwlmvEJc6JGnl0uATIhUatpfUN8KDAPykLQohKbA1m+
    aiDo9ePHJqeYQmTXKAZghSEDggzKEUkT4XOj1KNopdcD7+49vEGRD3BLssggGArs6tWvgN
    0qdi5UiihM6P6HMTt70q4tAFwK9NaUKMYKxJ3034xb9pl/Hwub8rjxfsFhlQx+PDtSH8MN
    dk8hgQxXXZrtZCn05NXr3jVoytdSonL9PdlOU+sYCzmPs/e7HWr8p1VGvVNBapSr2Cu8B/
    gLzj750v5n2Sw1Ovzrm/VaAhjTkkSAV8vUWUj7y2TLygDMXQETq++3zBphlx6ou53W+OYr
    IncAGgshpjbuPRQAFYcOkM9t1aH7fp9HrRoEUHXkETw3VheX7TRHHhhckdNZ9JRW5P8WV3
    jMmX0H4H7VGI57nCqDx4SAq0iSgT9poYB3KYZd+fHH2DaZgInRvXhxF+nC1wx07bnuPnui
    ycyIm1HDeVB9tyFegyBtgcKxkfw9UgvcRz2/YZwigLSfxt6D1Dr+BnFPtvnZPyD2OpJ4iC
    YoHxWC8MqqgE2YUttJokiBZOHkmBbrQSKgpXnxTC4ItRBdGfT2ZiW+Yz8zgQ
X-ME-Proxy: <xmx:-6sxamlFJuimqIQGHCXNsu6E4xanVa1uu7T4WVwzOib5XwCMtk_vig>
    <xmx:-6sxarwsTm15jECCePTk3uFcw28sJvtvMw85nzI6AQv11Txbh2q2aA>
    <xmx:-6sxasNxkPVUhPhNJ5TEgr5o40GLpsnaTTVO-P7KDtOBz2Vae4PA3A>
    <xmx:-6sxanSNEezf1tq_bgfmQkdRuKwX0Np3xsduZw_trcZqz2GqmrutiQ>
    <xmx:-6sxaqfZRKanwPF8fXf9Wy41ujtBpQvfcb57IwQwasPRBjzJJG2lBVrw>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3855D3021A92; Tue, 16 Jun 2026 16:03:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5otprVY9DGc
Date: Tue, 16 Jun 2026 22:02:46 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <43cd8c48-c933-4eef-a6c0-970c38885967@app.fastmail.com>
In-Reply-To: <aivvE6gVMGWhRbCB@pks.im>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <non-ident_trailers.8f5@msgid.xyz> <aivvE6gVMGWhRbCB@pks.im>
Subject: Re: [PATCH 2/6] SubmittingPatches: discuss non-ident trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026, at 13:35, Patrick Steinhardt wrote:
> On Thu, Jun 11, 2026 at 12:22:45AM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
>> index 0b12badf86d..51c308a89a8 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -474,7 +474,10 @@ These are the common trailers in use:
>>
>>  While you can also create your own trailer if the situation warrants=
 it, we
>>  encourage you to instead use one of the common trailers in this proj=
ect
>> -highlighted above.
>> +highlighted above. A trailer that credits someone might be more like=
ly
>> +to be accepted since these are the most common ones. But another kin=
d of
>> +trailer might be relevant, for example to link to an issue tracker
>> +belonging to a downstream project that is affected by a bug in Git.
>
> Hm, I wonder whether this is a bit too vague to really be helpful for a
> newcomer. Instead of alluding to such trailers, wouldn't it be
> preferable if we added those as actual examples to the list of known
> trailers and then tell folks that they can invent their own ones if
> there is a good reason to do so?

Honestly there are so few non-ident trailers that I don=E2=80=99t think =
they can
be listed as common trailers:

1. The Git project doesn=E2=80=99t need them (e.g. no bug tracker)
2. They seem mostly for use by other projects (bug trackers again)

With this list:

    git log --format=3D'%(trailers:only,keyonly)' | sort | uniq

If you filter out the ident-looking ones:

    grep -v --extended-regexp -- '-[Bb]y$'

There are few left. And some can be discarded:

=E2=80=A2 Change-Id
=E2=80=A2 Message-ID
=E2=80=A2 Fixes (pointing to a commit)

So to address your point:

1. Maybe this is so niche that it is not worth mentioning; or
2. Maybe give a concrete example like `Closes: <bug link>`?
