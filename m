Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD04202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbdCIWYD (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:24:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:50522 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752620AbdCIWYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:24:01 -0500
Received: from virtualbox ([37.201.193.18]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M92ZJ-1cxxtl2tDx-00CP1L; Thu, 09
 Mar 2017 23:23:52 +0100
Date:   Thu, 9 Mar 2017 23:23:50 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v5 01/11] t7006: replace dubious test
In-Reply-To: <cover.1489098170.git.johannes.schindelin@gmx.de>
Message-ID: <9a8c14d065cc0dd63ef71c18b6047a9a9023dac3.1489098170.git.johannes.schindelin@gmx.de>
References: <cover.1488897111.git.johannes.schindelin@gmx.de> <cover.1489098170.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iY/j0fCcd1Hhw0erR6YdlpmwD8rqVPMIN0wQd4Z8tc74fR+KFj/
 oV8nxVNFKmjdncBQLVKgkbxL/Vg0A9r5x6d0zKy+RP8Z8eD6dP3QssJZGywzCCoUSl/bJF7
 nSIlaIGu4lQmqYjY6wvsTg57AEfR5qFyNBTi32q/Msttfxr5mD3J9WuZWLgQcLWGFClB9SW
 uPDvtF+Phry3uPJPGEDag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ptPZc8Fno14=:K/d6rLk2zPWWg5WjPzqmtZ
 acJM48TQProD29am1TFqNtrrSK3sQ6eccgGmGkh0hhGym2OGKCCeTzNuHPS4wN3qSUsStKc0O
 DDHbOTbtt/2K+HycJFJV88OcQHGo1ER5xLeMx2FIK2jNfrL5uLHHl5NV3aI7nXYJqUwZOqs+z
 qxQcto2pqRKlH2mxuhxTnvZanN8kMgIHQe+JBzhB8eED4Weg/lMiUZ6Xl5XzbXxjJ24LoNC96
 JyII9N3n/H/8OUMTeqKpERI3/TCK25bM3rTAxVvuWOUEqwPt8JUyEkSmMtjPzPSXGc9gIj1ui
 o33F+G6KtfjLxXL11kCPWCkkLzSniLVx4GV2LdQ5dpq5oPJSkjpmqHjvtX6aJ4gXJdYEHzFXI
 BJVRHIx8zW/Hofq/axo2KoJCfYt+gNimRPLWb4sIwpUrJ6xuDvAgZugf7aDTEn+XkjkJSwfbI
 cHUv+wKo0t7uxf/NIrVeHsHOrRiZI55ypfwF8UDE6nW4O75zAp21fQvq9clBtfaT32AjFATNr
 6nXQg/TySwqU6h7LYbxEkEBqzjPz9rGIYqwWg/MItz447uJxmRZQwxjE2Cb048eSmliJevX+l
 OlLXjUOe0TddW1dDhbNHoENggLxgNlzPR3jtL/WfvovipLT5wyunCuPEvc2nuZJCH7vR59of/
 yXCatjuSl/mB97yOx/0sxczCC1gOOhosD0MDepL0LX3mRJx+o+Nv6A3JH8js7NtqeUWlTGS6V
 HEoEjzilSGGwnH3A3jgHuLztAOGjzyUG3SBV9JC8KZ59zdOSYTFU6Y96Z4jUTzDPGnmh6W6Ma
 ZiaocJY
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
index c8dc665f2fd..304ae06c600 100755
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
+		test_path_is_file cwd-retained
+	)
+'
+
 test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsense'
 
 test_pager_choices                       'git shortlog'
-- 
2.12.0.windows.1.7.g94dafc3b124


