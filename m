Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202917579
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972065; cv=none; b=lMP5r1vyn4Pmm17JDplNLufd3mxate/z2AZ4lhJBDfb1H4qFVhqm+eohHYTLJDbFIcxxdS8vUEZtamj1g86/LJIyNGNY9RZyY/uerLXqr+4PCe9/p5JpF14wrQG8mY4uL6lWjvovp3IKvB3huMba0QmPyzPExFha3BKX4vQnAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972065; c=relaxed/simple;
	bh=Mh4oPDmzRCqMlM0b7Ve0XuQpVKhJdldkCrxLiLbaDEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dt2Zl82xvT3bxENKHG/8AmlYifxHAAaLcydYDsse2CVIlfBpxeZZiy3QJ+EUINiVgRH7dO9rfZfQYOK81qDwoOqsArDT6bHBldjlBK+UfHj+OTESIyINtDcbWk/emjpLBgMdbxdS8YmsDCeTIIXkwujWfEt26xZKPohXpoRieKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FGunL0/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZ/6SDj6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FGunL0/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZ/6SDj6"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E4FC31382CB7;
	Fri, 14 Mar 2025 13:07:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 14 Mar 2025 13:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741972061; x=1742058461; bh=hGy4u9okyj
	LMCp8XvZqn1jXHwcBy+mrJbKK66dMzPtI=; b=FGunL0/H73vPKdAPaHrbYS96MH
	3dBYmsDtifPxEikB+AChD9n58BYqu/y0sGvA8cvsR4vdBUd+rl2tcdPAx329rIsM
	LXCRabQPNRBSjU2DJgCZ4x0zEMdyqMsp3OGQFcvnPLMcYPl+tvrj7ZnQgR5LJpbf
	djDKWUNOUA9zTYLqZqoFhlc7ARFMn8CUJnc8G27JbdudTA7Psb5nTgV/i3op7ucL
	eu6/XODQfokWOTvIde9I1qHUq/JNl2iFpo50JHy5cjnk4xN0RiqaD5il2wnKM6rR
	qKIbKfzs+6BoJH1v/mmURcKQmdB1FBsa/BqG+DeCf0EK6jOO8ICEdnoLcFoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741972061; x=1742058461; bh=hGy4u9okyjLMCp8XvZqn1jXHwcBy+mrJbKK
	66dMzPtI=; b=cZ/6SDj6ue8yzzI5gEbVnX32SdMKp/ERWiFk9GHzpmH+fq8lVPD
	GVHnHgF8ELFEb+JDAnH4hqPmSLpHyxg5RMCpXeL1ZHt9oqFPSbG1NkbVItbHm/v2
	REQFSiq35GjhZ0NkLLWprj41PE4ylO2rZ5dHh+F/v2uYczROpqgYUMRBVU0iLucB
	100wVBcU219mOhXol+8VVPzGKfylLTirQifu+bYnffAJtKcB6asl1Ooe6dQ6Oz3g
	fDBhDihKr4wBDJYKUoLcz/ZdT7uNammBEBmr+4olY/DrZrcQj8BIdAG9uhE3uupg
	gylc6Wing1MnSi56UEDEdJUsa5whCqkXLPg==
X-ME-Sender: <xms:XWLUZ4S_SJxv5kDXXHpD0U2D6EaOCoCzmBSEZZsA5060BEJzvuW2Tw>
    <xme:XWLUZ1w_sDTlVflatXbvdSIT9P5JXuY1m9vBikdjxRXhTg3wOVnENftzt2u0jc2mk
    QGNj3c8KhXJrg7CIQ>
X-ME-Received: <xmr:XWLUZ136J_AkIzFZeBa7Pna0W7-qbsl-4SoPIC8Fs559GsEMQuNdyr7hgTyij7TpXNlBEdUI_vTW4avROxwAOIZiy-chVTS5yx-KXJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrhigrnhdrph
    grthhhrghnihgrvddttdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XWLUZ8CTlOS6rbZgZhciXzI5NAsTULqJ4e-hVErfQH-pwSs46vBRWw>
    <xmx:XWLUZxgtRcELc37_5eQ06JFCEMSwaOkEJHFHxGk2tyDZwwskeMogtQ>
    <xmx:XWLUZ4pf_lNCMk8kr5rZyoOootOs0mkMnh-4fbHOyCLAmMXqwSl1ZA>
    <xmx:XWLUZ0g7-n409VhyEQ2ELh9MlI5H8PVBgrza9sCuCvA1WDCEf1f1ew>
    <xmx:XWLUZxfrbGdA6IzF8fNFE0G48Y9D8T5PpykyeT0wYP3O-HykSiodn3QD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:07:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aryan Pathania <aryan.pathania2003@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] t9400: prefer test_path_* helper functions
In-Reply-To: <gm67nhqkoa5adxz5ifckpvecn5f5hewubmcm62nr4hejlwbhsg@pmo472wkj7of>
	(Aryan Pathania's message of "Fri, 14 Mar 2025 21:00:22 +0900")
References: <20250308090358.25429-1-contact@aynp.dev>
	<Z86LrOEhH3CJOIey@pks.im>
	<r5572ospfh3d7nwniod36jcy5ikv5pkmiwtqj25ll7p5ts3zay@okbxrhy77iyv>
	<xmqqplimxgkb.fsf@gitster.g>
	<gm67nhqkoa5adxz5ifckpvecn5f5hewubmcm62nr4hejlwbhsg@pmo472wkj7of>
Date: Fri, 14 Mar 2025 10:07:40 -0700
Message-ID: <xmqqtt7vilr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aryan Pathania <aryan.pathania2003@gmail.com> writes:

> Hi Junio, thanks a lot for taking time to review my patch.
>
>>That is exactly Patrick suggested (go back and read it).  I agree
>>with him that the updated stronger check is an improvement and it
>>deserves to be explained in the commit message.
> I apologize for miscomunication. I was agreeing with the suggestion.

Sorry for misreading what you wrote.  Mistakes happen, so please
don't over-apologize around here ;-)
