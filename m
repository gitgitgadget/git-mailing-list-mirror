Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB2579DC
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705471302; cv=none; b=mmJ/cGuE2ubjTNhsihgv5md5kINdoTZUBNN02oqbIB5VdSvMLlUyGwPnLq9lsnDeI57IWPz5thh5RTuZn9PSOk6ko4/HXVm1cdLrvYGoTE94IylFa9o9Zj4SliSaMvqAmTltokO0wzeCH2RpDLnQCxHF4d2PCA1W1Ydetc359vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705471302; c=relaxed/simple;
	bh=cDrDvxm481Pq09iZYT0GI2BDsZ0KnM8ULkdbv7bmqWw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=GV5TbOOEIE1apymsSdzHKzw+NBAPeKTa+Vv0inncrer/q8u/oSAQv+HcxV+osLc6iI6i5fMwm4i/IcKFLgd3ItprAZYRIUdP4pBhczy5a5vHt1KsQ2OOcmwVIwvS9zMMrI148B6CkJbiJc+xRCm6PDitgxrx6n1RvMNaiswT97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UrLDKAJc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UrLDKAJc"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9cb95ddd1so4553908b3a.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705471300; x=1706076100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUNR2zSbTjJBsCle9WbXbNu0ey8T5xjpC9kyzV4dVQ0=;
        b=UrLDKAJc+A3CuT04IIw1+GywMAQlmWZgKDF7NMdO6/lbzQuSTHjCdSuLUuG+zWkHat
         IlvCYrkJ5JXbrxbLR+eXMK40dxDbTxbV6LsUTVodhhB0tEa6BInL6TP7lDq7TGam8hZi
         UGAWwlMN9vStTEf0tr+/3ueOrklgG7R+Mto0G5VQ8KsfhcL48KDTUyRzy92RdbCvTukz
         gO48IwDzVUSFrlyZT1faFEBMiM1WE7xYtHMMPVzn3w2NLWgPU5J/qW6v7fd7r5vp08f+
         DJuVZ1I33d6H1xiBlQOGhT2UTsvdPXJXWJwA3E/nKQnltAHIB39CD3WXdedQ+S7nUeSQ
         MXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705471300; x=1706076100;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUNR2zSbTjJBsCle9WbXbNu0ey8T5xjpC9kyzV4dVQ0=;
        b=wx8UfhdAcr8tQKrfSCqG72+0KLyzglz1VGLhJq2kHaxo/YpKjTNFq4Cf3oXGhoYgZT
         cpGu00cb58WvVpE4GAvcSAAz1wYkZgsEXNj7qQqHW2Ra9UTRY08MGZCLVLVDQpqRyHNz
         towgLR1stP1YGbztgPPzD6/ZLsHn3v6nc1ePZayibfsAa1aQOFjLZSgG0KTBpGRY2kbb
         4Rk2e3Pq0f26BRuQlSO5JPcKNZRV7KQ1s+iyO8ciFd4xMTLjaHBJ5KsGQJzHZNeGJAOD
         5Cm6O7yeNqYpztr2cYHwg958xF4Bznd7aaKblp/3RM8ZI/CT+zP7f3LNHf8mTF3Yv0tF
         MrYQ==
X-Gm-Message-State: AOJu0Yxn2ChDx0PMLLaCufxlrgW2TEtbyXF5SzoCNNf8X5jeQIkq471A
	eSmyTA9ruBp9jtgJNHwOUHZviQI5CDoZ
X-Google-Smtp-Source: AGHT+IGjTl473K4Yw2/AqoqsVZedSnwY+claN43W8z+c+xaUuxM1zaHA9rGjdyIIwMhldvrCYJNCLQ==
X-Received: by 2002:a17:903:1cb:b0:1d5:b28a:85ed with SMTP id e11-20020a17090301cb00b001d5b28a85edmr4837019plh.26.1705471299822;
        Tue, 16 Jan 2024 22:01:39 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:a6f6:5624:1895:86a4])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001d5e4c2d23asm2233426pls.212.2024.01.16.22.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 22:01:39 -0800 (PST)
Date: Tue, 16 Jan 2024 22:01:33 -0800
From: Josh Steadmon <steadmon@google.com>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] tests: move t0009-prio-queue.sh to the new unit
 testing framework
Message-ID: <ZadtPeTiS1HmM7aw@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
References: <pull.1642.git.1705219829965.gitgitgadget@gmail.com>
 <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>

