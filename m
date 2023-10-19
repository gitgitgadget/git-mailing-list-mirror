Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD822FE04
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOukeBwG"
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADA7B0
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 07:34:44 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57be3d8e738so4502639eaf.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726083; x=1698330883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVJ1+9sMYyj4GFuAsbpGr6CTa6yq6x3WHNHYFk12iyI=;
        b=nOukeBwG++6RwlezWSa9eteSDAi6tQo4Oj2hGUqx1ElXJx5LaTIJMLdcsAiJrPLis5
         pVZlzBKbV7+O2otxpLIVFF+eAfJzV5dJ4mBIrh5Gk9oQFZ9xvBd9nuSiKqHqsIF3AhBV
         hzYNd0ZoTiVeWsQcFn820HRjM6jMdIwGvH8d131DWUpNrSG08BBXmOQ776HHlelDhUnQ
         0v8AIHTEJ7MAWD/Oi6mFl67kDA+Z4zGlatE7gR4L/LHzTt+bGIpj022AZK+eDwXZCpVE
         YeYhqFRCi/a7Mni4DPTXwk8cWzXCSTMEiqVY2Mogr6g+4fYBkWu8uloJLGpxvU2sdhe4
         q3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726083; x=1698330883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVJ1+9sMYyj4GFuAsbpGr6CTa6yq6x3WHNHYFk12iyI=;
        b=NLAjgLHmlrZcL7cCbIkkQIyL5H1b1my8mO94zdP5yE09FD4FAQrdBz5NlnTqeFV4h3
         tUjzA0BvEKpKjN1Bm2VicFU6xkIqXS82mi/nbDqvgGvdY1IH7SXSndr6lJSUjpy/OyRR
         SJAgjLVjAtJPXCyem4pRRKj9PKSQUk8Ik+3YarXsGCLaV8sNBQf0REALGPjsrwwnvd7w
         fB/NPWmysvyCm8/XWGTYE6EbSKxJB0qt2bvEMeDpuWhwpJltjRyGhknyUJI68woqV1Im
         BONmhHF/+Y+FNoNkPc1Iw/pPYWSn9y0hFU3l7EJaE8jY5YFMlFz1Yr0O2x9LdxIaAw+u
         qWRg==
X-Gm-Message-State: AOJu0YwifapFXL7Pocv3gX7JoMxQbx+K73weOvCQYkXoQ+ws9deUN5h4
	bgS1337zKsb+UH0x4IPfjnvWzhvljmAsrQ==
X-Google-Smtp-Source: AGHT+IEGtxF2e9E3wiuMDPl6wPrMM7fi/OzAkTK2iuPcJzSa0EFywzQi3nyLrzwtrD/vF19huSw+3w==
X-Received: by 2002:a05:6359:100e:b0:13a:a85b:a4dc with SMTP id ib14-20020a056359100e00b0013aa85ba4dcmr2044071rwb.29.1697726082935;
        Thu, 19 Oct 2023 07:34:42 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f11-20020a056a00228b00b0068feb378b89sm5368869pfe.171.2023.10.19.07.34.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:34:41 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 1/2] t5574: test porcelain output of atomic fetch
Date: Thu, 19 Oct 2023 22:34:32 +0800
Message-Id: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
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

Refactor this test case to run it twice. The first time will be run
using non-atomic fetch and the other time will be run using atomic
fetch. We can see that the above assertion fails for atomic get, as
shown below:

    ok 5 - fetch porcelain output  # TODO known breakage vanished
    not ok 6 - fetch porcelain output (atomic) # TODO known breakage

The failed test case had an error message with only the error prompt but
no message body, as follows:

    'stderr' is not empty, it contains:
    error:

In a later commit, we will fix this issue.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5574-fetch-output.sh | 96 ++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 39 deletions(-)

diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 90e6dcb9a7..1397101629 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -61,9 +61,7 @@ test_expect_success 'fetch compact output' '
 	test_cmp expect actual
 '
 
-test_expect_success 'fetch porcelain output' '
-	test_when_finished "rm -rf porcelain" &&
-
+test_expect_success 'setup for fetch porcelain output' '
 	# Set up a bunch of references that we can use to demonstrate different
 	# kinds of flag symbols in the output format.
 	MAIN_OLD=$(git rev-parse HEAD) &&
@@ -74,15 +72,10 @@ test_expect_success 'fetch porcelain output' '
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
@@ -91,36 +84,61 @@ test_expect_success 'fetch porcelain output' '
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
2.42.0.411.g813d9a9188

