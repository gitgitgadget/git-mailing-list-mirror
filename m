Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwegKQAx"
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA389116
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 04:33:20 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c239897895so4035740a12.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557200; x=1703162000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po0dWZu+C6gweBJvf5nk2ASGBrSP9nUBZWAZaXFpDZk=;
        b=KwegKQAxjf4MNZNBkEgZbM9GsKkqz6EDo2svRvV2HHXkg6eCZ2R8Si1zoKh+a1Kpyv
         GK2dSvwLXh7hXAuHoN3Kb1QAmZ+yRCUDee7qyybySJKcxtRzYkRn0KZWpMPYjozvVuaa
         76xaKLQNMVaqFEE/YwBSDyOABEdRcavO4q3H3OoNQmWk81WgLGXvR/b93fp3eL5b46E6
         EvCFF3cgDXZitIXGQqN5PmIvnyczrc0MHlNFD7q9U2nEvd6RMv7S8ttkAMPzYSUKRzpH
         5sC4UsTbsC/jeFldYTaVMluvsHmDfOB25LJUrSxVPfsA+qH/wdD2DPeJrO8ZFzDjdq78
         jSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557200; x=1703162000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Po0dWZu+C6gweBJvf5nk2ASGBrSP9nUBZWAZaXFpDZk=;
        b=w9JpT5lkT6rLta1RyANJYFYe3y67M37bcO+pabSssA77USwHVZY47LXkHy8180oKDa
         /ijp4Rvk7ifJvJ4B0nS2imAM9Cyxz9lw25UuDpKlMv71i60na4utrQgtBDgK97QB3QqJ
         Ydfog7EnaJw1PLaCNCZgsKqC37uQkmM3IAILivMBBTDNhTfhsHI5Jg2vGmjC963sdrbQ
         yvc1Ss8qEV/mSdCbh3O2cXlmThnYr2ylv+H3wbZrsbUjzlvUyom60B/ZfXV3CaFXPgtA
         mgL/XX3CZJT1V7eQIkHm7ejfR28xQqTWHDQMKuGkWqK59lESKNOjFMe0XDZ1B7BrPmwD
         8FRA==
X-Gm-Message-State: AOJu0YxtczqgiuSgdViNJSdvsRyEO6GhwFmeZuybWwi+WXdRSr/7L+jP
	JYFJzk5AII2Mp88bf8CtKES8+uwNaPk=
X-Google-Smtp-Source: AGHT+IG8hQ4USXSdKzHwwe2V33qN27veIn4KYocdbiFL2ZgzX7J6xlzsB5qBoU+JR1jTWcHdjUXD/w==
X-Received: by 2002:a05:6a20:1604:b0:18f:457b:7ad3 with SMTP id l4-20020a056a20160400b0018f457b7ad3mr5634156pzj.51.1702557200016;
        Thu, 14 Dec 2023 04:33:20 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a734800b0028ae9cb6ce0sm3112368pjs.6.2023.12.14.04.33.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:33:19 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 1/2] t5574: test porcelain output of atomic fetch
Date: Thu, 14 Dec 2023 20:33:11 +0800
Message-Id: <210191917bcfa9293622908c291652059576f3e5.1702556642.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com> <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The test case "fetch porcelain output" checks output of the fetch
command. The error output must be empty with the follow assertion:

    test_must_be_empty stderr

But this assertion fails if using atomic fetch. Refactor this test case
to use different fetch options by splitting it into three test cases.

  1. "setup for fetch porcelain output".

  2. "fetch porcelain output": for non-atomic fetch.

  3. "fetch porcelain output (atomic)": for atomic fetch.

Add new command "test_commit ..." in the first test case, so that if we
run these test cases individually (--run=4-6), "git rev-parse HEAD~"
command will work properly. Run the above test cases, we can find that
one test case has a known breakage, as shown below:

    ok 4 - setup for fetch porcelain output
    ok 5 - fetch porcelain output  # TODO known breakage vanished
    not ok 6 - fetch porcelain output (atomic) # TODO known breakage

The failed test case has an error message with only the error prompt but
no message body, as follows:

    'stderr' is not empty, it contains:
    error:

In a later commit, we will fix this issue.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5574-fetch-output.sh | 97 ++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 39 deletions(-)

diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 90e6dcb9a7..bc747efefc 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -61,11 +61,10 @@ test_expect_success 'fetch compact output' '
 	test_cmp expect actual
 '
 
