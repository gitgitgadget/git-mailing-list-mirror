Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1E480DC0
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908337; cv=none; b=ARjJfwJg+BfqWBAACNDaUS/QelaC3sc1ixLj7RJvSAY4Y9xy6zrDcV+G8a/lAccin5fstdaRuj/cDsi0SXX/uFwpYBC/ccKw8NK8ObnetdE/KvMT2O5+onOzQpDZFU5zpoiA6oF95pjjxszy/2KqmmgzehZQxd78g9wR9CYOVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908337; c=relaxed/simple;
	bh=y2uzU5vNFVRfM+pafKNQvRwbnLOIisGexNOTXTYbf9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/eOKfw4SiHYANO+NSPtduzDWRshyeHjS4c8F2OfnWgGimgUaqAuRK2F60+E04QmUOQLDkQ4skZ1QN1OAkj4FAYKr/u0N0wpIEgxNOa0hgIMr/2LkmqyIqL02AcgJQUiRMPOTGk7S57hhAZvWTLbsOsQc6Z04W6g36frGypbjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rgA5pV0t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgA5pV0t"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49270caa5c0so5271315e9.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782908334; x=1783513134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=rgA5pV0tn/ZoMb9uoWaaUnmmmiWdyajnErPQC22k1ixxRDhBwGnJHWeSbBT66rCZZW
         89Pfx5Q8JA2bxZ5AvGH5TSxbP75MqvLi546G1620cMGDP9dAb/P1lsWWWPBwRnx+8u7G
         EI4yznaFgjoas4tt9vRdhTq9bcFnIL77ApVjU3RpJEbayfi0KS7vR1IZzLq5u3ehch/L
         t/DIpbNQKEbYXwJ2OZ8w//TZ6+IayO2Ix/a96O8VWBkheFii0XMNTOeYUo9/zqVF+BW5
         BC6BnWdEbxS2Saj4bP91CpghD8ttrXXsu2noMmcOPJzIgRwguXnGgoyOKfe5wYKhqygq
         +SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908334; x=1783513134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JSnx+CNl4jzPlODplDUft8aIHfS/Wkjf56tQY273kxY=;
        b=LLM6QkzTGjICClA4K2i4737j0y4bINgVMAcwVm400eda+kzeDSUfxsvMt2wVtS9S9A
         dSjSd9ZijSpzwUHe0Q3OTS1fFx6tdjiNelKMtYLz0PfY70xrXIYd8+3omXdXK2IHJBSU
         c6lfbYSSjO9SB/K+IvMrN73IVVJpzsl6M3BhAdVv7aV/MQ7GCNY6EUkUfiO+E4K5b3W2
         tezHTocPPGqToVLKHtgw2mfNuFb+xAyriBrrBI8D3SceqzgyuAVQclVGB15wQmxt+C+F
         gaOHXnjbruzD2iroc57Cm7S8OskZXkg0BaMDjyVFkJyFogOy7Lg84d151RY2744LrvNS
         vo6Q==
X-Gm-Message-State: AOJu0YzQMw2NCbFaXnfLhW4FPvEteoyLU7ZnhWRLlVcTMtQ89683gNHP
	k1bzx7zMyx/NnWwwr0r9GmKWFgsQ5g+fZKdiNLvhyS0lZlHOrSc9A9ZdcU1HRXcG
X-Gm-Gg: AfdE7clHKXAJIAPqAdZKFEaZPWqD4RzzD95CPgvM5fNKlhOWngSaNgpga3VUix9JEL5
	ApDCrIxRm6zHxOmZ2kWWfD+CvY7cunPURl+EcWV5z0ZGLMT4tzMwyDyXFi2aH8jKpOKVzwaLd9t
	mlJ7h1d62T44m5tBzhaurs9dcyTa7hnXQCdy+KGoelbZlfA0LHxm6iOzNXmCxxDQID5B3I55IRQ
	CTqOxsUYvza5ouLWZSLukBKd71ydL6PvCrtry4gDX2zWcChE64erS5qMVrwWG3B+L4QfQg0zIQo
	G2fUqsRKH2w0856jRBAO2+O+eVxivx8P7rh24hXWjX6kHpKhyomz6w7Azw/2xwwOuwcnqKxeFau
	0PnDJsE6iE60q3wINDyCok2wPmeiH4VnHSpUqMaJ8iSPMXp1rBKS/1mq7hbgWW2JF2PP5XeFZts
	MS1Ewg15qVhxO/Xcm05QE9PlV5peDov1fndeHY16in+mNb3mJXYIGfKeJRAdJtXrAU3s2TpmYL5
	sIg2D9tpeMamebM65tanFG6+9+d2OV2K7sIOReiQEs27zOELqesh2nYO5xEcCg66xAdS+l4ATxb
	UZWQKtzLl5enWXvXF9o4Wrpt6R7q6FDBcHc0sY/c5DjFiMXtlzOySPmoKbopgfvNd0N2+9AuScE
	pN3EEfR3SOg==
X-Received: by 2002:a05:600c:5808:b0:492:28be:6098 with SMTP id 5b1f17b1804b1-493c3cd9a79mr3904065e9.11.1782908334303;
        Wed, 01 Jul 2026 05:18:54 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm68267235e9.9.2026.07.01.05.18.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:18:53 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v15 04/13] t1006: split test utility functions into new 'lib-cat-file.sh'
Date: Wed,  1 Jul 2026 14:18:38 +0200
Message-ID: <20260701-ps-eric-work-rebase-v15-4-c88a43b63917@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
 <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

This refactor extracts utility functions from the cat-file's test
script 't1006-cat-file.sh' into a new 'lib-cat-file.sh' dedicated
library file.

A subsequent commit will need this functions, the goal is to improve
code reuse and readability,enabling future tests to leverage these
utilities without duplicating code.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..44af232d74
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related test functions.
+
+# Print a string without a trailing newline.
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replace them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8e2c52652c..8360f3bbd9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,7 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-loose.sh"
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -99,18 +100,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     object_name="$2"

-- 
2.54.0
