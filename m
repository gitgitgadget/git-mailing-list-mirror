Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5461920248
	for <e@80x24.org>; Mon, 25 Mar 2019 20:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfCYUne (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 16:43:34 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47150 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfCYUne (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 16:43:34 -0400
Received: by mail-qk1-f202.google.com with SMTP id i124so9677620qkf.14
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+bkIvXoNoOurawCqbJiHmlSqlAH1NhigNDZ29M/T0Xs=;
        b=oHF8s+aywvDhrnb1gnYG2TK7zj6IMyaA9X0rX3oKFkMF8wYIlqQLf/e+RNwXL9qwtF
         ZKGLWaZPRAMR2hoRTgNwci9fYWAjtlHUpNkqXT6cscd2vkyaIq4PKBEsiMOo5vu9T1ut
         1JL7RW65BcWtFs9SF40BorfGeCJI79cckkwxQ2xEQs1g9LPFD4WK/BcRbfELfDsH+R9B
         9zsz8JTeDF7J8SciHVSMpIxerb1BVeB2ldpPUwiq2kNc78v3BIK60E3nWRdxqCcLnNhy
         dTN6XMXQMjmYrXyRckomo+4iD3gWcY8wSac124Gl9FJO4aHky2dSQPdUWf0Gg7HPPtYk
         cbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+bkIvXoNoOurawCqbJiHmlSqlAH1NhigNDZ29M/T0Xs=;
        b=n5jBi21bPOrdlgOa+TKjxzWsWyoUpEt7YZg8Zkkx4Rp3xBEK3GvSyhiWBaZxFSW80i
         8DlUTp6uS/Fz1ojmIjMoYAjooe1Xb7K2n5yWSgLk6lhXPEHQJQzcTHqAMcuyASMvdLQi
         sXTdinzF/0xdrmPRJsX6uSGd3jN2jJr9SHVxStYZIyfqCUfdtcABdudA93NX01Qv3XPR
         2JVONm3r6Dk8WqkT4f7H2EzkP9tmdANeenqI5ghpBX639sCC9WBK//CIHLsH3ZJFAo+H
         xJmF44RQkuLNK1OmJOVCSRQYdUKbEMqcy8fekKX84Fm/f4I6BAyrkTNogZw9ga/zuIux
         P0xg==
X-Gm-Message-State: APjAAAW8VX4h60ZvbEZpl33yrYIHLkRJ+Pw2penGQ9qX0y3UBps4H1Sd
        vfyKiXvdHw76xY8m11g/lvcubio+UMMLPF0LPvcZKNcADUFCJQKVCnVtovk5iyIOwHPN4oIbAhr
        e+RCPfpZtb9ZRI5h/6SQpEF+w2AQoUBHXhc7IH7/8jwqsFiIjHCFp+PapLKFgRGMbgWay0bxQvF
        eJ
X-Google-Smtp-Source: APXvYqw48wpLkIi25vNUJ+PaagiQ4gxzfd4U3bv64dSjfx00OPvrRM/HauyPvd5ZvRCH/MvL3oT0jrTpGRFGEoVLLtu/
X-Received: by 2002:ac8:32fb:: with SMTP id a56mr22955677qtb.338.1553546612829;
 Mon, 25 Mar 2019 13:43:32 -0700 (PDT)
Date:   Mon, 25 Mar 2019 13:43:22 -0700
In-Reply-To: <cover.1553546216.git.jonathantanmy@google.com>
Message-Id: <d2eb101709cc9b300e38151b14c97f96a2b14188.1553546216.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH 1/2] fetch-pack: call prepare_shallow_info only if v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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

