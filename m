Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3E2C08AD
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598580; cv=none; b=bm6iPZ2x1AyftkgiANW4GY+2mqc58/Cv3oO3hKEFY0Bhidk/ilR4px1mv8nmN2HheeKPpE2+Eqz2HmZbSnIG/gm39wwrY6S+YDg6t5yklpvEyKItH20un/TU18K02CH9dIy5mFCcXiIihhQ2uqauQ5HiOMjS1mw0YXIZtfk0MB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598580; c=relaxed/simple;
	bh=hSqiEXR0MyAi8gXdgcQHN+Wr8tLDn+sXYGd+WSAMqRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpJDY8cuNpSA/5dLpPxITyRfxIicrs5eeoOg9+XoHenTtc2J+4SZ3+Sj5lSbzgTai1l+zZfsswZVqJxeyDOyiaHq5Z34HZ7v52UevkNtNX1M86dc9jKDNDmSAHLvZyvpAfW3I9ZcxHDIPB1AzNnAN7PSNgNs7ttRU+Y8db3+pUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0eLE80d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0eLE80d"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b38de7940so2043441f8f.3
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 06:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764598575; x=1765203375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9BoBISsiJ3sjHMyCo/YN8C3v+J4nT5sWOuFv7lPqd5A=;
        b=S0eLE80dpjM9PnmiRWTPeXE8wytTKOygRAlPFJORFeRekJJhfbFhPi6BgWkQaGoOJZ
         j4xFNn7K5izNI0T6CO4Zw+XDFAHCTX/9VWcDRzbELVHBU63Las9EzA5cBekNYAdaPIwh
         DDUNGAC45KFFe1kkRlM7Al8Xz65O5CdJindHhG+O53Scq1Q0Rw3FM7q2uqbbEvQNUNnM
         y4zBDPFecpwqPcrRKlMDg2C5/CGaEtwgZKv5BtrBz2JO+QiM/TSdb3sjSxKUryFNz+/H
         j26h3OuRf+aZkHAOAAvAje25fZ74dr7obMKbNDAZvL8PQ8YAgeQYJ7DSjClr53nTrRGM
         LzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598575; x=1765203375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BoBISsiJ3sjHMyCo/YN8C3v+J4nT5sWOuFv7lPqd5A=;
        b=eZbkTF4pbIjNCVlQvjELnPZcyGf4Zuls1amhOdGyLokUu5fBeIhPV542cQ+Y1zc4AH
         Pg12dP2tGCOomGUTiBaTy5r/4ovgx3nxNlkTDUNr3w6cmUkIQCVxYlzYxlInW8IBNqSs
         0iuv27wkC86pkE/0Cf0kvaIZ2HQAhNFvMS4r92NScI3uj8oKjberfnG3odXMPhtcISv1
         LpdYDT5NeB/KcSIAvANkb1NT9/8Ue0JrJai6Aoj9maNvPr2upKxl2a2/dJtq7PjDC2pM
         8RgF1/k2XECFonLywIv0h1m3ySMdvN2VvgscIeaj2XBnKN4GUmcR6JUua/ztG0VYcUJc
         jdJw==
X-Forwarded-Encrypted: i=1; AJvYcCX5t4iT5hpWlDn1HNM0zY18C2qioAU7hlZHjeaPHb0dJJaCrWtxnB08JQYaKII6JD/JGKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywpfs3Za/jFYNLxOvV5XHUmrVMh498/izSzVxX3CFKARAaPjbK
	foBLOwLmp3ZoOc6YVkJQ9wzz0BAOczPcnSM0gLvyN/cuQCduiD2LZuYOXeRp6w==
