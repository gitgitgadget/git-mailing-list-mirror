Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB51DE3CA
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600887; cv=none; b=VNlFCdpVIbt7ulZ3N/UX4i2pKD3rczk/JoLp3f5yIq8AlddoeNaZIYYfwLuLbm+FfKh7Vb0OAuudxjwzLvdXgV2Cd38/7KUMdFGviR6lX2OORZj/pVNPQiPjdPXXVoJWSpBnPKr/NwnZ1VzZzO/cBrX3ULJzTnNy1bXcDlbu328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600887; c=relaxed/simple;
	bh=YBL5TvH+MPHziZr8DFzjgaWEs8FJpjm0/iF0AlZHBSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9u6wyMo9RFRIAjH4g2jAv0bVtebgdfPPMCqhO3wb+kxm6p2x86HmvWRFgkB8DPLfjP2c98WwBiDAghH5kkdQVoKHoD/l8wrb+hQqsUPtcIXv0sw/Lei+8YLMulci9ryKIzjhY2HbE1yzMTo9OAaxGu2MLvANJu7sQWQa0FCshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qbhym9hZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w58QW2SZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qbhym9hZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w58QW2SZ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1C3925401C9;
	Fri, 25 Apr 2025 13:08:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 25 Apr 2025 13:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745600883; x=1745687283; bh=vjgFxWFrXS
	+B2P8k4vbI0GtuloBvXR3RyUpYME5shJg=; b=Qbhym9hZvKs02ljvPmtjZ0OjiL
	qtab9xHSYFO9wks9ov6fpiFebQV4khO17JRC+1xn/r7BLjd8oX6LuBHoMyF6I90W
	CrZDzIME3D4eTtzbYBzDzuciQmRjnIx4UGTVK03RI5VmnJbFNuJUbqPU1j4vY9ID
	0vcZJXhb+duUgFzJf9iNZi4gVrQY5wpGsQXhw5DBXhzw9QgSuyI1BQdXfKwnS2oS
	g3WvpsjllRWY8KuD+D/+g9HvV8Q4SqDXbdPVYi27KF/PiD3ihmi7Ni2J2FbuYHVc
	TFJdvp8sKLPGc/kjiDah7D47d0qO/8AWi2pm7zgrggiuOHLIkSXWidMje6ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745600883; x=1745687283; bh=vjgFxWFrXS+B2P8k4vbI0GtuloBvXR3RyUp
	YME5shJg=; b=w58QW2SZDJQQnb07qPNxv8mZUcoMDJzuVWaTl+LDhjCUygUJcCt
	Ya9TFngNtiFOojL4Bh5jY51nuhO6s0CMT8NCvs3CtjyV0UwPLd91LlKDiGC7UL1P
	88zJ+ovPuWQiwdax7nprPXcMlecIn1ZrbfRu8lWpDW9wHA6qsRvXVSkym9BHzOho
	zAzKYcyWuBE+GRJ9dI7HSO9clFD4Z4EvKYMzrXrbwuYTUf4+Q6sdqdCzhMzPnmof
	w7F4USeF6AGlGJoyeJZRMUEoQnuclqk7WYudZrBR63alUjrMF0ktCthfAURO0c7i
	CeSa6G+OeWT0jlFic4or7XfEIccp1UZkJsA==
X-ME-Sender: <xms:csELaMoZ4B7yN7iVTS6XenpDkhdcN9qzrQt4Jtz13uSjL62RPkDuCw>
    <xme:csELaCqTxLYyIZyEVAx4ks_PG2ATnEHV_KK8t3xqJGG7fX2IcA6lQ18rg6FjvY3yc
    YCugAgWKjK1vZpCEw>
X-ME-Received: <xmr:csELaBO9AnyTgong9_eTmxqDlb2mqELikZu0HiQUVd6zEn7oCsq8LDcE1MzkCNGiCBuGVlicyuEwHOzgCB-uiOp2CPOUNiF3J6AU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepueegkeevveefffetkeehueelhfdvffeh
    vdffieffheehleefvdejuddvffekkeefnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dpmhgvthgrtghprghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpth
    htohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghhuhgvlhhssehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomh
    dprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrghkvghrshdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhirhhthh
    drhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshes
    tghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepfihirghgnhdvfe
    efsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:csELaD7_cE-qawXYKHqc23f500Ii-beoyXuuOtK_4en8MdCKfJxeow>
    <xmx:csELaL4l2qWcsZ7mlQt0ROOvGCV_6DLRThk3GoqKdK8LWWv1dT71lw>
    <xmx:csELaDhi2atG76m_-mFul9zNQEWOn7sWsK7s0hTtEvHgCtIVdQZJEA>
    <xmx:csELaF6zCgi-sIvChsz3uTcIcnD-UXF6y7-Z4j-wSbHXfp_8VZcgbA>
    <xmx:c8ELaPomFBkUFigK5S8lepuyVit141YYCjYLJyQtlzq8_XRPpSrjw_5a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 13:08:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Erik Huelsmann <ehuels@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>,  Julian Swagemakers
 <julian@swagemakers.org>,  git@vger.kernel.org,  M Hickford
 <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,  Shengyu Qu
 <wiagn233@outlook.com>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook
 SMTP server
In-Reply-To: <CACOoB6irNaLLsRRf-aEsRbAmnvLJPFhDGnD0j_D9fY_ZbgAL6w@mail.gmail.com>
	(Erik Huelsmann's message of "Fri, 25 Apr 2025 18:22:43 +0200")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D4949EF555E2A96CE745B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<CACOoB6irNaLLsRRf-aEsRbAmnvLJPFhDGnD0j_D9fY_ZbgAL6w@mail.gmail.com>
Date: Fri, 25 Apr 2025 10:08:01 -0700
Message-ID: <xmqqtt6ctbim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Erik Huelsmann <ehuels@gmail.com> writes:

> Hi Junio, Aditya,
>
>>
>> Authen::SASL now finally supports XOAUTH2 and OAUTHBEARER thanks to Erik
>> and Julian! (Link: https://github.com/gbarr/perl-authen-sasl/commit/958a3aa165d30cf4e3cbb36dc45306de627aa13f)
>
> And it's official: https://metacpan.org/release/EHUELS/Authen-SASL-2.1800

Wonderful.

We tend to, however, try to cater to those whose distros are slow to
adjust to upstream changes.  What's the ETA for the updated module
to major distros?

Thanks.
