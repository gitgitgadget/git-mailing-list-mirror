Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D43202F89
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111157; cv=none; b=WFFRcWxKcp1B4F8g+WPChT+OL2NKMhJle7hv0e+S8R0kvx4IhXMK32qabSxOmIy5FLYolwyixJxdVOn/0UKZCX05ml4pjtQklkxZM5q2Xpfn4ckWh4/M0SC8glVOasC28SNlTRr7BObHrJVMpnQ5xGG6Bp9QC/25DmYkGvX84zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111157; c=relaxed/simple;
	bh=YkiUl817/4qZFJte6qqha73Z7TYxH0B7eG6Zum4TyZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tNKgpl+ciO0QtZHZSt9/B4ZndQd45uSj3GxStcZD4h7LPMDt9UIXxDOauootgSdJVZ+lPAUUhBdsKlfAShoziUWLLirM7aJzT70stZtlz+nsFYeYTZLOidY1/MYHkG8qLKZlaRog3oNqw0ZVZ6evNmcyH/jKx7piCr8rQpSShSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hrndDw9x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5nMHnyq7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hrndDw9x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5nMHnyq7"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02DBB1140222;
	Tue,  4 Mar 2025 12:59:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 04 Mar 2025 12:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741111154; x=1741197554; bh=5EMNSdiuEa
	UkOpqWQkoRx9FPnTz4ghjgmsmdyqc7JDU=; b=hrndDw9xXwa55x48hkmJJ58IND
	dOr2p6uG6VPKmX9CH2Bkcu6GcK/5/7Qack724vDvi08kbp0I+95TrdHYuYeXxVo9
	A6b2LRzKAVzXJj8sucwO23Xm/RfFFfmbuGvPEb4u8Tc/0loj54QPykSKXfQWlgjI
	000/HWG2lwCx+xTE79Yenomq8yL9+ph4YPm2VyRmDIQ7Vom5hRki1xTk0ZDd6o5p
	ZA8ShGRcwK8jYKGfffNn9lQmsDYdrWhTv4JTgKY2L8Dikkw6gD3bPSYQ0pgEScqd
	TomEKGQq79wauxChdfbNOynvieNQM8HIqLA0nkADkBPbuAIuWH0MrkCyRBjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741111154; x=1741197554; bh=5EMNSdiuEaUkOpqWQkoRx9FPnTz4ghjgmsm
	dyqc7JDU=; b=5nMHnyq7KU/4luIVzqf9scqvZsW1gx0jNIV0/3HEeiBCtnZofSQ
	AdTEFFezoylCuJahbeePMerTNLGBPO3g+LtjbKmwyICOZwJ2lCBZC/sKAuPinyoe
	oZDawVjJvXfdijnAR1yqHB3zdxnhcFI9QWsnNdVPs4Q95G48ewwJ1xMeFn1/iH6g
	YlKa0rihbC+UvDGtqrJ2f2X/A6sM69tTubsHV3dd+/5oxNOmECpbduXChmxGiNiW
	QrQEyMnr2cPF21oZI8AgmsiA/9hcNAbhDg09ScM+uPpiU3uI7NdsH+wTIxFzczQj
	+7TZHYoBUbttP+Ri0kY7WudVWfLKVHHF12Q==
X-ME-Sender: <xms:cj_HZzL1LfhiMr2NOnrzbrchJOpE11hRZ4Jagh_s8QK9veTLCxc2jA>
    <xme:cj_HZ3Ju6qOT1Rrl1MV9LQQB0KdhPQ6iuKoM2qCD9xzlzRqUWLAJP-Nxsj_BPDogu
    rZNxWn9BUOaZC54UQ>
X-ME-Received: <xmr:cj_HZ7vKgw4x4iUU4uKNA_fh82pJFSaJvtyDVgnc-IfeAcAEws2BRvyybaSqYAWTEyGAEA00p4gMAqJtAgG42Ao6t6emdBaWNZS0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijh
    hileeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cj_HZ8a_iOlToAy78wn9_VehfXGcByp2WPgmsP8ZAVyN8S_XpjW1BA>
    <xmx:cj_HZ6ZPUQbwFnFYLmqWPpjaFS3fNVKtJfsE1avQro3o0iVXVUoC3A>
    <xmx:cj_HZwCqHKBZ6LFAVYv0qq3i3xTbtjB4KAdO4q-oQS2vlMlXJ7ydCg>
    <xmx:cj_HZ4bzjRfVE8C3vy4izIXwYUUeD9re9xx8fRyWMSbs03P9j0zAKA>
    <xmx:cj_HZxwG5Qt8vaoGErz_NF1I3JJ-YDh7aqUco_M_Ee6elpNL1RJoWsvh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 12:59:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t/unit-tests: convert trailer test to use clar
In-Reply-To: <20250304113323.10564-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Tue, 4 Mar 2025 12:33:22 +0100")
References: <20250304113323.10564-1-kuforiji98@gmail.com>
	<20250304113323.10564-2-kuforiji98@gmail.com>
Date: Tue, 04 Mar 2025 09:59:12 -0800
Message-ID: <xmqqzfi0pthr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> diff --git a/t/unit-tests/u-trailer.c b/t/unit-tests/u-trailer.c
> new file mode 100644
> index 0000000000..3d60ea1603
> --- /dev/null
> +++ b/t/unit-tests/u-trailer.c

It is a bit sad (not your fault) that this is not shown as a
rename+modification patch, as most of the logic seem to be straight
out of the original.

> +void test_trailer__no_newline_start(void)
> +{
> +	struct contents expected_contents[] = { 0 };
> +
> +	t_trailer_iterator("Fixes: x\n"
> +			   "Acked-by: x\n"
> +			   "Reviewed-by: x\n",
> +			   0,
> +			   expected_contents);
> +}
> +
> +void test_trailer__newline_start(void)
> +{
> +	struct contents expected_contents[] = {
> +		{
> +			.raw = "Fixes: x\n",
> +			.key = "Fixes",
> +			.val = "x",
> +		},
> +		{
> +			.raw = "Acked-by: x\n",
> +			.key = "Acked-by",
> +			.val = "x",
> +		},
> +		{
> +			.raw = "Reviewed-by: x\n",
> +			.key = "Reviewed-by",
> +			.val = "x",
> +		},
> +		{
> +			0
> +		},
> +	};
> +
> +	t_trailer_iterator("\n"
> +			   "Fixes: x\n"
> +			   "Acked-by: x\n"
> +			   "Reviewed-by: x\n",
> +			   3,
> +			   expected_contents);
> +}

This is inherited from the original, but the hardcoded "3" feels a
bit brittle.

Would ARRAY_SIZE(expected_contents)-1 always match the expected
number, I wonder?  Even if it is, improving it is totally outside
the scope of this topic.  I am just mentioning this since I will
forget if I don't ;-).
