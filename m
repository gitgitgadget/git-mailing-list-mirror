Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7F1DFDBB
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181694; cv=none; b=VNZI7tfAnZKw6mEdBve3mG+904lZRdTOzT0c8yd8NT50ELvZgbxXd+qGj44NqwshoIdydi0qRpSrEyg1/FMc8PvNrRkWOK/8hTl3z2A/OdWsNAHkuIDEuZW4zsKtwSrVOWgfNKSYm49j+tnJh4FeSBuHNuydDgeNXnQnshG+6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181694; c=relaxed/simple;
	bh=/bD6qCwBs7FMfZFdgS/bUKV61sJk3M+6KsZ3ijnHrYw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qTcQAayEBPdhzcx7kwSmmi19o4IcAijh/M8GFjAR9CCjCkWrgsp8XJ7yQFI7Zte5QU1IKRsu40r3KJmWthwAcg59xCcBtbhR3LUAkK4ZSoM350MZD4+aR3BaYVSy4JpZeHf9hP2gRS+pCty+i5p5e8zSEQyHzCTSvoNULrkuJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWsuT2kS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWsuT2kS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso639266666b.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 15:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733181690; x=1733786490; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnbYefj8n+7rAkXVOoyWudmPM1pS4P6SwY3WyjHlJqo=;
        b=LWsuT2kSJ5ZkkGVV9bX/4bP5M5wqzUDE95N9TsYHkD0Ed4dbqxJDfk4NRU3V4GFsGY
         ZydNs+dvqQgMTzIuVMsJ1ondBL28u517a7sNipwtrlodT2Ku/ksHLz5+tnX45sYHYHKO
         wwUq9KjVJuU+4eZsZpjZ+01e0fOgmyhdD9WvqTIZ88Eg4Y0Z07++DE2S1wXlWoJoz5PR
         fepgMmy84MHp4TvqYuoxY/A8yAgN3Tap9Tzso4P3tHR2Ygd36CAm4xPK4pKX06nnK3oD
         MicZ1C8VqwQkxi8eYEAiF3mE7uX76sZD8GeYaZaeS9YXmyDvWLstHo4Gdztx/6DBORLT
         4Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733181690; x=1733786490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnbYefj8n+7rAkXVOoyWudmPM1pS4P6SwY3WyjHlJqo=;
        b=k+GuMsi8wcfS32efNngO6hGXdKRTyr0INeR3j7UFVLE9lyAq3OgDLRHYeKC9ab9BNo
         Ye1TVWr3YeMQeK+PS/uZGPd+kKAAsRzJVmWzKYmrVt3TCdXAey5Hf29+mbG9b3ycuDAx
         eigVGDhUrvCqjvXUaFAtTOozbMv/dOXZZYUzhjutlOkZn9YkUrkcHAHLOZNODRzHFOrm
         tD0rivnoZG0eXa5r7XcpqPPcZ71L1CG5hRGBY4FxVgn9ypVKT4PcwuMza7M2kf2nK3BW
         tjc7+gguWjedbE/iztFYJlrgvZWHngHboaDRzKSG+Aj2dyLVgmdll98QXBVKzLv4Jc5o
         Sq0Q==
X-Gm-Message-State: AOJu0YwKsE3hmQGabfmu8qyOUBcbejJesXpzIfSirmddIuSXb51fUz8L
	dOkHXRrE0qnmiVai1clSErM3jhqaPTrYzFJ05M8yBR5lm+C9WE42a3vebw==
X-Gm-Gg: ASbGncuuq5kyHTsPJzuoe8/Z3pdt6I9qwInPgzo4CDXG+35gviCiCGZIzI4r2WdefRp
	xYCTgRzvXnQDCyxVw2Ie+yBSIN/FgIJf9crdgg0/Vl9zDuAgu91S78hf2+MRxPsDDU3+FFSLT8h
	2aHw3DGyDqzW8dhTgZX2bShAdDsXtNHNA6i8Kv1nYHyNu8RiAJRK4F2uKK9fl/w6Z7UUxCnvR1R
	IyryPun3eu+Jiy4cuTddWYje/s9bX1oUgW/7weYqgHjF2LS/xY=
