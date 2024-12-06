Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AB1FFC7C
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515646; cv=none; b=Ulu/VYq43EofrB73Rxd5FwUlZx0TM5t/QEai8yfDI7hT7/pi7fWxKBIL6PRkRmQoxH2XgARjKztVJh39HeGb5Q6ELBaX1Gk/Zy71jNRsHph7anO8pisiNtZNFUB/5ywVaNgLjrzYNDIUTMXsfQ4HeUzahNjHC9GPu6x2hA//sVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515646; c=relaxed/simple;
	bh=j0KKRzngjNerlstBhOrZ2IH/mmgj05P7WVeOZE5MyoE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oaIask2JEtR4Qgy5nDVrdFTWQdoI9ps2/1K60IFwTAhU7dDkByu582ackgKjA4I9foVQwB/E6Ph/+wsLgTwS0j8mk9UB6scSI8XwbSa+ACvl74vjJM24lkGL1BAoccEbsQRb6m84PO5dbzXbCywddx7/CZxi6NzG0ZJ89e6VnAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTlkgoEl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTlkgoEl"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e2880606so2103889f8f.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 12:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515643; x=1734120443; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er7g41sFH0gPwKns8xL2/aF6TaIlLdQm11NwwyEEdXg=;
        b=lTlkgoElzQROHWP5w0dSFOBHP0v550D1OEloP48DH8fodlySXkack9xdG099nxk99q
         n4qwLDPHWb675lzIuEaltrXzVMve4qE7ZBTEOgSL3St+HHKvT/Vj5mYGIxQvKxdW+vVT
         wtPlNEbydeY+5bNS3Ujzm8LI3PdzMKKtg+l530f1xt8SisnKRvaFg649pviMxfX1fNYE
         R6iPq38pL9KQx5jgeIkcc/oe2XgKh2d+AonY3FkPCemmYLU+xcV318vSkqOFOsBqE1k8
         sPz0OUKka1NZY+meXMiF96p4a/Q4iPFy48sF/oEPDqh0/xDfoZtIlmOYNO6jCfRhF32r
         PlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515643; x=1734120443;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er7g41sFH0gPwKns8xL2/aF6TaIlLdQm11NwwyEEdXg=;
        b=Za5A6aviiHCs0y3vO7b15+IM+nOZ24KFRMMStX2KEiNFapDPVx2k7iIjP06v2EuYEI
         tCibfr1zu9+2LlnSNwK9kTkebfmjv4spgAfFDZ8dEieh/hS/tMU7YUGCjEMz6Tswrhky
         kVrYXz5omkJbdlA7CCaV132ktMnZ3YXYTrKv32bgaUPmSkwCC/sfScwcWN8pb9Wn9NwR
         vBRSSHeRaQi6aR+dsvv0GoZdqURtM8NQTEbotFfc7zhPsGCj7cPTGqbL98RELWa6+fq7
         gYq8yCv+VKOVQGdy5YljoV6YZbJSQhlcTS7Zmj4Ex+0DBlsjHIfWRadgBEWJYU8PGdxI
         Zpig==
X-Gm-Message-State: AOJu0YzleD9HV04WvfQLULxXAXv67eIpOJMOYycRd4ANv/d1E2fUGFTB
	Nf2PYu/2YtOF/9ks0/sdWg7YMwOkhQLiYR+GbA6Zgmt0/xqNYi4M1FPtGA==
X-Gm-Gg: ASbGnctx8SSbU0K0ECvR9bdsNiDGrCZv8N+B58J+VdKMCmjx1cmG9E7p9PljefqeZjY
	E1wIFS+x2XNWJGGCHZt0HLfVan7oXM7hlK4/nZ7CfRJgfDxr9tmNtTQDN9mTL4qLa0tG1Yt6Myy
	0I0zps3CTBR/072abk0EXM3L5Rfx707bsXB9s9ZpbUAbvTcuXIpIufir7MXGl/IS2TYt57QoqXb
	M85xgrWq3AexMO/NRDcUPmcU6mKZyHAAtjNX/Y+uVN1WOGhxGs=
X-Google-Smtp-Source: AGHT+IE5emegF67hqocf2Y9GUuTlUz7bSCW2peAARJajCovcdnGCEi/U35V2d38saqBTxl4fpcOYvA==
X-Received: by 2002:a05:6000:1787:b0:385:db0f:332e with SMTP id ffacd0b85a97d-3862b36a3a8mr4142522f8f.22.1733515642770;
        Fri, 06 Dec 2024 12:07:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386321be911sm841122f8f.49.2024.12.06.12.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:07:22 -0800 (PST)
Message-Id: <3cfd23073a036ea426569769b3e31290076257a6.1733515638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 20:07:16 +0000
Subject: [PATCH 3/5] backfill: add --batch-size=<n> option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

Users may want to specify a minimum batch size for their needs. This is only
a minimum: the path-walk API provides a list of OIDs that correspond to the
same path, and thus it is optimal to allow delta compression across those
objects in a single server request.

We could consider limiting the request to have a maximum batch size in the
future. For now, we let the path-walk API batches determine the
boundaries.

To get a feeling for the value of specifying the --batch-size parameter,
I tested a number of open source repositories available on GitHub. The
procedure was generally:

 1. git clone --filter=blob:none <url>
 2. git backfill

Checking the number of packfiles and the size of the .git/objects/pack
directory helps to identify the effects of different batch sizes.

