Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7D38D693
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180884; cv=none; b=qYuCPz4S6/Hy6b1e3svbvaYSOORRTRsk0Pi6jGpXikJ2l3WwJlbAjdE2LfnDMBtAjiIKXiSXamvH0/Bxq8WRw/QQPwRQiw56Hxw4/aAArF3QGYnyinAWO/oHF5Bd/c/lZFZuKKkEowdBCRuYZjYgiqK1FQPlIt/fPpiA85oX5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180884; c=relaxed/simple;
	bh=I9GF/n/7CbRooUail5R59zF538yxPVjcfJusgRb1p2o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RTF6cBiUSZDVO9WJ3PkkXRt5NzN594ZsqPQ20d6fTGRPN9iGeZ0PFHWvvuHlQmGINlaG8KAt+jkasTQHarW3fNzdREMK38tQCvxo5fag+3I93AZjlSeHmvp9UdVOay+rrwk1DukgYyNyaJHjQhUQttuHy4LTZZsYHVK7suEoY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IjZN+LuZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5fmaihZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IjZN+LuZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5fmaihZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A36CEC063C;
	Tue, 10 Mar 2026 18:14:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 10 Mar 2026 18:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773180882; x=1773267282; bh=NO+pJmpYe9
	gGBDSSGB/q9CbiqPhhRAmo1kTE/IbgGyA=; b=IjZN+LuZEw4PXywu2sQhlP+FcB
	k5CdAwewq6lO4vmcOnKWEBsniUlmG+7EYRZlw8iLBLWzC7iwCZUrHI+bNdbXaap6
	ri3ibYCa1V/VyH8rWKRjWTxAgOlT9gpdNM6oi7OHTarywHjb0VGOWCAq+IvUGEaq
	T3+0H4Z5lK5T5o/xAz6qHC/l9ajSsmbcPwdxci4DQ0T7T+aN4g4jSi6zdECPy7Ye
	sAoKmhXEb4Xj9WMWQun/vC1jIRtdV4pIqCDx6sT6NK5HIYF9YzS9mT/IO0Iwhf36
	tROR2v+TRCC1RfpZAYtOoonR0ZVgT+yRaplpjJamcLlY1Pe3crd0sIl/xing==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773180882; x=1773267282; bh=NO+pJmpYe9gGBDSSGB/q9CbiqPhhRAmo1kT
	E/IbgGyA=; b=k5fmaihZLu5pLpxWKVqFbp2WAIwLPfL7BIIGqDflvLn6o4RnR2z
	fclOvNAXtMHOT/KI3pzTcR4+e1FnbGZlwsMowrQFxXzAoxOkFOQc/iGppoqoJo08
	A0oA1XREoH+22qU23CxF5SNLWjMjjfp6pHKwfgQ9ulFc4Fndv+2mmlYX9VoVtz8v
	MpGl5FQIn4Dvskt2M+aB6DrisYIbnGpyC+xWGDUYKiZaoXJTboPqgTT4ksUV4KeF
	ju21fObb0kLswJ39T+9Kv0S5skbgGs9B8swn3RAnCZfGyYanD8Pp48eiCyKlXxf1
	ZFMLO+Fz8p69OHU+yeCGJ4auyigy4O7maDw==
X-ME-Sender: <xms:0ZewaTeSXoTOf385INc3Ww263xdaRVcOVWUhFTZNc6Alq95h0El48Q>
    <xme:0ZewaQNshDMUcF5Iyp2uJ4mbYvsm0ulJ6-_gyh_poAbPHn1N83WInu1j87Ga_947X
    DlWKwLBKLZ5ObP_0CiTDyYPxAp0JGaWElMIQLrlbrPenr-5iYAvnA>
X-ME-Received: <xmr:0ZewaRi9GoMbPt2JdSCmy7ts-i8nZoMjM9IeuJJmaEq3yPBafea33glPNx1f1gVK3dtvCFWR2h9Kvb1wWoFyIYEqVjM_sV_58g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0ZewaT0hhtNICGTfzV8oOzW331YKrmnhPNiOei2bbAytPCDkjhWBbg>
    <xmx:0ZewabgqdslkftxcM8qpzzYrlNjQIEOxj2fBHKFFsa2-dLvxPsO_1g>
    <xmx:0ZewaTfO5zGc8vmu2P5-IehEPU3OKBCgO3po8dAfLPPimPGwCxI1Yw>
    <xmx:0ZewaelKl9cyXMYiyNNVGWDQSC8ng5_BR1jjzxfByM5Ho5eq9SzTZQ>
    <xmx:0pewachOYHxqnoLGqkSIUdJ_EQUCPghCGBpFRGr3DWwx9LZx08b987Wy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 18:14:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 3/5] format-patch: add ability to use alt cover format
In-Reply-To: <316c9e76ee49d73aff75b63299c970e9f55f79b6.1772837832.git.mroik@delayed.space>
	(Mirko Faina's message of "Fri, 6 Mar 2026 23:58:46 +0100")
References: <cover.1772232373.git.mroik@delayed.space>
	<cover.1772837832.git.mroik@delayed.space>
	<316c9e76ee49d73aff75b63299c970e9f55f79b6.1772837832.git.mroik@delayed.space>
Date: Tue, 10 Mar 2026 15:14:40 -0700
Message-ID: <xmqqldfzs567.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> +static void generate_commit_list_cover(FILE *cover_file, const char *format,
> +				       struct commit **list, int n)
> +{
> +	struct strbuf commit_line = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +	struct rev_info rev = REV_INFO_INIT;
> +
> +	strbuf_init(&commit_line, 0);

We don't need this, when the struct is already initialized at the
definition a few lines above, do we?

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 21d6d0cd9e..458da80721 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -380,6 +380,54 @@ test_expect_success 'filename limit applies only to basename' '
>  	done
>  '
>  
> +test_expect_success 'cover letter with subject, author and count' '
> +	rm -rf patches &&
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_when_finished "rm -rf patches result test_file" &&
> +	touch test_file &&
> +	git add test_file &&
> +	git commit -m "This is a subject" &&
> +	git format-patch --cover-letter \
> +	--cover-letter-format="log:[%(count)/%(total)] %s (%an)" -o patches HEAD~1 &&
> +	grep "^\[1/1\] This is a subject (A U Thor)$" patches/0000-cover-letter.patch >result &&
> +	test_line_count = 1 result
> +'
> +
> +test_expected_success 'cover letter with author and count' '

Has this test been run successfully?  It is unsual that only one
among several you are adding has this typo.