On 2024.01.14 08:18, Chandra Pratap via GitGitGadget wrote:
> From: Chandra Pratap <chandrapratap3519@gmail.com>
> 
> t/t0009-prio-queue.sh along with t/helper/test-prio-queue.c unit
> tests Git's implementation of a priority queue. Migrate the
> test over to the new unit testing framework to simplify debugging
> and reduce test run-time. Refactor the required logic and add
> a new test case in addition to porting over the original ones in
> shell.
> 
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>     tests: move t0009-prio-queue.sh to the new unit testing framework
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1642%2FChand-ra%2Fprio-queue-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1642/Chand-ra/prio-queue-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1642
> 
> Range-diff vs v1:
> 
>  1:  ca20abe95ea ! 1:  60ac9b3c259 tests: move t0009-prio-queue.sh to the new unit testing framework
>      @@ t/unit-tests/t-prio-queue.c (new)
>       +#define REVERSE_STACK_INPUT "stack", "1", "2", "3", "4", "5", "6", "reverse", "dump"
>       +#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
>       +
>      -+#define TEST_INPUT(INPUT, EXPECTED, name)		\
>      ++#define TEST_INPUT(INPUT, EXPECTED, name)			\
>       +  static void test_##name(void)					\
>      -+{											\
>      -+	const char *input[] = {INPUT};						\
>      -+	int expected[] = {EXPECTED};					\
>      -+	int result[INPUT_SIZE];								\
>      -+	test_prio_queue(input, result);						\
>      ++{								\
>      ++	const char *input[] = {INPUT};				\
>      ++	int expected[] = {EXPECTED};				\
>      ++	int result[INPUT_SIZE];					\
>      ++	test_prio_queue(input, result);				\
>       +	check(!memcmp(expected, result, sizeof(expected)));	\
>       +}
>       +
> 
> 
>  Makefile                    |  2 +-
>  t/helper/test-prio-queue.c  | 51 -------------------
>  t/helper/test-tool.c        |  1 -
>  t/helper/test-tool.h        |  1 -
>  t/t0009-prio-queue.sh       | 66 -------------------------
>  t/unit-tests/t-prio-queue.c | 99 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 100 insertions(+), 120 deletions(-)
>  delete mode 100644 t/helper/test-prio-queue.c
>  delete mode 100755 t/t0009-prio-queue.sh
>  create mode 100644 t/unit-tests/t-prio-queue.c
> 
> diff --git a/Makefile b/Makefile
> index 312d95084c1..d5e48e656b3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -828,7 +828,6 @@ TEST_BUILTINS_OBJS += test-partial-clone.o
>  TEST_BUILTINS_OBJS += test-path-utils.o
>  TEST_BUILTINS_OBJS += test-pcre2-config.o
>  TEST_BUILTINS_OBJS += test-pkt-line.o
> -TEST_BUILTINS_OBJS += test-prio-queue.o
>  TEST_BUILTINS_OBJS += test-proc-receive.o
>  TEST_BUILTINS_OBJS += test-progress.o
>  TEST_BUILTINS_OBJS += test-reach.o
> @@ -1340,6 +1339,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
>  
>  UNIT_TEST_PROGRAMS += t-basic
>  UNIT_TEST_PROGRAMS += t-strbuf
> +UNIT_TEST_PROGRAMS += t-prio-queue
>  UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
> diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
> deleted file mode 100644
> index f0bf255f5f0..00000000000
> --- a/t/helper/test-prio-queue.c
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -#include "test-tool.h"
> -#include "prio-queue.h"
> -
> -static int intcmp(const void *va, const void *vb, void *data UNUSED)
> -{
> -	const int *a = va, *b = vb;
> -	return *a - *b;
> -}
> -
> -static void show(int *v)
> -{
> -	if (!v)
> -		printf("NULL\n");
> -	else
> -		printf("%d\n", *v);
> -	free(v);
> -}
> -
> -int cmd__prio_queue(int argc UNUSED, const char **argv)
> -{
> -	struct prio_queue pq = { intcmp };
> -
> -	while (*++argv) {
> -		if (!strcmp(*argv, "get")) {
> -			void *peek = prio_queue_peek(&pq);
> -			void *get = prio_queue_get(&pq);
> -			if (peek != get)
> -				BUG("peek and get results do not match");
> -			show(get);
> -		} else if (!strcmp(*argv, "dump")) {
> -			void *peek;
> -			void *get;
> -			while ((peek = prio_queue_peek(&pq))) {
> -				get = prio_queue_get(&pq);
> -				if (peek != get)
> -					BUG("peek and get results do not match");
> -				show(get);
> -			}
> -		} else if (!strcmp(*argv, "stack")) {
> -			pq.compare = NULL;
> -		} else {
> -			int *v = xmalloc(sizeof(*v));
> -			*v = atoi(*argv);
> -			prio_queue_put(&pq, v);
> -		}
> -	}
> -
> -	clear_prio_queue(&pq);
> -
> -	return 0;
> -}
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 876cd2dc313..5f591b9718f 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -57,7 +57,6 @@ static struct test_cmd cmds[] = {
>  	{ "path-utils", cmd__path_utils },
>  	{ "pcre2-config", cmd__pcre2_config },
>  	{ "pkt-line", cmd__pkt_line },
> -	{ "prio-queue", cmd__prio_queue },
>  	{ "proc-receive", cmd__proc_receive },
>  	{ "progress", cmd__progress },
>  	{ "reach", cmd__reach },
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 70dd4eba119..b921138d8ec 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -50,7 +50,6 @@ int cmd__partial_clone(int argc, const char **argv);
>  int cmd__path_utils(int argc, const char **argv);
>  int cmd__pcre2_config(int argc, const char **argv);
>  int cmd__pkt_line(int argc, const char **argv);
> -int cmd__prio_queue(int argc, const char **argv);
>  int cmd__proc_receive(int argc, const char **argv);
>  int cmd__progress(int argc, const char **argv);
>  int cmd__reach(int argc, const char **argv);
> diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
> deleted file mode 100755
> index eea99107a48..00000000000
> --- a/t/t0009-prio-queue.sh
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -#!/bin/sh
> -
> -test_description='basic tests for priority queue implementation'
> -
> -TEST_PASSES_SANITIZE_LEAK=true
> -. ./test-lib.sh
> -
> -cat >expect <<'EOF'
> -1
> -2
> -3
> -4
> -5
> -5
> -6
> -7
> -8
> -9
> -10
> -EOF
> -test_expect_success 'basic ordering' '
> -	test-tool prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
> -	test_cmp expect actual
> -'
> -
> -cat >expect <<'EOF'
> -2
> -3
> -4
> -1
> -5
> -6
> -EOF
> -test_expect_success 'mixed put and get' '
> -	test-tool prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
> -	test_cmp expect actual
> -'
> -
> -cat >expect <<'EOF'
> -1
> -2
> -NULL
> -1
> -2
> -NULL
> -EOF
> -test_expect_success 'notice empty queue' '
> -	test-tool prio-queue 1 2 get get get 1 2 get get get >actual &&
> -	test_cmp expect actual
> -'
> -
> -cat >expect <<'EOF'
> -3
> -2
> -6
> -4
> -5
> -1
> -8
> -EOF
> -test_expect_success 'stack order' '
> -	test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
> -	test_cmp expect actual
> -'
> -
> -test_done
> diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
> new file mode 100644
> index 00000000000..07b112f5894
> --- /dev/null
> +++ b/t/unit-tests/t-prio-queue.c
> @@ -0,0 +1,99 @@
> +#include "test-lib.h"
> +#include "prio-queue.h"
> +
> +static int intcmp(const void *va, const void *vb, void *data UNUSED)
> +{
> +	const int *a = va, *b = vb;
> +	return *a - *b;
> +}
> +
> +static int show(int *v)
> +{
> +	int ret = -1;
> +	if (v)
> +		ret = *v;
> +	free(v);
> +	return ret;
> +}
> +
> +static int test_prio_queue(const char **input, int *result)
> +{
> +	struct prio_queue pq = { intcmp };
> +	int i = 0;
> +
> +	while (*input) {
> +		if (!strcmp(*input, "get")) {

Running the test segfaults at the above strcmp() for me, from the very
first test_basic test case. I'm not sure why, there's not an obvious
problem that I can see. Does it run properly for you?


> +			void *peek = prio_queue_peek(&pq);
> +			void *get = prio_queue_get(&pq);
> +			if (peek != get)
> +				BUG("peek and get results do not match");
> +			result[i++] = show(get);
> +		} else if (!strcmp(*input, "dump")) {
> +			void *peek;
> +			void *get;
> +			while ((peek = prio_queue_peek(&pq))) {
> +				get = prio_queue_get(&pq);
> +				if (peek != get)
> +					BUG("peek and get results do not match");
> +				result[i++] = show(get);
> +			}
> +		} else if (!strcmp(*input, "stack")) {
> +			pq.compare = NULL;
> +		} else if (!strcmp(*input, "reverse")) {
> +			prio_queue_reverse(&pq);
> +		} else {
> +			int *v = xmalloc(sizeof(*v));
> +			*v = atoi(*input);
> +			prio_queue_put(&pq, v);
> +		}
> +		input++;
> +	}
> +
> +	clear_prio_queue(&pq);
> +
> +	return 0;
> +}
> +
> +#define INPUT_SIZE 6
> +
> +#define BASIC_INPUT "1", "2", "3", "4", "5", "5", "dump"
> +#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
> +
> +#define MIXED_PUT_GET_INPUT "6", "2", "4", "get", "5", "3", "get", "get", "1", "dump"
> +#define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
> +
> +#define EMPTY_QUEUE_INPUT "1", "2", "get", "get", "get", "1", "2", "get", "get", "get"
> +#define EMPTY_QUEUE_EXPECTED 1, 2, -1, 1, 2, -1
> +
> +#define STACK_INPUT "stack", "1", "5", "4", "6", "2", "3", "dump"
> +#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
> +
> +#define REVERSE_STACK_INPUT "stack", "1", "2", "3", "4", "5", "6", "reverse", "dump"
> +#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
> +
> +#define TEST_INPUT(INPUT, EXPECTED, name)			\
> +  static void test_##name(void)					\
> +{								\
> +	const char *input[] = {INPUT};				\
> +	int expected[] = {EXPECTED};				\
> +	int result[INPUT_SIZE];					\
> +	test_prio_queue(input, result);				\
> +	check(!memcmp(expected, result, sizeof(expected)));	\
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
> 
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
> -- 
> gitgitgadget
