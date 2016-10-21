Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D50920987
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755277AbcJUMYL (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:57523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754909AbcJUMYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:06 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lm3H7-1cXAjI2reD-00ZdjW; Fri, 21 Oct 2016 14:23:53
 +0200
Date:   Fri, 21 Oct 2016 14:23:52 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 01/27] sequencer: use static initializers for
 replay_opts
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <412aae8842d0a33e1da72107540a7edea810fd54.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JtyNz5mLXJd4Vt7otYP9RyvtsgxzC3ZtyRwlR2w2ve7ZEczXseu
 z1ZwmSN3IdoB1ND10Toxes5X1xuwNVihM4hMEMgnlR/wLF3qtrAa+mGXiLixIIhbyDYWuXO
 /o8OZrPBVbgF6+tez55uECh8cxVFsZTrYlWK6WD9Lbn9C45UUnBMJm0YPOfN6f85MHRteEN
 lBgekJfGD2BkubsIeC2mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iUOvlQmwce0=:9VBeY5udtf+2i67H+CB7dm
 ak4aIyH83RVTuqffft1sat/m/ytPzpmldWsFetpHyQDsh70fc9ZJwfSKazTQz61Klk1XhtUKC
 Ti3yAI07yNsxMx0z2FlH5dEuUwDG9k3/OyThL/4x9t1bHpTEke1cc/WggED9iuALiV4DXRxtr
 Hs9jPdKtbTRFsudYHteAdU4nAjZXks9/xWG9D3vJ+FdmzlKmaHJ0geIvq8m3x68mwZhtG6Dza
 L/SemfIb3cHIajYSeehZGn2usneA7guRmLasuCQ0SV/YIMf5w12vIMHivfjK4ctoqvwFmlj5z
 VoHxXjXbhzqAAxuWCPN6Aqgr8NfhwLHOmCa0/91h8GnILm48JYgR+cZs9ay/GhPGLUJX4nadU
 O739w8Xhm00XVbAd6YF06GdsazwUQ/PUPVCUkOjBTjXlPt7FV+JgQO8B6+gXdcfxQQogHJE6T
 3++On744WQ5E5f/L1Z0h/eQDaDyjDGm0vs2dOaTCVNFfM53uXyze6CtgGJNuunzo1nQPRPB2u
 EUPnLB2yzHbpCPbvnGhlEWyH6s+S9acPfXYo8sJVbsFr0qWQttE0eayzRyYz/iyD/TRoK+chY
 60GoIBA9YR9UL/YqtI2L8GhznkLXYFESkiK4TWCflwHI8Kg/cjE9tPn1n9cmbXzlZ9GpORJGE
 Y8gAinzgd6qJML2bVnE0Y8WDXEPsLViosXIFegEu0HIpzrM1cvM3nveRvBuJpca2OxbgwGeyO
 Ci3yhjBPktn9GZKQF+aFoznQtzxt86jSgBa6PrGGEvWKz4tT8w9K9P8Im1BrJxFBHiSahv2uA
 8YnXFBq
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
2.10.1.583.g721a9e0


