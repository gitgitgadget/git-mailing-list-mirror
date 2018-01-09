Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182911F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeAIOdM (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:33:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:55833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756010AbeAIOdH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:33:07 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV1wf-1eN3Xm1bnJ-00YOX5; Tue, 09
 Jan 2018 15:33:03 +0100
Date:   Tue, 9 Jan 2018 15:33:04 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] git-gui: allow Ctrl+T to toggle multiple paths
In-Reply-To: <cover.1515508360.git.johannes.schindelin@gmx.de>
Message-ID: <3f01f30f6fce762e127c45c361b009e7b6de33b4.1515508360.git.johannes.schindelin@gmx.de>
References: <cover.1515508360.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5Z64lsa3p1AVPRpFxFf8mTNAqkJEPYopa7yP2nI0rVGyEshpr8p
 Tz+C5ko+McPq+4SgDRujqMVs/yqgLRdkHw4gByCK8aF2kpbYwnOWH11EsU7CCVJmfLnzLDm
 T/yP5kx7LKfHhnNwDxTFFKZz0v0fSf8xexZILZAtqGi77ZCA6MrwfG6WRqEHV64UKa3kndA
 jaSVXTQDiq1gdC9VnNDlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4e/+EcrqLW4=:3fWDHo8O3w9PYBdJCPUTup
 C/azLZfhhR+CkMQv59Dwn4EaNEyqsypMHxnd0nNI893bk1TZ6Io/cD9UT5K4YP9ko1Ax7a2JH
 tmxKEWLyctnzGWIfUhsk84MqReDNabPBdlkheRILLMIJqxHCMMefid0AiqOiKXBtXKPJqS1wD
 msCvMd02rHWT65Vgq58sgvU1x+Pt7ak6JF5dQEl28Qf164U5nzbAFTzSBzCsfx5CQwLUy4St/
 o3WF0kkyfqF8BoMZp5WqIYBZN+GW2xiQahGZTW7yUG2u5osYcXzMXuetmchZ1KPhci3Ls2uIX
 i0Y/bjqMSBSVrhJT0C4EeNUCUgSzgeCtr6+iVkaOsUJF3W01mJP9uDLuwmU3r39/uJ652hg2h
 HU3hBBOI45pEuHMumRCtk212hbMdeSvo9ZXenLxBPiHlyCNHHuudAySOU4hS/g9BuiZxN4pek
 ZEUYq+ty7/YvMqiKqFQDo8amlNUy6Ei9KsWsEYdoge6Pvkg50gIRdyovCm+frpPSsYH212Ty7
 /nfnHYEq1gEMu7Z9UHd2xGqokyd3JrfxINGAskjmkrYVq99tVwebjw6pq0jZxo8U9LjNiKBXp
 IAFHexKVO6YawURvyjdPNdSyHsoy6dYqSG78XjrnXy338OKTRL1MFja08vsxVSxJDU0+GL22o
 iSyfj2P2z3P4Qsh2ecx5Wa8OzQsYEoUgyx5hVkozZzBEB/gkZTJocjEn6ShpBFlIpiSTwQ0gj
 rNjqzM9LwhD+qVsllmhvkKXvbuY5vFlxoD/+IDNw5CjBpskg4hhXG48zD3xDYpPri0tsDXDD/
 B6JFSLNogFpvC5aIpbBIfTn6sX54KmV1OPMeLGIsWBaYkOJk+uX7FmiNVERNi6AWxXOQs/3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to select multiple files in the "Unstaged Changes" and
the "Staged Changes" lists. But when hitting Ctrl+T, surprisingly only
one entry is handled, not all selected ones.

Let's just use the same code path as for the "Stage To Commit" and the
"Unstage From Commit" menu items.

This fixes https://github.com/git-for-windows/git/issues/1012

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui/git-gui.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index ca2cdebdc4f..91c00e64893 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2501,6 +2501,19 @@ proc toggle_or_diff {mode w args} {
 		set pos [split [$w index @$x,$y] .]
 		foreach {lno col} $pos break
 	} else {
+		if {$mode eq "toggle"} {
+			if {$w eq $ui_workdir} {
+				do_add_selection
+				set last_clicked {}
+				return
+			}
+			if {$w eq $ui_index} {
+				do_unstage_selection
+				set last_clicked {}
+				return
+			}
+		}
+
 		if {$last_clicked ne {}} {
 			set lno [lindex $last_clicked 1]
 		} else {
-- 
2.15.1.windows.2.395.g5bb0817ee52
