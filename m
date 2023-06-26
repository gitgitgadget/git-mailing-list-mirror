Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C3EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 13:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFZNPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 09:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjFZNPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 09:15:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D03B9
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 06:15:43 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f875b267d9so4507166e87.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687785341; x=1690377341;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXyndxv2Ahk8YMtie0uXz3woOICfqfpZWTbrxlRxJHM=;
        b=cDViUYem7Ynn2BN95N2Jk2tXexkBE6CdmzGzJnbBCmPUPaG28FUH5Nko/xguAL+awf
         hEKGy3oUadfPkF0yENrzZ+nuEsmVNqZRwUXfrXn1EMve0fRodBRhaKBNjgM25P8WCDug
         e0HMEcdiD2OBT/c/iVF722J5mm2T9KJmIeBmFSJ0wb6fO80QSygHOOLmwgccgurmIJMe
         TXsxsvuabOdFNa5PtuuIjhPYmkQRjNamZ/yGKInjRugdtH0QICgLIIrNyc2z6kuiy+Xd
         h0LSavlRbi+pgrq3zn2tD6O4EVuGkJ+sVyuqmNmNqVo783gsGFhzrYK5TvPVdHlrTj3v
         nDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687785341; x=1690377341;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXyndxv2Ahk8YMtie0uXz3woOICfqfpZWTbrxlRxJHM=;
        b=cTHV6dtr4H36UkCXkGQ+gxiMQFfV0IUm4rl6oZ7NU5Y8ei1yYLEnpVkTzql9lT/rKZ
         RhHebOZ3lNfIiLfxswYB1wPNy8yMVaTXL8LolS2aNJTBZ6L2eH2y1pDZB8Caucm1y97i
         5tP2a7jPpCt/ZB8kQguTopHzfEJ0creR7X3VC20qUUOcJetcTV4lRqWhWHDTxHnagWOb
         a8+ce/OmDIWFEHGxn/1uBAtTtIa1UVLE2a6M2rgfVYopjQWdo5JNTSIpBAZ4cqKbRiya
         zlJ/3yQWeJk/s1MeS24HUmhTo1ozZxc6iyNaA7RH3px2Ihej+3Ez8Ofr882D+Spu+oaq
         /x0Q==
X-Gm-Message-State: AC+VfDzBo0cgrkGUadBplWFNYx5eEpzuHWq6xdZQf6qINT/2SRwlDU95
        GZDg96pNywD5dpjAmNuwL9i/g37Mmrk=
X-Google-Smtp-Source: ACHHUZ69NQrbaXUseRnkPh2mM1fVdzKHJP4OEr867TQxGN05rbgROX2BLz1p04aWQTs4fhp8LW+EyA==
X-Received: by 2002:a19:5018:0:b0:4f8:75b0:2297 with SMTP id e24-20020a195018000000b004f875b02297mr12750242lfb.43.1687785340719;
        Mon, 26 Jun 2023 06:15:40 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm7724425wmb.8.2023.06.26.06.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:15:40 -0700 (PDT)
Message-ID: <a6dff108-6946-71e7-99dc-ac3b70f7d7fa@gmail.com>
Date:   Mon, 26 Jun 2023 14:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Reply-To: phillip.wood@dunelm.org.uk
To:     Linus Arver <linusa@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
 <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
 <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
 <owly8rcc3j1u.fsf@fine.c.googlers.com>
Content-Language: en-US
In-Reply-To: <owly8rcc3j1u.fsf@fine.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus

On 21/06/2023 16:57, Linus Arver wrote:
> Hello,
> 
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> I'd be interested to hear what you think of the alternative
>> approach in the patch below. The patch can be fetched with
>>
>> git fetch https://github.com/phillipwood/git unit-tests
> 
> I tried out your unit testing framework to see how it works in practice.
> It has most of what I'd expect in a test framework, e.g. showing file
> and line number in a test failure. Here are some changes I'd like to
> see:

Thanks for taking the time to try this out.

> - Make the 'TEST' macro accept the test description first. Or, keep the
>    'TEST' macro but also name a new macro 'IT' that accepts the
>    description first, to encourage usage that reads in a
>    behavior-driven-development (BDD) style, like 'IT("should accept foo",
>    t_bar(...))'. I find some test descriptions easier to write this way.

