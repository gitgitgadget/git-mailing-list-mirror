Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F117E77B
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629366; cv=none; b=lY9WYogePThtbyy8BcgFSEzSxTCRvvwMWxhJmCvQrIV8Lsa5TZqv1bxP3l0SrBr7q5vy9ffPF0u3dF4cAFOe2RyMh1HLxCvSfBAnX3mDBFm9OsqRhsu9Dw7itZY1nXwbcSXtIWDngN87OR0tc2ya4vv1x8piwNKLTTiQpsfU26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629366; c=relaxed/simple;
	bh=bg9loCkET3CcSLC/A0mOGEMUU3UAhJ3bMBkooNUGXF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKLd6Ir5C6hv07PIJW+3+4wbk+7PU7O41kq/udnmvynQwbYrJBzJ/WCNleAUDYyPkABMGAyUsmf7FegZXwo9Hq68q/6aJdzKIyHskBCA0poDx5N18bVoy0VMQQwSE7l6ybCqklMvEkEmMreLxPGDYNwzQdtAoWYxyQsK4ZCTwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPeLwH+N; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPeLwH+N"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6bee809b8so893482b3a.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711629363; x=1712234163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2z4AmX9aYjzvYLq8cexEBqMjItBdM/IJwab0XZfB8aI=;
        b=GPeLwH+N5Ar1GxHtKAwIJ+hNVWHaHTyCPRceC18PwJy7HPVjvvCz4UT6YCViXp39+M
         X0cd1kYhEkaOZwjFlzAefT+QuWWQqlfuoHiYWT4bcKa+HeSPXcqjavPPN1gmkRqQ7XV0
         m45DazKQlG29KGAux0FnnGD5kp+5/KnyJsNrB4NrrWo5ARFR1b4p7GfCdAtDsbxdQatR
         i+mCMZcELMNB47iMKlOwIHZ/AJOmoH3SFyUUUfccE4AxrEocFkKHluAGuks8TrXR3ZR+
         Xla3lM09eALydo9X4LsEibzDfvdAdZ9RyvhOT0XszIGja4F+apr9bJBBkbC41JBgpsjm
         WF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629363; x=1712234163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z4AmX9aYjzvYLq8cexEBqMjItBdM/IJwab0XZfB8aI=;
        b=YJozuhdLsaNr/0FQLqrjGyt59j43xougWbHIYZkMPD/amEsib6vSM8IsZcfQRV/UY0
         szXAtyh/5WhwFsuvusUEmNOyhKMRby3PPK8GHL88DBzcXLKY72ZZdJ5hz4XM52z3T+Fg
         xPcGWjYikLLWKFEuOBB6QUMD6VkGbaMVTU8LVS2v5Y+0GHBkx5HVj8Rsvqr+K5Nw6vLt
         Zi/pc+ZX/SSIAttq3VWtWt4uez8GQ7RPpUNVmORPeJDwokGt7akq+S6lXYCSamxpWplw
         Aj7osB9Pp/FQenej+X0U0YWvV8+9BQXITpEKcM/tD4jgd8PePjbc7IRPtym+37vRu0Io
         n3aw==
X-Gm-Message-State: AOJu0YxeH4yGFnJSi3tkJUWHbz07i33lP8WiqnzAMFYo0gsMd15rjXTf
	rHg+PSP9MWMlwYJ1yAjJ81MNFqh8e+9vmyywxMhesWklbH5RWDbm
X-Google-Smtp-Source: AGHT+IG3KD1ZX0p8sqHWyjhCx16stTD7q7QsJuT6mre5kOWTTMyKFfSEXZmJwBkeBOoMUcioybCFwg==
X-Received: by 2002:a05:6a20:394d:b0:1a3:6fbb:e31f with SMTP id r13-20020a056a20394d00b001a36fbbe31fmr3360357pzg.4.1711629363225;
        Thu, 28 Mar 2024 05:36:03 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id p10-20020a62b80a000000b006eac6425dedsm1281099pfe.219.2024.03.28.05.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:36:02 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:05:59 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Outreachy][PATCH 2/2] Port helper/test-date.c to
 unit-tests/t-date.c
