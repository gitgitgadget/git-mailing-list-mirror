Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA828D8D0
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784998832; cv=none; b=V3GhJFGlOKYvb8mvx9sYFlYiIiCk/B78VrlXXtoNQYzyo5xx6WGvb9Gdeb7xnizTPjamn3Gm4P4TMYWATXumkaa691e4PxZMPNyd3YUBTbVoZcwnYs54MvrbiZ9yb22MY3Mauov08nxABrxJI4FmegzJt6HqGGLlLNTen2loN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784998832; c=relaxed/simple;
	bh=4Ar3a+M5w1ky5ZJSRPMzH+3j+h4CrExuLh9k2S31dhQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cCQFKb1xoBBXmvIOyoCNhV7sAj/whxwtciewuJPI1fVq1AKu2z3Zmsi6kLIsFc6VvXdbyES2CiXhTvOopS2Blo35GaTlOU73kJp4ug9b97H7Tj1aXTGlf5Q3f9xkcWVWtCjUPBd/+pYajIIsreYg6zcLKHD+P3z36Jn+Lb5p5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT5QyhCN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT5QyhCN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1330033a91.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784998830; x=1785603630; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QoQC/WwV3wWQOfcpDse1V0OTXKjOfDN40MD+J/oOMWE=;
        b=eT5QyhCNEljv903HUesL+2wwG48l00GGvDlcEoY8qd83ksJqRYlDD59oSad6yjpZHX
         F4PTlPVYq/8nAK4OOYBLSUp/rOY1hzok6cDLVZdpj0FaxAPjy3oF8hi6K6NgM6fkTRun
         /3sir85neYSBQjgrOyP7jTY58GBA7DyA9YLSNUe5JEu2PxEkB8K5UWIXZwZirJLRHGJ1
         dbniTTfC0T9tQZLtTtd7aECcvNS+G1292tPMvwHTX12yn1d9j0F01dMx4864RNnyZQZC
         Jfn6ifqIG/4P8eqDc6dTV2IuQ0zq42FS/ZONPiC4hhCh7vOmrfonedmgS+Jhm1Z3ZYzH
         +/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784998830; x=1785603630;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QoQC/WwV3wWQOfcpDse1V0OTXKjOfDN40MD+J/oOMWE=;
        b=OLcXkCygN68xwb3VTa9wu7QaYtX63dJdwP0qm4U/E90BDKHnJq/Ov05FGepYX0ab1M
         tsNqkfTXIsSBLiU1paOuKUSIHFzfL0mYOE/4PVdh4KsNCvAijlLI/rIKnpJnRkJT4e23
         hWmJjrkueAX9F7fNXNVoZU/jUSDvOGmsNzBrGZ/vYvTVs8L694ez3r4gSEkQeGme5cbi
         pclWkmkKtVVyzknjQDKeTpHr8T6m3ZYkNGhpnXe6m4ej0sFszgZE/Ybh7v+cSG8k9PsV
         jq8lmWfsc0ySTZVfQPFPPlqqYC8lurdeyb2y3+ZwzgDqIlTW/O15VNXQgyHXMnivw+uh
         iyXQ==
X-Gm-Message-State: AOJu0Yy57n5BDmkjrhULZ9rUqOZWdxfl59GlWl5qaFxP+GTYMbbrRAv9
	MFrzh3RTOmz7mXP1YMpBhQIzJVyDl55AnsQLWjVd1wZl4t0io5WVaa+epEXS9A==
X-Gm-Gg: AR+sD12Z0d5V9cO1cJ1XV/DskmwqAdZxf/IJCpNmHqY/fZW9TulUAkgn3OkGaFWTSsb
	pDtm1u0Xm/VVNJHgwr/jEalkgM0qZd49qJxk6XJNWcRxv4sU/6SA+nLlakB7+vF3/CIS72JS+rx
	qZJ4iG/5QLbgAhIBkSt+P0hw3xNqa418lptT0sCuI5VDRTa3klLDsyrfZ3EFPEXZDD5FwwDZEaG
	AhFpHACotyfz4sIDJ7gVlCwzu0PjeTbe5gFYJ4QyO/HHx+wzI6eP+BefvMhINv9J+O2xycnZham
	iPxzWndksbo1o+E4VLwTLIClKusymzBWvsA+2tIBc7mmItahdyO1fNtSxgkK9wk5syhnUcNkJqE
	bMfa3F6WQ7PFcH3hLHRAfeBTTdsaAUpnfYwUS7OfgbZ09DONNfaPD38m/YBcQY0unEcYtQwnVKA
	GcO4E=
X-Received: by 2002:a17:90b:258e:b0:37f:9ce1:cda4 with SMTP id 98e67ed59e1d1-38f29641b23mr2721887a91.26.1784998830105;
        Sat, 25 Jul 2026 10:00:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.20.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13003f12sm63986830c88.2.2026.07.25.10.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 10:00:29 -0700 (PDT)
Message-Id: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
From: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 25 Jul 2026 17:00:28 +0000
Subject: [PATCH] merge-base: add tests for --is-ancestor
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
Cc: Nikolaus Schuetz <nikolauspschuetz@gmail.com>,
    Nikolaus Schuetz <nikolauspschuetz@gmail.com>

From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>

`git merge-base --is-ancestor A B` is used a lot in scripts but has no
tests. Add some to t6010 covering its exit codes: 0 when A is an
ancestor of B, 1 when it is not, and 128 (not 1) when given a bad
argument. Also check that --is-ancestor and --all can't be combined,
and that the resulting error names both options.

Signed-off-by: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
---
    merge-base: add tests for --is-ancestor

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2186%2Fnikolauspschuetz%2Ft6010-test-is-ancestor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2186/nikolauspschuetz/t6010-test-is-ancestor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2186

 t/t6010-merge-base.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 44c726ea39..d28d9dab2c 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -305,4 +305,38 @@ test_expect_success 'merge-base --octopus --all for complex tree' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup --is-ancestor' '
+	git init is-ancestor &&
+	(
+		cd is-ancestor &&
+		test_commit one &&
+		test_commit two &&
+		git checkout -b side one &&
+		test_commit three
+	)
+'
+
+test_expect_success '--is-ancestor parent and child' '
+	git -C is-ancestor merge-base --is-ancestor one two &&
+	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor two one
+'
+
+test_expect_success '--is-ancestor self' '
+	git -C is-ancestor merge-base --is-ancestor two two
+'
+
+test_expect_success '--is-ancestor diverged commits' '
+	test_expect_code 1 git -C is-ancestor merge-base --is-ancestor three two
+'
+
+test_expect_success '--is-ancestor exit 128 non-existent commit' '
+	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor one no-such-commit &&
+	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor no-such-commit one
+'
+
+test_expect_success '--is-ancestor and --all cannot be used together' '
+	test_expect_code 128 git -C is-ancestor merge-base --is-ancestor --all one two 2>err &&
+	test_grep "options .--is-ancestor. and .--all. cannot be used together" err
+'
+
 test_done

base-commit: f60db8d575adb79761d363e026fb49bddf330c73
-- 
gitgitgadget
