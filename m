Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B042E010
	for <git@vger.kernel.org>; Mon, 18 May 2026 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108274; cv=none; b=auCVAbNJXF+PCndoNa8zoIIrOoCIgizpm65vOypuxu5DyiTjmhQDZFV/QNwMTib7Pxio/7tWN97S0TuGw7W3YJygn+caVw1MEi5nL3qyB9A0i+Gjd0uAXFzXQqPwqjtc5CGgZH8rU7BjZTUdRNNO5LrAM1D0a+ukXGQEqKV7BYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108274; c=relaxed/simple;
	bh=78vn0oRpZiybyKU3zsEF6oj57zv4ytJhldMSEYvv9m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e9qP1T2HuUug4Dy7iWYXEA7khg4iXpLrK2Qr1GefX2cPLAp0CfaLyHoNAs0WsN4zm+SnpUF7j1L1ojToby2M/nJj8K8HVyUU+tZqnO4CtlD2lZZwM8DNqUqThuwH/e+h2INUgzxscNrweq4CWgIAAHCDHU5go1zgnjlBWN2vfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H7Tk4zj/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OlRgxXlf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H7Tk4zj/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OlRgxXlf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C50691D000DC;
	Mon, 18 May 2026 08:44:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 18 May 2026 08:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779108272; x=1779194672; bh=o/aux/9mtV
	No1wvjtRA3JBN5VOqtZ9D+ei8yCck08Jo=; b=H7Tk4zj/VaWQeRUnSAo6oUasS/
	Tj49ZFBM9It5+1xgDNOh+316pjrz/bDKqxlpN04tMldSC4yzU/6ChwmiLbbPUMVi
	MaIC8WQB1OAh6mHKjC+9yGOwf/wiB0keBIkgbJNlClkVj/K/Q9StDIJVKfTRA+IQ
	argL20B1f3lAneA1c90gk1daoKozEwLy1M/LPMikDSQZMjmeC8wNiEdiUNTt3wK9
	0N7dOVWr2yzbAuYKQUEH7WIsb+KH8RuHGXWJSE1YeIL/LmQTaXPmxyjCzfAxq9YB
	GoHlW/5/LcfHbUOzV/Sif1LGflqP/nJtZlouX3qcRk3DtMsGDyLT4DBKOgQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779108272; x=1779194672; bh=o/aux/9mtVNo1wvjtRA3JBN5VOqtZ9D+ei8
	yCck08Jo=; b=OlRgxXlf0HFsySQuK76Lt4WzYvhOLRqJmNBiB56hydGNgezEznM
	mdeQjT9UajBspGKk5L0JV4/AQ8K/WShYwZb3rqITswol4+3pXRR9I8uAmtWOGIMH
	Ey890zvJlIknYuybVx1pzapGGYHYjBmnbkh3hRLqyY+Fie/QqhPN0QrDm8rgmpgg
	k5cJibruEDncCH30vQKlZg4BihLFZ0s46fG/zX4RrMOLVKtefo5gRRVl7fvdRdmt
	PNAllxTVIDe1X/x52Ure2lINBPUrgpZODYblrgyY2PAE7f35iSD4fhdQNgH8qJ/u
	brhwMwHM/9Vy8zE6V3ogPiDOia2tp5jJpgg==
X-ME-Sender: <xms:sAkLaoWd2YT1s1hc_NEYgSy3s4mS7G8Ev-rWelJphM_u9HnGqd5Zig>
    <xme:sAkLagTROphinPOlOOQfJgLH--ARhU2eDHzyesJ8z0Ou-ElLkYi-TuuF2vQWjYHTH
    5Szb5PmeECihxSwfJv3tdOisjw9ozjfGrqq-TntZwXsmyzo-BN2vw>
X-ME-Received: <xmr:sAkLamPxRxlZqkPcJlyQMRAW3AL-cFT4ikh0RuMjVzs983qi5UGM4mGcW9thapHK8_JjOxz_H4ep8dl4gLu3uOLMvjkGkZPwzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sAkLauQosqu2YglT5jT1kBo3DSG2jDKxfbwhPL-fw0vhNXDswuNViA>
    <xmx:sAkLakgQPvxpm_k9KtHQiRlBQyDrAuTzwpUGjFzwZZS-rXDtf8zmjg>
    <xmx:sAkLan-9nSpj9IDUhDi9d0G3edW5GLDSL977L8AR_oaLmpdfqlAWvw>
    <xmx:sAkLarE_hr6TvYfdmFSLp1CEeS8co6m79ntiNYReRomJgxHMXcqAaA>
    <xmx:sAkLam7e21cEFNGeG8tzUJx__62tuF0HogyLHr23a8l7IIdbmrhn55li>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:44:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/4] Batch prefetching
In-Reply-To: <0da4f159-8d4b-49e2-93c1-25aa0bf69371@gmail.com> (Derrick
	Stolee's message of "Mon, 18 May 2026 08:17:15 -0400")
References: <pull.2089.v2.git.1776472347.gitgitgadget@gmail.com>
	<pull.2089.v3.git.1778775928.gitgitgadget@gmail.com>
	<0da4f159-8d4b-49e2-93c1-25aa0bf69371@gmail.com>
Date: Mon, 18 May 2026 21:44:31 +0900
Message-ID: <xmqqecj8c2fk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 5/14/2026 12:25 PM, Elijah Newren via GitGitGadget wrote:
>> Changes since v2:
>> 
>>  * Modified the final patch as suggested by Stolee to include pathspec usage
>>    in the testcase
>>  * Modified the last two patches to not re-download blobs we already have
>>    locally, and adjusted the tests to verify
>>  * Inserted a new first patch, containing a documentation addition that
>>    would have helped me avoid making the above mistake in the first place.
>
> Thank you for these changes. I reviewed the updates and documentation and
> think this version is good to go. 
>> Note: Stolee also suggest some code sharing or code movement in his review
>> of v2 2/3, but possibly based on a misunderstanding of v2 2/3 (that patch
>> isn't about a diff) and it's not clear to me what could be shared or moved,
>> so that's not part of this round.
>
> Your detailed responses in the v2 thread helped me understand that my thought
> was misguided. Thanks for giving me extra confidence in your approach here.

Thanks, both.  I do agree that the series is in a good shape.  Let
me mark the topic for 'next'.
