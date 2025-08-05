Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25363261595
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386113; cv=none; b=uqC94PMPXW6x3/Ki8riybQ5BDzbFsnAB+R1Jeb1Y0pzHnVbET1VPUoMKQ/eemyRqQWpmMTK5/s2a7DAfTyoXK2puBIr9zvQGLEu8EoeEDg3B3bBObYG7ay4CPn60UrBG4OlWeLZw+8lUtV3gqq+ph5MxVDWw/qrWrR4dE/xXs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386113; c=relaxed/simple;
	bh=9jY112r3+enlwIev2fti0fM8GuF7Hc533e0x0JqDmfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFUEvlBdkaQ6JYkiqcBNTqvzOzKB+XWOsPhV3RiFAc9PJOLIaHZnjcvcBE8DtIe8NYWYP2Dan2+VPrcvOmlHD1es4s/FpsV0jzrb6b2o5xSlaWZ3lfI+39EVW2DT9ZL87uPZpcnwAdGlRBY304gqQHKpuPTTIVgrkzk7xNjnl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egL/umPw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egL/umPw"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76b8d289f73so3725809b3a.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 02:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754386111; x=1754990911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95k4kKmRzGWChwdCIn5CqZQoymO9GijhHXNHxZn1FSQ=;
        b=egL/umPw1XEVwVSRdw20ZzPlZhlWUpcvZX/0QDKvSbOUJzDejtwN7uHtVvYLbdFrYd
         Uv45Jb9b4PVA15VX9zrR1PgzHrSMn2IjtQ/+P0sahRIxYIUQCESKOZU0u1ny9AHyysFN
         xtjl5pZcjHBj9CqWSHQ4OVfaaJV3ZQJRFfmlgjJH4Txme4YtgTLiAL65AK7+AJoPRU2d
         lRRrnlgxSoFiEDZev96ba8eEUReNpD4IiA0mdhJECf9c2wwZZd87bQvs24aEcHcsazb9
         HYiI0VQz4KN61nVQxxJYlNUutc708sKhpM1rhj+NT0dTwtTUR5VwziHJE+VhrOeh0nuE
         Mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754386111; x=1754990911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95k4kKmRzGWChwdCIn5CqZQoymO9GijhHXNHxZn1FSQ=;
        b=Hrp/rox/v6WyVhGDM7cyacD5whExTwfrLQ5ba6/e5R0gXI1Fhew72igEzNEudjC2so
         3rSAroXUeDddrq+ZZn0TelhuJ5LueaUIrdGKAw8ob+QgQRpOSBvw6Uo2M0uaI090enRa
         OBu068xx/0qTdufp5tiFPKL/p99mJKM8Y18W1r/V5mkgJvBPiBXmO0z58Y5/VQRWR7ER
         uvCzV9HYpPlgdo656xcEobBptcByIsQtb0ifrMQe8ecX5G9kki+sStKKKXlyKbcw2Ukm
         iCv4DJidFOkg3v/o4unDLYznL3kCj+fbFO0GdEUq9grRJPMLnCfqUhiCAuKzvp2OHPwr
         kNPw==
X-Gm-Message-State: AOJu0YzGQEiOPDEm0m8glXWPJk6mpDmSL+VNdl2voo/Pn3PVWrGjZrRz
	hQeDLiI0SwRjqJoCvVTndp1AluZNcKMtbBR9QLCv+fd6u9T4oMgBnKSq4RLnRA==
X-Gm-Gg: ASbGncuiOX5wCJNesYpRzN6E2mj5Ul95NfLyrQN4UOcDk1Gnv0cmXBu0kjJZNY/4+h4
	x0IS810QYJTfrazBijQBKsIA/0/Nb//u7PsT1+vyFyhe+Z62cDutuSF/WwmuSXol1h/Ya+oqlM/
	/B5sK6oQxyVJSEUt7y37naOXyvOpxTiGF/iQwvQqVwiA8/Vw3g4fWN1R64CGHpTC3Ft1/DWBaaW
	yI/yAenk1iMRiEsA2+Q4UU2HqaOL1lHHV+EKz4Gh69ROTQhdZXcVKu0+Wz9OJItd1v7l5W392qR
	HoHI4RpDQJtUBUF4wljYN3ieg1TeiAueY4uT3/udg2EPacD+RlzB4A9+H1yMBFJULsu+T1ZSf8A
	Zg0eVJ7TjL5iEL/KZH9Z6ESWzqbbRUA==
X-Google-Smtp-Source: AGHT+IHQXOVZtkHyI8ZHn0kjzClWeo5+9NdeNiTVLmr6+/7pj984NSDnKWqhPgDHYOYFWageYqhLnw==
X-Received: by 2002:a05:6a00:ae04:b0:76b:ef69:1543 with SMTP id d2e1a72fcca58-76bef691a42mr14635812b3a.8.1754386111217;
        Tue, 05 Aug 2025 02:28:31 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcceab592sm12465691b3a.58.2025.08.05.02.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 02:28:30 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v6 6/6] t: add test for git refs list subcommand
Date: Tue,  5 Aug 2025 14:57:58 +0530
Message-Id: <20250805092758.5321-7-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805092758.5321-1-meetsoni3017@gmail.com>
References: <20250804092255.1092973-1-meetsoni3017@gmail.com>
 <20250805092758.5321-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test script, `t/t1461-refs-list.sh`, for the new `git refs list`
command.

This script acts as a simple driver, leveraging the shared test library
created in the preceding commit. It works by overriding the
`$git_for_each_ref` variable to "git refs list" and then sourcing the
shared library (`t/for-each-ref-tests.sh`).

This approach ensures that `git refs list` is tested against the
entire comprehensive test suite of `git for-each-ref`, verifying
that it acts as a compatible drop-in replacement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/meson.build        | 1 +
 t/t1461-refs-list.sh | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100755 t/t1461-refs-list.sh

diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..23a3702958 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -208,6 +208,7 @@ integration_tests = [
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
   't1460-refs-migrate.sh',
+  't1461-refs-list.sh',
   't1500-rev-parse.sh',
   't1501-work-tree.sh',
   't1502-rev-parse-parseopt.sh',
diff --git a/t/t1461-refs-list.sh b/t/t1461-refs-list.sh
new file mode 100755
index 0000000000..36e3d81e59
--- /dev/null
+++ b/t/t1461-refs-list.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+test_description='git refs list tests'
+
+. ./test-lib.sh
+
+git_for_each_ref='git refs list'
+. "$TEST_DIRECTORY"/for-each-ref-tests.sh
-- 
2.34.1

