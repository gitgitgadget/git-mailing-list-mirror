Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049212940F
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411200; cv=none; b=neZUS6TzRomqzTd0BMHhnJV3XyzbxSP1zR0h4GukrOg6Y68sCS6oEcntTktHUPHSs9O0KBstKkDAIDUS1fut1fG2cDgmaeJ7haCcOw2vJgiJbVe1a4uwt95d7nF9EhPswequWuwzJtjkL/j+fMXjOh3aBHNxzAceS6F/56pJBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411200; c=relaxed/simple;
	bh=0qQsRA417i8PcGrs8JRHixNHPQYi0FMuMHNojCSZ86c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oWpJRD7xmMgFQySBEJtnz6njNDQOHOEKfeoBQQKIhKTMAytxToWlZorxGBeCozALmBl8dkH3j+Kv0rLJU845M8YCDTFSnDIexOMIeHZiyGOXprSp8BHLzREGTOcHbY3HYsFSU+hj/vInl5RbIaMtvw3e3U0OqWPx0CR2L7QvHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sh9a3yz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g6SHguHc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sh9a3yz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g6SHguHc"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06C69114015B;
	Tue,  8 Oct 2024 14:13:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 08 Oct 2024 14:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728411197; x=1728497597; bh=HCR1e4Hdvm
	X2a5iCTn114iTEw0hx7xnWSvthylReGqo=; b=sh9a3yz0je/Bbptc2hwXFZEU7b
	XhY1/QR/yBcltJS+IbECKvZprRMXLt8Rt4VWY+a32V0RiA0c2L0TTPuaKbx6YM6b
	xMB7pvA4F7sl8Oy8a0Dou5zQ/+KCxYODR2QlQzdZm1PkOmzqZsSBxTP9LIkmcFGG
	hoTu0E3BTtThXrFkIqVbTVi92YQrXAWztayhDnbw9WEA0bo8ug6PJCzXBgtdbq4/
	dGk0Cdw8pPrfKQHgzN09U51fmtozxW/AdaFVK5xBjfVsz3c92mI4FGo53BaRvMuZ
	YTFiqhtACcwx2GtnURSf2aQMB2X/SwaOikqVwogXlzuea5BQr87fNAMJM4hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728411197; x=1728497597; bh=HCR1e4HdvmX2a5iCTn114iTEw0hx
	7xnWSvthylReGqo=; b=g6SHguHcWCDF8tO+ulqeGofuOup1B+JmYncPcIuOz2Ek
	tq6zoKZeHQ01kT1fiNwfbFyWaIkcWh9SILjjsGwpkD0bQ8HJGdsw6GRfo7XZvGuq
	8HeFH+nTHPKS3ys/wzkh432ljMK2msksbxpspD8ACLrTeWJWrdTUsBU1DuGLDlnM
	gJkC9uZPD7ZN+lDWI97Fxf508WcqyxpFEjpcJvvsDyb1A81bHvJmF3nUnTsGyIo3
	jYWrG7yWVS+u32Y3p66YhO4JfpYATkfXQfNFZxLZ5uZ9NOs8ZOzWdSXNgvb5Dwo+
	uO2ujCbLu9LwaOIGKpsV42eU/xwgbvuiiqkA8PHMhQ==
X-ME-Sender: <xms:PHYFZygXYm0Qvmy845JmW53wbUKRGgB2_-5h1H9HYsrBHCmNTYe2ag>
    <xme:PHYFZzDoZwTEE1bkqO_hCG4URmmwcgTPhTvKeH_ezYKMx1YeaeQfsNwage7lQr4Ox
    R9tx89zY3Q3UFOk4w>
X-ME-Received: <xmr:PHYFZ6FUed6yQMwsHkpP697HQ0NotydZVw8wTxfCPuoSrKoOFLHy2xbXKspuDYZl-o2Te-53O0X6i92eE33b2-XauVb6h0o83C3Lt1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrg
    guvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PHYFZ7QaAaOVka5Awq8bsIQ-KR4e03sbYbWcaeLn3M5MyZXlPQ3khw>
    <xmx:PHYFZ_zaqVeZEZvCaDh3IHJ-qs4ULGu3T-GrCdJXgk7g3Vic3KN65g>
    <xmx:PHYFZ55BR9c0iLlM0E1TSR1zTcRPaHUqLmvnfYBKPDe4i8x1OGcEUA>
    <xmx:PHYFZ8x1kKKisMSoitLtcSZitdnIT7Eh030OUJiykjm2tHKe0JVHhA>
    <xmx:PHYFZ2zeWxZg61pyupD36O5om2WlXsUgnLtj-An9u88MhgXjGwKrQYwY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 14:13:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk,
  christian.couder@gmail.com
Subject: Re: [PATCH] t7300-clean.sh: use test_path_* helper functions
In-Reply-To: <CADYq+fYZSGBTnO+dM+MtHj=oUMqDWt+6wu-wEzwfWQJkSomkWA@mail.gmail.com>
	(Samuel Abraham's message of "Tue, 8 Oct 2024 09:58:44 +0100")
References: <pull.1811.git.1728328755490.gitgitgadget@gmail.com>
	<xmqq34l75pr7.fsf@gitster.g>
	<CADYq+fYZSGBTnO+dM+MtHj=oUMqDWt+6wu-wEzwfWQJkSomkWA@mail.gmail.com>
Date: Tue, 08 Oct 2024 11:13:15 -0700
Message-ID: <xmqqo73u1n0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Samuel Abraham <abrahamadekunle50@gmail.com> writes:

> ...
>  This was the reason for replacing "test ! -[df]" with
> "test_path_is_missing" where I think is appropriate.

Telling that concisely in the proposed log message will help those
who are reviewing the patch and those who are reading "git log -p"
later, and that is what I would want to see after a review exchange
like this.

Thanks.
