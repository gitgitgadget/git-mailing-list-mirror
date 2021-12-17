Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A6DC4332F
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbhLQQ2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhLQQ2v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 11:28:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF903C06173E
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:28:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso2169744wmd.2
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HxI7LNp9Mzvw87CrgiC/rca54WH3qXp3iObtgt57QSM=;
        b=Q72Q3AbnYCc81OZjHN8meq/lsIQw+bo3w+fa1s3az6Co6m58B5fB5+Huoyo3Eupock
         p9Gfvk6NmHrIKVdK2Uczh4szxFRiSg6IzSDEk9VuIVXHDW+0Zontg8XNAvh3gNbMwsiE
         9lepedNoBGabfpfDjJDYgne3X3cNq7c4nIZDPdyeUSD484WeXr/GDhxFzItIRghuKhQR
         x0ImRy8DxpABdOtU38sr+DeMIeAOyzSP7FjFIk4XV5dvxiGq7sC8l5M6u215wfUPlKV3
         cqv8poiXI9Rf6nlji+HR1ZEEcvt42w2K+5vap2rAOUX4Sn3zx6J9z+hCJJ+cHf/INHba
         xl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HxI7LNp9Mzvw87CrgiC/rca54WH3qXp3iObtgt57QSM=;
        b=5GNKx8O2N08u7LIjMG8G4doODUMURph1Hdo77t6qBYQa/QZSZoC6kEw3PhnsQGQRGI
         u0VTQp0qTEt+xZJQmvNHZ5zCksGpFm3SAqh9rvTMQF8qkkBXujzr852d19a0w2HMD51r
         mC785am5Vo6PqQyEs+DTaMh7gU0oB943Tn+9Czym3l+iV0fpSCq7P+0UDOgdsYa6gAQ4
         8xppiNFZPs+UwLcZ848+sLVTxPTy3vEyEgmL/6BBnvRfnaF38TAzdHk5QD58g9hJ0/Qv
         g/SLOljen6rmgiall/LKSu+Rt6QdmBCUSaCPaXC4szt0+fXx6fmPdDK5D5J1WE1lhv6X
         gp7A==
X-Gm-Message-State: AOAM530J30KDNisTuiyANW8aFl5HoxOt4WWn7jpO5ADKQ+8Ri0UHubW1
        J9gJKsrExtHXSUZtssiuu0x0nyR3aBg=
X-Google-Smtp-Source: ABdhPJz3qT21WkcTeBsyISUxK4k5HZpd3t1ER5ZWVakN3+nwR8+Hcovig+1boZKme3sx8a4e17s9oQ==
X-Received: by 2002:a05:600c:3d1a:: with SMTP id bh26mr10018805wmb.5.1639758529273;
        Fri, 17 Dec 2021 08:28:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm7966913wrh.32.2021.12.17.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:28:48 -0800 (PST)
Message-Id: <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Dec 2021 16:28:46 +0000
Subject: [PATCH 2/2] repack: make '--quiet' disable progress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

While testing some ideas in 'git repack', I ran it with '--quiet' and
discovered that some progress output was still shown. Specifically, the
output for writing the multi-pack-index showed the progress.

The 'show_progress' variable in cmd_repack() is initialized with
isatty(2) and is not modified at all by the '--quiet' flag. The
'--quiet' flag modifies the po_args.quiet option which is translated
into a '--quiet' flag for the 'git pack-objects' child process. However,
'show_progress' is used to directly send progress information to the
multi-pack-index writing logic which does not use a child process.

The fix here is to modify 'show_progress' to be false if po_opts.quiet
is true, and isatty(2) otherwise. This new expectation simplifies a
later condition that checks both.

This is difficult to test because the isatty(2) already prevents the
progess indicators from appearing when we redirect stderr to a file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 1f128b7c90b..c393a5db774 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -612,7 +612,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct tempfile *refs_snapshot = NULL;
 	int i, ext, ret;
 	FILE *out;
-	int show_progress = isatty(2);
+	int show_progress;
 
 	/* variables to be filled by option parsing */
 	int pack_everything = 0;
@@ -725,6 +725,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	prepare_pack_objects(&cmd, &po_args);
 
+	show_progress = !po_args.quiet && isatty(2);
+
 	strvec_push(&cmd.args, "--keep-true-parents");
 	if (!pack_kept_objects)
 		strvec_push(&cmd.args, "--honor-pack-keep");
@@ -926,7 +928,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			}
 			strbuf_release(&buf);
 		}
-		if (!po_args.quiet && show_progress)
+		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
 
-- 
gitgitgadget
