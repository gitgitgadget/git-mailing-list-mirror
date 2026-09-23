Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC19819005E
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158953; cv=none; b=t3T0uczypdXQQrL0xdHU6s/oRWM37bIJOcprPgjdV1tDTrL+pRA+kiG/9m4JnwLRawsrr/uSZbA2cDzyXfdn044F/ZID0dx/vZoHh4rDhHZ9WP43Q3N1TUa7Co3EYjV81PbAe0LOYVLOqWbJvV/3xdpYvSs5b/WuJXciLrPOh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158953; c=relaxed/simple;
	bh=RE34tPJnMCUpF4mW4IzM3IwH7IW8TNlFvSv8Q6AWB3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKjtzps4gBnOfDmi+vdVNHproCnteWw9ZGDBqFuh4AHuzyS4AxU9er1wNOMB+RtAImH46j+WgsgqtYHW3sXPIQnjqP7oi8pLQ9eDxlyJ6UiGd+EfB+p7cFrdnYeIpdmF92DZNsOTqdpkp3ePj+fPRhBO5DJkJIKfQM1+hxGN8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL7IopYE; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL7IopYE"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef783so433172eec.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790158951; x=1790763751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mU23xf38uGdbbA9X2E97KP7obu0p2KbHgTy+H5kTCE=;
        b=eL7IopYEidAkdBNbh/fVU/SfOjpx/MF77DOeuO5qp/RhJhY2wuHijEsp4AbtIFQ0or
         la7OfTZAAByQVDmSPsAarkvaSVGzYRdk6hBUN9PYc7oFnPxRrpV7hREWdpRi/Wc/MRGw
         S4PGKLLKMjAg4nlS3CUsMbEkUE0IVr10rJP4idjFO+5y7DviuAgF3/Vc61A06TY8bcJt
         9/20/4kKR8wJdpSHtzPjHJiSvdcTKtOyDVg/ILF6IMI4bj3cG+qBWyxHgR+xespasn78
         XCcEKLcLhQ3gONmP9ag8gva+qf/TrwYT1ADGaBzZyrsqBKj+NVti2+u0a0YBxqFz/ARc
         6RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790158951; x=1790763751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4mU23xf38uGdbbA9X2E97KP7obu0p2KbHgTy+H5kTCE=;
        b=H9/t2fT8sBaP7v3yiWBzpaXXbVz4WZTURyFrk4WAU/SKICwoqkoRKCQhht9vgr5PD8
         qhM6XKLnjjxUKHvoe4W4la5hnz8nJcGxjOAggj6yXty9Ink5tBJXrLr9NCJjmZ6rcJ6o
         14y2hZUuSQRRuAZ+i/zyEsAlz0Y920JsEfjB5A+w6dfzr5KXRjQWyEr5WduVhyVNlG3i
         LjfCko75FJfPw0Hf4OdKAPZ0DgXinMxVZFAlmTMsb6SjbUcrokQ0O5IjzLjrt/iS3BLt
         uRYVE/9Ymhp8wtUPN3IzbI0PbSDGDhZ+T9Rwd0McXIl+ndMqVW1tbu8qvuFgqL+vBTw5
         vaeQ==
X-Gm-Message-State: AFuF++m+q54xZWUDmRgkLYaZoX8v88Cx9l74gju0fLscaYEi9z98b+ZH
	+/YHC7jEQ2yYzDu+C7VJf0gS0ZRDudzwNDxM5NAmgqwl2S64MsnhzoWP
X-Gm-Gg: AYBFou16Llh2TpMSC9iqw0wEbGsD32SbYMrx0UH+7LdPxb5jk9fSOZm5eB/csOS9ImX
	+ghEYSaZxvucJRQdR6Sb1raZQMindQzEbJcL2cfa0bFLiJv0kAJhJtueE++jZn9dAOeKKdzqzND
	4aEiuI0CXQP5OdKxd+wxyTJAYBeLs3AwN7QPPthDuA6FnXQRGhU6bzUHs/g2vKoiDm501bLYOUj
	UE6BB5bNP/7BayGHErYYC4qWjvVbTYXMxIfYjxSjGLYmsmV5J8u0rJAVKB0nbaEHQp0QqOIj4mY
	c2nPFslsTGzyxiI3t0BljV1+Rw8S/NVzeh32HsKxGFBuF+aRfdETTx5cN842viOcUS+tVSpFVgB
	N51qbc9RFuEdrFpAREnKOxR2XcPklZ5s7cn71dwOa4+38h/j71DqBTDnMx5vhoJ/IIEF4/UUInC
	+gYOpg+X/MCXuEPkJQFoEsxtQjfuAjO14ITEIKlKDGiQUgYnEtoj2CfDjZnd2G8xauDn99zKygW
	XZaiBo+wtj1RHx2eIo8KAjQ/Ax81A==
