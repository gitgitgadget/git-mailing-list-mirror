Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6D71FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbcFYFYe (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35388 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbcFYFYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id w130so23688270lfd.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZRG+Dxj5GmWrKGlUo6WrdqQyhK7HfbEJiOVpPGz2bk=;
        b=a61VRcXnuL6XSkWsd8FRMiIZKYx6WcEDfgrTkcHyuPwAqSVlgP7EaHEHMV/8EkGdNm
         EhN4sx++1RpaNQimg6RxYrmk3Ct9ZmBqwhSG0QRI6L5Szbd5Wn5UgeflXwxamkHhL7o3
         sbFo/aT4h+WEkRKdSAg4NQCOqDwNtBn4wcED/wapyE/URK6DrQmPEe1/Wi1d1cC+lAZ2
         WIjGXoA63VT33yJYKD4yRBVbXJkRNR9WVHCV2QIpjk7+VKBDqksn8UGWsVg7Xjqhk/dG
         WG0A66J50KBxplPOuX2hdma+qAB5jaRU+dRaAWd+ZxKIIPaDzovkZjZQFXg41SWUWXi7
         1w4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZRG+Dxj5GmWrKGlUo6WrdqQyhK7HfbEJiOVpPGz2bk=;
        b=Y8hYrccQm+ndHKBl7nRV6FIrGKFo+rXKbRCJc6FIvWkH4YZiIo+9vejx1mE8KNeM4M
         zzjtt3b7KgQ1YbHFL32N4Ptgi5yHjUfUP7PtqHGcuI69b6KJAJvK6iZv+pe0E1rwOoBK
         EUq3FARMfn1jmaxQUx2T7Ekad2xNODnYRUrXUXvSK63/3FLDpNjn/XM7U/ssHiUh5n0n
         hEPGyE5H0O7gYs+V+hOMrMv3bksSbkJ285Me4Zh1NQcgwVgNQx4B6alHQdHxivwNVB2g
         dhIpG9IF/cF1m5abDnS3NILBCnxDl1GqyO19nYO/bpfyEs5ktYsi11UE4/R06ctpmMSD
         wx6Q==
X-Gm-Message-State: ALyK8tIR4SjyWqdrWxuIQ8URoOsYD3/YQZXUUFCXn2gUaO4bPLTA7EHTirHzPjHt0t4rcg==
X-Received: by 10.25.3.12 with SMTP id 12mr2005783lfd.110.1466832255597;
        Fri, 24 Jun 2016 22:24:15 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:14 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/12] diffcore-pickaxe: support case insensitive match on non-ascii
Date:	Sat, 25 Jun 2016 07:22:37 +0200
Message-Id: <20160625052238.13615-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to the "grep -F -i" case, we can't use kws on icase search
outside ascii range, so we quote the string and pass it to regcomp as
a basic regexp and let regex engine deal with case sensitivity.

The new test is put in t7812 instead of t4209-log-pickaxe because
lib-gettext.sh might cause problems elsewhere, probably.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diffcore-pickaxe.c              | 11 +++++++++++
 t/t7812-grep-icase-non-ascii.sh |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 2093b6a..55067ca 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -7,6 +7,8 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
+#include "commit.h"
+#include "quote.h"
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
@@ -223,6 +225,15 @@ void diffcore_pickaxe(struct diff_options *o)
 			cflags |= REG_ICASE;
 		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
+	} else if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE) &&
+		   has_non_ascii(needle)) {
+		struct strbuf sb = STRBUF_INIT;
+		int cflags = REG_NEWLINE | REG_ICASE;
+
+		basic_regex_quote_buf(&sb, needle);
+		regcomp_or_die(&regex, sb.buf, cflags);
+		strbuf_release(&sb);
+		regexp = &regex;
 	} else {
 		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
 			       ? tolower_trans_tbl : NULL);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 08ae4c9..169fd8d 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -61,4 +61,11 @@ test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
 	test_cmp expect2 debug2
 '
 
+test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
+	git commit -m first &&
+	git log --format=%f -i -S"TILRAUN: HALLÓ HEIMUR!" >actual &&
+	echo first >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.2.526.g02eed6d

