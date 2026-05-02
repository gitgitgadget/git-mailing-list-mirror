Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366922BF3F4
	for <git@vger.kernel.org>; Sat,  2 May 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731362; cv=none; b=OVlT9wSySnEQ3RM2DgvHql5uJSQu0FHn1ZkaymmtrXMx62D7mgQABGdKHAaYwF+8rqr9b0ha9lRjzswrxcYkv6UgEPpElq53keSYr9ISGb6cXhG+g7AzcmRMxqEVNWQHGUG4VKF6G6ncSeuQV1V1KJk7wpcHz/SLKILe/T61HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731362; c=relaxed/simple;
	bh=nTXHQwu3QLdizBTHrK+ybPNNKM0SMygDXKITerB35K0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BUqlxcaSI8iRey7nRvdLLThl5oH/cOTtD5H8m07QcwX0yUt6gazJn8GkjifdGD2n4uY+4rUifTj5iDIffAYr5NIoERDpM3dZ+m+gmyE5+YPJXvwRmiZmnzYzxKdCLnmPrCB/DfSr8AZjEwyPKoejeohhY+1gy9wOUrz7cipaAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpr8Lcjy; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpr8Lcjy"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c8ccc7755so4044330c88.0
        for <git@vger.kernel.org>; Sat, 02 May 2026 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731360; x=1778336160; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2Yqv+t7tlgZOJN6JK/l54MNrO5W1gi7r91xfTta6PM=;
        b=Cpr8Lcjy4I2UmbFg/lnygSQLt//UQiRzHeOBR+W60GprxqRl752YxWqLr4ZnWNR/Rt
         smkbkYv0/GTWSUAv+aphzLC8oCk7z233xV8o57X8/wRhjRSyMLQt15Ad44YBZzPRScGR
         /ITDL6IDe/jTbctZpCDmgoV8rnXMOFHPrhCz3dOG01y3mxBBPvzYpCrCwUB3OM6fDx0U
         +uaiaKv9L2ZVWbIjp182rSlVMUF4bZNwaHLEXZZJY4ZR2h1ze9sL87DOLSMhg6AvdQAj
         IBia4O3AA6zo4GyiRgLMiymDXsz9AYnpl7R2HsEPFtvq+Uma5SMElt09hZDENzJ/FnCI
         ky/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731360; x=1778336160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2Yqv+t7tlgZOJN6JK/l54MNrO5W1gi7r91xfTta6PM=;
        b=lSwGeVmEt4n/sLutBz0wXXBN3bjZ0TLv2wq9H4ugIAG1X35CoO6xSaqmnU81YfYqZm
         Nq4JsJ7dFmytbGTg6R/Nsus2PYdcycCdsGgvLBnQC6EjBtNtHt4SBJXWbg8dcCnurpr/
         K022swLwhSqbSNsipACCzHQ+ZKewg/0QhBGuk16dfvYAWRPYivsHZh4rbtBygRROl5T7
         WlOkug55Y0kRDYLhou/32LLKMj4wHZYlOm2YezEg8eR/3NFpEhThLbt6PukLr0cj0y8+
         j/IsYhxCrB412qpy9MPsUe61sKctZZpvj0uOanw6UDrJHS5JI+DMBJ/PAZIvDRWPvBSW
         WYYA==
X-Gm-Message-State: AOJu0YyY30IN4pA2TauKlw3n4mG3E29DyF0D/zHXGibYe4teIKIRPFzI
	LGwRoTXbHZ+gSyc+nc/IAU2CoKxG9CZKT+6pxL4p479DieXfidK+Kxc1ElctqTUY
X-Gm-Gg: AeBDiesNTYmRuvGBga+G+4gnCTIHRprgMjXphrphYV2GzBY8MMod6PULLoQw/qd/cSr
	o6n2uLlalRfTfF1obzj4KPeVWfV7nQOwi+GqLUbmECJC2wLFyP9k7pqjMNctN2c6O0gn9Exw1GH
	xDxEGr5SGS5/gXjXXF6eZ7+7yK65aZfbTOcgTH3pSK02JxB7fVx4GpGgQubTwjOwK6gmltdEF/U
	tMrQfvh2p1LLRfT9uUo5EluqW6m1fdgD0xxVK0RRbc3qomGipmC6OppbHtu3e+wOIUAWhiQSr3x
	hT7szif4YEL66vF28N9+AAzecqUAlZ1O0+EIdxa/SK0b7T310chZ8pFQGa3+gnuluAHu+bTEDBZ
	k8m6l8s7cPZz4TA2Xkgopkmd/JFX5/aohpZNEG2ZVkRSpwN0qAXDdTVBbQ2IL9ldd2w1EG5YUTw
	f7O/Ii6ooNNI+WNcy9F/QFagXZL0xx21AX4y0F
X-Received: by 2002:a05:7022:608:b0:12a:b932:81d3 with SMTP id a92af1059eb24-12dfd82131bmr1294742c88.26.1777731359731;
        Sat, 02 May 2026 07:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8295552sm6892080c88.7.2026.05.02.07.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:15:59 -0700 (PDT)
Message-Id: <f3646218153ecfe5d534033cb54b1a43733ca3dd.1777731354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 14:15:49 +0000
Subject: [PATCH 2/7] t/perf: add pack-objects filter and path-walk benchmark
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
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add p5315-pack-objects-filter.sh to measure the performance of
'git pack-objects --revs --all' under different filter and traversal
combinations:

 * no filter (baseline)
 * --filter=blob:none (blobless)
 * --filter=sparse:oid=<oid> (cone-mode sparse)

