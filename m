Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE741F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeBFAEo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:04:44 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37699 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBFAEn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:04:43 -0500
Received: by mail-pg0-f67.google.com with SMTP id o1so131821pgn.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VCp7SUaXs2i14HFaFIuYIYfotP1SL1beOmsDbyO8IIU=;
        b=jkDC2AVS89jfeKLgOXHeB96jHpLjkBxGjZ2b7GvVNKe4r6cRxpv7TMjZUxxvcuUo0k
         lM09JXSuIqw4/F2GGCr7FNEww2UkMTYl7SEYmqA8gqqUQRcVoM96pmu1UuQmwI/4+sgd
         vB4KR86QbEaDMeqqIpn7jBzWbovHOV57/F1rP+IhMe3nCDNNTBSpnXLZlLtvtTEEKRxX
         iIvKjiiOe93X7cnDzHystMnGVDd3mgfiP7W7jCtw7C+/yqi+ipKpvUhqqaC1Xdqyoa4J
         HGbHroWj1bODmczuVFZxvFvhteJig4fcCvEBisCJxWm8SHEMDGTqouuqXk/C94Noh6cm
         p98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VCp7SUaXs2i14HFaFIuYIYfotP1SL1beOmsDbyO8IIU=;
        b=IvxCEfXRXlycce4xSgYB640GX+Bw/ZXA6M3+ca7OcpI+PV9avrIaPIYCnh4irJiBYb
         xvUr1arjc2I1vsDhaQ8/CRLaYPzvmO5/BHzVBLaASLC1Ki8vtniCbpYJuPs7S9nZxHja
         OcfHmk6plGTuK58flFJqtYIa4ggRczyjbub019xfBNcaKFfDdudBNwtY4YlTVJ1Zz4Rw
         m7pdqT1OVWsNtwAX7wcnZOUbmBOGvLiGtZ1HO9PiyW4v4bLhlPrhakmfc2RgQOUqvxxN
         8t/+55P9CNzP3tX7pbOkhFWJLV5O6jY53OwuC8O7ukUS4oIAR+gfpHaqXZn7WmOdKkwF
         gECw==
X-Gm-Message-State: APf1xPAhd2R97dJUwNSZ2IjO3TLqQYFOcTn7JoBm7MwRpGZtWElKRoad
        KxwWCuVzs0cObGaj0Pe5PBzMLauiVPU=
X-Google-Smtp-Source: AH8x224weHSKVaZHT7DtbQuSvTKabzaTxyG9FACERiRG+0TdRXim1T0aOu8JiP28ldGcHkbYdBbBmQ==
X-Received: by 10.99.109.77 with SMTP id i74mr411177pgc.380.1517875482189;
        Mon, 05 Feb 2018 16:04:42 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 14sm19719619pfi.132.2018.02.05.16.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:04:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 051/194] refs: add repository argument to for_each_replace_ref
Date:   Mon,  5 Feb 2018 15:55:12 -0800
Message-Id: <20180205235735.216710-31-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow for_each_replace_ref callers to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 3 ++-
 refs.c            | 2 +-
 refs.h            | 4 +++-
 replace-object.c  | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index ccde160228..6d27dd73f0 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -15,6 +15,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "object-store.h"
+#include "repository.h"
 #include "tag.h"
 
 static const char * const git_replace_usage[] = {
@@ -84,7 +85,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 		    "valid formats are 'short', 'medium' and 'long'\n",
 		    format);
 
-	for_each_replace_ref(show_reference, (void *)&data);
+	for_each_replace_ref(the_repository, show_reference, (void *)&data);
 
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 968d33ac11..5c26532cbd 100644
--- a/refs.c
+++ b/refs.c
@@ -1415,7 +1415,7 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(),
 			       git_replace_ref_base, fn,
diff --git a/refs.h b/refs.h
index 01be5ae32f..546fa9e65a 100644
--- a/refs.h
+++ b/refs.h
@@ -300,7 +300,9 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-int for_each_replace_ref(each_ref_fn fn, void *cb_data);
+#define for_each_replace_ref(r, fn, cb) \
+	for_each_replace_ref_##r(fn, cb)
+int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
diff --git a/replace-object.c b/replace-object.c
index 91fedd9447..102e009927 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -76,7 +76,7 @@ static void prepare_replace_object(void)
 	if (the_repository->objects.replacements.prepared)
 		return;
 
-	for_each_replace_ref(register_replace_ref, NULL);
+	for_each_replace_ref(the_repository, register_replace_ref, NULL);
 	the_repository->objects.replacements.prepared = 1;
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

