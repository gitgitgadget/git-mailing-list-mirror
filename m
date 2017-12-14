Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361FF1F406
	for <e@80x24.org>; Thu, 14 Dec 2017 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbdLNJdF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 04:33:05 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55138 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLNJdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 04:33:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20171214093301euoutp0112b35162d68b0129f9704b32f90c2923~AH2I5WH3O1695016950euoutp01W;
        Thu, 14 Dec 2017 09:33:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20171214093301euoutp0112b35162d68b0129f9704b32f90c2923~AH2I5WH3O1695016950euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1513243981;
        bh=tOFz+lqLynA4o6Ce7eQZs64wQhTxWNsvafiflSGyEEA=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=cB1T3SRGy3dppDxVu1hRx90pJgIiSnwSzw0mnFPUv/ROgM0sA7Jm+gBYWrZMdI8Pu
         zDAVQzyoYEisI9RNRG0NVZWpRi3eKjGT3UouW5m+hb+WILCJO1pGrttU0mo8wiKDcY
         hNWi0BI5H070pxdX7zE6/IwxHgls+OAuvEh7sPZA=
Received: from eusmges4.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171214093300eucas1p1a32cc91c7580095abc32820e022f2820~AH2IQAVVk1045510455eucas1p11;
        Thu, 14 Dec 2017 09:33:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges4.samsung.com (EUCPMTA) with SMTP id EA.9D.30163.C45423A5; Thu, 14
        Dec 2017 09:33:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171214093300eucas1p28ed9bf0261a43a12978b6a3bfe908321~AH2HkQ-tu3133231332eucas1p2-;
        Thu, 14 Dec 2017 09:33:00 +0000 (GMT)
X-AuditID: cbfec7f4-f790c6d0000075d3-00-5a32454c4a47
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.31.18832.C45423A5; Thu, 14
        Dec 2017 09:33:00 +0000 (GMT)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from localhost ([106.116.147.110]) by eusync3.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0P0Y001LD2IZEO10@eusync3.samsung.com>; Thu, 14 Dec 2017 09:33:00
        +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     gitster@pobox.com
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        git@vger.kernel.org, patthoyts@users.sourceforge.net,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v4] git-gui: Prevent double UTF-8 conversion
Date:   Thu, 14 Dec 2017 10:32:57 +0100
Message-id: <20171214093257.15826-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
In-reply-to: <20171205142326.6140-1-l.stelmach@samsung.com>
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzneV0fV6MogwOnFSy6rnQzWTT0XmG2
        6F/exWZx89AKRot3nbdZHFg9PnyM87h4Sdmjb8sqRo+mU+2sHp83yQWwRnHZpKTmZJalFunb
        JXBlzD7ayVzwSbDiy9dTzA2MP3i7GDk5JARMJCZO6WCEsMUkLtxbz9bFyMUhJLCUUeLb5y9Q
        zmdGiba9p1hgOma8vAOVWMYocWv9PbAEr4CgxI/JIDYHB7OAvMSRS9kgYWYBTYmtu9ezQ9R/
        YZQ4uPYFE0iCTcBRon/pCVYQW0RAVOLI/EVgQ5kFpjJK3O7fBJYQFrCROPxnK9h9LAKqEot3
        NbNCLLOWeDl9KdTd8hK72i6CxTmB4tdu/gOL8wtoSaxpus4CMlRCYA+bxN4fDWwQDS4Si4+t
        h2oWlnh1fAs7hC0j0dlxkAmioZ9R4vD871CJKYwSixc6QNjWEn9WTWSD+I1PYtK26cwgL0sI
        8Ep0tAlBlHhIzP+zkBXCdpSY//UsE8T7fYwSC2bdY53AKD8LKcRmIUJsFlKILWBkXsUoklpa
        nJueWmyiV5yYW1yal66XnJ+7iRGYOk7/O/5lB+PiY1aHGAU4GJV4eCO0DaOEWBPLiitzDzFK
        cDArifCqTQQK8aYkVlalFuXHF5XmpBYfYpTmYFES57WNaosUEkhPLEnNTk0tSC2CyTJxcEo1
        MFauOui4si0oawEnQ29t0MGZnvGK1dP5o0w3K27UOhg2d/Vb43dWmbL+p75PMHh8L7H6puhX
        k6hIdq3SzUl32b3qj8x+UHTzkuFO999R3uHn23zD/rtlsmndMmn7omhredRGa2K7bcns12qt
        L29G8DTaTDbY5BWS3vZHsePmUR9/j5b7bjxSSizFGYmGWsxFxYkAtRCnHxkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xq7o+rkZRBhMus1h0XelmsmjovcJs
        0b+8i83i5qEVjBbvOm+zOLB6fPgY53HxkrJH35ZVjB5Np9pZPT5vkgtgjeKySUnNySxLLdK3
        S+DKmH20k7ngk2DFl6+nmBsYf/B2MXJySAiYSMx4eYcNwhaTuHBvPZDNxSEksIRRYtL+jywg
        CV4BQYkfk+8B2RwczALyEkcuZYOEmQXUJSbNW8QMUf+NUWLy0TNg9WwCjhL9S0+wgtgiAqIS
        R+YvAhvKLDCVUeLH6kZ2kISwgI3E4T9bGUFsFgFVicW7mlkhlllLvJy+lBHiInmJXW0XweKc
        QPFrN/+BxYUErCSurznLBGLzC2hJrGm6zjKBUXAWkltnIdw6C8mtCxiZVzGKpJYW56bnFhvq
        FSfmFpfmpesl5+duYgSG+LZjPzfvYLy0MfgQowAHoxIP7wZdwygh1sSy4srcQ4wSHMxKIrxq
        E4FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeXv3rI4UEkhPLEnNTk0tSC2CyTJxcEo1MMbzZK5w
        MDIsNHCRsfvA+jTh8HV1ieymy1/2MedtFbs5U/Tkhgrr2xMWZZ2wUrgpVH59X50CF5vk7PCW
        vdfi3grsSfBgj5P6st/I6Ixag7qn9YSC3fJdPTm/Z65MPHi1PMlt4tmJkxOzWhJmzxNZKnnp
        uPbakn17m8t1jssZuKgqHXr9f8+HZCWW4oxEQy3mouJEAMnfqo5tAgAA
