Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622E920195
	for <e@80x24.org>; Fri, 22 Jul 2016 12:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbcGVM0P (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 08:26:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:58704 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbcGVM0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 08:26:05 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M4002-1b8dAL1xWU-00rZlN; Fri, 22 Jul 2016 14:25:51
 +0200
Date:	Fri, 22 Jul 2016 14:25:49 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v4 13/16] merge-recursive: write the commit title in one go
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <c0fe32e181c0467ac20fe5a80d78781ccad83591.1469187653.git.johannes.schindelin@gmx.de>
References: <cover.1467902082.git.johannes.schindelin@gmx.de> <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4gWGJNFO7s640eiXU5oUxBUq0Wo/0LANEwuCt1hOhD5i1XLfsIn
 Pn+bzQXxvOJi7dLTmCQ38DThtixDuL2VdosEbC6lELNV8AbsnHwd8UAbjc+LTxr9Tr8P7uI
 EPBOE66ZwQHew8iQAvRrcDcE7wDpvMOXLROWHSPrgaTiREOBi8KuuYTNyvdgORq5FNF6tUp
 kMuxJJDIq1hkSa7dKzsdA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EEMH6tThYuo=:iAI4YXh1Xyxx6B1bJI+UN9
 wgGc2KbuesFLEXQ3Cybo2H43wPlrlcE+0+Fygm72yTaHuS6CGt3Dpe+v2sNjUq1O7JibLZtvY
 EwVkCiefFB3yO3f8BFpFdkcWjg6Z4HOKy05XsPeKEjYTAtt1kht5HqAeKjScREG8Pf4yAiIwz
 9yC/6Tln+fpmqWLgMuGM0u4gvuhmF5K1yk74NUDoC4eknebkFvl4mFsk7wJSQ1DXEjGOt9iJt
 Pz4E25rhcKA/ZjNCt4BnX0p+1P8gLK4ZupBwobxPf3ca1n4WYESG6KKNZRJg6euxEq/Ol5k0u
 LYhb0cTeFsUk5+sT3yc/1FJWg+HzQR35AEQSzhGNrVBvT7zGKVgAR/Oc5/GtqRabA37BVGg1J
 frfrkl2cqFNcZQbTyySgIyVvi9UZoX7EEAwvl3kk8eaD86G53yRWAZO4yhqXAxP/pdwblGh3P
 Zaiw6IbSC08UJcKT2qKtlGOfl0K0EAogSkcbcxXFHEOZ5TVMpkxOOwldFDltcsSnRkgCAD/rk
 47t+cZqFeKmc6r8kIDP0nF4/Ax4k5hbq7Pz+4mzoX0+NebxHdZ3vNBjcPlXDXEUFvRyj9kmLr
 i91uyWgGblY+niE4QWpc902sfKjVC8t2fWvZ8kWs+wB5l//CA6MPmMJBaJ9h5PtLkvgT10GaC
 qIYOWRVUwp38Mpdk4TFG4+TmiuwZMWyLvwqRvad7Bc3eNOFCQNa4IwdvVlZchofwesIdtcTAt
 2FTaAm5BAcMQ16zsKo0N/F2FTYvNvdhe5jjDfz6XOViN3pB7OwfguaItEl5751ouHPA5bk8oS
 Eqk+pft
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In 66a155b (Enable output buffering in merge-recursive., 2007-01-14), we
changed the code such that it prints the output in one go, to avoid
interfering with the progress output.

Let's make sure that the same holds true when outputting the commit
title: previously, we used several printf() statements to stdout and
speculated that stdout's buffer is large enough to hold the entire
commit title.

Apart from making that speculation unnecessary, we change the code to
add the message to the output buffer before flushing for another reason:
the next commit will introduce a new level of output buffering, where
the caller can request the output not to be flushed, but to be retained
for further processing.

This latter feature will be needed when teaching the sequencer to do
rebase -i's brunt work: it wants to control the output of the
cherry-picks (i.e. recursive merges).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 3ef1e2f..2bc41fe 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -191,25 +191,26 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 
 static void output_commit_title(struct merge_options *o, struct commit *commit)
 {
-	int i;
-	flush_output(o);
-	for (i = o->call_depth; i--;)
-		fputs("  ", stdout);
+	strbuf_addchars(&o->obuf, ' ', o->call_depth * 2);
 	if (commit->util)
-		printf("virtual %s\n", merge_remote_util(commit)->name);
+		strbuf_addf(&o->obuf, "virtual %s\n",
+			merge_remote_util(commit)->name);
 	else {
-		printf("%s ", find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
+		strbuf_addf(&o->obuf, "%s ",
+			find_unique_abbrev(commit->object.oid.hash,
+				DEFAULT_ABBREV));
 		if (parse_commit(commit) != 0)
-			printf(_("(bad commit)\n"));
+			strbuf_addf(&o->obuf, _("(bad commit)\n"));
 		else {
 			const char *title;
 			const char *msg = get_commit_buffer(commit, NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
-				printf("%.*s\n", len, title);
+				strbuf_addf(&o->obuf, "%.*s\n", len, title);
 			unuse_commit_buffer(commit, msg);
 		}
 	}
+	flush_output(o);
 }
 
 static int add_cacheinfo(struct merge_options *o,
-- 
2.9.0.281.g286a8d9


