Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1091F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932830AbcJNNYe (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:24:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:54435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932483AbcJNNYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:24:06 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MP1PX-1c1LbA3qQJ-006Ml2; Fri, 14 Oct 2016 15:16:12
 +0200
Date:   Fri, 14 Oct 2016 15:15:56 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 01/25] sequencer: use static initializers for
 replay_opts
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <a0441930fb5d0a0483a81dc6895056ca05336dbf.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0CuiPUrguZi+nCvJfOj/OvJbFKabnC8dhTB5IGOaA2CjGBMK6pN
 r0d5t1AFj7ZEtqN7BOi6QK4u813ex+LNZ9hQN4EFy113pw8tmI+ioVN3L4M52/no0DMpY89
 n9T2WEv/RweKdxjTc2W4zKEWw5tCR7PLVx9EwYMUIwcpNLTRUOBWUbXwVdudwLG4KiX4Hsz
 bgK2uC/D/Uckiki6PvRNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kfSdaxnzJDE=:7HeEg3+Y+56Ni8RcANtje3
 V89BKdUlcnl+O1RkT3Ehb39NekfNUp5mwoLpSs8hAHwJl2Br9jMMMl2gMVnMzAOvhhr7QmfnB
 kUQGNGbTt62YH6/UJm48UfSjdI6WOOr52WujKWd7lS3Fuow/L0Cr+F+22CEIbGijHhs+b413e
 oP6HQZU2MmK/kw/FIgDehfdrLYJx+u4ctwH6zzrWq1sqDeZeK6iFdbRQKD0m8TJKa+RoQlU95
 DBi0LMLhiw5unT1kjYWd3Ml6r+8cIVgVhmbOM/RPbbe1mmiIzdCL9vfLP/LSE9sk7wzTUD9k0
 zkPZEuL6dnuIk9IztGTdlNDZ+bfl7agGX2Df4UatyDIi1f9BLpGJKMB3tWdwdLHyGxCV7t5jI
 DNxYECNbcSI3LrQq1239CDdgGXWOg6b/tBtXXy0d0AhaS79NP35dkBEiElVgGO6di/t4UYabM
 jJrhaykVTFUE7FzmrcEyccPIb7F0hjM2pOIjZJ0UNKqmj1hOWy+8BMeXe2kENzL9Jl9zoQhTR
 /DIdINHtZ2hzPMpAslsiMXQOVhjjTR4iO7tU1BfjtkHK62Suhxqhksvn+Riqc9hcxAdhLvk4L
 QIn8PiVSfT1gyOrGOfv/MHTZJoTDSrdvAUOjUPIYR9s31+9P3GlOHdneeQ7/gofYjxYut/Z5P
 F0kQ2vj1McKdn5n8p7RH4denjTjRrT1bXp0uyyVLsBsCRU9m8Af5m5Ft5HVIY0JTNAkjadR6Z
 k6R8pWzGlp6QWb3QC1HmM0peZXcf/UwAiRzjpOgttIEw9AiRMKP1IszAZMYASN8DGhljIRMCN
 ejiQd/W
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
2.10.1.513.g00ef6dd


