Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D4313D68
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209772; cv=none; b=CfUCmVU9iOmcGvZlMKrVGoaRKnbKP1QiLMVTrIpuwhXkjMPGzM0FvOL4OAIoD7P507I2z61MIPT6VGp40U5A/UQU4jGFSE6gCzSnC2Ew4fBc17WNqL873czX6usMXTXBG6WJFtNfJUFcQpMRi1SNiDnFtdgRAUw/5w75VPOSs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209772; c=relaxed/simple;
	bh=7X9cPJWHJuxQ1T+2IwTeXmsNsy9T7p0mYtb1/uyhEqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBPeGvvN326EgdGkiydLMcdefB0TOWF0SS1KgwhL5+1KwVyHJttGQWMoxRSQg5GfTHDm/KBV+Cz2ixLwONk9jCpA5zDdMc02UyVhnZ082rHvmtXijUOCresQ5gbA78jfAbunaCi5EwHhUCzJBNWDaLrm5YMWIdOKI+1fgAJZZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=anGYmHhr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHG60cds; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="anGYmHhr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHG60cds"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C98B14000F8;
	Thu, 18 Sep 2025 11:36:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 11:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758209769; x=1758296169; bh=by6hi5bn5f
	4IqlDgUBLdXl9k78ap5ul8+70hPYCnAHg=; b=anGYmHhrLrC96m8WZWy0+yXXhf
	Tkv/OFzQbYgx02s7lehNgZEj50fDHUyDNbAQ93UYZni+1+DwQw06US4oNvWxmSSn
	+kwcaskfNVj7pwVc0F+md4l2MXuYCuscv6uBTvyfl4z0keyJp9nOetMM3lzmC712
	+6OllvKn+n2Dh6Ebj4kueAw76LYA3NeEfatJGUInhu+CCgI+llDoZWnoSUVOoENc
	ke75nNxCzvhr47g+dvRChzmSuzFc3t0ZyftDqjmyzs1GcP+24STEHSUVEUchEYNc
	rdBq1o7t7HhKsp6MMBUkXb6jYPXR4P33/eROcdJNENc4lTWMKY0e5FZSpysw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758209769; x=1758296169; bh=by6hi5bn5f4IqlDgUBLdXl9k78ap5ul8+70
	hPYCnAHg=; b=MHG60cdskYVv80oXIkw3BY8nM3xXOoAdsMjRtCfC1VTDotgOvNn
	AKuldvxKXoC3+RTDhM4QLz9LsbnJyL1QnB9muhki86Sf2hGOvsckQZ1qx+vn2LbS
	X/8ZRx7kdFbne62YTOSadRt561ZtqOJ0yQs+KHolbzs3uTI5DKWxdo4t5GlrWoUT
	aNpHhasiTb45YNrAnShLwkC7Ni8SN/qabHtWRktWOPr98eexqkt0/Iw1r4atvYUQ
	Z5KDVdyl7vOqxYCoizJH3MU6uBeGtslQooOzGhQY7OdWRNFAz3PfbKPPXImyubcp
	WxulPSKgMN3/UL0egAIXLc1njBNjFKLjGow==
X-ME-Sender: <xms:6CbMaNC62wM8od9VnSzosXuBNGTX0PD5bKErxGri1fyfgHwX8yUVXw>
    <xme:6CbMaHD9N0ncqtk1v1ltUJ-XdlVfel4IKw2XvA2UJRViIG0uuDQBTd-tEA9E2rl-m
    lU6Um2MM-ZeHEJWwA>
