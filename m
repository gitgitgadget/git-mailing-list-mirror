Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E08420209
	for <e@80x24.org>; Sat,  1 Jul 2017 12:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbdGAMzV (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 08:55:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34284 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdGAMzT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 08:55:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so12381976wmg.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2BfJW3MECXbywbYWUCHGrh1yrbsn0xwjo1gVYAir/mw=;
        b=nwtXEhZWyswey3627/2yQvfBzAKYUjOpvyi1OLguLQIOzcdm6r2lF/LCjgasTB9fPB
         1UFhv96H7otudyP+35itzvVbgjnj00RfEsZsWaC805nfJnn4aQ3Zn80jrvmDS7lBSii1
         oP9hTDHZLW7sjuL0Ao4TlS+9deYzmahVnpQOV5i9SonfZNz0wsgjXpvMo8DsBIbdLDwH
         EBhQu9r+5n2BqobmK8KQbJNVOxkoqmFE85OQDm5QS7Re/H/e+0Dj1nekgdoOprbvdtct
         dul+aEdX6uBBZoZC571GoEMMCNVtKkNfv/OYlbidY/DCEYYH0qLZbaCDcq8qm2+RzXer
         cmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2BfJW3MECXbywbYWUCHGrh1yrbsn0xwjo1gVYAir/mw=;
        b=aUhwQq+tFJY5N47o4FTsrZst8gZKBgpNUAGwJWzSB4+GLKornoMsmwpQPmtwINnwhD
         bUT8YVitDOXjK8LeBuzfVL8MGrQgac0oNxagsSZCS53XTfpgVikbGPUzrASuUkLUzLED
         GvBGnxfyPr51R7rv7nBsT7sxEU/VhzLu0cFDYJrhnscFEm+yYWVIPFxmHfzNJOWPlj13
         4vSFvjq80NzBm1v4iGI0b4GTh1XHkT125/2msRR0suMI6HJqFXVKhIzVGdG7PK426K0D
         q9oF34Qfp/g46Cv3NTF/+Esybv+rKOs1gjwNAnB75lgf6dW/eC5K2wYmw0cXAZ5HtSz5
         EA4g==
X-Gm-Message-State: AKS2vOzH0cENILAyD9I9d8H3WxxgfAnywiEwl3bcO5RJFrafzHtKCHe7
        xw2EIueyQX3iK2Ss4qM=
X-Received: by 10.80.194.66 with SMTP id t2mr8929339edf.86.1498913717545;
        Sat, 01 Jul 2017 05:55:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b22sm3964355edb.9.2017.07.01.05.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 05:55:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 2/2] strbuf: change an always NULL/"" strbuf_addftime() param to bool
Date:   Sat,  1 Jul 2017 12:55:07 +0000
Message-Id: <20170701125507.27214-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170701125507.27214-1-avarab@gmail.com>
References: <20170701125507.27214-1-avarab@gmail.com>
In-Reply-To: <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_addstr() allows callers to pass a time zone name for expanding
%Z. The only current caller either passes the empty string or NULL, in
which case %Z is handed over verbatim to strftime(3).  Replace that
string parameter with a flag controlling whether to remove %Z from the
format specification. This simplifies the code.

Commit-message-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Jun 24 2017, Junio C. Hamano jotted:
> René Scharfe <l.s.r@web.de> writes:
>> Here's an attempt at a commit message that would have be easier to
>> understand for me:
>>
>>   strbuf_addstr() allows callers to pass a time zone name for expanding
>>   %Z.  The only current caller either passes the empty string or NULL,
>>   in which case %Z is handed over verbatim to strftime(3).  Replace that
>>   string parameter with a flag controlling whether to remove %Z from the
>>   format specification.  This simplifies the code.
>
> I think the first one is strbuf_addftime(); other than that, I think
> this version explains what is going on in this patch than the
> original.
>
> I'll wait for Ævar to respond, but my inclination is to take the
> patch with the above tweaks to the log message, as the change is
> easy to revert if we find it necessary.

Thanks both. Here's a v6 with those changes, sorry about the delay.

 date.c   | 2 +-
 strbuf.c | 5 ++---
 strbuf.h | 5 +++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index 1fd6d66375..c3e673fd04 100644
--- a/date.c
+++ b/date.c
@@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
-				mode->local ? NULL : "");
+				!mode->local);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/strbuf.c b/strbuf.c
index c4e91a6656..89d22e3b09 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -779,7 +779,7 @@ char *xstrfmt(const char *fmt, ...)
 }
 
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
-		     int tz_offset, const char *tz_name)
+		     int tz_offset, int suppress_tz_name)
 {
 	struct strbuf munged_fmt = STRBUF_INIT;
 	size_t hint = 128;
@@ -808,8 +808,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 			fmt++;
 			break;
 		case 'Z':
-			if (tz_name) {
-				strbuf_addstr(&munged_fmt, tz_name);
+			if (suppress_tz_name) {
 				fmt++;
 				break;
 			}
diff --git a/strbuf.h b/strbuf.h
index 6809d7daa8..2075384e0b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -337,11 +337,12 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
  * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
  * of Greenwich, and it's used to expand %z internally.  However, tokens
  * with modifiers (e.g. %Ez) are passed to `strftime`.
- * `tz_name` is used to expand %Z internally unless it's NULL.
+ * `suppress_tz_name`, when set, expands %Z internally to the empty
+ * string rather than passing it to `strftime`.
  */
 extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
 			    const struct tm *tm, int tz_offset,
-			    const char *tz_name);
+			    int suppress_tz_name);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
-- 
2.13.1.611.g7e3b11ae1