X-Google-Smtp-Source: AGHT+IHKXB/ypchxZAI3ml1xlmsPoZjo9txf5V6r3skYRuSm/40cOjL1R8rMuietbQSWouL1DYzegg==
X-Received: by 2002:a17:906:310b:b0:aa1:e5a3:b26f with SMTP id a640c23a62f3a-aa5f7d03216mr5589866b.6.1733181689509;
        Mon, 02 Dec 2024 15:21:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5999734e4sm552054566b.203.2024.12.02.15.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 15:21:29 -0800 (PST)
Message-Id: <3b5697467c997b5d2080fb02debd911d716e8383.1733181682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Dec 2024 23:21:19 +0000
Subject: [PATCH v2 5/8] p5313: add size comparison test
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
    jonathantanmy@google.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

As custom options are added to 'git pack-objects' and 'git repack' to
adjust how compression is done, use this new performance test script to
demonstrate their effectiveness in performance and size.

The recently-added --name-hash-version option allows for testing
different name hash functions. Version 2 intends to preserve some of the
locality of version 1 while more often breaking collisions due to long
filenames.

Distinguishing objects by more of the path is critical when there are
many name hash collisions and several versions of the same path in the
full history, giving a significant boost to the full repack case. The
locality of the hash function is critical to compressing something like
a shallow clone or a thin pack representing a push of a single commit.

This can be seen by running pt5313 on the open source fluentui
repository [1]. Most commits will have this kind of output for the thin
and big pack cases, though certain commits (such as [2]) will have
problematic thin pack size for other reasons.

[1] https://github.com/microsoft/fluentui
[2] a637a06df05360ce5ff21420803f64608226a875

Checked out at the parent of [2], I see the following statistics:

Test                                         HEAD
---------------------------------------------------------------
5313.2: thin pack with version 1             0.37(0.44+0.02)
5313.3: thin pack size with version 1                   1.2M
5313.4: big pack with version 1              2.04(7.77+0.23)
5313.5: big pack size with version 1                   20.4M
5313.6: shallow fetch pack with version 1    1.41(2.94+0.11)
5313.7: shallow pack size with version 1               34.4M
5313.8: repack with version 1                95.70(676.41+2.87)
5313.9: repack size with version 1                    439.3M
5313.10: thin pack with version 2            0.12(0.12+0.06)
5313.11: thin pack size with version 2                 22.0K
5313.12: big pack with version 2             2.80(5.43+0.34)
5313.13: big pack size with version 2                  25.9M
5313.14: shallow fetch pack with version 2   1.77(2.80+0.19)
5313.15: shallow pack size with version 2              33.7M
5313.16: repack with version 2               33.68(139.52+2.58)
5313.17: repack size with version 2                   160.5M

To make comparisons easier, I will reformat this output into a different
table style:

| Test         | V1 Time | V2 Time | V1 Size | V2 Size |
|--------------|---------|---------|---------|---------|
| Thin Pack    |  0.37 s |  0.12 s |   1.2 M |  22.0 K |
| Big Pack     |  2.04 s |  2.80 s |  20.4 M |  25.9 M |
| Shallow Pack |  1.41 s |  1.77 s |  34.4 M |  33.7 M |
| Repack       | 95.70 s | 33.68 s | 439.3 M | 160.5 M |

The v2 hash function successfully differentiates the CHANGELOG.md files
from each other, which leads to significant improvements in the thin
pack (simulating a push of this commit) and the full repack. There is
some bloat in the "big pack" scenario and essentially the same results
for the shallow pack.

In the case of the Git repository, these numbers show some of the issues
with this approach:

| Test         | V1 Time | V2 Time | V1 Size | V2 Size |
|--------------|---------|---------|---------|---------|
| Thin Pack    |  0.02 s |  0.02 s |   1.1 K |   1.1 K |
| Big Pack     |  1.69 s |  1.95 s |  13.5 M |  14.5 M |
| Shallow Pack |  1.26 s |  1.29 s |  12.0 M |  12.2 M |
| Repack       | 29.51 s | 29.01 s | 237.7 M | 238.2 M |

Here, the attempts to remove conflicts in the v2 function seem to cause
slight bloat to these sizes. This shows that the Git repository benefits
a lot from cross-path delta pairs.

