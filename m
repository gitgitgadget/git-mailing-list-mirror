Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187601F488
	for <e@80x24.org>; Mon,  6 May 2019 23:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEFXXY (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 19:23:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFXXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 19:23:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so19456735wra.12
        for <git@vger.kernel.org>; Mon, 06 May 2019 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFiAb1vsIOdXPqDxPleEnq0KfXfWff123bUIOOCpK1E=;
        b=I8g6iDVqFFdGd1DZZs5cZFU1hlCQ9SDjJk/2ujryEfuQDyvHMVNcXChjCGxOWzUuaW
         j5AhiLVW3WwQOUEzf1BP6E4aTjpqvZBKXIKeS/K8oYo0Y886f0NQ1Zb429026RS3OAwR
         jy3gEfwjlq0+5y3JDTHHZ7caZYVwXgaxUMtpOtFhv2YE3I5ww90XZVW95/XVnwXAdZRH
         CLLuHM/3pSs+qhpmXqiNzqyQuu9qsC+RvsWoZ4CQl3Bxbd/Wo8/+J69yDsO1I+VMHP9o
         jPub3aBC/euZ1ADfkuU9Kn7si1zIikvysLjlMjch6vnNmNAYA5mLKtmwdRPSCofj0Fm7
         9YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFiAb1vsIOdXPqDxPleEnq0KfXfWff123bUIOOCpK1E=;
        b=Dm58eTILB8HJ3yayZgQo4Ud8l0ORxEjbF24YEaJG8zQkeRIlHzFEotR9+iqT2NfYg/
         dFQnQe9+t5xCVkH5MAIrOca9W4j6vIhZbO5Jnt4CUdDIN7PQvqtqDwUc89ucqPyXwNkC
         Y2Q8itSOOD4wKslH3n4jS745+UedK3xGK/z/fTpfWjJqmLFVxiCpelctBQVRubJmIPMl
         NZybxqCcUrpxHWqTSa/7vroQmlWffjJB9/lLdkPrDMFNYCgy3FE8m9CG/urDw322fqAs
         yJgRq9SDodxu8DkZKVEcjHZhURB0p4dl+l80gmsN2hSae2ly1FYQNbPN3Dtgp9s0GRIb
         Ln/w==
X-Gm-Message-State: APjAAAVpsCxWTFoEvfWLipilph/bM3dTcBFz6slvUjlU0f/ginfqqspU
        df5ODHMeNMlLOhlxdVJkDQYrxsC1UD8=
X-Google-Smtp-Source: APXvYqy9ypKERtqIf+9T8B0CxTEuyLN4xCkhAInaYlH+00+lfm2vCvc498ZT3wZZ2rWMoRvJwOufYw==
X-Received: by 2002:a05:6000:11cf:: with SMTP id i15mr9184496wrx.94.1557185000197;
        Mon, 06 May 2019 16:23:20 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c131sm9094436wma.31.2019.05.06.16.23.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 16:23:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] perf-lib.sh: make "./run <revisions>" use the correct gits
Date:   Tue,  7 May 2019 01:23:08 +0200
Message-Id: <20190506232309.28538-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506202451.GA19850@sigill.intra.peff.net>
References: <20190506202451.GA19850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a really bad regression in 0baf78e7bc ("perf-lib.sh: rely on
test-lib.sh for --tee handling", 2019-03-15). Since that change all
runs of different <revisions> of git have used the git found in the
user's $PATH, e.g. /usr/bin/git instead of the <revision> we just
built and wanted to performance test.

The problem starts with GIT_TEST_INSTALLED not working like our
non-perf tests with the "run" script. I.e. you can't run performance
tests against a given installed git. Instead we expect to use it
ourselves to point GIT_TEST_INSTALLED to the <revision> we just built.

However, we had been relying on '$(cd "$GIT_TEST_INSTALLED" && pwd)'
to resolve that relative $GIT_TEST_INSTALLED to an absolute
path *before* test-lib.sh was loaded, in cases where it was
e.g. "build/<rev>/bin-wrappers" and we wanted "<abs_path>build/...".

This change post-dates another proposed solution by a few days[1], I
didn't notice that version when I initially wrote this. I'm doing the
most minimal thing to solve the regression here, a follow-up change
will move this result prefix selection logic entirely into the "run"
script.

This makes e.g. these cases all work:

    ./run . $PWD/../../ origin/master origin/next HEAD -- <tests>

As well as just a plain one-off:

    ./run <tests>

And, since we're passing down the new GIT_PERF_DIR_MYDIR_REL we make
sure the bug relating to aggregate.perl not finding our files as
described in 0baf78e7bc doesn't happen again.

What *doesn't* work is setting GIT_TEST_INSTALLED to a relative path,
this will subtly fail in test-lib.sh. This has always been the case
even before 0baf78e7bc, and as documented in t/README the
GIT_TEST_INSTALLED variable should be set to an absolute path (needs
to be set "to the bindir", which is always absolute). Perhaps that
should be dealt with in the future, but I'm leaving that alone for
now.

1. https://public-inbox.org/git/20190502222409.GA15631@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/perf-lib.sh | 4 ++++
 t/perf/run         | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 169f92eae3..b15ee1d262 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -32,6 +32,10 @@ TEST_NO_MALLOC_CHECK=t
 if test -z "$GIT_TEST_INSTALLED"; then
 	perf_results_prefix=
 else
+	if test -n "$GIT_PERF_DIR_MYDIR_REL"
+	then
+		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
+	fi
 	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
 	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
 fi
diff --git a/t/perf/run b/t/perf/run
index 9aaa733c77..0a7c8744ab 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -91,10 +91,14 @@ run_dirs_helper () {
 	if test "$mydir" = .; then
 		unset GIT_TEST_INSTALLED
 	else
-		GIT_TEST_INSTALLED="$mydir/bin-wrappers"
+		GIT_PERF_DIR_MYDIR_REL=$mydir
+		GIT_PERF_DIR_MYDIR_ABS=$(cd $mydir && pwd)
+		export GIT_PERF_DIR_MYDIR_REL GIT_PERF_DIR_MYDIR_ABS
+
+		GIT_TEST_INSTALLED="$GIT_PERF_DIR_MYDIR_ABS/bin-wrappers"
 		# Older versions of git lacked bin-wrappers; fallback to the
 		# files in the root.
-		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$mydir
+		test -d "$GIT_TEST_INSTALLED" || GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_ABS
 		export GIT_TEST_INSTALLED
 	fi
 	run_one_dir "$@"
-- 
2.21.0.593.g511ec345e18

