Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E76EC77B61
	for <git@archiver.kernel.org>; Sat,  8 Apr 2023 09:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDHJfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjDHJfb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 05:35:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F6C148
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680946525; i=l.s.r@web.de;
        bh=H526Nc8rJ5/Pn4uV9bhEIyIyWvpk2ffwr9JJivk+F6Q=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=GE62NBo/ZbmbCBnVyOcrL+i73AH9Ve8Xm6mc9fJn18y5OVqNhB5dUdWpt33EPVHrR
         yjJZreoge8e3lToOBM3XyRTO7Vao8qJPjswuvjv5aF59Tjq2wlGxsRkJT6bp9maxTu
         bJG+LrFmMVnr8JK6tRmTVa6uxWWGhYeKLmKQnxhUAsxWwA4V6Un+TUJ9aaTDeO9B0w
         dLL/ghTr1eQrJPFP1aIA98v0dTAvezdJIkhAvOhcD4N7A0MrK0rGxLySbwEmxXlrsF
         fKi4W+OwE3KIZr3GIOmiHMHMpNyDSpX39Ce+rOJ31GIUvKQQqq2aY1e3D2uO11laHn
         5zurIxugo08xw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MqIB5-1q7RN80cwF-00mzX2; Sat, 08
 Apr 2023 11:35:25 +0200
Message-ID: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
Date:   Sat, 8 Apr 2023 11:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] date: remove approxidate_relative()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DpE/oZB3fPfTzF1T+VlREOp/kp9kdoGkGbmeLLUjy1j68cn9ntE
 ZBrjOtCRaXNCWv53atAMolP1zmTrbtY5cF2SUy0sYZjE9Iacv/+pY4BhfKXjFTHXwL5KCTt
 rY/uEJSROWdzc3N+2H97eC2lxsZLYcsSFV+O8nVJx554SQoLDnz32DrK1VQ9fF29ooDW/O9
 YWQ4wwIXJ9cHyXwjeLc+A==
UI-OutboundReport: notjunk:1;M01:P0:3LKNJH9G0a8=;wS2H9oz9eNRqoUXCDSaHBzim6Lx
 oIX0fqNq9p6M1+hiCpRUKn4PJ11/IZU5iFBuxHct5jIiS/1xU8+WTlnbJteiihw1oSwQ7f+NU
 GYsO4kuJajRFMEUZSpJBhWKt5DzrT81Pwc92qtd8jIgSFMUU/USLS/P/wPX1npj3RvYmg332C
 5WDMf2IS0q0/4yV6x+FypTd/6PGh15UJfH5f2pS0wGrboe6GsqfCsHLsZymHc/k7P/StzsgHE
 W0jKuF/Fh/7b4QnZci5CmWTnYNmLD1rmI/e1IOxW2dEhGkiZAkcldNUX+1TICPM9CfGzz1XsD
 ZdDJU4PV6ppulgPf4SLQsFdKh4f4dYbQhNiWQIgMVBCjefqkhgjQorgjZP3n1RSZOI9cE0N3y
 +DDccDcFoyLpBaiiCshJAehCqbBvnBXEWzu+g6VtoB8eVaoJMcxWPcdWu/fHhIihWPN10RbGL
 vTolGRud8vVmTUUFNloRknxm6sIkIsYj+VFzxIo8Wug0WhOZz96gvsrQNniQLR0TC3hBuJmyF
 tPpkVlU0IkyBSLhIPoDpBMPrL90eefBv3CGSPj5J/+b5fXir6eamtK2u8yiAV0lK3WVfo7bOF
 /WUBCACXNkvAL3wqgKX9tUpay1klghT9KtJ2lNdYbz7EmqcSddQdZprrAfdUQ9jdo8i2Ougtu
 LP5AnU12f0zFcuYayQAN0R7jiWgPK2wW/vuPq2ezEpXmBo/2L6jCeryucqxDWMLCuXnjZKSFp
 Qskk2gCrUxbIXCJ1Oq4hnsE24nPsIsmi61DI0gpD2SPkZLC30tn0wKwyU0HGxZm2O+VkcfJBy
 XrDBRlkPl1AQgQuJVlVGqpKRD6c83buiJvp7itaVIS+yufL3t1g4u3BVcaBcQJLI8Lja96VtH
 We+NuoopJSfJDZVlb5168Tc4K/SKWqmm/wLODIZgaM/FA6v1/QpqdFqNCmwvVs3WQLsF2tSNx
 50UsfQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 29f4332e66 (Quit passing 'now' to date code, 2019-09-11) removed
