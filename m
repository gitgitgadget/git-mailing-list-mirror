Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF68339B44
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768133543; cv=none; b=QLr9zV4dnoet22sG4f5rbCgtMwafoRWVjNDKW6U8UeYXEIAEGWjBxSdbxseZhfEUKd6TnU9dWBXsHb+k64xJxN/5MrEwFEZukfXmDGaZG2MdWV4VPnHjmyP+430x4xl6q+Ex9M28tCpLTIyNUfI8s3+nSMItyvxlEtNhRjvA2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768133543; c=relaxed/simple;
	bh=16JiymdbcRv43EkPQiNDfV7ILJuTfBDtYA2nXw0CrOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMgc0eJ9fkov5yeDWR+lxsFGufZqYMV7IJXGRjRMycpB0TPmtgss5ue0p4WRyKkiHojjeWqto5D/2wHc+H23Asbw5UK6+yHUQB7564fGXsNJbLyiBoUA1h9OiJC3+X3Vpf9qXmAGVmqdPU+dNPVSvNmuDw7RC0rni9pP1vG2XWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgIP03lQ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgIP03lQ"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29f1bc40b35so63691605ad.2
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 04:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768133542; x=1768738342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev+JqG/XyN4iCbikO9rbNNm2FEtD+7/+tMvJQV7nKtE=;
        b=SgIP03lQboC7bZbFrTJR8TCwXoXMVYHTUpf07f/tx53f/xRjTqgU26lKe82HU8QLqf
         hS8yvkOI0uWtqn74PAFGjn2wAxK2ITbZlkGooJWbOUmOPteCOrRWXWCg8Aae3nu8qd9y
         oIrX7dqAcMqIHZteZS3Y2hliE5VmxAHvqIG2nfCQRMCap9yCgYD9OkLegQQBoVPv3/U3
         fXImBLoR3DfK0jT3yxJQ5M7yx7fxvr4OGGkKP1lKBzwluLqAhLLHUFJtwbOG5WSsX9T8
         fLdjZ1Xv9ylkTWevMh7jFsmyFyzgmKhEvsre7CIuL3i1mOn8ObTeQDpWy4Xsq9RPnx/6
         pCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768133542; x=1768738342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ev+JqG/XyN4iCbikO9rbNNm2FEtD+7/+tMvJQV7nKtE=;
        b=Hvy1vkA0+5NGWep5qNMB9LbnXNQVYlI0Qy/6UhaaHjAvSIwFX+ZHG1pAKb8rt4+NfA
         U5uZ4KWfsAh3uh3c1qwBs2jrkrwLIAJJ+sz7itTB388CWw+erL0UicSXjGs3fSum1UGK
         5ZR0CiW3j8E1IrMLnCa46+1FYxfkOL07x/E8aU5LxK+aU+T0XS2HzyvLnSd2NzSlWskP
         mRB3NsE8OPR6YnXyUP5uZ6VEvGGgrBkWdKALLd2sYP3sLd9+x0k52t2rGNqPFVzYvJqR
         3+ViiZyh1zyYgqWwIwgcdnC+1pxVe5EnT8mixystxZJ87ENVAHItdgNuYeZ2boPrJZqH
         0gdw==
X-Gm-Message-State: AOJu0YwA1+r2FI2X1f3TltPjSxret0/PgACw5njfkgMtfXpTA9x9WajK
	18dq/VG2MdkfMsrdv+KLS6M8wzn2axEwd33nK3bHdaZ/qMY2JPmO6C+QBRk4U4/h
X-Gm-Gg: AY/fxX5zW/3n3tox6MPCNP8zJg3LTJKOaDSOWnSJAmWpPXHeb2XRHLeJd08/x4W7oSz
	KDwk7WIpn13A73dn7lgws7YKD5tdEMyc+lsMRfAjfdfK++VTVxbMhDZ7wFh6PcnPJ3fMPvYlzjS
	1H66jrQ7Xi4cV+t92JNpb1TvhxKJ/2SL1AYHdpTNZSkjU2prxtO2XVCztSoDG5leig27J5ecsBE
	3c+p3ZJm6+VmMqOokjcTnmusntcqeMWEjzCYbI5Jtdgsnre1keIgiDcqKgjVD4xUIFTlpNtV9iA
	zlnCS46t9MQuFI8yORdjJB09anN4j5U4xs81JrhZlmQ5djFV1/TLJwTle9dL77/CMTI25BHQ76K
	V82PU91aByfapSElK+DPG3GU1MNYIdXLYvCO24wAoq1hJrY2fYhcs3bxZcJKrh3/Apv+5KusmBl
	nq3x9HSkm4goAz68WlatzANqFBZspOlIE7
X-Google-Smtp-Source: AGHT+IHde+Tigi909PFiIhH1mF+3znhwy+ert9w3fa++O2ODngvPPkoRcgmMA5OmOv5Z7Bf3N90fsQ==
X-Received: by 2002:a17:902:f70e:b0:295:ed0:f7bf with SMTP id d9443c01a7336-2a3ee4c3231mr141838505ad.58.1768133541918;
        Sun, 11 Jan 2026 04:12:21 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc793fsm149553125ad.72.2026.01.11.04.12.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 04:12:21 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH] t5403: document check_post_checkout helper
Date: Sun, 11 Jan 2026 12:10:07 +0000
Message-ID: <20260111121218.33935-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111072950.9463-2-deveshigurgaon@gmail.com>
References: <20260111072950.9463-2-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 t/t5403-post-checkout-hook.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 63a2221441..31ad369b3f 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -9,7 +9,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-# Helper function to check post-checkout hook arguments
+# Usage: check_post_checkout <args-file> <old> <new> <flag>
+#
+# Verifies that the post-checkout hook wrote the expected old and new
+# object IDs and the expected flag (1 for branch switch, 0 otherwise)
+# into <args-file>.
 check_post_checkout () {
 	test "$#" = 4 || BUG "check_post_checkout takes 4 args"
 	read old new flag <"$1" &&
-- 
2.43.0

