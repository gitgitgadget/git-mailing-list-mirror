Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307B71FAED
	for <e@80x24.org>; Tue, 24 Oct 2017 23:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdJXXms (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 19:42:48 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:55232 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdJXXmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 19:42:46 -0400
Received: by mail-io0-f196.google.com with SMTP id e89so25714096ioi.11
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6ulrU82dQRp0udMmOLsjoxVoWwJNfQLUI+duN+XILM=;
        b=Cy6cucqxaE3cxoCwT2yDfykZ9QAvjr0ii4uA0QOCkbrZQNViGeTYbZU7Hj0t6tEgwY
         albWp/WqZI/uHMPcLyiyZQSvxd+ryAbKP5nfgqPN9hQeg2holUXtDmGome4n5r4z3Fn8
         wKNhv+OkyCTwH7+4maHqV+n6uZO+JolGpm/i+7l/QwtAQtphUS7XZwl8WT/KKnwskwJJ
         Z1tl805bgvi5HjC8tae1OlzkArgWGafM/8ET8JtppO0x2EqOhs6lJ9P3rANdpTjxieMe
         o+kcmfqXPg5FX+Shvs/MqSOK8wEzQWCQh8xcMCbGuDfGcRmT31jRpcItx1w4KAbBKtd+
         tg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6ulrU82dQRp0udMmOLsjoxVoWwJNfQLUI+duN+XILM=;
        b=KEyqUNGP7tC+k2p0zgjV2ZGCwf6UHYocm+Z2YzCCce22u3/ifVNUzxEDvFofDr96HX
         ekE6N8CH09HeYrzTjFls7kcdWDsbH1EvHNQnEUW0QtkVJMMKvJMdkmM5J+IBGqqHFEd8
         4/PVwA91Z3NC0vlBkBpAyt2HcXwL8NepI89oNnpK746n5ZHLuBcAD2UmospCCocIshQa
         zC+HB1pKgtTTbkpKI8Z1fKSj74vmF1sgaYvZrAccqiHK7t13jDW5qdo8Qps7WUjPQYyJ
         kX5gucJG2+q+El2dQZ/31ju1NAwAudqSswAihiZJKdszMxJaub/VUxqsWsF/jdRhff3t
         yjyA==
X-Gm-Message-State: AMCzsaU4GowqgvEaHrqSOriQqWsMRZHZAxPG3H5JoYfQ31jLBHPa0oBU
        8pzHW38ttGNwXnqH8X7TFl2DCA==
X-Google-Smtp-Source: ABhQp+THei6yiggUz9qOX14gZsHWiPkHbHHZK01bSiHsWR1Xaxjq2e2iMZuJ9QDuGV5aJDpVGHJFdg==
X-Received: by 10.107.153.18 with SMTP id b18mr22536075ioe.231.1508888566069;
        Tue, 24 Oct 2017 16:42:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id 79sm692990itu.7.2017.10.24.16.42.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 16:42:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        l.s.r@web.de
Subject: [PATCH 1/2] xdiff-interface: export comparing and hashing strings
Date:   Tue, 24 Oct 2017 16:42:33 -0700
Message-Id: <20171024234234.10944-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171024234234.10944-1-sbeller@google.com>
References: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
 <20171024234234.10944-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This will turn out to be useful in a later patch.

xdl_recmatch is exported in xdiff/xutils.h, to be used by various
xdiff/*.c files, but not outside of xdiff/. This one makes it available
to the outside, too.

While at it, add documentation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 xdiff-interface.c | 11 +++++++++++
 xdiff-interface.h | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 018e033089..9b35af2455 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -5,6 +5,7 @@
 #include "xdiff/xdiffi.h"
 #include "xdiff/xemit.h"
 #include "xdiff/xmacros.h"
+#include "xdiff/xutils.h"
 
 struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
@@ -296,6 +297,16 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg)
 	}
 }
 
+unsigned long xdiff_hash_string(const char *s, size_t len, long flags)
+{
+	return xdl_hash_record(&s, s + len, flags);
+}
+
+int xdiff_compare_lines(const char *a, long len_a, const char *b, long len_b, long flags)
+{
+	return xdl_recmatch(a, len_a, b, len_b, flags);
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value, void *cb)
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 6f6ba9095d..6f5abaf8d3 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -29,4 +29,20 @@ extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
 extern int git_xmerge_config(const char *var, const char *value, void *cb);
 extern int git_xmerge_style;
 
+/*
+ * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
+ * Returns 1 if the strings are deemed equal, 0 otherwise.
+ * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
+ * are treated for the comparision.
+ */
+extern int xdiff_compare_lines(const char *a, long len_a,
+			       const char *b, long len_b, long flags);
+
+/*
+ * Returns a hash of the string s of length len.
+ * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
+ * are treated for the hash.
+ */
+extern unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
+
 #endif
-- 
2.15.0.rc2.6.g953226eb5f

