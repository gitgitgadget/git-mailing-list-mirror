Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8BB820A40
	for <e@80x24.org>; Tue,  5 Dec 2017 14:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbdLEOXq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 09:23:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34220 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752366AbdLEOXp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 09:23:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20171205142343euoutp01a354f73a0c0a7cf016adf1ed534ea0a2~9bAYlT8P_1496814968euoutp01k;
        Tue,  5 Dec 2017 14:23:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20171205142343euoutp01a354f73a0c0a7cf016adf1ed534ea0a2~9bAYlT8P_1496814968euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1512483823;
        bh=lRJa+fs2Nxp7QGdotTuU7Z2uv7/Kfwp+nH3c1UgykCQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Am77T9yQRPpUyQU11bRvYLUUtU30xXgG3Mw+6V1R7BsU4QigRG43tQ4Q0KHmmR1T2
         OaI7DKAI8bvcWF1wKowMchAMXU0G38PzlZPrWsAXdtJ5vZ2Vjr/sfYfyycVhOmoyF9
         dxM30M6C37xkJ/moX5ZvHg2vFqBTPJApF3TfEG5s=
Received: from eusmges5.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171205142342eucas1p153442de3616248ecb2375bf93f3cc3e3~9bAXz9bPL3090930909eucas1p1V;
        Tue,  5 Dec 2017 14:23:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges5.samsung.com (EUCPMTA) with SMTP id D7.15.12743.EEBA62A5; Tue,  5
        Dec 2017 14:23:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171205142341eucas1p2b30072c799c8787f1b66db2fd4bac1a2~9bAXKZD2X1823518235eucas1p2m;
        Tue,  5 Dec 2017 14:23:41 +0000 (GMT)
X-AuditID: cbfec7f5-f79d06d0000031c7-f8-5a26abee2100
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 76.E5.20118.DEBA62A5; Tue,  5
        Dec 2017 14:23:41 +0000 (GMT)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from localhost ([106.116.147.110]) by eusync3.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0P0H00BJRRZHF840@eusync3.samsung.com>; Tue, 05 Dec 2017 14:23:41
        +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        =?UTF-8?q?=C5=81ukasz=20Stelmch?= <stlman@poczta.fm>
Subject: [PATCH v3] git-gui: Prevent double UTF-8 conversion
Date:   Tue, 05 Dec 2017 15:23:26 +0100
Message-id: <20171205142326.6140-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
In-reply-to: <20171202122046.6033-1-l.stelmach@samsung.com>
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned13q9WiDK51SFp0Xelmsuhf3sVm
        cfPQCkaLd523WSwW3exicmD1+PAxzqOx4QOTR9+WVYweTafaWT0+b5ILYI3isklJzcksSy3S
        t0vgynj2+wRLwRWBiu/7f7I0MH7i6WLk5JAQMJH4cOgGI4QtJnHh3no2EFtIYCmjxLF1Vl2M
        XED2Z0aJG/PWscI0XHy+nRkisYxRonXRJLAOXgFBiR+T77F0MXJwMAvISxy5lA0SZhbQlNi6
        ez07xNAvjBI7HzqB2GwCjhL9S0+AzRQR8JSY9+MIC8hMZoHljBI9zfeYQBLCAjYSe7rngV3H
        IqAqMfnMd6hdVhIP/s5igjhIXmJX20WwQZwC1hJPJvaD1fMLaEmsabrOAlFzgE2ic5IWyG0S
        Ai4Sy69JQ4SFJV4d38IOYctIXJ7cDXaDhEA/o8Th+d+hElMYJRYvdICwrSX+rJrIBvEYn8Sk
        bdOZIWbySnS0CUGUeEgcm38Baq2jRNvOl4yQsOpjlFiwfwLjBEb5WUjBNQsRXLOQgmsBI/Mq
        RpHU0uLc9NRiU73ixNzi0rx0veT83E2MwKRx+t/xrzsYlx6zOsQowMGoxMO7YpZalBBrYllx
        Ze4hRgkOZiURXuZ+oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe26i2SCGB9MSS1OzU1ILUIpgs
        EwenVAOjSLL7/TbFhCPl91x338/YzC3C/Oq07+yl22O6uf5O6/mskbTt0HS3APbZy/2ljaJF
        In80XGCqfSKk0h74r+vjq5kLln7o+q/MtM6z/1LSZqYjWj90J5Tettrflb1zYshUPTGnj2IB
        Fr8EP56u+jC940fJnt2Wua/iDv0NnDGBdQObmcvyG19dlViKMxINtZiLihMB3jVvLRYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xq7pvV6tFGbzstrboutLNZNG/vIvN
        4uahFYwW7zpvs1gsutnF5MDq8eFjnEdjwwcmj74tqxg9mk61s3p83iQXwBrFZZOSmpNZllqk
        b5fAlfHs9wmWgisCFd/3/2RpYPzE08XIySEhYCJx8fl2ZghbTOLCvfVsILaQwBJGiZfvfUBs
        XgFBiR+T77F0MXJwMAvISxy5lA0SZhZQl5g0bxFQKxdQ+TdGiblbfrODJNgEHCX6l55gBbFF
        BDwl5v04wgJSxCywnFFi27a/YEXCAjYSe7rnMYLYLAKqEpPPfGeDWGYl8eDvLCaIg+QldrVd
        BBvEKWAt8WRiPyPEcVYSx1r3gtXzC2hJrGm6zjKBUXAWkltnIdw6C8mtCxiZVzGKpJYW56bn
        FhvpFSfmFpfmpesl5+duYgSG+LZjP7fsYOx6F3yIUYCDUYmHd8UstSgh1sSy4srcQ4wSHMxK
        IrzM/UAh3pTEyqrUovz4otKc1OJDjNIcLErivL17VkcKCaQnlqRmp6YWpBbBZJk4OKUaGBU8
        9oYv/WYSybMviGO1knb0r2/qzoVXgqf4dkzumy6WmMPr/LWmemZprVy4/ww285U9DEfO3uiM
        neb760BL53Xr/tuaE3u/aJgcFvc8NV/0mJyhjGzn79q420vLrkl9fvVykWSu49WLAezdYRYW
        dS99V+17vttq+q3V9XrOm5dkR16o/NlwVImlOCPRUIu5qDgRAFy4ZpltAgAA
X-CMS-MailID: 20171205142341eucas1p2b30072c799c8787f1b66db2fd4bac1a2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20171205142341eucas1p2b30072c799c8787f1b66db2fd4bac1a2
X-RootMTR: 20171205142341eucas1p2b30072c799c8787f1b66db2fd4bac1a2
References: <20171202122046.6033-1-l.stelmach@samsung.com>
        <CGME20171205142341eucas1p2b30072c799c8787f1b66db2fd4bac1a2@eucas1p2.samsung.com>
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
---
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