-test_expect_success 'fetch porcelain output' '
-	test_when_finished "rm -rf porcelain" &&
-
+test_expect_success 'setup for fetch porcelain output' '
 	# Set up a bunch of references that we can use to demonstrate different
 	# kinds of flag symbols in the output format.
+	test_commit commit-for-porcelain-output &&
 	MAIN_OLD=$(git rev-parse HEAD) &&
 	git branch "fast-forward" &&
 	git branch "deleted-branch" &&
@@ -74,15 +73,10 @@ test_expect_success 'fetch porcelain output' '
 	FORCE_UPDATED_OLD=$(git rev-parse HEAD) &&
 	git checkout main &&
 
-	# Clone and pre-seed the repositories. We fetch references into two
-	# namespaces so that we can test that rejected and force-updated
-	# references are reported properly.
-	refspecs="refs/heads/*:refs/unforced/* +refs/heads/*:refs/forced/*" &&
-	git clone . porcelain &&
-	git -C porcelain fetch origin $refspecs &&
+	# Backup to preseed.git
+	git clone --mirror . preseed.git &&
 
-	# Now that we have set up the client repositories we can change our
-	# local references.
+	# Continue changing our local references.
 	git branch new-branch &&
 	git branch -d deleted-branch &&
 	git checkout fast-forward &&
@@ -91,36 +85,61 @@ test_expect_success 'fetch porcelain output' '
 	git checkout force-updated &&
 	git reset --hard HEAD~ &&
 	test_commit --no-tag force-update-new &&
-	FORCE_UPDATED_NEW=$(git rev-parse HEAD) &&
-
-	cat >expect <<-EOF &&
-	- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
-	- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
-	  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
-	! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
-	* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
-	  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
-	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
-	* $ZERO_OID $MAIN_OLD refs/forced/new-branch
-	  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
-	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
-	* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
-	EOF
-
-	# Execute a dry-run fetch first. We do this to assert that the dry-run
-	# and non-dry-run fetches produces the same output. Execution of the
-	# fetch is expected to fail as we have a rejected reference update.
-	test_must_fail git -C porcelain fetch \
-		--porcelain --dry-run --prune origin $refspecs >actual &&
-	test_cmp expect actual &&
-
-	# And now we perform a non-dry-run fetch.
-	test_must_fail git -C porcelain fetch \
-		--porcelain --prune origin $refspecs >actual 2>stderr &&
-	test_cmp expect actual &&
-	test_must_be_empty stderr
+	FORCE_UPDATED_NEW=$(git rev-parse HEAD)
 '
 
+for opt in off on
+do
+	case $opt in
+	on)
+		opt=--atomic
+		;;
+	off)
+		opt=
+		;;
+	esac
+	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
+		test_when_finished "rm -rf porcelain" &&
+
+		# Clone and pre-seed the repositories. We fetch references into two
+		# namespaces so that we can test that rejected and force-updated
+		# references are reported properly.
+		refspecs="refs/heads/*:refs/unforced/* +refs/heads/*:refs/forced/*" &&
+		git clone preseed.git porcelain &&
+		git -C porcelain fetch origin $opt $refspecs &&
+
+		cat >expect <<-EOF &&
+		- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
+		- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
+		  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
+		! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
+		* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
+		  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
+		* $ZERO_OID $MAIN_OLD refs/forced/new-branch
+		  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
+		+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updated
+		* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
+		EOF
+
+		# Change the URL of the repository to fetch different references.
+		git -C porcelain remote set-url origin .. &&
+
+		# Execute a dry-run fetch first. We do this to assert that the dry-run
+		# and non-dry-run fetches produces the same output. Execution of the
+		# fetch is expected to fail as we have a rejected reference update.
+		test_must_fail git -C porcelain fetch $opt \
+			--porcelain --dry-run --prune origin $refspecs >actual &&
+		test_cmp expect actual &&
+
+		# And now we perform a non-dry-run fetch.
+		test_must_fail git -C porcelain fetch $opt \
+			--porcelain --prune origin $refspecs >actual 2>stderr &&
+		test_cmp expect actual &&
+		test_must_be_empty stderr
+	'
+done
+
 test_expect_success 'fetch porcelain with multiple remotes' '
 	test_when_finished "rm -rf porcelain" &&
 
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

