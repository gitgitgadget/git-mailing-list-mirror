Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5A34E764
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715950; cv=none; b=tqNbfNMHp0jHHBnKLAjDcH8kwPDYlnOVG1BVLtwPH4TtFyjsfibEs9vg+XEmcTFY/Dc47H9Hl4CM1B2wcl91lQToUT1/T5OCa80pGmL7ghtQTPij249SdQWmkL8TAIxhrUaQpIP7uTtAb1mzLB66QJnXXgKRGPvtPet5f1Mrnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715950; c=relaxed/simple;
	bh=BtyXtFC3JMtgqtasTR2IkAiAkmJtcdDOWPlj4Lp9+tA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fniS8aHXQ6ZNd+tfcwjUyLwuhiBibNefzbVBkIMCiSoigD9dFOEtWYSh45RCXObMtamuPX6SW/P9tQH/EKNUqyBtjPguDENam9/VGQT9Dsmn7Z5euYRzghH43JCtu1JxsYAMK18CFtaP5dbCtHMEBUV1M9njdap4f+EK7QS39MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgDPdgPS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgDPdgPS"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b350c69b4so386312a91.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2026 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789715949; x=1790320749; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iD/JrO5wExFJN9AsIAO8TbyQA+UjT3bOrcDr20wIUi8=;
        b=XgDPdgPSPxAoS3HO0j4uX1hFXH+RAiKkBz8FxZL19neiDgGpyOkkv165NJ1ufWAS+v
         Xk1zdg8XFxpsHbA1Ade7FBqjAZIjzhn1M9cGzJ3iy00gL4ZM/t5Xncmx509S8R677vLu
         QRaOG7ZSYozTf1z6bKV1Jr2r/irIzLt35nviA1GNPHAmU51UWWAwDiM2pV6O4pDSWdAE
         Lbesa5tWiX8Zo1ShYrZFpakzYEC4tvrhECXVfcqv0fnybizjslIuiiXI9bTpfWKzo/jf
         AD6qVgs6cWTcAEDY2nXwVTazgIWkFKNcSg+ORHk9/37biNOlwcAuLqeXhx4f6nlERjmk
         TcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789715949; x=1790320749;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iD/JrO5wExFJN9AsIAO8TbyQA+UjT3bOrcDr20wIUi8=;
        b=ivADo3kmuD0z/v9HsUYONfDZ+UrMb7l7+Uf/vPPSy6e2C2QyNqXATbJw3QJ2l9qybU
         BYfFJFYVN+ZXXoo1JPLk6UbG0ZJhRQ9qUd5tfAWtKUPWmR2AKm8vZWkZ5gXN9+N0SkrR
         EdJMO5JprLDKtqlHG2fT6wCnc7l2e06/cS379setMl/3ixzc0dWsjJcNGCRls2kSg3Dc
         t+1EOrc0jRvcyYgqLecYxBg0PrF5MN71dBhS4jPFXQPpoLNBEOKKLMXeqNKyD5/3sE2o
         5VLKkxpdG0SXjipnl0lATm2k7EJvwTeHjWoz+L68gfPNp9oixfYRi7FOgnFc7Bke6e+u
         94dg==
X-Gm-Message-State: AFuF++l2RIyIArkpBPc7kQUpY+yZZr+eHXf+aDFGjBMhG8VregN2HTFy
	V+ojGRKuXdRhk1hXoHDQ0c6K02bMNCRvV6JZVHXAZ41EAaas1imvTRiJLqF8qA==
