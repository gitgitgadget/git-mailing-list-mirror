Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9D4C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD96B20748
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO25aT3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGJTDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgGJTC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 15:02:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E1C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:02:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so6895044wmi.4
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+X5KpkA6BWe4E63LdFUvnMrtNcMStA+Yf3yIC4iJ6M=;
        b=PO25aT3aiM2bzIc4jqo5OGuZmzitmdXUy7DWoczBbDAmR9TPGqDTucf6WjdN4Np5ZP
         SWwIjVIyrUlZW+36Dd00GuwG5t9qKD/oTq5PBr0SkSreqcFWLkQ3CcdhkJ/leaP1yl+t
         p2Il7tPreVTHibu9g6hnAOq0YbmJ4tGHxOSUNyKLfn/aTy6YQe0XZ0BRKH9NyLSPvESn
         HFH4qDnbmvwIncmsy8OLKsGYNkApI4PQsGFvcBIAxzJuXDazt8kybgUZ9IFB1Dq2sD2m
         uEQ3fe1oS8tatiUBruKQuFfjkI2aTxEplCit+37KKtPlkKAWKyWyLw4anEcLDZxkA/lO
         XFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+X5KpkA6BWe4E63LdFUvnMrtNcMStA+Yf3yIC4iJ6M=;
        b=PyIHNDe8dPJJpnUBQAAenTVT1ffQmfVf5ItTPHUUtDPd3ZlZbXOi7KjwYnBGWjRHE+
         mcGExevwbjR9lcPCx3i5KrQGG4Jz+KydHZQs+PHs5O0eGSH5+hjZ5MfxyWgmTQeopuAx
         C1v2a8BkSxoNCWTJj/eZ5meiRC/U2+nJDocSBVssZjg9Zv/K/UQ/mJ+1/DM1QB06SvMu
         RxUZa8YDGaNZHfJQIBv59pO+KC9uMIM7TivUF2YP5MMdGRn/e2ia3vCTTnpwswAXH8tD
         xnRQQXl9ysRK6KWp8s9kptYxIRW6R+RYahEvW10++5PClqLPK+uRrDJia/wUi7Fev9Pf
         twkg==
X-Gm-Message-State: AOAM532/mcgMwLG7Fk3+CIMlRacyMN6Pn3LksJV0+1OhVskVCstwqcaj
        mddGTXblm4URqzoyimF93H0=
X-Google-Smtp-Source: ABdhPJz0fESQ18VcdSFu2vaSTey0ubf0aWIbZWANpFUT5MuZe3XX50Ohp7LLlT9Kjap+ffnwzwoaNA==
X-Received: by 2002:a05:600c:2209:: with SMTP id z9mr6394785wml.178.1594407765890;
        Fri, 10 Jul 2020 12:02:45 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-27.pool.digikabel.hu. [78.131.17.27])
        by smtp.gmail.com with ESMTPSA id c194sm10495099wme.8.2020.07.10.12.02.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 12:02:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, dstolee@microsoft.com,
        peff@peff.net, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] commit-graph: fix "Collecting commits from input" progress line
Date:   Fri, 10 Jul 2020 21:02:38 +0200
Message-Id: <20200710190238.16376-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.263.g31a08549b0
In-Reply-To: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
References: <56403dd377b996d21a4da1e01ffd6e691ac120bd.1589407014.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To display a progress line while reading commits from standard input
and looking them up, 5b6653e523 (builtin/commit-graph.c: dereference
tags in builtin, 2020-05-13) should have added a pair of
start_delayed_progress() and stop_progress() calls around the loop
reading stdin.  Alas, the stop_progress() call ended up at the wrong
place, after write_commit_graph(), which does all the commit-graph
computation and writing, and has several progress lines of its own.
Consequintly, that new

  Collecting commits from input: 1234

progress line is overwritten by the first progress line shown by
write_commit_graph(), and its final "done" line is shown last, after
everything is finished:

  $ { sleep 3 ; git rev-list -3 HEAD ; sleep 1 ; } | ~/src/git/git commit-graph write --stdin-commits
  Expanding reachable commits in commit graph: 873402, done.
  Writing out commit graph in 4 passes: 100% (3493608/3493608), done.
  Collecting commits from input: 3, done.

Furthermore, that stop_progress() call was added after the 'cleanup'
label, where that loop reading stdin jumps in case of an error.  In
case of invalid input this then results in the "done" line shown after
the error message:

  $ { sleep 3 ; git rev-list -3 HEAD ; echo junk ; } | ~/src/git/git commit-graph write --stdin-commits
  error: unexpected non-hex object ID: junk
  Collecting commits from input: 3, done.

Move that stop_progress() call to the right place.

While at it, drop the unnecessary 'if (progress)' condition protecting
the stop_progress() call, because that function is prepared to handle
a NULL progress struct.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/commit-graph.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 75455da138..796954da60 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -251,7 +251,7 @@ static int graph_write(int argc, const char **argv)
 			}
 		}
 
-
+		stop_progress(&progress);
 	}
 
 	if (write_commit_graph(odb,
@@ -264,8 +264,6 @@ static int graph_write(int argc, const char **argv)
 cleanup:
 	string_list_clear(&pack_indexes, 0);
 	strbuf_release(&buf);
-	if (progress)
-		stop_progress(&progress);
 	return result;
 }
 
-- 
2.27.0.547.g4ba2d26563

