Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E0351FC3
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465292; cv=none; b=ORX/jKCMUCPIjx8VVHKi+qZXgtriIVlwJqeDZJJMK/HJvW5K9NJlkBu8OhGrfUFRh3vi6736bEyMezX6sjg8ViYqDWE59E0sxIDqFygjm4TuILZVaY6gX41Gm1GvefpKfwkghvFoEI9cNv6//gzIMNRITYawBqFDv6PAovpcW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465292; c=relaxed/simple;
	bh=nseM8F0IXFRu+Ivv17i73t+Vb1ScMZc1V94La77UzBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lc/TXN8Z+6Sz2nwE7GwiJD5MwMJc0WGqZTsMUgcIMBlmplfqEoKTPhHigxbn54W2cuU29xn17Fpr0sHFbNPyNec1KSvvXaWgB4veYfJmhocLgPqKFe/rf5hgDQhfMLgCsK8c7Pi84L+0FRutpHCniMmGsnX3H7c2EzDS4AWstNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfSHJn2U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfSHJn2U"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b72bf7e703fso887148766b.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 03:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763465286; x=1764070086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERwcfEiK+gRENd0epNimFDSYuGjP6ljxZcrovWCDS8k=;
        b=lfSHJn2UiVNSMHhZNUhfQASqBEcTqhtbCzL7qEgEhkcUyYarxWwEZFgXVlqe0o2SBL
         aeyB94WrWecBTXosEpPl6kOJ9DWGu5aMHl6HKWA1Hr8CMgfkGBEuZw1LIPcvSWiPgkWe
         kM99LByRvUKL+njvqahBi1pxQHWUHYFwcvUkFMO4SDdpnXwgrZuKiuI5gWvnr2JtYGwZ
         Gw6n5J54lH+6wSLHiawkQUqjQFFYRzl7OXP0XeDYhecRlMvVD5EgIqOTJo0EfnqYPaEQ
         q8bpSVeuM0z3LnyZAUeFWBaV8c92ydEcy1/+mzm/XBhtie/eAfuGVNYvgrT35dBxeXyo
         0Tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763465286; x=1764070086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ERwcfEiK+gRENd0epNimFDSYuGjP6ljxZcrovWCDS8k=;
        b=VosY9w/xT+D3uVurNlOCLL764mtvY6ld+i4yKIc/SLWFExFIw1BqYM3kYprFyBd7/Z
         vPHWA7Y675dhHeUGA3q3wAYBRG3cSp6dnTX2s9n+0ghB0iykWMf98MGC/RZyah6MPmEz
         zb9+UvaTFIlQmkDEQXS12civtz0t8+VzgLDBTW0Rm/1DmksJA3enV/tBONZ4mTt3nyw9
         eO+NEkroFiUUyRyePeVEu3FHv7bgT5AWA7wJ1of5YtOiIyio92M3yhn1aCsI1VoT/kmL
         HKDBcnkFKfrvALoqF/BIYgdSPus9h/STaCoYZd8iqPZlalc9H6YuvhAGEGH5Q+NOvq7o
         qQ0Q==
X-Gm-Message-State: AOJu0YwJf2uDVavo/eGTC6gqSiK14kfyZ/o9vJ46qAYvwZMvezsxsDvC
	s0jxmrwX1ZJmFHgJRWoPyyZfR1LhknjHHgrkiKA9QsHs849Uphrh1gz7
X-Gm-Gg: ASbGncva7mrIx3NK2HNHsd1BRXku0DQf5kan6JzROjk/ucSJzV87GfMhmobDqB5DSc7
	jShqPL79yMtgkdVoTCgkQLZ2RGBks/sjlWFNz9YGxSm4TFj2pdfIXz0DkEq4p87h7TeUivwcMLN
	QGZxC8R0DC70XrLFpSNph86jyA0CxbH+QONnJLACPIbLE8N96EUdHStX8ELD/XP29J84OHykf51
	GBXgvUdiwN4I1g/mm5yYcqo02TAFDmQQviDgA33DQgz8K0JVU4Rl/rrA7gFNiDvkA64O+U6rr3/
	HgIMxjmrupqmjnIfZpcUFBviDdykWANWirEJF/Uu5AwOi/7cdOCUp0MSBN2PhaSoyQNcEtp095l
	VZxzBFkwzREi/kA1C/7UuHqgXNDyi3HXp1netwIQFQSsKxi3hfARMY43W3kU+Dve93TrmN52j3I
	1zBmcc
X-Google-Smtp-Source: AGHT+IERSpzlIj1oZylgtMJ51yeEcs6MvgnbUR0GTC7CqJ0+Fe9jPKkKDS2U6S+Mhpgv0r+3rrLTtw==
X-Received: by 2002:a17:906:c147:b0:b73:8f33:eee2 with SMTP id a640c23a62f3a-b738f43363amr1245388166b.48.1763465285428;
        Tue, 18 Nov 2025 03:28:05 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:118:b28a:3b78:ce56:def6:5cf8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73718fec4csm1005451066b.39.2025.11.18.03.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 03:28:05 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 18 Nov 2025 12:27:57 +0100
