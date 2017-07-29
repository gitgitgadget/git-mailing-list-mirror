Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0649F20899
	for <e@80x24.org>; Sat, 29 Jul 2017 10:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbdG2KFN (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 06:05:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:62496 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753720AbdG2KFM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 06:05:12 -0400
Received: from [192.168.1.68] ([2.242.62.62]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBrCt-1dSLwX19nj-00Aq2y; Sat, 29
 Jul 2017 12:05:10 +0200
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>
From:   Stefan Dotterweich <stefandotterweich@gmx.de>
Subject: [PATCH] gitk: different color for boundary commits
Message-ID: <6d65267a-1811-8c25-dd59-98fa5ef19655@gmx.de>
Date:   Sat, 29 Jul 2017 12:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:SjxZYsTK9bZW71RsqXfj4yiULo9pQmoduQwWzYXSVu2wNUPjBOe
 O5jWjGOEmqdsgtktbYAD6rT7oAt5JDR/Bn151wRBPnQHw4SpDPsoqBZzEkwcU9fTdWfumNf
 ZtdeVMIRDLAb/w9i89tC01ePLPJVJ4NQ4oHHW/C+pcOhepNR4LBSq7uYuBODieJ9hRCn8DP
 CERIzSZm65snbNZO+Y4FQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nS+xhhrba/M=:hT5X2Dwt20rC9nnLqSDyyG
 3x7aF4TIRWtgbcFDuwihZ3l4j2/mciMT4BdPJ7S9aTJjbiA+hUZzq/uh4sD6YQjK34pumDO2Q
 w2AdZeO7nbZZhE/kikCO6g+FsRA5bNcmpJzBXRsbNVRCyrZVjKZWkdJo609fjqsz7F5ZDEiZ5
 AvXfq+qOKu9BuJqP3PKrLBJ8765sIyzFVTboRQ8wD/J2LqBFbjt2jNSQFvtVEQX9v6erE+1nu
 9xul0cD53jR7Ck/P3gANgMPQ4MQiDYI0WseWJ0ffCwOGJkpiVkZBV7wP4hiyW6pQ+xCn7ybFd
 pyf9xHYtKoHTP2SCcxIndXoOsaD6gElLdv2e4Q32OMebt9Jj0fZIYv/k4BC3qLk501VCrUnpJ
 7pgVZ5NMG8RrlKvt25rOFWPQrO81wLuYUfPcaacQBubNqwgLXtoUBU5QpWbhFUUwHyFkefrjH
 Re2F25++u5rpqXx+u/EchaG1y9NZ4oZif/2p+rWNsLVUzu0Hl5gNXFzJXIhRDYr/o3VaGKqXA
 ZMT+77K59S/OSZAp5pXYayOh89CESQX67a84GwN1Wq8oGNrvpNbhza6rWITUUSZgwN34iZ3fw
 30pRr8h7Uf/YViWdI/LomNxTTbKofsMpvBprNj0dlElXauAZcJ9hK5bDBVpavZjAZ+sXxapju
 zrcHv43vWiaXTgOexUWseFhyU8TPeCfO51qIMqHAW/659utv+xqQalatl6tM79uu6JHTMyFMb
 efiW99tWPvgG8GC+uLNDsbS7s/LeFGKXK5uyexwedzZRFWC5e/LRIVqg08cInktvdwMwcj8dl
 F54iEfbwb/jQaq5UAtIoEcIE5lJs/yOP18BLl6GYVdreV7pwSs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using filters, the commit list shows not only commits matching
the filter criteria, but also boundary commits. When going through a
list of say, all commits changing the variable `foo`, often half of
the displayed commits are boundary commits. In this case the boundary
commits are of little interest.

However, there is no way to hide them or quickly distinguish them from
the actual commits.  Boundary commits can be identified by the white
color inside the circle, but that is not easily recognisable.  On each
line you  have to look at the circle color to identify the commit
type. This makes it hard to just quickly skim a list of commits,
especially when looking at dates and authors which are further to the
right.

Therefore, to make boundary commits easier to recognise, display their
text in a different color.

Signed-off-by: Stefan Dotterweich <stefandotterweich@gmx.de>
---
 I made this change for myself, but it would be nice to see it in the
 official build.

 gitk-git/gitk | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a14d7a16b..8f5e0df75 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6115,7 +6115,7 @@ proc drawcmittext {id row col} {
     global canvxmax boldids boldnameids fgcolor markedid
     global mainheadid nullid nullid2 circleitem circlecolors ctxbut
     global mainheadcirclecolor workingfilescirclecolor indexcirclecolor
-    global circleoutlinecolor
+    global circleoutlinecolor uifgdisabledcolor
 
     # listed is 0 for boundary, 1 for normal, 2 for negative, 3 for left, 4 for right
     set listed $cmitlisted($curview,$id)
@@ -6128,6 +6128,10 @@ proc drawcmittext {id row col} {
     } else {
 	set ofill [lindex $circlecolors $listed]
     }
+    set textcolor $fgcolor
+    if {$listed eq 0} {
+	set textcolor $uifgdisabledcolor
+    }
     set x [xc $row $col]
     set y [yc $row]
     set orad [expr {$linespc / 3}]
@@ -6189,12 +6193,12 @@ proc drawcmittext {id row col} {
 	    set nfont mainfontbold
 	}
     }
-    set linehtag($id) [$canv create text $xt $y -anchor w -fill $fgcolor \
+    set linehtag($id) [$canv create text $xt $y -anchor w -fill $textcolor \
 			   -text $headline -font $font -tags text]
     $canv bind $linehtag($id) $ctxbut "rowmenu %X %Y $id"
-    set linentag($id) [$canv2 create text 3 $y -anchor w -fill $fgcolor \
+    set linentag($id) [$canv2 create text 3 $y -anchor w -fill $textcolor \
 			   -text $name -font $nfont -tags text]
-    set linedtag($id) [$canv3 create text 3 $y -anchor w -fill $fgcolor \
+    set linedtag($id) [$canv3 create text 3 $y -anchor w -fill $textcolor \
 			   -text $date -font mainfont -tags text]
     if {$selectedline == $row} {
 	make_secsel $id
-- 
2.12.0

