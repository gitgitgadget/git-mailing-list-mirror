Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B71CAA63
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740901532; cv=none; b=El2v4E0eLGdTVD0ij8kJmPrDteuOcBxFY0ffpZX2e4qY9Fm8jf0Nbnhq2X+Ys2wCY+8/BMV/cPwW0UOM7VPTruJGJee3TXDPx3U5Qw8uzvSRjirhnsABg14J1wPxKP8guwhORHF4bE/TuCgglZ9WD5zeGr3fV1TTToexZQ0CYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740901532; c=relaxed/simple;
	bh=wlIdBiMv1fiJhoIUuBBJhZ4evLFUWhVh7K6dlRfB5bM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LmGC/R07pa/y1GNv+GYA/LuyDuLHShJxY2xpaO0i3M6BOaNk0aDyu6FizUdbod1g70Kme4vB3dU0S4VlZ/ZYShkLh6EhmaOLiGkKkW4LKrUOP9DCX3wAJAAmcE+hsFzQ9Bzt8ssi3z4FZJ1tUbdZeRHqYgsxRpValiqbjsyzTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEqfgA7J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEqfgA7J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso21566825e9.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 23:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740901528; x=1741506328; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilylWBto4J5A+PWbsJRGiLufFNXBA1Kk4go+uYkDWnE=;
        b=VEqfgA7Jwp68D6957c6BWQbSPi2lv5gQWacaEMGL7PTBL928HkIQB9MiOQ0bwt5Af5
         xaO1KFxXV/nq8bZe2UCOSwT1rPK3L5wvfXO4m+RvrLf8CFsxk1yNEten3DmZkT0OW+vc
         cA8ItuK2d82GwWa9EcDYGRjNt017P35q35aKAYsLWAms3K79/rqD3iOSa1jBigJC9TuG
         qFPt/sLFOSg/pbFEM2VgPPJAkZNRH89NQhYa4AnyRUC1pLu6IwhPrO8eAuK69jnX26hr
         Pr2hR1h1U5NVXSb/pycTWYhbMPbAPxDn2YQxAKywAmzMIxkw9O718ZiAxK3rxFPWa8Ra
         iZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740901528; x=1741506328;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilylWBto4J5A+PWbsJRGiLufFNXBA1Kk4go+uYkDWnE=;
        b=ly/iKEcmrtdkAkrr+6+JkHiixvXWAQPWM8xJv0ObRrfO/6qZwuHWmJLQKsk+JGUulU
         Y+wGLODgzRxRIkZl5Yf1VaNILNMgYuxWKLR08FIkec4C8Z1+Wa9sDvvMpF4OO53q+TUC
         10iYiSrOVRfH5aiaMqGCm7D/2ufxDvsklCc4YS8iJEbk41QbCKPQEPGNdl++EnryU0lv
         i1URgyw6E/SkGIwNwu4jb2z5pRlVzelxzexKWm3bDM1jRancytVN7Iz2C0BVuQLON1Rl
         fKblYnxkzCHMfC09oFQCkuQ+nuzYpVav5iUZOk+6CPFc4j8chMri3jJnd2dIHY3CuuHV
         PU/Q==
X-Gm-Message-State: AOJu0YyqAykiCw4MUbEipTobIpWHP4HrXt85QnAmPlWxtlKdn9lNZRYW
	wn7Iih1vMjytBFjP5DaTz5/pkYuqsqkjrIHI/oAlyx8YxoThun3LnoyTMg==
X-Gm-Gg: ASbGncvKElBfNfHDyF0PR6zOOmfJDYGpGS7Ci5PNAd3D0WaunvLOarWlFy5vOIwhQ6P
	01KESs5jFwEsyf5od8SaJgvfsOOLlZQMxCj5odeel3Zr7erKkQKAS2RZ4jSbbAWWTJt2ql9GDnY
	81Qkl+PdITq5LvS+rNQvbBnrKBZiZCmjwOcYv+chicnhE21J8hBVCkN6SL2jhkiOzjsQheCsc+/
	eV4OOy0qNLmRqEB3kVPYH75cIt++lR//4yXWKdl3mzwAK1kCiC3M9goxMrP90xwEm8plbtaZHhZ
	Ft8KhVGm8eGpcXRdIGxdXxvF0JWsvwi++isEtZPqJBIPcw==
X-Google-Smtp-Source: AGHT+IG82ZEQ5WT+KD20SdUVIVYJFqot13KUeo5/5ez24xx/Z8IheoGwZcMB3wGeTCVK06kLJdzzqw==
X-Received: by 2002:a05:600c:4693:b0:439:88bb:d017 with SMTP id 5b1f17b1804b1-43ba66da7aamr70389365e9.6.1740901528403;
        Sat, 01 Mar 2025 23:45:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm10439957f8f.27.2025.03.01.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 23:45:27 -0800 (PST)
Message-Id: <4fab893d9fddd65b20d280edfb8cdf6ed8bfa295.1740901525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
From: "David Mandelberg via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Mar 2025 07:45:24 +0000
Subject: [PATCH 2/3] completion: add helper to count path components
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
Cc: Jacob Keller <jacob.keller@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    David Mandelberg <david@mandelberg.org>,
    David Mandelberg <david@mandelberg.org>

From: David Mandelberg <david@mandelberg.org>

A follow-up commit will use this with for-each-ref to strip the right
number of path components from refnames.

Signed-off-by: David Mandelberg <david@mandelberg.org>
---
 contrib/completion/git-completion.bash | 11 +++++++++++
 t/t9902-completion.sh                  | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cb10f818a81..17c044f7d60 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -246,6 +246,17 @@ __git_escape_fnmatch ()
 	printf '%s\n' "$s"
 }
 
+# Prints the number of slash-separated components in a path.
+# 1: Path to count components of.
+__git_count_path_components ()
+{
+	local path="$1"
+	local relative="${path#/}"
+	relative="${relative%/}"
+	local slashes="/${relative//[^\/]}"
+	echo "${#slashes}"
+}
+
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index c5e91622876..0219408358c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -462,6 +462,32 @@ test_expect_success '__git_escape_fnmatch' '
 '
 
 
+test_expect_success '__git_count_path_components - no slashes' '
+	echo 1 >expected &&
+	__git_count_path_components a >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_count_path_components - relative' '
+	echo 3 >expected &&
+	__git_count_path_components a/b/c >"$actual" &&
+	test_cmp expected "$actual"
+
+'
+
+test_expect_success '__git_count_path_components - absolute' '
+	echo 3 >expected &&
+	__git_count_path_components /a/b/c >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_count_path_components - trailing slash' '
+	echo 3 >expected &&
+	__git_count_path_components a/b/c/ >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+
 test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
 	sed -e "s/Z$//g" >expected <<-EOF &&
 	with-trailing-space Z
-- 
gitgitgadget

