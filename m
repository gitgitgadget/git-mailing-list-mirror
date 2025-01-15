Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F6161321
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975815; cv=none; b=MLRIIamVWHBtYNsRF9lZksO7w3Gy4K8NenRChhgDTK3pwgt2X/xN5w+zGRPmfHZBdyPlMnSE2P1KneNCVfNB8pJNwz/YacPXFcUWsv+bpArmCiUhbfRgwOc7gCjykmaea/6m80AZa2JPjR0xgRvL+VI4OaKTBCJ4zbFHd7q2ae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975815; c=relaxed/simple;
	bh=v1OsI6/cN7mg6VZRrI/UfrHseaLY4CeqUZh2KtreuEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4NHQBVJ3uCgPnzjbDv0O0DTAv9v1ysIlhsKVHh2uRrUbnrx1bDtCTIYRdjOqNb0D31Ruotqe6wwnYiqHMCAY9uHATwJk69tz8pNe5uoYZJKEgKs+nMpPQXTFggpMb+utz29OA0oq0sAJDDMnXJLRDcWWai1QNGRD+TENl1U8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hViI76jQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RfzWNd3D; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hViI76jQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RfzWNd3D"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3CEB8114013C;
	Wed, 15 Jan 2025 16:16:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 16:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736975812; x=1737062212; bh=vOcpReCI5H
	aZ7n5+7wpKgHJq8lDJ94pJA4Ko2rIC1J0=; b=hViI76jQRBuqhANgUEZvkvxQ4o
	8YgwfGNFObgXi1Mq+ODgLlqzli7CAsIY23rAXCrHJ/wfGnHt+n96zeMxux9Mk+oz
	JBceyU75PGIYgdvfV77mz8Vz8AUyT2gLsPkc3JwK5prKEuVJu0o/yKhG4alifGmJ
	akABVuu8dbkOyIqHxtUzEc5uW+yJXqcu6/Jbt8rYGc0EfWLVmBuv8Wv9YwrIKZDY
	/HiwDHWhm3A/dYvPlagP9RGPcAhF5rDdnpCCh2a7guvjwxm5s4YrX/Lwbv5bm24/
	MoPb3w319I51BB6+Ns8FC+ibShMCYOlT/ztpA7wYAT+BZ1SfL7WqdylHMHPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736975812; x=1737062212; bh=vOcpReCI5HaZ7n5+7wpKgHJq8lDJ94pJA4K
	o2rIC1J0=; b=RfzWNd3Dq47loNBobGjjVCkY0kD7Y2D5OeSn6+N2kGFuK2idIGZ
	btJQR9nDB2y0zkZ7imqLnNURmCEVSsvVPBRccxLEW+Z9c/nK0SevGRWCMweYnZn3
	6j+0hLMS2V7rNn9ln9464KgX+A7S0QG2vEVmfH5+la0urRmGilaH1/e5e8eznQg/
	IXoNQOYQlZd4ybiYR7UTHpyvwHK1o8N/B8Z8us8qydIFlmfV+XZIpgXjVwDLtjuN
	4SVWKSsO61k4TExff/4b2z61zoAQUdfcmAte+rE5GoDQsb4Q8Vm5zS1JFzyOYDiB
	mQWWpige8cTJpCavre1Jd8smPTL+10SBu8A==
X-ME-Sender: <xms:wyWIZ6zKWbvRmO0Gu28-uO2ThWnBLGkosrivS8groAvwPjhV0yo3bQ>
    <xme:wyWIZ2Tv17dcjeW6ec4lb7FNN_8u_G9DCe9_HfGQbmDbjfOPhEjAvE2o1AKwyJyaU
    JnjraeJTGSdl4Hwkg>
X-ME-Received: <xmr:wyWIZ8UdlafLQ3HeHWic4n-iWyDUe9-t6suT5etI7aVqMv7o1Ucs3IsmrFs4IbQBMESRSFRCwXQpGff9q51t4BKkyJFfxecGwJdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtph
    htthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wyWIZwgXvN9CYRkkG3-81Yxs9UGmP8wZCVRaMT6PMjaYOB7CqGlR_Q>
    <xmx:wyWIZ8DCaqfQzHO1VI5jbsp2BN6aiVFJqET0RctHQbAsonW5vvV-OA>
    <xmx:wyWIZxIIVL2vD0r5hriPr6oV_hIqIOOkOnSK1_iCR_qjPzBDeWnF0A>
    <xmx:wyWIZzAtPZvfzbDM4esgd_LjUVwVWj7CjWCbYr95mQSX3DS81qs6Jg>
    <xmx:xCWIZ-0yv0bvafnl24Bzink5qbGD0rscp2wuW8-OxE9S8SKZpOqkZ9os>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 16:16:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <20250115182419.GA86610@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2025 13:24:19 -0500")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g>
	<20250115182419.GA86610@coredump.intra.peff.net>
Date: Wed, 15 Jan 2025 13:16:50 -0800
Message-ID: <xmqqa5brydz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Yeah, I agree it is funny to have a "maybe noop, maybe exit" function.
> Perhaps a different name would help? I'd expect show_usage_help() to
> always do what the name says. Maybe check_help_option() or something?

maybe_show_usage_help()?

>> +void show_usage_help(int ac, const char **av,
>> +		     const char * const *usagestr,
>> +		     const struct option *opts)
>> +{
>> +	if (ac == 2 && !strcmp(av[1], "-h")) {
>> +		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
>> +		exit(0);
>> +	}
>> +}
>
> I think parse-options will exit(129) in this case, and that's what t0012
> insists upon.

Yeah, but the test can be adjusted to updated reality if needed.  

In this case, the command is doing what the end-user asked it to do,
and if we were writing the system from scratch, 0 would certainly be
the right exit status in this case.  If hit usage_with_options()
because the command line option supplied by the user was nonsense,
we should exit with non-zero, but I am not sure if exit(129) is a
good idea here.
