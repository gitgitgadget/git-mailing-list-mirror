Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5553321DC
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393593; cv=none; b=kYc7HEhmmWtpI0ZkPGiYghcc37VMeD6cI46v4beEsYfalneic8up9GbXUOU7N059wgcEePm5XVRYmdaI0x7miSJotJlWUGDPE3R/Wyewlb5+ME3IJ35d36xtVmC6FUX32kLPsKO1NWyKxFbh2oqgS3u2TJQ7S9yu/I1FjWOkLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393593; c=relaxed/simple;
	bh=LbHwbsSRObIKXgG6/GAGMTzOlaZOCtXaa7+uZISFc0s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GYIKwa1hbOZ7L7+wJQCkxNtZySsMZmWm8JPoC6+ko6UGWSpUAeHty2JdxZSX8v/HHu9vEBQiDrJ6zKsNku8ryOIUEl8Qnu8LQ13nHV5tf/Q81g9Y1gc+yRM8wdLX3dsF6qmSKv57vxut9lXjEJvFg/AY8Kt5L/2xJwH39jZo5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8+Yj8y+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8+Yj8y+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7de4e6c5a30so4052359a34.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393591; x=1777998391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4xodm3fjmxi+KQJTMUvyrLC0OV52p21gKVMP81J1fM=;
        b=I8+Yj8y+drBLMis1XNspr3fXwvMqX8MnPJZojT8tBtaw9wZfJ9jrGDIK2I6VO4+kok
         ZFfOazOk/hodQ2ZbVzwiSXNnw+vL+LKpvA3dfsxi0ebfyc50Rmd6IRA4FXaqccaNf6Se
         WbrzVzlCQOfwu1QOnKC7PCfxKvthKoAqKNxDATbvqF3pfeUnkWE8Prma59V0a3MJkOd8
         T0HgfKwfAfzakeB/Z5ZZvNlHEfNvM1MWNzmJCNXtt62pv23tO7Qe+/WjRLC8cKFcDrBz
         LC6rytwaaVNMF0LQCwTKNT/XCoU1XH+cQvP4HgaQ6WIJqtndf09H2A95MSTGkdQQmTIc
         XYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393591; x=1777998391;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4xodm3fjmxi+KQJTMUvyrLC0OV52p21gKVMP81J1fM=;
        b=bLb0LJprClBCb6RFbpMu1+n1/BE6lyZkxgmx4jUE/BAOIASolzkZcr2n2hhRvJC4jc
         4/DJzkVY76Awucg8NWW2b2B69qtfMLqkzwE9Th3Wn/f/Zu3tLcGPKHiZ+WoOz+8NTYoi
         03eShNvVEfW93LrE1LT136u8zp93IH+vooc13j4I5O3cXVSJQwo35Ta3cLrmEBa1rHYi
         ANcFcYwdYLXei22PbTrjafKYwaH4Q1jA7xVDVIi3zTYtCloszUw22wFAoeaezBjfrgod
         xoJ6wX5JCY3lckVaZ4jB4m+akiJXggGlNYQQsBAly75j87xEe+LymSxNSKaGj4pbzgYr
         hMcg==
X-Gm-Message-State: AOJu0YyYjVkGTMmF2MoIEKPf4YXkJCfW7E3Oti2DetrkrE9X875CGwgO
	6Fvj9MfzUHr2ByLrPl/0PBRKUm7fAW5d5cj6nToVm4BUjei+k5ImwpCKaELXMw==
X-Gm-Gg: AeBDievNSdty/aQeYKpRfSDGK2wc4x4qHQObDzX1KDgQiaOwaqyCbrdH165s9Dv4XVp
	GSvt/8Ruch94Y7oiF5OiOfSAVM8Z1Mcd74lrjhL01+l+qjp5pKaa5mN/IdPNMxpb3DiexF4go4r
	GpzwtNyl6yBDg7LyirhrT24Byl4E1YSxDD4oZhp7IViRvTQQ0Wa+ezjU4IFDkwYELg4mLWlDgSN
	Z5OFeTF2ldWk+cap5Ufm9yc4OcF4pZF0YFVQMlEQSmQYUkonCPCYSRd8LqNCxnjyM2DhsDiieYD
	K932oQdbHhBKV7KKTeicKGKhMdjEA0VFoBztxvbkQWxbQZYudrtmCqD7ABsoWO8HoRi2Um8+6ZB
	UbmnwHgdfBfLPz3mx5LI8CQP4REz3Rx6P4klG4NRYWTavrZIVa7Cy/SaGK33RhfCfHvpafcpvwy
	ZwxcgerFXA54WmQCrRVaAXs1NegaX+4Ku3zrecXQM=
X-Received: by 2002:a05:6830:264c:b0:7dc:e45a:adda with SMTP id 46e09a7af769-7dea679a2ddmr197299a34.19.1777393590917;
        Tue, 28 Apr 2026 09:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dea2d6b032sm501127a34.6.2026.04.28.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:26:30 -0700 (PDT)
Message-Id: <a3019888d8465e0f77926a91a20db170fef6989d.1777393580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 16:26:20 +0000
Subject: [PATCH 6/6] t5608: add regression test for >4GB object clone
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The shift overflow bug in index-pack and unpack-objects caused incorrect
object size calculation when the encoded size required more than 32 bits
of shift. This would result in corrupted or failed unpacking of objects
larger than 4GB.

Add a test that creates a pack file containing a 4GB+ blob using the
new 'test-tool synthesize pack --reachable-large' command, then clones
the repository to verify the fix works correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5608-clone-2gb.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 87a8cd9f98..af93302dde 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -49,4 +49,41 @@ test_expect_success 'clone - with worktree, file:// protocol' '
 
 '
 
+test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
+	large_blob_size=$((4*1024*1024*1024+1)) &&
+	git init --bare 4gb-repo &&
+	head_oid=$(test-tool synthesize pack \
+		--reachable-large "$large_blob_size" \
+		4gb-repo/objects/pack/test.pack) &&
+	git -C 4gb-repo index-pack objects/pack/test.pack &&
+	git -C 4gb-repo update-ref refs/heads/main $head_oid &&
+	git -C 4gb-repo symbolic-ref HEAD refs/heads/main
+'
+
+test_expect_success SIZE_T_IS_64BIT 'clone >4GB object via unpack-objects' '
+	# The synthesized pack has five objects, so a large unpack limit keeps
+	# fetch-pack on the unpack-objects path.
+	git -c fetch.unpackLimit=100 clone --bare \
+		"file://$(pwd)/4gb-repo" 4gb-clone-unpack &&
+
+	# Verify the large blob survived the clone by comparing its OID
+	# between source and clone.  We cannot use "cat-file -s" because
+	# object_info.sizep is still unsigned long, which truncates >4GB
+	# sizes on Windows.  OID equality proves content integrity since
+	# the clone already verified checksums via index-pack/unpack-objects.
+	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
+	clone_blob=$(git -C 4gb-clone-unpack rev-parse main^:file) &&
+	test "$source_blob" = "$clone_blob"
+'
+
+test_expect_success SIZE_T_IS_64BIT 'clone with >4GB object via index-pack' '
+	# Force fetch-pack to hand the pack to index-pack instead.
+	git -c fetch.unpackLimit=1 clone --bare \
+		"file://$(pwd)/4gb-repo" 4gb-clone-index &&
+
+	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
+	clone_blob=$(git -C 4gb-clone-index rev-parse main^:file) &&
+	test "$source_blob" = "$clone_blob"
+'
+
 test_done
-- 
gitgitgadget
