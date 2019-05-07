Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3D11F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEGKy6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:54:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52263 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEGKyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:54:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so8723218wmf.2
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvyQTTC8CWlumTtWCngNYht1Bolr2xWXbfYPdiyTTc0=;
        b=Vd7n8YTI6n9ROJA32fmR/w9i8pM1lkyng959JuiRHuJ4KO23Z/RSILQclNF0Z2Be3y
         0h8iK+Tg5ZHGSLavqijEbTS45IgIkDVrQRDti0J7xhqEsZuLDf4RCt9DuSsjZV99EQp+
         u4zOLcQYSr4jZohzrdaLJx/w5emus4T0udTn/K/ZbTwj5WHvk3IqbN3wRm8E4X5ElkBp
         x9fKdaEvQBrMMcMCkE4sCtgXBCBrUsdH1Dc14mdvlqiEUr76gjZd8OFVLXwa4aE0VEVC
         TdPhBPTUH3JM954JLZ84Ics1mFEVXLyPOO2RqILOeVO8npBIAhZ8VYNvK2EuXTvrVJSl
         3DmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvyQTTC8CWlumTtWCngNYht1Bolr2xWXbfYPdiyTTc0=;
        b=nj52CARmwtzIpya0cnGTZKbPC5L6bDYhDHDzg+oj4knP1um072PM1bM/LzS0BLw9ke
         mdyg1d3VWyIl9BoJPLLeQybJAvAenah3aOzmYGeSxrFlPhR4U/9IEDFt4TtArIUsHnXt
         zeUOyVUGhBlswZa5mMbf4F/xl50DEkzSItSg2IEZcfSBDX7+eQcVSSSbhuVFaQbH98M2
         HNqrjtZP6vcf3a400Iejv5Ce1+SyAZlkMfqg5YHgmv3GzZ2rBL3VA+u0RB59FQYJfFfB
         Y0sHmnABy91jOZz7FWiFSy0zlN20UXfz5+wsKeaMmcimrDkU1IAPEV1/APhvtNZG1UQG
         HQsA==
X-Gm-Message-State: APjAAAXfvnvPWzfL6mxg1Xu2y22oaPgImVyFtPcn3THP0CdbuAHC2KTw
        EYVDbOSleSURk3EokH7o4kzoz/dQcUI=
X-Google-Smtp-Source: APXvYqz+LXsW1ZYVd6vNwG7cDb+PUH0kmF4FkiaSgYWdJdkd7QM42V8hjnk2cR/j9KXE8P+JabZF1w==
X-Received: by 2002:a1c:3982:: with SMTP id g124mr20469575wma.25.1557226493697;
        Tue, 07 May 2019 03:54:53 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm11029573wmb.12.2019.05.07.03.54.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 03:54:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] perf-lib.sh: forbid the use of GIT_TEST_INSTALLED
Date:   Tue,  7 May 2019 12:54:34 +0200
Message-Id: <20190507105434.9600-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506232309.28538-1-avarab@gmail.com>
References: <20190506232309.28538-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in preceding commits setting GIT_TEST_INSTALLED has never
been supported or documented, and as noted in an earlier t/perf/README
change to the extent that it's been documented nobody's notices that
the example hasn't worked since 3c8f12c96c ("test-lib: reorder and
include GIT-BUILD-OPTIONS a lot earlier", 2012-06-24).

We could directly support GIT_TEST_INSTALLED for invocations without
the "run" script, such as:

    GIT_TEST_INSTALLED=../../ ./p0000-perf-lib-sanity.sh
    GIT_TEST_INSTALLED=/home/avar/g/git ./p0000-perf-lib-sanity.sh

But while not having this "error" will "work", it won't write the the
resulting "test-results/*" files to the right place, and thus a
subsequent call to aggregate.perl won't work as expected.

Let's just tell the user that they need to use the "run" script,
which'll correctly deal with this and set the right
PERF_RESULTS_PREFIX.

If someone's in desperate need of bypassing "run" for whatever reason
they can trivially do so by setting "PERF_SET_GIT_TEST_INSTALLED", but
not we won't have people who expect GIT_TEST_INSTALLED to just work
wondering why their aggregation doesn't work, even though they're
running the right "git".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/perf-lib.sh | 11 +++++++++++
 t/perf/run         |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 9cdccba222..b58a43ea43 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -27,6 +27,17 @@ TEST_NO_MALLOC_CHECK=t
 
 . ../test-lib.sh
 
+if test -n "$GIT_TEST_INSTALLED" -a -z "$PERF_SET_GIT_TEST_INSTALLED"
+then
+	error "Do not use GIT_TEST_INSTALLED with the perf tests.
+
+Instead use:
+
+    ./run <path-to-git> -- <tests>
+
+See t/perf/README for details."
+fi
+
 # Variables from test-lib that are normally internal to the tests; we
 # need to export them for test_perf subshells
 export TEST_DIRECTORY TRASH_DIRECTORY GIT_BUILD_DIR GIT_TEST_CMP
diff --git a/t/perf/run b/t/perf/run
index cd3882b117..c7b86104e1 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -84,6 +84,8 @@ set_git_test_installed () {
 		GIT_TEST_INSTALLED=$mydir_abs
 	fi
 	export GIT_TEST_INSTALLED
+	PERF_SET_GIT_TEST_INSTALLED=true
+	export PERF_SET_GIT_TEST_INSTALLED
 }
 
 run_dirs_helper () {
-- 
2.21.0.593.g511ec345e18

