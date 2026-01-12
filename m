Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B8314D04
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200824; cv=none; b=DZ+Q4wHCOO5n2epJK5rqEpBugLYm8Pc8pDolpxJ9t78YkfnyBaV492SZDelPKWOvcZk2pyPNx5IRonDrS/2LZ+v1ZdOPTKFmPD0dZDE60Lyi5aqgpTxSWO2plN50x6Tmc2vlb/LjVcn82q5ecqXeGn6j9EB56ltLZnNHiJoNW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200824; c=relaxed/simple;
	bh=IY4kCci68Mx2J+vD75pxBUxGt68jdig5JYBFETRVKnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXv7IFArfQyDT2AJ7NsFISMY+gYkA04cyf52nTUum65FV6dLtSWQv5SqTlDZzY2q1yjRbeLNGw0iZn+gclSNSd0vTI5bHobFuUuOuCu/61fGbHSGE5TKC+F/09tLIhov1i4GrAqEkPMrFT4Fhrp5WLheKNOK4ZbF56a9jCydQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7hkdliR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7hkdliR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f30233d8aso40745375ad.0
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 22:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768200821; x=1768805621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZijDl8MuXV3c4TUqDBTyiqUvYTStLjeBUNZ7xneXcGw=;
        b=a7hkdliR2GSjkh4hLB/I5GBxmOsVjkYM8BzKwkXtKa1tbIlPJSsOqpij3qOrE3Xq4t
         7Hclbp0Uc9I4bduxWgWIR+Gx1kO7a9HyNsYtxHr8RoGCcqOUJR435EGPi3wyE0onVSa5
         4S9CGORalk2N9t1Kv7lV454RpZjo/CcRfWhV1G7rHImMSaxakr6T6dolUPItjJxDSDyu
         I6jCmtoVCwtXUHHc1OZETqjlnWrC0OCO5y/UgX522+nxalTGgbW61Kckx2Ld+Rayzgti
         6JPBrhT+L19gDCxn46EzUHqwq4xubAAdWlWQ2wg+Z8F/1ZM6UdfC9Ce1IEIx6kWdO39i
         szrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768200821; x=1768805621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZijDl8MuXV3c4TUqDBTyiqUvYTStLjeBUNZ7xneXcGw=;
        b=LIM86z1Wy82cQ+fWjE2Mis+/SrNqu+Mk6wdM/pb6uUBu/4lICxN7wKZ9Xwepjyh9UC
         5ZhiJLyhskJn/TJqIWzHdBG3Nu1FOMPRMS38UgN+xF8B+qfqKTuSPve03W2K0ifHMDxX
         beJi8TDZoultVjQdLJnbKeeEf02u3tEs+MylnGxudh7lMDaGqjeckYophQL5/mDT3PIn
         9fujgt3SkCM5upf2Uz2ZJt5QXyZb7VA8VfuConwglKbET8+GQu2HJWgun3eivvyvcjBb
         ZVEUINrP5yFvS8u1ejtv2NpWMakb6DY5V7EqvLFSlpJai141G2cpivfuhAl5jI1HyE8O
         Tb+g==
X-Gm-Message-State: AOJu0YxsKaHYXRyyybJIC/B/fQmwsXsXdDTm26jJ5lcUjrvjS1Fy3o06
	GO60OHOzqpLXeeEBrMDHpAJ2xlN4zgvsK/5PYf/Zb3U4FZmFpx0FSbC0K0d4MjdX
X-Gm-Gg: AY/fxX6vFaC+AfNJk/ElbYuhGOsYTunb9evO4rBZvttIvkR1Txn5I+7o/dtKo8dEw8n
	Z6nV12cpEsv1q49ljBcX7gT3J9FoLKOB1YHWk/+ylHrByBSJkUHK8uVn7xPmsGC7k5Um/TblLvh
	eFg8T3u6dYIOilsfAITY4sHoOfccQgeRAyWf6cmaVrpU7LEb450AFMmE2Zpz6DjgZ0SfCnc2qrE
	nWggJ6z9JdirChV8KcF5Typ93ie/NuPHvzF577lmQk7XqlySqt3+J7lWM+o3suWszLQnFEyowwg
	B9VjxBDNb40fmJV/WD+OPql6zFuN3PWxQL4euNyagJRbiI6bvR/0vKlK5F5dtV/Bxf5cn+fWpU9
	v/EUUVurHibGzEceMYFmKyHglD9hwn0HaRb6D/0KFI1szulu+SHDmzRg0orlB1cUMKe2ArqZNY7
	ZIRlwsdZouQJzFuqSHRvcu48plJDrkoHtO+7hJU4aVPWbh
X-Google-Smtp-Source: AGHT+IEdkdlUtybjMHY4YYVRqhYEenYWNgF/1engZ0K+WymtVrROl9Je8g5NZOLRDXD9W+9CmY8IWg==
X-Received: by 2002:a17:902:e743:b0:2a1:e19:ff4 with SMTP id d9443c01a7336-2a3ee4b750amr178655205ad.29.1768200820961;
        Sun, 11 Jan 2026 22:53:40 -0800 (PST)
Received: from d ([27.59.119.159])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f476sm2634005a12.8.2026.01.11.22.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:53:40 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: deveshigurgaon@gmail.com,
	sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com
Subject: [PATCH v2 2/2] t5403: use test_cmp for post-checkout argument checks
Date: Mon, 12 Jan 2026 06:53:01 +0000
Message-ID: <20260112065301.1290-3-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260112065301.1290-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
 <20260112065301.1290-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update check_post_checkout and the post-checkout hook implementation to
use test_cmp instead of individual test commands. This provides better
error messages when tests fail, making it easier to debug which specific
argument (old ref, new ref, or flag) was incorrect.

The hook now outputs in key=value format which test_cmp can display
clearly when there's a mismatch.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 7bdea25107..cb0300b2d2 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -16,13 +16,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 # <flag> indicating whether this was a branch checkout (1) or file checkout (0).
 check_post_checkout () {
 	test "$#" = 4 || BUG "check_post_checkout takes 4 args"
-	read old new flag <"$1" &&
-	test "$old" = "$2" && test "$new" = "$3" && test "$flag" = "$4"
+	echo "old=$2 new=$3 flag=$4" >expect &&
+	test_cmp expect "$1"
 }
 
 test_expect_success setup '
 	test_hook --setup post-checkout <<-\EOF &&
-	echo "$@" >.git/post-checkout.args
+	echo "old=$1 new=$2 flag=$3" >.git/post-checkout.args
 	EOF
 	test_commit one &&
 	test_commit two &&
@@ -112,7 +112,7 @@ test_rebase --merge
 test_expect_success 'post-checkout hook is triggered by clone' '
 	mkdir -p templates/hooks &&
 	write_script templates/hooks/post-checkout <<-\EOF &&
-	echo "$@" >"$GIT_DIR/post-checkout.args"
+	echo "old=$1 new=$2 flag=$3" >"$GIT_DIR/post-checkout.args"
 	EOF
 	git clone --template=templates . clone3 &&
 	check_post_checkout clone3/.git/post-checkout.args \
-- 
2.52.0.230.gd8af7cadaa

