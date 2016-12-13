Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02DB0206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934217AbcLMPcw (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:52 -0500
Received: from mout.gmx.net ([212.227.15.19]:62162 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934007AbcLMPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLO9y-1cHNHi114E-000ZFq; Tue, 13
 Dec 2016 16:31:40 +0100
Date:   Tue, 13 Dec 2016 16:31:39 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 22/34] sequencer (rebase -i): run the post-rewrite hook,
 if needed
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <431b268b4828c6c1c5fc9bbadb38ad5f45aa9304.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hEPEDIa3+B+Wg1pJgLZMG17r5+4CBQ0zJ1aoDo0phY9UkEmJQDH
 nVXlMIvY1+WLizNg5Pkizzwvtc4C4MExbhzYB/iaSCtFwfnTPr4C/3FswNeXDa6x3lAzr0L
 JPbKaQWbPSA0pUY31bSRQxaPX7zd8A2CZ5jAlIg8pBMStRDYIyCF5M1xK9j5ZsXBXlIM3xV
 gWHm+TE2rXMhYhhQ1lScw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZDuqz4Su5ug=:4qyU2GyMnApRd7K4jqOxm4
 aYuLAiO6hFkm1AFnuppKaaQ7M5BQqtIEyaiK+IYzQmjD5PrnaP0f4nm42C0fzytiQ/9axeV6e
 7O0Duk9ismgKMxGdyhKhdPpMbGXRbAFZQMmgLYAzKYEePXhByCsjGm/yWUf5KgG4hva+jov3T
 uRSNuy86uh/fNt6uB/FT9955s/C11PAziWrZ1ZOlQvPM2oyodRYCwbs7qPBNCcHUEsFfmGQNf
 RM0tLnDQCnB3ZIbTJj+rRCOfusBr+Y1E3ykl51SKKoUwh4MBvaznreVsaEkLiPo7y3czzcS4/
 wrpLNbD0MzJ3ZN4OifpVHVebX8l5vo0NjSEKd7z0d+1h7vA33YZSfDll/234Nq/iyS2eNaXke
 9pqpXlc/HxcYlvGk2cRwyZtHX5dGz/zcnG6r70G/yeeBVYr0ET8ngtfdVFttw4yAbac7o6i2t
 CKRa07z8joAap22y0Vl91Zd4VGud3cq5mpQEZFE4azOEs2hDR5g9DKgYgZCTngEvH40EPXezQ
 asvnaR3oNTG2PMTA1KN0wXPtxlZVzxXExlEKO9GsB7ih1Y4bVkCMPoC/4z35F+ZVcpMLIOInt
 iBAPUJAnI2btoxSdvsIyDtrMVstim7ZsJ1MjXXA/hqhsxtuxPl/qj1lMB4Wu9uXm95velgjYp
 6xOEqDuh46BVT6S9KaG8na4D+UAx8uCD5F/4l/M6t5Rk/Aky3IR3jQ4E7SbPBR1EEkfUuPUsl
 XjPfBeoo6bMrB/B93TxbJdUmcQKYmD1zQNzvRlOeMx8RNHVBLxtNRRXDl9oD09eZrU/MI8Us0
 7u491/D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 0233999389..cafd945e83 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1947,6 +1947,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
 			struct child_process child = CHILD_PROCESS_INIT;
+			const char *post_rewrite_hook =
+				find_hook("post-rewrite");
 
 			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
 			child.git_cmd = 1;
@@ -1955,6 +1957,18 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			argv_array_push(&child.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
 			run_command(&child);
+
+			if (post_rewrite_hook) {
+				struct child_process hook = CHILD_PROCESS_INIT;
+
+				hook.in = open(rebase_path_rewritten_list(),
+					O_RDONLY);
+				hook.stdout_to_stderr = 1;
+				argv_array_push(&hook.args, post_rewrite_hook);
+				argv_array_push(&hook.args, "rebase");
+				/* we don't care if this hook failed */
+				run_command(&hook);
+			}
 		}
 
 		strbuf_release(&buf);
-- 
2.11.0.rc3.windows.1


