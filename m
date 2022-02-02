Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A16C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347422AbiBBVEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347354AbiBBVEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:04:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DBC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:04:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m13-20020a05600c3b0d00b00353951c3f62so415250wms.5
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dn/936N5fKmid+902qDNJxi9qCu8Y4nSplpjGhuvx6E=;
        b=DelVKSH1gAB9rCfa6D4uUFve6/3jazP8YW7lGZbkAdBy/vK9ESbrSPBttn1BaSjPtF
         Yk32LHTBqgAXjw2sgIcPMJz2wsoWXf1RM7NXgw3xQzDKA1VEr/dH78Ya/2ulvpLqo4Mg
         8oJizKmAdt+luwVmBXT5M6qEEhtGr+xC4/KuSst7fUr0SGz9p9RuJVjlD4JhommTsY9s
         lf09KH9YAd46sd+PF+Z1dEspTbF0e9JY3tHnu4iz//wO7IS/n5CiEFyUgKRBTqrz+qZp
         Nc+X2cIE3TJ3U0pgCTm+p8/rJzKAPcrDwoOQZ4Q0z50+w5JARDFIN0QOjr8PkVmFk1J0
         hcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dn/936N5fKmid+902qDNJxi9qCu8Y4nSplpjGhuvx6E=;
        b=u3hwdzjzgASntz6p73GeS4sQ+U16zasDWitG6RZTfFeZO+tMw0YqUhJQLVKH+FVHmy
         IgyAEZ4R9KEU34QUPYCM9AMccrk7ARS0F9goq2XU2OG39Rj9vJwG3+bsQUcrraVe7d/J
         G/cjo6NIZfxlZ2EOQ4kx85h0Cp5Kn8GxPLXsOWkGW0Kpz/1ifO397m6WFbllgdJroWwd
         y+5aglLiSTipHZhFv0pZ1x3lQXjJWDcgUEYjKOGObz21+xMed41GiBAYfvrYGoKfYVtn
         xpgPtT1SWfG/vTsYQB/TzyepdaW/EO0lZz3xaS7ZLkj/3Qdseon15G3wm93uVP+w7IbM
         J4Ig==
X-Gm-Message-State: AOAM530tMTXWKG1p7aJodQYqO2gk7rOUfX162Isz8DsNhMc9ZURyG6Hi
        Zd/vG8/b28Ppo8u4Spjazrv5QTp/b/M7xw==
X-Google-Smtp-Source: ABdhPJzIcpCJILKkd1QsYIcYZu9TLiJORE08N7Xm7gRBdLov9Hhdw8L3/4r2XFKmvObJ5s8ln0sOUA==
X-Received: by 2002:a05:600c:4f84:: with SMTP id n4mr7813770wmq.106.1643835847256;
        Wed, 02 Feb 2022 13:04:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm17264592wry.50.2022.02.02.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:04:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] date API: add basic API docs
Date:   Wed,  2 Feb 2022 22:03:52 +0100
Message-Id: <patch-4.5-aab2ae9cc72-20220202T195651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.920.g34be1f84792
In-Reply-To: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net> <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add basic API doc comments to date.h, and while doing so move the the
parse_date_format() function adjacent to show_date(). This way all the
"struct date_mode" functions are grouped together. Documenting the
rest is one of our #leftoverbits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 date.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/date.h b/date.h
index c3a00d08ed6..4ed83506de9 100644
--- a/date.h
+++ b/date.h
@@ -1,6 +1,12 @@
 #ifndef DATE_H
 #define DATE_H
 
+/**
+ * The date mode type. This has DATE_NORMAL at an explicit "= 0" to
+ * accommodate a memset([...], 0, [...]) initialization when "struct
+ * date_mode" is used as an embedded struct member, as in the case of
+ * e.g. "struct pretty_print_context" and "struct rev_info".
+ */
 enum date_mode_type {
 	DATE_NORMAL = 0,
 	DATE_HUMAN,
@@ -24,7 +30,7 @@ struct date_mode {
 	.type = DATE_NORMAL, \
 }
 
-/*
+/**
  * Convenience helper for passing a constant type, like:
  *
  *   show_date(t, tz, DATE_MODE(NORMAL));
@@ -32,7 +38,21 @@ struct date_mode {
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
+/**
+ * Show the date given an initialized "struct date_mode" (usually from
+ * the DATE_MODE() macro).
+ */
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
+
+/**
+ * Parse a date format for later use with show_date().
+ *
+ * When the "date_mode_type" is DATE_STRFTIME the "strftime_fmt"
+ * member of "struct date_mode" will be a malloc()'d format string to
+ * be used with strbuf_addftime().
+ */
+void parse_date_format(const char *format, struct date_mode *mode);
+
 void show_date_relative(timestamp_t time, struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
@@ -41,7 +61,6 @@ void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
 timestamp_t approxidate_careful(const char *, int *);
 timestamp_t approxidate_relative(const char *date);
-void parse_date_format(const char *format, struct date_mode *mode);
 int date_overflows(timestamp_t date);
 time_t tm_to_time_t(const struct tm *tm);
 #endif
-- 
2.35.0.913.g12b4baa2536

