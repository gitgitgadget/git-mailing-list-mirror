Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16ED1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeJQCFM (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:12 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:38230 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:12 -0400
Received: by mail-ot1-f73.google.com with SMTP id g2so5728816otb.5
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+rOFzW5bJHQCIBM022kwARqDlluGnq5Nr5y183LRgpg=;
        b=T1q4kVryPBS+dqxSf8n1QEYB4NIvyUpVab6TEIvg5kD1aJ8gEw84il4zZWzRz6jfs5
         xE2zc2e8CSbRiYzY+VeHalR2jhV5tOE7xHlLOwQtTVwkHxLyDvsgJ69JvOdZ/WYtBkRT
         8u7S4LyJjVqEKBiD84DdprP0sAl3CI2L27qVbUccb1HOniOKb8CzMJLEHJOR9iABcGzG
         wYOWLIf2PVXUhxW1OI+wn36bnk1lJBN8izqrlJW76dWZpCsAc0ezLph9vgxwQdFFtn31
         8mpBdLygbBdkjgNCnapKHLlVMQfAjPsm2QY9JxcQ8WI+tMQchQFZLOhELrUJYH1LSHVU
         KSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+rOFzW5bJHQCIBM022kwARqDlluGnq5Nr5y183LRgpg=;
        b=bne98K241oj8JmXSeFT0Za5GcxMzR02R/7sW7kncdVsxUHcnNUuu1NsE6JTBeB5s4D
         rulfimnbekH1Tck2ayTqIPGB50Hr2kjZl0Jry+0Wky5b/3eyl9mW/j1HNIjNba7IwnTc
         hpM+0i84mNrMzi2CUA9UJX1r8D0fEv3U1QL7jTHI89c702PWJIqW5z17G3T1Y4Sp/Lbf
         2ENhJlDk0siV0gpaCteO8WLYvA6EqIicP/t+sq3isb4pOtIesTHFGN6hF0VWlAqfWWq4
         O/k3LWEyFx546A4yDKTbjbZO2w0U4m5KQWKz0YkQcgz4k41SkMGQw27dh3NZdYHrCHwh
         uKMg==
X-Gm-Message-State: ABuFfojHsTjs9Aclsh4B5QB8R2eXUAkpxJEEU7jtEV8Gah4SiEl8E/Ya
        dXBqMyRi0fw1DSdRn4vOeQWJ/s8HDRE0
X-Google-Smtp-Source: ACcGV62vtyUaxsPQu6fcfwm0x/nJCt66TxuLr4ynO+fpgrpsfJiXeYVL9v8nhQ9HRaCZFuA08C7fstjN3Bm/
X-Received: by 2002:aca:d695:: with SMTP id n143-v6mr19642571oig.23.1539713612842;
 Tue, 16 Oct 2018 11:13:32 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:19 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 1/9] sha1-array: provide oid_array_filter
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/api-oid-array.txt |  5 +++++
 sha1-array.c                              | 17 +++++++++++++++++
 sha1-array.h                              |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
index 9febfb1d52..c97428c2c3 100644
--- a/Documentation/technical/api-oid-array.txt
+++ b/Documentation/technical/api-oid-array.txt
@@ -48,6 +48,11 @@ Functions
 	is not sorted, this function has the side effect of sorting
 	it.
 
+`oid_array_filter`::
+	Apply the callback function `want` to each entry in the array,
+	retaining only the entries for which the function returns true.
+	Preserve the order of the entries that are retained.
+
 Examples
 --------
 
diff --git a/sha1-array.c b/sha1-array.c
index 265941fbf4..d505a004bb 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -77,3 +77,20 @@ int oid_array_for_each_unique(struct oid_array *array,
 	}
 	return 0;
 }
+
+void oid_array_filter(struct oid_array *array,
+		      for_each_oid_fn want,
+		      void *cb_data)
+{
+	unsigned nr = array->nr, src, dst;
+	struct object_id *oids = array->oid;
+
+	for (src = dst = 0; src < nr; src++) {
+		if (want(&oids[src], cb_data)) {
+			if (src != dst)
+				oidcpy(&oids[dst], &oids[src]);
+			dst++;
+		}
+	}
+	array->nr = dst;
+}
diff --git a/sha1-array.h b/sha1-array.h
index 232bf95017..55d016c4bf 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -22,5 +22,8 @@ int oid_array_for_each(struct oid_array *array,
 int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data);
+void oid_array_filter(struct oid_array *array,
+		      for_each_oid_fn want,
+		      void *cbdata);
 
 #endif /* SHA1_ARRAY_H */
-- 
2.19.0

