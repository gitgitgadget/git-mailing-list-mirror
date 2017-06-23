Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EA320282
	for <e@80x24.org>; Fri, 23 Jun 2017 14:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbdFWOqQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 10:46:16 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36000 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753528AbdFWOqP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 10:46:15 -0400
Received: by mail-lf0-f65.google.com with SMTP id f28so6759611lfi.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLN0SRtg2SldCp2eBxzgpF+ApyvGRunRfXWCttIhpXw=;
        b=Va+lOVtaB3W7/PSZqUSeJ55ZM8J1BDDePXiwPdOb1pxyBTzV4bf4kIwfuFH0LQmutA
         RuyoFOVilCOSPqnrOw63T9gh8O3sWY59X8UX9tWbYpiMmmowhOUotHlkmaV2Bhd5RwkW
         yr4/aPG9a87sXI5RbRoRO7pjmHP4UDiyOz6RbFUEcNpxKIgekzecb3s2ANTBRZzSSkA0
         0jyN9piLpfydUMwNDlko7z70oR+KqH3DQ+DdIRHfxD56FdKbt8LV9if8X8+TLq0AkQ8j
         PMDw5dQC8BDEux2+JDJiHcV2clmHpYd0av6PC2dDf7Co9/EPoFPqIR2+CRZFNsuq9nPc
         TSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLN0SRtg2SldCp2eBxzgpF+ApyvGRunRfXWCttIhpXw=;
        b=gu90MNlb8x6cvH5HadVkfXL98WcdiiKoORw/+TMQcl80PREDsfUpR4UStRbmA8goW9
         aDml85KjG1/hyehOiGiy2YSAQCUC3u6x0dbpw2SV5IBSD0iIN61ZzyUXWKVfKZc6BGSP
         bexzfpZA6QsoCXdR2RKZAGvilHo41+guWTFYw/JSjbZPaT/oqlAKLzz2kQvUm0tyxEan
         VT28tTWJfncD7LJtMAXFOPq3s1z6ooQTzjO4ocFwYkI8kEpb5Wm4v0go9woC4AnTCX4K
         HPtmkn1KeO96QG7qHUAIfQsJSuNh2/m3chawtF3PATvlMDfjYhWezXM1zEcZ5HNiK3/Z
         NamA==
X-Gm-Message-State: AKS2vOznEI/SH0iAl7NMm83vYpYDQVHKIw12qikI8Z7vdQfn8k9rg4h7
        1VWh9JPcGvBNGUgU3Hg=
X-Received: by 10.80.182.157 with SMTP id d29mr6360438ede.56.1498229173225;
        Fri, 23 Jun 2017 07:46:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l17sm2318569edc.39.2017.06.23.07.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 07:46:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param to bool
Date:   Fri, 23 Jun 2017 14:46:03 +0000
Message-Id: <20170623144603.11774-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the code for deciding what's to be done about %Z to stop
passing always either a NULL or "" char * to
strbuf_addftime(). Instead pass a boolean int to indicate whether the
strftime() %Z format should be omitted, which is what this code is
actually doing.

This code grew organically between the changes in 9eafe86d58 ("Merge
branch 'rs/strbuf-addftime-zZ'", 2017-06-22) yielding an end result
that wasn't very readable. Out of context it looked as though the call
to strbuf_addstr() might be adding a custom tz_name to the string, but
actually tz_name would always be "", so the call to strbuf_addstr()
just to add an empty string to the format was pointless.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 date.c   | 2 +-
 strbuf.c | 5 ++---
 strbuf.h | 5 +++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index 1fd6d66375..5f09743bad 100644
--- a/date.c
+++ b/date.c
@@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
-				mode->local ? NULL : "");
+				mode->local ? 0 : 1);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/strbuf.c b/strbuf.c
index be3b9e37b1..81ff3570e2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -786,7 +786,7 @@ char *xstrfmt(const char *fmt, ...)
 }
 
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
-		     int tz_offset, const char *tz_name)
+		     int tz_offset, const int omit_strftime_tz_name)
 {
 	struct strbuf munged_fmt = STRBUF_INIT;
 	size_t hint = 128;
@@ -815,8 +815,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 			fmt++;
 			break;
 		case 'Z':
-			if (tz_name) {
-				strbuf_addstr(&munged_fmt, tz_name);
+			if (omit_strftime_tz_name) {
 				fmt++;
 				break;
 			}
diff --git a/strbuf.h b/strbuf.h
index 4559035c47..bad698058a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -340,14 +340,15 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 /**
  * Add the time specified by `tm`, as formatted by `strftime`.
- * `tz_name` is used to expand %Z internally unless it's NULL.
  * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
  * of Greenwich, and it's used to expand %z internally.  However, tokens
  * with modifiers (e.g. %Ez) are passed to `strftime`.
+ * `omit_strftime_tz_name` when set, means don't let `strftime` format
+ * %Z, instead do our own formatting.
  */
 extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
 			    const struct tm *tm, int tz_offset,
-			    const char *tz_name);
+			    const int omit_strftime_tz_name);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
-- 
2.13.1.611.g7e3b11ae1

