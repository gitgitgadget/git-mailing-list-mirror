Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F741F406
	for <e@80x24.org>; Tue,  9 Jan 2018 14:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756062AbeAIOdI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 09:33:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:52978 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756009AbeAIOdF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 09:33:05 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0ME47n-1efGst2nMt-00HRiC; Tue, 09
 Jan 2018 15:33:00 +0100
Date:   Tue, 9 Jan 2018 15:33:01 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] git-gui: fix exception when trying to stage with empty
 file list
In-Reply-To: <cover.1515508360.git.johannes.schindelin@gmx.de>
Message-ID: <c227a5f8354c736abca92e9b040f7e6f569af119.1515508360.git.johannes.schindelin@gmx.de>
References: <cover.1515508360.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SP1vwO2NZbi/Hij24fjqubDVATkCieQgF3mfyXBStMnfjJAtU3d
 b4uW/5yIcDahALk43aDsGYwVcq5KoevliuTioaZEHTxGMk7GqiiSRaukHzGHaYnoq4YkX2r
 0REEPQWnasD88Y1/2qV4mb0x78/yzQjppwovcG+nOktjAp7VOQAbHID7GSPcYeEX8LLAkxg
 +ULg9kYny/1jbHUCMHNZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6EBq/IPclSc=:iON+gconO/UDugTiTT4Oon
 +TH8c27/u+viI6LmHAsf2MEkZ2cZ5+1Ahi9IMeVXkP+AFkPwAdFP+CV6wVDMdor/uHQ+Wgbbf
 WgugZVJLr38m+Mm959pOigeZSVqPAaz7Wn0l3O3tF6Xt4gpPcVtyjVrIXUgfmR2cbYs4ScSJT
 d2bOhptNz5eO3ZHEK3P6rxf2Pe2uAyiv577ACCgroFmgZ/Wle34RSS5GtqtyYeRCotQOf5dMf
 2iWjS2Gg8hDjWjJMOpXBB/aylSt/LNwI5ZEzOQkmQoC7xq8GofRN0d8ImD7XQfsb6PmhT9H4H
 XbeLyFErUqwcx/XWxdT3xp83n9lBKK428K9J0VBXxov6LyGkFBp0KN4ucg72bckgqA2xyrXtM
 I+MDsHn66A1r+W4JEtyQ888ILbiLygWzHXHIvVO26OKne9cx3yktRD1eBJDSpeXOlWDipvElo
 EyptmbLBDhCqvnt4/afaIlDZvpMNump+AWwzJN//FvuxsCjwkw6cRY5v46mB/ffdt/Kajo8A8
 IHcR/mC7lZMY2hV1OITXmLJjvdLQFOJA5pOhrW1dJNzWEeG3u86deHdzVh65K0og4CrEx114o
 kzHCSqBbPudecnC5FNZoxAx9m40NjA3lJjVwqBFMfctw8RtvlZg8EZ1L5TrLR5+dp4YHdvTjJ
 JycRtVHVVvpIQsTZ0eqA1iJ2n81v8zDpNiyymuizjBoBgRutaznYhv99viG1n6i+gy8iVomow
 HLUaz1hPnsEFBjlzGH91SMhlEQYnmyV0gK8xV48zTmN+bdjk/exPOLiVyV3fiEDrqb6mmnN1X
 09VlSjyz8ZZ0jdaNAIIMlEZVMFqcfi0fLapsAgIFL9srNjRZ8miycZcjCDrc+rKj46Op7iM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there is nothing to stage, there is nothing to stage. Let's not try
to, even if the file list contains nothing at all.

This fixes https://github.com/git-for-windows/git/issues/1075

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui/git-gui.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3c085cddc61..ca2cdebdc4f 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2504,7 +2504,9 @@ proc toggle_or_diff {mode w args} {
 		if {$last_clicked ne {}} {
 			set lno [lindex $last_clicked 1]
 		} else {
-			if {[llength $file_lists($w)] == 0} {
+			if {![info exists file_lists]
+				|| ![info exists file_lists($w)]
+				|| [llength $file_lists($w)] == 0} {
 				set last_clicked {}
 				return
 			}
@@ -2518,7 +2520,13 @@ proc toggle_or_diff {mode w args} {
 		}
 	}
 
-	set path [lindex $file_lists($w) [expr {$lno - 1}]]
+	if {![info exists file_lists]
+		|| ![info exists file_lists($w)]
+		|| [llength $file_lists($w)] < $lno - 1} {
+		set path {}
+	} else {
+		set path [lindex $file_lists($w) [expr {$lno - 1}]]
+	}
 	if {$path eq {}} {
 		set last_clicked {}
 		return
-- 
2.15.1.windows.2.395.g5bb0817ee52


