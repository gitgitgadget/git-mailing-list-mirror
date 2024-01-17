Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076BC2556C
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528343; cv=none; b=fOfFNLCYeMt9rXVrnEfpdmgsgT7YF1BYkR1ASRT4bmc4qW+fDRIrNcpeRn2ZRJ6LIqrbY8GCJQTZJJtZD+6PU92GJOaq5H/QCYeB2E+MrD++CaCGs3HPngrfFRwAtGFNEEIfriNg6DmagU+kcCG44HCIsRRky2iskmIqSv1C+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528343; c=relaxed/simple;
	bh=KwctIMwsN1zUtYShHS/nUVsI65CkXGsAQfq7i8/Ae1E=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=CksaCqbsOjtwJgYRLKca/GCy6CczyRPRw9HLVcHJvcaj1Jffz52HTc5tyonshEMFtBEkm/XXUGPax/1VaceQ2jaFMhQFJpLJo4zCraceJXGMtdeNTLoG2tqX2i2Q4qCQvnNl//GrO8nvpTeGXrkdYrtAJefDqI/VXNYLc+18HZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DfKZ7pgu; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DfKZ7pgu"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64AE31C236E;
	Wed, 17 Jan 2024 16:52:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KwctIMwsN1zUtYShHS/nUVsI65CkXGsAQfq7i8
	/Ae1E=; b=DfKZ7pguud+bL0xRM3h6qzEuvJo2Pd4Ve8514tnmq7osKSiIaHwc7+
	6dyOYSyoEkdgoSeIuokPBZVJpR0lIMczuY0D3novSZXMZSy0koszIz8uKLuZrTzZ
	NS4ULiFuYTGug/uvZL/r4VIJfqWlylYrCr8uFAwns6J4GKhXniUlM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B98D1C236D;
	Wed, 17 Jan 2024 16:52:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C131E1C236C;
	Wed, 17 Jan 2024 16:52:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap3519@gmail.com>,
  Chandra Pratap <chandrapratap376@gmail.com>
Subject: Re: [PATCH v3] tests: move t0009-prio-queue.sh to the new unit
 testing framework
In-Reply-To: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Wed, 17 Jan 2024 14:38:23
	+0000")
References: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
	<pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 13:52:13 -0800
Message-ID: <xmqqh6jbvd9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD02864C-B582-11EE-8C2D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int test_prio_queue(int *input, int *result)
> +{
> +	struct prio_queue pq = { intcmp };
> +	int i = 0;
> +
> +	while (*input) {
> +		int *val = input++;
> +		void *peek, *get;
> +		switch(*val) {

Ah, this one is a bit tricky.  I would have expected that we can
make val a pure integer, but because we need to give the address of
the element to be placed in the queue, not the value to be placed as
an element in the queue, to prio_queue_put(), we would need the
pointer.

I wonder if writing this as a more conventional for(;;) loop would
make it easier to handle, i.e.

	int val, i;

	for (i = 0; (val = *input); input++) {
		switch (val) {
		case ...:
		...
		default:
			prio_queue_put(&pq, input);
			break;
		}
	}

> +...
> +			default:
> +				prio_queue_put(&pq, val);
> +				break;
> +		}
> +	}
> +	clear_prio_queue(&pq);
> +	return 0;
> +}

> +#define TEST_INPUT(INPUT, EXPECTED, name)			\
> +  static void test_##name(void)				\
> +{								\
> +	int input[] = {INPUT};					\

I think I missed this myself in my review the last round, but we
need the sentinel value 0 at the end, i.e.,

	int input[] = {INPUT, 0};

because the test_prio_queue() loops "while (*input)".  Otherwise
the loop would not terminate.

> +	int expected[] = {EXPECTED};				\
> +	int result[ARRAY_SIZE(expected)];			\

These arrays are correct.

> +	test_prio_queue(input, result);				\
> +	check(!memcmp(expected, result, sizeof(expected)));	\

So is this check.

> +}
> +
> +TEST_INPUT(BASIC_INPUT, BASIC_EXPECTED, basic)
> +TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_EXPECTED, mixed)
> +TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_EXPECTED, empty)
> +TEST_INPUT(STACK_INPUT, STACK_EXPECTED, stack)
> +TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_EXPECTED, reverse)
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	TEST(test_basic(), "prio-queue works for basic input");
> +	TEST(test_mixed(), "prio-queue works for mixed put & get commands");
> +	TEST(test_empty(), "prio-queue works when queue is empty");
> +	TEST(test_stack(), "prio-queue works when used as a LIFO stack");
> +	TEST(test_reverse(), "prio-queue works when LIFO stack is reversed");
> +
> +	return test_done();
> +}

Other than that, looking good.  Thanks.
