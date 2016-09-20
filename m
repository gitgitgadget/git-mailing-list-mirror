Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033EF209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932825AbcITTEg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:04:36 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:38114 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932624AbcITTEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:04:35 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id D9D5FB0054B;
        Tue, 20 Sep 2016 21:04:28 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/6] i18n: commit: mark message for translation
Date:   Tue, 20 Sep 2016 21:04:27 +0200
Message-ID: <1579845.fzuqLqrEJ8@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.25.0; x86_64; ; )
In-Reply-To: <xmqq4m5begxj.fsf@gitster.mtv.corp.google.com>
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt> <34292875.FKhN8jTqO5@cayenne> <xmqq4m5begxj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---

Instead of distillating change requests, I'd better do it by myself. Here is the reworked version of the patch.

 diff.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index c6da383..494f723 100644
--- a/diff.c
+++ b/diff.c
@@ -55,6 +55,11 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
 };
 
+static NORETURN void die_want_option(const char *option_name)
+{
+	die(_("option '%s' requires a value"), option_name);
+}
+
 static int parse_diff_color_slot(const char *var)
 {
 	if (!strcasecmp(var, "context") || !strcasecmp(var, "plain"))
@@ -3325,7 +3330,7 @@ void diff_setup_done(struct diff_options *options)
 	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
 		count++;
 	if (count > 1)
-		die("--name-only, --name-status, --check and -s are mutually exclusive");
+		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
 
 	/*
 	 * Most of the time we can say "there are changes"
@@ -3521,7 +3526,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-width' requires a value");
+				die_want_option("--stat-width");
 			else if (!*arg) {
 				width = strtoul(av[1], &end, 10);
 				argcount = 2;
@@ -3530,7 +3535,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				name_width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-name-width' requires a value");
+				die_want_option("--stat-name-width");
 			else if (!*arg) {
 				name_width = strtoul(av[1], &end, 10);
 				argcount = 2;
@@ -3539,7 +3544,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				graph_width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-graph-width' requires a value");
+				die_want_option("--stat-graph-width");
 			else if (!*arg) {
 				graph_width = strtoul(av[1], &end, 10);
 				argcount = 2;
@@ -3548,7 +3553,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				count = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-count' requires a value");
+				die_want_option("--stat-count");
 			else if (!*arg) {
 				count = strtoul(av[1], &end, 10);
 				argcount = 2;
-- 
2.10.0


