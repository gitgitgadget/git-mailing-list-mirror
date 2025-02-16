Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F4199EAF
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723837; cv=none; b=W4Y1JvqpuQH8fDUcwYSd2B4TrsPPsBe3lQ0rFl/gMK8zr34afQsiVVnnzLmIpw0Jtgptgw2F1H1gyjYqsQvieP9v8rE7k/wKf6imSyp/2m9CSZKfhGAanJeMjrJVWf7MlUdKWKgYeP82wlr0B8HQusyGMIe4OQSnV6sCcYmmrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723837; c=relaxed/simple;
	bh=iB5wMfHI+J9P2YZV+NCaEmyVstCchgGsnuq7mfblivY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=OoU52o9x3rYnTssIXhz6ZrfESQWA6ZuelFCaVA/Xoy477bHbcgzFD4gnO500aR7WYP9WdFy2tcu2rxxUIocUgWJohWPQs0QhIYQmgbWbXEOQSgEy4yDYQIJ9MiibuzGfNy7CYXcA6Nb/6dstuei6s/6DBj+36zl9RzXHaljp8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRfbEegq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRfbEegq"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so24529855e9.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723832; x=1740328632; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPqc6l0vee5Ni9OfLO4My72PUsnlMX1DvFM+AF0kAbE=;
        b=WRfbEegqokA977l+iQexnsG5E5Mw4xQ+lc9KkGRa7iq9r5C2YD+gdv05juroWsXhGC
         9e/OQ9+AbITc2ZwiEXwH0S3mm3qECo6a9VBYCA2hk9YR1/txM29hrXUReJRVA04tOBOM
         MZvM9+VRsQvg4hly8emT0iZwdIBSiGcBmYPHS2RgydHNZdPJ9XVnJXuLi1u6wcplQWxb
         TNUE+QYTGIfgl7/+1lqEvSqYyA8UdWvvbKhU5PQj6kEk82a+Efi2nMphEmBaeOdpDV5l
         ZK7EbmL8/SUyQ46/mMoMfDl+fnm980IxOvchLYtIUxkInFpm4lnHPaYuGTt/4mLg4bYe
         UIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723832; x=1740328632;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPqc6l0vee5Ni9OfLO4My72PUsnlMX1DvFM+AF0kAbE=;
        b=mXwlF9nsl8NXPnmaHYo4h5um59w5bMqjbyw1R5YDZhPqQrLqoLHTNoxcF0iKKGQaZe
         +t5EeUdH9y5QPAfCz3X9XhTHdHgvX7QQIWhi0S9aYwE2KYdoB8JCrd/M0SThoQc0Upe6
         jxBCzaL+mHVwhr6UtXNkuVgt1Y0Em+6z8qIaVdAL2+Bkeo+wL6KbedP9dbAbcfU34B7U
         fX/ruVw78OKbk5EIgYSfpvu9F+64E8FLp8TP/tPRNUmag2En8YOo/cVsQm1NXw0qd7Jl
         B/HkYsqhikhBwUMdbcGcOpTivHPdu0mSfWBoPvhFf/8+9tAW6/tStuabqa8nYUI9PeYH
         aaaA==
X-Gm-Message-State: AOJu0YwpGomLiwFe+acXhXM4GMbisHTCwZEo3mxWKvon890FQQ2KkJ+b
	xlhrotw64QJnQz3mNq8NEWbZT8qwNcnpHQ4lEPbji5E8NK8DcPgtsKvO9w==
X-Gm-Gg: ASbGncvp0LgRjCiab7u07sVZl0HuJTYkXTj+y/XZBPSRw1kaIql3I8SEeIddWj3FHq7
	16Ini9VRhwMMqEXdGFWJXp5q9X88Eu0O0jkjI+ny69J12YWIOBiB22S5TWod2wT8D/oG/ImcF8d
	MEv3SeJwfvyTBV2c7zntD8O5mu+Sc5xiVNSRAoeN83xU1h+6FDUklN6XYJFDcvwzqHyUFWRKlJK
	VsMZyz3mJGNFDAXYjAdj6kxfdWrobEA3s34eCHPyiy8fOxNCKTLGRX5jVyox/2pd1X1Yb+lUvA4
	r+rKWeuSVGaR5GGd
X-Google-Smtp-Source: AGHT+IEx6lk6fUiax+A6RJ179KR7olaW0Yq2OdPH3lAo1xBNUj/BgnkogLMaV9O2GML12Qj2GMdSQg==
X-Received: by 2002:a05:600c:1c21:b0:439:4345:3dc4 with SMTP id 5b1f17b1804b1-4396e6c0778mr53774585e9.9.1739723832052;
        Sun, 16 Feb 2025 08:37:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618102f1sm97153145e9.19.2025.02.16.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:37:11 -0800 (PST)
Message-Id: <3b3179785098580f3336bb24bdbaf0aa1366bfcd.1739723830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Feb 2025 16:37:05 +0000
Subject: [PATCH 1/5] merge-tree --stdin: flush stdout to avoid deadlock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a process tries to read the output from "git merge-tree --stdin"
before it closes merge-tree's stdin then it deadlocks. This happens
because merge-tree does not flush its output before trying to read
another line of input and means that it is not possible to cherry-pick a
sequence of commits using "git merge-tree --stdin". Fix this by calling
maybe_flush_or_die() before trying to read the next line of
input. Flushing the output after each merge does not seem to affect the
performance, any difference is lost in the noise even after increasing
the number of runs.

$ git rev-list --merges --parents -n100 origin/master |
	sed 's/^[^ ]* //' >/tmp/merges
$ hyperfine -L flush 0,1 --warmup 1 --runs 30 \
	'GIT_FLUSH={flush} ./git merge-tree --stdin </tmp/merges'
Benchmark 1: GIT_FLUSH=0 ./git merge-tree --stdin </tmp/merges
  Time (mean ± σ):     546.6 ms ±  11.7 ms    [User: 503.2 ms, System: 40.9 ms]
  Range (min … max):   535.9 ms … 567.7 ms    30 runs

Benchmark 2: GIT_FLUSH=1 ./git merge-tree --stdin </tmp/merges
  Time (mean ± σ):     546.9 ms ±  12.0 ms    [User: 505.9 ms, System: 38.9 ms]
  Range (min … max):   529.8 ms … 570.0 ms    30 runs

Summary
  'GIT_FLUSH=0 ./git merge-tree --stdin </tmp/merges' ran
    1.00 ± 0.03 times faster than 'GIT_FLUSH=1 ./git merge-tree --stdin </tmp/merges'

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/merge-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 9a6c8b4e4cf..57f4340faba 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "config.h"
 #include "strvec.h"
+#include "write-or-die.h"
 
 static int line_termination = '\n';
 
@@ -623,6 +624,7 @@ int cmd_merge_tree(int argc,
 			} else {
 				die(_("malformed input line: '%s'."), buf.buf);
 			}
+			maybe_flush_or_die(stdout, "stdout");
 
 			if (result < 0)
 				die(_("merging cannot continue; got unclean result of %d"), result);
-- 
gitgitgadget

