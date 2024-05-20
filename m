Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AC928E7
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221243; cv=none; b=XwhYZfiJv6wsZnXZjwWi1d40cEkRH1WOOJZUZpobcR8p/gJ/oWH9vH+O9K5o4n7w8hpXBmWQduFiLgS7S9rA+bOvwnok8qcwiU3QznCej14AU2a0Nsq5BVodr+5ugxyF3r5vZwYqlxHiHjZKZOkJ5k2NzMBML2mDy6jlYa8OgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221243; c=relaxed/simple;
	bh=4wFmQFTCQ25jm8YcgoJk7llGNcLx9/aQN9fY9rtoTb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZfO3nlf0dwvbI77uy9c2Nqp4C2VK4EsFzJgiU7tA6fLCd/mCBmLObwN66hEadulhguJsLUT0wOQJJk/c7+JI0YhmXjV6AHXOw+Yt5WuqpiNOACUC8mwOOUBeXQTROw2aHoBq5MTZVsjN9HMG2LWBcgLFRghH3VecZsFjVnQPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hdbLv8Uu; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hdbLv8Uu"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D6126EFD;
	Mon, 20 May 2024 12:07:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4wFmQFTCQ25jm8YcgoJk7llGNcLx9/aQN9fY9r
	toTb0=; b=hdbLv8Uuqt6sOoYbNnJuda9yvkKAW95QUsbYBQSfLVqKdB9rCgqlcq
	obK6+TOi/ymQf4l7nF0KjrJVqC0UIII0kKTL1LQPCN5lEcuoZFfzhTJbEJX0TDhP
	bTrfF6seZJDb3jQXbzq/1z7UegUl99uz7+tW1uKbwBGJZcINxraPo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 015FC26EFC;
	Mon, 20 May 2024 12:07:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E85326EF4;
	Mon, 20 May 2024 12:07:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,  Christian
 Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Achu Luma <ach.lumap@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: port helper/test-strcmp-offset.c to
 unit-tests/t-strcmp-offset.c
In-Reply-To: <20240519204530.12258-3-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Mon, 20 May 2024 02:14:42 +0530")
References: <20240310144819.4379-1-ach.lumap@gmail.com>
	<20240519204530.12258-3-shyamthakkar001@gmail.com>
Date: Mon, 20 May 2024 09:07:18 -0700
Message-ID: <xmqq1q5wmpqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08BC0840-16C3-11EF-917C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> The v2 only adjusts the formatting to be in line with the style
> described in CodingGuidelines. And it is also rebased on 'next' to
> avoid Makefile conflicts.

Please do not base a new topic on 'next', as I will NOT be applying
it on top of 'next'.

Imagine what it takes for a topic to graduate to 'master', if it
started from the tip of 'next'?  You have to wait for ALL other
topics that are in 'next' to graduate.

Instead, new things are to be built on 'master' and fixes are to be
built on the oldest maintenance track the fix is relevant.

After building such a base, you can and should make a trial merge of
your topic into 'next' and 'seen' to see if your work interferes
with work by somebody else, which often gives you a good learning
opportunity.

Unless the conflicts are severe and is impractical, in which case
see Documentation/SubmittingPatches and look for "Under truly
exceptional circumstances".  But the conflict in Makefile about
UNIT_TEST_PROGRAMS in this case hadly qualifies as one.

Anyway, thanks for a patch.

Now for the patch text itself.

The original looked like this.

> index d8473cf2fc..0000000000
> --- a/t/helper/test-strcmp-offset.c
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -#include "test-tool.h"
> -#include "read-cache-ll.h"
> -
> -int cmd__strcmp_offset(int argc UNUSED, const char **argv)
> -{
> -	int result;
> -	size_t offset;
> -
> -	if (!argv[1] || !argv[2])
> -		die("usage: %s <string1> <string2>", argv[0]);
> -
> -	result = strcmp_offset(argv[1], argv[2], &offset);
> -
> -	/*
> -	 * Because different CRTs behave differently, only rely on signs
> -	 * of the result values.
> -	 */
> -	result = (result < 0 ? -1 :
> -			  result > 0 ? 1 :
> -			  0);
> -	printf("%d %"PRIuMAX"\n", result, (uintmax_t)offset);
> -	return 0;
> -}

It used to print the result and the discovered offset to the
standard output, which is used in the comparison of the calling test
script.  Now we are doing the check ourselves here, that part needs
to be different.  But other than that, there shouldn't be any change.

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
> +	check_int(result, ==, expect_result);
> +	check_uint((uintmax_t)offset, ==, expect_offset);
> +}

Subtle differences that do not seem to have any good reason to be
there relative to the original, namely, the order of declarations of
two local variables, how 'result' is initialized, how the exact same
comment is line-wrapped differently.  If there weren't such changes,
the output from "git show --color-moved" would have allowed readers'
eyes coast over them, but because of them, they need to read most of
the lines.  That's an inefficient use of their time.

The test used to be

> -while read s1 s2 expect
> -do
> -	test_expect_success "strcmp_offset($s1, $s2)" '
> -		echo "$expect" >expect &&
> -		test-tool strcmp-offset "$s1" "$s2" >actual &&
> -		test_cmp expect actual
> -	'
> -done <<-EOF
> -abc abc 0 3
> -abc def -1 0
> -abc abz -1 2
> -abc abcdef -1 3
> -EOF

so a misbehaving "strcmp-offset abc abc" that gives different result
can be seen by showing say

    -abc abc 0 3
    +abc abc -1 2

if it incorrectly say that the first difference is at the offset 2
and reported that the first "abc" sorts before the second "abc".

With the new code, how would the failing test look like?

> +#define TEST_STRCMP_OFFSET(string1, string2, expect_result, expect_offset) \
> +	TEST(check_strcmp_offset(string1, string2, expect_result,          \
> +				 expect_offset),                           \
> +	     "strcmp_offset(%s, %s) works", #string1, #string2)

That's a neat way to use the #stringification.  Without it the
message will say

	strcmp_offset(abc, abc) works

but it is properly C-quoted, i.e.

	strcmp_offset("abc", "abc") works

If the second string were "abc\t", then the benefit of using
#string2  would become even more prominent.

Having said that, output from overly generic:

> +	check_int(result, ==, expect_result);
> +	check_uint((uintmax_t)offset, ==, expect_offset);

used in the check_strcmp_offset() function is not all that readable,
especially given that it comes _before_ the test title.  It shows
something like

    # check "result == expect_result" failed
    #    left: -1
    #   right: 0

Hopefully it would automatically improve as the framework gets
improved, perhaps to say

    # check "result == expect_result" failed
    # result = -1, expect_result = 0

In any case, it is a general problem of the current unit test
framework and outside the scope of this patch.

> +int cmd_main(int argc, const char **argv)
n> +{
> +	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
> +	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
> +	TEST_STRCMP_OFFSET("abc", "abz", -1, 2);
> +	TEST_STRCMP_OFFSET("abc", "abcdef", -1, 3);
> +
> +	return test_done();
> +}

Looking good.

