Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62B21F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 22:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeGGWCk (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 18:02:40 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35451 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeGGWCj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 18:02:39 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so4367599plt.2
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6HqwArH5YN6YnqmZq04C7DLD//O7XfRwK6v1a6phJ1w=;
        b=MnrYWRe6kCxphHG9q5NyZAiDKmDW5iganEGXuw/fpTG+phiFZ4nhWLrn/6VnoKinid
         XhJWd8S0HPJmLBvuWjOIHIdPr5aa/kbXqNBJcNMNWlBbX6r+NLSie2RUvSVsmlM8keP1
         BVKwM9gH7QGEnUOAHM5fLL4msThbwyaWMNmnfT6z1zqpNM1ifJgGnrFfJoiDRgYub0/4
         6rheNcYwHy3aXb4byiBjo3Gt1QT99FDIy3s735k7vfUujhs1gD7218CZrB2P2f1Ec/Cw
         oz2o/x6LRyV/EEENIgcU581lg7PBmrzC/5Y3s9G50XghWJkEwV8JlFYJ43TaVoC7kOSV
         4UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=6HqwArH5YN6YnqmZq04C7DLD//O7XfRwK6v1a6phJ1w=;
        b=WrAn8vrDFAdHwM/VtIEAxFZYYC1iMPTUTk/hqFFJsJic9aNIQuyBjlSKt5fu+W/7ra
         iRtnT/idV+uX2ehDP+1vZOLsCIBjpSZzviV+kw7BrGcTOYR1xelTKAzJhXhlL8XkBCW1
         +SVIABAS5FEYNxC9JH/nGRsZIq+jfCoQemgLkdJy6uhoFZP4l5NARnrLSYkwkvI/DPbj
         /3NHWpD3IXWR1usaZnirXNiU5SwW7CgpAWzekjLM6ilD9WdXTbGxgaHUSRfuIlJcI1ZC
         1bKG/KllQXjPCaf1RfyWV8IGTY3TxXnkklbZWQizXlW3U8BeYgOyjtF0e8IxUaIrBrDN
         fjmA==
X-Gm-Message-State: APt69E3CD0xy45MlHAt8uuJJEJKIX99VRA1hik3wd7bct/5++mDt8Tlm
        hdGr2e9SBC1/0u5esskktJI=
X-Google-Smtp-Source: AAOMgpceD/cd9c+FcVkgVGRWP98TeaKujme2QuQLzUSJmeBhCisysgGRx+9dD172ELlJiuQI96QAMg==
X-Received: by 2002:a17:902:5ac3:: with SMTP id g3-v6mr14910152plm.90.1531000958440;
        Sat, 07 Jul 2018 15:02:38 -0700 (PDT)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id e3-v6sm19987300pfa.183.2018.07.07.15.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 15:02:37 -0700 (PDT)
Date:   Sat, 7 Jul 2018 15:02:35 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: [RFC PATCH v2] Add 'human' date format
In-Reply-To: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
Message-ID: <alpine.LFD.2.21.999.1807071502260.18818@i7.lan>
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
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

For really recent dates (same day), use the relative date stamp, while
for old dates (year doesn't match), don't bother with time and timezone.

Also add 'auto' date mode, which defaults to human if we're using the
pager.  So you can do

	git config --add log.date auto

and your "git log" commands will show the human-legible format unless
you're scripting things.

Note that this time format still shows the timezone for recent enough
events (but not so recent that they show up as relative dates).  You can
combine it with the "-local" suffix to never show timezones for an even
more simplified view.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Slightly updated version after playing with this more. 

This tries to make the length somewhat more consistent (and shorter), 
which came about when looking at this in "git blame" output. 

Once you're talking "last year" patches, you don't tend to care about time 
of day or timezone. So the longest date is basically "Thu Oct 19 16:00", 
because if you show the year (four characters), you don't show the time 
(five characters). And the timezone (five characters) is only shown if not 
showing the date (5-6 characters).

Also, because the relative time is now handled entirely inside the 
show_date_normal() function, I could undo some of the changes to 
show_date() that were updating date->mode and date->local. So the patch 
has actually shrunk a bit, I think.

 builtin/blame.c |   4 ++
 cache.h         |   1 +
 date.c          | 130 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 115 insertions(+), 20 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a0388aae..7b6235321 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -917,6 +917,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		 */
 		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /* add the null */
 		break;
+	case DATE_HUMAN:
+		/* If the year is shown, no time is shown */
+		blame_date_width = sizeof("Thu Oct 19 16:00");
+		break;
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
index 49f943e25..4486c028a 100644
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
@@ -191,9 +199,80 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
+static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm, int tz, struct tm *human_tm, int human_tz, int local)
+{
+	struct {
+		unsigned int	year:1,
+				date:1,
+				wday:1,
+				time:1,
+				seconds:1,
+				tz:1;
+	} hide = { 0 };
+
+	hide.tz = local || tz == human_tz;
+	hide.year = tm->tm_year == human_tm->tm_year;
+	if (hide.year) {
+		if (tm->tm_mon == human_tm->tm_mon) {
+			if (tm->tm_mday > human_tm->tm_mday) {
+				/* Future date: think timezones */
+			} else if (tm->tm_mday == human_tm->tm_mday) {
+				hide.date = hide.wday = 1;
+			} else if (tm->tm_mday + 5 > human_tm->tm_mday) {
+				/* Leave just weekday if it was a few days ago */
+				hide.date = 1;
+			}
+		}
+	}
+
+	/* Show "today" times as just relative times */
+	if (hide.wday) {
+		struct timeval now;
+		gettimeofday(&now, NULL);
+		show_date_relative(time, tz, &now, buf);
+		return;
+	}
+
+	/*
+	 * Always hide seconds for human-readable.
+	 * Hide timezone if showing date.
+	 * Hide weekday and time if showing year.
+	 *
+	 * The logic here is two-fold:
+	 *  (a) only show details when recent enough to matter
+	 *  (b) keep the maximum length "similar", and in check
+	 */
+	if (human_tm->tm_year) {
+		hide.seconds = 1;
+		hide.tz |= !hide.date;
+		hide.wday = hide.time = !hide.year;
+	}
+
+	if (!hide.wday)
+		strbuf_addf(buf, "%.3s ", weekday_names[tm->tm_wday]);
+	if (!hide.date)
+		strbuf_addf(buf, "%.3s %d ", month_names[tm->tm_mon], tm->tm_mday);
+
+	/* Do we want AM/PM depending on locale? */
+	if (!hide.time) {
+		strbuf_addf(buf, "%02d:%02d", tm->tm_hour, tm->tm_min);
+		if (!hide.seconds)
+			strbuf_addf(buf, ":%02d", tm->tm_sec);
+	} else
+		strbuf_rtrim(buf);
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
 	struct tm *tm;
+	struct tm human_tm = { 0 };
+	int human_tz = -1;
 	static struct strbuf timebuf = STRBUF_INIT;
 
 	if (mode->type == DATE_UNIX) {
@@ -202,6 +281,15 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		return timebuf.buf;
 	}
 
+	if (mode->type == DATE_HUMAN) {
+		struct timeval now;
+
+		gettimeofday(&now, NULL);
+
+		/* Fill in the data for "current time" in human_tz and human_tm */
+		human_tz = local_time_tzoffset(now.tv_sec, &human_tm);
+	}
+
 	if (mode->local)
 		tz = local_tzoffset(time);
 
@@ -258,14 +346,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
 				!mode->local);
 	else
-		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
-				weekday_names[tm->tm_wday],
-				month_names[tm->tm_mon],
-				tm->tm_mday,
-				tm->tm_hour, tm->tm_min, tm->tm_sec,
-				tm->tm_year + 1900,
-				mode->local ? 0 : ' ',
-				tz);
+		show_date_normal(&timebuf, time, tm, tz, &human_tm, human_tz, mode->local);
 	return timebuf.buf;
 }
 
@@ -802,6 +883,11 @@ int parse_date(const char *date, struct strbuf *result)
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
@@ -819,6 +905,10 @@ static enum date_mode_type parse_date_type(const char *format, const char **end)
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
2.18.0.132.g95eda3d86