X-CMS-MailID: 20171214093300eucas1p28ed9bf0261a43a12978b6a3bfe908321
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171214093300eucas1p28ed9bf0261a43a12978b6a3bfe908321
X-RootMTR: 20171214093300eucas1p28ed9bf0261a43a12978b6a3bfe908321
References: <20171205142326.6140-1-l.stelmach@samsung.com>
        <CGME20171214093300eucas1p28ed9bf0261a43a12978b6a3bfe908321@eucas1p2.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert author's name and e-mail address from the UTF-8 (or any other)
encoding in load_last_commit function the same way commit message is
converted.

Amending commits in git-gui without such conversion breaks UTF-8
strings. For example, "\305\201ukasz" (as written by git cat-file) becomes
"\303\205\302\201ukasz" in an amended commit.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
Changes since v3:

- Added Reviewed-by footer. Thank you Johannes Schindelin, for review.

 git-gui/lib/commit.tcl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 83620b7cb..75ea965da 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -25,6 +25,8 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 	set msg {}
 	set parents [list]
 	if {[catch {
+			set name ""
+			set email ""
 			set fd [git_read cat-file commit $curHEAD]
 			fconfigure $fd -encoding binary -translation lf
 			# By default commits are assumed to be in utf-8
@@ -34,9 +36,7 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 					lappend parents [string range $line 7 end]
 				} elseif {[string match {encoding *} $line]} {
 					set enc [string tolower [string range $line 9 end]]
-				} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} {
-					set commit_author [list name $name email $email date $time]
-				}
+				} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} { }
 			}
 			set msg [read $fd]
 			close $fd
@@ -44,7 +44,13 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 			set enc [tcl_encoding $enc]
 			if {$enc ne {}} {
 				set msg [encoding convertfrom $enc $msg]
+				set name [encoding convertfrom $enc $name]
+				set email [encoding convertfrom $enc $email]
 			}
+			if {$name ne {} && $email ne {}} {
+				set commit_author [list name $name email $email date $time]
+			}
+
 			set msg [string trim $msg]
 		} err]} {
 		error_popup [strcat [mc "Error loading commit data for amend:"] "\n\n$err"]
-- 
2.11.0

