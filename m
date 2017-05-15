Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EC4201A7
	for <e@80x24.org>; Mon, 15 May 2017 15:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966016AbdEOPYK (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 11:24:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:60999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965870AbdEOPYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 11:24:08 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b03-1dIIL42j6N-00CyVa; Mon, 15
 May 2017 17:23:57 +0200
Date:   Mon, 15 May 2017 17:23:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] gitattributes: demonstrate that Git tries to read a
 bogus file
In-Reply-To: <cover.1494861793.git.johannes.schindelin@gmx.de>
Message-ID: <8d5e663dc74241176219a51e75624549668373f1.1494861793.git.johannes.schindelin@gmx.de>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jEzXOFsSFOpamLx3Hv5n3Gs4nUHK+jC7PlFgiXp5AiOl13En2p8
 O9NVZY8xLPYwkY4RU8ndKz24wBfFN2KIAFdp5Gbzbj58rO05TP5Y+LrSKpIRIsAwTIlIJu5
 MAdCrVApSWY+gkV1v0YHT9N/NJFPb2xW6VY1110uGm3PuIA8IpBupdMpmkxH8cTDvFtFxtU
 bMubGFEHHiuuTOebR7CUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DQxR8G4vxEo=:fmiA2Y0270VC6fnOfNVzME
 YutLfGrrCHnwD30/UNssHG7tJ4gCkM7auwppfNdzKMT366ORiEy+6EpjI1qrnWDgDrk9mwzY8
 36oCF1BN1YNHs1vTI6WWZDfwuGqIJRgiwzABVafd0okQwSnBYrvKyYL3nXJkPyKm2tkf0D70/
 56BKTGI5wY7txm3KJHmFwny/G/w1Rsb9YCSv9BXRT6S8JDPZgGMAPZXX7O/tJyEUO6U3qdOPK
 sZwOTfbULbK1vjcPlYpmW3CUitiFP7FFWGSexqJqT44V7HlVZhocTSNvwhKmMbQf65KDOygYC
 TkAKacp3emJQ9m2/wju2+7qAoJ53llkg+vaTiuhX00yvGUqcKXNPjZ8ZJKZLKvOPxbmrhzv7F
 Kg9rdpUPx2DXvGzh60RzKAcExQhcB4mGrXhbs52GkJl8Bu2y6QpYa94MKE0oT1rkQK+DyB1ev
 O+n9pkxjXRq3UxcIEEWtRW+gt5q8zjjom04LCIp5fZsySeOXOV4g71PNl9XgZN+FOKUbVChO2
 YohndARvvSMAzpYAYLst27OZhILe8xdCYZCvSbyxjONxb9agqflMBgphhuSkFXM2sujk9HRY8
 X2rTM/JhOfDsfR1eFfVPLJuEF7SzT1hbMHBwGn7hD4Lua+wbBi4EjHpRN2Ca8tF56WZigCr9/
 z2DWB1QK8FSEe9b0hX24PG2gKkiHmGQZAztG2yLQRWyTPUtHzuF1pzYKeG2aUMfBld+HuioA5
 oYez+e71WTfY5ZuqvHYkukhOS8UV9h+tdb48mMRriMiFuqHl70Aq9MbPUu8Of9dSlfUAfBNR6
 IUiMkLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This problem has been reported originally in August 2015, as

	https://github.com/git-for-windows/git/issues/255

The symptom: when passing <commit>:<directory>/<file> style arguments to
`git diff`, Git tries to read the attributes from a file called
<commit>:<directory>/.gitattributes.

This symptom is more prominent on Windows because the colon in the file
name is illegal, and therefore reported to the user. On Linux, the colon
is legal, and it just so happens that that file typically does not
exist, and therefore there are no adverse consequences.

However, it is still a bug: Git should not even attempt to open that
file. Let's add a test case to demonstrate that problem, even on Linux
and MacOSX.

The underlying problem will be really tricky to fix: the run_diff*()
family of functions expects the path passed via the diff_filespec
structs to be the path as if it were in the worktree. However, when
processing the `git diff <blob1> <blob2>` invocation, Git uses
setup_revisions()'s parsing of the pending objects to fill in this
information, and setup_revisions() simply copies the command-line
argument, rather than reconstructing the actual *file* path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0003-attributes.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f19ae4f8ccd..a7820022d8d 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -323,4 +323,25 @@ test_expect_success 'bare repository: test info/attributes' '
 	)
 '
 
+test_expect_failure 'a file <commit>:.gitattributes is ignored' '
+	git init bogus-file &&
+	(
+		cd bogus-file &&
+		mkdir sub &&
+		test_commit sub/file &&
+		test_commit sub/file2 &&
+		commit=$(git rev-parse HEAD) &&
+		if test_have_prereq !MINGW
+		then
+			# Windows does not support colons in filenames
+			mkdir $commit:sub &&
+			echo "* -inva/id" >$commit:sub/.gitattributes
+		fi &&
+		git diff $commit:sub/file.t..$commit:sub/file2.t >out 2>err &&
+		! grep "is not a valid attribute name" err &&
+		# On Windows, there will be a warning because of the colon
+		! grep "warning: unable to access .$commit:sub" err
+	)
+'
+
 test_done
-- 
2.13.0.windows.1


