Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC961FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 13:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761830AbdJQNKT (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 09:10:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:58602 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758101AbdJQNKR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 09:10:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3ARX-1dCUAV1CND-00srZR; Tue, 17
 Oct 2017 15:10:12 +0200
Date:   Tue, 17 Oct 2017 15:10:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] status: do not get confused by submodules in excluded
 directories
Message-ID: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:axt52Kj82brfV8C0DSXtlNNlq/uFtgcwJJu8GILpM6uiLyvHhJz
 bdZmQQdYZHWjH1G0kR5qw/nx645FmVDYTtTLIG85+k/edcuwmTwBwwJ7vQzLh2mGnImh82y
 JbOL+AcSQ/St/TjAzCenhGqEIPASOcoHODLcKppJ3K9oAObAPuRp5IW3glAKY1BO7/uoUSm
 F99qcARYd0goqWNuAdKPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mvmnoW5RHjg=:xJTjMh0rWid7CEqQBceyMO
 7urRncBDVIjpS1gkZSX/JoIwDOcHgqNvitQLdG25IWLLcCJVzNHFgS/fRVjijJ42tUWkBSFw0
 AfdB3jwHB1cKaxI/rjirQ8uknXjgHrF+z0Usw0EpO6/V6iEmNrxEF3GIWNSkSLKZg/VOHxDOq
 gj3EWWVjCXV1Y9kdjeEo2IzQM+OXchHLVata1nx2FWDA4y2ODXTv2Xk7qc59PRm4rJ7hUebT7
 TLd21Xyj1ziQDcFaro2XQd2qcEOKG5XWLfW8wpWMvyiLTdcnBr1MGlwtMosaHgZXgcSeBQcwa
 YOzFvgkss8kxbHXFs58Gj6TEXSUpeR/vLDhYcQpfIRrcqFE63kU2os88N9YbiOgsEdN2nMCSC
 YMXcXhnKvFLmVtpdfdpE0/g4+Jlm2msKv+VHLy6+bWwNhE2SIRMMIDJyZ08kpuelODezKW8Em
 KP3PgXbyglRIRKBBYKM+jEZeGrutI3S+3ro92YY+VOElo6CVGg5PJzNk9oqZjXA+x30gWcxJG
 BiPwpHJro8DNeDRb+vrEl2EaBB7m4n967t4Ly8roF2b0GVT9XrEqGAA4XzOi9vYZmvFKXeGBs
 G5TOMxbs1gavrxCWg6KD6w5cGeN3xD2guPNqa6E/JG/YroP+sbc2k+uTEZhTFf++vpSFLTece
 KFe+0qOIQxa4XdwcS/MTCWPOezKZojoLWDzeFV6Db7obToqIHw47n0X9Ao3NaUzndYjtcggVV
 +svC33eu/mJKRXCbvSVtpXRlGfuEv95n8uBaFnuCDycadjLYLqSUzWuHx1aFyGkYXPCF+VqKZ
 7+guE7vEb+gdPvfLPnaRSmhxWk8Gac5vdEgcuBmWZVLy9uJ9Bg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We meticulously pass the `exclude` flag to the `treat_directory()`
function so that we can indicate that files in it are excluded rather
than untracked when recursing.

But we did not yet treat submodules the same way.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/submodule-in-excluded-v1
Fetch-It-Via: git fetch https://github.com/dscho/git submodule-in-excluded-v1
 dir.c                      |  2 +-
 t/t7061-wtstatus-ignore.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 1d17b800cf3..9987011da57 100644
--- a/dir.c
+++ b/dir.c
@@ -1392,7 +1392,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
-				return path_untracked;
+				return exclude ? path_excluded : path_untracked;
 		}
 		return path_recurse;
 	}
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index fc6013ba3c8..8c849a4cd2f 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -272,4 +272,18 @@ test_expect_success 'status ignored tracked directory with uncommitted file in t
 	test_cmp expected actual
 '
 
+cat >expected <<\EOF
+!! tracked/submodule/
+EOF
+
+test_expect_success 'status ignores submodule in excluded directory' '
+	git init tracked/submodule &&
+	(
+		cd tracked/submodule &&
+		test_commit initial
+	) &&
+	git status --porcelain --ignored -u tracked/submodule >actual &&
+	test_cmp expected actual
+'
+
 test_done

base-commit: 111ef79afe185f8731920569450f6a65320f5d5f
-- 
2.14.2.windows.3
