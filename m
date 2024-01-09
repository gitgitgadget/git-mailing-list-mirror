Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0C3A8C5
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TneURXco"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3f29fea66so15140175ad.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704819666; x=1705424466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H05f5DT1QMn1RVd0xp9sVOBYi7QK2LvNizACYhubXJM=;
        b=TneURXcobAIGmb6O+R2UAeAQHKPhi08Ngqrnz/pn4f/3BwNNLwoG3nYKRa0n5O5Xyh
         BIYUg6EtAjQfiqxifCHy915Dm/WSB1MqXCqqS9iK/Owt51BvUB4hDRzD0D+WTmlT4iDc
         zu/9P/VjW8zOFq+ksCNNfqoz4nU4EgIZz8bXDIE7W7783z2zqLxRVqvzhuz01uBeBuWp
         3EhQYbacU4vJ4DbZXv4q2eLeaUctV746F7LyOBqie0GfMqMztMJyunGwe4ojLtjT9zPa
         SuqaYNPQf0+TVBYndCSPnkTgEt8uhAYY68TCetbIs2QgoonzTv4g8Y/WeFmWGUH0V3aa
         mYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819666; x=1705424466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H05f5DT1QMn1RVd0xp9sVOBYi7QK2LvNizACYhubXJM=;
        b=NUeiNHu8dViKZ/O1FW7hOfsu0Znj25br0mOhHvqbJewh46Gm4TcPfwpzw1+0V7F/BL
         qm6wQhWTbq/CCXzkVawBKdIw35Gk+4RzTMkyPrWtEdvTVI7lIMikfVmscus279gRazcV
         tkyCB/78XI6JeU13MYyhVPtYLZ9++mMXAHBu+LQwrTtXwxviiplkOgj3vkIaTv8ITgo7
         C8wvoJJb2TaPx3EiFIwHIzjzdJ+jdiO6XOJRMcTZg4FuCirygLidaK6vfJ/8BzQUlQm2
         2L3qH0ZL0v4fEPZtYoySfDt4I8bU6RGqdp5TDKbUPVmCAErZmgrYTByxneuKpnUBRdBW
         0mBw==
X-Gm-Message-State: AOJu0YzjjjUn+iBJ4hnJ+/kKyp4NZacle9VldeXj/Zs5ZEvLgazYmyJd
	2SManujehclPQwc1RxwKEXMpQlNvM0wTmd3J
X-Google-Smtp-Source: AGHT+IGZrdN4Kfoc/iVb8PF7wVQfhhZAJKtXHhCr3BnVB6HDHFJkWXZlH6EnR/07WnwZ15jzi9an7Q==
X-Received: by 2002:a17:903:495:b0:1d4:2266:64bf with SMTP id jj21-20020a170903049500b001d4226664bfmr2788031plb.52.1704819665836;
        Tue, 09 Jan 2024 09:01:05 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709027c9800b001cca8a01e68sm1985851pll.278.2024.01.09.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:01:05 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 1/2] t7501: add tests for --include, --only of commit
Date: Tue,  9 Jan 2024 22:21:21 +0530
Message-ID: <20240109165304.8027-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adds tests for testing --include (-o) and --only (-o). It
include testing --include with and without staged changes, testing
--only with and without staged changes and testing --only and --include
together.

Some tests already exist in t7501 for testing --only, however, they
are only tested in combination with --amend --allow-empty and to-be-born
branch, and not for testing --only separately.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
A single test also exists in t1092-sparse-checkout-compatibility.sh
named "commit including unstaged changes" for --include, however, that
compares the results of sparse-checkout with full-checkout when using
--include and is not necessarily for testing --include itself. Otherthan
that, I could not find any other test for --include.

 t/t7501-commit-basic-functionality.sh | 55 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 3d8500a52e..9325db1f66 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, -i and -o, test reflog,
+# FIXME: Test the various index usages, test reflog,
 # signoff
 
 test_description='git commit'
@@ -150,6 +150,59 @@ test_expect_success 'setup: commit message from file' '
 	git commit -F msg -a
 '
 
+test_expect_success '--include fails with untracked files' '
+	echo content >baz &&
+	test_must_fail git commit --include baz -m initial
+'
+
+test_expect_success 'commit --include' '
+	test_when_finished "rm -rf remaining" &&
+	echo content >file &&
+	git commit --include file -m "file" &&
+	git diff --name-only >remaining &&
+	test_must_be_empty remaining
+'
+
+test_expect_success '--include with staged changes' '
+	echo newcontent >baz &&
+	echo newcontent >file &&
+	git add file &&
+	git commit --include baz -m "file baz" &&
+
+	git diff --name-only >remaining &&
+	test_must_be_empty remaining &&
+	git diff --name-only --staged >remaining &&
+	test_must_be_empty remaining
+'
+
+test_expect_success 'commit --only' '
+	echo change >file &&
+	git commit --only file -m "file" &&
+	git diff --name-only >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success '--only fails with untracked files' '
+	echo content >newfile &&
+	test_must_fail git commit --only newfile -m "newfile"
+'
+
+test_expect_success '--only excludes staged changes' '
+	echo content >file &&
+	echo content >baz &&
+	git add baz &&
+	git commit --only file -m "file" &&
+	git diff --name-only --staged >actual &&
+	test_grep "baz" actual
+'
+
+test_expect_success '--include and --only together fails' '
+	test_when_finished "git reset --hard" &&
+	echo new >file &&
+	echo new >baz &&
+	test_must_fail git commit --include baz --only bar -m "bar"
+'
+
 test_expect_success 'amend commit' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-- 
2.43.0