X-Received: by 2002:a05:693c:87ce:10b0:33b:b4b8:ac57 with SMTP id 5a478bee46e88-33e8dec34e3mr2151012eec.29.1790158950533;
        Wed, 23 Sep 2026 03:22:30 -0700 (PDT)
Received: from HP-V15.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258978sm5263195eec.14.2026.09.23.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:22:29 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	peff@peff.net,
	ps@pks.im,
	r.norouzi@proton.me
Subject: [PATCH v2] reflog: fix default expiry periods
Date: Wed, 23 Sep 2026 10:21:41 +0000
Message-ID: <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.55.0.1055.g20c0e7c0fb
In-Reply-To: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default reflog expiry periods were swapped when they were moved to
REFLOG_EXPIRE_OPTIONS_INIT() by 85658275702b (builtin/reflog: stop storing
default reflog expiry dates globally).

This caused reachable entries to expire after 30 days instead of 90 days,
and unreachable entries after 90 days instead of 30 days.

Reported-by: r.norouzi <r.norouzi@proton.me>
Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes in v2:
- Expand the regression test to cover both reachable and unreachable
  entries before and after their respective expiry periods.

 reflog.h          |  4 ++--
 t/t1410-reflog.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/reflog.h b/reflog.h
index b996712c00..3bdd1ca8a5 100644
--- a/reflog.h
+++ b/reflog.h
@@ -23,8 +23,8 @@ struct reflog_expire_options {
 	int recno;
 };
 #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
-	.default_expire_total = now - 30 * 24 * 3600, \
-	.default_expire_unreachable = now - 90 * 24 * 3600, \
+	.default_expire_total = now - 90 * 24 * 3600, \
+	.default_expire_unreachable = now - 30 * 24 * 3600, \
 }
 
 /*
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 8f78cf4b01..c494aa5ef0 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -153,6 +153,51 @@ test_expect_success 'reflog expire should not barf on an annotated tag' '
 	test_grep ! "error: [Oo]bject .* not a commit" err
 '
 
+test_expect_success 'reflog expire uses the correct default expiry periods' '
+	test_when_finished "rm -rf reachable-keep reachable-expire unreachable" &&
+	git init reachable-keep &&
+	(
+		cd reachable-keep &&
+		timestamp=$(test-tool date timestamp "60.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old &&
+		git reflog expire --all &&
+		test_stdout_line_count = 1 git reflog refs/heads/main
+	) &&
+	git init reachable-expire &&
+	(
+		cd reachable-expire &&
+		timestamp=$(test-tool date timestamp "100.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old &&
+		git reflog expire --all &&
+		test_stdout_line_count = 0 git reflog refs/heads/main
+	) &&
+	git init unreachable &&
+	(
+		cd unreachable &&
+		test_commit --no-tag base &&
+		base=$(git rev-parse HEAD) &&
+		timestamp=$(test-tool date timestamp "20.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old-20 &&
+		old20=$(git rev-parse HEAD) &&
+		git update-ref refs/heads/main "$base" &&
+		timestamp=$(test-tool date timestamp "40.days.ago") &&
+		timestamp=${timestamp#* -> } &&
+		test_commit --no-tag --date "$timestamp +0000" old-40 &&
+		old40=$(git rev-parse HEAD) &&
+		git update-ref refs/heads/main "$base" &&
+		git rev-list --all --objects >reachable &&
+		test_grep ! "$old20" reachable &&
+		test_grep ! "$old40" reachable &&
+		git reflog expire --all &&
+		git reflog --format='%H' refs/heads/main >actual &&
+		test_grep "$old20" actual &&
+		test_grep ! "$old40" actual
+	)
+'
+
 test_expect_success 'corrupt and check' '
 
 	corrupt $F &&
-- 
2.53.0

