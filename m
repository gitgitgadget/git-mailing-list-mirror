Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F5220248
	for <e@80x24.org>; Tue, 26 Mar 2019 17:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfCZRxd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 13:53:33 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:54854 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbfCZRxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 13:53:33 -0400
Received: by mail-ot1-f74.google.com with SMTP id b10so8778770oti.21
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+bkIvXoNoOurawCqbJiHmlSqlAH1NhigNDZ29M/T0Xs=;
        b=XFnQRTGyjzrZhJRDvKcl6dFKKWJ7AJZTIEw4lBrsONqfulJCentpHFnX5A8RRpncJ3
         G3pOorowmnq8naYryOZgisJTqCQP1raVbfnIKoGzAHOcFYQ5DMa6oOsKeIJ7VwkvuYhW
         /dQeCgIaVnn0Io4Luw4UWOJTioxds0KUMyp0vtwoPFta9pXooEVRPbgTwI5kSTLpzMw2
         4t2+Ih91WjTDt8IPsLo47dtYNxRn/PYjPwnSm/J5BzbAwpUOE9c1SlMYrmATOFf31VoG
         Vr69brRgBki70KHCfbwo5z1r6XJOoMzRGfHP15uGcyFgW+hOVWLlxUUJecdZcshf32u3
         MpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+bkIvXoNoOurawCqbJiHmlSqlAH1NhigNDZ29M/T0Xs=;
        b=AYCVlDGi2xYmYy1a14INjar/jrHORZlRksJ9UQ6uuvc77LDjDx8g8Ayg0ZuM7XDA8u
         mbPP8JA8PLkG3UZgNgZSc/iKgqjKDe5kdt+TrKtmI+/hie6LMvxpeHc1YqB4zqDJ1BK9
         y+IQP2LR8ankRsiV1Q+bSRMlFLkw2C59uLWFQ9CpDIslSXGMy01WzXrTrIf71vWcSjOd
         FynA4isujqoMgj6SaUyoTHiPwolrq/21LL48Yooeh9RHNAWSnGHkDv6b0C5KrDh6Hqa+
         Ii3Udc6lOmuCmG2I4O1aaaO8dzSqwK56ayZLaueEZHCpU/hYZqdA74yU2WLK/uPI7wsg
         aVFw==
X-Gm-Message-State: APjAAAVCZ+lbZavlxV7V6dtp5cyuJVrtJodMjH0u/yziJcClbf76QdLV
        XRouwfV1Y6kPh+G+SLdMg1qUADIHNpFK/GDxRcfQv7ThMUN5MXAUB/srwKORtZyTG01rCaXlEH2
        kVwPpWan39nA4GK6VPSjrk5yIIvDCAlYuPkQw1PDY+VEYAi9TSDa5/IuVAShz23ryhK0NkRhGAg
        vz
X-Google-Smtp-Source: APXvYqxKrMEFPJYGwAUtqrVMSi0uqJxeyj1uF1lVh98K3qr8HoYjuLOI0Jw6S4oeSlixTWvVhgIPxw/pbwjjQ3fFOqdH
X-Received: by 2002:a9d:4044:: with SMTP id o4mr4504022oti.10.1553622812744;
 Tue, 26 Mar 2019 10:53:32 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:53:25 -0700
In-Reply-To: <cover.1553622678.git.jonathantanmy@google.com>
Message-Id: <d2eb101709cc9b300e38151b14c97f96a2b14188.1553622679.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com> <cover.1553622678.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v2 1/2] fetch-pack: call prepare_shallow_info only if v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fetch_pack(), be clearer that there is no shallow information before
the fetch when v2 is used - memset the struct shallow_info to 0 instead
of calling prepare_shallow_info().

This patch is in preparation for a future patch in which a v2 fetch
might call prepare_shallow_info() after shallow info has been retrieved
during the fetch, so I needed to ensure that prepare_shallow_info() is
not called before the fetch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 commit.h     |  4 ++++
 fetch-pack.c | 10 +++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/commit.h b/commit.h
index 42728c2906..a3f2b2eddb 100644
--- a/commit.h
+++ b/commit.h
@@ -257,6 +257,10 @@ extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 extern const char *setup_temporary_shallow(const struct oid_array *extra);
 extern void advertise_shallow_grafts(int);
 
+/*
+ * Initialize with prepare_shallow_info() or zero-initialize (equivalent to
+ * prepare_shallow_info with a NULL oid_array).
+ */
 struct shallow_info {
 	struct oid_array *shallow;
 	int *ours, nr_ours;
diff --git a/fetch-pack.c b/fetch-pack.c
index e69993b2eb..a0eb268dfc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1648,13 +1648,17 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
 	}
-	prepare_shallow_info(&si, shallow);
-	if (version == protocol_v2)
+	if (version == protocol_v2) {
+		if (shallow && shallow->nr)
+			BUG("Protocol V2 does not provide shallows at this point in the fetch");
+		memset(&si, 0, sizeof(si));
 		ref_cpy = do_fetch_pack_v2(args, fd, ref, sought, nr_sought,
 					   pack_lockfile);
-	else
+	} else {
+		prepare_shallow_info(&si, shallow);
 		ref_cpy = do_fetch_pack(args, fd, ref, sought, nr_sought,
 					&si, pack_lockfile);
+	}
 	reprepare_packed_git(the_repository);
 
 	if (!args->cloning && args->deepen) {
-- 
2.21.0.155.ge902e9bcae.dirty