X-Gm-Gg: ASbGncuGGXZe3kGfUm9/0RQjnCWo2RFVr53V0ZHBZlfVc3RUf2KaH7f5Q+Y83ZJK/Rs
	W9Ln0UyQTmxIW/RELE+TO2wXyF9hgIDzJwtfzJwUvwbbFvIlrc9xfSgOVHeSszvgmzLKQHOUos7
	0nanTFrr1xGcsPbCfWaT4na8y7xRheSWGg5BDiOyniouvMDkX5abZXdjMjz5MLFTyprZSOpR2Ih
	5l6kcll79cGZRwMLrnJaQ8BFIgfnmYrb4B9QaqGuImv1WyJtN8b3HRttS/R7pxX3FED8RB0qhiL
	O/+93y+5xxdP/kk4THuuz7szD2UWBHjKRb6cNpONlEk2tmXQ725O4tG/4yYYVdnbku2EqHhCMuv
	OuKSbTdrvyr0oGT9catB/xGFgALGb0rjM6h20vlGH9IEd0fVLwhFbhCH/kOQHcln2SZ/zSETvIL
	XGeD08GIDIuQd+C4n2O9XibImmBAoF7rZyeSuwSyEC/CYJXy/UmJAONQLG0W/0xHmRgvwJ/w0Bj
	Q==
X-Google-Smtp-Source: AGHT+IFshOzRqwCwaV3kENx9tbW7PJyF9EUkLefgQykePdid7GytuKRzjVLBWXFUNIyC4f/rndR01A==
X-Received: by 2002:adf:8bcf:0:b0:42b:3806:2ba0 with SMTP id ffacd0b85a97d-42cc1ab887fmr29563973f8f.2.1764598575305;
        Mon, 01 Dec 2025 06:16:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm26817083f8f.12.2025.12.01.06.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 06:16:14 -0800 (PST)
Message-ID: <bd0a8a76-fccb-4b6c-abb7-b53dd890e9e0@gmail.com>
Date: Mon, 1 Dec 2025 14:16:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: my complaints with clar
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>
References: <20251130131351.GA198697@coredump.intra.peff.net>
 <20251130131537.GB199335@coredump.intra.peff.net>
 <20251130134625.GA199421@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20251130134625.GA199421@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 30/11/2025 13:46, Jeff King wrote:
> 
>    cl_invoke(check_int_full("0", 0));
>    cl_invoke(check_int_full("11", 11));
>    cl_invoke(check_int_full("-23", -23));
>    cl_invoke(check_int_full("+23", 23));
> 
> gives you the line number in the caller. Better, but there's a lot of
> cross-referencing the line numbers (plus sprinkling cl_invoke everywhere
> is ugly).

The README for the old unit-testing framework recommended wrapping 
helper functions in a macro to pass the file and line numbers from the 
calling site. Perhaps we should do the same with clar

#define check_int_full(input, expect) cl_invoke(check_int_full(input, 
expect))

> What I really would have liked is some notion of "context". If the
> helper could have done:
> 
>    cl_context("input: %.*s", (int)len, buf);
> 
> or similar, and failed assertions print that context, then that would
> have made the failing part of the test easy to see, even without using
> cl_invoke() at all.

If you're writing a helper function you might want to use cl_failf() 
instead of cl_assert_* to provide more context but it's a pain that you 
can't just use the builtin assertions. I've not used them but there are 
assertions named cl_assert_*_ which I think let you add some context. 
One of the features of the conversion of our unit tests from the old 
framework to clar has been a degradation of the diagnostic messages when 
a test fails.

>> +void test_parse_int__basic(void)
>> +{
>> +	cl_invoke(check_int_full("0", 0));
>> +	cl_invoke(check_int_full("11", 11));
>> +	cl_invoke(check_int_full("-23", -23));
>> +	cl_invoke(check_int_full("+23", 23));
>> +	cl_invoke(check_int_str("  31337  ", 7, 0, 31337));
>> +
>> +	cl_invoke(check_int_err("  garbage", EINVAL));
>> +	cl_invoke(check_int_err("", EINVAL));
>> +	cl_invoke(check_int_err("-", EINVAL));
>> +
>> +	cl_invoke(check_int("123", 2, 2, 0, 12));
>> +}
> 
> into a series of nine separate tests, each of which gets a name. But
> each of those tests is at least five lines of boilerplate, which sucks
> (plus you have to come up with syntactically valid C names for them).

