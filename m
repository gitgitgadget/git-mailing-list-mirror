Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000762BDC00
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451261; cv=none; b=fiGO7LxZmGY3toFnomTqDV2mCqhCGatqQX3pBn+zrW8gkxGRYh9IPzfRFzQ1DEhU4K1SiPve4oHHs7PWLTC4siIMrW/s5u0+eXJYMD89Thw4sjTDh47qjeWePAKAd6ClqK+curtwLfhYYXDWkLsc81fzhEX31HuRS+gZYv6hZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451261; c=relaxed/simple;
	bh=xCqUXt8Mxez/n40rEU/S3d4GRjFUuGjT6FUumiZHePw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwkp6VlfCTdc7/V9aocgsNdgGbdZqTU6APh6wgYpRLVTfneYg73XKav7w+6eJxFjwNWEuORAxXJuoYzywBs54z9cpCVD1ok21R55u1oXw0/2iMJMciXwVIpuQ6kbHTIlEerc2USKdD2/skQcO0vKGoK7v069WJgB75g5VENF7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ws7fxKfa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vcn3uBwr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ws7fxKfa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vcn3uBwr"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F2B54EC0268;
	Thu,  6 Nov 2025 12:47:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 06 Nov 2025 12:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762451258; x=1762537658; bh=QOWFxR+YUI
	hBNzgrzUDuUCbTIa4xsnCqDBxCF/4Ucxo=; b=Ws7fxKfaiOE4dbt1V+Be7W3O/B
	jDr8BySp1MwEILLMQ+goBLBtqodkyFYjwabN/i/mpXS2ESWAjK+T2xrwjVSo7+fE
	zxOn0O4vVM48pE1FZi2NKB2S7ptlDu10EllyjgDIyuPUsVUhG1Zo1T2abSUPL43t
	qx3TmqOFh8HKWPPE2TiVnAYfP3i09wfxnZr/2GF6XJ68eIBGbiZgBKAXc/NoZQ1x
	N2cmSR1htJk0thDYP9MMgFn6AK5ItWHSFzG3xpNsykgMBLw4LiiL+4g5sh0ou1Ep
	pB6o+HuldsLUdXS0J/65hQlNWsl/VKQlMNgou8B8JcnDj1HrMwtTWzAVGmFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762451258; x=1762537658; bh=QOWFxR+YUIhBNzgrzUDuUCbTIa4xsnCqDBx
	CF/4Ucxo=; b=Vcn3uBwr7wz7irVn2FVgrnj9vcbkl9IoYzlViCSrvk1nVTeoOAB
	BQKgVTDp/1vERZ3qYEmRL0fQYtS3BQMU/M1h6VEjQOX/QnmQINLsfC3TbYcZbTWB
	3RSrovvnkEf0cPdCR2hAQMUy5gyswedHHx5Cr48wpNIO7oFw4wc1uC8q0HD4suFM
	jG6331U8fvkQH/2k1hVACme03MIKs7aUwU90IO9KPJ/Z5HJgGF7hrTYqAEDU7iN4
	6EfZnGQoXuUTuUhBu9jeC32m5vJfkr32O6Rqfu6K5mdSmBD+3S1L0OnqJNZBszTm
	evxQm9I+Drldx+3YxQgTMVjzCl93jXn7/ZA==
X-ME-Sender: <xms:Od8MaSMwn2durybAgGh_UbzRaUdmPHNHeb5WxPykrNveSULftuLcjg>
    <xme:Od8MaaRgOMK7q1CLidz8fpLJtJN5UbjRffCSMXr-XwQMmPz-NNyfEnOHuEMzsL-BV
    eeUkXj3gZTs6oNtuFHS1bTKn2-oSghjXki61pXGw95aMOFKXSZ88Q>
X-ME-Received: <xmr:Od8MaQhNeg6qeo248tnci4Fogg7raGMGY6aK9pjdCxxVTXukMXitZBV4hvJPn51GMuq53O7R1jw_Me854XRCsIIH6A7Fc4-9El7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:Od8MaT8b2I2uEtKLpESezKHdj2V-lv9mv9Go26yRhfr8ml3_hGMXpA>
    <xmx:Ot8MaXGqmlsVVOd6n-fJixFp8LQdKtXbwJ7zkmRKybmw9UuFieInwg>
    <xmx:Ot8MaWkc9hIPduISgIPCa4AyEzatGzWmINCAvkedyCiZEnsLWnCCOw>
    <xmx:Ot8MabZKYFrJLKiVq095CoM31mA1sBp3cKMyyASweFHVf_yG6yFTwQ>
    <xmx:Ot8MaVJWZ7Ab7gfLiR9NbctSQhqeM1egdUByzkIxXqWfN1Q7dVhUySTD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 12:47:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/5] parseopt: fix :(optional) at command line to only
 ignore missing files
In-Reply-To: <5951a930-0e57-4201-9b56-12a41cb44333@gmail.com> (Phillip Wood's
	message of "Wed, 5 Nov 2025 16:35:25 +0000")
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
	<9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
	<ec8d1764-649d-4edf-b0ae-a19ead5f6f9a@gmail.com>
	<xmqq1pmdr9qu.fsf@gitster.g> <xmqqwm45puqr.fsf@gitster.g>
	<5951a930-0e57-4201-9b56-12a41cb44333@gmail.com>
Date: Thu, 06 Nov 2025 09:47:36 -0800
Message-ID: <xmqqecqbhx3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 04/11/2025 17:34, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> Let me have this on top of Ben's 5-patch series.
>> 
>> ----- >8 -----
>> Subject: [PATCH] parseopt: remove unreachable code
>> 
>> At this point in the code after running skip_prefix() on the
>> variable and receiving the result in the same variable, the contents
>> of the variable can never be NULL.  The function either (1) updates
>> the variable to point at a later part of the string it originally
>> pointed at, or (2) leaves it intact if the string does not have the
>> prefix.  (1) will never make the variable NULL, and (2) cannot be
>> the source of NULL, because the variable cannot be NULL before
>> calling skip_prefix(), which would die immediately by dereferencing
>> the NULL pointer in that case.
>
> Nicely explained, the changes below look good
>
> Thanks
>
> Phillip

Thanks for a quick review.

>
>> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   parse-options.c | 2 --
>>   1 file changed, 2 deletions(-)
>> 
>> diff --git a/parse-options.c b/parse-options.c
>> index 27c1e75d53..97a55300e8 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -223,8 +223,6 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
>>   			return 0;
>>   
>>   		is_optional = skip_prefix(value, ":(optional)", &value);
>> -		if (!value)
>> -			is_optional = false;
>>   		value = fix_filename(p->prefix, value);
>>   		if (is_optional && is_missing_file(value)) {
>>   			free((char *)value);
