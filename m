Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB1E207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755598AbcIKKwn (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:52:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:57915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755542AbcIKKwm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:52:42 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MTSrf-1bZRIs1WWl-00SLah; Sun, 11 Sep 2016 12:52:34
 +0200
Date:   Sun, 11 Sep 2016 12:52:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 01/25] sequencer: use static initializers for
 replay_opts
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <666493d3f166d839deb817042ed7d1636b11f19e.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aFn8x4bNPk0l3gGV/fQO1rte5nlhn5NeXwqtZf60BK/bTz/Y6AW
 gfIBxZx7aHZAWFPYrv0Ikaz+cAH3P5gNsMZhwmLJOk5Q0Gc7y0f6TbdRiWRQr+wy/58qP4o
 Z+Ib+wS8Cc1T/sOKTSYiE6TwKPDZ1PKMSFAvzCJgrBUqbAU7GibD8voc7ttQLzFdrUYpP02
 QUMK/YAvwbQlXnL0yA6gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3TsOhq1gJAs=:xkN/eKSPh9o39TmpqzAkvR
 eZ9aRDSSdNXFaDGRQFrdbrXF/vF2EP7kCBQ5PcCV5wtgsKf7Ne7u05a8P0u0A364JMM3AF2Zf
 rmtsoyt3+8+953IVUNaigFMeCrZ5JVZ3KA/M/ID+8b7u/fsqZxSM2q7FG8LH278S84xFXty7m
 39tNrKti2rx/vx3tqQzfe1fVqKNmvGZGVOywz57WRlHHuHaHbzSxazM1IHQBnRAyMSYUxwnxa
 TmBIozEKgPEOAKNT19tqr00rQGSzYrnC/OSCJGLnhKsFhnJbPhsocBPjxNPbsH1y0YFsrDpsy
 tXN0h+rIRqPWuPV3MFz9ejt+Lwrdkl6plDlZhVGXgYgInyxpknVw2HjBkuhJWm5I8N9WnhXGa
 jRpP3cc/anxzhqON0esOVjeOfFBjJQQgNGT5ZIvK8cymddLVxl9I+y0ht/5vBrS2sx23/TNph
 mMrJbpi18NFJZBQEF2tA1Nd62FeMGAounYV7ji64jNrQdJllXbdIKXXEMG9FdVoFagU9d3WZY
 CHIUPY0q/rxhnONQioxXGoCTqGksbLcbpiuL619CEeW8bfoOKIm6rhcud7p0wty3xG0VK78Wi
 3T4MWNgNhT6P+7aISLfJk/ejaP7hrW4cKCEU4WJEhOE6XU4KFDX4xjj2glLE/Q8oS2LvTH6NQ
 +U5WxTPXR/IGlrFXK31p4udBvft4EIQpGtJz7XRsjdUtlt/xU4EO3IDUeYnEFzzGjCZ51icIx
 91jooTGDU8Y2LdVl/cHRh2KasC8FM+NmuNzyZUthqnb95TxBasahW0ppd3aUMOnyJvhv1WErR
 WK8aoHW
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
2.10.0.windows.1.10.g803177d


