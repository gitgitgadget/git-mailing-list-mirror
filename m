Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99928202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 14:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755633AbdCGOdL (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:33:11 -0500
Received: from mout.gmx.net ([212.227.15.18]:58629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755611AbdCGOdE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:33:04 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYP57-1cpuxu0B9N-00V95D; Tue, 07
 Mar 2017 15:32:27 +0100
Date:   Tue, 7 Mar 2017 15:32:26 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 01/10] t7006: replace dubious test
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <96c2b0be087ee212cbe0aa18cefd2965c09e48fd.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:31DhMwvFP50mEIoGfZxLi7V+RpGwpLvdz7Mz+Cc6O1zCo52YiF9
 ZMaPiOJ3flQMtQjG45qURz++dTs5/N3C7hAoVBaf2tNQ1elGEbuwQRDMjW2RpL0e2RPOGFR
 2FGVeodM4sCFOf5z9jhb0wAwXc/FXPBmTbY4+DwJJLfBQR5qUgQW3t+GJviFKLXt4LXUJY/
 2Fp9h4Qj5FosVKLrmyhEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2UA/rhWiKrQ=:mxOg49+JewG3a5+GYRNDHt
 A6PYOsiCuwkQU3McCvrp/6KuRLfs1v6S1bJnSeQZxAhXCBgfSW4eFYtuqwjs1OqLu+ikGDiMG
 gPBG7IpxzenOvOFSfxim8yt0ICkjwF/8zrPKtml7pujiVWKLfvuCyyFIn6Ou3G1BP4+k6WvER
 1V7v1/AsLzUVfTv6vrfd7h2PY9zIJa+MI+cpIE3obaSKugbPKFTAYVaiF6iyit37AinLSAj4Q
 szh33rp9NL05YNtI19bAeHKpC3N3g0Twxmjt/ZuwQkOePuJGZh6raBW7N32+VFG374CdWr0Gd
 paCBohFNx0WQPMUYIcLHe7hMJfCUV7fsY6qKeSMSaFp/UKhT8aTTf/7yQ6W60t5o+rjA+tMhv
 Yd4KLVMfjcw5H2qj4y1SO6FMNNx/6zD8AhjR5nzmmlFnEJhBVsRQ2VL/bYU1FwmfFQs6hR56U
 XrxI8QbaAsygFa0m/5HXurzj2zTD9qf2m/GDYffZiovCXl4QtxTDrPNDKlFMs7p5aqyO77oX5
 fJswniZ7sm/eXzFtTTmC27mxO3AjcEX2YYKmYCpiOAYcBhyMYQCcP6enbWqYTpE5ZUOKiq5at
 WKcWVwhJhW4F1VB3KPoEMwvE+uSMP/UD7LM/A7/awMdm8LyHa6XQ01nhsyOyTa0l04ZzX70KA
 OXdjDu9rXU8tD4LNIPHFA94rroFBF8IWgd9gaJvMQMixj4CyDnV3FSayoVzh+m+cAJQ+aY16G
 JkrwtX9AwilvI/8dhszOfNoozyMQM0ucdKLN7MMn3lXnKZ0R7bWjSWIJPBFuKX2v5P9kaILUb
 T2AnTWn
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