X-Gm-Gg: AYBFou2o7VhTUAPzjaWvUaH1zF6DWODaMFEiJCOXqHzNifkUuZr6ZT3LwhZsivCyQ+K
	8IJnJ1DyRl0EmUX9SKeTGMyBukNFk3yO3i3vvIjlke8faz/OHfZgXAP1ZjAto3+jDZXalSuEQbp
	TmS3drKAuvwuHxmKGfnFMJO9l01o7dsZhQd/WbTdrrtHLQ6SkXLqTwNJhsliVsjBSONtyVOntm4
	+3bM1/Zk1KpTdKM3Srs5xcWm3yWjAv13Rip5ZsEIjYTwTQlAfBK/eWNpvOzruqQl2JbUfKjvMg9
	DfYt5VPLjfTAvtBeEPwm7SjYmbd6ueEl1lJTChB9aGSzDq0nZAC2DqUPNboJm0FP3yOlqBq3/Vq
	/gk5GhnPFJp1wNPjWj54yBMttk6w5zISXRV4d/9hSe/L4B6FHfu9Lqcm4iGAmFekmEMmHo3Ua/u
	O7hvQt3DlQc9NCU7r7ei4qFuGeukF4o1BYY6woWXxFj/FA3ZctYC3JN4t7dRg6ih0J7i/zSBQ=
X-Received: by 2002:a17:90b:558e:b0:39e:4c80:44bc with SMTP id 98e67ed59e1d1-39e54df6d7fmr3701422a91.31.1789715948613;
        Fri, 18 Sep 2026 00:19:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.103.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c286d98e7sm2341748eec.9.2026.09.18.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:19:07 -0700 (PDT)
Message-Id: <pull.2232.git.1789715946888.gitgitgadget@gmail.com>
From: "Haokai Ding via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 07:19:06 +0000
Subject: [PATCH] diff --no-index: fix -R with file/directory conflicts
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jacob Keller <jacob.e.keller@intel.com>,
    Haokai Ding <hk_ding@outlook.com>,
    Haokai Ding <hk_ding@outlook.com>

From: Haokai Ding <hk_ding@outlook.com>

When a path is a file on one side and a directory on the other,
queue_diff() queues the file separately before recursing into the
directory. This early queue entry bypasses the reverse_diff handling
used for ordinary files.

As a result, comparing directories d and e where d/sub is a file and
e/sub/file is another file reports both paths as deleted with -R.
Reversing the operands reports both paths as added instead.

Swap the filespecs of the early queue entry when reverse_diff is set,
so that -R reverses the file change as well as the directory contents.
Add regression tests for both directions.

Signed-off-by: Haokai Ding <hk_ding@outlook.com>
---
    diff --no-index: fix -R with file/directory conflicts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2232%2FHaokaiDing%2Ffix%2Fno-index-reverse-file-directory-mail-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2232/HaokaiDing/fix/no-index-reverse-file-directory-mail-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2232

 diff-no-index.c          |  2 ++
 t/t4053-diff-no-index.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/diff-no-index.c b/diff-no-index.c
index f320424f05..a9151cc27a 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -188,6 +188,8 @@ static int queue_diff(struct diff_options *o, const struct git_hash_algo *algop,
 			mode1 = 0;
 		}
 		/* emit that file */
+		if (o->flags.reverse_diff)
+			SWAP(d1, d2);
 		diff_queue(&diff_queued_diff, d1, d2);
 
 		/* and then let the entire directory be created or deleted */
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 8e0394cf5a..c3c703f4f4 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -120,6 +120,24 @@ test_expect_success 'turning a file into a directory' '
 	)
 '
 
+test_expect_success 'reverse diff when turning a file into a directory' '
+	(
+		cd non/git &&
+		printf "A\td/sub\nD\te/sub/file\n" >expect &&
+		test_expect_code 1 git diff --no-index -R --name-status d e >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'reverse diff when turning a directory into a file' '
+	(
+		cd non/git &&
+		printf "D\td/sub\nA\te/sub/file\n" >expect &&
+		test_expect_code 1 git diff --no-index -R --name-status e d >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'diff from repo subdir shows real paths (explicit)' '
 	echo "diff --git a/../../non/git/a b/../../non/git/b" >expect &&
 	test_expect_code 1 \

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
gitgitgadget
