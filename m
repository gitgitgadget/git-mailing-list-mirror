Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447F17C
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713572044; cv=none; b=GRWoXi2JlYOz3PG+gisPMFXxKGFsCiqFpT8LiLZCoctBxJZnvGkDkKbyGvU1VoB2TXn2fd6efD9KXSvnyIor+fWddUGvfqfKyIipFP6rZHGWyZ0LVO33JBfUiZE2u3YF+WrqEokLA3XceOFg3ctGrgLO+MzPohDYaLDB7Lz3hPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713572044; c=relaxed/simple;
	bh=dp3CSnHQ3AkqzSux7yAuBaQzP/ZkiB1Uub6XkwXIjKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QphMDkG/MOop7xr2SyzklutyqmyY4NW/rEFxybVF3C+7Oi9zKe1aItDNX5ffYVoDA8/Y4bihWrAzwTIlhNzOA4110AuDXhfHCv9X+PRacftE/guQvba9o+fhBqYl7x3WPZhEK9Q1wb/3rBMcCa5qdfmcdPWfLXUQ7pbOtLn+wsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUcj7WTq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUcj7WTq"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de463fb34c9so5231039276.3
        for <git@vger.kernel.org>; Fri, 19 Apr 2024 17:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713572042; x=1714176842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+irKz1ci5EfkHFjdKN//PQZLljRemUoeHa/5tQB1SAc=;
        b=FUcj7WTqK1Krxb6ZNUUIUXEbmhiw34RqpDhW1vJ1PAftzK6RmQz1xoiQLw7Tr2tDM6
         bXJr7Gq6FnZ6EDqiAng/5hVfQpSL8yW73gpLy4xcfUxkRLSiPKBu1nl1wa0R9vF5X6gA
         vXr+sIFEp0RICT0oUnrnVx1/6f34HIj+uS8NAi5AUEBtZiSaWJT9cDSaTf1w9+HSzuiY
         aTuTOuA8qJFnrCOvGMgONOuPbaLaKODzz1PCrMRRylLIk2sZTm/fx5eEQY0Fq4HuS5GU
         d+bc+hczXQyeOczSsdDuV8Hl1+uSq7gcEfHIsuakmSNbCIe5FNyFCtR3cwBzFQJp/pwH
         AwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713572042; x=1714176842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+irKz1ci5EfkHFjdKN//PQZLljRemUoeHa/5tQB1SAc=;
        b=NDnZb4BqmGqiFdPQ4gdTL0D+TqaQtPqmB0vpGyAa5CAPD/JWnrOxz+1prXx3YWvdyQ
         hemb1uBwEQU0y+h3CmWWJINUK0iooCkR34Ebg7KugvcjdLH3Y37Xn6xD+smFq0NAbgCA
         0Qd1Pmn30aXrpD92DcztHRxinYnaGADi7sLKNmp3xHdxFVX5VzktzlLv3q6p3qjlJ4A3
         fyFkAjI0YcXl0L+8N/1//9bupezgomOS58eJDd1BJViP/i+fYr2JKNzn7KeZcLgryCt1
         9YoaRHJE0L/u98esK27ya6PuEenUFIu5BRjrMBkLGv0vO4vAIEVJ7qBmrT2oE4NajMDV
         EiXQ==
X-Gm-Message-State: AOJu0YwTNfYkvqJpQqFTZ/tv9+QrcXdhVB9fxAr0fupE0JGTjIpeJX7L
	gXw/eOn57P6PT4fPbQ1zgrGk9DPDLBnMnkcW1inepzPElTq2QZF/ytuGoceKe8wKye9NA2IuXA1
	fTQ==
X-Google-Smtp-Source: AGHT+IFCeNTI1hHEUek0010NvQTQf12lbml6yd2hUn6x391DLdOkLk+cfVqczuK329VreKJLrMme0LuL0/M=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1243:b0:dc6:44d4:bee0 with SMTP id
 t3-20020a056902124300b00dc644d4bee0mr337358ybu.7.1713572041750; Fri, 19 Apr
 2024 17:14:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 17:14:00 -0700
