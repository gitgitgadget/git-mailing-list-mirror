Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581411F404
	for <e@80x24.org>; Mon, 10 Sep 2018 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeIKCyn (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 22:54:43 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:51563 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKCyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 22:54:43 -0400
Received: by mail-yb1-f202.google.com with SMTP id 1-v6so10790545ybe.18
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U9DPIcYrXKEqkhCDeZZkhjFQcDZNBa9WLq5Oah2PLVg=;
        b=L/kV3TbjNz6D7etNVeUyvr4eJfnTh7/ApSRFHotc/SoUeiWakMpklWH9s+ik66u2Is
         sUjYz5CsPcbWuaqMeBS92rDgc91P//DOQ9jyYKZDl1tre5oX5Y5JRSZVtLrrnQG4m+zW
         DQXDvNmcTySWR0dFXcTuN8/S4Hmh4TmbrkTyyAkm1QP6SIFhTn77Wfsr/EWqtLYk+4sX
         shHnP52tX4/ca9hCqDLqWMWvV3iGdF7mn66YMd7yj1FHeyi9tN8KupRIkZCey4V0fxVV
         IgC3dG04TDNtS1IKq9c3bxoslVJ9w2dAp4tnUt3kmTYuKMjtU86O7dYMxVX7Rz5kW5HX
         Qwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U9DPIcYrXKEqkhCDeZZkhjFQcDZNBa9WLq5Oah2PLVg=;
        b=TJ0ZiNSav4sfrJrg4WuzCoK5pxbEpCo9veLLh15bsSRdY9uSL/27o4G1Vkny3B2rFN
         yzacl/fGIN0EITbr/tpvQ7TNyz70rEC6iHpQssol0W7pX4+7b3k59UhmaRigv+epNRc2
         MdCIGIMIi1D48Pe6X3d32wNfZ5B/Lhz7NY0L7aLXwBjywjT6UukHRfKJ9olYOJLa4oVR
         lAHqhmlvMqrdv6uQXz6c8qVmfoWev1burC3491maf3it4r2LiU5m/h1msFuUFN8ni/eZ
         icbCm9HcSnRIQCxzsro9NrM5XH5fb6NCQNhVD9Lwm9Cyei+gf7zxGoK73Ddtupp23HJC
         LCXA==
X-Gm-Message-State: APzg51DFRtE5QfgERKr+EPVmsXOSZo5GafwGF9YPS9bC5O+luWTF8Vhh
        KrEvy72gaaJmWu5rszXijvd1+2QCbPh3
X-Google-Smtp-Source: ANB0VdZjHpzPDYEZLHTTtc7bkElgf3v6jpFOvZeD3ryZIZFxtZ1KTQsydenGeuLzXmu9yWRF6AoifZ5/EWUA
X-Received: by 2002:a81:1393:: with SMTP id 141-v6mr5353741ywt.209.1536616716484;
 Mon, 10 Sep 2018 14:58:36 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:58:30 -0700
In-Reply-To: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
Message-Id: <20180910215831.17608-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH 1/2] trace: add trace_print_string_list_key
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to trace_strbuf or trace_argv_printf, we might want to output
a string list in tracing. Add such a function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

I separated this from the other series, making it into 2 patches:
This first patch adds tracing for string lists and the next patch that
removes the unused function from the string list API.
That way we can decide on these two patches separately if needed.

 Documentation/technical/api-trace.txt |  8 ++++++
 trace.c                               | 39 +++++++++++++++++++++++++++
 trace.h                               | 16 +++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/technical/api-trace.txt b/Documentation/technical/api-trace.txt
index fadb5979c48..ad0ea99d930 100644
--- a/Documentation/technical/api-trace.txt
+++ b/Documentation/technical/api-trace.txt
@@ -62,6 +62,14 @@ Functions
 	Prints the strbuf, without additional formatting (i.e. doesn't
 	choke on `%` or even `\0`).
 
+`void trace_print_string_list_key(struct trace_key *key, const struct string_list *p, const char *text)::
+
+	Print the string-pointer pairs of the string_list,
+	each one in its own line.
+	It takes an optional key and header argument.
+	If the tracing key is not given, use the default key.
+	The header text is printed before the list itself.
+
 `uint64_t getnanotime(void)`::
 
 	Returns nanoseconds since the epoch (01/01/1970), typically used
diff --git a/trace.c b/trace.c
index fc623e91fdd..e3a12a092f9 100644
--- a/trace.c
+++ b/trace.c
@@ -176,6 +176,38 @@ void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 	strbuf_release(&buf);
 }
 
+void trace_print_string_list_key_fl(const char *file, int line,
+				    struct trace_key *key,
+				    const struct string_list *p,
+				    const char *text)
+{
+	int i, buf_prefix;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!key)
+		key = &trace_default_key;
+
+	if (!prepare_trace_line(file, line, key, &buf))
+		return;
+
+	buf_prefix = buf.len;
+
+	if (text) {
+		strbuf_addstr(&buf, text);
+		print_trace_line(key, &buf);
+	}
+
+	for (i = 0; i < p->nr; i++) {
+		strbuf_setlen(&buf, buf_prefix);
+		strbuf_addf(&buf, "%s:%p\n",
+			    p->items[i].string,
+			    p->items[i].util);
+		print_trace_line(key, &buf);
+	}
+
+	strbuf_release(&buf);
+}
+
 static void trace_performance_vprintf_fl(const char *file, int line,
 					 uint64_t nanos, const char *format,
 					 va_list ap)
@@ -227,6 +259,13 @@ void trace_strbuf(struct trace_key *key, const struct strbuf *data)
 	trace_strbuf_fl(NULL, 0, key, data);
 }
 
+void trace_print_string_list_key(struct trace_key *key,
+				 const struct string_list *p,
+				 const char *text)
+{
+	trace_print_string_list_key_fl(NULL, 0, key, p, list);
+}
+
 void trace_performance(uint64_t nanos, const char *format, ...)
 {
 	va_list ap;
diff --git a/trace.h b/trace.h
index 2b6a1bc17c2..0e083891e1f 100644
--- a/trace.h
+++ b/trace.h
@@ -37,6 +37,10 @@ extern void trace_argv_printf(const char **argv, const char *format, ...);
 
 extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
+extern void trace_print_string_list_key(struct trace_key *key,
+					const struct string_list *p,
+					const char *text);
+
 /* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
 __attribute__((format (printf, 2, 3)))
 extern void trace_performance(uint64_t nanos, const char *format, ...);
@@ -103,6 +107,13 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 			trace_strbuf_fl(TRACE_CONTEXT, __LINE__, key, data);\
 	} while (0)
 
+#define trace_print_string_list_key(key, list, text) 			    \
+	do {								    \
+		if (trace_pass_fl(key))					    \
+			trace_print_string_list_key_fl(TRACE_CONTEXT,	    \
+						       __LINE__, key, data);\
+	} while (0)
+
 #define trace_performance(nanos, ...)					    \
 	do {								    \
 		if (trace_pass_fl(&trace_perf_key))			    \
@@ -127,6 +138,11 @@ extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
 extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 			    const struct strbuf *data);
+extern void trace_print_string_list_key_fl(const char *file, int line,
+					   struct trace_key *key,
+					   const struct string_list *p,
+					   const char *text);
+
 __attribute__((format (printf, 4, 5)))
 extern void trace_performance_fl(const char *file, int line,
 				 uint64_t nanos, const char *fmt, ...);
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

