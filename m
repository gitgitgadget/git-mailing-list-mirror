Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C18C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiKGSiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiKGShI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D254B29373
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so7729025wmb.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YJ063CkQp/JCiBt5QZ8btPCMMjnxYxtyH0hjcvY6bM=;
        b=hqpf0msiY3XLWcLSJFYBTJ1wWBFgtku6l7EnL3CTCKsZkAvw4vWFj/HOa2Q8aglQwT
         W9D6BcC8yw7vEa2z7lkQy99LXVU8SOvwdJg05kEP2JKE2HIh0j/Hvj4N8Jy9UChmsKtF
         6yVuUHc3ZQVSvhM61Q36hZpb2i/FsJhENAGYa+Y95Vs19j8vNA4zu6eVFS6yHcwfyBHO
         M0q1TLglfPtoyqvFvLsIgIJg4y+cgpfhi8cm9KY2ojWeVioNLPcCvr+wf29R7TPUrw6w
         cKyjyqk4/Jht5YJIfOyrWhk/oxsPXzdUqyfchlHKWTw9naTUIXZyUqH7m4CbuIFhd7W+
         vAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YJ063CkQp/JCiBt5QZ8btPCMMjnxYxtyH0hjcvY6bM=;
        b=gTclr/hrvbBDJ2F0koTSma4gG0WKEB0EUmGk4W2BP3wZ5/1dzT4L+ezFrtMC+pNBrF
         PJ2YGc31XRWxK7MEzReeMY/EKQE5WmYhcsrHrwi1w3GzFa4Fv7UIRIcQj/Z+HEeEASHv
         AzcHb8Oh4suQX8V9zV3rYp+tHmhVA8+gMeLVzq8WA+X7jpsKz8MeTR/7n2gXqJIJN+dg
         xWZzwKLs/UWhdAOKOapYlyXGhzNoefhyuJGHrwJj5nLqesRzmwfSfJDZC0N0eazhu0Da
         d202encscQJMe/iTysL5od5XNuq93+5iIxtT1Gw6oTtdPNUfdrZBMXUp602wtTMhcfrb
         xBaA==
X-Gm-Message-State: ACrzQf0TQTLjzcLMvXVlpwsqMfgkdxkO7+UIPnhDEME4JDaXUL2Da74q
        xXqt6bAXMgJUdl267kaKaAFzGDs9s4I=
X-Google-Smtp-Source: AMsMyM6JlemftlbbjRotkltB9h6XmIAsBdsRgbSG8mPTc+qaKoBHW7zG5WV+pf612fO+6L5mwuZe0g==
X-Received: by 2002:a1c:7207:0:b0:3cf:8115:b39a with SMTP id n7-20020a1c7207000000b003cf8115b39amr24428648wmc.80.1667846196075;
        Mon, 07 Nov 2022 10:36:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b003b47e75b401sm11904668wmr.37.2022.11.07.10.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:35 -0800 (PST)
Message-Id: <37fb4e73ca711f642351d10e1db51c330a1544f1.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:36:04 +0000
Subject: [PATCH 30/30] refs: skip hashing when writing packed-refs v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'skip_hash' option in 'struct hashfile' indicates that we want to
use the hashfile API as a buffered writer, and not use the hash function
to create a trailing hash. We still write a trailing null hash to
indicate that we do not have a checksum at the end. This feature is
enabled for index writes using the 'index.computeHash' config key.

Create a similar (currently hidden) option for the packed-refs v2 file
format: refs.hashPackedRefs. This defaults to false because performance
is compared to the packed-refs v1 file format which does have a checksum
anywhere.

This change results in improvements to p1401 when using a repository
with a 42 MB packed-refs file (600,000+ refs).

Test                        HEAD~1            HEAD
--------------------------------------------------------------------
1401.1: git pack-refs (v1)  0.38(0.31+0.52)   0.37(0.28+0.52) -2.6%
1401.5: git pack-refs (v2)  0.39(0.33+0.52)   0.30(0.28+0.46) -23.1%

Note that these tests update a ref and then repack the packed-refs file.
The following benchmarks are from a hyperfine experiment that only ran
the 'git pack-refs --all' command for the two formats, but also compared
the effect when refs.hashPackedRefs=true.

Benchmark 1: v1
  Time (mean ± σ):     163.5 ms ±  18.1 ms    [User: 117.8 ms, System: 38.1 ms]
  Range (min … max):   131.3 ms … 190.4 ms    50 runs

Benchmark 2: v2-no-hash
  Time (mean ± σ):      95.8 ms ±  15.1 ms    [User: 72.5 ms, System: 23.0 ms]
  Range (min … max):    82.9 ms … 131.2 ms    50 runs

Benchmark 3: v2-hashing
  Time (mean ± σ):     100.8 ms ±  16.4 ms    [User: 77.2 ms, System: 23.1 ms]
  Range (min … max):    83.0 ms … 131.1 ms    50 runs

Summary
  'v2-no-hash' ran
    1.05 ± 0.24 times faster than 'v2-hashing'
    1.71 ± 0.33 times faster than 'v1'

In this case of repeatedly rewriting the same refs seems to demonstrate
a smaller improvement than the p1401 test. However, the overall
reduction from v1 matches the expected reduction in file size. In my
tests, the 42 MB packed-refs (v1) file was compacted to 28 MB in the v2
format.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-format-v2.c        | 7 +++++++
 t/perf/p1401-ref-operations.sh | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/refs/packed-format-v2.c b/refs/packed-format-v2.c
index 2cd45a5987a..ada34bf9bf0 100644
--- a/refs/packed-format-v2.c
+++ b/refs/packed-format-v2.c
@@ -417,6 +417,7 @@ struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *
 						       struct strbuf *err)
 {
 	struct write_packed_refs_v2_context *ctx;
+	int do_skip_hash;
 	CALLOC_ARRAY(ctx, 1);
 
 	ctx->refs = refs;
@@ -430,6 +431,12 @@ struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *
 	}
 
 	ctx->f = hashfd(refs->tempfile->fd, refs->tempfile->filename.buf);
+
+	/* Default to true, so skip_hash if not set. */
+	if (git_config_get_maybe_bool("refs.hashpackedrefs", &do_skip_hash) ||
+	    do_skip_hash)
+		ctx->f->skip_hash = 1;
+
 	ctx->cf = init_chunkfile(ctx->f);
 
 	return ctx;
diff --git a/t/perf/p1401-ref-operations.sh b/t/perf/p1401-ref-operations.sh
index 1c372ba0ee8..0b88a2f531a 100755
--- a/t/perf/p1401-ref-operations.sh
+++ b/t/perf/p1401-ref-operations.sh
@@ -36,6 +36,11 @@ test_perf 'git pack-refs (v2)' '
 	git pack-refs --all
 '
 
+test_perf 'git pack-refs (v2;hashing)' '
+	git commit --allow-empty -m "change one ref" &&
+	git -c refs.hashPackedRefs=true pack-refs --all
+'
+
 test_perf 'git for-each-ref (v2)' '
 	git for-each-ref --format="%(refname)" >/dev/null
 '
-- 
gitgitgadget
