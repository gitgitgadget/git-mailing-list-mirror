Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3281DEFFC
	for <git@vger.kernel.org>; Wed, 21 May 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839697; cv=none; b=NUj0EEVlKmbJ1ND5RyPwx5S6Ohr2cEqvtTPIq3PuOQABnCnkKV+xa/l+/rPAE31XL3ZV4r7B92wPqo+2SdyIkUU7OIWztZ/g7scjh/gy4Wj/xjdG5PHPxA+dURVqcCYTlb5pm/DXrBHCdgHwMePX+vzlakK48IoafsVJlHgdOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839697; c=relaxed/simple;
	bh=2eyNcb+tyM3nV3z9bk6sEOjfw2tSdbzVwokbPpV+7OQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bkCqM3QTuEhZr8iEXaezLKBX6IfCL4CalxLakOdk04jqPIcNgFygN1Hoc3L/QbbciLdKRIub0aLAMnneuhbXSGcnRfO4AzQlwI/kCT1IP/55X51qX9nDZpJ78tmO2dLTKaFk2IZcByDXKzWSjVvRAPYuoWeA67CdNudvJYU6r7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NojUdohL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t1Eg7/iy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NojUdohL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t1Eg7/iy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 22C582540150;
	Wed, 21 May 2025 11:01:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 May 2025 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747839694; x=1747926094; bh=YUEf573D4t
	iqKHJijWg3nrOU4ku4A+yThKt0MPJSDuU=; b=NojUdohLiPoPO9QKTlDDZ1KIZ2
	koyZNUTNQY1r5OeJLgGpIldcha7bH+kctiR2SW6QeYa9eArSoq6Xy0Yaly8KvcI9
	kNRAQTFqxH/YNfElqN4VMbI9z0qe0g1qAl6Z6YyWHWwopcKS1RKgjD8Y5ajVxs1z
	PkgeGVKYhnqLsFAEUs/6d5qtIJM51pFeZtk10crtX6v1lJ9wA2Z3JlviKbur1hI7
	risuDGE2EqZrIGl7Q3ucuQKxHudFu/F/LrJxtNK/kP84XC1AiJupRBANEafqTSIz
	SPAbBtLPaJ1AXusdAieZe4TowFA9sJbn1HKxoILyjinyVDbEWGAT0etbyvkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747839694; x=1747926094; bh=YUEf573D4tiqKHJijWg3nrOU4ku4A+yThKt
	0MPJSDuU=; b=t1Eg7/iym+0LcPQNAyd/XR9GybG4uJWyR/UXdhiSJD/yrRJ+eso
	FxdLoKq7xuyBmvDboVTEw6vyj3Oal3sQsERSSy9n/I+d4grVcEmrXapb0ldcIoiK
	40o2rTvr8YXi3+2kFUU9S4TmjOgjE6dHo1LNYqlYK8gfSNz4zqxqrbEafBMIM82p
	TgUev93G3fhURZklM+0LvNWKWPmC05Ij6F3C38MF1NvhrOltyMaBY9tG5qD3Na8S
	jhmyiGo87+bUMGgHByQxMgZ2iUIhvU6ZzG6QN76PyNXSt7AMJMqeyo1Q4P392BS4
	b8oe5RbTpjAduqrU0xB/yVT+MDvOIn+34Uw==
X-ME-Sender: <xms:zuotaCVJUwIar1AgzwWSvBQqxuXFskPx6SW8b_Wcw1oEj8AIOYZ0-Q>
    <xme:zuotaOl-P539j1hNZ75IMRD1-m-josYxSQMIHvoeMKVGZsWH5Hy-pTiukHFDvBjav
    vvaD94OJgJE-reMyg>
X-ME-Received: <xmr:zuotaGa3OgSJIk9GP--PCwtR3glHaGL1rzF6T9LaAQApLC2h73RvH1P62HrWxsQKND_03rt12ZityhXhYtMgAdEanjrr0tqsJzOdpL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeffeelucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zuotaJUmsVhrJYZ4Ql0pXYz0EdlP798lfkFwO1-ThsKCXQoortpRuQ>
    <xmx:zuotaMkPt-9uUmH6W7xzyeRtW4kbIJZMJqLURjpIjUkINo3VD6A3jA>
    <xmx:zuotaOfqUuUNbAgwxxwA4Xq-zcJtqj0rPBjR_n3KD_yYrD2dvzMYRg>
    <xmx:zuotaOEf63RKWtjftiiASPmgNcfaj3LhocipPuVqZ15psNqryjG-TA>
    <xmx:zuotaJ_wJD_EDzRBXyEdZBT29L_T-H0D4-aRjMMQVQYlTk1GO5SMax5j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 11:01:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,
  Derrick Stolee <stolee@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] midx repack: avoid integer overflow on 32 bit systems
In-Reply-To: <CALnO6CAMqVvHbY2sR_+dt8vYHxDn4S7f4B2jq+HcMEXx7SLj9Q@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 21 May 2025 09:10:58 -0400")
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
	<cbc5e69b908cef3800569abe79cb9c107f72bfec.1747753388.git.phillip.wood@dunelm.org.uk>
	<CALnO6CAMqVvHbY2sR_+dt8vYHxDn4S7f4B2jq+HcMEXx7SLj9Q@mail.gmail.com>
Date: Wed, 21 May 2025 08:01:32 -0700
Message-ID: <xmqqh61ec8j7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> +               if (unsigned_add_overflows (total_size, (size_t)expected_size))
>
> Style nit (only in case Taylor's approach doesn't prove better): I
> wasn't expecting a space between the function and its argument list.

Good eyes.  I didn't notice it myself.