Message-ID: <tpaamfc3g5mrrbfufyvxi67ja2ko2hiihrptwxkbmdx4qpid3f@7aashrngiscn>
References: <20240205162506.1835-1-ach.lumap@gmail.com>
 <20240205162506.1835-2-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205162506.1835-2-ach.lumap@gmail.com>

On 24/02/05 05:25PM, Achu Luma wrote:
> In the recent codebase update (8bf6fbd (Merge branch
> 'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
> merged, providing a standardized approach for testing C code. Prior to
> this update, some unit tests relied on the test helper mechanism,
> lacking a dedicated unit testing framework. It's more natural to perform
> these unit tests using the new unit test framework.
> 
> This commit migrates the unit tests for C date functions
> (show_date_relative(), show_date(), etc) from the legacy approach
> using the test-tool command `test-tool date` in t/helper/test-date.c
> to the new unit testing framework (t/unit-tests/test-lib.h).
> 
> The migration involves refactoring the tests to utilize the testing
> macros provided by the framework (TEST() and check_*()).
> 
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Achu Luma <ach.lumap@gmail.com>
> ---
>  I am currently facing challenges in handling the time zone (TZ)
>  variable, in t-date.c. The tests, which were initially passing
>  in the t0006-date.sh  on Windows, fail after porting to the new
>  framework. I have tried to set the timezone using the setenv,
>  but unfortunately, the issue persists. I suspect that the problem
>  might be related to how Windows C compilers process the setenv
>  function compared to POSIX environments. Please If anyone has
>  insights into managing environment variables in a cross-platform
>  manner or has encountered similar issues, your help would be
>  highly appreciated.

I believe the issue might not be related to the setenv function, but rather
with tzset(). As you can see here[1], when we set TZ before we call the
unit-testing binaries, the tests which were failing (EST5 ones that I
separated with t-datetest) pass on 'win test (0)', and the ones which
were passing (UTC ones, t-date) fail. (Although some tests on linux are also
failing, but that can be explained by the fact that t-date runs first
and sets the TZ to UTC, afterwhich t-datetest runs and fails, although
this is not conclusive). Therefore, I am almost certain that the issue
is with changing the timezone during runtime on windows and not with setting
TZ variable with setenv(). CC'ing Johannes to see if he has any insights
on this.

Other that that, there are many places in this patch where indentation
is done with spaces instead of tabs, so it'd be good to change that.

Thanks.

[1]:
https://github.com/spectre10/git/actions/runs/8466649087/job/23196586161
> 
>  t/helper/test-date.c  |  91 +---------------
>  t/t0006-date.sh       | 169 ------------------------------
>  t/unit-tests/t-date.c | 237 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 238 insertions(+), 259 deletions(-)
>  delete mode 100755 t/t0006-date.sh
>  create mode 100644 t/unit-tests/t-date.c
> 
> diff --git a/t/helper/test-date.c b/t/helper/test-date.c
> index be0b8679c3..b9cb2c5455 100644
> --- a/t/helper/test-date.c
> +++ b/t/helper/test-date.c
> @@ -3,89 +3,11 @@
>  #include "trace.h"
> 
>  static const char *usage_msg = "\n"
> -"  test-tool date relative [time_t]...\n"
> -"  test-tool date human [time_t]...\n"
> -"  test-tool date show:<format> [time_t]...\n"
> -"  test-tool date parse [date]...\n"
> -"  test-tool date approxidate [date]...\n"
>  "  test-tool date timestamp [date]...\n"
>  "  test-tool date getnanos [start-nanos]\n"
>  "  test-tool date is64bit\n"
>  "  test-tool date time_t-is64bit\n";
> 
> -static void show_relative_dates(const char **argv)
> -{
> -	struct strbuf buf = STRBUF_INIT;
> -
> -	for (; *argv; argv++) {
> -		time_t t = atoi(*argv);
> -		show_date_relative(t, &buf);
> -		printf("%s -> %s\n", *argv, buf.buf);
> -	}
> -	strbuf_release(&buf);
> -}
> -
> -static void show_human_dates(const char **argv)
> -{
> -	for (; *argv; argv++) {
> -		time_t t = atoi(*argv);
> -		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(HUMAN)));
> -	}
> -}
> -
> -static void show_dates(const char **argv, const char *format)
> -{
> -	struct date_mode mode = DATE_MODE_INIT;
> -
> -	parse_date_format(format, &mode);
> -	for (; *argv; argv++) {
> -		char *arg;
> -		timestamp_t t;
> -		int tz;
> -
> -		/*
> -		 * Do not use our normal timestamp parsing here, as the point
> -		 * is to test the formatting code in isolation.
> -		 */
> -		t = parse_timestamp(*argv, &arg, 10);
> -		while (*arg == ' ')
> -			arg++;
> -		tz = atoi(arg);
> -
> -		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
> -	}
> -
> -	date_mode_release(&mode);
> -}
> -
> -static void parse_dates(const char **argv)
> -{
> -	struct strbuf result = STRBUF_INIT;
> -
> -	for (; *argv; argv++) {
> -		timestamp_t t;
> -		int tz;
> -
> -		strbuf_reset(&result);
> -		parse_date(*argv, &result);
> -		if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) == 2)
> -			printf("%s -> %s\n",
> -			       *argv, show_date(t, tz, DATE_MODE(ISO8601)));
> -		else
> -			printf("%s -> bad\n", *argv);
> -	}
> -	strbuf_release(&result);
> -}
> -
> -static void parse_approxidate(const char **argv)
> -{
> -	for (; *argv; argv++) {
> -		timestamp_t t;
> -		t = approxidate(*argv);
> -		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
> -	}
> -}
> -
>  static void parse_approx_timestamp(const char **argv)
>  {
>  	for (; *argv; argv++) {
> @@ -106,22 +28,11 @@ static void getnanos(const char **argv)
> 
>  int cmd__date(int argc UNUSED, const char **argv)
>  {
> -	const char *x;
> 
>  	argv++;
>  	if (!*argv)
>  		usage(usage_msg);
> -	if (!strcmp(*argv, "relative"))
> -		show_relative_dates(argv+1);
> -	else if (!strcmp(*argv, "human"))
> -		show_human_dates(argv+1);
> -	else if (skip_prefix(*argv, "show:", &x))
> -		show_dates(argv+1, x);
> -	else if (!strcmp(*argv, "parse"))
> -		parse_dates(argv+1);
> -	else if (!strcmp(*argv, "approxidate"))
> -		parse_approxidate(argv+1);
> -	else if (!strcmp(*argv, "timestamp"))
> +	if (!strcmp(*argv, "timestamp"))
>  		parse_approx_timestamp(argv+1);
>  	else if (!strcmp(*argv, "getnanos"))
>  		getnanos(argv+1);
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> deleted file mode 100755
> index e18b160286..0000000000
> --- a/t/t0006-date.sh
> +++ /dev/null
> @@ -1,169 +0,0 @@
> -#!/bin/sh
> -
> -test_description='test date parsing and printing'
> -
> -TEST_PASSES_SANITIZE_LEAK=true
> -. ./test-lib.sh
> -
> -# arbitrary reference time: 2009-08-30 19:20:00
> -GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
> -
> -check_relative() {
> -	t=$(($GIT_TEST_DATE_NOW - $1))
> -	echo "$t -> $2" >expect
> -	test_expect_${3:-success} "relative date ($2)" "
> -	test-tool date relative $t >actual &&
> -	test_cmp expect actual
> -	"
> -}
> -
> -check_relative 5 '5 seconds ago'
> -check_relative 300 '5 minutes ago'
> -check_relative 18000 '5 hours ago'
> -check_relative 432000 '5 days ago'
> -check_relative 1728000 '3 weeks ago'
> -check_relative 13000000 '5 months ago'
> -check_relative 37500000 '1 year, 2 months ago'
> -check_relative 55188000 '1 year, 9 months ago'
> -check_relative 630000000 '20 years ago'
> -check_relative 31449600 '12 months ago'
> -check_relative 62985600 '2 years ago'
> -
> -check_show () {
> -	format=$1
> -	time=$2
> -	expect=$3
> -	prereqs=$4
> -	zone=$5
> -	test_expect_success $prereqs "show date ($format:$time)" '
> -		echo "$time -> $expect" >expect &&
> -		TZ=${zone:-$TZ} test-tool date show:"$format" "$time" >actual &&
> -		test_cmp expect actual
> -	'
> -}
> -
> -# arbitrary but sensible time for examples
> -TIME='1466000000 +0200'
> -check_show iso8601 "$TIME" '2016-06-15 16:13:20 +0200'
> -check_show iso8601-strict "$TIME" '2016-06-15T16:13:20+02:00'
> -check_show rfc2822 "$TIME" 'Wed, 15 Jun 2016 16:13:20 +0200'
> -check_show short "$TIME" '2016-06-15'
> -check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
> -check_show raw "$TIME" '1466000000 +0200'
> -check_show unix "$TIME" '1466000000'
> -check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
> -check_show raw-local "$TIME" '1466000000 +0000'
> -check_show unix-local "$TIME" '1466000000'
> -
> -check_show 'format:%z' "$TIME" '+0200'
> -check_show 'format-local:%z' "$TIME" '+0000'
> -check_show 'format:%Z' "$TIME" ''
> -check_show 'format-local:%Z' "$TIME" 'UTC'
> -check_show 'format:%%z' "$TIME" '%z'
> -check_show 'format-local:%%z' "$TIME" '%z'
> -
> -check_show 'format:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 16:13:20'
> -check_show 'format-local:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 09:13:20' '' EST5
> -
> -check_show 'format:%s' '123456789 +1234' 123456789
> -check_show 'format:%s' '123456789 -1234' 123456789
> -check_show 'format-local:%s' '123456789 -1234' 123456789
> -
> -# arbitrary time absurdly far in the future
> -FUTURE="5758122296 -0400"
> -check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
> -check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_IS_64BIT
> -
> -check_parse() {
> -	echo "$1 -> $2" >expect
> -	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
> -	TZ=${3:-$TZ} test-tool date parse '$1' >actual &&
> -	test_cmp expect actual
> -	"
> -}
> -
> -check_parse 2008 bad
> -check_parse 2008-02 bad
> -check_parse 2008-02-14 bad
> -check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
> -check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> -check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
> -check_parse '20080214T20:30:45' '2008-02-14 20:30:45 +0000'
> -check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000'
> -check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
> -check_parse '20080214T203045' '2008-02-14 20:30:45 +0000'
> -check_parse '20080214T2030' '2008-02-14 20:30:00 +0000'
> -check_parse '20080214T000000.20' '2008-02-14 00:00:00 +0000'
> -check_parse '20080214T00:00:00.20' '2008-02-14 00:00:00 +0000'
> -check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
> -check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
> -check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
> -check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
> -check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
> -check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
> -check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
> -check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
> -check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
> -check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
> -check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
> -check_parse 'Thu, 7 Apr 2005 15:14:13 -0700' '2005-04-07 15:14:13 -0700'
> -
> -check_approxidate() {
> -	echo "$1 -> $2 +0000" >expect
> -	test_expect_${3:-success} "parse approxidate ($1)" "
> -	test-tool date approxidate '$1' >actual &&
> -	test_cmp expect actual
> -	"
> -}
> -
> -check_approxidate now '2009-08-30 19:20:00'
> -check_approxidate '5 seconds ago' '2009-08-30 19:19:55'
> -check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
> -check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
> -check_approxidate yesterday '2009-08-29 19:20:00'
> -check_approxidate 3.days.ago '2009-08-27 19:20:00'
> -check_approxidate '12:34:56.3.days.ago' '2009-08-27 12:34:56'
> -check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
> -check_approxidate 3.months.ago '2009-05-30 19:20:00'
> -check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
> -
> -check_approxidate '6am yesterday' '2009-08-29 06:00:00'
> -check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
> -check_approxidate '3:00' '2009-08-30 03:00:00'
> -check_approxidate '15:00' '2009-08-30 15:00:00'
> -check_approxidate 'noon today' '2009-08-30 12:00:00'
> -check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
> -check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
> -check_approxidate '10am noon' '2009-08-29 12:00:00'
> -
> -check_approxidate 'last tuesday' '2009-08-25 19:20:00'
> -check_approxidate 'July 5th' '2009-07-05 19:20:00'
> -check_approxidate '06/05/2009' '2009-06-05 19:20:00'
> -check_approxidate '06.05.2009' '2009-05-06 19:20:00'
> -
> -check_approxidate 'Jun 6, 5AM' '2009-06-06 05:00:00'
> -check_approxidate '5AM Jun 6' '2009-06-06 05:00:00'
> -check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
> -
> -check_approxidate '2008-12-01' '2008-12-01 19:20:00'
> -check_approxidate '2009-12-01' '2009-12-01 19:20:00'
> -
> -check_date_format_human() {
> -	t=$(($GIT_TEST_DATE_NOW - $1))
> -	echo "$t -> $2" >expect
> -	test_expect_success "human date $t" '
> -		test-tool date human $t >actual &&
> -		test_cmp expect actual
> -'
> -}
> -
> -check_date_format_human 18000 "5 hours ago" # 5 hours ago
> -check_date_format_human 432000 "Tue Aug 25 19:20" # 5 days ago
> -check_date_format_human 1728000 "Mon Aug 10 19:20" # 3 weeks ago
> -check_date_format_human 13000000 "Thu Apr 2 08:13" # 5 months ago
> -check_date_format_human 31449600 "Aug 31 2008" # 12 months ago
> -check_date_format_human 37500000 "Jun 22 2008" # 1 year, 2 months ago
> -check_date_format_human 55188000 "Dec 1 2007" # 1 year, 9 months ago
> -check_date_format_human 630000000 "Sep 13 1989" # 20 years ago
> -
> -test_done
> diff --git a/t/unit-tests/t-date.c b/t/unit-tests/t-date.c
> new file mode 100644
> index 0000000000..dd5dbbb2e0
> --- /dev/null
> +++ b/t/unit-tests/t-date.c
> @@ -0,0 +1,237 @@
> +#include "test-lib.h"
> +#include "date.h"
> +#include "strbuf.h"
> +
> +/* Reference time: 2009-08-30 19:20:00. */
> +#define GIT_TEST_DATE_NOW 1251660000
> +
> +/* The time corresponds to Wed, 15 Jun 2016 16:13:20 +0200. */
> +static const char test_time[] = "1466000000 +0200";
> +
> +enum prerequisites {
> +    	TIME_IS_64BIT = 1 << 0,
> +    	TIME_T_IS_64BIT = 1 << 1,
> +};
> +
> +/* Macro to check prerequisites */
> +#define CHECK_PREREQ(var, prereq) \
> +    	do { \
> +		if ((var) & prereq && !check_prereq_##prereq()) { \
> +			test_skip("missing prerequisite " #prereq); \
> +			return 0; \
> +		} \
> +	} while (0)
> +
> +/* Return 1 if all prereqs are satisfied, 0 otherwise */
> +static int check_prereqs(unsigned int prereqs) {
> +    	CHECK_PREREQ(prereqs, TIME_IS_64BIT);
> +    	CHECK_PREREQ(prereqs, TIME_T_IS_64BIT);
> +
> +    	return 1;
> +}
> +
> +static void set_TZ_env(const char *zone) {
> +	setenv("TZ", zone, 1);
> +	tzset();
> +}
> +
> +static void check_relative_dates(int time_val, const char *expected_date) {
> +	struct strbuf buf = STRBUF_INIT;
> +	timestamp_t diff = GIT_TEST_DATE_NOW - time_val;
> +
> +	show_date_relative(diff, &buf);
> +	check_str(buf.buf, expected_date);
> +	strbuf_release(&buf);
> +}
> +
> +#define TEST_RELATIVE_DATE(value, expected_output) \
> +    	TEST(check_relative_dates(value, expected_output), \
> +        	"relative date (%s) works", #expected_output )
> +
> +static void check_show_date(const char *format, const char *TIME, const char *expected, unsigned int prereqs, const char *zone) {
> +	struct date_mode mode = DATE_MODE_INIT;
> +	char *arg;
> +	timestamp_t t;
> +	int tz;
> +
> +	if (!check_prereqs(prereqs))
> +		return;
> +	if (strcmp(zone, ""))
> +		set_TZ_env(zone);
> +
> +	parse_date_format(format, &mode);
> +	t = parse_timestamp(TIME, &arg, 10);
> +	tz = atoi(arg);
> +
> +	check_str(show_date(t, tz, &mode), expected);
> +
> +	if (strcmp(zone, ""))
> +		set_TZ_env("UTC");
> +	date_mode_release(&mode);
> +}
> +
> +#define TEST_SHOW_DATE(format, time, expected, prereqs, zone) \
> +	TEST(check_show_date(format, time, expected, prereqs, zone), \
> +	     "show date (%s) works", #format)
> +
> +static void check_parse_date(const char *given, const char *expected, const char *zone) {
> +	struct strbuf result = STRBUF_INIT;
> +	timestamp_t t;
> +	int tz;
> +
> +	if (strcmp(zone, ""))
> +		set_TZ_env(zone);
> +
> +	parse_date(given, &result);
> +	if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) == 2)
> +		check_str(show_date(t, tz, DATE_MODE(ISO8601)), expected);
> +	else
> +		check_str("bad", expected);
> +
> +	if (strcmp(zone, ""))
> +		set_TZ_env("UTC");
> +	strbuf_release(&result);
> +}
> +
> +#define TEST_PARSE_DATE(given, expected_output, zone) \
> +    	TEST(check_parse_date(given, expected_output, zone), \
> +        	"parse date (%s) works", #expected_output)
> +
> +static void check_approxidate(const char *given, const char *expected) {
> +	timestamp_t t = approxidate(given);
> +	char *expected_with_offset = xstrfmt("%s +0000", expected);
> +
> +	check_str(show_date(t, 0, DATE_MODE(ISO8601)), expected_with_offset);
> +	free(expected_with_offset);
> +}
> +
> +#define TEST_APPROXIDATE(given, expected_output) \
> +    	TEST(check_approxidate(given, expected_output), \
> +        	"parse approxidate (%s) works", #given)
> +
> +static void check_date_format_human(int given, const char *expected) {
> +	timestamp_t diff = GIT_TEST_DATE_NOW - given;
> +	check_str(show_date(diff, 0, DATE_MODE(HUMAN)), expected);
> +}
> +
> +#define TEST_DATE_FORMAT_HUMAN(given, expected_output) \
> +    	TEST(check_date_format_human(given, expected_output), \
> +        	"human date (%s) works", #given)
> +
> +int cmd_main(int argc, const char **argv) {
> +	set_TZ_env("UTC");
> +	setenv("GIT_TEST_DATE_NOW", "1251660000", 1);
> +	setenv("LANG", "C", 1);
> +
> +	TEST_RELATIVE_DATE(5, "5 seconds ago");
> +	TEST_RELATIVE_DATE(300, "5 minutes ago");
> +	TEST_RELATIVE_DATE(18000, "5 hours ago");
> +	TEST_RELATIVE_DATE(432000, "5 days ago");
> +	TEST_RELATIVE_DATE(1728000, "3 weeks ago");
> +	TEST_RELATIVE_DATE(13000000, "5 months ago");
> +	TEST_RELATIVE_DATE(37500000, "1 year, 2 months ago");
> +	TEST_RELATIVE_DATE(55188000, "1 year, 9 months ago");
> +	TEST_RELATIVE_DATE(630000000, "20 years ago");
> +	TEST_RELATIVE_DATE(31449600, "12 months ago");
> +	TEST_RELATIVE_DATE(62985600, "2 years ago");
> +
> +	TEST_SHOW_DATE("iso8601", test_time, "2016-06-15 16:13:20 +0200", 0, "");
> +	TEST_SHOW_DATE("iso8601-strict", test_time, "2016-06-15T16:13:20+02:00", 0, "");
> +	TEST_SHOW_DATE("rfc2822", test_time, "Wed, 15 Jun 2016 16:13:20 +0200", 0, "");
> +	TEST_SHOW_DATE("short", test_time, "2016-06-15", 0, "");
> +	TEST_SHOW_DATE("default", test_time, "Wed Jun 15 16:13:20 2016 +0200", 0, "");
> +	TEST_SHOW_DATE("raw", test_time, test_time, 0, "");
> +	TEST_SHOW_DATE("unix", test_time, "1466000000", 0, "");
> +	TEST_SHOW_DATE("iso-local", test_time, "2016-06-15 14:13:20 +0000", 0, "");
> +	TEST_SHOW_DATE("raw-local", test_time, "1466000000 +0000", 0, "");
> +	TEST_SHOW_DATE("unix-local", test_time, "1466000000", 0, "");
> +
> +	TEST_SHOW_DATE("format:%z", test_time, "+0200", 0, "");
> +	TEST_SHOW_DATE("format-local:%z", test_time, "+0000", 0, "");
> +	TEST_SHOW_DATE("format:%Z", test_time, "", 0, "");
> +	TEST_SHOW_DATE("format-local:%Z", test_time, "UTC", 0, "");
> +	TEST_SHOW_DATE("format:%%z", test_time, "%z", 0, "");
> +	TEST_SHOW_DATE("format-local:%%z", test_time, "%z", 0, "");
> +
> +	TEST_SHOW_DATE("format:%Y-%m-%d %H:%M:%S", test_time, "2016-06-15 16:13:20", 0, "");
> +
> +	TEST_SHOW_DATE("format-local:%Y-%m-%d %H:%M:%S", test_time, "2016-06-15 09:13:20", 0, "EST5");
> +
> +	TEST_SHOW_DATE("format:%s", "123456789 +1234", "123456789", 0, "");
> +	TEST_SHOW_DATE("format:%s", "123456789 -1234", "123456789", 0, "");
> +	TEST_SHOW_DATE("format-local:%s", "123456789 -1234", "123456789", 0, "");
> +
> +	/* Arbitrary time absurdly far in the future */
> +	TEST_SHOW_DATE("iso", "5758122296 -0400", "2152-06-19 18:24:56 -0400", TIME_IS_64BIT | TIME_T_IS_64BIT, "");
> +	TEST_SHOW_DATE("iso-local", "5758122296 -0400", "2152-06-19 22:24:56 +0000", TIME_IS_64BIT | TIME_T_IS_64BIT, "");
> +
> +	TEST_PARSE_DATE("2000", "bad", "");
> +	TEST_PARSE_DATE("2008-02", "bad", "");
> +	TEST_PARSE_DATE("2008-02-14", "bad", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45", "2008-02-14 20:30:45 +0000", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45 -0500", "2008-02-14 20:30:45 -0500", "");
> +	TEST_PARSE_DATE("2008.02.14 20:30:45 -0500", "2008-02-14 20:30:45 -0500", "");
> +	TEST_PARSE_DATE("20080214T20:30:45", "2008-02-14 20:30:45 +0000", "");
> +	TEST_PARSE_DATE("20080214T20:30", "2008-02-14 20:30:00 +0000", "");
> +	TEST_PARSE_DATE("20080214T20", "2008-02-14 20:00:00 +0000", "");
> +	TEST_PARSE_DATE("20080214T203045", "2008-02-14 20:30:45 +0000", "");
> +	TEST_PARSE_DATE("20080214T2030", "2008-02-14 20:30:00 +0000", "");
> +	TEST_PARSE_DATE("20080214T000000.20", "2008-02-14 00:00:00 +0000", "");
> +	TEST_PARSE_DATE("20080214T00:00:00.20", "2008-02-14 00:00:00 +0000", "");
> +	TEST_PARSE_DATE("20080214T203045-04:00", "2008-02-14 20:30:45 -0400", "");
> +
> +	TEST_PARSE_DATE("20080214T203045 -04:00", "2008-02-14 20:30:45 -0400", "");
> +	TEST_PARSE_DATE("20080214T203045.019-04:00", "2008-02-14 20:30:45 -0400", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45.019-04:00", "2008-02-14 20:30:45 -0400", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45 -0015", "2008-02-14 20:30:45 -0015", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45 -5", "2008-02-14 20:30:45 +0000", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45 -5:", "2008-02-14 20:30:45 +0000", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45 -05", "2008-02-14 20:30:45 -0500", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45 -:30", "2008-02-14 20:30:45 +0000", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45 -05:00", "2008-02-14 20:30:45 -0500", "");
> +	TEST_PARSE_DATE("2008-02-14 20:30:45", "2008-02-14 20:30:45 -0500", "EST5");
> +
> +	TEST_PARSE_DATE("Thu, 7 Apr 2005 15:14:13 -0700", "2005-04-07 15:14:13 -0700", "");
> +
> +	TEST_APPROXIDATE("now", "2009-08-30 19:20:00");
> +	TEST_APPROXIDATE("5 seconds ago", "2009-08-30 19:19:55");
> +	TEST_APPROXIDATE("10 minutes ago", "2009-08-30 19:10:00");
> +	TEST_APPROXIDATE("yesterday", "2009-08-29 19:20:00");
> +	TEST_APPROXIDATE("3 days ago", "2009-08-27 19:20:00");
> +	TEST_APPROXIDATE("12:34:56.3 days ago", "2009-08-27 12:34:56");
> +	TEST_APPROXIDATE("3 weeks ago", "2009-08-09 19:20:00");
> +	TEST_APPROXIDATE("3 months ago", "2009-05-30 19:20:00");
> +	TEST_APPROXIDATE("2 years 3 months ago", "2007-05-30 19:20:00");
> +
> +	TEST_APPROXIDATE("6am yesterday", "2009-08-29 06:00:00");
> +	TEST_APPROXIDATE("6pm yesterday", "2009-08-29 18:00:00");
> +	TEST_APPROXIDATE("3:00", "2009-08-30 03:00:00");
> +	TEST_APPROXIDATE("15:00", "2009-08-30 15:00:00");
> +	TEST_APPROXIDATE("noon today", "2009-08-30 12:00:00");
> +	TEST_APPROXIDATE("noon yesterday", "2009-08-29 12:00:00");
> +	TEST_APPROXIDATE("January 5th noon pm", "2009-01-05 12:00:00");
> +	TEST_APPROXIDATE("10am noon", "2009-08-29 12:00:00");
> +
> +	TEST_APPROXIDATE("last tuesday", "2009-08-25 19:20:00");
> +	TEST_APPROXIDATE("July 5th", "2009-07-05 19:20:00");
> +	TEST_APPROXIDATE("06/05/2009", "2009-06-05 19:20:00");
> +	TEST_APPROXIDATE("06.05.2009", "2009-05-06 19:20:00");
> +
> +	TEST_APPROXIDATE("Jun 6, 5AM", "2009-06-06 05:00:00");
> +	TEST_APPROXIDATE("5AM Jun 6", "2009-06-06 05:00:00");
> +	TEST_APPROXIDATE("6AM, June 7, 2009", "2009-06-07 06:00:00");
> +
> +	TEST_APPROXIDATE("2008-12-01", "2008-12-01 19:20:00");
> +	TEST_APPROXIDATE("2009-12-01", "2009-12-01 19:20:00");
> +
> +	TEST_DATE_FORMAT_HUMAN(18000, "5 hours ago");
> +	TEST_DATE_FORMAT_HUMAN(432000, "Tue Aug 25 19:20");
> +	TEST_DATE_FORMAT_HUMAN(1728000, "Mon Aug 10 19:20");
> +	TEST_DATE_FORMAT_HUMAN(13000000, "Thu Apr 2 08:13");
> +	TEST_DATE_FORMAT_HUMAN(31449600, "Aug 31 2008");
> +	TEST_DATE_FORMAT_HUMAN(37500000, "Jun 22 2008");
> +	TEST_DATE_FORMAT_HUMAN(55188000, "Dec 1 2007");
> +	TEST_DATE_FORMAT_HUMAN(630000000, "Sep 13 1989");
> +
> +	return test_done();
> +}
> --
> 2.43.0.windows.1
> 
> 
