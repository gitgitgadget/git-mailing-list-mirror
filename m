Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1939E1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 12:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbdEIMxi (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 08:53:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:58305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753616AbdEIMxg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 08:53:36 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHH6Z-1dCh5V17jv-00E9CR; Tue, 09
 May 2017 14:53:22 +0200
Date:   Tue, 9 May 2017 14:53:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 1/6] Fix build with core.autocrlf=true
In-Reply-To: <cover.1494334366.git.johannes.schindelin@gmx.de>
Message-ID: <6bc890b10de8a59f90005462f8767d6b022b0749.1494334366.git.johannes.schindelin@gmx.de>
References: <cover.1493891336.git.johannes.schindelin@gmx.de> <cover.1494334366.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NA5x3UWBGy1BJd49DqQdlMP6yLT3kvDk8cNzFHzmfU5Gihg0f+a
 1j68wmsbDxUcQg6hK24atCNXv5eODT78OzD/v+myw2BuNlJ8ohNw6DpwL1kpzceJ8kmdg/W
 OGp6k1TW88iRa+jy29A0bkMwhWQoJxaI0GcknLZyuA9RycTlCWfyt+a615nb7PSKYCRjzJi
 E2RFBi6Qty45VHG3x/zKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3gFfLh+PVOY=:0W5O+6KgSIjrqbEec0KE33
 kB1OaKyEBYm5HouhFayaZI5b66mfHCJl1x9eDwIo/ptvp1HM3v4ZO9Nclk+oJkhs5+j2atEo1
 q1IuGmBCxBlS2Sg+6dAXo27TBeRnWJ4f97bFV4r9NJZfjnWlr7T861PwurByWuWbT3ZZ8/nz+
 pzeCjSjyM0EAXj3wpdPCIvB0NBYck8TuV/YxynkZL8Yp4XcLns0GQAU2MsTw+1pVZerDYBLEs
 pqItGpkhRx2jVh6gRLVIxoDHPWjSphIaXYUXUNZjcC5UqWwhGUiqRqVjcysULAjxay0bcyke4
 z+wpiGoAbCf3ZxEgBf0U6ccgSZPipx+zr8oL/rz1az68CJ+8izmBvURNS6YhFTLy71VwyM1XS
 F0whprlBBNLjrXA9rGfTivpNtSDJrXqs6KzXzeluA3w7wKlCpTUWLHmPZtNOlsdPwUXXmKx5i
 D/lAnFdCDXvwCbNWRVmbhcsQJkyaIOX2qcQfoUeIN3uiOw+DZXXb+VSeLnU+EWPigicL8EhWj
 9vhsiUy3XDiIUf7CvYfY9RtNfjvj/DdYTxSmJq2JxK8nKV6K85BaRNt1WPZMTxGlR1G5vDpET
 tzz7QUO2yymPiEt6vtOC/QNOegTF3/yOORmloFq+QLrxCa/LGq+4IoZgrBFHY7oNe7iZY7vOw
 ufYHJkaWKLHsBva3KgSAhehVbG7dmJSmIvINnzTpTI6+BuOGo9ZZmpvnvzXyr4tl5KLogBK+6
 kV+1j7et5bKadwXAjfhzxhQKSoPSqHgInA+Up3Bb+QAe+6LSGI0hplUbDxAqtoKNZXnFuyV0R
 1LYuFXC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, the default line endings are denoted by a Carriage Return
byte followed by a Line Feed byte, while Linux and MacOSX use a single
Line Feed byte to denote a line ending.

To help with this situation, Git introduced several mechanisms over the
last decade, most prominently the `core.autocrlf` setting.

Sometimes, however, a single setting is incorrect, e.g. when certain
files in the source code are to be consumed by software that can handle
only LF line endings, while other files can use whatever is appropriate
for the current platform.

To allow for that, Git added the `eol` option to its .gitattributes
handling, expecting every user of Git to mark their source code
appropriately.

Bash assumes that line-endings of scripts are denoted by a single Line
Feed byte. Therefore, shell scripts in Git's source code are one example
where that `eol=lf` option is *required*.

When generating common-cmds.h, the Unix tools we use generally operate on
the assumption that input and output deliminate their lines using LF-only
line endings. Consequently, they would happily copy the CR byte verbatim
into the strings in common-cmds.h, which in turn makes the C preprocessor
barf (that interprets them as MacOS-style line endings). Therefore, we
have to mark the input files as LF-only: command-list.txt and
Documentation/git-*.txt.

Quite a bit belatedly, this patch brings Git's own source code in line
with those expectations by setting those attributes to allow for a
correct build even when core.autocrlf=true.

This patch can be validated even on Linux, by using this cadence:

	git config core.autocrlf true
	rm .git/index && git stash
	make -j15 DEVELOPER=1

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 .gitattributes         | 8 +++++++-
 git-gui/.gitattributes | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 320e33c327c..8ce9c6b8888 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,9 @@
 * whitespace=!indent,trail,space
 *.[ch] whitespace=indent,trail,space diff=cpp
-*.sh whitespace=indent,trail,space
+*.sh whitespace=indent,trail,space eol=lf
+*.perl eol=lf
+*.pm eol=lf
+/Documentation/git-*.txt eol=lf
+/command-list.txt eol=lf
+/GIT-VERSION-GEN eol=lf
+/mergetools/* eol=lf
diff --git a/git-gui/.gitattributes b/git-gui/.gitattributes
index 33d07c06bd9..59cd41dbff7 100644
--- a/git-gui/.gitattributes
+++ b/git-gui/.gitattributes
@@ -2,3 +2,4 @@
 *           encoding=US-ASCII
 git-gui.sh  encoding=UTF-8
 /po/*.po    encoding=UTF-8
+/GIT-VERSION-GEN eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


