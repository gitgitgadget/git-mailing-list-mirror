Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36F01FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933571AbcLSQqV (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 11:46:21 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45772 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933444AbcLSQpd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Dec 2016 11:45:33 -0500
X-AuditID: 12074413-44dff70000000a33-03-58580eab41a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.82.02611.BAE08585; Mon, 19 Dec 2016 11:45:31 -0500 (EST)
Received: from bagpipes.fritz.box (p57906BA3.dip0.t-ipconnect.de [87.144.107.163])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBJGjKR2011292
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 19 Dec 2016 11:45:31 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/13] gitk: shorten labels displayed for modern remote-tracking refs
Date:   Mon, 19 Dec 2016 17:45:08 +0100
Message-Id: <5dec4a22621a441099b187f081831bbe8f5cc05c.1482164633.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1482164633.git.mhagger@alum.mit.edu>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsUixO6iqLuaLyLC4NkaA4uuK91MFrdXzGe2
        WHNkMbsDs8ff9x+YPObu6mP0+LxJLoA5issmJTUnsyy1SN8ugSvj1tkbjAUzBSuap7xnaWB8
        y9PFyMEhIWAisX4hUxcjF4eQwGVGia6Hy1kgnFNMEqee3mbtYuTkYBPQlVjU08wE0iAioCqx
        /oIQSJhZwEFi8+dGRhBbWCBU4talm0wgNgtQyfJrTcwgNq9AlMTtBR/BxkgIyElc2vYFLM4p
        YCFxc/4VdhBbSMBcYsOz3ywTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI118vNLNFL
        TSndxAgJCOEdjLtOyh1iFOBgVOLhLXgfFiHEmlhWXJl7iFGSg0lJlHc/T0SEEF9SfkplRmJx
        RnxRaU5q8SFGCQ5mJRFeMZAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaD
        Q0mCN5wXqFGwKDU9tSItM6cEIc3EwQkynAdoeDpIDW9xQWJucWY6RP4Uo6KUOK8jSEIAJJFR
        mgfXC4vYV4ziQK8I83IC41eIBxjtcN2vgAYzAQ1e2B0OMrgkESEl1cBoZ5swk9EyiqdpB19J
        5JHjC24yfLt902TltfUtM1Y/VvOSnNL37sWPo9mSObf2XPOc/thf5ul56fke4t/2eHgrS1Tm
        +l9ZfE6Mx9764Odswbb//+LevHgQ/O1gxiTxQ1ySOV8j89Xu5U49zBV59pzVJs1b234uZJnJ
        Nsf0t1+x1LIY0YZrZwXOKbEUZyQaajEXFScCAAuEQlGzAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a reference has the form

    refs/remotes/origin/foo

, then use the label

    origin/foo
    ^^^^^^^

, where the indicated part is displayed in `$remotebgcolor`. The old
code would have displayed such a reference as

    remotes/origin/foo
    ^^^^^^^^^^^^^^^

, which wastes horizontal space displaying `remote/` for every remote
reference. However, if a remote-tracking reference has only two slashes,
like

    refs/remotes/baz

, render the label the same as before, namely

    remotes/baz
    ^^^^^^^^

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 gitk | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index c146a15..d22ce5f 100755
--- a/gitk
+++ b/gitk
@@ -6558,7 +6558,9 @@ proc remotereftext {head textName prefixName} {
     upvar $textName text
     upvar $prefixName prefix
 
-    if {[regexp {^((remotes/([^/]+/|)).*)} $head match text prefix]} {
+    if {[regexp {^remotes/(([^/]+/).*)} $head match text prefix]} {
+	return 1
+    } elseif {[regexp {^((remotes/).*)} $head match text prefix]} {
 	return 1
     } else {
 	set text $head
@@ -6613,7 +6615,8 @@ proc drawtags {id x xt y1} {
 		lappend wvals [font measure mainfontbold $head]
 	    } else {
 		lappend types head
-		lappend wvals [font measure mainfont $head]
+		remotereftext $head text remoteprefix
+		lappend wvals [font measure mainfont $text]
 	    }
 	    lappend marks $head
 	}
@@ -6644,6 +6647,7 @@ proc drawtags {id x xt y1} {
 	set xl [expr {$x + $delta}]
 	set xr [expr {$x + $delta + $wid + $lthickness}]
 	set font mainfont
+	set text $tag
 	if {$type eq "tag" || $type eq "tags"} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
@@ -6679,7 +6683,7 @@ proc drawtags {id x xt y1} {
 			-width 0 -fill $remotebgcolor -tags tag.$id
 	    }
 	}
-	set t [$canv create text $xl $y1 -anchor w -text $tag -fill $headfgcolor \
+	set t [$canv create text $xl $y1 -anchor w -text $text -fill $headfgcolor \
 		   -font $font -tags [list tag.$id text]]
 	if {$type eq "tag" || $type eq "tags"} {
 	    $canv bind $t <1> $tagclick
-- 
2.9.3

