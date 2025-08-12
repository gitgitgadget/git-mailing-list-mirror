Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C19280037
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022980; cv=none; b=qHr4f2qgL5VV3fyPKIYr7VFMyaVa/EsNQf43GXncPvaN6SG7rwXvRvvPzpx6oIsT+kqb8/9Z8HQZQD29CPw0zJOhYnHh4zwMB4hlXrYF1Erp6Fm49ablo3jK7nQEOjLsR3ay13NefyZfJzMR0/YgcicGwyh4tr/SfIbhlWxqrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022980; c=relaxed/simple;
	bh=pI+Dfpl0cJxYNGXTZDXAJ+otpMal1TRt7y9wrmHAB3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUS+mq43PB7XMD5tq0VhQR+pKcocUB2vrsR0aCS0zONYMZgBTJGfhSUBPQ3N4ZgRhPC1vgOfPtm5NL1/UN+H6LW3GGCqqHPnVIDqywR3utz6nhBkxUZWELvWPRtQ4cg1O/9XD62LGbohHSNuDE1VLl8MKzfCVh8s9J+C+d2B+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X7wG0JvT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PcWMej0B; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X7wG0JvT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcWMej0B"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C90427A0182;
	Tue, 12 Aug 2025 14:22:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 12 Aug 2025 14:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755022977; x=1755109377; bh=4cuFCQg1B5
	sKg/ySI61jAhIGidZcUGqYj5a0IFzMCA0=; b=X7wG0JvTVmzdPbjpil1RCHfGF0
	/mJTRQ0u4L7DbHyimbHVcCQ8DousNlClJay1M97HaLhWKG2UmcFavrUtYoAT85zN
	hFHzeo2EYRKeTNeqNMC0HwDw9Yb9hQCh2NE8qPRGgegU2Zxa5nyKHZdTFhO36lXz
	YmRypRbAp2m5Q3NvBdsHjk9fOWN2lvlPBtN08JHEv16TCa8WRDRs6rnqNLQf1iIP
	R0pr0A9LVPNYIrX7blCuefGJ+8b2jugsk47Z0lSBsl444aPkQDbAPFfUayeXTBJ8
	21RKGI4K0ejSLhH2ckhaXSoPC4o8l9XXMO095W7iINsKdm1GPB3JkJ7SZTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755022977; x=1755109377; bh=4cuFCQg1B5sKg/ySI61jAhIGidZcUGqYj5a
	0IFzMCA0=; b=PcWMej0BBKQhSZe6ohFvz3hMybfjREUdS1zxrSGLRDzUOxdAfGD
	/gz4zWA2JsafhyXIIai87QSxWi4XOzJVZKHI2zolAaVJnZBuApdyVJc2EsYegtej
	NH7vsEK1Jzt7w9rx4p5Iq6UnA7QqQVpDrPDfjSZKDalk364YA13YVVicT6yZsJA2
	HDnT3VkOLg+geDFfEmwsdq6dHeI9thGE3fAFmWrUBpp53f2v8VoXTdBg8DvKS+/V
	NmvL2K4ZjlZ27rtj+UJVnPllV6//hl+8o9qYi4BfTRYAQnLF+6li3iGpFR9KXnPQ
	07hpTUd4W6LwpSCm0XGn3xYz8wj0y6R0x0g==
X-ME-Sender: <xms:gYabaKDL51RC0ubIcL3vwaeuQjOKhYO-81KEE47tHXUP7f9sW_OI0Q>
    <xme:gYabaCFPZ8owif0SxrBeedTgiFDFoyyuXrYmZW_d_wky2ZblbDUMcr7V-2Q52RMJh
    ygqgLlGP-kBAkT1LQ>
X-ME-Received: <xmr:gYabaEDFLx71kTIjUv05yz-XJLbE05yU4K8BT2T_Fs96K9Rau3CzMavYyZzDzSbaq3gScl6hDPYJB7A8odbZvy5HWM8ZxfybTeScKRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfefgvdefudetudekteetveehiefgvddtjefftdekfeejffeghffggfeggeef
    feetnecuffhomhgrihhnpehmrghkrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuh
    gssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:gYabaKVQQ2SCTcglz8pTNvTaLeHKKfotwIAM0DejtgXhL0InIef4Uw>
    <xmx:gYabaAr0huviNA66Gq7PKeYsk-vyasvaTq5PvPmbYLr_oTYbKkqQsw>
    <xmx:gYabaOQ_yaAvQ7j-SBvQXxQfwjd5vE3hbwVnB47p41h8PNG97_G2JQ>
    <xmx:gYabaC0HsHF6JQFMG0Bg5YqJiL0dly1P2P-xf94tM1g4w0YR9c5ymw>
    <xmx:gYabaH-B8MSGoHrjeIGrq33CMCAnWr2NKgDjAyvIy3V6qHxwAGVOFyiT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 14:22:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  "D. Ben Knoble"
 <ben.knoble+github@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/4] clean up some code around editors
In-Reply-To: <CAPig+cQMa32G0pqi1UU6hqRAB5709Zcif0pd5uWifqB8d9o6rg@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 12 Aug 2025 14:13:01 -0400")
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
	<6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com>
	<CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
	<xmqq1ppgv3wg.fsf@gitster.g>
	<CAPig+cQMa32G0pqi1UU6hqRAB5709Zcif0pd5uWifqB8d9o6rg@mail.gmail.com>
Date: Tue, 12 Aug 2025 11:22:55 -0700
Message-ID: <xmqq8qjotn5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

Eric Sunshine <sunshine@sunshineco.com> writes:

>>  ifdef DEVELOPER
>>  include config.mak.dev
>> +all:: check-developer
>>  endif
>> ...
> Not a bad idea, though I don't think we need to hide the target behind
> DEVELOPER.

This target is designed to be a collection of light-weight tests for
your uncooked code, so running it when somebody makes a production
build should *not* be too costly, but at the same time, it is more
or less pointless---if it catches somethig for a build engineer, it
is way too late.

On the other hand, if you have only started to add a new command and
trying to see if your skeletal implementation even compiles, it may
be annoying to be told that you still have to write documentation.
You may already know you need to, but you are not ready to do so
yet.  Even though I on purpose made the checks run as part of "all"
to give the target more exposure, I am not sure if limiting to
developer is still too aggressive.
