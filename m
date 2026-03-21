Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050E19C566
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774115260; cv=none; b=itqB0GlT/80bwWySScbSb6iEz8klD+fdWKG+7LqDYBT8gnpAnV2UKjXvBgpZi+4MDcPRbDgZdjIAdqH1MCSEX6+KLnJeYFHmxXEh5isQC93bxptM2UvajAL9HdBbgpdcKO1c3F2z22les5vGyIhtQhL9HyANmlHyr/dVEER1teg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774115260; c=relaxed/simple;
	bh=LKo3Vv6U+2NEKC37MzbOLHe0HTHQzCqDF1wa5aM8MTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppA9AIIFqsj6NekGpquCpxk4KTHUL7bg5gLh9++6berrRTtAFosrcSfurfgotCqKcpXCAg5jo+zA5WHGJt810VR7zviJGv8MFNvf65DV64Yax75jfscuqUZhZ+mm5V7qoo9ACBwF4N4JWK8hg7F/WgCdhajTdN8pwLs1gEd6ujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQWQO2Wx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQWQO2Wx"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so2029644a91.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774115258; x=1774720058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13ZFPts41Qqc5sJTN4efZzhoFpSqSngJQQRAWy6pfhY=;
        b=MQWQO2WxuguXnHQQ9DYfQBzFe8RXnsP5xuuGVccRF+Z1HxOGoFWnUY/KmI0V6inNFE
         aLFBO2qa09KYK4QwMX0MSt9sODa0rHRwampt5coquXVNhQVYcGzDnHA0hcnjJh5TC5cn
         Br/EGK976AWsCZCfyzrC9T2salec19naipBQiGK3LsciznfiFDdwIelpBI+jW9hKJdbP
         cjngmVcAdA6knOswdTmf6ymSr7K7i7tarpoZsm8UKfAmgkhqlZS4rUrPm4ZzSHSay5ss
         L7l877z+mC3n03Vh5RmfdU7BqApX9MqtZzT/nZNXrdVh4JMVup1Ikd8xxUpfHDYNh2LQ
         9q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774115258; x=1774720058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=13ZFPts41Qqc5sJTN4efZzhoFpSqSngJQQRAWy6pfhY=;
        b=mR3iJv0gFCXcIeGAFlh8zwJsCtSXzb9GwK76Tph+91pG1HCRQC0oEXnKZIdITQh9pc
         8Yp31Mh/lDLCEIFufDo0x8QYvlkBnVTHTZSDgMJ1kvcmAnx2KDmLmhAa5s21XNE9Dxga
         8wMj+T8BUurF4XACql6bNs1C0Tz813SBhNmBKYOE/eIHVOd0lioiO1gZXi1jGbf3K+dd
         3nbZCV1vaPp2Mm6lhyFEkjhFYwdZquEcf2svxI8XpgDq52EsDZw+SdEkvI3B1O9848jr
         br/xdAyuB4MG3rVh6tOUgpsEBZaNGKjJHg1TemzsWnL0jcLnmzD3anIAfkjrgr+1B7v0
         xM+w==
X-Gm-Message-State: AOJu0YwhFNEjTxRpw1imagp2zjElQaohX557RhN+xqcXWqnrnWFOPK0a
	j6klt+a0c4zIbRXxxNfWHYp7+ASYqE0YwJYmzuubzHpwDwr0yIwC+xj3fCjtquzyCP8=
X-Gm-Gg: ATEYQzziJyRiMkxTASAJOftW2yS+YyDtJ/qLvMQWG85l7OkrOCUZ51VRg58Z7h7xwvj
	jr1I8m6aBB7sgAL4yZWOq1ClF4EtGZzgSxjXqDfYyIwQ+JtxTU8jDZpyPklHBWVfi3mfMpo52CH
	+/Vd9BslGPCmPppV4582ibpwq8GmikdMizVj2loviKykoIfCZeaW0hHTqJzkwWkAH2xtETwrM15
	pAqAfweuWFoQHLaYHNRLbrrf85AXh9babro3s/c1bEnd8ggIX7XebR+myRO86WJdQAd5XME0v1V
	7hXB0ML7PAjmdBU0UMq/5adbCX5GH25joEdlp7aVpekcUJpQhrZheKeoeoh7NTimwHqqVrlNqBk
	ikItSPd/qyTRuJRGi9srJJtxlRghvC0VAqLpPBtEOFrT8vY7wf6/p+g9Ct8YL6/eonlqjV42ijm
	6fMOA7q9hZlt1LBGvvBptoapAq1mNLbBMHzkBcMvwYNM48L4Ah9MNPZk02zdQyOaws1AbzqNrIk
	jTcQXXAHYxV8RTi+X5emwg0pfWvPZS3wYyZ6AdnSWm0K/Oj5MLlyZx71g==
X-Received: by 2002:a17:902:da8d:b0:2b0:5903:140a with SMTP id d9443c01a7336-2b0826c731amr66877485ad.10.1774115258372;
        Sat, 21 Mar 2026 10:47:38 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fa:aa1e:45:876d:7ee7:e4df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836955dbsm77137125ad.72.2026.03.21.10.47.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 10:47:37 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	stolee@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2] backfill: handle unexpected arguments
Date: Sat, 21 Mar 2026 23:17:30 +0530
Message-ID: <20260321174730.34762-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <xmqq341tdbal.fsf@gitster.g>
References: <xmqq341tdbal.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git backfill takes no non-option arguments. However, if extra
arguments are passed with git backfill, parse_options() leaves
them in argc and the command ignores them silently, giving the
user no indication that something is wrong.

Add a check after parse_options() to call usage_with_options()
if any unexpected arguments remain. To ensure the user understands
why the command failed, print an error message specifying the unknown
argument before showing the usage string. This is consistent with how
other Git commands such as git-bugreport handle this situation.

Also, add a test in t5620 to ensure the unexpected arguments are
rejected with the correct error message.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Changes in v2:
- Dropped the word "currently" from the commit message as per 
  Junio's feedback.
- Added an `error()` call before `usage_with_options()` to state which 
  argument was unknown, following the pattern in `git bugreport`.
- Added a test case in `t5620-backfill.sh` to verify the new error output.

 builtin/backfill.c  | 5 +++++
 t/t5620-backfill.sh | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e9a33e81be..5a333afde0 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -135,6 +135,11 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
 			     0);
+	
+	if (argc) {
+		error(_("unknown argument `%s'"), argv[0]);
+		usage_with_options(builtin_backfill_usage, options);
+	}
 
 	repo_config(repo, git_default_config, NULL);
 
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 58c81556e7..d74e1be74b 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -176,6 +176,11 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
 	test_line_count = 12 missing
 '
 
+test_expect_success 'backfill rejects unexpected arguments' '
+	test_must_fail git -C backfill1 backfill unexpected-arg 2>err &&
+	grep "unknown argument .*unexpected-arg" err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.51.2

