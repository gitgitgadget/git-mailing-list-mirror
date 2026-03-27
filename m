Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAC3A3821
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654841; cv=none; b=GnJDP6Q3TGL5lC48QCp0JbOXXL3+r2P5P8AjoXVXPYZbCQiQELMgplBR1IeLsDityBW4AH70kiuN3mWofgIlBPwXPBZs0Tnjz5tEWqBsn2mRb5lx0KvTweFbEXQ6amRJzikO7ZtWkS62yE5C4jeZBpUJnUfYoiCHi6NS6zqT1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654841; c=relaxed/simple;
	bh=cOzg36Y2gKMuJfB3i8q4AGU44YMN13ivsWDd5C7W5dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3+2/Fxfkbd7j9H1vsJhSkOqKaMO6TWeXaJfZd3vf1VCOvAMo3NBjPfZ6Ki/iSRxab0nLseXHnkhaLroFNk2aDuMfQzeQSBrxV8dUrLSTmmjrYnADb/gh7QITpP+e3xoqHtOsiWLhiba+6IDxe9sOlCwwTZ2ve10D1q70Rs3AbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq53rmb5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq53rmb5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso21409115e9.3
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774654837; x=1775259637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33fDOQFkGq/FAkWQDYnPdW2Ylt8mbwr0yhyi5VSePsE=;
        b=gq53rmb5n0zWdVRw4H/TFAmy2f9fTiz/ij/XYOGKVyf9oGHvIpI0wZIgxjh0/P9/+5
         pO/expzU0YbCxCU56vPvvCqDrzpu91cQhd8k301VHU4i8l32An/YMXzDC6Ri+tg09kPl
         kqW7LPrGAhJu9M/7Pw47Tf4ppBYcIdBB9EK62aovpWDFtlp0lF55MKmXCaCwAVUTnYK8
         n03uVkhBXFKFVLVQzzyBj2dhD90X24b63NUC1/a6kAjb9NcrNG/DgzTRZILX5z6mQwqq
         WOVfbLB6s1bYt94zfjukl4vTggS44pE/AG5hUA7qpxxFGeLEy8AMlvhjO0iXa3B3UJBK
         5Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654837; x=1775259637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=33fDOQFkGq/FAkWQDYnPdW2Ylt8mbwr0yhyi5VSePsE=;
        b=YfXSpsg9ETjqVuFaV0qycD/g3xlh4fZmTuP+BTCJ0MA5GGF0fobjk6Pl1Aza7RrpOk
         X1azGdAowgXPp6yX52blPBr1mP4sdYv2yF2QG5PIkZfaPG5rFIQCbDoj6e87VDsrOJeJ
         XXJ77Hf4YbcosUiWzeTuzGJQ7P16JPN8JmkwH7UkTOUA3G1GFWYRh3ELAYXxWjGJCEsb
         wrRZ5EimRDvEAVYO9pq5VaJtjaW8W2vEOs6CLb4cL+6DmkvyNysgW9mgaPAwFBZA1Yer
         uVGaJciU9x2wLAa09Nrera24xS+Hbrk/MsUI/g6Osb1YlJpLT9KLMycr2G39DOVKiiTz
         KF1Q==
X-Gm-Message-State: AOJu0YyK9/J2fAuJSQ75FsBQvjuh9VfCrCHJ6C40DbuktFAdOlbH19FF
	SbKcyDWnUr830LwjFtHrrPSdC3w1O94oIp7OsQdPpuhmHGsHPr/xX00cx662noyy9zE=
X-Gm-Gg: ATEYQzwynEAgAQSfTh9g4NV+qt+B9X5/mzynwzMxzR2YMrd0TrwxHmm4b8kOygVXWo0
	VAWQCWYF9idHTEBoW09SJnlDfQDJdJM+FSCLPmc+DB3wr88EzcNdWPMyU9VZ89yTkDHA6nvRoS5
	KrPo+xTddomgAPVm8grjzd6iASPqj2Tk1fhuT35DevkLsgAy0vJ+dgQEL6mIPRtMahx/+PcBUBS
	QrNNmVhBDSMf/K4OXZeDpvkpaeJoFEaeFBRiJ+dHpBWgzBV70CyxWgTMnCyRAnlGB941/6Qdzr6
	g46uVU/cAZEuH4IEVcsVH7kil7vb/8fSRGg7fG99Bavz+uyh/dKHX1QEwZuscG77pXLNMRjewOk
	g9Etdd2drqFKYQZ0jdwgT+cfPC7vDEoZn3fMrKxv7D5dth0VzCjLShrfKImiTrBkjBFLJigAsh2
	+h8eBGsynF1EgrFNaBTVMRRzsn0f9HG9ReoQsnarmuMnYLqORsQW88tUFQjH2ocRZk8BWhMtVJK
	6j9Z6sbIjm3zYVtbF8=
X-Received: by 2002:a05:600c:6487:b0:485:49c5:8eb7 with SMTP id 5b1f17b1804b1-48727ec7760mr67676555e9.22.1774654837053;
        Fri, 27 Mar 2026 16:40:37 -0700 (PDT)
