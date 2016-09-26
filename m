Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A5E207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbcIZWm4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:42:56 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36230 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbcIZWmw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:42:52 -0400
Received: by mail-qk0-f195.google.com with SMTP id m184so4646558qkb.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8cZ1EX+gapOJ5v9UCJkT8CWzvgVWzN0zi3nQxOMet3Y=;
        b=fw76p/iWg30W57EjgXy++GiEk0tfqzCH5sYd+7mR14WQ2qL0J/hK7JWmClzCv1QYjr
         MGOcqn6l2RZjf+W91zoYs/SjISA0dq25f2+jg1oLxkGFfSXqP+7yAUztwwAs5zBS0Sa7
         pcVlfdo7wjvhgNIXoxdhOownNbXDzRUiQ2+7L5DVM8ucj6c2SQ8EJCzlTUGnEvdg9SNR
         0ExZh2YqPH/oTAbCamjxSD6oK7QIkgaci+WVOJvXex07PWeC0FxhdsdFB5Rx6pRkLl4w
         4eWkU4pW4qPPuCXE/nNkfI+8PY3N/nSxIU77/vJifDz7H6G/WQYweRZJYq0B0DY6zl8s
         mroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8cZ1EX+gapOJ5v9UCJkT8CWzvgVWzN0zi3nQxOMet3Y=;
        b=TjV/K+1dnXyD5LEqGF0xD/5w63wCZzm1YyalChGkEeei2mLS9h49VxhMTkCZe0XtMy
         j8edtFkwk6bXADWEzSAsFjR3mrPgH8IYgfvXJujuZUHYq9jjG1JbAsAI6VkBdAsZwUE6
         izxQeqZbuzqaaLFuFAHuO/tAHpvqmla74unQJwwKZRDhQlrCf1dCcpcq7t3j1k35pC3k
         o3sSMQ+TkXOKhpYDkyiNXNg1fNAc2pDEofj3d4QIMv+SHCBDCmZAcLVPySJdUnynHbeY
         ZShrw/9evSEoCo5by2lEwAmKHvFqJR2l5ojbd/q/Fg55sEqfsveNgNvSa280Ba+duaMH
         f3Bw==
X-Gm-Message-State: AA6/9Rn/B4sXyT318A+anZgtx52UvA5TgzQ+WbxJMbiCg4iUYeuaHaum7kCAzmUV4SxXZYAA
X-Received: by 10.55.71.198 with SMTP id u189mr25969725qka.251.1474929771255;
        Mon, 26 Sep 2016 15:42:51 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id 62sm12840092qtg.14.2016.09.26.15.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:42:50 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: [PATCH v2 2/5] ref-filter: add function to print single ref_array_item
Date:   Mon, 26 Sep 2016 18:42:30 -0400
Message-Id: <20160926224233.32702-3-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160926224233.32702-1-santiago@nyu.edu>
References: <20160926224233.32702-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

ref-filter functions are useful for printing git object information
using a format specifier. However, some other modules may not want to use
this functionality on a ref-array but only print a single item.

Expose a format_ref function to create, pretty print and free individual
ref-items.

Signed-off-by: Lukas P <luk.puehringer@gmail.com>
---
 ref-filter.c | 10 ++++++++++
 ref-filter.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index bc551a7..e0aaf5f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1655,6 +1655,16 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	putchar('\n');
 }
 
+void format_ref(const char *name, const unsigned char *sha1, const char *format,
+		unsigned kind)
+{
+	struct ref_array_item *ref_item;
+	ref_item = new_ref_array_item(name, sha1, 0);
+	ref_item->kind = kind;
+	show_ref_array_item(ref_item, format, 0);
+	free_array_item(ref_item);
+}
+
 /*  If no sorting option is given, use refname to sort as default */
 struct ref_sorting *ref_default_sorting(void)
 {
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e..1ef7999 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -107,4 +107,8 @@ struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
+/* Pretty-print a single ref */
+void format_ref(const char *name, const unsigned char *sha1, const char *format,
+		unsigned kind);
+
 #endif /*  REF_FILTER_H  */
-- 
2.10.0

