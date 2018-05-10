Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB721F406
	for <e@80x24.org>; Thu, 10 May 2018 14:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757386AbeEJOCG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:02:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35161 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeEJOCF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:02:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id o78-v6so4630333wmg.0
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShJd+5kW/ZZbMSooQTmBMIe/hfWRmfmIf87VdPJlnpg=;
        b=EXk7qN/XVcrAYoDOnL0nW2jLrAnGb36BctkP11hnvfL0VVGRdWWBQbJ3yiqp4fEoDN
         o7y8+/DQZC2haDeYvSy5wMRir20UeAXw2l6khcHtpYYOMAvR/HxYbivtcZReqpk9ZPcc
         htr49AlLYl5VwuYvFd2QummnNJghrhQ3Z9By7724+yxK0CTkqJRv5xZ0uS7E0CRRFZo4
         bpsiSemQD+Q/jCt3w9ZtN9uT80oH4X195657fhR6j/jxqCdHNKH6OSrmxdZF04NiA8ZM
         3L/P2QjOY7WCvVpIQozfBT8OY+cWwHQ6vLMqOusocz37VDZgnt6/8qQ7V1mlnWdYnavV
         nPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShJd+5kW/ZZbMSooQTmBMIe/hfWRmfmIf87VdPJlnpg=;
        b=l0oy4wdNeEvl2rmNscrAOSAP0lIEMboOLsb5+5F0N0DX5LQbknYp3dovv5KtwC9Vd/
         hIcAjx2kvPd0exX0sZFvN8U4GRlw3psmo85dKdnQbEJJxgZRFj106caf42ItP9s3tNPA
         OeCjc2t6HGkQ+6z3wklm3LiEnvl91hIpkcAC+yDDYTQNaZ3tO6MGtk+/d+b2NBJzHEIT
         pMjAbBJEoIsXmdAlScXoekwS57g7LGcD0UoTYnKV1DH3zhFLN0FPqd4NNkYrp2C+F6yy
         3iOxlgMx9fX917vh3e5JuaVFKToYdBgPq1h2V1yx23Vw+JzcDNJWauB+w9KybiqR01Y0
         NR5g==
X-Gm-Message-State: ALKqPwfU7LReRT/N5/Ohnpc9GuJ38QbkBThwOjp+011sg/4iSOGt8hi+
        7DXCgsPUIY58Rvx+0aQl9x3pE3R2
X-Google-Smtp-Source: AB8JxZoPvVFozxjRQZ1mDyNs4UmyDsed8nZCtCQaTyUR+m3V9C4jd9PyWpxPcgPQIikuC9wuPMUWUQ==
X-Received: by 2002:a1c:6803:: with SMTP id d3-v6mr1444289wmc.70.1525960923944;
        Thu, 10 May 2018 07:02:03 -0700 (PDT)
Received: from localhost.localdomain (x590c7c95.dyn.telefonica.de. [89.12.124.149])
        by smtp.gmail.com with ESMTPSA id q194-v6sm1850296wmd.26.2018.05.10.07.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 07:02:03 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] t5516-fetch-push: fix 'push with dry-run' test
Date:   Thu, 10 May 2018 16:01:53 +0200
Message-Id: <20180510140154.30381-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.756.gcf614c5aff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a while-at-it cleanup replacing a 'cd dir && <...> && cd ..' with a
subshell, commit 28391a80a9 (receive-pack: allow deletion of corrupt
refs, 2007-11-29) also moved the assignment of the $old_commit
variable to that subshell.  This variable, however, is used outside of
that subshell as a parameter of check_push_result(), to check that a
ref still points to the commit where it is supposed to.  With the
variable remaining unset outside the subshell check_push_result()
doesn't perform that check at all.

Use 'git -C <dir> cmd...', so we don't need to change directory, and
thus don't need the subshell either when setting $old_commit.

Furthermore, change check_push_result() to require at least three
parameters (the repo, the oid, and at least one ref), so it will catch
similar issues earlier should they ever arise.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5516-fetch-push.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 82239138d5..832b79ad40 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -94,6 +94,9 @@ mk_child() {
 }
 
 check_push_result () {
+	test $# -ge 3 ||
+	error "bug in the test script: check_push_result requires at least 3 parameters"
+
 	repo_name="$1"
 	shift
 
@@ -553,10 +556,7 @@ test_expect_success 'branch.*.pushremote config order is irrelevant' '
 test_expect_success 'push with dry-run' '
 
 	mk_test testrepo heads/master &&
-	(
-		cd testrepo &&
-		old_commit=$(git show-ref -s --verify refs/heads/master)
-	) &&
+	old_commit=$(git -C testrepo show-ref -s --verify refs/heads/master) &&
 	git push --dry-run testrepo : &&
 	check_push_result testrepo $old_commit heads/master
 '
-- 
2.17.0.756.gcf614c5aff

