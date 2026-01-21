Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C9314B62
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022166; cv=none; b=PB0Q0Dz+aWp5qaVVw99E87Bmi+UDnzZCisbK64h0X5G9LvsUsX38H/xf1BJKTq1JzVnJRfaToE8rjo72tTa68BVpvJM4aOLtiitbPDFcCn+DtiI88OrkJEWJZargK80NDLeULgdzbzWfFUwXXrXoqfy70m5ItwXjgx+WiTSON4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022166; c=relaxed/simple;
	bh=JnDd8dsq74PpLULSH1GHIBvDEqN+v9g0GwEle1ffSG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kqlDvniCmrOIPKcMFT7JcoSg+HarQzrawUZVYrJRbI8Q1xXMEz77pR7LnT/PX+iWqm2EEj8yZQTL/QMQI2xeNHoh5lVse2VuukBF14hm3a8AY5Z8Q3QieaN0RpViMFflmSf6333J4Z4vEgC7NBpsuHITIoHtRFgw11QOdghF4Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FNyTiHpx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sDaMHzMq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FNyTiHpx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sDaMHzMq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D05B1D0011B;
	Wed, 21 Jan 2026 14:02:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 14:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769022163;
	 x=1769108563; bh=gs7MuQJlr1xpGD0dOyQR6YdIiX0CGYY33zsqyL47eHA=; b=
	FNyTiHpxJp+Mc8spFChdW4+itLgrbl7Svol1bmsT+vEPyi00Gyxx7dZWvb6jcXTK
	z2e0sKLIirdV+7kzHHdSXc5JlsxqjvYWA1DO67q69LtwEer0Nhbq5SZq2VP0B8Re
	+0h1gzOkzR0v4LvJlqInk3zCLoG76XQNOLogj0/A4ImTZaSWt3xlX0N8EpanlXky
	djum8zx6oxuZnU2ojsmS7DDCcY3SHD+Rj6Vr6g8MFl1vL1w631X8qlBVFhcD6S44
	kyBqiSOJ+2VPRVWFZ0CSxZ3r81GrvJUFNuoMb5+zyK2PhGRqp4W+WSW2W5dXClYY
	N2nfVGgWRHwOUQQFNVEthg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769022163; x=
	1769108563; bh=gs7MuQJlr1xpGD0dOyQR6YdIiX0CGYY33zsqyL47eHA=; b=s
	DaMHzMq/ED5DF4AOly853wa1xuOwuXH3LVYYZ/f9BHrN5XdgRsBbzIKajzhOZYbG
	jxk0084CNlwdLWg7C+eBE6Stk3ci8QXgbmUtQnSy4fK2G3fH4MiXUPTU2E+DkaYG
	URjdaHyxrUMOoGCyEPkO27iL4IIDnQPvtyNUxAbXjlLcVhcw5R8/EYd3ihB56Gde
	PTVn+PwXBKZXNRDExolO2fpvJ4Z2y7JJYgU3yriucCJfE/AAZtduNrwgaSqkmuRt
	cgGMqmeap06SPEHAEfWxRlKf67cTJm3z9gJMd4jWo5529bOvgmGy+o8XwqOE4m59
	ZKsm5X0afYzw8wBccMFLA==
X-ME-Sender: <xms:0iJxaTJ9XnVbdSbZ_7kxRvHYD-wo_Qng8p_hdxUIjX90oVhau0EHhw>
    <xme:0iJxadi4OPYxejDaPyil8uYCv3wd6IP-mxWI0i0A6oC9bS_duF_sIt-1uXoeHHu_N
    ycz-ZuAR2q_fIqWHUnHwct-3sstUxNOtP8nAi4pIpv6wDiCgVP0>
X-ME-Received: <xmr:0iJxaX_lSABgPTHWIgv--w7QIsDnB42PduB2vircNS3FCVKaoqbyaeqNUauGxrIoJ_T-xZjsa0j3R2Tz82rWIv53ZdrtYNI5c8HZQDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtg
    homhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehm
    rghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:0iJxaaNwu7WVskelMwBL3w_pwspOiPVtYhA7a_DvZXW_ePvaa7JkkA>
    <xmx:0iJxaTByL5Eewgbe9T6i8UzBVBTRvpSeIG9A_RaJdOBufenphtWhow>
    <xmx:0iJxaWMKtWPjd2JraRT-QvDWKdQNfIVq-nmm2U5SRD0KP8NdjqT93g>
    <xmx:0iJxaSdBnAJYMMOD048bqKnhd7psf5qY-ohZv_DAoDjpKDyrIKIDbw>
    <xmx:0yJxaRiHXaEvj-g60VxAAD91CJiurss6VYL6hkPJGgKV4CNVz8RrxkaY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 14:02:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v11 0/8] Introduce git-history(1) command for easy
 history editing
In-Reply-To: <aWpoMcgwsfRCCrr4@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Fri,
	16 Jan 2026 17:32:49 +0100")
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
	<20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
	<CABPp-BFbUEGqNAeUtUghLd3oKcZiD88P04AYuTtY4T01F1rzdQ@mail.gmail.com>
	<xmqqy0lxa8i6.fsf@gitster.g> <aWpoMcgwsfRCCrr4@szeder.dev>
Date: Wed, 21 Jan 2026 11:02:40 -0800
Message-ID: <xmqq4ioeu6un.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Jan 16, 2026 at 07:21:21AM -0800, Junio C Hamano wrote:
>> Elijah Newren <newren@gmail.com> writes:
>> 
>> > On Tue, Jan 13, 2026 at 1:54 AM Patrick Steinhardt <ps@pks.im> wrote:
>> > [...]
>> >> Changes in v11:
>> >>   - Fix overly clever `BUG()` condition.
>> >>   - Drop the `struct replay_result::merge_conflict` field.
>> >>   - Return a positive value from `replay_revisions()` in case there was
>> >>     a conflict.
>> >>   - Improve a commit message.
>> >>   - Fix check for whether `setup_revisions_from_strvec()` was
>> >>     successful.
>> >>   - Link to v10: https://lore.kernel.org/r/20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im
>> >
>> > This version looks good to merge down.
>> 
>> Thanks.
>
> FWIW, I think it's far from ready to be merged.

Will the discussion continue in the other subthread, i.e.,

https://lore.kernel.org/git/CABPp-BHkNLdH4C7U4sFoVhrsSPH8KAaDtOdLEQGyajmXZz9hVg@mail.gmail.com/

