Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501891F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 18:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKSSu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 13:50:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35926 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfKSSu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 13:50:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id c22so5040733wmd.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDXSZfhs8Cx8BscAEkznv4QOOjpkWYht8Ki3c66CCcI=;
        b=PQG3D7PzSGVlwxD81oXon1Bt4uDAMYYvc4ImRBdkiWibEtI5XXRqv8GTU29mjSm3IF
         Aa03M/wp1VtYQ8pkTUNJfc+W2RP7kiL/ZA5UdekJdoHLhv302FFyJ1KFYBB55W6m73Oq
         DkVpkeyYS2sdTt0XrubGfLaO8WhL94se2pFZ8Klw+yvwDzvEHN5lub4DzPcVTZuxfuKE
         OxfMSupEfelGXCltWPhWt21YXpPd4ylqittbfqWkMWGRTJKDRwBCDjb60iSVuSKdbEtQ
         L/m+nhheu+RrybUl/wEstLthHlyoGy3lPCn3UbQkX1d/CwU4akRjoJQ8o/TiIHyZvBTx
         kQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDXSZfhs8Cx8BscAEkznv4QOOjpkWYht8Ki3c66CCcI=;
        b=IgSilLjV/phH2k9Uqz5JP+QO02G7AwYbdifqrGf4I82Y4DpkA9OK2cioIoCYNr6rFO
         XHD6jK6Bzw5KtjgHE5C0/KNuqFHkagb6ToZ5ks/12bTZd53q597g4xFHh6LQeUIXCjSO
         UmF6rxXBeq+YBnCwztOLU98YfV60TRvYNMnVaEz4fzHv7BYemsil4LJTPwxuzz++CUfx
         FKa+3U9EdPajzcGIU5kOdacpI9k+Nd7Kf/4yN4PAE82UvYgxTArxk5JsLRvS5cMa5Xc5
         ElwD96LS5tOKU3CiNoksQLsc4jdQQPTlwmx0l1N/GrX+GDjYCbH3gc2n2nUscc25YxaL
         CmaA==
X-Gm-Message-State: APjAAAUDtXOLKjs1m6bK4MitsCJBCg44Fr7rcxIrJRN9tXKGabkUGUs4
        xdG54JYO1NcR0DJIgu6WUJo4BJWs
X-Google-Smtp-Source: APXvYqwfR6MNc093XXzHhEGLt4ytPZCoatAUWcfvOoYhYhsiXF1wyHQiWJG92av7rBBSvisz0Kg2NA==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr7242931wme.107.1574189454031;
        Tue, 19 Nov 2019 10:50:54 -0800 (PST)
Received: from localhost ([46.69.175.162])
        by smtp.gmail.com with ESMTPSA id y8sm3862179wmi.9.2019.11.19.10.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 10:50:53 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] perf-lib: remove old result files before running tests
Date:   Tue, 19 Nov 2019 18:50:47 +0000
Message-Id: <20191119185047.8550-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.24.0.155.gd9f6f3b619
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The perf tests write files recording the results of tests.  These
results are later aggregated by 'aggregate.perl'.  If the tests are
run multiple times, those results are overwritten by the new results.
This works just fine as long as there are only perf tests measuring
the times, whose results are stored in "$base".times files.

However 22bec79d1a ("t/perf: add infrastructure for measuring sizes",
2018-08-17) introduced a new type of test for measuring the size of
something.  The results of this are written to "$base".size files.

"$base" is essentially made up of the basename of the script plus the
test number.  So if test numbers shift because a new test was
introduced earlier in the script we might end up with both a ".times"
and a ".size" file for the same test.  In the aggregation script the
".times" file is preferred over the ".size" file, so some size tests
might end with performance numbers from a previous run of the test.

This is mainly relevant when writing perf tests that check both
performance and sizes, and can get quite confusing during
developement.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

This came out of something different that I'm working on, but makes
most sense as a standalone patch, rather than part of that series, so
I'm sending this out separately.

 t/perf/perf-lib.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b58a43ea43..7e80251889 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -178,10 +178,11 @@ test_wrapper_ () {
 	export test_prereq
 	if ! test_skip "$@"
 	then
-		base=$(basename "$0" .sh)
-		echo "$test_count" >>"$perf_results_dir"/$base.subtests
-		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
 		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"
+		rm -f "$base".*
+		no_prefix_base="$perf_results_dir"/$(basename "$0" .sh)
+		echo "$test_count" >>$no_prefix_base.subtests
+		echo "$1" >$no_prefix_base.$test_count.descr
 		"$test_wrapper_func_" "$@"
 	fi
 
-- 
2.24.0.155.gd9f6f3b619

