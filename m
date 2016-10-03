Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_BLACK
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3770A20986
	for <e@80x24.org>; Mon,  3 Oct 2016 10:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbcJCKCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 06:02:17 -0400
Received: from know-smtprelay-omc-2.server.virginmedia.net ([80.0.253.66]:57865
        "EHLO know-smtprelay-omc-2.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbcJCKCP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 06:02:15 -0400
Received: from red.patthoyts.tk ([82.37.62.216])
        by know-smtprelay-2-imp with bizsmtp
        id qy2C1t00w4fw4HN01y2Djc; Mon, 03 Oct 2016 11:02:13 +0100
X-Originating-IP: [82.37.62.216]
X-Spam: 0
X-Authority: v=2.1 cv=XKnNMlVE c=1 sm=1 tr=0 a=y+L2qvWGb0b1Khfuzk0aNQ==:117
 a=y+L2qvWGb0b1Khfuzk0aNQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=xqWC_Br6kY4A:10 a=1oJP67jkp3AA:10 a=ZZnuYtJkoWoA:10
 a=CH0kA5CcgfcA:10 a=RYzSAsksAAAA:8 a=Rf460ibiAAAA:8 a=7Io_EmylM0BKZtK_dVcA:9
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=Fb0xDar0a352j_O217At:22
 a=-X4ai1wA6IXBCEr1GZS2:22
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2001:470:1f1d:26c::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by red.patthoyts.tk (Postfix) with ESMTPS id A516419602E4;
        Mon,  3 Oct 2016 11:02:12 +0100 (BST)
From:   Pat Thoyts <patthoyts@users.sourceforge.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-gui: ensure the file in the diff pane is in the list of selected files
References: <20160628085925.GE3710@pflmari>
X-Face:  .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
Reply-to: patthoyts@users.sourceforge.net
X-Url:  http://www.patthoyts.tk/
Date:   Mon, 03 Oct 2016 11:02:12 +0100
In-Reply-To: <20160628085925.GE3710@pflmari> (Alex Riesen's message of "Tue,
        28 Jun 2016 10:59:25 +0200")
Message-ID: <87eg3xwy1n.fsf@red.patthoyts.tk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

>It is very confusing that the file which diff is displayed is marked as
>selected, but it is not in fact selected (that means the array of selected
>files does not include the file in question).
>
>Fixing this also improves the use of $FILENAMES in custom defined tools: one
>does not have to click the file in the list to make it selected.
>
>Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
>---
> lib/diff.tcl | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/lib/diff.tcl b/lib/diff.tcl
>index 0d56986..30bdd69 100644
>--- a/lib/diff.tcl
>+++ b/lib/diff.tcl
>@@ -127,6 +127,9 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
> 	} else {
> 		start_show_diff $cont_info
> 	}
>+
>+	global current_diff_path selected_paths
>+	set selected_paths($current_diff_path) 1
> }
> 
> proc show_unmerged_diff {cont_info} {

These both look good. Applied with minor changes to the commit message
for patch 1.

Thank you,

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
