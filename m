Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C020CCE4
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342735; cv=none; b=optctP6ofTXcQxSDu753eY1NAp3ILZnutuydLhTvp96Dy35FLQ1vNCTiF74C6H2NKqgvTZ6895gdFAtL8wxR7Lvb3sGZXKkbGqKn/nRoH2X1HJEPG4COupT9+v4o8f+VPsFMjQFWeaNjRftpoQVf6DtJKahbty1wG1lRseMW1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342735; c=relaxed/simple;
	bh=59rNOOaxmBUfeYOskbdIB6x4c5XZRkXhwpEiI0J3E8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NTVZEjr53k3pj/4ibQD7mvAcYWyVZsc+fdbZgPwj9e7a/JvzYDZAR0+BPEgSMZl8xH9OJOTn8wZ2U6TRLL4uDXc28BoGGEoXvPvdV3o2L2IcI78TvlyBM1cK2YyqroOvxGRIDItGswfgPWe99MOHMIU/v584wIG8rSYMpjamf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O8QeqKUI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uPVuQnpg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O8QeqKUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uPVuQnpg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACEFF11400EA;
	Thu, 15 May 2025 16:58:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 15 May 2025 16:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747342732; x=1747429132; bh=xNs+hj8wkY
	x81PWeJoDIpMG6g2XKWOmoiXeKthF22QY=; b=O8QeqKUIQtU6RZPHorl04Pzdzj
	TTQpTsxXQ6MN1hghBip9Ez7BtHprEHJePltUWsTtkYYEfgPGlK1OEFRGFvVr59Ed
	/borUhJyRoT/X8ppLuNCtMOA2bLlWmQ5GwDepfU6g3Py1cu3Z7o0TH6eifCnxg+2
	ubnwy/JvL+iJQAGMe0kNUBaBVFt1F4G3mYSJBwncZWgSmub/SfsVWVwosg469URB
	R1x0ubJZoxWSdrqZqr3w3QLh/GEZGjKEN221nssKxifo8HGNtvl6FkVikN580BSS
	WMMTAN1JVUOPXiqo3oEEC5Td2vCjg6SjI1TvgIrnTZxjiJ02P9Pcohq3jH4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747342732; x=1747429132; bh=xNs+hj8wkYx81PWeJoDIpMG6g2XKWOmoiXe
	KthF22QY=; b=uPVuQnpgeyn7y7ODQYluOkfCT7GmWhm3b1iLiHPuwbNCV/DrcsC
	VPLZxaR+SMYJLqLnW7XFZ0350a0uu1dJTJ3YKIywROt4CemqerldOq+skRJQCRY4
	QC5Gn9SBdHt+TAasr8gIeMkw1Bsj1C4znUx4fLwquCRtHYpsB8mS9SSlxl1KIWFv
	wsSltiSgzr5qSRkUp1vw2wTmuC06FyUfocJdBaZCpX+7fAmJaguEIus+nz1H+fyW
	99wloMuTx93VdW/VaZizA9neRYQkxSbh9LL23djllRfQ/QtDzfPlmtn33KFqYbZC
	yk024mCOiQzO2zX3+drmcoeYnWXaqy0vr1A==
X-ME-Sender: <xms:jFUmaISP8hkE7ecQ__Gtvw0yFWEAJk4MHsTdn0ysSnP8TS4cib06EA>
    <xme:jFUmaFzP3Qb3zW_-320rHZYtznnAaoWohyNHyeczbZ5TldKGajcLLcvcnPjzSzqUI
    -jcBHYG736wXkU7pQ>
X-ME-Received: <xmr:jFUmaF1K7hwzpVIuu-QbxQTXSYMCbbqmAPOXp7gYhEWKKgshtqf_vsHj5a7N_v8IWmbxgDAc_RaVB0FI5cFMbcXvHIYO7xvzQi4iYh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:jFUmaMCj5OB21orSu9ZVZI1sacpzY4qadqSdUSj0K5WMQwHarcoJmw>
    <xmx:jFUmaBj9u91bxCwj9KsFoDNTr29zLWTBTymkH7hMP1aFJvYEUOMvyA>
    <xmx:jFUmaIrvdPGWuMHVNQp_J3Oa7ib7ruiYIEmjq2xGp8pGeAuhmJ0dQA>
    <xmx:jFUmaEiL1c89j164l1viS7ymCDvjQHeAof5j2I_ubbaXQeuZ_6qQGQ>
    <xmx:jFUmaP3bf5ZrpAUICzTU4eqxjJdXLefqMd37E3sonJisYuVQFTRXlrNh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 16:58:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] CodeQL-inspired fixes
In-Reply-To: <20250515202652.GM3320240@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 May 2025 16:26:52 -0400")
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
	<20250515202652.GM3320240@coredump.intra.peff.net>
Date: Thu, 15 May 2025 13:58:50 -0700
Message-ID: <xmqqzffdy4j9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, May 15, 2025 at 01:11:38PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> CodeQL [https://codeql.github.com/] pointed out a couple of issues, which
>> are addressed in this patch series.
>> 
>> Johannes Schindelin (11):
>>   commit: simplify code
>>   fetch: carefully clear local variable's address after use
>>   commit-graph: avoid malloc'ing a local variable
>>   upload-pack: rename `enum` to reflect the operation
>>   has_dir_name(): make code more obvious
>>   fetch: avoid unnecessary work when there is no current branch
>>   Avoid redundant conditions
>>   trace2: avoid "futile conditional"
>>   commit-graph: avoid using stale stack addresses
>>   bundle-uri: avoid using undefined output of `sscanf()`
>>   sequencer: stop pretending that an assignment is a condition
>
> I read through all of these and didn't find anything incorrect. I did
> leave a few comments that might or might not be worth following up on.
> Thanks for fixing these.

Yup, I also looked at them and didn't see any incorrect updates.
