Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69FB27814A
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419143; cv=none; b=mO2wGeBI47ZPhn4Y0zdY0W+6AECERJjp30LxiGaigtMwo4f8XOEug5SSz5KxAsypPSCHRUhSkTopPOoc4L2hBB167sTYzNRTQN8d3OMQV761MXpmdxtnbJ2k2wBLoja7M3LiJAgb+n13PfQPCY/ug4JFjiRjzu56gC8LA76S9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419143; c=relaxed/simple;
	bh=ibCXeGSjs0ssCK9ic6RCA7Vd481i/akL5IT/woY4ZI4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aJQsD7DIAzzzFI335I6iLapFO6kbIOKufr0fDL/AERyW4+Wd0e/8UTk88sacxJ/UFh49QY00LgoeCa6Z0rs4MJXbQTdqQB68GiAN47yhFpVGfCuemhhAjEuu+S5XHH+EUhvxqS2DHb/burzTIQObHbVE41l/lYyQhvtkuAhvHRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUkE4FTk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUkE4FTk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1d8c09683so1672125f8f.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419140; x=1748023940; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwx1upnnPwebS2dBgwmzgJtFdUoGJxip46g8AElACFU=;
        b=dUkE4FTkzvU/DtT8fZBP6hAL7EqDyzEnHzvqcSUfjHNbqFAr+GiOjo/XejDTX5aR69
         cxw0KDRPKWHOvlzfqiu5ISppZ6v/Lnxcs1CyHPUJor+ZCmdJof97ftHdaNuRg+BkU8GK
         6e2XklIO/mIfd9lDDfm4qgJbpFeKxXKuSypRvvQULFkOPOtyEVwfFMxcXmX39MLtiXR/
         QfM8siBgdHbGaaQ6SWZyIdyCRGeXoLR3IgCOGBrUIz9xFZMmmJMQQmOb3k6X3K9gY3i2
         Yke4WzQYupaUYoSBn8oSiHUHKJTqdPC6bvrVuOU2gUyC/MinkBStvr2RerJYs7kGrTCS
         VPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419140; x=1748023940;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwx1upnnPwebS2dBgwmzgJtFdUoGJxip46g8AElACFU=;
        b=oxVFwT4XqGBrgAxsuYOu72YrtmVjYnYui+5F9QBVW+DIyQT18QldIYZD0Ox3r5MznN
         fAype1+m7Efrb7MZvM2iPqffbqLQXqksQ6EQwF2abikbMTb7AcSgCxZCLIrcdbYeB2wY
         zNaoCZYePuiVTbY8M/jBhnmkJmduCZy/GzOUuwymdd9K1RRQyoPl0hRYi6mee7nFGTZX
         R0uP2rkqOI8mWCdOgq3e6Rf9NJYXLMs2h+DCQ+M+5c7nHRuwo/Vlxc+l5LHZvyJsYkIY
         wnhZ0oFMeko3SmsweA1MlM65oGgiCXNAHpCWw4aVV8kQ8vbE2w0d3mB/0ebKSjEWmIVm
         jaOw==
X-Gm-Message-State: AOJu0YxZBwb4784xSJbI1aOmFjv8TSfbEfbVGofwIo71XEgNDjZ2gR9n
	PzQqty2Ao0gynseG3ejpmtWWkTAyzTtIJhhtkC2h0SCXWs0JDBAokctTyd6wrg==
X-Gm-Gg: ASbGnctJk+VuyoAVh9fagW6i5t7TS97qfkHPWp0dexZex0gGE6eRaI8OPhqiQGXvGqr
	wckrWnRhQeWoraMcUKBjp7Jd/pnmnR4MFaQz0JiXxUoF4A2BtSQVPL+04YvSVotiNHQvTxBJYBC
	qgwrjJBQvvcQQBiyExQdHRDDgLtVYRYwOzE+NDjIfGzO72SZ1rRupEqiM9WnNhXW6Xf+wn+mrjw
	X0ikMWp4CEABljIY2tZdLlynL79Iey8rBRX8/4kruC1ReoIm9HemX9i3QiwmRRjMZAOBZayX2AA
	CGfgxCl98M0y0b3Q0tKYaQP74fJ2LDYAATtMnP8cvGJe3hQlQ5rl
X-Google-Smtp-Source: AGHT+IFtPp/DotAF+0UFHPcjw5uEdVQgF6ifBL+zveS9FpYXs1t1G8bcYwrN1L9Fhh66OhZ91g/X9A==
X-Received: by 2002:a05:6000:4201:b0:3a3:5c05:69e with SMTP id ffacd0b85a97d-3a35c85300emr4723224f8f.46.1747419139712;
        Fri, 16 May 2025 11:12:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d310sm3624444f8f.17.2025.05.16.11.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:18 -0700 (PDT)
Message-Id: <ad65148558eb698c6e7a8bbc1cfb6e6e6004e973.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:54 +0000
Subject: [PATCH v3 04/13] p5313: add performance tests for --path-walk
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change added a --path-walk option to 'git pack-objects'.
Create a performance test that demonstrates the time and space benefits
of the feature.

In order to get an appropriate comparison, we need to avoid reusing
deltas and recompute them from scratch.

Compare the creation of a thin pack representing a small push and the
creation of a relatively large non-thin pack.

Running on my copy of the Git repository results in this data (removing
the repack tests for --name-hash-version):

