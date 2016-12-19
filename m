Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09F41FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933565AbcLSQqU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:20 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61897 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933448AbcLSQpf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:35 -0500
X-AuditID: 12074411-fbbff700000009b7-5b-58580eaed077
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 38.97.02487.EAE08585; Mon, 19 Dec 2016 11:45:34 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKR5011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:34 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/13] gitk: add a configuration setting `remoterefbgcolor`
Date:   Mon, 19 Dec 2016 17:45:11 +0100
Message-Id: <543b8463c22b19aade4c5dbcc72f4fc8663d372a.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsUixO6iqLuOLyLCYO4Ec4uuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugStjyfc/rAV/BSqezLrM1MB4
        kreLkYNDQsBE4sdxnS5GTg4hgcuMEh1tqhD2KSaJKesFQWw2AV2JRT3NTCDlIgKqEusvCIGE
        mQUcJDZ/bmQEsYUFvCX2n3wNZrMAldz9cIMVxOYViJJYfukbE4gtISAncWnbF2YQm1PAQuLm
        /CvsEKvMJTY8+80ygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQ
        YBDcwTjjpNwhRgEORiUe3oL3YRFCrIllxZW5hxglOZiURHn380RECPEl5adUZiQWZ8QXleak
        Fh9ilOBgVhLh/cYLlONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDe
        B2kULEpNT61Iy8wpQUgzcXCCDOcBGv4AbHhxQWJucWY6RP4Uoy7HkhvrnjIJseTl56VKifM6
        ghQJgBRllObBzYFF8StGcaC3hHk5gTEtxANMAHCTXgEtYQJasrA7HGRJSSJCSqqBcSOT5Xmh
        vUvMmwxO33OrW56xVSHk5sZL78/tVbvzat7FzXdn6FwvaK50WrKW6/jvuoll5yVrGRIY+iMt
        8p/lzQvtXFaZ98tgseCxjSnRIQc+qy/S62uLZvq69kOXYO1tk9/Ti2K02GPM5uVkNB+dsfiP
        VdfksjjnN4mPXmeu3vSBnSvu8pL8T0osxRmJhlrMRcWJAG6N9hS9AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remote-tracking references are very different than local branches, so it
would be nice to make it possible to distinguish then visually. So allow
the remote reference background color to be configured separately from
the branch reference background color by introducing a new constant,
`remoterefbgcolor`. For the moment, leave it set to the old default
`headbgcolor`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 0bd4aa5..cb5c715 100755
--- a/gitk
+++ b/gitk
@@ -6574,7 +6574,7 @@ proc drawtags {id x xt y1} {
     global linespc lthickness
     global canv rowtextx curview fgcolor bgcolor ctxbut
     global headbgcolor headfgcolor headoutlinecolor
-    global remotebgcolor otherrefbgcolor
+    global remotebgcolor remoterefbgcolor otherrefbgcolor
     global tagbgcolor tagfgcolor tagoutlinecolor
     global reflinecolor
 
@@ -6669,8 +6669,10 @@ proc drawtags {id x xt y1} {
 	    if {$type eq "mainhead"} {
 		set col $headbgcolor
 		set font mainfontbold
-	    } elseif {$type eq "head" || $type eq "remote"} {
+	    } elseif {$type eq "head"} {
 		set col $headbgcolor
+	    } elseif {$type eq "remote"} {
+		set col $remoterefbgcolor
 	    } else {
 		set col $otherrefbgcolor
 	    }
@@ -12362,6 +12364,7 @@ set headbgcolor "#00ff00"
 set headfgcolor black
 set headoutlinecolor black
 set remotebgcolor #ffddaa
+set remoterefbgcolor #00ff00
 set otherrefbgcolor #ddddff
 set tagbgcolor yellow
 set tagfgcolor black
@@ -12420,7 +12423,7 @@ set config_variables {
     bgcolor fgcolor uifgcolor uifgdisabledcolor colors diffcolors mergecolors
     markbgcolor diffcontext selectbgcolor foundbgcolor currentsearchhitbgcolor
     extdifftool perfile_attrs headbgcolor headfgcolor headoutlinecolor
-    remotebgcolor otherrefbgcolor
+    remotebgcolor remoterefbgcolor otherrefbgcolor
     tagbgcolor tagfgcolor tagoutlinecolor reflinecolor
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
-- 
2.9.3

