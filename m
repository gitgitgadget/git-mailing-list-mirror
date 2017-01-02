Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7D1205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756334AbdABP2N (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:13 -0500
Received: from mout.gmx.net ([212.227.17.22]:53829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753711AbdABP2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:12 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHLNn-1cJLYM3AXb-00E3d2; Mon, 02
 Jan 2017 16:27:57 +0100
Date:   Mon, 2 Jan 2017 16:27:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 18/38] sequencer (rebase -i): leave a patch upon error
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <59d8be697e7fc27caf255c1bc5c089752694e29c.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9nC8O8n8FzoUahFauXiRgbyBnCle0SKHSx654m29kMUweE1cRed
 O6Lg0VjZgD2I7Zo4HaVH9H/AhL5qqnC4WBOHbzHRNkqIRFNs+BF98ionXtX9coPEzGb4Xhl
 lrop+sn0UvjmaMBHndAFaSerXCtG6zRsXr09aJO+pgPCI/q/kx9Zz5XIkele5m49aGtFDBJ
 aTRvMYJprO3Fbp+N5QjXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uOgKWZ+ffPY=:dXbXhQJUG1+feY44Nx1PnY
 FAqR1LvDepEyyN1qarcIYpEJG8XYAnmgjMPZtQ1/6WtJYMMp8ccOBBt8Wvm28rFTuW7RqUPj3
 9BvTc7lS7MMuaY8hFiVUMuajAe7Lue/9x3kCSk9CgCRMh+0nrYf+iJZ6pcsV7cPSgL4dHD/oa
 CBYir9anxndmirKApWNnk8VdNOBd801ySw5ju+b8CAGq1PfE3/iaDanF61Y3RyyYcBoBa7KpV
 Z2zqYY55JFVcSyV1e+CSmjT2BTANJ+jD/KRjziSt9zQqUiGCXSMc1AwPDEjDiAbSNcVe2JSsj
 Zu3zFfKauMd7EKzxQpsJ0AtUzfdrmoKLdZZ/xSnFXCo093t5YqtFtWKJP9QClbq5D9wWfrsXZ
 dVWqjMBSZE4Ae/V4D+REGY3pPznFjZRsExdXaruSSaGHqiTO02Yki1Zk+PZYNXnp919GGFi+s
 JbKFXmzBR1f/lBi4k3UXhsFoAhctMrqGZ7YCnrUYsb6O65cTDvWRfZxmMn3XDWHedzX1EKGip
 JErnljAVJR39NSLqiSAJJPFQ+LQGTn874pP3vx4HnQOx6agHh9OQ4DkMh+z+CgAv+Tl+oZxGc
 SN7ZX/r0cHKDQdEv3+KBxHysvlko5GCaHFv81+rzOjJiqW0OHgzHeTqk9Ta1X0L/I8iDMUszm
 t4s1r93+WJp616ru2yd2aWlP+8kMkd6n10FXm7HsDfeqohY8d6xEugry6KMKA5dlx7xnM16eZ
 77FT/vIH8IPBTmfP3dGgt3QttSiG9jAts2fPdM9jzp4YyZrQMgf82TP+2GgU/Jv3YK/jx4JuM
 g27KxO4oAXAxVQCkRkKsytNSYDozWHyLSHbvep2wYSD8RFN0QBr20/irI/BHeTROP7vBiRV67
 fZgNwiHyc1vYMgSP/FHfWjDGoJfCMipeRZIsdvZIWDryXt4a+fibpXBliynssPXsouFICN+2C
 DCFVsxwhAssIZB5CvqRi8cVbTSY9oiQM9I/oFAvVFXt6ykbh+TdWxu8ZsAnZYpNV23ewknLgS
 sG2deXT3DMVieorsWJ0yUibwhxdxxvPiPuoTs8JZsVnxxaxJ3Urb7TwEnH3OBx/mgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing an interactive rebase, we want to leave a 'patch' file for
further inspection by the user (even if we never tried to actually apply
that patch, since we're cherry-picking instead).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 80b2b2a975..a2002f1c12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1769,7 +1769,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					intend_to_amend();
 				return error_failed_squash(item->commit, opts,
 					item->arg_len, item->arg);
-			}
+			} else if (res && is_rebase_i(opts))
+				return res | error_with_patch(item->commit,
+					item->arg, item->arg_len, opts, res, 0);
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
 			int saved = *end_of_arg;
-- 
2.11.0.rc3.windows.1


