Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27C190664
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109023; cv=none; b=d/xC3LtfOZwN22tXYWtnr/AM9x40D1Iy0jMT2QwSy+AxzUksVrKQe7A2SDn+ly/qntkH3oHWDEWWbzY8f/aulP6TBOyAGPZqj/y4JncFqf9sIEiGss2hACPPBLyaiRDfQEtPLteQ4tMfGsksR8Mm9HzAtJZ7bYWSnFvSTGE+c0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109023; c=relaxed/simple;
	bh=3WS1ZhyG8lU493Iu4DDKWJGRvpbgR7ajLTJZY7I+pzc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=K8QNEwQGxr41P8POKfDdieHi0Tdx2jC3thvMmeVvc2/Ht2HgrEc/Sf3o0t/Mko8u2y5OsA9UrJAp6BbrXHiGdg7Sd6JvkLASDhXKgNrFRjC7a920SH8cgDrrU0ICjhUSv/8wj/iaVHEzHzoCt/21FpmV5J8tEo3ghgbujgrTcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFRsuEfL; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFRsuEfL"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4043b909ed4so5096657fac.3
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 19:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773109021; x=1773713821; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7OWPoxCVt9NCrZmqp4xdOou2n6mP/zgUkjxJ5o13FVI=;
        b=DFRsuEfLbjKWJmgnElUL07ysW0Uoxi/NFOeFsdP0wGnKPCpqgz206r5p7P8/wo5Lo7
         B05S7chg2JOMmcZP7poSh1YkIpYLNSuBrxPDQa3flOFbLZM9TWbiq/WnkhYcDk08IIgT
         wDIyV5yhFmgfHHE+ud27rtiQ5lp0X/ZYhxTRwVfxenXoaDO4HbV5GiYbj38dEhX5YhGL
         kznWWIG0DJ9dkuTdDef+t4XGu3lI4Vj1mQ2tq0kgX1RYTva0xYMAyWe8R0HNsNf6zwgc
         ZdtKvu9MH9uLBrjLL+1wW1XG53FP78hwxIp1qKBr2MGFsE1QLLEEjTS5Au6KZLSax7DC
         Df3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773109021; x=1773713821;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OWPoxCVt9NCrZmqp4xdOou2n6mP/zgUkjxJ5o13FVI=;
        b=m7abiRKYQ8eC/ab3p0rRAuVTnFkqRMOk6YZRomPqYmfmIiEkjcJlL7ESmyuNeAG6PU
         hwBuN2Ad5eF6rvZDWKtEPlCo3LH2uvIBtB61Gu+bzm0yGU3qm3+oH+TxjyNYkiELmq3i
         5evWOJ64zws/wfoEBY3uC19caycmdJBqOkQLbgypfhgJkBOq73aI8RZ9c8gy2qjrbEqd
         OG65xGrLiSQpyMyD74C2dHYbWccebAxDv+HNdCYEWOcWnzv/PvG2THP7xUb9K+uv79Q4
         OW8AWAsImwcbdI+ZrJr/l7P/U/qDgq7k+S9SLADb3cdn0vjk60VbJeW9g6jABYjOUSim
         NWAg==
X-Gm-Message-State: AOJu0Yya/AdETeXeQLxz24fh25qnbpNaevozFpb855W4UwCJXj1u+r6v
	u9Xg+ze21chf2mJnR7hq3w4adlG/eAZOWJ/zHW4PXzxQevrgyxFhBTNiIb2TFA==
X-Gm-Gg: ATEYQzzjX6FqCLmC/569/43evki1nxAZf7bvmaokWO/azo7GhDN9juq0aEj/LpYUY9A
	BFUqPgLuwfGzj4mNpB9CckFLvJfQPVDhe7ku6wDlM2PePFw+zkdZBg6dkd0llVuw6/YKD473r16
	URLuIPVZ7KtaANGIM0ah4OAALrUxWHRZAFp4NHjowXt/TU0FRmuHC9fL2qU4SoI+81SsEIbYZTT
	nYgHUa52o7LBKuzZsnjpGNNgA3eWH9AO6zb93cjPFOc6Kj+BZTQABthYSfzQ66fXS5i21ahbHJ/
	Jyk3lDP7KJzD3i7AOKIF8xNqaFNiVjFbMAAGgbaphY8dTrrFwGofX6sAv3+ZW0uOvLOhnltzUpb
	hsdAJFwiYwtbm9OpTSgBoqKx5Q1ULubMA6ZixQfCaBmZt0g4/I+8lAd4Q+HAARvZcNvKlA4WWOE
	OKUi2rfUU7zR1xQCWKPVi+JMP5
X-Received: by 2002:a05:6870:9727:b0:417:1ba0:7320 with SMTP id 586e51a60fabf-4171ba0dd8cmr4791148fac.33.1773109020765;
        Mon, 09 Mar 2026 19:17:00 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.164.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756abbc1asm1344329fac.4.2026.03.09.19.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:17:00 -0700 (PDT)
Message-Id: <pull.2062.git.1773109018.gitgitgadget@gmail.com>
From: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 02:16:56 +0000
Subject: [PATCH 0/2] repo: remove redundant variable shadow in stats_table_print_structure
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
Cc: Mansi Singh <mansimaanu8627@gmail.com>

The variable i is declared in the outer scope of
stats_table_print_structure() and then re-declared inside the loop,
shadowing the outer one unnecessarily. Remove the redundant inner
declaration to clean up the scope.

Signed-off-by: Mansi Singh mansimaanu8627@gmail.com

Mansi (1):
  t7605: use test_path_is_file instead of test -f

Mansi Singh (1):
  repo: remove redundant variable shadow in stats_table_print_structure

 builtin/repo.c           | 1 -
 t/t7605-merge-resolve.sh | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2062%2FMansiSingh17%2Frepo-fix-variable-shadow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2062/MansiSingh17/repo-fix-variable-shadow-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2062
-- 
gitgitgadget
