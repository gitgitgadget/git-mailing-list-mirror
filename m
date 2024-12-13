Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A671E0E08
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100437; cv=none; b=SmouwyZDO/0l6qAiaDhRzCncgyG8LTux/mN6SNLY+07F2fZC5NZ0dakW516d/da7MsP78+nt3FwwWuej72PZxAfel1gDi1R06W0hElOd6VCECJuDDdx2NoZ1em8OSLXtfp94Kl/q8BTEHRqaXNl0DfClobz5M2KdcltpJgA78+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100437; c=relaxed/simple;
	bh=4FWbyynvcEfKvZEurfVgp3Ic9WIiThgBRANSQuPEbuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYsngWEEbl2O6IxiySzXwIn/hK89eefb6qAv/cdgHzEaKNlCC43bucj/ZlAg92vzb7njOCFBdZnhEi5ie5QqF4yN5wn6+4dxEGEvIjxLRsudpmssDqvF6Kz+3ekDUrK4LkfNo6Qztd4SuC9zDWBIW7V0uv9T2NsHswMkXiKRxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lP8ax6Ez; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aLs8W5U2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lP8ax6Ez";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aLs8W5U2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CB7561140095;
	Fri, 13 Dec 2024 09:33:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 09:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734100433; x=1734186833; bh=hBmUQ5Pb58
	f/48vPUirGe/LhdxbrhR13Wr52ChRp31I=; b=lP8ax6Ez1wnh5bDMlelw4w2gTc
	sl8HgroNBML6Hp4aMOXe6EG+4DeBRgt+sRhBRsjiU+0rG5tcot6yvUDEh+sau7FW
	rjLd7TtPuvDg/8fDM5a7nAo0hUYmzyNpsKTZnJnWoY5aJDfekseKDmBt9Xi7hPWd
	lRZiV0znSf/OXYj1jAfLkdSTM4EDatQnP5MnZTagUMMpfZJ76Fd0d9BZ1jf0x9En
	anZ3D/QOMQS+VMiSHMSuXiDLpToPCQT6Cxz2eOcfE0X1mDZwTzuKdyH9yfTdoeC6
	Aukmvo90U0qHIws5fxbyKXCHeWhzq36ltafBStfp091WlvPp5eNpTJ6Mihtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734100433; x=1734186833; bh=hBmUQ5Pb58f/48vPUirGe/LhdxbrhR13Wr5
	2ChRp31I=; b=aLs8W5U24B5+bTTbG+Mv8aBI/ye3b1Y52YaYUklL1yoSfviGq/7
	LAI9SqVHNbSHIM+DkpPKtsqsk7FGp9Yg0XkJCtMNSwlRPScHumME1OV595gpfOFM
	8RVy2TInUiV7YB5/y5Ta+Nc0OFaFOCBVH+gJFylpEAYOPRGI/vAj7rzX0HXyTFS6
	6AekilyIFiTF8AV7ZDDKLcjxIJ+ViEEtu7Br6bkL/9rYk2FnPYYIbJNJQUtFdqJJ
	suQ3GUD/+BRLBmoLo60IM9IRFNHhTAeuODX/v0L7KH8ZInEju+xLBkih1pBi1PHq
	MvJHd3VVfW2oWG9ebuWr1wUWjQQ3eK3fJrA==
X-ME-Sender: <xms:0UVcZ13xb3KfmhPdtQQpEHN648xgJkcdj1bvJ142PNI6FEP71cebAw>
    <xme:0UVcZ8FuNbzGbV47cH5iGVMEMaYYqukRa6-ypwnJIrxySY66JA4pH4GmmxNQt7Rjq
    jeJTsfts2chSDo_Fg>
X-ME-Received: <xmr:0UVcZ17mjZN-OwprH-vUsRMrNiBEW5rx7_h03mwTVAPSC2kZptTKp7a6tP5bXkU92Hhqi-jotmNZAp8dU6TsNgbMjp2ffgFB3m75HJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0UVcZy327nfWdJu_QBF_-tr4ikW8xJhorr1lQP5QD3fQprwoo0UeSg>
    <xmx:0UVcZ4EDq_XUNCxSxgQsqlsifE0CmvX0Io-DcpzcVlLPLik-JAVGKQ>
    <xmx:0UVcZz8AydjaH7Qa3g5DtNMuLgsQj66vpBZUB99hLuIM1EhS6xIdWA>
    <xmx:0UVcZ1lGfzICFNMGqkESYfqLKHXNaWvXwqVuAu1ZbERM9knri0A_MQ>
    <xmx:0UVcZ8CO09jEgRp5ZzfhKl9X6we0z58c9i8X-B5wP5ztugIuBhy6KphT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 09:33:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #05; Thu, 12)
In-Reply-To: <CAOLa=ZQmDyy1yajNzASUkRZeizroyCXcgsRK+fOtstatg5r=2A@mail.gmail.com>
	(karthik nayak's message of "Thu, 12 Dec 2024 09:27:17 -0500")
References: <xmqq8qslf5h1.fsf@gitster.g>
	<CAOLa=ZQmDyy1yajNzASUkRZeizroyCXcgsRK+fOtstatg5r=2A@mail.gmail.com>
Date: Fri, 13 Dec 2024 23:33:51 +0900
Message-ID: <xmqq7c83ejow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> [snip]
>
>> * kn/reftable-writer-log-write-verify (2024-12-07) 1 commit
>>  - reftable/writer: ensure valid range for log's update_index
>>
>>  source: <20241206-424-reftable-writer-add-check-for-limits-v2-1-82ca350b10be@gmail.com>
>>
>
> Hey Junio, this was reviewed by Patrick and Toon. I see this was added
> to 'seen'. Is it also scheduled for 'next'?

If it does not say "Will do X", it is not scheduled for that.

This applies to everybody, not specifically to you, but when you see
an empty entry like the above in the "What's cooking" report, three
things you can do are:

 (1) offer a few lines of topic summary
 (2) point at the review message(s)
 (3) suggest for updated status with rationale (e.g. "let's move
     this to 'next' by day X, as this and that reviews at URL1 and
     URL2 seem to indicate that we have a concensus that it is ready".

Patrick's comments were on the previous one, IIRC, but I do see Toon
commented on the latest round.

Thanks.


