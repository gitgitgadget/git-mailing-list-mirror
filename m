Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AA220696
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439290; cv=none; b=H1/e1gahvbfHeMPm1c1dw9HLOUbjrs5bATXZZpiIAXS8pBUqQhTCNGcdMk4zSqoTzraNmbHGsVaTphFS8SWgj5WyxhOjoOTsfUpQGRGsBOEk7fKMmvbRIhRi1EMJCnHjKQh28J9Wk/giAtGp5gCXWtPmE5YYlKzf85WRXw8pLj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439290; c=relaxed/simple;
	bh=t8xTJFXfxyqGDNG8KoGvAiWRKAvYwgULPmFSO9OkaOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u3/jexw+nrideH7iMu8UzGcMrOvUaJhpw/jlvBABszGZrUSQzKM65jy/gGUTaUftOxnhmHyYK8ZrnQjVemeFXYfC4ULRoT+Zn2Uqi2l7tBvs2QAR4oZ6o/JuFR8mpoFMVJFQ+aSO6t/oddySXqWlIlCAFPPELPpbGYlcOjCNP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HT/tnXrn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CT4PFIfr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HT/tnXrn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CT4PFIfr"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B796114015B;
	Thu,  9 Jan 2025 11:14:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 09 Jan 2025 11:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736439287; x=1736525687; bh=OH9C3SRrkM
	0gNLQRco+VJgXfMfqUNACHHuN/C2OjTLs=; b=HT/tnXrncM2cehDNYOAToSCP7V
	XESrXwwPesv2HTu2PSGL4NJ8Po+LAqBMU9EssD6iZf7AbVyZuZHMBgve2IPBsQkU
	V06hlVT7CYAq/TzRoMmWwueg3JD/I6JVdw8RU07VGp9IiOiVtuXrq7TUwe4UMwLv
	tr5gTKOT5eIIUyMlhel4b526eJRhWPlBzzbQdZIBZzdfCRsJP9+DPypuZFmyz4Vl
	AXJjVeHOeAJDyT6sQeH7QM7eZaKQ4Gdz6JTHOdWebOvFcse6knruKVUhoHpdiF14
	S3mkLv+gs2vJ7VmTECDouU8LaTwE8rPEoJr+DEok1nBI8VuKp0hGV30Us8jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736439287; x=1736525687; bh=OH9C3SRrkM0gNLQRco+VJgXfMfqUNACHHuN
	/C2OjTLs=; b=CT4PFIfrcl5ZhmAsyFCW7BRgaiSj/0UH4sY9BLx5qNklSOv16qr
	P93XJGNGu5MF/y3xJtiFH9mwfemRE8xgcney1z71NZN6tPauuD8p45KTgt7IT61E
	OQYsJ48vl0pdTrDuH1OQ6yBQxvXQK52gc0WNF9wP6Typ7UImWl07LOu91e/7F0/5
	EaCljYny5nECX3IQ9hf1KdIx2dgziXfiSayKBKfIe4zRJUXpIImm9ur+s/PjrGmb
	PV3waeCIzymbhoGwQDNEXktdw8foN2vixY3ws3taZIw7sJBT6ukam3SXE7zisVRK
	b0/NqM0HGtzfAZy0jY9LNePyMdh21kPBn2w==
X-ME-Sender: <xms:9vV_Z2lXPDYjGaXZHV5fkd7MorSCz3JpB6ycycTgBiS8L-PRaB-Y6w>
    <xme:9vV_Z92p-zgSo9qCZVEf4jWotDMSu3bwri00LEay1O7J1pui4GpctNHVcKpSpQh58
    qBtFGkMbSNFB72Yrg>
X-ME-Received: <xmr:9vV_Z0o54JLk3YGX61ipQSfuS6G-4Qt0zHUV0CXR_d2cqMPS78Hz8wdj9ClI8VaIUs2EGknNqJG-QUl48mMMrT5jIf1VtM6ppx_S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhile
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:9vV_Z6lMDD6m9Quoa8CbkUXD6nEk-QzUr06-b6Uk26Ow2SnNhyjfrA>
    <xmx:9vV_Z00-LO6D2RzX9QnajW5WPTFBltzCnDlzEo-VbAQhxl68BXPhfA>
    <xmx:9vV_ZxtRst6lEovyvzJsXstv7SGBugZ_4UjdPm0ZgOpsFxENx-2JlQ>
    <xmx:9vV_ZwVcTKgIvtivqGx2R9QlMzLVEwCMw12tajVQlrvu-7a9sa-m5g>
    <xmx:9_V_Z49tM5U_oCvVdC7YT9-KMnWSMr7na8AsCZhUZs5-xxlX-ROdKGKv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 11:14:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] t/unit-tests: convert hash to use clar test framework
In-Reply-To: <20250109140952.5267-1-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Thu, 9 Jan 2025 15:09:52 +0100")
References: <20250108120339.225596-1-kuforiji98@gmail.com>
	<20250109140952.5267-1-kuforiji98@gmail.com>
Date: Thu, 09 Jan 2025 08:14:45 -0800
Message-ID: <xmqqmsg0j762.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Adapt the hash test functions to clar framework by using clar
> assertions where necessary. Following the consensus to convert
> the unit-tests scripts found in the t/unit-tests folder to clar driven by
> Patrick Steinhardt. Test functions are structured as a standalone to
> test individual hash string and literal case.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>

The change to the test program was a very pleasant read.  It was
trivially obvious that the new version faithfully rewrites the
original.  E.g., ...

>  static void check_hash_data(const void *data, size_t data_length,
>  			    const char *expected_hashes[])
>  {
> -	if (!check(data != NULL)) {
> -		test_msg("BUG: NULL data pointer provided");
> -		return;
> -	}
> +	cl_assert(data != NULL);

... instead of using check() and giving message with test_msg(), the
clar framework gives cl_assert() for us to use.

And ...

>  #define TEST_HASH_STR(data, expected_sha1, expected_sha256) do { \
>  		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
> -		TEST(check_hash_data(data, strlen(data), expected_hashes), \
> -		     "SHA1 and SHA256 (%s) works", #data); \
> +		check_hash_data(data, strlen(data), expected_hashes); \

... instead of TEST() macro with the title string, we call the
underlying test function.  The loss of the message does not hurt us,
as both the test suite name and name of each test are shown by the
clar framework.

> -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> +void test_hash__empty_string(void)
>  {
> -	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
> -	struct strbuf alphabet_100000 = STRBUF_INIT;
> -
> -	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
> -	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
> -
>  	TEST_HASH_STR("",
>  		"da39a3ee5e6b4b0d3255bfef95601890afd80709",
>  		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");
> +}

And the fact that the body of each test function are unchanged from
the original helps to build confidence in the faithfulness of the
conversion.

The strbuf allocation is lost from here, and clean-up is lost from
the end of the file, and they are done in the function that needs
the strbuf, which also contributes to the clarity of the new
version.

Nicely done.  Will queue.

Thanks.