The test description is a printf style format string followed by 
arguments. This allows parameterized tests to include the parameter 
values in the description to aid debugging but it means the test 
function must be the first parameter. We could have IT("should accept 
%d", t(), i) but that would be a bit weird.

I hope that we will end up with some guidelines for writing unit tests 
that recommend testing the expect behavior and to avoid testing 
implementation details. I'm don't think we necessarily need an IT() 
macro to do that.

> - The 'check_int(result, ==, expected)' usage would be better without
>    the commas, like 'check_int(result == expected)'. Is this possible?

I don't particularly like the comma's either but in order to have decent 
diagnostic messages we need to pass 'result' and 'expected' as separate 
parameters so we can print them. We could have separate macros for 
different comparisons check_int_eq(a, b), check_int_lt(a, b), ... I 
don't have a strong preference either way.

> - It would be nice to report the test name for failing tests, so that
>    this output can be parsed to check for the failing test name.

I'm not quite sure what you mean here. The test name in printed in the 
"not ok" lines for failing tests as shown in the output from your tests 
below.

> There are other smaller changes I'd like (such as optional
> colorization), but I think these bits can be sorted out much later.

Sure

> My patch can be found at
> 
>     git fetch https://github.com/listx/git trailer-unit-tests
> 
> and also inline at the bottom of this email message.
> 
> Build and test with
> 
>      make unit-tests && t/unit-tests/t-trailer
> 
> Sample output:
> 
>      $ make -j47 unit-tests && t/unit-tests/t-trailer
>          CC t/unit-tests/t-trailer.o
>          LINK t/unit-tests/t-trailer
>      ok 1 - empty trailer_item and arg_item
>      ok 2 - identical
>      ok 3 - case should not matter
>      ok 4 - arg_item is longer than trailer_item
>      ok 5 - trailer_item is longer than arg_item
>      ok 6 - no similarity
>      ok 7 - accept WHERE_AFTER
>      ok 8 - accept WHERE_END
>      ok 9 - reject WHERE_END
>      ok 10 - token with trailing punctuation (colon)
>      ok 11 - token without trailing punctuation
>      ok 12 - token with spaces with trailing punctuation (colon)
>      ok 13 - token with spaces without trailing punctuation
>      ok 14 - token with leading non-separator punctuation
>      ok 15 - token with leading non-separator punctuation and space
>      ok 16 - one-letter token
>      ok 17 - token with punctuation in-between
>      ok 18 - token with multiple leading punctuation chars
>      # check "result == expected" failed at t/unit-tests/t-trailer.c:25
>      #    left: 1
>      #   right: 0
>      not ok 19 - empty trailer_item

This test fail because same_token() tests that the longer of its two 
arguments starts with the shorter argument, not that the two arguments 
are equal. As the shorter argument is empty in this case it returns 
true, not false.

>      # check "result == expected" failed at t/unit-tests/t-trailer.c:25
>      #    left: 1
>      #   right: 0
>      not ok 20 - empty arg_item
>      1..20
>
> Note that some of the tests I expect to fail are passing.

Which ones are those?

> These may be
> bugs but I am not sure because I don't fully understand the
> interpret-trailers machinery yet.

Thanks for sharing these tests, it is helpful to see examples of the 
test framework being used. In this case the tests are checking static 
functions from trailer.c. This mean that you have to export a number of 
functions and structs that are really implementation details. Where 
possible I think we want to concentrate our testing effort on the public 
API as (a) that is what matters to callers and (b) it avoids having to 
export internal functions and encourages people to test behavior rather 
than implementation details. There may be some cases where there are 
internal helpers that would benefit from tests. In those cases we can 
either hide the export behind a #define so it is only visible to the 
test code or just #include the file being tested in the test file (gross 
but works). An alternative to both of those is for the tests to live in 
the implementation files and have them conditionally compiled (a bit 
like rust).

Thanks again for your comments, Best Wishes

Phillip


