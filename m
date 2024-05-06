Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C621E492
	for <git@vger.kernel.org>; Mon,  6 May 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715036916; cv=none; b=U4ZfFOyZ8PFUxwbBwjFN2zh/AU8D3j86elgrYuLMrbCtvrEhNtsQAtpEwstMtutTs4Gn42b11dBEFDFPMYNGaw8STXwaqc41mMs5BfbBt6sFRJLisQ4jPkJu41T5ptFtoI59J7ZgrJyD01Mxbf7JjScj+qQP/y4WRpHoRh1nu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715036916; c=relaxed/simple;
	bh=69y1t0kbXGGuP3Nx3Hh+wBpO5UeYjRWyRS5a/bWbUUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=oPWAxnjAF5vEymk349Cxvrk3XWFeVmz34apMwP/j5fT5cPQIHBha0C7EGRFbxMcjtSFy6F+I/4tywPjg3PzX0LvcFQuuYe9+m1stAVHQ0k6heJAOFd2fct4uRga2RtUUWMj4oUq+RhWEmN7sHeYuSrJFIXdSlkeORkF1B5bh4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=QnbH+s1F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MiHKKcHY; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="QnbH+s1F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MiHKKcHY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 20237180013A;
	Mon,  6 May 2024 19:08:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 06 May 2024 19:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1715036912;
	 x=1715123312; bh=x7hv4IgCU1J5AIeVv1AqEj641j2LrrpBEE5uPSMp6sM=; b=
	QnbH+s1Ff/F/4g21H16huNXB7ssOtqwtLDVM0C72663GQRnpwgjz7xqP5b5z4La5
	gP1YYgFpYkjA5+NjGzIx/1zjSCqOwzb7Ym/lK99cE1CbEzI199EhGuQldfED17m4
	gW9xVitZD/Y1C3EElezy1HovWYJYH1LYA2QJtsvqO1S+EfwfJtityeXx6pO2Uzim
	tXOvE7rmpn2ppTG+SjgsuZlODpAuh+MsQuzs+7UGQSgQbidQrSCFhuG0NSOJRg9Z
	ko1jpiDo/lc0YUQg+/6x0Myo/4N0lqsYkWGvq/rmhyi7SiTxATdpCFoHzp1Bs0Wg
	P0txpw8CyQzrqPSQVJ4XHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715036912; x=
	1715123312; bh=x7hv4IgCU1J5AIeVv1AqEj641j2LrrpBEE5uPSMp6sM=; b=M
	iHKKcHYcQ41vuFZe1fCq7QwehPjY1t2INUMgUem3vqAT2HaJpW4Y6PfGZObWUzx9
	whgnhTrU6d5sptsmco7wWMRTi5nMQpeVVi83YXHB+olEPH2bJAwPGSiWzVadlY4R
	pwtemuPRCp/APMFblh5OhBulbXivIlssa0eKWjWqWFAoQw0/bm2eJtinwJbJfoPF
	yU0zccj5HFGGedAwaJnrHDDVYuN5vBd1ha2w5Z3nMZ12yeT6Y0ABFaYoYZ1yTWMz
	VECFh27T63hTJ49XFzOVW0rTcaeOQmcQRtSlAQ4f3L+yhubNbyx5MZXn3+ufFkoR
	BUDD7Tp0YI2o8hea4ITRg==
X-ME-Sender: <xms:8GI5ZsT0FyzmjD2WKRufmHHsrY1GPF_39OE9GpbKRrG8_DQo3nn4gQ>
    <xme:8GI5ZpxrwTDnd6E16zs99s1eoMKcLHUtNqTgUVkH1LT9UwTTHHPnTr_HB21W_2_y5
    rPgOpbjcWS9qto_hg>
X-ME-Received: <xmr:8GI5Zp1ROfy17Qz6zulU7BWtB_ltSz7xwR7VrP_FmM5XgRWnZnZCdZEFf7rRoxmrqSJwwipCKF5wjj33rOP694lc3Jsw0OzMM-924Oai>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgr
    mhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrth
    htvghrnhephfetteetheetkeduiedtudehtdeijeehfeefheejhedufeffhfffjeffvdeg
    ledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    grmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:8GI5ZgA6WosrOVZC4iUj2uZN0edq3jq-fFDRao8LMf_KtAGzBUnAyA>
    <xmx:8GI5Zlh2yhlGokggljA42hkjIcJWYgeRIX0SKUwabx2mRHYFiG0rew>
    <xmx:8GI5ZsoPjsuRBq__-IntrJx4g3sIpJmGJaWdsvtl_gte_y3eESzIYw>
    <xmx:8GI5ZojGgXoW00KgUC-Iwf7_hoYt5Y5ZWoKHUr4y6V3P2ZAmu7Im4Q>
    <xmx:8GI5Zqvk-BwSg0WyCY2F5IDFJ_LN6u7Wm5KffPZd4czLxe5y7Ptm2f8g>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 19:08:30 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 09:08:27 +1000
Message-Id: <D12XUEC6DL6O.POVU09JJFHO9@jamesliu.io>
To: "Junio C Hamano" <gitster@pobox.com>, "Karthik Nayak"
 <karthik.188@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] advice: add "all" option to disable all hints
From: "James Liu" <james@jamesliu.io>
X-Mailer: aerc 0.17.0
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io> <xmqqedai959z.fsf@gitster.g>
 <D123HB68ZKO0.3C5RSYGQNO9L3@jamesliu.io>
 <D125SZ21UPI0.166ZOVLTOBCRH@jamesliu.io> <xmqq1q6e3n0i.fsf@gitster.g>
In-Reply-To: <xmqq1q6e3n0i.fsf@gitster.g>

On Tue May 7, 2024 at 2:47 AM AEST, Junio C Hamano wrote:
> I count two messages from Karthik for v4, one of them being "this
> round looks good", to which you said "thanks".
>
> If you mean the other comment about a non-sentence in the proposed
> log message of [2/3], the copy I have in 'seen' says this:
>
>     doc: add spacing around paginate options
>
>     Make the documentation page consistent with the usage string printed =
by
>     "git help git" and consistent with the description of "[-v | --versio=
n]"
>     option.
>
>     Signed-off-by: James Liu <james@jamesliu.io>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> If that looks good enough to both of you, then we can probably
> declare victory and mark the topic for 'next'.
>
> Thanks.

Yes I'm happy with that. Thanks Junio!

Cheers,
James