For the Git repository, we get these results:

| Batch Size      | Pack Count | Pack Size | Time  |
|-----------------|------------|-----------|-------|
| (Initial clone) | 2          | 119 MB    |       |
| 25K             | 8          | 290 MB    | 24s   |
| 50K             | 5          | 290 MB    | 24s   |
| 100K            | 4          | 290 MB    | 29s   |

Other than the packfile counts decreasing as we need fewer batches, the
size and time required is not changing much for this small example.

For the nodejs/node repository, we see these results:

| Batch Size      | Pack Count | Pack Size | Time   |
|-----------------|------------|-----------|--------|
| (Initial clone) | 2          | 330 MB    |        |
| 25K             | 19         | 1,222 MB  | 1m 22s |
| 50K             | 11         | 1,221 MB  | 1m 24s |
| 100K            | 7          | 1,223 MB  | 1m 40s |
| 250K            | 4          | 1,224 MB  | 2m 23s |
| 500K            | 3          | 1,216 MB  | 4m 38s |

Here, we don't have much difference in the size of the repo, though the
500K batch size results in a few MB gained. That comes at a cost of a
much longer time. This extra time is due to server-side delta
compression happening as the on-disk deltas don't appear to be reusable
all the time. But for smaller batch sizes, the server is able to find
reasonable deltas partly because we are asking for objects that appear
in the same region of the directory tree and include all versions of a
file at a specific path.

To contrast this example, I tested the microsoft/fluentui repo, which
has been known to have inefficient packing due to name hash collisions.
These results are found before GitHub had the opportunity to repack the
server with more advanced name hash versions:

| Batch Size      | Pack Count | Pack Size | Time   |
|-----------------|------------|-----------|--------|
| (Initial clone) | 2          | 105 MB    |        |
| 5K              | 53         | 348 MB    | 2m 26s |
| 10K             | 28         | 365 MB    | 2m 22s |
| 15K             | 19         | 407 MB    | 2m 21s |
| 20K             | 15         | 393 MB    | 2m 28s |
| 25K             | 13         | 417 MB    | 2m 06s |
| 50K             | 8          | 509 MB    | 1m 34s |
| 100K            | 5          | 535 MB    | 1m 56s |
| 250K            | 4          | 698 MB    | 1m 33s |
| 500K            | 3          | 696 MB    | 1m 42s |

Here, a larger variety of batch sizes were chosen because of the great
variation in results. By asking the server to download small batches
corresponding to fewer paths at a time, the server is able to provide
better compression for these batches than it would for a regular clone.
A typical full clone for this repository would require 738 MB.

This example justifies the choice to batch requests by path name,
leading to improved communication with a server that is not optimally
packed.

Finally, the same experiment for the Linux repository had these results:

| Batch Size      | Pack Count | Pack Size | Time    |
|-----------------|------------|-----------|---------|
| (Initial clone) | 2          | 2,153 MB  |         |
| 25K             | 63         | 6,380 MB  | 14m 08s |
| 50K             | 58         | 6,126 MB  | 15m 11s |
| 100K            | 30         | 6,135 MB  | 18m 11s |
| 250K            | 14         | 6,146 MB  | 18m 22s |
| 500K            | 8          | 6,143 MB  | 33m 29s |

Even in this example, where the default name hash algorithm leads to
decent compression of the Linux kernel repository, there is value for
selecting a smaller batch size, to a limit. The 25K batch size has the
fastest time, but uses 250 MB more than the 50K batch size. The 500K
batch size took much more time due to server compression time and thus
we should avoid large batch sizes like this.

Based on these experiments, a batch size of 50,000 was chosen as the
default value.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt | 10 +++++++++-
 builtin/backfill.c             |  4 +++-
 t/t5620-backfill.sh            | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 0e10f066fef..9b0bae04e9d 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [verse]
-'git backfill' [<options>]
+'git backfill' [--batch-size=<n>]
 
 DESCRIPTION
 -----------
@@ -38,6 +38,14 @@ delta compression in the packfile sent by the server.
 By default, `git backfill` downloads all blobs reachable from the `HEAD`
 commit. This set can be restricted or expanded using various options.
 
+OPTIONS
+-------
+
+--batch-size=<n>::
+	Specify a minimum size for a batch of missing objects to request
+	from the server. This size may be exceeded by the last set of
+	blobs seen at a given path. Default batch size is 16,000.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/builtin/backfill.c b/builtin/backfill.c
index e5f2000d5e0..127333daef8 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -21,7 +21,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [<options>]"),
+	N_("git backfill [--batch-size=<n>]"),
 	NULL
 };
 
@@ -112,6 +112,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.batch_size = 50000,
 	};
 	struct option options[] = {
+		OPT_INTEGER(0, "batch-size", &ctx.batch_size,
+			    N_("Minimun number of objects to request at a time")),
 		OPT_END(),
 	};
 
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 64326362d80..32e2bb1c132 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -59,6 +59,24 @@ test_expect_success 'do partial clone 1, backfill gets all objects' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'do partial clone 2, backfill batch size' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill2 &&
+
+	GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
+		-C backfill2 backfill --batch-size=20 &&
+
+	# Batches were used
+	test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
+	test_line_count = 2 matches &&
+	test_trace2_data promisor fetch_count 8 <batch-trace &&
+
+	# No more missing objects!
+	git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
+	test_line_count = 0 revs2
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