> Linus
> 
> ---- >8 ----
>  From e5907b328d35eb37cfd1feb3a2431cb672beb4c8 Mon Sep 17 00:00:00 2001
> From: Linus Arver <linusa@google.com>
> Date: Thu, 15 Jun 2023 18:25:47 -0700
> Subject: [PATCH] add some unit tests for interpret-trailers
> 
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>   Makefile                 |  5 +++
>   t/unit-tests/t-trailer.c | 77 ++++++++++++++++++++++++++++++++++++++++
>   trailer.c                | 33 ++---------------
>   trailer.h                | 32 +++++++++++++++++
>   4 files changed, 117 insertions(+), 30 deletions(-)
>   create mode 100644 t/unit-tests/t-trailer.c
> 
> diff --git a/Makefile b/Makefile
> index f0ca5bae4b..9d68518168 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2668,6 +2668,7 @@ scalar-objs: $(SCALAR_OBJS)
>   
>   UNIT_TEST_PROGRAMS += t-basic
>   UNIT_TEST_PROGRAMS += t-strbuf
> +UNIT_TEST_PROGRAMS += t-trailer
>   UNIT_TEST_PROGS = $(patsubst %,t/unit-tests/%$X,$(UNIT_TEST_PROGRAMS))
>   UNIT_TEST_OBJS = $(patsubst %,t/unit-tests/%.o,$(UNIT_TEST_PROGRAMS))
>   UNIT_TEST_OBJS += t/unit-tests/test-lib.o
> @@ -3848,5 +3849,9 @@ t/unit-tests/t-strbuf$X: t/unit-tests/t-strbuf.o t/unit-tests/test-lib.o $(GITLI
>   	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
>   		 $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
>   
> +t/unit-tests/t-trailer$X: t/unit-tests/t-trailer.o t/unit-tests/test-lib.o builtin/interpret-trailers.o $(GITLIBS) GIT-LDFLAGS
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> +		 $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
> +
>   .PHONY: unit-tests
>   unit-tests: $(UNIT_TEST_PROGS)
> diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
> new file mode 100644
> index 0000000000..150b5606fa
> --- /dev/null
> +++ b/t/unit-tests/t-trailer.c
> @@ -0,0 +1,77 @@
> +#include "test-lib.h"
> +#include "trailer.h"
> +
> +static void t_token_len_without_separator(const char *token, size_t expected)
> +{
> +	size_t result;
> +	result = token_len_without_separator(token, strlen(token));
> +	check_uint(result, ==, expected);
> +}
> +
> +static void t_after_or_end(enum trailer_where where, int expected)
> +{
> +	size_t result;
> +	result = after_or_end(where);
> +	check_int(result, ==, expected);
> +}
> +
> +
> +static void t_same_token(char *a, char *b, int expected)
> +{
> +    struct trailer_item trailer_item = { .token = a };
> +	struct arg_item arg_item = { .token = b };
> +	size_t result;
> +	result = same_token(&trailer_item, &arg_item);
> +	check_int(result, ==, expected);
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	TEST(t_same_token("", "", 1),
> +		 "empty trailer_item and arg_item");
> +	TEST(t_same_token("foo", "foo", 1),
> +		 "identical");
> +	TEST(t_same_token("foo", "FOO", 1),
> +		 "case should not matter");
> +	TEST(t_same_token("foo", "foobar", 1),
> +		 "arg_item is longer than trailer_item");
> +	TEST(t_same_token("foobar", "foo", 1),
> +		 "trailer_item is longer than arg_item");
> +	TEST(t_same_token("foo", "bar", 0),
> +		 "no similarity");
> +
> +	TEST(t_after_or_end(WHERE_AFTER, 1), "accept WHERE_AFTER");
> +	TEST(t_after_or_end(WHERE_END, 1), "accept WHERE_END");
> +	TEST(t_after_or_end(WHERE_DEFAULT, 0), "reject WHERE_END");
> +
> +	TEST(t_token_len_without_separator("Signed-off-by:", 13),
> +	     "token with trailing punctuation (colon)");
> +	TEST(t_token_len_without_separator("Signed-off-by", 13),
> +	     "token without trailing punctuation");
> +	TEST(t_token_len_without_separator("Foo bar:", 7),
> +	     "token with spaces with trailing punctuation (colon)");
> +	TEST(t_token_len_without_separator("Foo bar", 7),
> +	     "token with spaces without trailing punctuation");
> +	TEST(t_token_len_without_separator("-Foo bar:", 8),
> +	     "token with leading non-separator punctuation");
> +	TEST(t_token_len_without_separator("- Foo bar:", 9),
> +	     "token with leading non-separator punctuation and space");
> +	TEST(t_token_len_without_separator("F:", 1),
> +	     "one-letter token");
> +	TEST(t_token_len_without_separator("abc%de#f@", 8),
> +	     "token with punctuation in-between");
> +	TEST(t_token_len_without_separator(":;*%_.#f@", 8),
> +	     "token with multiple leading punctuation chars");
> +
> +	/*
> +	 * These tests fail unexpectedly. They are probably bugs, although it may be
> +	 * the case that these bugs never bubble up to the user because of other
> +	 * checks we do elsewhere up the stack.
> +	 */
> +	TEST(t_same_token("", "foo", 0),
> +		"empty trailer_item");
> +	TEST(t_same_token("foo", "", 0),
> +		"empty arg_item");
> +
> +	return test_done();
> +}
> diff --git a/trailer.c b/trailer.c
> index a2c3ed6f28..9f59d8d7a6 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -13,35 +13,8 @@
>    * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
>    */
>   
> -struct conf_info {
> -	char *name;
> -	char *key;
> -	char *command;
> -	char *cmd;
> -	enum trailer_where where;
> -	enum trailer_if_exists if_exists;
> -	enum trailer_if_missing if_missing;
> -};
> -
>   static struct conf_info default_conf_info;
>   
> -struct trailer_item {
> -	struct list_head list;
> -	/*
> -	 * If this is not a trailer line, the line is stored in value
> -	 * (excluding the terminating newline) and token is NULL.
> -	 */
> -	char *token;
> -	char *value;
> -};
> -
> -struct arg_item {
> -	struct list_head list;
> -	char *token;
> -	char *value;
> -	struct conf_info conf;
> -};
> -
>   static LIST_HEAD(conf_head);
>   
>   static char *separators = ":";
> @@ -62,7 +35,7 @@ static const char *git_generated_prefixes[] = {
>   		pos != (head); \
>   		pos = is_reverse ? pos->prev : pos->next)
>   
> -static int after_or_end(enum trailer_where where)
> +int after_or_end(enum trailer_where where)
>   {
>   	return (where == WHERE_AFTER) || (where == WHERE_END);
>   }
> @@ -73,14 +46,14 @@ static int after_or_end(enum trailer_where where)
>    * 13, stripping the trailing punctuation but retaining
>    * internal punctuation.
>    */
> -static size_t token_len_without_separator(const char *token, size_t len)
> +size_t token_len_without_separator(const char *token, size_t len)
>   {
>   	while (len > 0 && !isalnum(token[len - 1]))
>   		len--;
>   	return len;
>   }
>   
> -static int same_token(struct trailer_item *a, struct arg_item *b)
> +int same_token(struct trailer_item *a, struct arg_item *b)
>   {
>   	size_t a_len, b_len, min_len;
>   
> diff --git a/trailer.h b/trailer.h
> index 795d2fccfd..b2031eb305 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -146,4 +146,36 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
>    */
>   void trailer_iterator_release(struct trailer_iterator *iter);
>   
> +int after_or_end(enum trailer_where where);
> +size_t token_len_without_separator(const char *token, size_t len);
> +
> +struct conf_info {
> +	char *name;
> +	char *key;
> +	char *command;
> +	char *cmd;
> +	enum trailer_where where;
> +	enum trailer_if_exists if_exists;
> +	enum trailer_if_missing if_missing;
> +};
> +
> +struct trailer_item {
> +	struct list_head list;
> +	/*
> +	 * If this is not a trailer line, the line is stored in value
> +	 * (excluding the terminating newline) and token is NULL.
> +	 */
> +	char *token;
> +	char *value;
> +};
> +
> +struct arg_item {
> +	struct list_head list;
> +	char *token;
> +	char *value;
> +	struct conf_info conf;
> +};
> +
> +int same_token(struct trailer_item *a, struct arg_item *b);
> +
>   #endif /* TRAILER_H */
