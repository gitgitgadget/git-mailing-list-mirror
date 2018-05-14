Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6C61F406
	for <e@80x24.org>; Mon, 14 May 2018 21:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeENV4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:56:52 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:32800 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeENV4r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:47 -0400
Received: by mail-yw0-f202.google.com with SMTP id z195-v6so5830724ywa.0
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=k7XaI9qakJBGqD4qv+gsHGNavDBjWTq9IzMh9TZSSUg=;
        b=Oe4bYS3iIQ8Hz8vaDgZVfGxH1WtKC3YzzLlFHEc5xPvYFP/EfILdw6fG2iOLITm9lK
         rumrbgVQsJY5G84rNnBN9577sGvQENaRILHLh7N7F4oia5vxj7mDM79YUYL/nC/hZsBA
         Hph0QJHTRKMLWg8GkSWcO2nG88onIr1NWSB/1IO0y/gHCst6MDYV2W1kSx3rbSieG5z7
         njEchxW1QmGOKeOF2KfotCDpxwuMAmpjemtP85bRwcn4dnCL2kGKgQrfLr91AUntX1Nn
         PB2lGdyHgeANsLbH/c4T8edCCMBXgN1zoh3qO1Ql4m2TS+sFmT2dZ0DBt2LSPne8J4XJ
         XHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=k7XaI9qakJBGqD4qv+gsHGNavDBjWTq9IzMh9TZSSUg=;
        b=LAV/gNCaIeiwsc8lVwLjy7ZEHOuYsXAtkb5wr7WE8pTeOCN8lKd9Np4nPX33/zsi+M
         /+lnJEKg2KpOoHk+ZiJjlv/Nxuol6PVYeGMZtQnobP8B4LQ+Bf/3uXz0EKM5Dil5oQIw
         zSmm4oKthjko/S5Rtyhv2kcTCunvaoqXAbWCGoP4w/F0FA6oaptCSVCufqxKLF/b9UcI
         79JH6nM/UP/JQHaF7B7/NUfqG7ecempXuu5Z705WoexeldKIUOWs36jUR77wQuLW6hzo
         4116mbOL8x9g5twdNGuORFsK5CwHoNBZXViaJoLiNSDntO4zx2AJ6QTz+0N6BakxrlXV
         TnLA==
X-Gm-Message-State: ALKqPwfHDRHYAB05fax+ztZXs5iyXwIgS7WoG8RjCNLCkao5wx4OVmQw
        juybPPUGTWNly9PerKAXsYrOXUDYJkwZBfaRgjnD/Y/7JfQI8zQNTGW1xjD3lMADuKAJr9rA/GJ
        aH1I0uxuMReYjYv98832+mFTIyRfHrsTbB0H4WUIIEDSXf/NK+i3TorE4iA==
X-Google-Smtp-Source: AB8JxZppPImLxUG7BYoL2t2iIBDEdmdkCs9Ci0dvwjs2l96uxv3PV1Z7ND7okISoihJktNefN/Y8tWAU2Lw=
MIME-Version: 1.0
X-Received: by 2002:a81:b142:: with SMTP id p63-v6mr3653703ywh.8.1526335006734;
 Mon, 14 May 2018 14:56:46 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:55 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-5-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 04/35] refspec: introduce struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce 'struct refspec', an abstraction around a collection of
'struct refspec_item's much like how 'struct pathspec' holds a
collection of 'struct pathspec_item's.

A refspec struct also contains an array of the original refspec strings
which will be used to facilitate the migration to using this new
abstraction throughout the code base.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 refspec.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 refspec.h | 25 ++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/refspec.c b/refspec.c
index cef513ad8..2b898c922 100644
--- a/refspec.c
+++ b/refspec.c
@@ -178,3 +178,67 @@ void free_refspec(int nr_refspec, struct refspec_item *refspec)
 	}
 	free(refspec);
 }
+
+void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
+{
+	memset(item, 0, sizeof(*item));
+
+	if (!parse_refspec(item, refspec, fetch))
+		die("Invalid refspec '%s'", refspec);
+}
+
+void refspec_item_clear(struct refspec_item *item)
+{
+	FREE_AND_NULL(item->src);
+	FREE_AND_NULL(item->dst);
+	item->force = 0;
+	item->pattern = 0;
+	item->matching = 0;
+	item->exact_sha1 = 0;
+}
+
+void refspec_init(struct refspec *rs, int fetch)
+{
+	memset(rs, 0, sizeof(*rs));
+	rs->fetch = fetch;
+}
+
+void refspec_append(struct refspec *rs, const char *refspec)
+{
+	struct refspec_item item;
+
+	refspec_item_init(&item, refspec, rs->fetch);
+
+	ALLOC_GROW(rs->items, rs->nr + 1, rs->alloc);
+	rs->items[rs->nr++] = item;
+
+	ALLOC_GROW(rs->raw, rs->raw_nr + 1, rs->raw_alloc);
+	rs->raw[rs->raw_nr++] = xstrdup(refspec);
+}
+
+void refspec_appendn(struct refspec *rs, const char **refspecs, int nr)
+{
+	int i;
+	for (i = 0; i < nr; i++)
+		refspec_append(rs, refspecs[i]);
+}
+
+void refspec_clear(struct refspec *rs)
+{
+	int i;
+
+	for (i = 0; i < rs->nr; i++)
+		refspec_item_clear(&rs->items[i]);
+
+	FREE_AND_NULL(rs->items);
+	rs->alloc = 0;
+	rs->nr = 0;
+
+	for (i = 0; i < rs->raw_nr; i++)
+		free((char *)rs->raw[i]);
+	FREE_AND_NULL(rs->raw);
+	rs->raw_alloc = 0;
+	rs->raw_nr = 0;
+
+	rs->fetch = 0;
+}
diff --git a/refspec.h b/refspec.h
index 173cea882..f6fb251f3 100644
--- a/refspec.h
+++ b/refspec.h
@@ -20,4 +20,29 @@ struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
 
 void free_refspec(int nr_refspec, struct refspec_item *refspec);
 
+#define REFSPEC_FETCH 1
+#define REFSPEC_PUSH 0
+
+#define REFSPEC_INIT_FETCH { .fetch = REFSPEC_FETCH }
+#define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
+
+struct refspec {
+	struct refspec_item *items;
+	int alloc;
+	int nr;
+
+	const char **raw;
+	int raw_alloc;
+	int raw_nr;
+
+	int fetch;
+};
+
+void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch);
+void refspec_item_clear(struct refspec_item *item);
+void refspec_init(struct refspec *rs, int fetch);
+void refspec_append(struct refspec *rs, const char *refspec);
+void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
+void refspec_clear(struct refspec *rs);
+
 #endif /* REFSPEC_H */
-- 
2.17.0.441.gb46fe60e1d-goog

