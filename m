Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC31F20279
	for <e@80x24.org>; Fri,  3 Mar 2017 17:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbdCCRcm (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:32:42 -0500
Received: from mout.gmx.net ([212.227.17.21]:59475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdCCRch (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:32:37 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmfKJ-1cAnUg0wJ1-00aAQH; Fri, 03
 Mar 2017 18:32:17 +0100
Date:   Fri, 3 Mar 2017 18:32:01 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 1/9] t7006: replace dubious test
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <96c2b0be087ee212cbe0aa18cefd2965c09e48fd.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7+Q99FpJ2S7fbTLuMdFzCV+75YBj/yQ5oMIzgvDnX0GLBxDDWSH
 Izp4R9RC7f8rDELzb/1NeXUL3o04MNbd+iVSuteeexVfh47HUqhIyMz0jCjgvUwIFD+nsZ+
 S+7/kmOK1d9IIgypDFiO3VJpt2Pm42KmY0uo9lm1MG1a1S4XsUovG74yiWOuQLWyTuLmt5C
 a/nG+JrJLKmEzSyMm7XTw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mb+WAlSyBJU=:Dd5IPbzsQMBeLEoCeG2TpS
 wETWoybNxgICVzj1Txh+7xnK8JqXf602qK9M+32c2mpfWZwnsD84bEk8GqxldrFsH60x+HhJW
 KTmwodqZqYWe3lCUKutk1EvpuFhpKAzEtpa3IiHnn1yPSZ2b13ni/n7rUBH4Q0EJMdRF7N8Qt
 SRW8Wqg8jreffOyN9oTdQCibrgQ+uTfOnnfsD6p6fLkmi7TODUCHkFqhXG+Xz68o5q2Hu6rIL
 BiYsuK+9aJ58EBsZzEUlukRacKsksx/4Z80kuEB/inOIAqqX8+U6WngQtNpbSfINYSEH4Sohv
 zRq8s5yZBaNSBeiEYJvgysPGlPT9k8xXjWRmuueqWxyrCkpRqibig7PkxIrY7JIDpyz/QQfzt
 sN7Pu2Hv98EOIjmIZd4F2lrUoQ3LPbeucwSTUzj/8mOcmlTZO7ls3dAQWPxVeE0lUG5obOL7i
 VAdyRqjGmbZ+8eI3qxsAn/jgldG+phX28a90lz2m+Vy7FD1+yPUPS1O9jS3LE8CtQFP3t9pGr
 V8tJ8CFyi6mYrVbL9Ax1wTXh8GRGbTdlMsECp4ODCbAuEjAeRWQQTdhwpp4jy8JJwg5WeaK09
 uSxKLoQst6wB1vhxfm8nr5wl5DGulWTAGDb9Zw5fpvC9U8RdIhz7tUwIffJK0CBhc4AsTSKLX
 d1doy3tBCpi03khUH230HGH+NJ18p+/TUSi4FxCC3qzAU7BewgQlsgaUEOeVcG+HtNc7Rh37M
 VwydnxoCewdVan/ZMNXANcjSVnLa1y1EuW3jvPlnWRsMx0l86nJRtSER8xWabDdg3LfMGHSXe
 OD5ZKms
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


