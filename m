Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10412343214
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965251; cv=none; b=Q7SF60TXy24V+kvcMVz0Q+3pVbrqoawdouB39Xaj8hGiicwqXJJyqCvqjcOWTQCah8C09rcHy4sCYFSK037aQgPDm9xDfxiYAbQ44XHWOyVC3j3afDThoIUif/yvNRYYy6a/UG87u9tQNDlGWRJAF7uXWdRvHOPaL3r2FILEWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965251; c=relaxed/simple;
	bh=dHVsBF/ozjBU6dZ9gqW6lVv3/df6jGyFi33xR867LFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s12nJyKyFs4QNO2ytGZdXYA74Yw2o1ljDHyPqcIkvDzxGmmgqqTBwk4jgufILI80pE0EeZta10eXHs56C8Wub/Fq5CC6iyHA/ytXnGP5s5vKrE0bNy2xeDXVLzt0NWzvQVKHSVVlsbBPtIaSevRdkqjZraGdqq4MvbIyfJuVDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=REH+Wwc/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLhOPaRF; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="REH+Wwc/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLhOPaRF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D91967A0146;
	Wed, 12 Nov 2025 11:34:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 11:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762965247; x=1763051647; bh=jWYQcSo1dP
	KSTQaDV0Q+OoRtSBV8W9chFPyRS057eds=; b=REH+Wwc/rhdlysX3gE2ntC3WPf
	s4v1dchgd3hbzGAyOWWsFn8wBXfFG/9etZYJ5bb8J6DkGxhvKTc5HB8p6S1A2O2X
	z5Xt49dmpznjy04vTT4VQRJqvjph1lJwdoVJRDtRN4IPfjnn03fdxn8rkDm7Uywb
	0ZCA6R4W0DOydNSlCCBvH7XJPKIGk+YiCov/sZlD+MBtj3YTOqvYrSEEd/zRG7rO
	BwYEG/RLNDT6DkyRqOidNmucZdUEDHIgh+dmu+mc3ZPsE+c3kF+UDEHT9g3PhndK
	LbgJbYaqSlCl3gR/tWyMwVV9cRzsqdOSYqByRwGSDrQlWb3mZpMM/4mXapmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762965247; x=1763051647; bh=jWYQcSo1dPKSTQaDV0Q+OoRtSBV8W9chFPy
	RS057eds=; b=bLhOPaRF5i2Zcj7pas2bHg3ojlosoCsc4GSY8XJ5FjdxFTmNLfI
	2SrMNCUG/rP5BubxmdL5ytmu6Jyd1XKgwoeYr9Wz0NSfhblwdBC3ZrXZu4UNfl4T
	vlKy299zd8ywX+FjNzzBZC1/zv8+uB5Hh/VbiDEjI34Ohsak3di1XbGWgkbi7xbK
	0bOGJ7kZTnsSuy9YBhOLfSkAexQh90QFA0Z5p6EMStH7AM3ORCrpFiSIquF1fVvz
	k4WElrKhd+9XxHhcs8Sq2pl6Du5rNLvR4io3fjkLFZJ2FowC9JKDJMfLDHfF/5ic
	kzv7Lw5gUZAtwznKjOR4kajLS9yqaZ+eVLA==
X-ME-Sender: <xms:_7YUadxhwbbsnLiIYd0ch2SQBapDyLWXGt4QIopzQIQplDbhNFd19A>
    <xme:_7YUaQ-Ug4Qq61k1nUoWSgGzBrKslQGBZZFlCLl2qxTLsYb2j7GHakOywoOAtVod2
    S2GjB1DHL5wO-zAxnGVLZqjIO3ILrupdKTS-p94QFszXCvgWhwzFQ>
X-ME-Received: <xmr:_7YUaRLfomssYz_oCfbNytn19dr-8TzkO47YrcPJrrrAZ6vFskcuzopGnbg5QKuCb5NEpyWKsYoaNBjVUUVcausUgrDQSPbb-ZXr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopeguvggsohhhmhgrnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_7YUaWeWSE0-hSm2zeFLqdzctGMp8iQJyi2ZFn9MAnEbWYFCs08gtg>
    <xmx:_7YUaQ9jcn4974Uz0lQz18qvfb_h9dYCt6vTUTBweSCR-tcfc6KQRg>
    <xmx:_7YUaTrGt36u4pW3gfuVuPzKTeEj_KgOPd4r6f2j4zP-8pt4-Sa16Q>
    <xmx:_7YUaVD51yeDc0dHxEcst_fec-IBHgnNjJuo2XTiJOCm3Z-y5oOJcQ>
    <xmx:_7YUafXPgcqv4xGb-FF87bN1WhMGfGTh6u1iEyXhZdQSSGi9ct8Gdwso>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 11:34:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  David Bohman
 <debohman@gmail.com>,  jltobler@gmail.com
Subject: Re: [PATCH v4 2/2] fetch: fix non-conflicting tags not being committed
In-Reply-To: <CAOLa=ZQAQ1dtstD+uqh=vzV+w5q2uWsnZkzqucHuj_W_VL931A@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 12 Nov 2025 00:52:47 -0800")
References: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
	<20251111-fix-tags-not-fetching-v4-2-185d836ec62a@gmail.com>
	<aRQmVPe1RsFcr4hz@pks.im>
	<CAOLa=ZQAQ1dtstD+uqh=vzV+w5q2uWsnZkzqucHuj_W_VL931A@mail.gmail.com>
Date: Wed, 12 Nov 2025 08:34:05 -0800
Message-ID: <xmqq346jtdky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Tue, Nov 11, 2025 at 02:27:08PM +0100, Karthik Nayak wrote:
>>> The cleanup section is reached with `retcode` set in several scenarios:
>>>
>>>    - `truncate_fetch_head()` and `open_fetch_head()` both set `retcode`
>>>      before the transaction is created, so no commit is attempted.
>>>
>>>    - `prune_refs()` sets `retcode` after creating the transaction, so
>>>      the commit will now proceed. Before batched updates, `prune_refs()`
>>>      created its own transaction internally with all-or-nothing
>>>      semantics. This was done since all deletions were made without an
>>>      old OID, which meant they were assumed to never fail. This change
>>>      allows partial deletions to succeed, consistent with how other
>>>      reference updates behave during fetch.
>>
>> Okay, so we do have a change in behaviour for `prune_refs()`. I guess
>> the reasoning is sound, but I was wondering why we don't have a test for
>> this.
>>
>> I guess the reason is that, as you said, it should in theory always
>> succeed. But what if with the "files" backend one of the refs that we're
>> about to prune was locked? Would that be a case where we continue with
>> pruning the remaining refs now?
>>
>
> I was thinking of concurrent writes to lock the reference, and didn't
> think of a nice way to do this. Your solution works and is indeed better.
>
> I started writing the test and realized that the pruning happens before
> we create the batched updates transaction. So I was _wrong_ and there is
> no change for `prune_refs()` either, as the transaction is never defined
> at this stage. Will amend and send in a new version.

Thanks, both.  I too was wondering what was going on in that part of
the flow.
