Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF13A1C3
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150353; cv=none; b=bReQRQ+9Y1SCWZxNGb/sNjeMzZABNM+XyuDV4Ygqb9Brt7xoSY6o2IDv92SfHIRE5gzxuIDzqH9owErPiy8tQEa5eTDsD81gJ+HorAjX8xxoge4ZpNiVL5HCiiC2DauGmG31ir4Nhxz/Kzty874WRXzJ6GBx3VRvC1O3ovaZnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150353; c=relaxed/simple;
	bh=qKvOnQc2ydgd8dUFT7ba/g3543TCDjcR/uQuRBEPN3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LvhxqB77pm3DXoxGrnXa1S8ORT6HdQIWveeDqjT/q+Diiiw5/69X+hHXaK6XmQFPwtEZulT66zAhQu3He+GemCYbFv/4itFKT/kkrHquVGsxfsmJNkeOMn19hJlfgtqYhgjL0y8JYz10HnbJhUb7hReRP7Gtb4cKmNPslIZOuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDI8auYK; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDI8auYK"
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so57366901fa.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707150349; x=1707755149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBrLzi/bgfqam09ByhTUZfz8fWb76b8QGtnKC24Ard8=;
        b=BDI8auYKU8N1wtgnj9w8YjLO6wFeIocZTXOrxV8Ee7oRFUrZe11tr2ASj1P62G+14u
         a0BUpTlb4T8wx67wq/8g8yWf+ztl8zpFITN5A5+dFp4Dajj2nkbB+k5zfFje9yjZFnS1
         aKtzTUW8O4+MM1hk15qZSwUfZtpdpa3XfVGamA+MlThOm5eTSaaAvYxmdSswdMsDbFs6
         9oRfEXH8Tq4Wsu1iU7q4U+zqfNbJRSj8yVOLFHcrmM3aArBb8NUFKs7XSx6RqSrXJLXA
         76NkL0/0l3lSWr18ADrFvt5vN8d5ipM/HNLTyioc90UrNNFArgoWHq/8korbmb9zDY2J
         6CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707150349; x=1707755149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBrLzi/bgfqam09ByhTUZfz8fWb76b8QGtnKC24Ard8=;
        b=Q7PsBioMejRt2bnnKDPbfoNDjFVXgI3wgt5A3+tzgC95vMU8g2pXFKh1leljAGWq+O
         DlY24jM2z0yyGBJxjRkjRzp14AZlvhuWLzIuEFL2Q1eLA0GNuOhyNOQonErVDHA16+Jt
         PXvS6CVuKlomG+ax29EjzlrPYtT30M098uNvfPWO43/T7SufwOcjCgNfgEqiYzCpaLOm
         9BzHl0vtpyO/Ycr5y/1dyZ7ZGKh/erSm64ovIjBx28xFrJoEy/vUyEp7zOgNV0eF+LpU
         9b6xtMitaNVs4eqNTZruVO57PI4b7ceuYW504SyP6ZNrVu5uAnch/mpahB8N5M8S2eFD
         mtPg==
X-Gm-Message-State: AOJu0YzXxCoyS2T2r0/xQWqVzwxOiWh3Zuj9ABhaRJI7j2VihjVaJkPj
	NhYlcKo2pOmLCNnGmaPF7zB7eVJDxsFE2OhqMwwUYsaIyLk9dGfs7jf2e1gUNqg=
X-Google-Smtp-Source: AGHT+IE5mL4lDkW5D6Djqn7x6yzyVkfcE1SZ36X4+nLXiOsWQWMP3W8NpCMnWaixR39lPhcF6bd1Aw==
X-Received: by 2002:a19:6513:0:b0:511:4bf9:59a9 with SMTP id z19-20020a196513000000b005114bf959a9mr78962lfb.40.1707150348309;
        Mon, 05 Feb 2024 08:25:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/019UN7qn7caifIObHnx0GSldQ7FyvR83H12Fu3dpW3dWLG62XYe5w1rcyp/f1+DzA3ghz9WDaj9OkWY3cN22qzQMH9yu29OlaUQRQNXqBiDFyvn3RfMWFlFbdg==
Received: from localhost.localdomain ([129.0.78.143])
        by smtp.gmail.com with ESMTPSA id k15-20020a05600c1c8f00b0040eea5dc778sm2326904wms.1.2024.02.05.08.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 08:25:47 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	Achu Luma <ach.lumap@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [Outreachy][PATCH 2/2] Port helper/test-date.c to unit-tests/t-date.c