X-ME-Received: <xmr:6CbMaPCyasMoPK9R2MnxETpNYy3cahTjP1LC0MsIw-cMZbtyo7Y_thUoYXnRCvxBAQP7b9QwS6MR6FPSLmzEQ5FrWViySXs_vLZDh5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6CbMaCqNh1uFbGm-9tzyh_x3HDTdt0My1WtB9cb5bqB8tRQi7MfiZA>
    <xmx:6CbMaJkwP1S2MiVOgM4p-XHVYilgpdedb6NrTIHm2FxFdnbXUwSY1g>
    <xmx:6CbMaCxv1nXTvAaRNncv53uKTDqGvlq1HXAnnvT_haVFQfviKmEhHQ>
    <xmx:6CbMaB8fMHCJyOEYWcK8iSYWXTckDvMDcVDjTiFixDi8Gay_Sp5BPQ>
    <xmx:6SbMaCAncE-qvJCZA1VqQiJiKQ3ifsWTX1qVFx-XEcHy0ra2nURSv4a->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 11:36:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [PATCH v3 3/8] reftable: check for trailing newline in
 'tables.list'
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
	(Karthik Nayak's message of "Thu, 18 Sep 2025 10:11:44 +0200")
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
	<20250918-228-reftable-introduce-consistency-checks-v3-3-271af03eb34d@gmail.com>
Date: Thu, 18 Sep 2025 08:36:07 -0700
Message-ID: <xmqqo6r793iw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/reftable/basics.h b/reftable/basics.h
> index 7d22f96261..019dfe6d7e 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -167,10 +167,11 @@ void free_names(char **a);
>  
>  /*
>   * Parse a newline separated list of names. `size` is the length of the buffer,
> - * without terminating '\0'. Empty names are discarded. Returns a `NULL`
> - * pointer when allocations fail.
> + * without terminating '\0'. Empty names are discarded.
> + *
> + * Errors are assigned to the `err` variable.
>   */
> -char **parse_names(char *buf, int size);
> +char **parse_names(char *buf, int size, int *err);
>  
>  /* compares two NULL-terminated arrays of strings. */
>  int names_equal(const char **a, const char **b);

Makes sense.

> diff --git a/reftable/stack.c b/reftable/stack.c
> index f91ce50bcd..955be1edb6 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -109,11 +109,9 @@ static int fd_read_lines(int fd, char ***namesp)
>  	}
>  	buf[size] = 0;
>  
> -	*namesp = parse_names(buf, size);
> -	if (!*namesp) {
> -		err = REFTABLE_OUT_OF_MEMORY_ERROR;
> +	*namesp = parse_names(buf, size, &err);
> +	if (!*namesp)
>  		goto done;

Nice.

> diff --git a/t/unit-tests/u-reftable-basics.c b/t/unit-tests/u-reftable-basics.c
> index a0471083e7..f77ec96429 100644
> --- a/t/unit-tests/u-reftable-basics.c
> +++ b/t/unit-tests/u-reftable-basics.c
> @@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
>  #include "unit-test.h"
>  #include "lib-reftable.h"
>  #include "reftable/basics.h"
> +#include "reftable/reftable-error.h"
>  
>  struct integer_needle_lesseq_args {
>  	int needle;
> @@ -79,14 +80,17 @@ void test_reftable_basics__names_equal(void)
>  void test_reftable_basics__parse_names(void)
>  {
>  	char in1[] = "line\n";
> -	char in2[] = "a\nb\nc";
> -	char **out = parse_names(in1, strlen(in1));
> +	char in2[] = "a\nb\nc\n";
> +	int err = 0;
> +	char **out = parse_names(in1, strlen(in1), &err);
> +	cl_assert(err == 0);
>  	cl_assert(out != NULL);
>  	cl_assert_equal_s(out[0], "line");
>  	cl_assert(!out[1]);
>  	free_names(out);
>  
> -	out = parse_names(in2, strlen(in2));
> +	out = parse_names(in2, strlen(in2), &err);
> +	cl_assert(err == 0);
>  	cl_assert(out != NULL);
>  	cl_assert_equal_s(out[0], "a");
>  	cl_assert_equal_s(out[1], "b");

Sensible.

> @@ -95,10 +99,21 @@ void test_reftable_basics__parse_names(void)
>  	free_names(out);
>  }
>  
> +void test_reftable_basics__parse_names_missing_newline(void)
> +{
> +	char in1[] = "line\nline2";
> +	int err = 0;
> +	char **out = parse_names(in1, strlen(in1), &err);
> +	cl_assert(err == REFTABLE_FORMAT_ERROR);
> +	cl_assert(out == NULL);
> +}

OK.

>  void test_reftable_basics__parse_names_drop_empty_string(void)
>  {
>  	char in[] = "a\n\nb\n";
> -	char **out = parse_names(in, strlen(in));
> +	int err = 0;
> +	char **out = parse_names(in, strlen(in), &err);
> +	cl_assert(err ==  0);

I'll drop an extra SP after == here (no need to resend only to fix
this).

>  	cl_assert(out != NULL);
>  	cl_assert_equal_s(out[0], "a");
>  	/* simply '\n' should be dropped as empty string */
