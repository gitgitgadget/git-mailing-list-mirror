Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB61B205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756293AbdABP1j (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:27:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:55328 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756282AbdABP1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:27:38 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvPgd-1cWdFx2IZn-010gY5; Mon, 02
 Jan 2017 16:27:22 +0100
Date:   Mon, 2 Jan 2017 16:27:21 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 13/38] sequencer (rebase -i): allow continuing with staged
 changes
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <7d3fe6850ffbf9252199c3d190e76efb18afeaca.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KgIihQ4ZJOfivPx9seWBGwpHdhbA+R3sj2MrkJ6jVH2xkCV2+d+
 yXUWEcUHNuwKVnZR8xcKdwu37c+QztSRTVsvqOA9Dx4VK0mtSnqs1M/rKNQISnI2OJ1I8Xs
 xa9Z7SjEvRFSfIbDyIbSuG5+ll4i8cwDgYEaTXpxAwZ5XWq8nT2T0WFz9zdiJX0OWjihZzI
 r9a5/O3YGh4iiyqvW4FIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tfQlb4d6Q6Y=:ERacOSBeNfv4iN9SAWcJM8
 a80OQkLQMJbt2weOKFqCPhGzPdJm7oLdAKokD4MDVdOu2hbF022qxrSkTSwfQFBqnAJ6ZgnPA
 SSLqf+tyySgqSPfQdzd54srMIrj9qjuvResFT6eMZzD4/s19YLVc6OVO2n+YwQ/LOoicjwf79
 TzduoPHICXrIZuMC/jnw+UdRxnMWbIeaEF6qI5cnhDBgM6rrUnzaXftYbMFHHkcZ8N/n/KYDF
 U0Xeb+/ZP9w1RRtx4YF+QE8GgnYSmdGOoOfE+I7/kjlm8ArhHwZ+j8fXivSNpi6KCzuD0+ZV7
 JmGzm/6XpeB0pKjCWqC0Iv71mdHox/PrnVy/AMOgdyx63QffYgmHuF61xmxYlYLaX4ZMEN4/b
 9N/VwBdbeY5BXfJFUiSqcNotE5sfmf0f26t/Hxn/5+8IIhRPIZ7bR29fKjGuh05yP7ULRuNXP
 xYULA050TNAIajKPhqp/UKaTne6SmrzvNS1QygImQA4BpZBUGIcsXP565bJTFKvEq8vQrNTki
 jchVOyGDoPp+mp3vhvEaW8RbYXTiNAHYfMCbflL3pZhbREti9WW02JfGfi8rFniRMChhHRJIr
 rLmKjL/jpXZsmT4ByZ9DU6H6XHBtBkchi+aNTIhctKHFj5gQn8CEAGPPLjlAdv4p2RywUpBs7
 R8puPCKpEvqdOzhBbkcyf2BDfp514M6GDia7wDQLwmv4bPcDpK5ZIOtXkuTohQgXuIy4gJ4J9
 tU6q3/52Ri8Pinn/o+qtV/f6nwS5R/BB2rDSXGlaGix1rGy7JQJb/ud3saRdDsVwX/zOip4Jf
 RgO7mGDlTrFCdHgreR5F5rsBuS82GMAKc5nhE4zifAAzFcKUUQ+4dF3NIYU10I2A5zL+09d1l
 CuNttX+Zz8+6KgSfObaglrTWTX2SzmJ36+IgbLPFT8niEXry2tqNwyK3tJNquK0YXdJcCrT1E
 9fp4xRSFa7aRelWEX+5Al3iz3C6HgJL6aV/On1qCisX0MjMin4I7zETCwQ/oHRKT4PkOkoD+o
 /HftW5xoR/6r++6rMIDDQzcDacFGSx3pAlqm3jCswmJ3tVzFhlfOmWGZo+Z6B1ofYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an interactive rebase is interrupted, the user may stage changes
before continuing, and we need to commit those changes in that case.

Please note that the nested "if" added to the sequencer_continue() is
not combined into a single "if" because it will be extended with an
"else" clause in a later patch in this patch series.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 9913882603..69301fecc6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1826,6 +1826,42 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
+static int commit_staged_changes(struct replay_opts *opts)
+{
+	int amend = 0;
+
+	if (has_unstaged_changes(1))
+		return error(_("cannot rebase: You have unstaged changes."));
+	if (!has_uncommitted_changes(0))
+		return 0;
+
+	if (file_exists(rebase_path_amend())) {
+		struct strbuf rev = STRBUF_INIT;
+		unsigned char head[20], to_amend[20];
+
+		if (get_sha1("HEAD", head))
+			return error(_("cannot amend non-existing commit"));
+		if (!read_oneliner(&rev, rebase_path_amend(), 0))
+			return error(_("invalid file: '%s'"), rebase_path_amend());
+		if (get_sha1_hex(rev.buf, to_amend))
+			return error(_("invalid contents: '%s'"),
+				rebase_path_amend());
+		if (hashcmp(head, to_amend))
+			return error(_("\nYou have uncommitted changes in your "
+				       "working tree. Please, commit them\n"
+				       "first and then run 'git rebase "
+				       "--continue' again."));
+
+		strbuf_release(&rev);
+		amend = 1;
+	}
+
+	if (run_git_commit(rebase_path_message(), opts, 1, 1, amend, 0))
+		return error(_("could not commit staged changes."));
+	unlink(rebase_path_amend());
+	return 0;
+}
+
 int sequencer_continue(struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -1834,6 +1870,10 @@ int sequencer_continue(struct replay_opts *opts)
 	if (read_and_refresh_cache(opts))
 		return -1;
 
+	if (is_rebase_i(opts)) {
+		if (commit_staged_changes(opts))
+			return -1;
+	}
 	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts))
-- 
2.11.0.rc3.windows.1