Received: from alibaba.. ([98.97.76.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm1488281f8f.1.2026.03.27.16.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 16:40:36 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	ayu.chandekar@gmail.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	siddharthasthana31@gmail.com,
	Zakariyah Ali <zakariyahali100@gmail.com>
Subject: [GSoC][PATCH v3] t2000: modernise overall structure
Date: Sat, 28 Mar 2026 00:40:19 +0100
Message-ID: <20260327234019.95591-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326192603.23961-1-zakariyahali100@gmail.com>
References: <20260326192603.23961-1-zakariyahali100@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test script that dates back to 2005 certainly shows its age and
both its style and the way the tests are laid out do not match the
modern standard.

 * Executables that prepare the data used to test the command should
   be inside the test_expect_success block in modern tests.

 * In modern tests, running a command that is being tested, making
   sure it succeeds, and inspecting other side effects that are
   expected, are all done in a single test_expect_success block.

 * A test_expect_success block in modern tests are laid out as

        test_expect_success 'title of the test' '
                body of the test &&
                ...
                body of the test
        '

   not as

        test_expect_success \
                'title of the test' \
                'body of the test &&
                ...
                body of the test'

   which is in a prehistoric style.

 * In modern tests, each &&-chained statement in the body of the
   test_expect_success block are indented with a horizontal tab,
   unlike prehistoric style that used 4-space indent.

Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
---
 t/t2000-conflict-when-checking-files-out.sh | 122 +++++++++++---------
 1 file changed, 66 insertions(+), 56 deletions(-)

diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index f18616ad2b..af199d8191 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -35,30 +35,30 @@ show_files() {
 	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
 }
 
-date >path0
-mkdir path1
-date >path1/file1
-
-test_expect_success \
-    'git update-index --add various paths.' \
-    'git update-index --add path0 path1/file1'
-
-rm -fr path0 path1
-mkdir path0
-date >path0/file0
-date >path1
+test_expect_success 'prepare files path0 and path1/file1' '
+	date >path0 &&
+	mkdir path1 &&
+	date >path1/file1 &&
+	git update-index --add path0 path1/file1
+'
 
-test_expect_success \
-    'git checkout-index without -f should fail on conflicting work tree.' \
-    'test_must_fail git checkout-index -a'
+test_expect_success 'prepare working tree files with D/F conflicts' '
+	rm -fr path0 path1 &&
+	mkdir path0 &&
+	date >path0/file0 &&
+	date >path1
+'
 
-test_expect_success \
-    'git checkout-index with -f should succeed.' \
-    'git checkout-index -f -a'
+test_expect_success 'git checkout-index without -f should fail on conflicting work tree.' '
+	test_must_fail git checkout-index -a
+'
 
-test_expect_success \
-    'git checkout-index conflicting paths.' \
-    'test -f path0 && test -d path1 && test -f path1/file1'
+test_expect_success 'git checkout-index with -f should succeed.' '
+	git checkout-index -f -a &&
+	test_path_is_file path0 &&
+	test_path_is_dir path1 &&
+	test_path_is_file path1/file1
+'
 
 test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	mkdir -p tar/get &&
@@ -83,53 +83,63 @@ test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 # path path3 is occupied by a non-directory.  With "-f" it should remove
 # the symlink path3 and create directory path3 and file path3/file1.
 
-mkdir path2
-date >path2/file0
-test_expect_success \
-    'git update-index --add path2/file0' \
-    'git update-index --add path2/file0'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree1=$(git write-tree)'
+test_expect_success 'prepare path2/file0 and index' '
+	mkdir path2 &&
+	date >path2/file0 &&
+	git update-index --add path2/file0
+'
+
+test_expect_success 'write tree with path2/file0' '
+	tree1=$(git write-tree)
+'
+
 test_debug 'show_files $tree1'
 
-mkdir path3
-date >path3/file1
-test_expect_success \
-    'git update-index --add path3/file1' \
-    'git update-index --add path3/file1'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree2=$(git write-tree)'
+test_expect_success 'prepare path3/file1 and index' '
+	mkdir path3 &&
+	date >path3/file1 &&
+	git update-index --add path3/file1
+'
+
+test_expect_success 'write tree with path3/file1' '
+	tree2=$(git write-tree)
+'
+
 test_debug 'show_files $tree2'
 
-rm -fr path3
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree -m $tree1 && git checkout-index -f -a'
+test_expect_success 'read previously written tree and checkout.' '
+	rm -fr path3 &&
+	git read-tree -m $tree1 &&
+	git checkout-index -f -a
+'
+
 test_debug 'show_files $tree1'
 
-test_expect_success \
-    'add a symlink' \
-    'test_ln_s_add path2 path3'
-test_expect_success \
-    'writing tree out with git write-tree' \
-    'tree3=$(git write-tree)'
+test_expect_success 'add a symlink' '
+	test_ln_s_add path2 path3
+'
+
+test_expect_success 'write tree with symlink path3' '
+	tree3=$(git write-tree)
+'
+
 test_debug 'show_files $tree3'
 
 # Morten says "Got that?" here.
 # Test begins.
 
-test_expect_success \
-    'read previously written tree and checkout.' \
-    'git read-tree $tree2 && git checkout-index -f -a'
+test_expect_success 'read previously written tree and checkout.' '
+	git read-tree $tree2 &&
+	git checkout-index -f -a
+'
+
 test_debug 'show_files $tree2'
 
-test_expect_success \
-    'checking out conflicting path with -f' \
-    'test ! -h path2 && test -d path2 &&
-     test ! -h path3 && test -d path3 &&
-     test ! -h path2/file0 && test -f path2/file0 &&
-     test ! -h path3/file1 && test -f path3/file1'
+test_expect_success 'checking out conflicting path with -f' '
+	test_path_is_dir_not_symlink path2 &&
+	test_path_is_dir_not_symlink path3 &&
+	test_path_is_file_not_symlink path2/file0 &&
+	test_path_is_file_not_symlink path3/file1
+'
 
 test_done
-- 
2.43.0

