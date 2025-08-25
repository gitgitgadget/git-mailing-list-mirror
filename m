Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A919D07E
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136859; cv=none; b=sa0uf58RshmFh0PLwfp89/0PmxHAMO+2kjuJFEfp1ARtjhvINw1payLwxgW1In4Qya3vuv7XpSC27Hz6pyRtnsakm+Un2zBPALidomtQgrR/NcLg7Akmp6gMOs1wnAWM8dfdPB4TNQ14KkB6XNAy1YAdPjxIS3oPjKRxYX8h7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136859; c=relaxed/simple;
	bh=hlPCR73wAOAgSy7joZBYF4OpTKv62WExXQ5qxnWejsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ripWBfvPFdSjEvfxrJGtzBCSg4F5Ki5j4rkBZnjyGlisX86N8c2BynAfM/kn5PMbn3s42Fpy1Qxh2kj1cC6qCX0iZenBI4H6i5aj9MCSoKcLJhMgPqbIBx4CmOzFRPojGavnVAPjOoQfuRdSFVmSr0iVF4BxC1CAUlzIQuQu9to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cwUAW3M2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NEwtFRB2; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cwUAW3M2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NEwtFRB2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D16A87A0062;
	Mon, 25 Aug 2025 11:47:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 25 Aug 2025 11:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756136856;
	 x=1756223256; bh=hlPCR73wAOAgSy7joZBYF4OpTKv62WExXQ5qxnWejsg=; b=
	cwUAW3M2yIy9Z6o22tPI6p7d7HZa7vhAqFg15kjAsSyshmbmwoluF8fikY936SRD
	1PVaLxUX5OpQxUqwqHPTTRDFhtZh93QyQRQRY4k1LEbqLZje4KkH5Q+/B0NVdpgy
	8jkp2Fy81lhJ0shIljbUXQM1MdGvXYVWrM908mYzRYg+jbMWYm2oFh+GkmIISIcd
	I5lpuZYhfOcrApHS6dyC1Ao58c03nce8merAh2GGrfm4g3/3nExtE3Mfp+x7LCbQ
	a5PLDCcbGKo6BlHqNJx+MEy/tX9eU1+xENzl4cl50jYKM9qDcFtBegHDLkJDOtOz
	Hch8lRU6LANVchYQ0YLUFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756136856; x=
	1756223256; bh=hlPCR73wAOAgSy7joZBYF4OpTKv62WExXQ5qxnWejsg=; b=N
	EwtFRB2/4+PzUvFrkvAHWpPnlhPjHeWKvcE31BMGPXKj9mQpy3Ipogk1HTl5ghWZ
	ItVqqauo6N6Z0ivlB0R8INgG07CWJxGItzzvHAFdXmAJIWKzkN3iol6rdjJMBpln
	OvjFIN/RjBjeQMVyYokhyzJ+h4yhkfk8FuceO6aTLSSc46zOFwK+YTOIxtXcIjAc
	TqPkldkFxTZPiZ1/ztLb0EWCOlvV9nQP7LqMhd54ukzrlFKM6z/Ppc+Ryp5gJvEd
	fi6unHCfsHWLtjZVxrVu9IdXQH+FXquPw7WrJtqiKs3BqEIwMGy3AZkuaIKorJmb
	d4k1PooM/G8/7CApSO5gw==
X-ME-Sender: <xms:mIWsaJRHy3wiKtJ-7WOWn2mq7qpq-eEcTGCV-pZKifQpzk-Z2b7eGQ>
    <xme:mIWsaNV_Noc6aO-JWMeCw6RrcVXBU8Gzen1txeiIMtgAmPeBObnyFhCfCeGB_as16
    1O62nevF4XI8TKhRw>
X-ME-Received: <xmr:mIWsaLbZifDbfIHZiPERIlSVAfLF08zFqJs_Rvwqmf0EH7CWY62LmKxrAsq5uyRg0AwQGqz6GWZJkFK2o-39Ne2rFbM2iz6ksnALVqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepuggrvhhiughofhhfsegrtghmrdhorhhgpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:mIWsaD1sVHktWHCRaWdUbFQVHF6PrSHgUZ1_TYNft0gpB09piRSUdQ>
    <xmx:mIWsaNgxA39BnZSQQc8NLWSIUzQn4676ItsmKoCUnYB9yJd5lPvt9g>
    <xmx:mIWsaHZcL745_S5JmlfB5OC7YsHWF9rcme39gos_DdftvPfHankIlw>
    <xmx:mIWsaNRIMTO1NTvktSJzKQT_hRl-gnMYZhfCqAsd6NZMzFXnrrlQCQ>
    <xmx:mIWsaJ6-6WA7L64a8rJB9FMIKyXu53iBcLZ9G_-NKLX5KigXBmXIKEfs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 11:47:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Monte Davidoff" <davidoff@acm.org>,  git@vger.kernel.org
Subject: Re: Still use git whatchanged
In-Reply-To: <3ee1ba17-47c3-4090-82c4-73548006f800@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 25 Aug 2025 08:39:57 +0200")
References: <9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org>
	<3ee1ba17-47c3-4090-82c4-73548006f800@app.fastmail.com>
Date: Mon, 25 Aug 2025 08:47:35 -0700
Message-ID: <xmqqbjo3tnc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Aug 25, 2025, at 00:01, Monte Davidoff wrote:
>> I still use "git whatchanged".
>>
>> This is regarding the removal nomination message in git 2.51.0.
>>
>> Thanks,
>> Monte
>
> You can replace it with `git log`:
>
> • Given: `git whatchanged <opts>`
> • Replace with: `git log <opts> --no-merges --raw`
>
> ... with some caveats about timestamps? [1]

Not timestamps but about elimination of single-parent empty commits,
I think?

>
> 🔗 1: https://lore.kernel.org/git/877byxbtiw.fsf@gmail.com/
