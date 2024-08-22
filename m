Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831DD1D174F
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363874; cv=none; b=F5VK/mRTA3ywrqZTjwrpFPxGcFgcChoxc/8/wy1FUQ9nd81gQRYK3Sybza9ppNLBleWzzsysfppnsmwJAV39nmNsCNGjuTDmZQ+5bkGb18kLFeDDkmcQ4F3zWPN80XtJNNgHCFIMzQOsWTi9oZXC0B3yUUSZidjKl04qvAe805U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363874; c=relaxed/simple;
	bh=O1cT69Ipix/85JXm+8nnpMYvvVyGl5dA2fmJ19/8V1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N/khcHAJb2ih1aC9VYqN8Vd2JFrjxV85Mo53Av2mrLtvh9kR9cvnJPY3+9ItwV3+I24i8Uoi/S4RnZup42qmTykU7d7zSiYmCM8C2RGJlKkVjFQ3Crj9AF4WRY+Wr26t/OsjJRfTcWZNALzkrdxzHpRqQyIoqlTd9jS1QJY38AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cL8ehcxQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cL8ehcxQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b3825748c2so25800187b3.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 14:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724363871; x=1724968671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Viv9nOAtEr+jT6FLDMFvCiyEN+PbpOsrHccaNC7adHA=;
        b=cL8ehcxQ16zCGG8T66wX5VMNDstYCTSG3rIbyn89HdPbXL42m7MwfYbXHQNc8gzvpK
         5mSsqapipapnxL0hUAKn4reOiDV5XMurBFoSwcsJrd5Br5mi9RX62vEf0u1Hzd1NSGCQ
         Hbh465t7wT3uSGNlzV713x/+4EXn49GBwh8cf1mOcT0hb/o0WA6IwVBrv0T1fWqBAO0Y
         HGCBzm2xszGhK1vm9mqm8copPyHo/hdGvo/UoeYPWG+k9cfIz4ed0Ar5oWdQLjagmN6V
         PgysbmkkLvpjzygJIXd0vyaNiRaOjsOmft3fNxKuuDNy+cGQCReD0h0Tp7QWv/Rl05dn
         Oilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724363871; x=1724968671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Viv9nOAtEr+jT6FLDMFvCiyEN+PbpOsrHccaNC7adHA=;
        b=JqWaYAyxvtpdSD2i8X04y+JWhBfv/vVyiVOpJ7rmrTq+X7hu3HTgV5mE9nzQCde+l4
         yytOdGOSKWMdIELGEzzymnXNzU12R87kZKDLhVvK7in5cw9SPGjwFylH9R4ydAZfdn7n
         Qd2ZDoXLjHp4OMLi02Uvn1kcYUdrguIWf+8+gVwrSccZzhzDNrggp+uXFOHcRHAfEzr/
         5N6BQuQw3zBkETxo8U5dTLdgEsTylGCT/hrkvKL1syeUTKNAIdJhHT6fMbFDbsHe9LBu
         5Kb2be6VIWOAmsXzCka8yP1n4SQBkKFMFcHg1RPWe8Tr9vcWplbF35YT6GRzrDiaV3SE
         P6Ag==
X-Gm-Message-State: AOJu0YxxBGdQI4/em0MwAiFcr9iBP7vY0rTuwh3QeJXjlHrJ7eGVfXT8
	kNqeB5h5kfcOEmy6j8Xbr+kocJMqSoD/J1wKFY5DrjIl4aBd/ACwDrxvU+IB2cXt94FbE1kKVeF
	PGv0NDJiFXjMGFjjeLE1YGwldcmG/zziQ8zZiCH4BwZcaHc1/SnIcHr7kvuckHE86WJvtaBV56+
	1zClhhoY078JUEWU0kCAY+NPriiQVBMn0ASL5r6G0=
