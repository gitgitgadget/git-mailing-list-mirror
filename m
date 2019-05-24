Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEA81F462
	for <e@80x24.org>; Fri, 24 May 2019 09:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbfEXJgj (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:36:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45663 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389881AbfEXJgi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:36:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so4987729pfm.12
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rx+KAZewP7QhWcnC6uZ4qWDfncYVmhHvtg8fxTLiC+g=;
        b=evlbQOR4vJ4crfu7zY24Ol+5HINS7+9Ru0MYmb3wMtrFznhnEEhRbgnLTR9WYQ1Uf1
         kncOFpUhRFTSoViEvuA5sVVO1/uy5v05Y8Twv0oiEEg7h1f6kxeTMJM9YAmQ5uJK0bSC
         OXB/xzjOvdeSh+nDYBWLywze7tA7j2HK3EQQNBK4yuZWwuOQ3WCDpslTKI5z/PLsHyQz
         +CxXe1KXYs0dbNNNC78fDv0fhFLeVuDcB++vT5ZIBC//bVDhMxjC9jDyYqtpNlAqFbMv
         KIsOg7vinBO+FkvtTNF+JlLnLPjZ9gcfEFHqeiEWKXCCARL6bpDn1qddILv3TK62xGS5
         osWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rx+KAZewP7QhWcnC6uZ4qWDfncYVmhHvtg8fxTLiC+g=;
        b=aXXZBMs0BaI8XDLACTUgxn3NmyZbBDZEfuCj48IQ05LaPPz3BByCtPZv3c0LRGJQC3
         X9OM48zIabUrTu/ggDQADVrulwDxYNdjAHxpo0c9L9uqOI6Ottag3OZsFks8ckT1LkAf
         IlTlf0nwCbmJ+sXKkW0rZRiV4/5AG3c5CG9bwNH7IsqkaxlFeXsJTPHagraT3usYwcMG
         ob9dPeg2p04DVcaEy7HdSNaH+JKVqy0DHY2xpCJorw8qGFXXAibiWG8/9t18M67K5xsr
         5wEXYA2jDowhWuQj35WZ8N9/+otaKZ2LEAk5sDGbCzcocoLarsKWQbZ6WlvTXakrCxUe
         +W8w==
X-Gm-Message-State: APjAAAUDOm49ZkAf4hbka/Yy9dWeJQyJNvBvowL1IIgK6ElL4J2yjGwe
        MpvdXMFOoTVtnCi04vPIeOc=
X-Google-Smtp-Source: APXvYqzkmKkmPoJxuovoVMUD7wIw6xaKdcYo797T7K/FvkkqgWmhsvh//99kM2uo5iFCy4KKPBS8wA==
X-Received: by 2002:a65:56c3:: with SMTP id w3mr10428175pgs.232.1558690597232;
        Fri, 24 May 2019 02:36:37 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id 85sm1923195pgb.52.2019.05.24.02.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:36:36 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 24 May 2019 16:36:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, bturner@atlassian.com, git@vger.kernel.org,
        gitster@pobox.com, tmz@pobox.com
Subject: [PATCH 4/3] parse-options: make compiler check value type mismatch
Date:   Fri, 24 May 2019 16:36:11 +0700
Message-Id: <20190524093611.1165-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190524092442.701-1-pclouds@gmail.com>
References: <20190524092442.701-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a disconnect between the actual value type from parse-options
user and the parser itself. This is because we have to store 'value'
pointer as 'void *' and the compiler cannot help point out that the user
is passing a 'long' while the parser expects an 'int'. This could lead
to memory corruption.

In order to spot these type mismatch problems, a dummy inline function
is used to process the 'value' input with the right type, before the
input is stored in 'struct option'. This gives the compiler some context
to start complaining.

The catch though, is that we can only call a function in variable
declaration if it's in automatic scope. Global and static 'struct
option' variables will fail to build after this. But I think this is an
reasonable price to pay, compared to memory corruption.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 For the record, this is what I used to make patch 1/3 (I don't think I
 could just rely on manual code inspection to catch these problems)

 If we are doing something like this, then we have some clean up to do
 first. I think it's worth doing though. But maybe there's a better way?

 parse-options.h | 50 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index ac6ba8abf9..b6ea0ac66d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -128,55 +128,67 @@ struct option {
 	intptr_t extra;
 };
 
-#define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
+#define DEFINE_OPT_TYPE_CHECK(name, type)  \
+	static inline void *_opt_ ## name(type *p)	\
+	{						\
+		return p;				\
+	}
+
+DEFINE_OPT_TYPE_CHECK(int, int)
+DEFINE_OPT_TYPE_CHECK(ulong, unsigned long)
+DEFINE_OPT_TYPE_CHECK(string, const char *)
+DEFINE_OPT_TYPE_CHECK(string_list, struct string_list)
+DEFINE_OPT_TYPE_CHECK(timestamp, timestamp_t)
+
+#define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), _opt_int(v), NULL, (h), \
 				      PARSE_OPT_NOARG|(f), NULL, (b) }
