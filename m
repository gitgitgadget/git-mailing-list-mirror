Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8433205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756354AbdABP2X (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:64032 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756337AbdABP2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:19 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPD8G-1cSSFa2PRo-004P2F; Mon, 02
 Jan 2017 16:28:06 +0100
Date:   Mon, 2 Jan 2017 16:28:05 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 20/38] sequencer (rebase -i): allow fast-forwarding for
 edit/reword
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <06952cd808c4d4344ff887d77684142752d59a76.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BPqtWdiZZEHeupIp4RASVfR/Ys4msySEpShv+mwOBmZtTsMavTA
 tn6kKbemnnQHk8JYHkqnDtcYLztrPmDsD/mkp0+2BJCpuIE5tHnFtNo4pQISPl7+RdrQVi6
 z1qcObkCxwiOJEtBro4n7E2sE+1fWF0lyx80HZTjo+OkIB5+zagcN0ydExg+ZPHXgUuEE6V
 ZZK/9XLkV2TABJm6juonw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Og46x9+Q6uI=:YcQtYoRpQ4/DD1mtFT2a0l
 DV0IKBzKvkAskEn1AFswm7gxOIxBu6TNqthzUFOrUICTEkWU2pJgun7y3nCJB8m7QLTNliah3
 R95z37BW5DnNuCWNHAiz6slziPsGXO6oTAnXhX6yV1QEdEkW3TqMTX6MDtzOQcZEl+S+KdhHV
 mRpI1x7YzAMmMA5l2NgEBLpCPpgfp11rXhOBg/8Q3u+72hjXbqfbkNt9Xvidg+6oZHF1ouzxF
 OL74wa48rC1T1aP1G1H7ml0gY9NLWIctFUdxMZdI+qkSoKkOoeCfSEFvO2x8fbttplhixUdRl
 jtXa1PCXXrA6ONdNJ7YS8hqXf/Qqe0g5mq94FUPVVN6h9ECWkYljtm76qEe2/iSzZNBmZ7dvV
 i0sLdilJtaLsj3w6+GgP8/jdOVuRdO0d7WsBUm+dEM25vmi1mgzR2gKzYbAQwM7GrfT609btr
 5Lf3m6pG3U3WwoRNNQ+937T3reg33aowgfX09nAv0VdrwzLM6j01ipLvhy53RK0xzwc5gFae9
 ItlOxOZx3V7JZNl6BQtIpQ8aIV2clRu2CW07RG5PCYDytpTThVKbRfqIofqf23H2s93mcBpC9
 O97KjgGP4bFJD56420cNEy6eP1BhbTzAhtvqDE+K3H5LBI/LTqKsQRgmacXteJ4T3C4Pj1+PS
 q/sJOZLAaVvIqkPaiONFBeDcA+Ggdgb74osQ1riqkhfGakRLtHbf387SvHAf5f2Va3/sOrNUu
 HrLi1tdvnPHZq1rt+UB+XQZBMtwsigWdzeCu7pi9/imM4BTPVn9Uf9dcbW34XlAhAisPai3mZ
 Tgijo7r2QWg+wySSYJH+Kzkvf4oo+blpeAP9Sq6Bi1XlIlu/2FPGLJW0/PpZ5nJgGDlFmOy3w
 Crn4/LagfgUnzhfjAkpIC9lXxAixv+a7VE38kY1SNL4I0pBJrw9Q5O1GX1gFqDUgQcOLKdssL
 PmUMATYR63YT39tMDh5sUmEliZDvGmRB0/aLiB3T25F56w/5UYLYDPexoA48Iv1t+semFaEu/
 gFHKC00sGEw3zFzmTLNohh18WSpRFXBxxA5xw8BZyQbX/5lDtRNH7xgSw8Bq+AJDew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer already knew how to fast-forward instead of
cherry-picking, if possible.

We want to continue to do this, of course, but in case of the 'reword'
command, we will need to call `git commit` after fast-forwarding.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 50e998acc4..23161f593e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -860,7 +860,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, amend = 0, allow;
+	int res, unborn = 0, amend = 0, allow = 0;
 
 	if (opts->no_commit) {
 		/*
@@ -905,11 +905,23 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	else
 		parent = commit->parents->item;
 
+	if (get_message(commit, &msg) != 0)
+		return error(_("cannot get commit message for %s"),
+			oid_to_hex(&commit->object.oid));
+
 	if (opts->allow_ff && !is_fixup(command) &&
 	    ((parent && !hashcmp(parent->object.oid.hash, head)) ||
-	     (!parent && unborn)))
-		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
-
+	     (!parent && unborn))) {
+		if (is_rebase_i(opts))
+			write_author_script(msg.message);
+		res = fast_forward_to(commit->object.oid.hash, head, unborn,
+			opts);
+		if (res || command != TODO_REWORD)
+			goto leave;
+		edit = amend = 1;
+		msg_file = NULL;
+		goto fast_forward_edit;
+	}
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be a "todo" command like
 		   "revert" or "pick", the second %s a SHA1. */
@@ -917,10 +929,6 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			command_to_string(command),
 			oid_to_hex(&parent->object.oid));
 
-	if (get_message(commit, &msg) != 0)
-		return error(_("cannot get commit message for %s"),
-			oid_to_hex(&commit->object.oid));
-
 	/*
 	 * "commit" is an existing commit.  We would want to apply
 	 * the difference it introduces since its first parent "prev"
@@ -1044,6 +1052,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
+fast_forward_edit:
 		res = run_git_commit(msg_file, opts, allow, edit, amend,
 				     cleanup_commit_message);
 
-- 
2.11.0.rc3.windows.1