In-Reply-To: <xmqq5xwd58b9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
 <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com> <e1fa05143ac63e8fe8dbc8ccb76a89b7a008c412.1713504153.git.gitgitgadget@gmail.com>
 <xmqq5xwd58b9.fsf@gitster.g>
Message-ID: <owly7cgs6gc7.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 2/8] trailer: add unit tests for trailer iterator
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +UNIT_TEST_PROGRAMS += t-trailer
>>  UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
>>  UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
>>  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
>
> Totally offtopic, but does it bother folks who are interested in
> adding more unit tests that they do not seem to interact very well
> with GIT_SKIP_TESTS environment variable?

FWIW I am not bothered (not that I've actually used GIT_SKIP_TESTS)
mainly because the unit tests finish so quickly.

>
>> diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
>> new file mode 100644
>> index 00000000000..147a51b66b9
>> --- /dev/null
>> +++ b/t/unit-tests/t-trailer.c
>> @@ -0,0 +1,175 @@
>> +#include "test-lib.h"
>> +#include "trailer.h"
>> +
>> +static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
>> +{
>> +	struct trailer_iterator iter;
>> +	size_t i = 0;
>> +
>> +	trailer_iterator_init(&iter, msg);
>> +	while (trailer_iterator_advance(&iter)) {
>> +		i++;
>> +	}
>
> Unnecessary {braces} around a single-statement block?

Gah, I blame writing too much Go. Will fix.

I also wonder if there's a C linter that could catch this... I am not
very familiar with C tooling. Would be great to run that in CI (GGG).

>> +	trailer_iterator_release(&iter);
>> +
>> +	check_uint(i, ==, num_expected_trailers);
>> +}
>> +
>> +static void run_t_trailer_iterator(void)
>> +{
>> +	static struct test_cases {
>> +		const char *name;
>> +		const char *msg;
>> +		size_t num_expected_trailers;
>
> This is more like number of lines in the trailer block, not
> limiting its count only to true trailers, no?

Yes, but to be even more precise, it would be the number of trailer
objects in the trailer block (a single trailer could be folded over
multiple lines). Will update to "num_expected_objects".

>
>> +	} tc[] = {
>> ...
>> +		{
>> +			"with non-trailer lines in trailer block",
>> +			"subject: foo bar\n"
>> +			"\n"
>> +			/*
>> +			 * Even though this trailer block has a non-trailer line
>> +			 * in it, it's still a valid trailer block because it's
>> +			 * at least 25% trailers and is Git-generated.
>> +			 */
>> +			"not a trailer line\n"
>> +			"not a trailer line\n"
>> +			"not a trailer line\n"
>> +			"Signed-off-by: x\n",
>> +			1
>> +		},
>
> It is OK to leave it num_expected_trailers in this step and then
> rename it when you update this "1" (number of real trailer lines)
> to "4" (number of lines in the trailer block).
>
> I wonder if you'd want to make more data available to the test.  At
> least it would be more useful if the number of true trailer lines
> and the number of lines in the trialer block are available
> separately.

I purposely did the simplest test possible in order to keep the patch
simple. Totally OK with expanding the data available to the test though,
if you'd prefer that (although that could also be in a separate series
later when we start converting some of the existing shell tests to these
unit tests).

> The interface into the trailers that is being tested by this code is
> "the caller repeatedly calls the iterator, and the caller can
> inspect the iterator's state available as its .raw, .key and .val
> members and use them as it sees fit", so you could check, if you
> wanted to, the following given the above sample data:
>
>  * the first iteration finds no key/value pair (optionally, the
>    contents found in the .raw member is as expected).
>  * the second iteration finds no key/value pair (ditto).
>  * the third iteration finds no key/value pair (ditto).
>  * the fourth iteration finds key="Signed-off-by" value="x".
>  * there is no fifth iteration.
>
> but the current code only checks the last condition and nothing
> else.  I dunno.

Yeah, this sounds like the natural thing to do. Basically have an exact
list of "this is the linked list of trailer objects I expect to see
after parsing is complete".

I do plan on making the trailer iterator struct private in a future
series though, so maybe it's best to do the above after that series (to
avoid churn)? IDK.

@Christian thoughts?