X-Google-Smtp-Source: AGHT+IFmy1YTowhvs/+EAbR+TFOi/+Yi+zhfjcATuh4JTy1914fyAxGt61z2R+1LGAydSrWBA0BsnKS9eQnW4Q==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:9ba9:7ac3:74ce:2b8f])
 (user=steadmon job=sendgmr) by 2002:a81:ce01:0:b0:648:afcb:a7ce with SMTP id
 00721157ae682-6c6249e2673mr48837b3.3.1724363871430; Thu, 22 Aug 2024 14:57:51
 -0700 (PDT)
Date: Thu, 22 Aug 2024 14:57:45 -0700
In-Reply-To: <cover.1724363615.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723747832.git.steadmon@google.com> <cover.1724363615.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <de27f45401f32bc43de2db42384b2dfa5c651b25.1724363615.git.steadmon@google.com>
Subject: [PATCH v2 1/3] trace2: implement trace2_printf() for event target
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

The trace2 event target does not have an implementation for
trace2_printf(). While the event target is for structured events, and
trace2_printf() is for unstructured, human-readable messages, it may
still be useful to wrap these unstructured messages in a structured JSON
object. Among other things, it may reduce confusion when manually
debugging using event trace data.

Add a simple implementation for the event target that wraps
trace2_printf() messages in a minimal JSON object. Document this in
Documentation/technical/api-trace2.txt, and bump the event format
version since we're adding a new event type.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 17 +++++++++++++++--
 trace2/tr2_tgt_event.c                 | 22 ++++++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index de5fc25059..5817b18310 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -128,7 +128,7 @@ yields
 
 ------------
 $ cat ~/log.event
-{"event":"version","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"3","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"version","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"4","exe":"2.20.1.155.g426c96fcdb"}
 {"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
 {"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
 {"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
@@ -344,7 +344,7 @@ only present on the "start" and "atexit" events.
 {
 	"event":"version",
 	...
-	"evt":"3",		       # EVENT format version
+	"evt":"4",		       # EVENT format version
 	"exe":"2.20.1.155.g426c96fcdb" # git version
 }
 ------------
@@ -835,6 +835,19 @@ The "value" field may be an integer or a string.
 }
 ------------
 
+`"printf"`::
+	This event logs a human-readable message with no particular formatting
+	guidelines.
++
+------------
+{
+	"event":"printf",
+	...
+	"t_abs":0.015905,      # elapsed time in seconds
+	"msg":"Hello world"    # optional
+}
+------------
+
 
 == Example Trace2 API Usage
 
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 59910a1a4f..45b0850a5e 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -24,7 +24,7 @@ static struct tr2_dst tr2dst_event = {
  * a new field to an existing event, do not require an increment to the EVENT
  * format version.
  */
-#define TR2_EVENT_VERSION "3"
+#define TR2_EVENT_VERSION "4"
 
 /*
  * Region nesting limit for messages written to the event target.
@@ -622,6 +622,24 @@ static void fn_data_json_fl(const char *file, int line,
 	}
 }
 
+static void fn_printf_va_fl(const char *file, int line,
+			    uint64_t us_elapsed_absolute,
+			    const char *fmt, va_list ap)
+{
+	const char *event_name = "printf";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_abs = (double)us_elapsed_absolute / 1000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_double(&jw, "t_abs", 6, t_abs);
+	maybe_add_string_va(&jw, "msg", fmt, ap);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 static void fn_timer(const struct tr2_timer_metadata *meta,
 		     const struct tr2_timer *timer,
 		     int is_final_data)
@@ -694,7 +712,7 @@ struct tr2_tgt tr2_tgt_event = {
 	.pfn_region_leave_printf_va_fl = fn_region_leave_printf_va_fl,
 	.pfn_data_fl = fn_data_fl,
 	.pfn_data_json_fl = fn_data_json_fl,
-	.pfn_printf_va_fl = NULL,
+	.pfn_printf_va_fl = fn_printf_va_fl,
 	.pfn_timer = fn_timer,
 	.pfn_counter = fn_counter,
 };
-- 
2.46.0.295.g3b9ea8a38a-goog

