Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63D7260B
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973491; cv=none; b=j8ikT8zF+rT4CMiozF1KQ2vf3gv0ClUFyGdD+VOGrf4w0e7qwIIrhfo1jg3LPK08peZYPVfEnN4QqatDx3Ktt+vNK5Vu2brTcLf7UIThdzHaixE4FKILaHazncCwIL2dfLBKux7EqpGhsLw7jXkzJZK2l0sqPcAOJZnVMEk52BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973491; c=relaxed/simple;
	bh=Kr0RlKFt3f7Um6rU93WCs+FnwPl+oLQ2F2Im3d8t4bI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dn+zMo5atqp9nlToxrtYyGGohIuGnVAJQEqrZUvsQ0RITegOxyi1vgQ6gmbdq1XLA2JvuBkL+9zbvRWE3ABeHiuUs3rIQ9IvvPenWBMn1KA5/H/ZODMgIVVxrKmdTRHOXtmBOcQb5cdTQrR2XOCe2U8dJTEqEpm03a+nIXFLMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q/C3A4GW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nzhozSQe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q/C3A4GW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nzhozSQe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C3931D0002E;
	Mon, 20 Oct 2025 11:18:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 20 Oct 2025 11:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760973487; x=1761059887; bh=HgSPWQjiG/
	LfJKEKnwc0lX7DcotHPsovEj91hFrjFvI=; b=Q/C3A4GWz9Pj3zgFvv47YOJ0KK
	kk715rAvDpJLBwnDoC83ZK7RWs6ADAAG5GMMA77mIK/CyxaSRHsHDPzj2gpw2Xrg
	YLb3JtWjve06Qg2hwS0av7o0czwBFVDwgWk5B/0KkKMKLRzko4ZXp32dciLEhinj
	t0DajAybzH2AW29fQAHP4EPGf5ObJeNXmPi/aD2FC8OUaJ/iNxBYBnJs5D+3fHW5
	fZLrIae0rF/pir0wACJqdF/Aa8186DUwoaS5sUDi9MDKv+ArU2iZqcEa00K92/cr
	KbAmi4OccfqsHblHpY7h+eT2G54WPVbestIG+Lm+NIDYfBbPrnKRzl/dWuAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760973487; x=1761059887; bh=HgSPWQjiG/LfJKEKnwc0lX7DcotHPsovEj9
	1hFrjFvI=; b=nzhozSQebsA0U60vMbAYQ8f8fQZgHktirfnOtffL0qL/vbMM7Lq
	+F4RhWJrvS4RPWx0v9XZvNcVC/1lGkmLaNvWm7QJU09Sq2v59yZtES5/c9z/l0yn
	k1/se3QHrsGd31678H9S/sxoSmUSWUpE5PmG9iMEjusBL8N6aSH5CC1PS+rVkdZt
	ZKTzBZN7ugzj6s9E2M0GB1BN+8oZiYUp17Fk6fFNJDET5OKhP5vDF0ebFv1LWuk+
	Fd0Hil9FYq6I8ZllhckKozCFy58zyT+YG1/8h8mV/9Jg0I1CWbsC49er3qu5E0g5
	HaR0SQ0bS0g1onW3kLx27o6bJL5jc3cHAEg==
X-ME-Sender: <xms:r1L2aCcEdPvLEDUrOviU6hH3lej9zmf8P2u3D8Bf5iX3sawMkWb5Zw>
    <xme:r1L2aHthJ5XKeFbcwLJli5HDDjLyuo8vAIFSnuzmut_YbBD0-t_MiP98RKHd476HX
    sJnR7lWYYDL0QOWdXKepjxAWGADE59yi4xpKi0JOima386nll6I>
X-ME-Received: <xmr:r1L2aJ8tXvCX4KiN1QXj-XFiHytZnLl_l5QbO00d_iAQkUqnd7lK6U5VTsdebJnkchEUXTsWy-QERy8A_1ufyYZCG4LbkU9QmKru>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r1L2aK0DwBrkABuuPQIU55NX7ShHlVODO0XChlhBYIUqnYW1iV1B8w>
    <xmx:r1L2aGBYh1QXcbuR7T8wMxQfItyg2FNTX1gXzb_vwNi86yDfj0T1iw>
    <xmx:r1L2aOcowKV7lPIuYwW8F6fEfAiuAmOEKmY1e0S0m2c0pi_BZHO3Yw>
    <xmx:r1L2aL419jU9hmq4Aax7c_-zSpHofb6DdRCY069CoDrYEO0b2Aw0vw>
    <xmx:r1L2aGO_CW817spjw0vL4WG3CStW-eI67s8ct-UVDyMe95I0yakClB-X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 11:18:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com
Subject: Re: [Outreachy PATCH v3 2/2] gpg-interface: use
 string_list_split*() instead of strbuf_split*()
In-Reply-To: <CAD=f0L9Bu2xcOt98n_iB6Td2+pdniOP-wU_KyigJdt+3Oy3wxw@mail.gmail.com>
	(Bello Olamide's message of "Mon, 20 Oct 2025 09:15:00 +0100")
References: <cover.1760869186.git.belkid98@gmail.com>
	<9a6eb6ff8b92a94de990303cc78026029a669cf8.1760869186.git.belkid98@gmail.com>
	<xmqqikga3mqj.fsf@gitster.g>
	<CAD=f0L9Bu2xcOt98n_iB6Td2+pdniOP-wU_KyigJdt+3Oy3wxw@mail.gmail.com>
Date: Mon, 20 Oct 2025 08:18:05 -0700
Message-ID: <xmqq1pmx38lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bello Olamide <belkid98@gmail.com> writes:

> I am just asking to know if something like this
> should be done within the respective functions or I will need
> to write functions for each and just call here.

Unlike [1/2] that asked for the second string, this one just wants
to discard everything after the first LF, so I am not sure if you
need any new helper or hand-rolled loop.  Wouldn't strchr() and
xmemdupz() that were used in my response to [1/2] sufficient for the
purpose of this step, too?