Yes that's a pain. One of the nice things about the old framework was 
the the TEST() macro just took an expression and created a test case out 
of it which worked well for tests like this and meant you could have 
table driven tests where each entry in the table was a separate test case.

>> +	/*
>> +	 * Do not use cl_assert_equal_i_fmt(..., PRIuMAX) here. The macro
>> +	 * casts to int under the hood, corrupting the values.
>> +	 */
>> +	clar__assert_equal(CLAR_CURRENT_FILE, CLAR_CURRENT_FUNC,
>> +			   CLAR_CURRENT_LINE,
>> +			   "expect_result != result", 1,
>> +			   "%"PRIuMAX, expect_result, result);
>> +}
> 
> This was an exciting bug to track down. If you use i_fmt() here, you get
> some neat undefined behavior. It worked for gcc, but failed with clang
> (but only with -O2!).
> 
> Obviously this was me using it wrong, and the "i" in the macro should
> have been a hint. But this invocation is kind of ugly, with the explicit
> mentions of internal CLAR variables. clar__assert_equal() understands
> PRIuMAX as a comparator, but there doesn't appear to be any macro to use
> it nicely.
> 
> Should there be a generic cl_assert_equal() that fills in the first
> few parameters but is otherwise type-agnostic?

Patrick's got a PR open for that at 
https://github.com/clar-test/clar/pull/117 it seems to have got stuck 
because of a lack of review.

>    # start of suite 10: parse_int
>    not ok 59 - parse_int::basic
>        ---
>        reason: |
>          expect_result != result
>          10 != 11
>        at:
>          file: 't/unit-tests/u-parse-int.c'
>          line: 41
>          function: 'test_parse_int__basic'
>        ---
> 
> OK, but "prove t/unit-tests/bin/unit-tests" gives me:
> 
>    t/unit-tests/bin/unit-tests .. Failed 1/59 subtests
>    
>    Test Summary Report
>    -------------------
>    t/unit-tests/bin/unit-tests (Wstat: (none) Tests: 59 Failed: 1)
>      Failed test:  59
>      Parse errors: Badly formed hash line: '---' at /usr/share/perl/5.40/TAP/Parser/YAMLish/Reader.pm line 244.
> 
> Yuck. It actually does have what I need (that test 59 was the failure),
> so the extra parse error is mostly a red herring (though it does prevent
> us finding any further failures). I think in TAP that arbitrary output
> is supposed to be prefixed with a "#".

TAP also allows you to embed YAML and unfortunately that's what clar 
tries to do but that last "    ---" line should be "    ...". With the 
diff below (which I'm afraid thunderbird will probably mangle) prove 
parses the output correctly but still does not print the error message. 
I'll update clar's self tests and open a PR later this week.

---- 8< ----
diff --git a/t/unit-tests/clar/clar/print.h b/t/unit-tests/clar/clar/print.h
index 89b66591d75..6a2321b399d 100644
--- a/t/unit-tests/clar/clar/print.h
+++ b/t/unit-tests/clar/clar/print.h
@@ -164,7 +164,7 @@ static void clar_print_tap_ontest(const char 
*suite_name, const char *test_name,
                          printf("      file: '"); 
print_escaped(error->file); printf("'\n");
                          printf("      line: %" PRIuMAX "\n", 
error->line_number);
                          printf("      function: '%s'\n", error->function);
-                        printf("    ---\n");
+                        printf("    ...\n");
                  }

                  break;
---- >8 ----

> In test-lib.sh, we solve this by
> only allowing "--verbose-log", not regular "-v", under a TAP harness.
> 
> I kind of wonder if we should have t0011-unit-tests.sh that simply runs
> unit-tests and filters the output into stdout and stderr.

I don't have a strong opinion on this but now that we don't run the unit 
tests in parallel because clar links them all into a single executable 
there is less reason to use prove.


Thanks

Phillip

