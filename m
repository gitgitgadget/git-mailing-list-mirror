Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A20581F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933894AbcHaI4n (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:54233 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933760AbcHaI4k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:40 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ldttv-1bEExb2iSx-00j4zT; Wed, 31 Aug 2016 10:56:36
 +0200
Date:   Wed, 31 Aug 2016 10:56:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 31/34] sequencer (rebase -i): suggest --edit-todo upon unknown
 command
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <fa3efbbadd7eeb9b7e357c5e6fa23e737fc5e048.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fATC9bpLNrQmChetDCVCtiwqUW449Elo+QnfQ8KzJq/eGKg2Bbt
 S53WmdfyVCaiOB9yRjKWFBf1tI99Rqq30kglt1k6c53EdUArxzWlyV3ge2vJPhWvXxNdW5p
 ktsSPRZgJjs8/FIhLkMKeCHy20RcVfD4YEX572PJ0A1Gul1JE3Odb6lK67gW1lmK0MxOLl3
 HUBs9Nq/naa6N80P/2wvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8WkKct4+YrY=:hXct5cRx+NPwjenhwvkQOY
 HpuACNKT6aDoL1RtoUCVAChLPWC51OXQz7PeeTXYIqNFTnVswaIqFvW/lyQLIRfkMgQcmhhm7
 m0aRN4nsw+EO6QdhzYLniPUpF/URltzuC+UyRJrxBHFlH89XmAM1igIV5gnq6EMZaD52OYRTA
 U/YeX2zJi44srlQMEiA5Mo7pR+kf3icqqoJ/lVwR3bER2yMY1iuJM9+3ZBTX+/boRRacOjjKB
 Ji0v8Vx777V6W1y4coUcycH8EiQHh4Pmudu23TTPxiLTEDtBnyAAa5nZsTHkVpprLE49kBsN6
 NzhP88WVdzFZADjcMrrrzGbNgFsbXC3eElhzTYEYv/peA3dJy+Zr5ZAV7f/zXlDIaX2QDgNLy
 fv/CBWPOdDsBBDLSXVY3Y3w3bh/Z9F+XbHVenbGY6DyK1tqinLr3jyHO0sh84llU4XVfMQOo+
 fqoBr2ejAT7W7SfTh7DfrZyv2ITvP+jfmY3vtifwV46uhxnfyHk465OVp5hdy60scgQUrYsNh
 antT2OP74AULk4bzN3UDOAq64i4C7wXGsLJB937V7zXP6L9cxsG1x84mBn3jNdGNwn1dB5sOr
 AX1sl/dboXD4Ga1LMyryKJR7NkaSQKzHWaOftU60lxX3aHDFvCzV+j60ATqEz30ZNFKQrV04e
 o70KxDjQe3DesAmsxoMGcqvJ/i+BU6LapPTZna5M2OvP9Dezkq6V0eaBDTdbnfGu7i5NA8acd
 7+mfkmu8cwEHnDTDNceV2AQ1iDvGEn/QSCIWBqajrO4G3K6OIVb98k/RYnzEo08AiCD+5NRxc
 YLsdGzh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the same behavior as known from `git rebase -i`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index b34c381..89fd625 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1346,8 +1346,12 @@ static int read_populate_todo(struct todo_list *todo_list,
 	close(fd);
 
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
-	if (res)
+	if (res) {
+		if (is_rebase_i(opts))
+			return error("Please fix this using "
+				"'git rebase --edit-todo'.");
 		return error(_("Unusable instruction sheet: %s"), todo_file);
+	}
 	if (!todo_list->nr &&
 	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
 		return error(_("No commits parsed."));
-- 
2.10.0.rc2.102.g5c102ec


