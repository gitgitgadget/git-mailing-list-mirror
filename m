Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B222120248
	for <e@80x24.org>; Tue, 26 Mar 2019 19:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbfCZTbc (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 15:31:32 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:33236 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbfCZTbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 15:31:31 -0400
Received: by mail-qk1-f201.google.com with SMTP id n64so12588149qkb.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u8eA5y+Zz1P0hKtq9Z44hGIcKGcALvwpjR1uj/SkAlU=;
        b=vL98vT6Y9y0fhmx4KPIw7DoGYm0nnSltYJdzF8k8rrJMw75FdoUM8eOlr1OASzRZT0
         FZhUjvPDbteq8HSLlbGKBkikAodhk3aEz+t/uegpMLP/T4lbjKhFBhLGcHKajZLrmdci
         Lm6INU59BWPBZFUV8EotugBbMLK22WSxmXvxinxrllk62+mzrTm0mRm4qyEEGOSNIkbJ
         kg33T7mqySnLsmvPXEDxWTT5gfMRvKM0XP4rGfRmBo8eNeEvKv9N3u9xIVpI/lV6zn2O
         kqb3MCG6cd+2r9v88WTolP3ATJ8AhC3FA0MsJYv1po/9aCRNMbtYavNRxherar9xe6o3
         6GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u8eA5y+Zz1P0hKtq9Z44hGIcKGcALvwpjR1uj/SkAlU=;
        b=Y7tFyCl0Qc4IbGmJ7ZJDaNlC2/ysQQKnWBuEJDVUtLzeNhMYmNrM1Z1E77Q1CIxvmT
         XnO1zC9iCCp6X3B7s6aza+sU3mMm32yvVSuliXwEOfNocc/6z1wkEsE8MlBJlFxAwUde
         drEjhyZrhOhHCBV3eGFT9+vRUdGkEJoB5LhJn/mqlXQK2aOwIhjd0RWidkbVJRLCEQow
         V4aLRr5Aq6h7zSiZWJTvWWiXFMK/erMnVBciEpbzvLT+URTX5U3556eJcvqXYpR5KB3p
         5gy9VudnEoTE0gwq2vDwIB99KpHuWE18BR0UtW3CnhckbQ7igKdGAKH4x6eGfaTDdMpk
         tWRQ==
X-Gm-Message-State: APjAAAX4N53flWCdUSRxZimkOgNvvZ5uitzbuu7OshbyczSpVRtJdXzD
        U55OPkaO3wBmYFsVzEWRb7USIb0pBr1t2G1+u54KN4QiwIV+tBNeH1MG55SZ0edSgQWYj8zzN8j
        TaFTi9+nyBoROpdzMwHn0m0Lu4gtlwlCFmG/5VRPKgFtMTjNXCYvq59KKDwCq87+sooPjwCGMfN
        xf
X-Google-Smtp-Source: APXvYqyt+s6lpZOd60AxH9YVgV90WVgAAioK+USUzR5Z7Dfc1MOqwZvPMsWM4lMb6/CYNEDYHGBhjq+sPMv/GIHxWUp6
X-Received: by 2002:a0c:8813:: with SMTP id 19mr26697302qvl.234.1553628690328;
 Tue, 26 Mar 2019 12:31:30 -0700 (PDT)
Date:   Tue, 26 Mar 2019 12:31:20 -0700
In-Reply-To: <cover.1553628494.git.jonathantanmy@google.com>
Message-Id: <64f44a18ad02f68410b9a6637c543fc911de5f56.1553628494.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1553546216.git.jonathantanmy@google.com> <cover.1553628494.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH v3 1/2] fetch-pack: call prepare_shallow_info only if v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net
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
index e69993b2eb..ebb24ada24 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1648,13 +1648,17 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		packet_flush(fd[1]);
 		die(_("no matching remote head"));
 	}
-	prepare_shallow_info(&si, shallow);
-	if (version == protocol_v2)
+	if (version == protocol_v2) {
+		if (shallow->nr)
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

