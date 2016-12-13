Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627B92042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933533AbcLMPhE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:37:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:55803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933362AbcLMPhD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:37:03 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbPPQ-1c0O742td6-00ImhF; Tue, 13
 Dec 2016 16:30:26 +0100
Date:   Tue, 13 Dec 2016 16:30:09 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 09/34] sequencer (rebase -i): write an author-script
 file
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <09c2718e119f809093794410ae1a738c1cd122d1.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:272nkv9o50fwaQFjfcW2zYecurf0Fd7NXG2ane2WclzBfhQIL9n
 N55TuAJ1FFB4meiMESglmkCCy8HX0ZIvfctHTFDPw93A+zpXzqPB7DNNA5J7I399vonrNN5
 VPKFO4/olc6GsT6vK72pUM6Bltnj0LMQ9UU2KmyuY9NN9JPzbcB00Z5Bdok2kiOyzFCh7tG
 XjSqRejlW4z6loqZo4G2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aYw5BxK7sI0=:yjFDbt2wJHwPxlpKGE6GAB
 +EVcNzF24fVQ98RhknZRCWZZZ/Kc9oIpUYVQCWOdUzNxO6RrUrCiNQF/wDVOZ+GNFWb68rBl7
 YOdiQzTI2Pf6IHxBRS77eUfRcJH5cTsSEzpkV3OMQOqh56fdIC8Z9fxHgIeypugMt95voEzBB
 0RK5A5Iogwk3sb09QnzigHZunpAtx0/zmbxQjHfMLIg4gYaOYyGRxDn56JI23Bzuq7v427Tqf
 xZbIFpuK/9ImK4rLb7f2vAfwkzaIzEC/NVOEdafc7kXg9xaC5mXVZIT3olqBnnWtfLbn30F+l
 hYJWV0WamCVBLPHK4eb9SIUk1RP1GhxU3I1U2mv/0BLGVD2/KZxx/4yJPJscIkCPRvJ+C0hMZ
 16UIVF/UrV7crQOPROXRLR2PXPYqX41Iollg80N77IMDBHemKCcrDTZDXjrMvRcSbZxATxF7w
 z0sYsB6SJ0Q+Hlg275NxrIcBcql36BwnRB2kff3DIvn6LRMYXzq3jVBTayBvX3uCvtOjA0258
 Zgg1xlxVJyLzDRY+HUoNCcnSARFUSX0lcOX9KUlTc0z0dfmG7rRLaJ7amZ0JoSOLh9VY1PcBH
 JdZcwG6ZQUVXuNlydLzG8EOvLcUFQELQKGYr+Ry8cez0a09dSyKuVtrVThWUkQtz5FNJs1sCd
 nh2Y2Z4MuqjTyA3gyfeklrBqSyx1QAhyMxAYCn2yfqxmpbKonkp7clar2uvDlBhuiLJx0ACLw
 RrWgWa6j4sbd8Eu8+eIXD0WTki0EfOVrbOHq9mfflj8L9KsqHhN5C4/98DUoMU/UkE4xUfP+Y
 IgMudZB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the interactive rebase aborts, it writes out an author-script file
to record the author information for the current commit. As we are about
to teach the sequencer how to perform the actions behind an interactive
rebase, it needs to write those author-script files, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index e443f4765d..80469b6954 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -515,6 +515,53 @@ static int is_index_unchanged(void)
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
 }
 
+static int write_author_script(const char *message)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *eol;
+	int res;
+
+	for (;;)
+		if (!*message || starts_with(message, "\n")) {
+missing_author:
+			/* Missing 'author' line? */
+			unlink(rebase_path_author_script());
+			return 0;
+		}
+		else if (skip_prefix(message, "author ", &message))
+			break;
+		else if ((eol = strchr(message, '\n')))
+			message = eol + 1;
+		else
+			goto missing_author;
+
+	strbuf_addstr(&buf, "GIT_AUTHOR_NAME='");
+	while (*message && *message != '\n' && *message != '\r')
+		if (skip_prefix(message, " <", &message))
+			break;
+		else if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
+	while (*message && *message != '\n' && *message != '\r')
+		if (skip_prefix(message, "> ", &message))
+			break;
+		else if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
+	while (*message && *message != '\n' && *message != '\r')
+		if (*message != '\'')
+			strbuf_addch(&buf, *(message++));
+		else
+			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
+	strbuf_release(&buf);
+	return res;
+}
+
 /*
  * Read the author-script file into an environment block, ready for use in
  * run_command(), that can be free()d afterwards.
@@ -974,7 +1021,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
-	if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
+	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
+		res = -1;
+	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
 		res = do_recursive_merge(base, next, base_label, next_label,
 					 head, &msgbuf, opts);
 		if (res < 0)
-- 
2.11.0.rc3.windows.1


