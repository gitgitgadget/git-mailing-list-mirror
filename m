Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A42C4332F
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJKAeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJKAeG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:06 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA361723
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:05 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id a2so6409910iln.13
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9P8zBi5V64Fajqxnrctl6pwpjn/IaczFaAmlsO8RT8=;
        b=CiQf9eSY1y8Gfd93YZkemqx+KfslUNKKNRQnJotCIcTNFZpI/attsRkUUryI53G/rQ
         uRslMGeVhZEE1PIUZ5o+GiaEa93qpC0s/HmjSPb44C/1ntjgor5ZYqifGwIozhOCoclB
         SdZIoHnP/RK2vQE0u7QclN3xVY9qXwKxPpRDbt7FpTUgNAmfiIVhWPI1EEcbYwprymaO
         QAxBSNzCo+noxNGeNa31XKgMBs8yiM5RW/f8dt5TOJrHTXB4y8XYZRFJiRdGRhLv8Ymv
         cky278LnyJ/XsqtaMTsHWsVIEN4VvnFiwF3veZbZ5Q/4SeN8drQ1sxqteux3tR28ItbP
         MAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9P8zBi5V64Fajqxnrctl6pwpjn/IaczFaAmlsO8RT8=;
        b=ea39R8IpQTW5iTWYNB18ujoqGMPH3fPMf49lgPrHYjLZc0C+bpv47YN7ZU07IxTZHd
         ANZVKUuHXonPN+8dqkVlwVxUJQDygL7tiTOKexpcEt8hnlsCtals8i4L7PHMwY1XpdzF
         LxOLZXPjpBXwlX9/RusPyNMJNz1mj8XNXBM1QEPp1eIW9BSrRNs8HE1A6gsDCdOfsI3f
         tJQAMnND5iRHvO+1y+das+Gztpd8RHwOU1tI+ebWnytnfPEzhff9AG5jXEpk6ThbHIpu
         Jg09uAEpw/2DoTjvWSsxIyqa3hbb+r/bKRhp4XZ5EgR0LKe50YyRCdCtqaHtLDJzY0fN
         p0tA==
X-Gm-Message-State: ACrzQf347wNCSxMsO5dkvJ6pmBO/yAFOZqyhf0lENGxaVbgxrXZSUfan
        lwWmPBmqXtcHW8/L6TzUS4l51FH3z/VYqr+7
X-Google-Smtp-Source: AMsMyM5zokAYz/aOO7VnfYTu62B5SNnuBYYp9F3gYZ1KBP0QojvXIfnwvg1G5g6lmg/e4lKBtg/A2w==
X-Received: by 2002:a92:c247:0:b0:2fa:16d1:9cc0 with SMTP id k7-20020a92c247000000b002fa16d19cc0mr10079352ilo.293.1665448444139;
        Mon, 10 Oct 2022 17:34:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x12-20020a92dc4c000000b002fc681a6ad8sm662502ilq.78.2022.10.10.17.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:34:03 -0700 (PDT)
Date:   Mon, 10 Oct 2022 20:34:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@initialcommit.io, peff@peff.net, gitster@pobox.com
Subject: [PATCH 1/7] Documentation: extract date-options.txt
Message-ID: <eaec59daa178c205a59b779c63e411316d8180ed.1665448437.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future commit will want to include `--date`-related options in the
documentation for `git-shortlog(1)`, but without some of the additional
baggage in the usual rev-list-options.txt.

Extract those options to a separate file in Documentation and include it
from its original source in rev-list-options.txt.

This patch does not modify the contents of the `--date`-options section
of Documentation/rev-list-options.txt.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/date-options.txt     | 66 +++++++++++++++++++++++++++++
 Documentation/rev-list-options.txt | 67 +-----------------------------
 2 files changed, 67 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/date-options.txt

