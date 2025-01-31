Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED91C3BE9
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738323848; cv=none; b=QPtpjgefeSa7MLwqfRbolCczGCOCAnXCXjpqviHOpgJpRDfxIu5nf7gtY8xtlaXWYLhZSp20SrKAo1pKv1Bxxql6m5863scC1A0EtZleVdzILf6f/jYQ7uYmyyVdiUxdcQzVbj+UB35QCu1sS0p7SzGAaXOEeiy3m2QXSRMhSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738323848; c=relaxed/simple;
	bh=6Kp5FQkREql7NMv63vzyYLLICycWvwV/gcoVy18Peqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mj4p/r0rC+n612FsHpXvOlKaTVP4bWXB6EoFuDdVzywNw49qoUG0Nuo/O1HmlshJNZxJwXd+27q7OZ0DdtaIDdQEtKIa+GhVrT1boSLSu7UeD4tOHHKxTg1PNbXCzqe+Vmz2jX4Hv2qOMveW36P2NMA8kZoPRRJaTW+zeU9ttL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PnN5WbIM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGqKCKAT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PnN5WbIM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGqKCKAT"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F20D81140083;
	Fri, 31 Jan 2025 06:44:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jan 2025 06:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738323845; x=1738410245; bh=fbdOjqk4LG
	lINOOaJAXgbO8jTywHzc2QKohgSv0udKE=; b=PnN5WbIM481u7gyxtIBHFqw9Eh
	2a6sPXJVSbVZHl6bdc6yQDwBTOjZjh6p5DdVsdyDOviSKZIPQG3A0h/cdY57wNBA
	eGKzsVMYbkC9ZxePTp4Wts299gTPSdZ5OipJ/PBa4N7pwBkZ497oznBTKoXqMAxq
	fQaZtep+iEvC8y2kaHYbP3GP94EXaVNWp1sc5yQcFFKfdHhLI1Cg8fMuNf1ycA8x
	FU9g9JOdAWHMgkku59/X41wX7QzhNPQL8Q1p9MWIgAFe22ALeK4TRLKZ7JFzuCm3
	aKc9P9DbM3eJV2aCLjIG3g+8JhakBgh7GBaSBEm3v4PWA9dw19JTy002pAKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738323845; x=1738410245; bh=fbdOjqk4LGlINOOaJAXgbO8jTywHzc2QKoh
	gSv0udKE=; b=HGqKCKATR/q71GGBT/eI5I0OOjUAzYTvzOfxVZTAsTgK23nOgrK
	rEuJFEmSWKfHRh2qGRGNe0BOz8UEDHJ7klqApEAvQ9CGyvPuXkecMDAAlLL4aQn1
	fL0bzLHVwv0PRl9uBl0JXiV7zKpdVwXd4YxullXqAoZu2FJ0XpOpNHCvuFTeKaZ9
	t1755FZMEAR+GY51/GkL2JaTxVLejXxLNvXZveU6+9NuMd4ICoEjOaphG5oNJdDA
	hr5HNPh4uanhcW46rnxk8tE/UeDdacYeNnBHLUEiEXofNzIfEOu1RmV/he4LCrlP
	CnFedaExWV55GoXRLIne4OWcmZMfM1qiKMQ==
X-ME-Sender: <xms:hbecZ0Fe0znpeiqB6R9Bt9GXx0csNAOXJyt6-1-JOcfEedSZEFtQHQ>
    <xme:hbecZ9Wjjw8DDeKiuZZmvFBeY5ytfdgZqfDKtNZLmzM_aGYKm9eE1TKfE6M1EJEF5
    xIpCgcKasIeAKw7gw>
X-ME-Received: <xmr:hbecZ-J3FmPXENraKiJmXswuWF9UBwUFNUoxRwGY7iNvgRqcvtT8vZ0t1XQRAYef-X9wwjILiLXIpG9neg0sFXdfqMBqZ6E7QBl7OCedYl4RQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hbecZ2GDgSV_CqDe9TGnfUl9DUHtR0xfOxfp4bkie0HZiUC4Vmo4sQ>
    <xmx:hbecZ6Xa3cuqibFiByeNBOojjIqK1Dxyq5Ien4ueEmt70U1Dytr3Sw>
    <xmx:hbecZ5Py6EaGfovHunTgX-EJNfQpIDlYyRb1OmqN1XC61tLCjyK3oQ>
    <xmx:hbecZx3sQAeCBKnB5dEHRwB7Rth2I6dXLhJSB4GeQoZ3bC1SfYbyFw>
    <xmx:hbecZ5T3lxTfl2byl-bgquWitNO0T356rsk2-FmERKcE2oamvDJBYOAH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 06:44:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1342d5bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 11:44:04 +0000 (UTC)
Date: Fri, 31 Jan 2025 12:44:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] t/unit-tests: convert strcmp-offset test to clar
 framework
Message-ID: <Z5y3gwWwLFlHiLkj@pks.im>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250130091334.39922-5-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130091334.39922-5-kuforiji98@gmail.com>

On Thu, Jan 30, 2025 at 10:13:34AM +0100, Seyi Kuforiji wrote:
> Adapt strcmp-offset test script to clar framework by using clar
> assertions where necessary. Test functions are created as standalone to
> test different test cases.

Same comment here regarding the message.

> diff --git a/t/unit-tests/u-strcmp-offset.c b/t/unit-tests/u-strcmp-offset.c
> new file mode 100644
> index 0000000000..7e8e9acf3c
> --- /dev/null
> +++ b/t/unit-tests/u-strcmp-offset.c
> @@ -0,0 +1,45 @@
> +#include "unit-test.h"
> +#include "read-cache-ll.h"
> +
> +static void check_strcmp_offset(const char *string1, const char *string2,
> +				int expect_result, uintmax_t expect_offset)
> +{
> +	size_t offset;
> +	int result = strcmp_offset(string1, string2, &offset);
> +
> +	/*
> +	 * Because different CRTs behave differently, only rely on signs of the
> +	 * result values.
> +	 */
> +	result = (result < 0 ? -1 :
> +			result > 0 ? 1 :
> +			0);
> +
> +	cl_assert_equal_i(result, expect_result);
> +	cl_assert_equal_i((uintmax_t)offset, expect_offset);
> +}
> +
> +void test_strcmp_offset__empty(void)
> +{
> +	check_strcmp_offset("", "", 0, 0);

This test didn't exist in the preimage, right? I don't mind adding it,
but it is somewhat surprising as the commit message does not mention
this at all.

Patrick