Date: Mon,  5 Feb 2024 17:25:06 +0100
Message-ID: <20240205162506.1835-2-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240205162506.1835-1-ach.lumap@gmail.com>
References: <20240205162506.1835-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the recent codebase update (8bf6fbd (Merge branch
'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
merged, providing a standardized approach for testing C code. Prior to
this update, some unit tests relied on the test helper mechanism,
lacking a dedicated unit testing framework. It's more natural to perform
these unit tests using the new unit test framework.

This commit migrates the unit tests for C date functions
(show_date_relative(), show_date(), etc) from the legacy approach
using the test-tool command `test-tool date` in t/helper/test-date.c
to the new unit testing framework (t/unit-tests/test-lib.h).

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 I am currently facing challenges in handling the time zone (TZ)
 variable, in t-date.c. The tests, which were initially passing
 in the t0006-date.sh  on Windows, fail after porting to the new
 framework. I have tried to set the timezone using the setenv,
 but unfortunately, the issue persists. I suspect that the problem
 might be related to how Windows C compilers process the setenv
 function compared to POSIX environments. Please If anyone has
 insights into managing environment variables in a cross-platform
 manner or has encountered similar issues, your help would be
 highly appreciated.

 t/helper/test-date.c  |  91 +---------------
 t/t0006-date.sh       | 169 ------------------------------
 t/unit-tests/t-date.c | 237 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+), 259 deletions(-)
 delete mode 100755 t/t0006-date.sh
 create mode 100644 t/unit-tests/t-date.c

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index be0b8679c3..b9cb2c5455 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -3,89 +3,11 @@
 #include "trace.h"

 static const char *usage_msg = "\n"
-"  test-tool date relative [time_t]...\n"
-"  test-tool date human [time_t]...\n"
-"  test-tool date show:<format> [time_t]...\n"
-"  test-tool date parse [date]...\n"
-"  test-tool date approxidate [date]...\n"
 "  test-tool date timestamp [date]...\n"
 "  test-tool date getnanos [start-nanos]\n"
 "  test-tool date is64bit\n"
 "  test-tool date time_t-is64bit\n";

-static void show_relative_dates(const char **argv)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	for (; *argv; argv++) {
-		time_t t = atoi(*argv);
-		show_date_relative(t, &buf);
-		printf("%s -> %s\n", *argv, buf.buf);
-	}
-	strbuf_release(&buf);
-}
-
-static void show_human_dates(const char **argv)
-{
-	for (; *argv; argv++) {
-		time_t t = atoi(*argv);
-		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(HUMAN)));
-	}
-}
-
-static void show_dates(const char **argv, const char *format)
-{
-	struct date_mode mode = DATE_MODE_INIT;
-
-	parse_date_format(format, &mode);
-	for (; *argv; argv++) {
-		char *arg;
-		timestamp_t t;
-		int tz;
-
-		/*
-		 * Do not use our normal timestamp parsing here, as the point
-		 * is to test the formatting code in isolation.
-		 */
-		t = parse_timestamp(*argv, &arg, 10);
-		while (*arg == ' ')
-			arg++;
-		tz = atoi(arg);
-
-		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
-	}
-
-	date_mode_release(&mode);
-}
-
-static void parse_dates(const char **argv)
-{
-	struct strbuf result = STRBUF_INIT;
-
-	for (; *argv; argv++) {
-		timestamp_t t;
-		int tz;
-
-		strbuf_reset(&result);
-		parse_date(*argv, &result);
-		if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) == 2)
-			printf("%s -> %s\n",
-			       *argv, show_date(t, tz, DATE_MODE(ISO8601)));
-		else
-			printf("%s -> bad\n", *argv);
-	}
-	strbuf_release(&result);
-}
-
-static void parse_approxidate(const char **argv)
-{
-	for (; *argv; argv++) {
-		timestamp_t t;
-		t = approxidate(*argv);
-		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
-	}
-}
-
 static void parse_approx_timestamp(const char **argv)
 {
 	for (; *argv; argv++) {
@@ -106,22 +28,11 @@ static void getnanos(const char **argv)

 int cmd__date(int argc UNUSED, const char **argv)
 {
-	const char *x;

 	argv++;
 	if (!*argv)
 		usage(usage_msg);
-	if (!strcmp(*argv, "relative"))
-		show_relative_dates(argv+1);
-	else if (!strcmp(*argv, "human"))
-		show_human_dates(argv+1);
-	else if (skip_prefix(*argv, "show:", &x))
-		show_dates(argv+1, x);
-	else if (!strcmp(*argv, "parse"))
-		parse_dates(argv+1);
-	else if (!strcmp(*argv, "approxidate"))
-		parse_approxidate(argv+1);
-	else if (!strcmp(*argv, "timestamp"))
+	if (!strcmp(*argv, "timestamp"))
 		parse_approx_timestamp(argv+1);
 	else if (!strcmp(*argv, "getnanos"))
 		getnanos(argv+1);
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
deleted file mode 100755
index e18b160286..0000000000
--- a/t/t0006-date.sh
+++ /dev/null
@@ -1,169 +0,0 @@
-#!/bin/sh
-
-test_description='test date parsing and printing'
-
-TEST_PASSES_SANITIZE_LEAK=true
-. ./test-lib.sh
-
-# arbitrary reference time: 2009-08-30 19:20:00
-GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
-
-check_relative() {
-	t=$(($GIT_TEST_DATE_NOW - $1))
-	echo "$t -> $2" >expect
-	test_expect_${3:-success} "relative date ($2)" "
-	test-tool date relative $t >actual &&
-	test_cmp expect actual
-	"
-}
-
-check_relative 5 '5 seconds ago'
-check_relative 300 '5 minutes ago'
-check_relative 18000 '5 hours ago'
-check_relative 432000 '5 days ago'
-check_relative 1728000 '3 weeks ago'
-check_relative 13000000 '5 months ago'
-check_relative 37500000 '1 year, 2 months ago'
-check_relative 55188000 '1 year, 9 months ago'
-check_relative 630000000 '20 years ago'
-check_relative 31449600 '12 months ago'
-check_relative 62985600 '2 years ago'
-
-check_show () {
-	format=$1
-	time=$2
-	expect=$3
-	prereqs=$4
-	zone=$5
-	test_expect_success $prereqs "show date ($format:$time)" '
-		echo "$time -> $expect" >expect &&
-		TZ=${zone:-$TZ} test-tool date show:"$format" "$time" >actual &&
-		test_cmp expect actual
-	'
-}
-
-# arbitrary but sensible time for examples
-TIME='1466000000 +0200'
-check_show iso8601 "$TIME" '2016-06-15 16:13:20 +0200'
-check_show iso8601-strict "$TIME" '2016-06-15T16:13:20+02:00'
-check_show rfc2822 "$TIME" 'Wed, 15 Jun 2016 16:13:20 +0200'
-check_show short "$TIME" '2016-06-15'
-check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
-check_show raw "$TIME" '1466000000 +0200'
-check_show unix "$TIME" '1466000000'
-check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
-check_show raw-local "$TIME" '1466000000 +0000'
-check_show unix-local "$TIME" '1466000000'
-
-check_show 'format:%z' "$TIME" '+0200'
-check_show 'format-local:%z' "$TIME" '+0000'
-check_show 'format:%Z' "$TIME" ''
-check_show 'format-local:%Z' "$TIME" 'UTC'
-check_show 'format:%%z' "$TIME" '%z'
-check_show 'format-local:%%z' "$TIME" '%z'
-
-check_show 'format:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 16:13:20'
-check_show 'format-local:%Y-%m-%d %H:%M:%S' "$TIME" '2016-06-15 09:13:20' '' EST5
-
-check_show 'format:%s' '123456789 +1234' 123456789
-check_show 'format:%s' '123456789 -1234' 123456789
-check_show 'format-local:%s' '123456789 -1234' 123456789
-
-# arbitrary time absurdly far in the future
-FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_IS_64BIT
-
-check_parse() {
-	echo "$1 -> $2" >expect
-	test_expect_${4:-success} "parse date ($1${3:+ TZ=$3})" "
-	TZ=${3:-$TZ} test-tool date parse '$1' >actual &&
-	test_cmp expect actual
-	"
-}
-
-check_parse 2008 bad
-check_parse 2008-02 bad
-check_parse 2008-02-14 bad
-check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
-check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
-check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
-check_parse '20080214T20:30:45' '2008-02-14 20:30:45 +0000'
-check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000'
-check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
-check_parse '20080214T203045' '2008-02-14 20:30:45 +0000'
-check_parse '20080214T2030' '2008-02-14 20:30:00 +0000'
-check_parse '20080214T000000.20' '2008-02-14 00:00:00 +0000'
-check_parse '20080214T00:00:00.20' '2008-02-14 00:00:00 +0000'
-check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
-check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
-check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
-check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
-check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
-check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
-check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
-check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
-check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
-check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
-check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
-check_parse 'Thu, 7 Apr 2005 15:14:13 -0700' '2005-04-07 15:14:13 -0700'
-
-check_approxidate() {
-	echo "$1 -> $2 +0000" >expect
-	test_expect_${3:-success} "parse approxidate ($1)" "
-	test-tool date approxidate '$1' >actual &&
-	test_cmp expect actual
-	"
-}
-
-check_approxidate now '2009-08-30 19:20:00'
-check_approxidate '5 seconds ago' '2009-08-30 19:19:55'
-check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
-check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
-check_approxidate yesterday '2009-08-29 19:20:00'
-check_approxidate 3.days.ago '2009-08-27 19:20:00'
-check_approxidate '12:34:56.3.days.ago' '2009-08-27 12:34:56'
-check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
-check_approxidate 3.months.ago '2009-05-30 19:20:00'
-check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
-
-check_approxidate '6am yesterday' '2009-08-29 06:00:00'
-check_approxidate '6pm yesterday' '2009-08-29 18:00:00'
-check_approxidate '3:00' '2009-08-30 03:00:00'
-check_approxidate '15:00' '2009-08-30 15:00:00'
-check_approxidate 'noon today' '2009-08-30 12:00:00'
-check_approxidate 'noon yesterday' '2009-08-29 12:00:00'
-check_approxidate 'January 5th noon pm' '2009-01-05 12:00:00'
-check_approxidate '10am noon' '2009-08-29 12:00:00'
-
-check_approxidate 'last tuesday' '2009-08-25 19:20:00'
-check_approxidate 'July 5th' '2009-07-05 19:20:00'
-check_approxidate '06/05/2009' '2009-06-05 19:20:00'
-check_approxidate '06.05.2009' '2009-05-06 19:20:00'
-
-check_approxidate 'Jun 6, 5AM' '2009-06-06 05:00:00'
-check_approxidate '5AM Jun 6' '2009-06-06 05:00:00'
-check_approxidate '6AM, June 7, 2009' '2009-06-07 06:00:00'
-
-check_approxidate '2008-12-01' '2008-12-01 19:20:00'
-check_approxidate '2009-12-01' '2009-12-01 19:20:00'
-
-check_date_format_human() {
-	t=$(($GIT_TEST_DATE_NOW - $1))
-	echo "$t -> $2" >expect
-	test_expect_success "human date $t" '
-		test-tool date human $t >actual &&
-		test_cmp expect actual
-'
-}
-
-check_date_format_human 18000 "5 hours ago" # 5 hours ago
-check_date_format_human 432000 "Tue Aug 25 19:20" # 5 days ago
-check_date_format_human 1728000 "Mon Aug 10 19:20" # 3 weeks ago
-check_date_format_human 13000000 "Thu Apr 2 08:13" # 5 months ago
-check_date_format_human 31449600 "Aug 31 2008" # 12 months ago
-check_date_format_human 37500000 "Jun 22 2008" # 1 year, 2 months ago
-check_date_format_human 55188000 "Dec 1 2007" # 1 year, 9 months ago
-check_date_format_human 630000000 "Sep 13 1989" # 20 years ago
-
-test_done
diff --git a/t/unit-tests/t-date.c b/t/unit-tests/t-date.c
new file mode 100644
index 0000000000..dd5dbbb2e0
--- /dev/null
+++ b/t/unit-tests/t-date.c
@@ -0,0 +1,237 @@
+#include "test-lib.h"
+#include "date.h"
+#include "strbuf.h"
+
+/* Reference time: 2009-08-30 19:20:00. */
+#define GIT_TEST_DATE_NOW 1251660000
+
+/* The time corresponds to Wed, 15 Jun 2016 16:13:20 +0200. */
+static const char test_time[] = "1466000000 +0200";
+
+enum prerequisites {
+    	TIME_IS_64BIT = 1 << 0,
+    	TIME_T_IS_64BIT = 1 << 1,
+};
+
+/* Macro to check prerequisites */
+#define CHECK_PREREQ(var, prereq) \
+    	do { \
+		if ((var) & prereq && !check_prereq_##prereq()) { \
+			test_skip("missing prerequisite " #prereq); \
+			return 0; \
+		} \
+	} while (0)
+
+/* Return 1 if all prereqs are satisfied, 0 otherwise */
+static int check_prereqs(unsigned int prereqs) {
+    	CHECK_PREREQ(prereqs, TIME_IS_64BIT);
+    	CHECK_PREREQ(prereqs, TIME_T_IS_64BIT);
+
+    	return 1;
+}
+
+static void set_TZ_env(const char *zone) {
+	setenv("TZ", zone, 1);
+	tzset();
+}
+
+static void check_relative_dates(int time_val, const char *expected_date) {
+	struct strbuf buf = STRBUF_INIT;
+	timestamp_t diff = GIT_TEST_DATE_NOW - time_val;
+
+	show_date_relative(diff, &buf);
+	check_str(buf.buf, expected_date);
+	strbuf_release(&buf);
+}
+
+#define TEST_RELATIVE_DATE(value, expected_output) \
+    	TEST(check_relative_dates(value, expected_output), \
+        	"relative date (%s) works", #expected_output )
+
+static void check_show_date(const char *format, const char *TIME, const char *expected, unsigned int prereqs, const char *zone) {
+	struct date_mode mode = DATE_MODE_INIT;
+	char *arg;
+	timestamp_t t;
+	int tz;
+
+	if (!check_prereqs(prereqs))
+		return;
+	if (strcmp(zone, ""))
+		set_TZ_env(zone);
+
+	parse_date_format(format, &mode);
+	t = parse_timestamp(TIME, &arg, 10);
+	tz = atoi(arg);
+
+	check_str(show_date(t, tz, &mode), expected);
+
+	if (strcmp(zone, ""))
+		set_TZ_env("UTC");
+	date_mode_release(&mode);
+}
+
+#define TEST_SHOW_DATE(format, time, expected, prereqs, zone) \
+	TEST(check_show_date(format, time, expected, prereqs, zone), \
+	     "show date (%s) works", #format)
+
+static void check_parse_date(const char *given, const char *expected, const char *zone) {
+	struct strbuf result = STRBUF_INIT;
+	timestamp_t t;
+	int tz;
+
+	if (strcmp(zone, ""))
+		set_TZ_env(zone);
+
+	parse_date(given, &result);
+	if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) == 2)
+		check_str(show_date(t, tz, DATE_MODE(ISO8601)), expected);
+	else
+		check_str("bad", expected);
+
+	if (strcmp(zone, ""))
+		set_TZ_env("UTC");
+	strbuf_release(&result);
+}
+
+#define TEST_PARSE_DATE(given, expected_output, zone) \
+    	TEST(check_parse_date(given, expected_output, zone), \
+        	"parse date (%s) works", #expected_output)
+
+static void check_approxidate(const char *given, const char *expected) {
+	timestamp_t t = approxidate(given);
+	char *expected_with_offset = xstrfmt("%s +0000", expected);
+
+	check_str(show_date(t, 0, DATE_MODE(ISO8601)), expected_with_offset);
+	free(expected_with_offset);
+}
+
+#define TEST_APPROXIDATE(given, expected_output) \
+    	TEST(check_approxidate(given, expected_output), \
+        	"parse approxidate (%s) works", #given)
+
+static void check_date_format_human(int given, const char *expected) {
+	timestamp_t diff = GIT_TEST_DATE_NOW - given;
+	check_str(show_date(diff, 0, DATE_MODE(HUMAN)), expected);
+}
+
+#define TEST_DATE_FORMAT_HUMAN(given, expected_output) \
+    	TEST(check_date_format_human(given, expected_output), \
+        	"human date (%s) works", #given)
+
+int cmd_main(int argc, const char **argv) {
+	set_TZ_env("UTC");
+	setenv("GIT_TEST_DATE_NOW", "1251660000", 1);
+	setenv("LANG", "C", 1);
+
+	TEST_RELATIVE_DATE(5, "5 seconds ago");
+	TEST_RELATIVE_DATE(300, "5 minutes ago");
+	TEST_RELATIVE_DATE(18000, "5 hours ago");
+	TEST_RELATIVE_DATE(432000, "5 days ago");
+	TEST_RELATIVE_DATE(1728000, "3 weeks ago");
+	TEST_RELATIVE_DATE(13000000, "5 months ago");
+	TEST_RELATIVE_DATE(37500000, "1 year, 2 months ago");
+	TEST_RELATIVE_DATE(55188000, "1 year, 9 months ago");
+	TEST_RELATIVE_DATE(630000000, "20 years ago");
+	TEST_RELATIVE_DATE(31449600, "12 months ago");
+	TEST_RELATIVE_DATE(62985600, "2 years ago");
+
+	TEST_SHOW_DATE("iso8601", test_time, "2016-06-15 16:13:20 +0200", 0, "");
+	TEST_SHOW_DATE("iso8601-strict", test_time, "2016-06-15T16:13:20+02:00", 0, "");
+	TEST_SHOW_DATE("rfc2822", test_time, "Wed, 15 Jun 2016 16:13:20 +0200", 0, "");
+	TEST_SHOW_DATE("short", test_time, "2016-06-15", 0, "");
+	TEST_SHOW_DATE("default", test_time, "Wed Jun 15 16:13:20 2016 +0200", 0, "");
+	TEST_SHOW_DATE("raw", test_time, test_time, 0, "");
+	TEST_SHOW_DATE("unix", test_time, "1466000000", 0, "");
+	TEST_SHOW_DATE("iso-local", test_time, "2016-06-15 14:13:20 +0000", 0, "");
+	TEST_SHOW_DATE("raw-local", test_time, "1466000000 +0000", 0, "");
+	TEST_SHOW_DATE("unix-local", test_time, "1466000000", 0, "");
+
+	TEST_SHOW_DATE("format:%z", test_time, "+0200", 0, "");
+	TEST_SHOW_DATE("format-local:%z", test_time, "+0000", 0, "");
+	TEST_SHOW_DATE("format:%Z", test_time, "", 0, "");
+	TEST_SHOW_DATE("format-local:%Z", test_time, "UTC", 0, "");
+	TEST_SHOW_DATE("format:%%z", test_time, "%z", 0, "");
+	TEST_SHOW_DATE("format-local:%%z", test_time, "%z", 0, "");
+
+	TEST_SHOW_DATE("format:%Y-%m-%d %H:%M:%S", test_time, "2016-06-15 16:13:20", 0, "");
+
+	TEST_SHOW_DATE("format-local:%Y-%m-%d %H:%M:%S", test_time, "2016-06-15 09:13:20", 0, "EST5");
+
+	TEST_SHOW_DATE("format:%s", "123456789 +1234", "123456789", 0, "");
+	TEST_SHOW_DATE("format:%s", "123456789 -1234", "123456789", 0, "");
+	TEST_SHOW_DATE("format-local:%s", "123456789 -1234", "123456789", 0, "");
+
+	/* Arbitrary time absurdly far in the future */
+	TEST_SHOW_DATE("iso", "5758122296 -0400", "2152-06-19 18:24:56 -0400", TIME_IS_64BIT | TIME_T_IS_64BIT, "");
+	TEST_SHOW_DATE("iso-local", "5758122296 -0400", "2152-06-19 22:24:56 +0000", TIME_IS_64BIT | TIME_T_IS_64BIT, "");
+
+	TEST_PARSE_DATE("2000", "bad", "");
+	TEST_PARSE_DATE("2008-02", "bad", "");
+	TEST_PARSE_DATE("2008-02-14", "bad", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45", "2008-02-14 20:30:45 +0000", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45 -0500", "2008-02-14 20:30:45 -0500", "");
+	TEST_PARSE_DATE("2008.02.14 20:30:45 -0500", "2008-02-14 20:30:45 -0500", "");
+	TEST_PARSE_DATE("20080214T20:30:45", "2008-02-14 20:30:45 +0000", "");
+	TEST_PARSE_DATE("20080214T20:30", "2008-02-14 20:30:00 +0000", "");
+	TEST_PARSE_DATE("20080214T20", "2008-02-14 20:00:00 +0000", "");
+	TEST_PARSE_DATE("20080214T203045", "2008-02-14 20:30:45 +0000", "");
+	TEST_PARSE_DATE("20080214T2030", "2008-02-14 20:30:00 +0000", "");
+	TEST_PARSE_DATE("20080214T000000.20", "2008-02-14 00:00:00 +0000", "");
+	TEST_PARSE_DATE("20080214T00:00:00.20", "2008-02-14 00:00:00 +0000", "");
+	TEST_PARSE_DATE("20080214T203045-04:00", "2008-02-14 20:30:45 -0400", "");
+
+	TEST_PARSE_DATE("20080214T203045 -04:00", "2008-02-14 20:30:45 -0400", "");
+	TEST_PARSE_DATE("20080214T203045.019-04:00", "2008-02-14 20:30:45 -0400", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45.019-04:00", "2008-02-14 20:30:45 -0400", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45 -0015", "2008-02-14 20:30:45 -0015", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45 -5", "2008-02-14 20:30:45 +0000", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45 -5:", "2008-02-14 20:30:45 +0000", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45 -05", "2008-02-14 20:30:45 -0500", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45 -:30", "2008-02-14 20:30:45 +0000", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45 -05:00", "2008-02-14 20:30:45 -0500", "");
+	TEST_PARSE_DATE("2008-02-14 20:30:45", "2008-02-14 20:30:45 -0500", "EST5");
+
+	TEST_PARSE_DATE("Thu, 7 Apr 2005 15:14:13 -0700", "2005-04-07 15:14:13 -0700", "");
+
+	TEST_APPROXIDATE("now", "2009-08-30 19:20:00");
+	TEST_APPROXIDATE("5 seconds ago", "2009-08-30 19:19:55");
+	TEST_APPROXIDATE("10 minutes ago", "2009-08-30 19:10:00");
+	TEST_APPROXIDATE("yesterday", "2009-08-29 19:20:00");
+	TEST_APPROXIDATE("3 days ago", "2009-08-27 19:20:00");
+	TEST_APPROXIDATE("12:34:56.3 days ago", "2009-08-27 12:34:56");
+	TEST_APPROXIDATE("3 weeks ago", "2009-08-09 19:20:00");
+	TEST_APPROXIDATE("3 months ago", "2009-05-30 19:20:00");
+	TEST_APPROXIDATE("2 years 3 months ago", "2007-05-30 19:20:00");
+
+	TEST_APPROXIDATE("6am yesterday", "2009-08-29 06:00:00");
+	TEST_APPROXIDATE("6pm yesterday", "2009-08-29 18:00:00");
+	TEST_APPROXIDATE("3:00", "2009-08-30 03:00:00");
+	TEST_APPROXIDATE("15:00", "2009-08-30 15:00:00");
+	TEST_APPROXIDATE("noon today", "2009-08-30 12:00:00");
+	TEST_APPROXIDATE("noon yesterday", "2009-08-29 12:00:00");
+	TEST_APPROXIDATE("January 5th noon pm", "2009-01-05 12:00:00");
+	TEST_APPROXIDATE("10am noon", "2009-08-29 12:00:00");
+
+	TEST_APPROXIDATE("last tuesday", "2009-08-25 19:20:00");
+	TEST_APPROXIDATE("July 5th", "2009-07-05 19:20:00");
+	TEST_APPROXIDATE("06/05/2009", "2009-06-05 19:20:00");
+	TEST_APPROXIDATE("06.05.2009", "2009-05-06 19:20:00");
+
+	TEST_APPROXIDATE("Jun 6, 5AM", "2009-06-06 05:00:00");
+	TEST_APPROXIDATE("5AM Jun 6", "2009-06-06 05:00:00");
+	TEST_APPROXIDATE("6AM, June 7, 2009", "2009-06-07 06:00:00");
+
+	TEST_APPROXIDATE("2008-12-01", "2008-12-01 19:20:00");
+	TEST_APPROXIDATE("2009-12-01", "2009-12-01 19:20:00");
+
+	TEST_DATE_FORMAT_HUMAN(18000, "5 hours ago");
+	TEST_DATE_FORMAT_HUMAN(432000, "Tue Aug 25 19:20");
+	TEST_DATE_FORMAT_HUMAN(1728000, "Mon Aug 10 19:20");
+	TEST_DATE_FORMAT_HUMAN(13000000, "Thu Apr 2 08:13");
+	TEST_DATE_FORMAT_HUMAN(31449600, "Aug 31 2008");
+	TEST_DATE_FORMAT_HUMAN(37500000, "Jun 22 2008");
+	TEST_DATE_FORMAT_HUMAN(55188000, "Dec 1 2007");
+	TEST_DATE_FORMAT_HUMAN(630000000, "Sep 13 1989");
+
+	return test_done();
+}
--
2.43.0.windows.1