Each filter scenario is tested both with and without --path-walk,
producing paired measurements that show the impact of the path-walk
traversal for each filter type as we integrate the --path-walk feature
with different --filter options. It currently has no integration so
falls back to the standard revision walk. Thus, there are no significant
differences in the current results other than a full repack (and even
then, the --path-walk feature is not incredibly different for the
default Git repository):

Test                                             HEAD
-----------------------------------------------------
5315.2: repack (no filter)                      27.91
5315.3: repack size (no filter)                250.7M
5315.4: repack (no filter, --path-walk)         34.92
5315.5: repack size (no filter, --path-walk)   220.0M
5315.6: repack (blob:none)                      13.63
5315.7: repack size (blob:none)                137.6M
5315.8: repack (blob:none, --path-walk)         13.48
5315.9: repack size (blob:none, --path-walk)   137.7M
5315.10: repack (sparse:oid)                    72.67
5315.11: repack size (sparse:oid)              187.4M
5315.12: repack (sparse:oid, --path-walk)       72.47
5315.13: repack size (sparse:oid, --path-walk) 187.4M

The sparse filter definition is built automatically by sampling
depth-2 directories from the test repository, making the test work
on any repo passed via GIT_PERF_LARGE_REPO. For repos that lack
depth-2 directories, a single top-level directory is used; for flat
repos, the sparse tests are skipped via prerequisite.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5315-pack-objects-filter.sh | 129 ++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh

diff --git a/t/perf/p5315-pack-objects-filter.sh b/t/perf/p5315-pack-objects-filter.sh
new file mode 100755
index 0000000000..b009039c89
--- /dev/null
+++ b/t/perf/p5315-pack-objects-filter.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='Tests pack-objects performance with filters and --path-walk'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup filter inputs' '
+	# Sample a few depth-2 directories from the test repo to build
+	# a cone-mode sparse-checkout definition.  The sampling picks
+	# directories at evenly-spaced positions so the choice is stable
+	# and scales to repos of any shape.
+
+	git ls-tree -d --name-only HEAD >top-dirs &&
+	top_nr=$(wc -l <top-dirs) &&
+
+	>depth2-dirs &&
+	while read tdir
+	do
+		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null |
+		sed "s|^|$tdir/|" >>depth2-dirs || return 1
+	done <top-dirs &&
+
+	d2_nr=$(wc -l <depth2-dirs) &&
+
+	if test "$d2_nr" -ge 2
+	then
+		# Pick two directories from evenly-spaced positions.
+		first=$(sed -n "1p" depth2-dirs) &&
+		mid=$(sed -n "$((d2_nr / 2 + 1))p" depth2-dirs) &&
+
+		p1=$(dirname "$first") &&
+		p2=$(dirname "$mid") &&
+
+		# Build cone-mode sparse-checkout patterns.
+		{
+			echo "/*" &&
+			echo "!/*/" &&
+			echo "/$p1/" &&
+			echo "!/$p1/*/" &&
+			if test "$p1" != "$p2"
+			then
+				echo "/$p2/" &&
+				echo "!/$p2/*/"
+			fi &&
+			echo "/$first/" &&
+			if test "$first" != "$mid"
+			then
+				echo "/$mid/"
+			fi
+		} >sparse-patterns &&
+
+		git hash-object -w sparse-patterns >sparse-oid &&
+		echo "Sparse cone: $first $mid" &&
+		cat sparse-patterns &&
+		test_set_prereq SPARSE_OID
+	elif test "$top_nr" -ge 1
+	then
+		# Fallback: use a single top-level directory.
+		first=$(sed -n "1p" top-dirs) &&
+		{
+			echo "/*" &&
+			echo "!/*/" &&
+			echo "/$first/"
+		} >sparse-patterns &&
+
+		git hash-object -w sparse-patterns >sparse-oid &&
+		echo "Sparse cone: $first" &&
+		cat sparse-patterns &&
+		test_set_prereq SPARSE_OID
+	fi
+'
+
+test_perf 'repack (no filter)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all </dev/null >pk
+'
+
+test_size 'repack size (no filter)' '
+	test_file_size pk
+'
+
+test_perf 'repack (no filter, --path-walk)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all --path-walk </dev/null >pk
+'
+
+test_size 'repack size (no filter, --path-walk)' '
+	test_file_size pk
+'
+
+test_perf 'repack (blob:none)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all --filter=blob:none </dev/null >pk
+'
+
+test_size 'repack size (blob:none)' '
+	test_file_size pk
+'
+
+test_perf 'repack (blob:none, --path-walk)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all --path-walk \
+		--filter=blob:none </dev/null >pk
+'
+
+test_size 'repack size (blob:none, --path-walk)' '
+	test_file_size pk
+'
+
+test_perf 'repack (sparse:oid)' \
+	--prereq SPARSE_OID '
+	git pack-objects --stdout --no-reuse-delta --revs --all \
+		--filter=sparse:oid=$(cat sparse-oid) </dev/null >pk
+'
+
+test_size 'repack size (sparse:oid)' \
+	--prereq SPARSE_OID '
+	test_file_size pk
+'
+
+test_perf 'repack (sparse:oid, --path-walk)' \
+	--prereq SPARSE_OID '
+	git pack-objects --stdout --no-reuse-delta --revs --all --path-walk \
+		--filter=sparse:oid=$(cat sparse-oid) </dev/null >pk
+'
+
+test_size 'repack size (sparse:oid, --path-walk)' \
+	--prereq SPARSE_OID '
+	test_file_size pk
+'
+
+test_done
-- 
gitgitgadget

