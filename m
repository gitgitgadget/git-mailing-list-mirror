Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F781F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 19:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeGGTjD (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 15:39:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42000 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbeGGTjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 15:39:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id f4-v6so100781plb.9
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=GlaZBd/Grp7M4g7+FMd5T0iAJ+cNIsBAMDlzh+26rRA=;
        b=Qu+vtKHkjMSm3lBm/bQROLqGO2Q/EutqZu+/csu57Fxhd+B0rDGizotOxiyHylnv9Y
         CyIGM4YJE3ZngEumwB9GBXA1CwerkNnyoHqpudq4366AQNJm5+p0gFmu8tGdxbcM1Gf1
         +dZlxKalRETMAcQHAyVf+WEb8/gpGNR6mCtaXvROQgoSa/5pgkDK5y9h/igo+rgpvc0b
         SkfdMzTJuGd2vfZ72Kc+rqFiLM3XbsJ6xDTyIg+QPSroEUuO0kEmtdNnQ63QNwcfj93F
         lc7Th2eVHNFPKzKS1DeLjc39XaULSVXnI5kJbqTAG+yTNmcFhYb0M9T+ZwJ5KovfTAMU
         LCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=GlaZBd/Grp7M4g7+FMd5T0iAJ+cNIsBAMDlzh+26rRA=;
        b=HPr/JUdRFGh1ca+vM9bO4bpjOH5rptCThu6xoit3W5mZIZZTX/Qpzvi9weA2+0Z043
         KtqOeQ6ExHpqM/sB2QIFdlusf7n2wvJn65Ph6CmRAtmJRjbSR76nAzL/baiyLBCKlfF4
         Fugmh/PtCWHuJOPWDD54yHw/McBhNHKOZdoUQPE3chEkk1HnHLhjvBAqStt0LPey/FXB
         s2Cl8W0W101PD/tINfaEjfxkgB9+mLW+EUTO/F1jHUampl/GJ+fER/BQZYlCVnyvYtWE
         O3v7kheOVPZnzUQg3A5giKT29TOoNJTRsFSyexkFeyb/PK2BB9teNcqXLTnKLDd2VTHW
         siew==
X-Gm-Message-State: APt69E1sAXK0tkEDoQ71Xa2S/vwqQ5XwPw4zb42ZPLoFisdkpVS41Fan
        cCZKWdDDShVe49y9ttwYBZI=
X-Google-Smtp-Source: AAOMgpdmZ0VXlT/zjuG4ckaomLLtix4hIYOgPpPILtB0dfjjUpo5+JSXYQNc8HX4OU04xWSN4gLoAw==
X-Received: by 2002:a17:902:988f:: with SMTP id s15-v6mr14836800plp.95.1530992341251;
        Sat, 07 Jul 2018 12:39:01 -0700 (PDT)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16298730pfj.122.2018.07.07.12.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 12:39:00 -0700 (PDT)
Date:   Sat, 7 Jul 2018 12:38:59 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: [RFC PATCH] Add 'human' date format
Message-ID: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
User-Agent: Alpine 2.21.999 (LFD 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>

This adds --date=human, which skips the timezone if it matches the
current time-zone, and doesn't print the whole date if that matches (ie
skip printing year for dates that are "this year", but also skip the
whole date itself if it's in the last few days and we can just say what
weekday it was).

For really recent dates (within the last hour), use the relative date
stamp.

Also add 'auto' date mode, which defaults to human if we're using the
pager.  So you can do

	git config --add log.date auto

and your "git log" commands will show the human-legible format unless
you're scripting things.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Ok, I tried something like this long long ago, but that was a fairly nasty 
patch that just defaulted to "--date=relative" for recent dates, and then 
did the usual default for anything else.

But the issue kept bugging me, and this is a slightly more sane model (?). 
It keeps the notion of "let's use --date=relative for very recent dates", 
but for anything that is more than an hour old, it just uses a simplified 
date.

For example, for time stamps that are "today", just show the time. And if 
the year or the time zone matches the current year or timezone, skip them.  
And don't bother showing seconds, because humans won't care.

The end result is a slightly simplified view.

So for example, the date for this commit right now looks like

    Date:   Sat Jul 7 12:21:26 2018 -0700

to me, but with "--date=human", right now it just says

    Date:   12:21

(and maybe for a US locale, I should make it do the AM/PM thing).

This is marked RFC because

 (a) maybe I'm the only one who has ever wanted the simplified dates

 (b) the simplification rules themselves might be worthy of discussion.

For example, I also simplified the "a couple of days ago" case, so that it 
shows

    Date:   Fri 19:45

for one of my kernel commits that happened yesterday. The date didn't 
match _exactly_, but it's the same month, and just a few days ago, so it 
just shows the weekday. Is that easier to read? Maybe. I kind of like it.


 builtin/blame.c |   1 +
 cache.h         |   1 +
 date.c          | 139 +++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 110 insertions(+), 31 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a0388aae..27c64b1c8 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -917,6 +917,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 */
 		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
 		break;
+	case DATE_HUMAN:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
diff --git a/cache.h b/cache.h
index d49092d94..8a6810ee6 100644
--- a/cache.h
+++ b/cache.h
@@ -1428,6 +1428,7 @@ extern struct object *peel_to_type(const char *name, int namelen,
 struct date_mode {
 	enum date_mode_type {
 		DATE_NORMAL = 0,
+		DATE_HUMAN,
 		DATE_RELATIVE,
 		DATE_SHORT,
 		DATE_ISO8601,
diff --git a/date.c b/date.c
index 49f943e25..9809ac334 100644
--- a/date.c
+++ b/date.c
@@ -77,22 +77,16 @@ static struct tm *time_to_tm_local(timestamp_t time)
 }
 
 /*
- * What value of "tz" was in effect back then at "time" in the
- * local timezone?
+ * Fill in the localtime 'struct tm' for the supplied time,
+ * and return the local tz.
  */
-static int local_tzoffset(timestamp_t time)
+static int local_time_tzoffset(time_t t, struct tm *tm)
 {
-	time_t t, t_local;
-	struct tm tm;
+	time_t t_local;
 	int offset, eastwest;
 
-	if (date_overflows(time))
-		die("Timestamp too large for this system: %"PRItime, time);
-
-	t = (time_t)time;
-	localtime_r(&t, &tm);
-	t_local = tm_to_time_t(&tm);
-
+	localtime_r(&t, tm);
+	t_local = tm_to_time_t(tm);
 	if (t_local == -1)
 		return 0; /* error; just use +0000 */
 	if (t_local < t) {
@@ -107,6 +101,20 @@ static int local_tzoffset(timestamp_t time)
 	return offset * eastwest;
 }
 
+/*
+ * What value of "tz" was in effect back then at "time" in the
+ * local timezone?
+ */
+static int local_tzoffset(timestamp_t time)
+{
+	struct tm tm;
+
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+
+	return local_time_tzoffset((time_t)time, &tm);
+}
+
 void show_date_relative(timestamp_t time, int tz,
 			       const struct timeval *now,
 			       struct strbuf *timebuf)
@@ -191,27 +199,94 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
+static void show_date_normal(struct strbuf *buf, struct tm *tm, int tz, struct tm *human_tm, int human_tz, int local)
+{
+	struct {
+		unsigned int	year:1,
+				date:1,
+				wday:1,
+				seconds:1,
+				tz:1;
+	} hide = { 0 };
+
+	hide.tz = local || tz == human_tz;
+	hide.year = tm->tm_year == human_tm->tm_year;
+	if (hide.year) {
+		if (tm->tm_mon == human_tm->tm_mon) {
+			if (tm->tm_mday > human_tm->tm_mday) {
+				/* Crazy future time */
+				hide.year = 0;
+			} else if (tm->tm_mday == human_tm->tm_mday) {
+				hide.date = hide.wday = 1;
+			} else if (tm->tm_mday + 5 > human_tm->tm_mday) {
+				/* Leave just weekday if it was a few days ago */
+				hide.date = 1;
+			}
+		}
+	}
+
+	/* Always hide seconds for human-readable */
+	hide.seconds = human_tm->tm_year > 0;
+
+	if (!hide.wday)
+		strbuf_addf(buf, "%.3s ", weekday_names[tm->tm_wday]);
+	if (!hide.date)
+		strbuf_addf(buf, "%.3s %d ", month_names[tm->tm_mon], tm->tm_mday);
+
+	/* Always show time. Do we want AM/PM depending on locale? */
+	strbuf_addf(buf, "%02d:%02d", tm->tm_hour, tm->tm_min);
+	if (!hide.seconds)
+		strbuf_addf(buf, ":%02d", tm->tm_sec);
+
+	if (!hide.year)
+		strbuf_addf(buf, " %d", tm->tm_year + 1900);
+
+	if (!hide.tz)
+		strbuf_addf(buf, " %+05d", tz);
+}
+
 const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 {
+	int type = mode->type;
+	int local = mode->local;
 	struct tm *tm;
+	struct tm human_tm = { 0 };
+	int human_tz = -1;
 	static struct strbuf timebuf = STRBUF_INIT;
 
-	if (mode->type == DATE_UNIX) {
+	if (type == DATE_UNIX) {
 		strbuf_reset(&timebuf);
 		strbuf_addf(&timebuf, "%"PRItime, time);
 		return timebuf.buf;
 	}
 
-	if (mode->local)
+	if (type == DATE_HUMAN) {
+		struct timeval now;
+
+		gettimeofday(&now, NULL);
+
+		/* Fill in the data for "current time" in human_tz and human_tm */
+		human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
+
+		/* Special case: if it's less than an hour ago, use relative time */
+		if (time - now.tv_sec < 60 * 60)
+			type = DATE_RELATIVE;
+
+		/* Don't print timezone if it matches */
+		if (tz == human_tz)
+			local = 1;
+	}
+
+	if (local)
 		tz = local_tzoffset(time);
 
-	if (mode->type == DATE_RAW) {
+	if (type == DATE_RAW) {
 		strbuf_reset(&timebuf);
 		strbuf_addf(&timebuf, "%"PRItime" %+05d", time, tz);
 		return timebuf.buf;
 	}
 
-	if (mode->type == DATE_RELATIVE) {
+	if (type == DATE_RELATIVE) {
 		struct timeval now;
 
 		strbuf_reset(&timebuf);
@@ -220,7 +295,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
-	if (mode->local)
+	if (local)
 		tm = time_to_tm_local(time);
 	else
 		tm = time_to_tm(time, tz);
@@ -230,17 +305,17 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 	}
 
 	strbuf_reset(&timebuf);
-	if (mode->type == DATE_SHORT)
+	if (type == DATE_SHORT)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
-	else if (mode->type == DATE_ISO8601)
+	else if (type == DATE_ISO8601)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
-	else if (mode->type == DATE_ISO8601_STRICT) {
+	else if (type == DATE_ISO8601_STRICT) {
 		char sign = (tz >= 0) ? '+' : '-';
 		tz = abs(tz);
 		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
@@ -249,23 +324,16 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				sign, tz / 100, tz % 100);
-	} else if (mode->type == DATE_RFC2822)
+	} else if (type == DATE_RFC2822)
 		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
-	else if (mode->type == DATE_STRFTIME)
+	else if (type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
-				!mode->local);
+				!local);
 	else
-		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
-				weekday_names[tm->tm_wday],
-				month_names[tm->tm_mon],
-				tm->tm_mday,
-				tm->tm_hour, tm->tm_min, tm->tm_sec,
-				tm->tm_year + 1900,
-				mode->local ? 0 : ' ',
-				tz);
+		show_date_normal(&timebuf, tm, tz, &human_tm, human_tz, local);
 	return timebuf.buf;
 }
 
@@ -802,6 +870,11 @@ int parse_date(const char *date, struct strbuf *result)
 	return 0;
 }
 
+static int auto_date_style(void)
+{
+	return (isatty(1) || pager_in_use()) ? DATE_HUMAN : DATE_NORMAL;
+}
+
 static enum date_mode_type parse_date_type(const char *format, const char **end)
 {
 	if (skip_prefix(format, "relative", end))
@@ -819,6 +892,10 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
 		return DATE_SHORT;
 	if (skip_prefix(format, "default", end))
 		return DATE_NORMAL;
+	if (skip_prefix(format, "human", end))
+		return DATE_HUMAN;
+	if (skip_prefix(format, "auto", end))
+		return auto_date_style();
 	if (skip_prefix(format, "raw", end))
 		return DATE_RAW;
 	if (skip_prefix(format, "unix", end))
-- 
2.18.0.131.gc3213e20f.dirty