its timeval parameter, approxidate_relative() became equivalent to
approxidate().  Convert its last two call sites and remove the redundant
function.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with -U16 for easier review.  Only useful in date.c, but
cannot be restricted to just one file.

 date.c               | 14 --------------
 date.h               |  1 -
 t/helper/test-date.c |  4 ++--
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/date.c b/date.c
index 1fb2cd1b53..7c8650f799 100644
=2D-- a/date.c
+++ b/date.c
@@ -1353,46 +1353,32 @@ static timestamp_t approxidate_str(const char *dat=
e,
 		date++;
 		if (isdigit(c)) {
 			pending_number(&tm, &number);
 			date =3D approxidate_digit(date-1, &tm, &number, time_sec);
 			touched =3D 1;
 			continue;
 		}
 		if (isalpha(c))
 			date =3D approxidate_alpha(date-1, &tm, &now, &number, &touched);
 	}
 	pending_number(&tm, &number);
 	if (!touched)
 		*error_ret =3D 1;
 	return (timestamp_t)update_tm(&tm, &now, 0);
 }

-timestamp_t approxidate_relative(const char *date)
-{
-	struct timeval tv;
-	timestamp_t timestamp;
-	int offset;
-	int errors =3D 0;
-
-	if (!parse_date_basic(date, &timestamp, &offset))
-		return timestamp;
-
-	get_time(&tv);
-	return approxidate_str(date, (const struct timeval *) &tv, &errors);
-}
-
 timestamp_t approxidate_careful(const char *date, int *error_ret)
 {
 	struct timeval tv;
 	timestamp_t timestamp;
 	int offset;
 	int dummy =3D 0;
 	if (!error_ret)
 		error_ret =3D &dummy;

 	if (!parse_date_basic(date, &timestamp, &offset)) {
 		*error_ret =3D 0;
 		return timestamp;
 	}

 	get_time(&tv);
 	return approxidate_str(date, &tv, error_ret);
diff --git a/date.h b/date.h
index 5d4eaba0a9..6136212a19 100644
=2D-- a/date.h
+++ b/date.h
@@ -55,20 +55,19 @@ const char *show_date(timestamp_t time, int timezone, =
const struct date_mode *mo
  */
 void parse_date_format(const char *format, struct date_mode *mode);

 /**
  * Release a "struct date_mode", currently only required if
  * parse_date_format() has parsed a "DATE_STRFTIME" format.
  */
 void date_mode_release(struct date_mode *mode);

 void show_date_relative(timestamp_t time, struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offse=
t);
 int parse_expiry_date(const char *date, timestamp_t *timestamp);
 void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
 timestamp_t approxidate_careful(const char *, int *);
-timestamp_t approxidate_relative(const char *date);
 int date_overflows(timestamp_t date);
 time_t tm_to_time_t(const struct tm *tm);
 #endif
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index cd6a6df702..2d9232cc68 100644
=2D-- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -68,42 +68,42 @@ static void parse_dates(const char **argv)

 		strbuf_reset(&result);
 		parse_date(*argv, &result);
 		if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) =3D=3D 2)
 			printf("%s -> %s\n",
 			       *argv, show_date(t, tz, DATE_MODE(ISO8601)));
 		else
 			printf("%s -> bad\n", *argv);
 	}
 	strbuf_release(&result);
 }

 static void parse_approxidate(const char **argv)
 {
 	for (; *argv; argv++) {
 		timestamp_t t;
-		t =3D approxidate_relative(*argv);
+		t =3D approxidate(*argv);
 		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
 	}
 }

 static void parse_approx_timestamp(const char **argv)
 {
 	for (; *argv; argv++) {
 		timestamp_t t;
-		t =3D approxidate_relative(*argv);
+		t =3D approxidate(*argv);
 		printf("%s -> %"PRItime"\n", *argv, t);
 	}
 }

 static void getnanos(const char **argv)
 {
 	double seconds =3D getnanotime() / 1.0e9;

 	if (*argv)
 		seconds -=3D strtod(*argv, NULL);
 	printf("%lf\n", seconds);
 }

 int cmd__date(int argc UNUSED, const char **argv)
 {
 	const char *x;
=2D-
2.40.0
