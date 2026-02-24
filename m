Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC6218AB9
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911272; cv=none; b=PoIxbjVn3GCs/N6Hi87mhzYwsiJ95PG9aA118+9uVjOYoLUxA0vmYM6GT4W6igm57ckWYPYQPwp+VkXp8Nv/J1R7SYCDfY9EK6RNa/hUSJ3QbtfNvQRpff8vT5JNrc1DuQfQifu7l93zPQ7bTtSFSwOuBs1DYWH+fINAQP0EEl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911272; c=relaxed/simple;
	bh=s2b/Bgx8z2izDBAtQSx5D0cKhsAPlselriCtzUgvDls=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FIOr721apehmfEQjvrfmp1Fk7TMZ33SCL94OZBJXEHRGJltpUQKcT+LW74TX2Jd1uzbjx+kYDNFGw/W3UXanYtxuFzqitGSiKyqDwRNl9P87kEw8H+J2KGLHHsMby88/X54zN2DDNYahuGS7kRT7KM+EUiTA80A420h9vheaC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmKVAcsN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmKVAcsN"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb39647a70so510364985a.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 21:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771911270; x=1772516070; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YBOepqQDvmbBF6pq2JGJgpABCz5bQqbTEn/xcvM1TaM=;
        b=NmKVAcsNLsfzeFxf8zaVDSrLcnZmazW8nALNC4G9uTUP45VAwkNQd/JVyCiR+WlhL1
         dMPASh2YVCg4g43geD2sEg8xOGXOP8bdIRb4yeEup4Qsd0NpNQpsZoFdvKxWFl027FaY
         fh+iuy3/nBJ+C5J4Mql5G0lw9Hbhmzg08q2ba4KrVxEpz+b5Lg8A0dtZFg8MRbT339Xk
         AcRxOd+W+/R7UtsRwUmTjiFHtmGualSXYICF3TCsY5BssRVYWqhGANyInlIhcaJuKHFX
         KsawmwG2czjqHsCjTUyW+wxYznSGDFCj+XV3xg8fhpdxxqG8KqvfmPLT+em29v0K4d02
         6Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771911270; x=1772516070;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBOepqQDvmbBF6pq2JGJgpABCz5bQqbTEn/xcvM1TaM=;
        b=C+UFA5P9OQjL+AjxnfdSX+GYfgTFTRWyID9FoIxWyzbBsgz20Qx6ngPWw0y7IWUTuL
         qnDftDvHj2EgDOuQKejWmkn+uzPN9h+NE3781ZG4rG0puhiiHz5kVI6HR+G5MZa4Xbbo
         H7RtShknlT4+yvv+r/sCn+1JRV/xdpvLopMPxD3dTp4lhHQ4IFwLH01sbD2EXTEJTDuK
         Yy3EIKsxo7SnXp7dssAn/tbN+zcLxGlVEnNJJUP1lK+NwEW2vhZ8UFltaFq35pbZQp4E
         Ie1g6+WJLPPOyqSsQq3D2qVXGMyTp79/4Gx7vSPTHZBAcSXNEp0lujGuVwjfxHLqwZsZ
         i/Ow==
X-Gm-Message-State: AOJu0YyzYJU7gcRyujD5YXd9SCwxouASmIaXpKXDkbl+uGjE91AV/7ml
	QJn6vOy0JYdrK3RZyR/pv5X1Pwna9pu6edZGoTxtoTylGcKUScKvpJHbRLuUbQ==
X-Gm-Gg: AZuq6aK4ZYjYj+yZWiqq72HR6fDKR2jToAmuIPkkeDD97WDD6JnoZT+PoY6l0d7I4EM
	6WlUbAwZKrw8PcPmjJSCBw858zY38ILMHt6q8WDPn7GCKPSYhiiwX5UbsztHRHCiA6LfJo+kE+e
	LyEkUSP+p6r6LTJtrqwqafN1DzkFtfy/NKotM/4b6+lD/kBT8UyhexZ8gzRo3KgSAyT7AOT5Ddo
	kzh2gzVZDIsvKuD8DTJmuR/LtBrZr+txUcMtlJd2hdUt008e9aDl7Nsf7FE7xEP046Z0zngjtlE
	PB8ilcyoKgJV/0txMJyR9kdiPNRjbIRfEZYs0rqUFHeMhVtnnqbjim2Hs8SORuo/xcAJjdHZcl/
	DFT2GU3VLwTmxlRF/5Sik/U7L9xT//vAAfy9okdJYgGtpXPs68PRzuI7gn6M5xth4a8XydnISp4
	SSeWKbgSxighYkniCXZbjdn73xsXA=
X-Received: by 2002:a05:620a:480a:b0:8ca:3c67:8924 with SMTP id af79cd13be357-8cb8ca71e02mr1510772385a.42.1771911269834;
        Mon, 23 Feb 2026 21:34:29 -0800 (PST)
Received: from [127.0.0.1] ([135.237.130.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb010sm948726485a.32.2026.02.23.21.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 21:34:29 -0800 (PST)
Message-Id: <pull.2050.git.1771911268805.gitgitgadget@gmail.com>
From: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 05:34:28 +0000
Subject: [PATCH] t7605: use test_path_is_file instead of test -f
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
Cc: Mansi Singh <mansimaanu8627@gmail.com>,
    Mansi <mansimaanu8627@gmail.com>

From: Mansi <mansimaanu8627@gmail.com>

Replace old-style 'test -f' path checks with the modern
test_path_is_file helper in the merge_c1_to_c2_cmds block.

The helper provides clearer failure messages and is the
established convention in Git's test suite.

These instances were found using:
  grep -rn "test -[efd]" t/ --include="*.sh"

Signed-off-by: Mansi <mansimaanu8627@gmail.com>
---
    t7605: use test_path_is_file instead of test -f

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2050%2FMansiSingh17%2Fgsoc-t7605-test-path-helpers-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2050/MansiSingh17/gsoc-t7605-test-path-helpers-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2050

 t/t7605-merge-resolve.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 5d56c38546..44de97a480 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -34,9 +34,9 @@ merge_c1_to_c2_cmds='
 	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
 	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
 	git diff --exit-code &&
-	test -f c0.c &&
-	test -f c1.c &&
-	test -f c2.c &&
+	test_path_is_file c0.c &&
+	test_path_is_file c1.c &&
+	test_path_is_file c2.c &&
 	test 3 = $(git ls-tree -r HEAD | wc -l) &&
 	test 3 = $(git ls-files | wc -l)
 '

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