The results are similar with the nodejs/node repo:

| Test         | V1 Time | V2 Time | V1 Size | V2 Size |
|--------------|---------|---------|---------|---------|
| Thin Pack    |  0.02 s |  0.02 s |   1.6 K |   1.6 K |
| Big Pack     |  4.61 s |  3.26 s |  56.0 M |  52.8 M |
| Shallow Pack |  7.82 s |  7.51 s | 104.6 M | 107.0 M |
| Repack       | 88.90 s | 73.75 s | 740.1 M | 764.5 M |

Here, the v2 name-hash causes some size bloat more often than it reduces
the size, but it also universally improves performance time, which is an
interesting reversal. This must mean that it is helping to short-circuit
some delta computations even if it is not finding the most efficient
ones. The performance improvement cannot be explained only due to the
I/O cost of writing the resulting packfile.

The Linux kernel repository was the initial target of the default name
hash value, and its naming conventions are practically build to take the
most advantage of the default name hash values:

| Test         | V1 Time  | V2 Time  | V1 Size | V2 Size |
|--------------|----------|----------|---------|---------|
| Thin Pack    |   0.17 s |   0.07 s |   4.6 K |   4.6 K |
| Big Pack     |  17.88 s |  12.35 s | 201.1 M | 159.1 M |
| Shallow Pack |  11.05 s |  22.94 s | 269.2 M | 273.8 M |
| Repack       | 727.39 s | 566.95 s |   2.5 G |   2.5 G |

Here, the thin and big packs gain some performance boosts in time, with
a modest gain in the size of the big pack. The shallow pack, however, is
more expensive to compute, likely because similarly-named files across
different directories are farther apart in the name hash ordering in v2.
The repack also gains benefits in computation time but no meaningful
change to the full size.

Finally, an internal Javascript repo of moderate size shows significant
gains when repacking with --name-hash-version=2 due to it having many name
hash collisions. However, it's worth noting that only the full repack
case has significant differences from the v1 name hash:

| Test      | V1 Time   | V2 Time  | V1 Size | V2 Size |
|-----------|-----------|----------|---------|---------|
| Thin Pack |    8.28 s |   7.28 s |  16.8 K |  16.8 K |
| Big Pack  |   12.81 s |  11.66 s |  29.1 M |  29.1 M |
| Shallow   |    4.86 s |   4.06 s |  42.5 M |  44.1 M |
| Repack    | 3126.50 s | 496.33 s |   6.2 G | 855.6 M |

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..be5229a0ecd
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+GIT_TEST_PASSING_SANITIZE_LEAK=0
+export GIT_TEST_PASSING_SANITIZE_LEAK
+
+test_perf_large_repo
+
+test_expect_success 'create rev input' '
+	cat >in-thin <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1)
+	EOF
+
+	cat >in-big <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1000)
+	EOF
+
+	cat >in-shallow <<-EOF
+	$(git rev-parse HEAD)
+	--shallow $(git rev-parse HEAD)
+	EOF
+'
+
+for version in 1 2
+do
+	export version
+
+	test_perf "thin pack with version $version" '
+		git pack-objects --thin --stdout --revs --sparse \
+			--name-hash-version=$version <in-thin >out
+	'
+
+	test_size "thin pack size with version $version" '
+		test_file_size out
+	'
+
+	test_perf "big pack with version $version" '
+		git pack-objects --stdout --revs --sparse \
+			--name-hash-version=$version <in-big >out
+	'
+
+	test_size "big pack size with version $version" '
+		test_file_size out
+	'
+
+	test_perf "shallow fetch pack with version $version" '
+		git pack-objects --stdout --revs --sparse --shallow \
+			--name-hash-version=$version <in-shallow >out
+	'
+
+	test_size "shallow pack size with version $version" '
+		test_file_size out
+	'
+
+	test_perf "repack with version $version" '
+		git repack -adf --name-hash-version=$version
+	'
+
+	test_size "repack size with version $version" '
+		gitdir=$(git rev-parse --git-dir) &&
+		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
+		test_file_size "$pack"
+	'
+done
+
+test_done
-- 
gitgitgadget

