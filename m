Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CF20C46A
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602677; cv=none; b=alObb8jdevByHZosQ+mQfjrdFNLrAxhmD9lV40wqXLgP5q1jc779wN5+W0UUVEglxY/Wja/D5+WyP8PewD00ItVPvlsWe9dOr2JDGKiIR2dm5CkPb7By4keQWsPEom4YZ6A4hy1Pum0uQJ/FMV2CszV6ecPP7uFXacuavTXypf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602677; c=relaxed/simple;
	bh=pQ5cC/MIwIkqzfPR53W2C8+S8l8I7Vh2oWFz0IavHfc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fY0k8Nod17ZjEJojPG3xXdraXaaSTn/oMx/A5IYcDCxuRwnks0LQqKx/F2006oJPEDReIrhRoBssb699QIOJ/yGKiQT8KANAgrU32L4lAsbgqivCqavWcI67Q4X2LiFUX1YGFfBXqvAsYMOC4YTzbQZthtdRQu4UeO29THLki1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfV2zE94; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfV2zE94"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so11265351a12.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738602672; x=1739207472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwmLMOg6kqF/7d4afWMf0LV6sb7oQoooYIjw5ZWsJPA=;
        b=JfV2zE94LfNSu28ramzvq5jcGiWAEugzQHssC32L62e029Jj3qGorfyKyMZSNqChER
         nLmhfieTRA1jnGDSfWy6QtlFZn+l8Xc4Q+IsmkLywFv3cqMfweONGVXiSDXS9XIYpVet
         2xtry7lW+88VKC/n0Mr551IxCHtOAu2ReIubmaN8bISfwksToWB7G20GpdWhLSPwlETe
         z8P8z2ccaF0hiDbNDXbL80ZHrPqT+/nM9FxHqYNKG0mVP82wj23zA0QRpeH6exn6BQFN
         FjKjc/zY03pQU7qduULmTQ8mSpO3DodJgktWPIjDb8RyCTCUNfTbXnzTkbdoA+Df6Lp3
         C1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738602672; x=1739207472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwmLMOg6kqF/7d4afWMf0LV6sb7oQoooYIjw5ZWsJPA=;
        b=KyNqswxU5ntwHtBKauNH0QoBA69VuvXJzovcrFRmyucgQJGeJg9QkQgOPN2SRBdHic
         VKj8iB5XJfn/uKeOkPF+lWytwd8Wdc0AGl/bWzjuRBJZMrjfKvg7fZ1Rpw7BkYZfjHqg
         rfCG2r2gvUC/ik+GGshFGFF4r+qBP5bq29dMb3bpnNEV1rZ9o0vjqTB70LTZmYrtfIyg
         zRQomwQZlmycP4EnE8djV9KwONgfRVccUIWZa4YM1uSOvKuw1gBOoTPQwr6Qz8NwEqqX
         FlTbaBtxllMJWlPa4v3LtL1dGVqdfqA7OkTd8FRZoFjtMsSsUcYofePulMzloI9j/gES
         w7gA==
X-Gm-Message-State: AOJu0Yx8YvZchr0BC0G76gJ1oJHH+YvbAjFl5eNrG9YZr+rwKrJmS5cO
	e+BqhCsaBajMiWeF1pYRWTcMnMewXQu6QCKsa4OLI7vH6pSjB2QC5i1MZw==
X-Gm-Gg: ASbGncvKqtbr4Y19PqKJLDcdxyZPkS0pcoFumcBx03pEr3C+bj8dbX2n5QTdL6oOXFd
	s7Kg0rTXEGHTjPsQqb4aE35Ei5YBiSpelosBats9I38MnW6nd39WN/kCYvkFCkmNBqBC7WORVSp
	Qt+4vJSQ8j3pD0gkj12ENBQLBHnoSoolcSRsve+gQG66MCEA48lWVn2cGmhIJ3cKY+ASQq/ni1j
	g5XZzObv5pBaB6x6TtZg0F2i9/ocEvukBr7dY29Yao22yfXLzGH4kKZARVY4XJhcYdBY8xqoj0e
	+DKxoY7jrny9FGjA
X-Google-Smtp-Source: AGHT+IEM7fDWf7SBGJ0zmuah+bMC/iFdPvRz3kgE8Go7zfkpexUsE5EYHSJmV+aSWvQ6CKc3xaRAzQ==
X-Received: by 2002:a05:6402:254e:b0:5d9:6633:8eb1 with SMTP id 4fb4d7f45d1cf-5dcc15d5a63mr28822a12.14.1738602672438;
        Mon, 03 Feb 2025 09:11:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724c93d9sm8047041a12.68.2025.02.03.09.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:11:11 -0800 (PST)
Message-Id: <b35c2f06b5952ff34ea52766652a3bd3c698f681.1738602667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
	<pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Feb 2025 17:11:05 +0000
Subject: [PATCH v3 3/5] backfill: add --min-batch-size=<n> option
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
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
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

To get a feeling for the value of specifying the --min-batch-size parameter,
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
 Documentation/git-backfill.txt | 12 +++++++++++-
 builtin/backfill.c             |  4 +++-
 t/t5620-backfill.sh            | 18 ++++++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 56cbb9ffd82..136a1f1d294 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [synopsis]
-git backfill [<options>]
+git backfill [--min-batch-size=<n>]
 
 DESCRIPTION
 -----------
@@ -47,6 +47,16 @@ commit. This set can be restricted or expanded using various options.
 
 THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR MAY CHANGE IN THE FUTURE.
 
+
+OPTIONS
+-------
+
+`--min-batch-size=<n>`::
+	Specify a minimum size for a batch of missing objects to request
+	from the server. This size may be exceeded by the last set of
+	blobs seen at a given path. The default minimum batch size is
+	50,000.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 0eca175a7fe..cfebee6e17b 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -21,7 +21,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [<options>]"),
+	N_("git backfill [--min-batch-size=<n>]"),
 	NULL
 };
 
@@ -108,6 +108,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.min_batch_size = 50000,
 	};
 	struct option options[] = {
+		OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
+			    N_("Minimum number of objects to request at a time")),
 		OPT_END(),
 	};
 
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 64326362d80..36107a51c54 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -59,6 +59,24 @@ test_expect_success 'do partial clone 1, backfill gets all objects' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'do partial clone 2, backfill min batch size' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill2 &&
+
+	GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
+		-C backfill2 backfill --min-batch-size=20 &&
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

