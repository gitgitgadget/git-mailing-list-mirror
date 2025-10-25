Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC04238142
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411472; cv=none; b=QzRa/Ne1jvBdbjDZq/07+4XoIXiIhfs7lAe3tq1DPbS2VHRs+gWGkgbqVEBOpBpjq03vDlEoq+D9iYAowr1PxRfFgkENX8zAzart5owZy4ufej9XLoBial46SCbNxO/DpzCqp3zmJ6cBMP27LjanZNqWJt9nvokl4hvkTBOIkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411472; c=relaxed/simple;
	bh=hw+04beFW9mVoYMlwViqvMRZaWhEoiwVJOiUdvkRfrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umRTpWidYbC6vqYAY9jyhkHpiGPsui7yixO4WJ4TV46RfUxHhoYi8XpLdTyf899+nEuB+NUQA/Ci0jL02ZqRhhQZlEZDJ35oCGKk/5GLDtXR0S497RLuzZVKXckvPf1EtU8UxpkJYS+aX3Er68RWhNkyY+vMk5CqWauecKRgnsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EKAChhqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tzNI7Brp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EKAChhqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tzNI7Brp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A118EEC0218;
	Sat, 25 Oct 2025 12:57:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 25 Oct 2025 12:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761411469; x=1761497869; bh=K978/rcJid
	LM7BwOS2aMrQVLsBq3FL1nUHxiBHuj1tA=; b=EKAChhqrtFZqdhTmXUJW6rsDha
	IwSqQw2ZT6f1HBOrt9JvvqkJtpsT8Co0AveQY0de45DwSj0LudzLqXiO/dgXB0Gj
	BxPgSsd1Ru5OgYf/7A8zG5Ui1tQ3a2oTXMUUb4m0vdrX50YMffjEp6e0TPKSYmQx
	VLuPst08b/iEIu4bu7p4i7QrMNDqwslj19jefrufW9+zzD+S71EYvbjBp7udbe15
	N+SZ9rGHcEG+ptfNArmCROVS0nPu4QswJcdltEAlMTrwK6osI3DK32NlWMN/LKpT
	uj/7yISb29+Plc5YVASmmtSMUdgXGWNnGd91dg5sga7xpSjVvdEgidRMU/Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761411469; x=1761497869; bh=K978/rcJidLM7BwOS2aMrQVLsBq3FL1nUHx
	iBHuj1tA=; b=tzNI7Brp53O4G7cTefmbFZEAaEFL6l8l5JVayCUEWrgiZJxK995
	80cSZh8kZUiwLsY7n1FgeAP+MYB68gd77Fgc7Yv75bY6/5sbPumzNVt7JCgpPhKo
	fh08bheXT7KOIhU79imnZOgh7JvO+Cc66/t7ijmwYGl7Z2u90IDc/IRfMERwg9y0
	4uF/SEv2A94pUfsZbtboZ3C5fYZczd/iZdnQpfrNY3XOhLLbTL/PHPtHCNfhbEvm
	RCGPd7h4lf5sld1RNitILJ+Yky0IYyZJWoJclFXXOcjcWc78kNBYNg82OmedYAVo
	gNC2UjsHnGm4G1Y0tlFWz5jB8dn9wKo0oMg==
X-ME-Sender: <xms:jAH9aMPlkXbwBGza--4rP8fyaZPmNbZD11qs6-Yz8Z7OvTuEAuNNmw>
    <xme:jAH9aNUahQH5OouFyF3mYjmj4PEkkJ6wfaAIqs4Kwpsn9Xfd1dtFgw1-zneh3fHow
    41dorKo0E4WpjToDQmLc3Pd_w7-KFK7YdBv-40SDQkmYahe2hTuuLo>
X-ME-Received: <xmr:jAH9aJZq6lqnUyuFYU3GXFCyad1heGbEX3l-h48BqQA08u-nqAOQE79DeD4WNnf6y8qet0z6mBzCCphLcld3godzOU_UOc34fFTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedvjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:jAH9aP1JQcMuofOJA3q0XlhPSFCHhqlNI5zM0ei5ukwcF1cXlCDt_g>
    <xmx:jAH9aNDTrPrKeMLYk5cq1EOw8ORQWFz12zQJA5PCpDMdoE5cAneFYA>
    <xmx:jAH9aL-CTdk50UqwW-12u6FXPctwQS2TY-HMDzLJAoyLsdQIChrLeQ>
    <xmx:jAH9aIW1b7RcmdMaChyBd1yp7YED5-gcgWoeZqB8-7mW2uchaT8FVg>
    <xmx:jQH9aHbo35sFdgMucjkrNDePQN2TQKmDKt6hlysWUAbGvdCbjqVZC2P5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 12:57:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v4 0/3] replay: make atomic ref updates the default
In-Reply-To: <xmqq7bwlv4jh.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	23 Oct 2025 11:47:30 -0700")
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-1-siddharthasthana31@gmail.com>
	<xmqq7bwlv4jh.fsf@gitster.g>
Date: Sat, 25 Oct 2025 09:57:46 -0700
Message-ID: <xmqqzf9encl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> This is v4 of the git-replay atomic updates series.
>> ...
> I didn't see anything glaringly wrong in this round, even though I
> picked a couple of small nits in one patch, so we might want a
> hopefully small and final reroll before marking the topic for
> 'next'.
>
> Is everybody else happy with this iteration otherwise?

There are a few actionable comments pointing out typos and style
glitches for this iteration.  I'll mark the topic as expecting a
hopefully small and final reroll in the next issue of "What's
cooking" report.

Thanks.
