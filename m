Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964628CF6F
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411553; cv=none; b=DWVb9qXGW4aF33QnP3P8LnLUPpuzBU1qf3nkSTxA1wV5+6FpQ7Ywlkah5FAo808Sx3q1UmKy+/jSwPHsETjlRu1VgwTQzDyA1lWh4osJSMW8mpNdmbY5jJA41OFBiIwQsO64jqhRJhAcU4zoOvXUMltQSIvJbOrj0zo1LYWKgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411553; c=relaxed/simple;
	bh=r8p6kTwoG9BmdazdExzeIGgZKygfiB9IQ3tp3oDmvCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m1aYDA6GFITJTHwsv1n1kh/RxtsGUzPaWFeeecmdYh72ezEipMnbhTBdqzYkGhRv3HPrBXJhAee0BDDlaXlDJRm+5SyOeAaoMKZF8NGFgE6XPdrQNLVoiW6bExZvCLkLaeVRMqhOdsyGQNxTMCBCKqm5TIXueLOcmjiZHX9b72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L823tqKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pr19oOF8; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L823tqKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pr19oOF8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A3CD17A0095;
	Mon, 26 Jan 2026 02:12:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 26 Jan 2026 02:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769411549; x=1769497949; bh=Wk0z2CxBhm
	/0X4maj8mJKDaHNpui9/l0/C5+r6n5Fgw=; b=L823tqKTCh8/KfQZMAklKEB/R3
	0dlAGTVadYb6/PHiHdLT9Uw01tmkhvjiOHsx7W9a2c0XG9D0g+nTG5DjvQXZ6fF4
	ZQitOCelROoZJdk5bgF3WLtI3IX6eyKjEyUph75Uu5vTTSrOqA7OYgqeEQWrNdz4
	LCTAieA+fNhWuebEiLb2n7XtKuhVWR5V49drHZLL2y1cruc2jHL0ipFIHCLHbblq
	Koo5MGIMCxv1aynarJwjPXoKh08cNGV/NRAuG8uvVLaf8sG4FQTXjry7/lHqXDZN
	TcGxmiyJP7jRvbcRTRSpoLJ9Ras7PZpF0nJwbZbJbA/WpGQNf7gc3+LarNQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769411549; x=1769497949; bh=Wk0z2CxBhm/0X4maj8mJKDaHNpui9/l0/C5
	+r6n5Fgw=; b=pr19oOF8Stji84I3/wgn49pZPun1QdRKfkTtwm4MI/YUU6IFUGx
	hIVhNmT3N2uMaqYkU4VEjD1U0uYduAfzjt0CnrBeUOJ4QAFw9O/6GR+fPgheRvvA
	K6RpcTONZHZHO7hQjlSheeRQi3AOSa920rlQOCnQ+mEQmzzHoqTxm0mvqJFLN1F4
	IVlDEKhHi+hrjGt3xQ6+arX8SWv9eUBx8UcfzdV+/ei88rw2ickxRiMA6kJAyltT
	wtgaQjafPUxtIaQKtRdgbWiHdykbqY84WapyFsXFjLsqxE8/mPpiJcQbXwDLM0P5
	F4lnK/OZCZHHNoXThOTsGEVXIZOoxdfIjkw==
X-ME-Sender: <xms:3RN3aaTydZLq1wVofayHRRYjsPUVSNJ61qjuYQqdTwsEgOyAi8n0gA>
    <xme:3RN3aTfp2DJ-D3bkvu2N7kIcTEP6aVa2AV2peKQdE7FDlvUThv5v__zY3xW3WpJ3i
    v2DIRvtgaH6Z_SiLnGqRmP_4UtdYfQfMqRrT8o6KlvkRq4R6NVkOw>
X-ME-Received: <xmr:3RN3aRoRWoHyg78xxk52LHmLFMyV5OJLK4OBJ2dSPFloO-_igAZQgaNKWBN8uaqPl4mz1g4qSP1w3JjZ3dVWjMWUwYfmvJWMuMpPn2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghilhdrtghomh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3RN3ac8TnDJk7x28MfB7qYlVl0Pf8tEoR8n5gFzLMeBrtylgW3pPyA>
    <xmx:3RN3aVc4ivFlBO1UaYkk-o-L6eARkigQVzp1AhUwSJjCiMvQkTwBbA>
    <xmx:3RN3aeJF3Pe4T3esxcUEoJPaSk9g5zfph3aiTlIQQekJ2xS0cNnYsQ>
    <xmx:3RN3adhD8-UNgBL9AvVqUC1KVtU1Ux4iBxsgiUYV7XK4KBPKKRsEFg>
    <xmx:3RN3aWArd3G6pvO4w5ljoYwLiMU7fN-WubNv0SKbfq6SzMx58oekbXlq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 02:12:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Elijah Newren <newren@gmail.com>,
  Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] u-string-list: add unit tests for string-list methods
In-Reply-To: <20260125201500.63904-1-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Mon, 26 Jan 2026 01:44:59 +0530")
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
	<20260125201500.63904-1-amishhhaaaa@gmail.com>
Date: Sun, 25 Jan 2026 23:12:27 -0800
Message-ID: <xmqqpl6wkftw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> Unit tests in u-string-list.c does not cover several methods
> in string-list, this gap in coverage makes it difficult to
> ensure no regressions are introduced in future changes.
>
> Add unit tests for the following methods to enhance coverage:
> string_list_remove_empty_items()
> unsorted_string_list_has_string()
> unsorted_string_list_delete_item()
> string_list_has_string()
> string_list_insert()
> string_list_sort()
> string_list_remove()
>
> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> ---
>  t/unit-tests/u-string-list.c | 197 +++++++++++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
>
> diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> index a2457d7b1e..6b4b858330 100644
> --- a/t/unit-tests/u-string-list.c
> +++ b/t/unit-tests/u-string-list.c
> @@ -243,6 +243,133 @@ void test_string_list__filter(void)
> ...
> +static void t_string_list_insert(struct string_list *expected_strings, ...)
> +{
> +	struct string_list strings_to_insert = STRING_LIST_INIT_DUP;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	va_list ap;
> +
> +	va_start(ap, expected_strings);
> +	t_vcreate_string_list_dup(&strings_to_insert, 0, ap);
> +	va_end(ap);
> +
> +	for (int i = 0; i < strings_to_insert.nr; i++) {

As strings_to_insert.nr is of type size_t, even though int is plenty
large enough in practice, the compiler will complain.

> +		string_list_insert(&list, strings_to_insert.items[i].string);
> +	}

Also, lose the {} around a single statement block.
