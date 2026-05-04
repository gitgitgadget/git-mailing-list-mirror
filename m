Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB9D31353B
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926087; cv=none; b=E1ayfaE0xSzwG/G1eBdmc3xWOVKTOgWFnWwL4qWYb5WZ0DzEHbE5V6zPxRIBwTCxJxnJm8oUaPigItnOqkAEDoTm1X/OAAbCnvQAmPx8U7TsdO9jPRw4WDdQaEU90H+LDUPOSKh8oqn5sGakjkl4gX+10XOAfVVDiSA74zRQ0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926087; c=relaxed/simple;
	bh=nTXHQwu3QLdizBTHrK+ybPNNKM0SMygDXKITerB35K0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qP98CBGoZ8Hz079e/CsXniw61rEqYF3C7sumKfmhbGtCMaz59usR0ZBNYLIoP6uEgK+LQH4Z5L54wx1q7Goho+qxBlX4DFGlqSbYTotMMzucXOQipdAFR4ywWf+1Nr9fMT53ta+vbM/o6mafnv1K94OzoEAtVbMh3qCYCsAXic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIpdVVDA; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIpdVVDA"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-900fa9f178dso224359785a.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926084; x=1778530884; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2Yqv+t7tlgZOJN6JK/l54MNrO5W1gi7r91xfTta6PM=;
        b=XIpdVVDAFnLrALNHbaqSVFnLXCofNuu0YXuL5skWQ1qsQ8QAD0C0ikeP/CcFm73uQz
         u7MlqGTrtlA5MZ1cF60OOts/35a3qLDMogYMDHxZcI1oCnMzgye0XJb+AqivRXaxC0is
         BBY8/BJRsWlkpYpt64h7oLGFTagyCbbjzZf77nh34ZZhIiTR6K59wwgHNWIGQTueg/+A
         Ys1KSR1u2kdDh71b/ticmdr0PezoydjaruYSKKyaQyrFFBF5S1La9Elfk9hueCjv5Dl5
         4hB0irwazfz9UAtEux9zav0ZlF/HD4xcuy/geBNPmXeEzS5GwzGjSb/W3MqBzej5h3Kc
         LeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926084; x=1778530884;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2Yqv+t7tlgZOJN6JK/l54MNrO5W1gi7r91xfTta6PM=;
        b=R6jXLh8mnBXnj3TVUQI/c5gH+pIzEZZomUGSthWKRpAcy+yi6OiBdKiWTiJi7zgbt1
         1nCYbYfyXuhHKASgcO76kbbM85XhlsrWmkAMEkIZHm5qgJrYewIJV68VJw3Daytjh2TO
         weztz+vpgKH03zWrR/I1TW3BukvNK0Eq93a9HS9RphFNuSNr7EjykjTIs+PB1TfC/T7s
         VHMqy5iQst2fuu/QHIglszfE4Nr5inZ01vLPMku08lZLMoZEVL/uM80D4KNpQBSgl2X+
         BqmTxdKPDo7DS6TJuMieiD5NZgH6vxriqPvjMOzTSVlYz75ZyTAA6mbICzyiTHB3R8qg
         wjwQ==
X-Gm-Message-State: AOJu0YzmnFFCz6Rv7l2QEij8ntwxVr4Nod/cSI/GzajJZsxkLelFeTFw
	Ek2lZrCO7MCNzun+KHsE1yAF9YfgEFEQTlMTayE7PtgkAGQgxpVkGn8MmAddPg==
X-Gm-Gg: AeBDietqGtEJkMIowcnDmFZa/kEpawMdQg+TpZx46J46g1V6MQrKFkwN+fHCHhFold4
	8w20hEE8SQJsJOvM5bjBp9BsK5D2LzU9dumXYEPNCgFeEPhP6ch49yLo5Q8uv85xElGqvr308c3
	TXr6I13j9cHMGc6eX01d0lKzUeISrT0w2GRZWga5g6XhGfUMX37Jpy9qsiW57JJtbhJrbmBQG7V
	uA+JRPgVSF+QFbcyMvsKaDJltDmHSVmtJglDiCPL4ViX4N7vIVI43n5GfI7ijp/LwBSw/Ah4glh
	6cxpYlWnzY7WUdvNWgYS+7J0EkZKbg2xKiG5YUzVITFrHnbKgMEY1eBhPfTulVnWNc3mKds84fd
	kGnZDP8juLrCWAsiHLBG+b/FkPr+0gFyzyDcjb6g1wA8/GUN75/hxAgSRH6ZiGJjkttyUUlX17O
	+AccSprVMjRPHIIntVb1oBTDu0rU625m9PHIQH
X-Received: by 2002:a05:6214:4c92:b0:8b1:f297:a54b with SMTP id 6a1803df08f44-8b665f017a8mr178961486d6.18.1777926083912;
        Mon, 04 May 2026 13:21:23 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e7d3esm143408866d6.28.2026.05.04.13.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:23 -0700 (PDT)
Message-Id: <9ea81aa7269c6fac61723ff46323549f35f5d06d.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:11 +0000
Subject: [PATCH v2 02/10] t/perf: add pack-objects filter and path-walk
 benchmark
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