diff --git a/Documentation/date-options.txt b/Documentation/date-options.txt
new file mode 100644
index 0000000000..65896e4b95
--- /dev/null
+++ b/Documentation/date-options.txt
@@ -0,0 +1,66 @@
+--relative-date::
+	Synonym for `--date=relative`.
+
+--date=<format>::
+	Only takes effect for dates shown in human-readable format, such
+	as when using `--pretty`. `log.date` config variable sets a default
+	value for the log command's `--date` option. By default, dates
+	are shown in the original time zone (either committer's or
+	author's). If `-local` is appended to the format (e.g.,
+	`iso-local`), the user's local time zone is used instead.
++
+--
+`--date=relative` shows dates relative to the current time,
+e.g. ``2 hours ago''. The `-local` option has no effect for
+`--date=relative`.
+
+`--date=local` is an alias for `--date=default-local`.
+
+`--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.
+The differences to the strict ISO 8601 format are:
+
+	- a space instead of the `T` date/time delimiter
+	- a space between time and time zone
+	- no colon between hours and minutes of the time zone
+
+`--date=iso-strict` (or `--date=iso8601-strict`) shows timestamps in strict
+ISO 8601 format.
+
+`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
+format, often found in email messages.
+
+`--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
+
+`--date=raw` shows the date as seconds since the epoch (1970-01-01
+00:00:00 UTC), followed by a space, and then the timezone as an offset
+from UTC (a `+` or `-` with four digits; the first two are hours, and
+the second two are minutes). I.e., as if the timestamp were formatted
+with `strftime("%s %z")`).
+Note that the `-local` option does not affect the seconds-since-epoch
+value (which is always measured in UTC), but does switch the accompanying
+timezone value.
+
+`--date=human` shows the timezone if the timezone does not match the
+current time-zone, and doesn't print the whole date if that matches
+(ie skip printing year for dates that are "this year", but also skip
+the whole date itself if it's in the last few days and we can just say
+what weekday it was).  For older dates the hour and minute is also
+omitted.
+
+`--date=unix` shows the date as a Unix epoch timestamp (seconds since
+1970).  As with `--raw`, this is always in UTC and therefore `-local`
+has no effect.
+
+`--date=format:...` feeds the format `...` to your system `strftime`,
+except for %s, %z, and %Z, which are handled internally.
+Use `--date=format:%c` to show the date in your system locale's
+preferred format.  See the `strftime` manual for a complete list of
+format placeholders. When using `-local`, the correct syntax is
+`--date=format-local:...`.
+
+`--date=default` is the default format, and is similar to
+`--date=rfc2822`, with a few exceptions:
+--
+	- there is no comma after the day-of-week
+
+	- the time zone is omitted when the local time zone is used
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1837509566..1cb91dfb9c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1033,72 +1033,7 @@ endif::git-rev-list[]
 
 include::pretty-options.txt[]
 
---relative-date::
-	Synonym for `--date=relative`.
-
---date=<format>::
-	Only takes effect for dates shown in human-readable format, such
-	as when using `--pretty`. `log.date` config variable sets a default
-	value for the log command's `--date` option. By default, dates
-	are shown in the original time zone (either committer's or
-	author's). If `-local` is appended to the format (e.g.,
-	`iso-local`), the user's local time zone is used instead.
-+
---
-`--date=relative` shows dates relative to the current time,
-e.g. ``2 hours ago''. The `-local` option has no effect for
-`--date=relative`.
-
-`--date=local` is an alias for `--date=default-local`.
-
-`--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.
-The differences to the strict ISO 8601 format are:
-
-	- a space instead of the `T` date/time delimiter
-	- a space between time and time zone
-	- no colon between hours and minutes of the time zone
-
-`--date=iso-strict` (or `--date=iso8601-strict`) shows timestamps in strict
-ISO 8601 format.
-
-`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
-format, often found in email messages.
-
-`--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
-
-`--date=raw` shows the date as seconds since the epoch (1970-01-01
-00:00:00 UTC), followed by a space, and then the timezone as an offset
-from UTC (a `+` or `-` with four digits; the first two are hours, and
-the second two are minutes). I.e., as if the timestamp were formatted
-with `strftime("%s %z")`).
-Note that the `-local` option does not affect the seconds-since-epoch
-value (which is always measured in UTC), but does switch the accompanying
-timezone value.
-
-`--date=human` shows the timezone if the timezone does not match the
-current time-zone, and doesn't print the whole date if that matches
-(ie skip printing year for dates that are "this year", but also skip
-the whole date itself if it's in the last few days and we can just say
-what weekday it was).  For older dates the hour and minute is also
-omitted.
-
-`--date=unix` shows the date as a Unix epoch timestamp (seconds since
-1970).  As with `--raw`, this is always in UTC and therefore `-local`
-has no effect.
-
-`--date=format:...` feeds the format `...` to your system `strftime`,
-except for %s, %z, and %Z, which are handled internally.
-Use `--date=format:%c` to show the date in your system locale's
-preferred format.  See the `strftime` manual for a complete list of
-format placeholders. When using `-local`, the correct syntax is
-`--date=format-local:...`.
-
-`--date=default` is the default format, and is similar to
-`--date=rfc2822`, with a few exceptions:
---
-	- there is no comma after the day-of-week
-
-	- the time zone is omitted when the local time zone is used
+include::date-options.txt[]
 
 ifdef::git-rev-list[]
 --header::
-- 
2.37.0.1.g1379af2e9d

