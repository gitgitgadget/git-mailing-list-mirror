Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523623643F
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774157537; cv=none; b=C/CE93bvVNoEowcuepWr6E22nU+pl+HMsQeYPGdhevcCdLjsmyhifIbQTASMrpUT0q6X2b3V1rZ6PtLiXN1IZfus77MRVGXvJiXthJlX0uak24wGZ+qBHWLka/D+3ZPwcpNUwIhJF6yRD9Mo3LAHCmnhx4DzE/tfnXvXNgVyj00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774157537; c=relaxed/simple;
	bh=p81TjOghU66vifmegANc5ER8nwzNhAFnZTi75qDbW5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+y7wmg0rA8wBl+8eRUUq3lCwMQDKHplWCktwtY2LI0MtrODhT0Lyf0CNCmWcG/57hBnXdlWLeXdCQpswpN3irTATMDKKG/3TNBPpSrND83R1zl0NRk21pbWJTL1wkZXmAph5qqj3z76mDO9lSk4Ck/vfIc33JfuCjPY7q8TNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2Mz0pC6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2Mz0pC6"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a9296b3926so24404225ad.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2026 22:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774157535; x=1774762335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcbMR9Evzi63HpubEwgGaDk/xY7Q8MZ25CwR4g//RY4=;
        b=N2Mz0pC66kZa8wfHP6oF7EN6aJpE/pzIWxHbh1Z/McUdA9+gS34SdLDXaitD0oKXww
         vbDDWx70uDTl5/1tdA0XK4KSzqohBoWTOmwC15pfJ39R1FXa67g/DKDZS6M5RUTm+NF0
         QsplxZ1Mk6lnjSGEY+EaUt7L/FAxSxscUG7CqcAdmhATmD2mZDH4ea/dH0ZNxpCRK2hP
         UqqBBWIhh16FI8PTulbTsdrdZtIMsEWIEBFRoLwktSvfLYEQmk+HsDLOH1T7hG0CvegR
         Y/w5S5FTu2n16kacJGeP4snUsMUDl0QTLvFBIMpDONMq1vQaC4vGgpBHtCPG5jZWi6Um
         /Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774157535; x=1774762335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UcbMR9Evzi63HpubEwgGaDk/xY7Q8MZ25CwR4g//RY4=;
        b=Gr/ARhMCRz2ADRSfsBNEG1hDuydKHIUrrt4/ih1j5khmm7VbDDN9b/AKVZijbMFhMS
         iIvFfaAFuAPm/8TJ3+X7ythQ7KcIbWd6Rmhv68gtYuASThOz8V4/pS9b8DB7LPxz5BMr
         tggGcRTSECshCeZ5631PCLoERBncI7Pg+KeB+qlHo/3hNVohvbfX4CYD2DBFLXqx1skB
         EzgPmmeJfxe9UUwLR8b3977FyF6+EGz/1oiF9wPpqw1fNamYI5f85zGvSfwsIHztHtkJ
         bsaWrwGx6dnE2vYCJwhb8SoQMIYmNSQ1KmTic5ARsxbaErTu2VRFE6bSzp7XDFqcOsWY
         GRjQ==
X-Gm-Message-State: AOJu0YyXx8wL9czYp+PFV6YwMKrsA+3j0jz55sMgku/ivKvOYQ57hnu2
	cpBkzmzHTJmaozh+VhGE5s4tzMw32sZXMOOoSFLUOHQ4ZRgpHLyj/DwHMvtBNNMErsk=
X-Gm-Gg: ATEYQzyMrau8V5FnkGbqtWbopfyFo/AC3nRZkBUwy/7NsZtzRSLBmZzoS+HophIUDd7
	PKgJSbCgY7Vsw1TR7M8Vut88RgqVRPISH17PVX3kzVfMt5TzgwMB2JhicWpoSNnqAzA09g9+pMB
	d5nZzKIzjJ4ylcOtDBA6rC1rAZM8bibUGPk0mYWIFSYYXecVw33scF5aLgoU63Mb/0vil+HbVpw
	o5dSbdpqHBQozAzfi3NJykMpK84IKmHoSQXKZJ/DicyChoa3spcsmoZigpjoKM2/0OxqEg5H278
	m5oac+m9aS5kEOsYEvWlfbCF4QzdJW8COfq3vaThhk4bLQr0XZVdhWutY1KUB7JiYOro/P9kshT
	ld/XxobWU1owNjwZg8JrZ7Y//LPQM19si2MDO53eIJ/C8NDxdeI9kABLK0A7r4jO/Fa0qFohbZ/
	opcrWbYLw4jb5atuOnTEv/NxEBEOK4L4Cdxn9TbG9wzf1Pp0mhucaa0SgmYiVVNpDIpXQYqnYMU
	SgFCgrx/2JCiyfGn1+R2imsjvlGrbenz9PvIV0zPklpdr14CRRJZSEACmaBQDw=
X-Received: by 2002:a17:903:1247:b0:2b0:6d2d:f1d7 with SMTP id d9443c01a7336-2b0827cab9amr80153625ad.48.1774157535144;
        Sat, 21 Mar 2026 22:32:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fa:aa1e:45:876d:7ee7:e4df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656f65sm92860285ad.45.2026.03.21.22.32.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 22:32:14 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	stolee@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v3] backfill: handle unexpected arguments
Date: Sun, 22 Mar 2026 11:02:07 +0530
Message-ID: <20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <xmqqfr5sacps.fsf@gitster.g>
References: <xmqqfr5sacps.fsf@gitster.g>
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

Add a check after parse_options() to report an error if any unexpected
arguments remain. To ensure the user understands why the command
failed, print an error message specifying the unknown argument
followed by the short usage string. This matches the behavior of
other Git commands such as git bugreport.

Also, add a test in t5620 to ensure the unexpected arguments are
rejected with the correct error message and that the full option
descriptions are not printed.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Changes since v2:
- Replaced the backtick (`%s') with standard single quotes ('%s').
- Swapped `usage_with_options()` for `usage(builtin_backfill_usage[0])` 
  so the user only sees the short usage string instead of the full 
  option descriptions.
- Updated the test to also verify that the full option descriptions 
  are not printed.

 builtin/backfill.c  | 5 +++++
 t/t5620-backfill.sh | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e9a33e81be..6d90db3da0 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -135,6 +135,11 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
 			     0);
+	
+	if (argc) {
+		error(_("unknown argument '%s'"), argv[0]);
+		usage(builtin_backfill_usage[0]);
+	}
 
 	repo_config(repo, git_default_config, NULL);
 
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 58c81556e7..3f1eeb67e8 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -176,6 +176,12 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
 	test_line_count = 12 missing
 '
 
+test_expect_success 'backfill rejects unexpected arguments' '
+	test_must_fail git -C backfill1 backfill unexpected-arg >err 2>&1 &&
+	grep "unknown argument .*unexpected-arg" err &&
+	! grep "Minimum number of objects" err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.51.2

