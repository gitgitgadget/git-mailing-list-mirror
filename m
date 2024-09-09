Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E61BBBF8
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890219; cv=none; b=rSmWqIXacamoPWet/3ZuFoBzxjY5o8Eks/z5P5azY7uExtnfBdQ7LbUV9Gl/GTvlYVlYb/q2m0SNM2NCC+edPT7bCVHXsiiHevXf9bLkIauML4o+gOARp19ii+y5Dg8RxIzeZDFc88bcbjq+FR5LUNcM5p3IMixmFvrChFLm4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890219; c=relaxed/simple;
	bh=h61VfJ5PRvX70y5Cj/PmoU7PbTfdMKY9wPBYa0T28H8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pgR8EqzO5gH+lq7b0LPnAeG3LIWkleaGAF5c3G2dPR+pDW2JlKV/GEQwhRMI3OYBPkO6q6/tz0iAFLBQARvOgBznbJ9CJl+RdhA50gu2adc0FJr5nF7MYe/+3rtGGNunA03i693fXjySS0QjACrOC5zI01dAaCggAGHW56Hi47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctwq/Nbf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctwq/Nbf"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso395448266b.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890215; x=1726495015; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4WYr7D2VHDGk880NsIJoejctM1hF9UmVMWSgrDcxxM=;
        b=Ctwq/NbfRNoe98E1txa+d3MwGtVsW6nouGE6sWsccPdMZx2nPlxTOHpzSmxbjoCoV8
         T0HSOKjH+6TWGlwllXBhKbt8MGMmUjTz8aloPXUhyENOotj7PrV5R4iHCghOcPBTusBc
         CXpoD4maqOlDcze3MAcHQQ3MgM+Gl7l0n4Cx7vMmr2hwIgDRMGVYKpmCzXycNZNMzAu3
         OKhcSk0FL8lqfnJo88STPeg5WcMQmObKEhEMbIFNfBBS+RyRPCgY02LZRZrnapF8soVh
         spB7D6tCCXO0Y/W+sMaIRVJKKlpVcD6MWu+C0txUMR3rSRd5+BYXKm7V6kCohYLXsJTe
         HRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890215; x=1726495015;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4WYr7D2VHDGk880NsIJoejctM1hF9UmVMWSgrDcxxM=;
        b=JoFMMREQFQDOSEfCkcofJ1yPxYP72JoxaMAmJCeJUmk7NoYqLokPzhDjwAcKa1B8hZ
         CBaYuYEExYpk0USYjdSwXtibbLdk5eYJ6leOY9cGLR0eH6cJAC9Ru95hWxAy4LE98SGB
         tHjiui3YRM43jhhXjHo6hynTauz5605DkWZUUtOxFJIBhfBPgdfovHfNBJOkMF0M37EP
         njCIDLfuJZntJrOeDZWA1hfvMnCLlL2VdTtcrBT2vxa2DJAjHGZk0q2zXzNxZA4+vbgr
         uDxSelkal4eFRw9PlTclRiADOj9DPnIoxnWBpfkauKcxKxvL16ivexfr3dKMXshr9HBc
         m0ww==
X-Gm-Message-State: AOJu0YxSldxqqyNFjZTZAgzZ6f5l/B/Y++ymU5Ngdg79AuyiukkToOFQ
	ZTjSD5SzqPOMjbfuirPZHBTNbAXe2fkSrhAImV9cDV4VSr7224vwCI/5yA==
X-Google-Smtp-Source: AGHT+IEFA52Bs4m0E041moZJK/uhn6ToSuIg65fOX0urxjFtZQIVluFJ/tdOwBo+FNvLjgo5nGbLLQ==
X-Received: by 2002:a17:907:6ea3:b0:a8d:29b7:ecee with SMTP id a640c23a62f3a-a8d29b7ef1emr496607266b.61.1725890214489;
        Mon, 09 Sep 2024 06:56:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25833c90sm345793066b.25.2024.09.09.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:56:54 -0700 (PDT)
Message-Id: <ed3ea4281a909edac8623734283ef9c87548ec62.1725890211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Sep 2024 13:56:49 +0000
Subject: [PATCH 3/4] p5313: add size comparison test
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

As custom options are added to 'git pack-objects' and 'git repack' to
adjust how compression is done, use this new performance test script to
demonstrate their effectiveness in performance and size.

The recently-added --full-name-hash option swaps the default name-hash
algorithm with one that attempts to uniformly distribute the hashes
based on the full path name instead of the last 16 characters.

This has a dramatic effect on full repacks for repositories with many
versions of most paths. It can have a negative impact on cases such as
pushing a single change.

This can be seen by running pt5313 on the open source fluentui
repository [1]. Most commits will have this kind of output for the thin
and big pack cases, though certain commits (such as [2]) will have
problematic thin pack size for other reasons.

[1] https://github.com/microsoft/fluentui
[2] a637a06df05360ce5ff21420803f64608226a875

Checked out at the parent of [2], I see the following statistics:

Test                                           this tree
------------------------------------------------------------------
5313.2: thin pack                              0.02(0.01+0.01)
5313.3: thin pack size                                    1.1K
5313.4: thin pack with --full-name-hash        0.02(0.01+0.00)
5313.5: thin pack size with --full-name-hash              3.0K
5313.6: big pack                               1.65(3.35+0.24)
5313.7: big pack size                                    58.0M
5313.8: big pack with --full-name-hash         1.53(2.52+0.18)
5313.9: big pack size with --full-name-hash              57.6M
5313.10: repack                                176.52(706.60+3.53)
5313.11: repack size                                    446.7K
5313.12: repack with --full-name-hash          37.47(134.18+3.06)
5313.13: repack size with --full-name-hash              183.1K

Note that this demonstrates a 3x size _increase_ in the case that
simulates a small "git push". The size change is neutral on the case of
pushing the difference between HEAD and HEAD~1000.

However, the full repack case is both faster and more efficient.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..88ea0a4698a
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,71 @@
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
+	cat >in-big <<-EOF
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1000)
+	EOF
+'
+
+test_perf 'thin pack' '
+	git pack-objects --thin --stdout --revs --sparse  <in-thin >out
+'
+
+test_size 'thin pack size' '
+	wc -c <out
+'
+
+test_perf 'thin pack with --full-name-hash' '
+	git pack-objects --thin --stdout --revs --sparse --full-name-hash <in-thin >out
+'
+
+test_size 'thin pack size with --full-name-hash' '
+	wc -c <out
+'
+
+test_perf 'big pack' '
+	git pack-objects --stdout --revs --sparse  <in-big >out
+'
+
+test_size 'big pack size' '
+	wc -c <out
+'
+
+test_perf 'big pack with --full-name-hash' '
+	git pack-objects --stdout --revs --sparse --full-name-hash <in-big >out
+'
+
+test_size 'big pack size with --full-name-hash' '
+	wc -c <out
+'
+
+test_perf 'repack' '
+	git repack -adf
+'
+
+test_size 'repack size' '
+	du -a .git/objects/pack | sort -nr | awk "{ print \$1; }" | head -n 1
+'
+
+test_perf 'repack with --full-name-hash' '
+	git repack -adf --full-name-hash
+'
+
+test_size 'repack size with --full-name-hash' '
+	du -a .git/objects/pack | sort -nr | awk "{ print \$1; }" | head -n 1
+'
+
+test_done
-- 
gitgitgadget

