Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8574020989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbcJJRYu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:24:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:54730 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbcJJRYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:24:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LsUDg-1arfji0WIC-011wGu; Mon, 10 Oct 2016 19:24:22
 +0200
Date:   Mon, 10 Oct 2016 19:24:19 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 01/25] sequencer: use static initializers for
 replay_opts
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <5c4c86f0ea7ee4a9bad15e48f72b8fe5baa72dfb.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qn+2xuSQZ5lkqMlrsHPZzylbkPtRGIFxja4dSeVZVJEWZ9iQ/aE
 htgGf0m6XL4IGj7x09ge/cFpma1G1Cncsa8WBaSIvv7jtaJcCCCDnjXPf2S0zvPkPdTli2h
 gp3CMS2Lw3S5F9nPy9zBZvXxQRT3B/woUa7O7dfa3J5jT85nbuPb3cgDgyGUt9bS9b+2/4j
 Uy1DTMXdBqIR6eljCaOsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t/akkZYWWbg=:6byo0293qo+wNs/OxLgePZ
 OJgxHmO/QZcusfmQK8Qomo41exHNiuswIViHuVpQLRsIcZwk/dXsrQerPsM2z08Pm2zwrhxV4
 1JKXq+dLaZTJqABLiRCFJJtviNWE//HzvNafY2KVteAW0vhp88n6lR6WLztDwDBHIo+iP3ZL8
 VoBtHPRv2hmK749pCdDuFqeNc5dHDQjcDUxB68nx620DzQz54sm/cwIjQgE4DPLPNKkGrMjpD
 6NupyIuA7urx1Od6dIUJi0SWjjsv5RN/tsDDv3ArTZkjRbyRqsPQui+fx76ODoMwY6joUGEFS
 lDjNxaKm9JBXxBO2vHR3iW1AeZFbByy5p1nbXddXBwPz+gw1lisUXeOTkZMrS22xTpKzAtRme
 INdpG59WIwx+hvBVlVnpjcWgOnkqqySvMwTiWqJ2q352Ov43ySY4JUtbunzIPgFbW/9i9wsA4
 TA7dEVnpTFLpNmNpkcwZiToJJGdTmq50mD40x9b8MrAZHZLA+qTZo3w+Tm8PzOOEsBKk8RuGP
 9LjDDt88Djr/qidSCBTyGsPIrMMG/xROJD2Ip8NtvcSITdpKpPqh4iPj3pSHWvWrjPtovyM3r
 8qJ+SwXy/RP6+dDPNn2Cx+x7BeQyHQisJfXuhi4XQyTmBMuUTnTZ2x6DooHvd+dKO8MF7mjls
 u6KexoxXuzgsINEfhN4njcT7iyO6nyDruDplfE0PwSeiBFMVNn0RZMolRy5Y6lSl5qQfKLJ7q
 ecqvElMjwECif1bgSJ5ViJ0EPu23J7oRdEWoSHepHOEvxFeA1qeYEZ4bSr6nHeZ77kVaydJ+p
 zJIj5v+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change is not completely faithful: instead of initializing all fields
to 0, we choose to initialize command and subcommand to -1 (instead of
defaulting to REPLAY_REVERT and REPLAY_NONE, respectively). Practically,
it makes no difference at all, but future-proofs the code to require
explicit assignments for both fields.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/revert.c | 6 ++----
 sequencer.h      | 1 +
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4e69380..7365559 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -178,10 +178,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
 {
-	struct replay_opts opts;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
-	memset(&opts, 0, sizeof(opts));
 	if (isatty(0))
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
@@ -195,10 +194,9 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
-	struct replay_opts opts;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int res;
 
-	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
diff --git a/sequencer.h b/sequencer.h
index 5ed5cb1..db425ad 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -47,6 +47,7 @@ struct replay_opts {
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 };
+#define REPLAY_OPTS_INIT { -1, -1 }
 
 int sequencer_pick_revisions(struct replay_opts *opts);
 
-- 
2.10.0.windows.1.325.ge6089c1