Subject: [PATCH v6 3/3] fetch: fix failed batched updates skipping
 operations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-fix-tags-not-fetching-v6-3-2a2f15fc137e@gmail.com>
References: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
In-Reply-To: <20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nseM8F0IXFRu+Ivv17i73t+Vb1ScMZc1V94La77UzBE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkcWD0Y3arb+qqyKpAt6OCrNt8s+j+RLyq77
 bncn8DAW3ZbyYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpHFg9AAoJED7VnySO
 Rox/sasMAIv4kcACPjLasc/knp72Tf1zkET3OvxEceMp7gXv+aJDDuZKp4WEFQI9FyuTUsxiz+C
 XQY/g2o/XzJ6faR2mDh55tOmM28JitY7UzrOYkPKvQgCBdZm69kOzc0g++F06Zj8+uMQtUOmnqS
 MCYY0X2rT1UHvp/R//pbg37jAzGhMytCviVLAnTic9tiNb2f2vc70DkdluJZoCEh5mR7neBhzn6
 Ruft4Ei9iAeke3rjqwR7PoCOTOghwOt7jI1BbS/ePugmhQfWyNATQqVaoJMOM6sxOZpzmkPkKKu
 BObMwd5B+06saSwboTbG33kmqXtoLDKim3QsaeMVaZSvV35zoAS70Z/z0c8vBcHPwB/hxVIUiuP
 HhFKZfOFo5drCVTnpjA5Bjn/dak5hK8/pkFpv42PfhhjaXEKQlO4NfGuw15WUu1dGuVGJ7Zr3/j
 pVYVZaXY+0nhlpamEkhRezgGZ+9F7+LOsWuXamWg0BqVDuYGk9ziMX118kYq1P5LJ31i99ix1A7
 ac=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Fix a regression introduced with batched updates in 0e358de64a (fetch:
use batched reference updates, 2025-05-19) when fetching references. In
the `do_fetch()` function, we jump to cleanup if committing the
transaction fails, regardless of whether using batched or atomic
updates. This skips three subsequent operations:

  - Update 'FETCH_HEAD' as part of `commit_fetch_head()`.

  - Add upstream tracking information via `set_upstream()`.

  - Setting remote 'HEAD' values when `do_set_head` is true.

For atomic updates, this is expected behavior. For batched updates,
we want to continue with these operations even if some refs fail to
update.

Skipping `commit_fetch_head()` isn't actually a regression because
'FETCH_HEAD' is already updated via `append_fetch_head()` when not
using '--atomic'. However, we add a test to validate this behavior.

Skipping the other two operations (upstream tracking and remote HEAD)
is a regression. Fix this by only jumping to cleanup when using
'--atomic', allowing batched updates to continue with post-fetch
operations. Add tests to prevent future regressions.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  6 +++-
 t/t5510-fetch.sh | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b19fa8e966..74bf67349d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1890,7 +1890,11 @@ static int do_fetch(struct transport *transport,
 
 	retcode = commit_ref_transaction(&transaction, atomic_fetch,
 					 transport->remote->name, &err);
-	if (retcode)
+	/*
+	 * With '--atomic', bail out if the transaction fails. Without '--atomic',
+	 * continue to fetch head and perform other post-fetch operations.
+	 */
+	if (retcode && atomic_fetch)
 		goto cleanup;
 
 	commit_fetch_head(&fetch_head);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4b113d7c27..f5c87d81fe 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1639,6 +1639,93 @@ test_expect_success "backfill tags when providing a refspec" '
 	test_cmp expect actual
 '
 
+test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	(
+		cd base &&
+		test_commit "updated" &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @
+	) &&
+
+	git init --bare repo &&
+	(
+		cd repo &&
+		! test -f FETCH_HEAD &&
+		git remote add origin ../base &&
+		touch refs/heads/foo.lock &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test -f FETCH_HEAD
+	)
+'
+
+test_expect_success REFFILES "upstream tracking info is added with --set-upstream" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base "updated" &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		git fetch origin --set-upstream main &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES "upstream tracking info is added even with conflicts" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base "updated" &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		test_must_fail git config get branch.main.remote &&
+
+		mkdir -p refs/remotes/origin &&
+		touch refs/remotes/origin/main.lock &&
+		test_must_fail git fetch origin --set-upstream main &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES "HEAD is updated even with conflicts" '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	(
+		cd base &&
+		test_commit "updated" &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @
+	) &&
+
+	git init --bare repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+
+		! test -f refs/remotes/origin/HEAD &&
+		mkdir -p refs/remotes/origin &&
+		touch refs/remotes/origin/branch.lock &&
+		test_must_fail git fetch origin &&
+		test -f refs/remotes/origin/HEAD
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.2

