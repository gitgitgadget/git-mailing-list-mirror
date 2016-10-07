Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC99720986
	for <e@80x24.org>; Fri,  7 Oct 2016 21:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756143AbcJGVIO (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 17:08:14 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34765 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754816AbcJGVIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 17:08:11 -0400
Received: by mail-qk0-f194.google.com with SMTP id n189so3236811qke.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xD/oSj8lsk8tah5/YyWF8aUGlFZ3WJdYLuoIXxfQ4GQ=;
        b=BUTRhf4ExM/znOfi4txhiLFytd6ZRsxEcs/Vy9uDKTmYV1qVlxtlsBTxbOzqW8Olhh
         WjFKnHdOhJj87oExO3qO1yYVjq/vxQKIIp9lO7iYrbc619Tb4gQfhnCrKMad47PPbyra
         QTXXb8CbjXpCiwGJqEXWuXgUkErBZWKCXWw/mST0LjcGBEBEu8tzk5AfQwNIgayqmjaP
         RdfPPoIS/GlEQZLjDEa33oJU9E1A+etaoycHHF4i6bGq3JR15Yu6rmtfOaXeqEO2PBVc
         uduiEdY2N/N+PcqlSueE6n8P9w8j4srl54rw+uYL9cfA9W0Yslr59vNrxBqgfDDvDNyA
         D7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xD/oSj8lsk8tah5/YyWF8aUGlFZ3WJdYLuoIXxfQ4GQ=;
        b=TsysO0MljomxW173VZmAnjxpFB93EJr0LsWPNB790vptjEbWAM477FZ71nXeGlwDgy
         g+lgOsHxyUKAgYvsYMmYk7JIuOUQM0Qg9LS9Vtl8vxMQwGFWxX+adIvhJMyR9I+YPJzT
         ocQjk0Y4dY5sS00S6Zdn1ZyX5L+gTgk+O6MxOmLviVgoOvHr3PC47J0cOsjo/Rmjlsa6
         ioRyFv0+b0Pk55SB1hZiSdohVFpqjNdwIAwuIBzIiSg7GJn7ZdbrJh4msUHleWfzMICo
         VgR0Zh8iP7r7IaCyLbEw8IuolZFRteFp0oXRx6tdj5GskH7qDx5z9Dpen9KD4mzkTpWh
         K7Gg==
X-Gm-Message-State: AA6/9Rmp0ZT3H3UgVkgzpkDDO9vBsM9Ais0TszPEC8GTkBMGW6zUEJw5zjb9Lqq3mjWWg9n8
X-Received: by 10.55.22.15 with SMTP id g15mr21750653qkh.75.1475874449009;
        Fri, 07 Oct 2016 14:07:29 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-05.NATPOOL.NYU.EDU. [216.165.95.76])
        by smtp.gmail.com with ESMTPSA id a192sm7544808qkc.26.2016.10.07.14.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Oct 2016 14:07:28 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v4 2/7] ref-filter: add function to print single ref_array_item
Date:   Fri,  7 Oct 2016 17:07:16 -0400
Message-Id: <20161007210721.20437-3-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161007210721.20437-1-santiago@nyu.edu>
References: <20161007210721.20437-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

ref-filter functions are useful for printing git object information
using a format specifier. However, some other modules may not want to use
this functionality on a ref-array but only print a single item.

Expose a pretty_print_ref function to create, pretty print and free
individual ref-items.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 ref-filter.c | 10 ++++++++++
 ref-filter.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 9adbb8a..cfbcd73 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1637,6 +1637,16 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	putchar('\n');
 }
 
+void pretty_print_ref(const char *name, const unsigned char *sha1,
+		const char *format, unsigned kind)
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
index 14d435e..3d23090 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -107,4 +107,7 @@ struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
+void pretty_print_ref(const char *name, const unsigned char *sha1,
+		const char *format, unsigned kind);
+
 #endif /*  REF_FILTER_H  */
-- 
2.10.0

