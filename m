Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2158AA8
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695555; cv=none; b=KcOVLdG5PvaHzeLBzSkkIPJv8L1H5/jVM5cyfL9N0XhjIPRYoKuWgYycX9gvy9Srawc2gWxxy7+7GE7BBTkN9SHTfkHNSL1GyeWMGyA1RZkxF9Ipiob69OphCbOmGImdJZ718IqVim5g9j14glKED8O49H9gVnZk2zUz1biPsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695555; c=relaxed/simple;
	bh=ejqNHH5KjAGEhLO2wXgrqJb7tXVf68mEg1yp5eJbapk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rlg95Ijcjw1Keto7xxsxvRzCFhZXPC2xgpHAmaGeEl4aaGOK6fgj2YHLe+wgtKUfD2hS2OnAdrQPQd8bEpoXk7WtzKF5UrZbjTwBHwUloYQdAidc2J3xHXRwj92F7VQ+BTzppVPy1kTkFnYOYDklVeS70zJpQUHCHdhklJzwsJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ2irkrd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ2irkrd"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-338aca547d9so847163f8f.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695552; x=1706300352; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvaBrntQ+N1TnDrJtNuUCqAW79T8hXzXkq3CXl/qwHQ=;
        b=PQ2irkrdcgGVE8ZuNoJbERYwdGirWfHp1wpcOb9vnte/cglzBH780Ra7PjuyWmQZSw
         hqZKy7d8mx+LCaGPgwldYPo6R0qq31qbFLU+/tc8mZGDoJw8dbSvVDfSKq/h8fOxL7d1
         iQFcO8pSLiokdZ9v9aRCnsDWS/yFZaVdSO+KGkMgYA8mVWKCyLHiYUHYT5+kbgQIkif2
         +bo1KuyiLOsHqOWQeqAUN/Qt7MPiP4WqYOt1Qx3pT36y472JJGqErGC+gaPa3tBKwa4q
         d9p67FQSWkCVssmAJFZhC6JnJGNf1huBIJ8aDI1J49jPNZF5H10cdQhXxYdpurqaXsT6
         QeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695552; x=1706300352;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvaBrntQ+N1TnDrJtNuUCqAW79T8hXzXkq3CXl/qwHQ=;
        b=kt2k6NKK+13SUxXNQk3NiuLJE64OeE70pJ+H9YUJVeV5BzSSdj1ywfYFXs3hjWZ2qB
         RselpqSwCoUsPGpHcr+2YS8pNy7KTWX3/Zc3M3RRk8ArvRMlxexw7WPKuscpCjU5RB2j
         6GQ93km5nlycpe2tsaloAzeIrsUKOMNay4QLniiDb+z8suYjL0BjbAdWi9+43L0RMerQ
         pM6XKfwQ3s/Cl7+xYdHdrxdx8LdigmBCrzPWzILvsF4hkrejcKK3F2SaIDJd2rF58EIa
         z1VF4zY83jOtir2xAtH80jtQzBBJ3pofX+2jHjuwCT84YZ/Cf0FagzMnm78zkGgjINTk
         BeDw==
X-Gm-Message-State: AOJu0Yx+/NlfKfysyCHVcewlX3L9zgRKS2pQHeGZXgdgTQiUKMRGTyJS
	Wlbf84OAgF27GRnA3TTyQ991MbrNQzEFVwo67srF40FFqxJmxepM4umQG8A+
X-Google-Smtp-Source: AGHT+IH5Yi6eX88Oaabf9zv+t1EtG8H3aNLuxRr+rTVKHiqrPsFRDAsNocpCHTPJYN27FeEWfDke7A==
X-Received: by 2002:a5d:5f8b:0:b0:337:eec:62e3 with SMTP id dr11-20020a5d5f8b000000b003370eec62e3mr88947wrb.17.1705695552147;
        Fri, 19 Jan 2024 12:19:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020adfee46000000b00337cf4a20c6sm4661425wro.31.2024.01.19.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:11 -0800 (PST)
Message-ID: <7329e87148a7f8d4f8bd1b0fd3a0b1e0bc9e9e69.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:19:00 +0000
Subject: [PATCH v2 12/12] t5312: move reffiles specific tests to t0601
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
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move a few tests into t0601 since they specifically test the packed-refs
file and thus are specific to the reffiles backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0601-reffiles-pack-refs.sh | 30 ++++++++++++++++++++++++++++++
 t/t5312-prune-corruption.sh   | 26 --------------------------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index c2c19befacc..263e99cd84b 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -328,4 +328,34 @@ test_expect_success 'refs/worktree must not be packed' '
 	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
 '
 
+# we do not want to count on running pack-refs to
+# actually pack it, as it is perfectly reasonable to
+# skip processing a broken ref
+test_expect_success 'create packed-refs file with broken ref' '
+	test_tick && git commit --allow-empty -m one &&
+	recoverable=$(git rev-parse HEAD) &&
+	test_tick && git commit --allow-empty -m two &&
+	missing=$(git rev-parse HEAD) &&
+	rm -f .git/refs/heads/main &&
+	cat >.git/packed-refs <<-EOF &&
+	$missing refs/heads/main
+	$recoverable refs/heads/other
+	EOF
+	echo $missing >expect &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack-refs does not silently delete broken packed ref' '
+	git pack-refs --all --prune &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pack-refs does not drop broken refs during deletion' '
+	git update-ref -d refs/heads/other &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 230cb387122..d8d2e304687 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -111,30 +111,4 @@ test_expect_success 'pack-refs does not silently delete broken loose ref' '
 	test_cmp expect actual
 '
 
-# we do not want to count on running pack-refs to
-# actually pack it, as it is perfectly reasonable to
-# skip processing a broken ref
-test_expect_success REFFILES 'create packed-refs file with broken ref' '
-	rm -f .git/refs/heads/main &&
-	cat >.git/packed-refs <<-EOF &&
-	$missing refs/heads/main
-	$recoverable refs/heads/other
-	EOF
-	echo $missing >expect &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success REFFILES 'pack-refs does not silently delete broken packed ref' '
-	git pack-refs --all --prune &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success REFFILES  'pack-refs does not drop broken refs during deletion' '
-	git update-ref -d refs/heads/other &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
 test_done
-- 
gitgitgadget