Test                                                     this tree
------------------------------------------------------------------------
5313.2: thin pack with --name-hash-version=1             0.02(0.01+0.01)
5313.3: thin pack size with --name-hash-version=1                   1.6K
5313.4: big pack with --name-hash-version=1              2.55(4.20+0.26)
5313.5: big pack size with --name-hash-version=1                   16.4M
5313.6: shallow fetch pack with --name-hash-version=1    1.24(2.03+0.08)
5313.7: shallow pack size with --name-hash-version=1               12.2M
5313.10: thin pack with --name-hash-version=2            0.03(0.01+0.01)
5313.11: thin pack size with --name-hash-version=2                  1.6K
5313.12: big pack with --name-hash-version=2             1.91(3.23+0.20)
5313.13: big pack size with --name-hash-version=2                  16.4M
5313.14: shallow fetch pack with --name-hash-version=2   1.06(1.57+0.10)
5313.15: shallow pack size with --name-hash-version=2              12.5M
5313.18: thin pack with --path-walk                      0.03(0.01+0.01)
5313.19: thin pack size with --path-walk                            1.6K
5313.20: big pack with --path-walk                       2.05(3.24+0.27)
5313.21: big pack size with --path-walk                            16.3M
5313.22: shallow fetch pack with --path-walk             1.08(1.66+0.07)
5313.23: shallow pack size with --path-walk                        12.4M

This can be reformatted as follows:

Pack Type            Hash v1   Hash v2     Path Walk
---------------------------------------------------
thin pack    (time)    0.02s      0.03s      0.03s
             (size)    1.6K       1.6K       1.6K
big pack     (time)    2.55s      1.91s      2.05s
             (size)   16.4M      16.4M      16.3M
shallow pack (time)    1.24s      1.06s      1.08s
             (size)   12.2M      12.5M      12.4M

Note that the timing is slower because there is no threading in the
--path-walk case (yet). Also, the shallow pack cases are really not
using the --path-walk logic right now because it is disabled until some
additions are made to the path walk API.

The cases where the --path-walk option really shines is when the default
name-hash is overwhelmed with unhelpful collisions. An open source
example can be found in the microsoft/fluentui repo [1] at a certain
commit [2].

[1] https://github.com/microsoft/fluentui
[2] e70848ebac1cd720875bccaa3026f4a9ed700e08

Running the tests on this repo results in the following comparison table:

Pack Type            Hash v1    Hash v2    Path Walk
---------------------------------------------------
thin pack    (time)    0.36s      0.12s      0.08s
             (size)    1.2M      22.0K      18.4K
big pack     (time)    2.00s      2.90s      2.21s
             (size)   20.4M      25.9M      19.5M
shallow pack (time)    1.41s      1.80s      1.65s
             (size)   34.4M      33.7M      33.6M

Notice in particular that in the small thin pack, the time performance
has improved from 0.36s for --name-hash-version=1 to 0.08s and this is
likely due to the improved size of the resulting pack: 18.4K instead of
1.2M.  The relatively new --name-hash-version=2 is competitive with
--path-walk (0.12s and 22.0K) but not quite as successful.

Finally, running this on a copy of the Linux kernel repository results
in these data points:

Pack Type            Hash v1    Hash v2    Path Walk
---------------------------------------------------
thin pack    (time)    0.03s      0.13s      0.03s
             (size)    4.6K       4.6K       4.6K
big pack     (time)   15.29s     12.32s     13.92s
             (size)  201.1M     159.1M     158.5M
shallow pack (time)   10.88s     22.93s     22.74s
             (size)  269.2M     273.8M     267.7M

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 37 ++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index be5229a0ecdc..cd6dd3abb710 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -25,46 +25,55 @@ test_expect_success 'create rev input' '
 	EOF
 '
 
-for version in 1 2
-do
-	export version
+test_all_with_args () {
+	parameter=$1
+	export parameter
 
-	test_perf "thin pack with version $version" '
+	test_perf "thin pack with $parameter" '
 		git pack-objects --thin --stdout --revs --sparse \
-			--name-hash-version=$version <in-thin >out
+			$parameter <in-thin >out
 	'
 
-	test_size "thin pack size with version $version" '
+	test_size "thin pack size with $parameter" '
 		test_file_size out
 	'
 
-	test_perf "big pack with version $version" '
+	test_perf "big pack with $parameter" '
 		git pack-objects --stdout --revs --sparse \
-			--name-hash-version=$version <in-big >out
+			$parameter <in-big >out
 	'
 
-	test_size "big pack size with version $version" '
+	test_size "big pack size with $parameter" '
 		test_file_size out
 	'
 
-	test_perf "shallow fetch pack with version $version" '
+	test_perf "shallow fetch pack with $parameter" '
 		git pack-objects --stdout --revs --sparse --shallow \
-			--name-hash-version=$version <in-shallow >out
+			$parameter <in-shallow >out
 	'
 
-	test_size "shallow pack size with version $version" '
+	test_size "shallow pack size with $parameter" '
 		test_file_size out
 	'
+}
 
-	test_perf "repack with version $version" '
+for version in 1 2
+do
+	export version
+
+	test_all_with_args --name-hash-version=$version
+
+	test_perf "repack with --name-hash-version=$version" '
 		git repack -adf --name-hash-version=$version
 	'
 
-	test_size "repack size with version $version" '
+	test_size "repack size with --name-hash-version=$version" '
 		gitdir=$(git rev-parse --git-dir) &&
 		pack=$(ls $gitdir/objects/pack/pack-*.pack) &&
 		test_file_size "$pack"
 	'
 done
 
+test_all_with_args --path-walk
+
 test_done
-- 
gitgitgadget

