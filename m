Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A07D2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdCCCET (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:04:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:49665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdCCCER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:04:17 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLvGW-1ce7rM2YuK-007nW2; Fri, 03
 Mar 2017 03:04:04 +0100
Date:   Fri, 3 Mar 2017 03:04:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 1/9] t7006: replace dubious test
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <8f79df34e63a37c052437dd022269b4a6c495108.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l3hZYu7ZKD6U0akTeeS322vVVLMDSu27MwZA8c0AUuFb2Lt148A
 CUl9xuarL/BauHEJlAYdYzJ3dqLQoDcvaKwqs+PiqIYyp7KBJdv3UaFHFA7GsjEnL18Cz0m
 b3A2dpnsv3qnV89iBPjU3X8AaKObvhV0qCj8FMy8uxomnFRSUR1KZEpMf2o4oLxIbu0744C
 yRp5fWbkYsP8rbZdFb0fA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EJ/BKNUBgP4=:Op1BzNpxWmJozL84GfQ2qN
 JnZ8YYRYxgMky255PYEzlOd4kKT3tKf0InZqiTZamIL8cem5NBKIs/iAnL9Bq8b5PShviPJtk
 sMz71fiW8h/a9yZXUFSToknmf4Nb884UwagEW9GPdWVzZIPy3ksAxWc92174hRH8YxHGg31+q
 4RdnETj5MR/WSZVR1nHWAq7HvPoaPjexX+SLVPywRcNGHDScFl4xsxjBLRrowtg1DZWYnJ1t1
 jlr+UaW9yu98+BqoZWAozQEQxUuuvn6pLoXzTXEnP8RczBzKuZueGlWcqV2pcuXgbY8DsY2F+
 SUek8dQQGPSBlusykbTJkrM0kNpdVb4Sdxvjh4O1oMf4wgP0f0sljFAUJccaCZlefV0iervHG
 5OE+R3dsrmW6DvVPBv3pC/5p+JqALFK+7Kxntq30Etz+Qaia89MDnY2Z/ztzoqPsG1x228aJ0
 NqvTdAWLC9OsAH4wVY1WLyVoaKKjfsyPDy8BXS6AKsmFfLSaifll/nzFqx/P/4MCKFHv9NFOu
 y8tSzKWSVaH9+gp3gzmdn7dKKzF6vOdxcMj5keCWdwdZDcz9cxbxW1SV2VdBU1c2yHOl5OvmF
 mRbg5iZKgfDf/lMLFYHYTeL1BJDAuCtkcR9bOCyX7QmBPvBhxpbYR95ORpuUE4XbZYlkqcVcd
 DsK4vHtYkzahIXuHfQU102ERRpiPLEMFF6hLRcw5eRVjOw8EHGYJOO80HXoKoyPJbPo8s2fLe
 M2qo3SYnKqSVZSXqfhFz/hyEKqPRselP8Duzq0A7cnEevt/pmzZiSUCjdwVpAZIG+jpBjCWiV
 zLCK6+B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The idea of the test case "git -p - core.pager is not used from
subdirectory" was to verify that the setup_git_directory() function had
not been called just to obtain the core.pager setting.

However, we are about to fix the early config machinery so that it
*does* work, without messing up the global state.

Once that is done, the core.pager setting *will* be used, even when
running from a subdirectory, and that is a Good Thing.

The intention of that test case, however, was to verify that the
setup_git_directory() function has not run, because it changes global
state such as the current working directory.

To keep that spirit, but fix the incorrect assumption, this patch
replaces that test case by a new one that verifies that the pager is
run in the subdirectory, i.e. that the current working directory has
not been changed at the time the pager is configured and launched, even
if the `rev-parse` command requires a .git/ directory and *will* change
the working directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7006-pager.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index c8dc665f2fd..427bfc605ad 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -378,9 +378,19 @@ test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p request-pull'
 test_default_pager        expect_success test_must_fail 'git -p'
 test_PAGER_overrides      expect_success test_must_fail 'git -p'
 test_local_config_ignored expect_failure test_must_fail 'git -p'
-test_no_local_config_subdir expect_success test_must_fail 'git -p'
 test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
 
+test_expect_failure TTY 'core.pager in repo config works and retains cwd' '
+	sane_unset GIT_PAGER &&
+	test_config core.pager "cat >cwd-retained" &&
+	(
+		cd sub &&
+		rm -f cwd-retained &&
+		test_terminal git -p rev-parse HEAD &&
+		test -e cwd-retained
+	)
+'
+
 test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsense'
 
 test_pager_choices                       'git shortlog'
-- 
2.12.0.windows.1.3.g8a117c48243


