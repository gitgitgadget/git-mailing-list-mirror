Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B542885D
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138047; cv=none; b=p3beMO+Y87GKZR0zCwTF/kkf9QU1dSnfSXBe4iRVZHGS3XtZiHQvNQHTVKG78SJsyIgsLrOWmv76uwJXdlb5J+KvMEq37/+87KhDOl7zv4Pb5nKDzH6zpeMPA7QeAByOHdecUDQKp6FDoW4Tk8sJ6f5unGVTL0ZK0kuw63CUOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138047; c=relaxed/simple;
	bh=ayDOUkXQhZYc65DdDewc9nJP49yC1w5SnpqVg+kp9jA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvX/X/3j9BO+dZy5121WtlWbLw7YtWBS2AWRcOg4dn4OctMfWdIcXLyHGVTyy4j000L4C2tsAbp9GFta56NLcaFQipCV+SYCRo2rLKV+QteCCEuuO32dL/M41SfnCw6x6IY3IMFZ9tBu3Wp66AxrXI3M244pmuKl4GuIdNV1eKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MmuQcD92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glgfIzt0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MmuQcD92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glgfIzt0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F1547A01DF;
	Thu, 26 Feb 2026 15:34:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 15:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772138045; x=1772224445; bh=Ax7huFBbxN
	SDj4/UgldzPxGlq3giuH2VRYtr2qIM5w8=; b=MmuQcD927ldoiuG1HwQJS/md6G
	pfbnOzQXHUUEU0TGeIfl5HqFY1Zy1GLT08CHOAM70f20eYPPedOhE77ZgHUJnBcm
	M1sy599r9Hvx8dalP2tedOom8fQd/rVp7Q6l+xWjMt6HCPsoVp9TnkWVmUqVZov+
	8neIjDfKxbvxKi1ev12If3C5lSbDcnKWiukMqe3wzvQse6ktkt2E7esYynV/ZPxR
	PZHF1heIziTLQQuwaYyMGqJq/iRWQ7J9RpBwAQpKHSjhfeMH5de6TPwfb9b9fIhO
	otpmWasbJOztT3ik637dcj/YExxYCCFsDAZqp0RUJV9TsJayquws87EssfZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772138045; x=1772224445; bh=Ax7huFBbxNSDj4/UgldzPxGlq3giuH2VRYt
	r2qIM5w8=; b=glgfIzt0SFQJTYB6B20A1nTyTAzJik7EyW9Yw5Zzw3T0ltVs47S
	iYFc0Ia5WRXov3lZIxJdokMc21Eh7Ce/dAGM2n54Fmx9sXMxb1sM129UMvaVX2UH
	DuTEU/fGWrfabc5a9Sd9JytM9HR3bBof9vmMz/vwt+n6VivhuAF7zP4Xjqk19Gy/
	tSgR7MHPTvrzprPcEXkghOH64nRWaiQ1RL1PEhxlaxi+eXUxuwrq4GfLhcklbO9c
	GykMoFT6pspYOSEArebO5U+aCy+GoE4LV670jD81hUnk5VeKRCn9rNNQUSWeFbVZ
	RBBQTM02iuXwdD2SuuS5mOdtIMHG3mWZXTQ==
X-ME-Sender: <xms:Pa6gaVTY86iIZ5XyVb_wa6ekrpph-gILi24Ns7wuVgWOw9mHyJofEg>
    <xme:Pa6gaSfVD0G9jBw3XUg5GgP6JdDVTR0wGTAQ3xkOG2jvePnVmq92PG-qCCxIoYe9K
    YLATF5ZY6q_v_MRuHQVJHAG5BahLWHKTm_D33I0aDUs1VpkD7HK5A>
X-ME-Received: <xmr:Pa6gaUom9oegFubLuRcrGCdVitBKuzsu-f4-8tPUj-Aa323lTriQhVAomCxvZBOFCzq3fasGa6m9w-2NpieMH8KN5aFEIK3jTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Pa6gaT85WmatX6Fq2ZuB4BmFVqFdsKcbio4SqYwyCrxPnYBNW0CpEQ>
    <xmx:Pa6gaQfJYnLIxxSuJoQSHAThBClC-34bycQPZB_Rdoq-azTWJnsnkg>
    <xmx:Pa6gadIAUGhewuu6dE9D-C5FU6MJqkUd4_QzYg9fkTp8R-vTCyIMcw>
    <xmx:Pa6gaQh8bTb0YX-c0XbKvGEnwEuitzDjZwJSC-b6cEvmIC8M6Zf-mg>
    <xmx:Pa6gaetQBhWPAbebI0QV86aOshtqqI0qeTDlQAf1KayoaO-meXFO7YIF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:34:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 02/14] strvec: introduce `strvec_init_alloc()`
In-Reply-To: <50efbbb0fe8d897d7c4cd51489af4cb4c4c49d02.1771978829.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 24 Feb 2026 19:21:01 -0500")
References: <cover.1771978829.git.me@ttaylorr.com>
	<50efbbb0fe8d897d7c4cd51489af4cb4c4c49d02.1771978829.git.me@ttaylorr.com>
Date: Thu, 26 Feb 2026 12:34:03 -0800
Message-ID: <xmqqh5r31byc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> When the caller knows upfront how many elements will be pushed onto a
> `strvec`, it is useful to pre-allocate enough space in the array to fit
> that many elements (and one additional slot to store NULL, indicating
> the end of the list.)
>
> Introduce `strvec_init_alloc()`, which allocates the backing array large
> enough to hold `alloc` elements and the termination marker without
> further reallocation.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  strvec.c | 7 +++++++
>  strvec.h | 5 +++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/strvec.c b/strvec.c
> index f8de79f5579..f7f32a53b56 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -10,6 +10,13 @@ void strvec_init(struct strvec *array)
>  	memcpy(array, &blank, sizeof(*array));
>  }
>  
> +void strvec_init_alloc(struct strvec *array, size_t alloc)
> +{
> +	CALLOC_ARRAY(array->v, st_add(alloc, 1));
> +	array->nr = 0;
> +	array->alloc = alloc + 1;
> +}

It is not satisifying that strvec_init() does *not* become a thin
wrapper around this that says "my initial allocation is for zero
elements", but that cannot be done easily as a strvec that begins as
an empty one has a small optimization to avoid one-slot allocation
only to store NULL.  So, ... OK.