-#define OPT_COUNTUP_F(s, l, v, h, f) { OPTION_COUNTUP, (s), (l), (v), NULL, \
+#define OPT_COUNTUP_F(s, l, v, h, f) { OPTION_COUNTUP, (s), (l), _opt_int(v), NULL, \
 				       (h), PARSE_OPT_NOARG|(f) }
-#define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), (v), NULL, \
+#define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), _opt_int(v), NULL, \
 					  (h), PARSE_OPT_NOARG | (f), NULL, (i) }
 #define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
 #define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
-#define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (l), (v), (a), (h), (f) }
-#define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h), (f) }
+#define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (l), _opt_string(v), (a), (h), (f) }
+#define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (l), _opt_int(v), N_("n"), (h), (f) }
 
 #define OPT_END()                   { OPTION_END }
-#define OPT_ARGUMENT(l, v, h)       { OPTION_ARGUMENT, 0, (l), (v), NULL, \
+#define OPT_ARGUMENT(l, v, h)       { OPTION_ARGUMENT, 0, (l), _opt_int(v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, 1 }
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
-#define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
+#define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), _opt_int(v), NULL, (h), \
 					    PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, \
 					    (set), NULL, (clear) }
-#define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
+#define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), _opt_int(v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
 #define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
 #define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
-#define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
+#define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), _opt_int(v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
-#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
+#define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), _opt_int(v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
-#define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
+#define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), _opt_ulong(v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
 #define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
 #define OPT_STRING_LIST(s, l, v, a, h) \
-				    { OPTION_CALLBACK, (s), (l), (v), (a), \
+				    { OPTION_CALLBACK, (s), (l), _opt_string_list(v), (a), \
 				      (h), 0, &parse_opt_string_list }
-#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
+#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), _opt_int(v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
+	{ OPTION_CALLBACK, (s), (l), _opt_timestamp(v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) OPT_CALLBACK_F(s, l, v, a, h, 0, f)
 #define OPT_NUMBER_CALLBACK(v, h, f) \
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
-#define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
+#define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), _opt_string(v), \
 				       N_("file"), (h) }
 #define OPT_COLOR_FLAG(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("when"), (h), PARSE_OPT_OPTARG, \
+	{ OPTION_CALLBACK, (s), (l), _opt_int(v), N_("when"), (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
 
 #define OPT_NOOP_NOARG(s, l) \
@@ -301,14 +313,14 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
-	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose"), \
+	{ OPTION_CALLBACK, 'v', "verbose", _opt_int(var), NULL, N_("be more verbose"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
-	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
+	{ OPTION_CALLBACK, 'q', "quiet", _opt_int(var), NULL, N_("be more quiet"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
 #define OPT__FORCE(var, h, f) OPT_COUNTUP_F('f', "force",   (var), (h), (f))
 #define OPT__ABBREV(var)  \
-	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
+	{ OPTION_CALLBACK, 0, "abbrev", _opt_int(var), N_("n"),	\
 	  N_("use <n> digits to display SHA-1s"),	\
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 #define OPT__COLOR(var, h) \
-- 
2.22.0.rc0.322.g2b0371e29a

