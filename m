Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D02DCF55
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033810; cv=none; b=GNVyFj1RRwHAtg2jnlpOqZoB2H7eLd96YNXjjkQvHLMG1u/y9zKweFf1SEXNjCF7XlkxOBN3lGBo42XUxliiUA/H6CrkJC91DCjj/OSFFmOF8dkSsf3zXc8hkBpBIG3s9yxcji82mlgMdO/BbrK0jqbZd+mf2O7qYCgf6wnzO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033810; c=relaxed/simple;
	bh=YPpfs7yBKOQucT3ZMXM8kjJWd2yiay+RZ/vEWPTEqhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gzuBSHoS8QnydV7A95LZOiFAvQKvgneqKEm3AmBooKnir7o/2p2790zgxizL9VCrLqhmIFjHCklK/ybMg2pn5Jg8SVXJt4qe7qBivcFjooiWJ2GRlC1G+ArCe/+Zd4TgF1CKQ0si/CNY+IkWv+hhZcwLFVo9Dx3CEo1HqTig9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qXgqQmWR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FX9/P8nt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qXgqQmWR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FX9/P8nt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AD54EC05E2;
	Wed, 25 Feb 2026 10:36:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Feb 2026 10:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772033808; x=1772120208; bh=+CoAleUpYs
	taJb9NljRgLC0h2AVKEqQVzwgwQf1KvxU=; b=qXgqQmWRJ7ia4Ns5aPOQLYeFxe
	C6XthnxMNUPNW9f9F6b6Vxg+e2h0tTpkTL/lpOYg58bIvZrtl7U63Tf55r9mlnFE
	wo1W5nGyKkLKIJkfvJvns0J2wokRMNRFaW2lv+DHdvZYOP1taSfFGzrSj57feNzw
	3J/T2SG3D66eBqd3pLPus4G+N/93kuPHQujB2KPCKqNCeXzibOlr+zl9lfAQFs/5
	kjg4Rsr2gLD+s67+saAG+sFhJZ2eK9HLK/pbLN6cuNSZ9xsj6Peqq20d2KDJ/LIw
	vM3FTlf84LD2gY1Zg9bBLG7BGg5YTfMbnUbJ0rXQyxddG4HTN4yzPQjKZq2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772033808; x=1772120208; bh=+CoAleUpYstaJb9NljRgLC0h2AVKEqQVzwg
	wQf1KvxU=; b=FX9/P8ntNctQR3AZ3pl/UQ8Fva5S79TffC4nK0vi4HwJrHHwnFv
	LXK7O3zbY65jXwlLX4B6XXIscI/oe6NvEQs5pOwM8TFgbV6hcptmakoiDfekTFJL
	rv53J3ekPcGkHdvH3fMtNrZFwipRKhtEE0uX1G+To/CY86cluGSSGJYvJrAL7GFl
	PUqvaVdiWnYsrArlpRtuF1zPGzJiZkTS8dgJadX+8o0wlw3eEv8o7L1Ek+Be96Lj
	09OnQAeabV3JRMBtVlHTQNIpoFI5yAtTftGmF4bWQM5TEx6H6ET1vj7iL/Av+M70
	Sm3GopWV4ecHor6lJ+fLX3QKqiNiGuyLaug==
X-ME-Sender: <xms:DxefaXnSyyN-gmMAsxqWfrgaoOMMHGBTC3Ux0xlGGgkDXztFN2x59w>
    <xme:DxefaeiU3knfWEDwpaiYxPjRdyixpV_qbc0A_JLvGH7ZZa7a8Ro-58HviaRDbNw7J
    VXZyNjh6ieWL14dIYCgDlRaoa8Q4yqficOdIb_xe8IVK1SfYp1CWQ>
X-ME-Received: <xmr:DxefaXcxMSzqt9HONhDjCdCrG1Qly2doZ3otf4qWpcAiViEpSYLLpj1ED2PWdHmVSNpWZZN3zDya1s1g5RjoyA80qr-W_tJAcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephedvfeehudeiheejleesqhhqrd
    gtohhmpdhrtghpthhtoheptghuihifvghigihivgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DxefaWhpBLNrGXJ8cnxW1MdVFwcQeODexfczL4d194_14GmbKiiQIg>
    <xmx:DxefaXwg6vHuIm_yeDC0ZJuuj72tfjmj1Dq1OLsYVOunms7_dnoSiw>
    <xmx:DxefaaNbX2NFJrwB9PukLyXvCEgL3JAXAK01zA3Ru7en5FF3-MOKPA>
    <xmx:DxefaQXtOt5fSvqjtUrKYx3ulksJKYhujz-G9Q_2WVt5NsXtz6Au_A>
    <xmx:EBefadybzvPcYvMdwHh9CIc5FcqU6xILJQOcdTKEytov0siUX3v8xeYM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 10:36:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: cui via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  cui <523516579@qq.com>,  cuiweixie <cuiweixie@gmail.com>
Subject: Re: [PATCH] fetch: fix wrong evaluation order in URL trailing-slash
 trimming
In-Reply-To: <20260225141059.GE2139176@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 25 Feb 2026 09:10:59 -0500")
References: <pull.2211.git.git.1771984857879.gitgitgadget@gmail.com>
	<20260225141059.GE2139176@coredump.intra.peff.net>
Date: Wed, 25 Feb 2026 07:36:46 -0800
Message-ID: <xmqq4in4decx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I can't help but think this would be easier to read without an empty
> loop body, like:
>
>   for (len = strlen(display_state->url); len > 0; len--) {
> 	if (display_state->url[len-1] != '/')
> 		break;
>   }
>
> which makes it much more clear we never leave the bounds of the string
> (and also works with a size_t, which is a more appropriate type than int
> here).

Yes, this is vastly more readable, even though what it does is
exactly the same as the original.

Or instead of having strlen() to scan the entire string once and
then ourselves scan backwards from the end, scan forward ourselves
only once while noting where the last non-slash byte was, or
something.

> But it may not be worth polishing this bit of code too much (if we did,
> I'd also suggest strip_suffix_mem() to drop ".git" rather than all of
> those magic numbers. Or even stuffing it in a strbuf and using
> strbuf_setlen() and strbuf_strip_suffix().

True.  None of these "we could do it this way too" bikeshedding has
much value.  The patch posted is an obvious and trivial enough
improvement.

Thanks.
