Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F08368299
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235818; cv=none; b=YFXmSzED9YbB8wkdjY8b84TScwBBUa8DeGv105AdDOX25ArdKSN7ES6ecskJLM2wtCesBvglwRX5Y9e8RLXlcRsFHH2RFf/6xNhQnEDh+vl1l4uNA3o/khASzfrnTJHazEFF+hF7L3NrGFX7GcHBjPgzYBtbwgl73pgSeXb9h5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235818; c=relaxed/simple;
	bh=IY4kCci68Mx2J+vD75pxBUxGt68jdig5JYBFETRVKnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpyEIbSFgSghqmrjUNB8G7cJH75+bXaqxMvx++mXYBDA7gm5MrbESJAWyvuEPGg2+Gea1ADh3V1QuHkS9NFc+32zt/zK4xzHCY7g3mZ5p9UXBza81G48jjg4EOXFOPPy6ToVc1v3Z0aKTEa1k1BTBquL8nUoBujnJmaAx9dSnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGucCHUG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGucCHUG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c09bb78cso40974365ad.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768235816; x=1768840616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZijDl8MuXV3c4TUqDBTyiqUvYTStLjeBUNZ7xneXcGw=;
        b=GGucCHUGMnxXsABHqrJt3mt8WKMwhncfm86v7aAlFrJn3LhlE79N6/c7lnoXmeSbKG
         Orf0e38Rkmh3SOcfn5zFATVkzNRyof0NJ38hEg4FAr88OmVQMeCIQAIjKM/El8qLSaVh
         zUxqI6BgIIZh4A1KRqCjmgqUH8N5qEfBRg0GSi69CV34Cm6j7N5gyMEA7WNO/rzcO/82
         urJ29UlBZ9Vkd8+0xtTFIO8uOYRmpaUJAz+pbyKV9FXgHeRkYxPL36rfoJSwmU0Hq3Xq
         3kYScoy0q79IBQ06/Y6u8GkRZHy19p8x4Tbm6620u2nkbMjh1ZXRGwqS4PyZGmMgd98O
         PTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235816; x=1768840616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZijDl8MuXV3c4TUqDBTyiqUvYTStLjeBUNZ7xneXcGw=;
        b=peVK7EwsyFasCHN2v4W1mmKTABvZyWRe6ipmdvVmcoaYxWqOQRBZmWGY78/iQ6YqZd
         oTJajV/Mgfe76tyhV1EVxdNu59/o+4jIhCkiLyNoPZTsoHzgd71yjXxkOXC+zrfCJvgg
         lzzeC4p4x26r6OD/cw+dCkThLMR6+IJwxQ+cYYMYV+Qy6S5jkGRm8Oe4HvJcd+/83LxA
         AvIu054TzW94L0Zb1LXCxKjb9G3qv5X722YZoP2B+SsKvTqANWX7kc9cVqfvfGgS2cjW
         DCRb/l8UxUYbtvF9DHAPyzbKEed7+Oe5fHwCkLCd1WHIMJdEy287xwvk3x/N9U2MS7DR
         2YoA==
X-Gm-Message-State: AOJu0YyqwOW67V+2MZjPNKxckh6onCiwOadNEv0ozr/ZvaUmfC79d8fv
	SV6lOTE1uO4ImLu/0UXgLyiJv1luWO1CDQP+2VU/zD7nerGOdDmf3xMUTFgNrxvL
X-Gm-Gg: AY/fxX6tswZhpu0X+CVFZfx0zXXiFbPGvu0pzptBVCpoPYRNa2K2xL1tR1MocUSx+Sc
	D6w3IoOye+uPT7Qqo7aPei5Q3VsPqDewXBgNAYwWHgQRtGnZfagP4Fx+mHJYeqy+j2Ck1xUtH6T
	lNBom2hgOTwhIc0J83o+G20Fhc3/OtCbVuY+X8Y2vrnZb2wJ1UZ+sGx69gGJ4w2qjizmSnTGcPN
	vC27tLhkVW7J6pHvKDxh/9hy5ZtXlYMwPzBlNM2yhl9frukuAX+gG6rsukrSEvr5tWlz6aEqRHS
	YPZFQsyEgO9KQ8SK1epBqvPWAZtg9/2QlU3oL+RPmDs5ACWskQV0cJ/R95dRlXBt2Jz25lh/Z/A
	I65WCM0/p7lvo+bimNKlJFiPg4RQdpGISnQ+z+NVNh/9Em55GN/vqIOiXKvb+Q68zbY7j1+jpQx
	IMzOf2jAwqOrWmCs16RgxT10gXRVQ+3yvV
X-Google-Smtp-Source: AGHT+IGk+YDDf/CEYkt1A+RplfCRh/j7+r00HgP+Xmzh4KXUxVVHCiHfrR31fhoDvBLrYUyhsKvmJA==
X-Received: by 2002:a17:902:d2d1:b0:2a0:f0bf:197a with SMTP id d9443c01a7336-2a58b4e4758mr77485ad.13.1768235816115;
        Mon, 12 Jan 2026 08:36:56 -0800 (PST)
Received: from d ([49.43.40.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2c04sm183006655ad.53.2026.01.12.08.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:36:55 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: deveshigurgaon@gmail.com,
	sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 2/2] t5403: use test_cmp for post-checkout argument checks
Date: Mon, 12 Jan 2026 16:36:43 +0000
Message-ID: <20260112163643.231-3-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260112163643.231-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
 <20260112163643.231-1-deveshigurgaon@gmail.com>
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

