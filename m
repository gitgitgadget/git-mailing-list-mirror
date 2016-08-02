Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267F62021F
	for <e@80x24.org>; Tue,  2 Aug 2016 22:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbcHBWpy (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:45:54 -0400
Received: from avasout07.plus.net ([84.93.230.235]:37199 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388AbcHBWpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 18:45:49 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Aug 2016 18:45:42 EDT
Received: from [10.0.2.15] ([209.93.82.95])
	by avasout07 with smtp
	id SNZE1t00223PrXV01NZF7o; Tue, 02 Aug 2016 23:33:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=UYYTc+aN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=BETnLjAs8_MAruiCruQA:9
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH:	ramsayjones@:2500
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] apply: mark some file-local symbols static
Message-ID: <a2b34209-2244-d498-6ed2-4f9fbf9f7ed1@ramsayjones.plus.com>
Date:	Tue, 2 Aug 2016 23:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

I had intended to ask you to squash this into your 'cc/apply-am'
branch, specifically commit 4d18b33a (apply: move libified code
from builtin/apply.c to apply.{c,h}, 30-07-2016).

However, having read that commit a little closer, it seems that
you deliberately made these symbols public. The commit message
does not mention this issue at all, and it is not clear to me
why these symbols should be public.

What am I missing?

ATB,
Ramsay Jones


 apply.c | 26 +++++++++++++-------------
 apply.h | 14 --------------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/apply.c b/apply.c
index 96f02fa..ec545f6 100644
--- a/apply.c
+++ b/apply.c
@@ -4743,16 +4743,16 @@ static int apply_patch(struct apply_state *state,
 	return res;
 }
 
-int apply_option_parse_exclude(const struct option *opt,
-			       const char *arg, int unset)
+static int apply_option_parse_exclude(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 1);
 	return 0;
 }
 
-int apply_option_parse_include(const struct option *opt,
-			       const char *arg, int unset)
+static int apply_option_parse_include(const struct option *opt,
+				      const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
@@ -4760,9 +4760,9 @@ int apply_option_parse_include(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_p(const struct option *opt,
-			 const char *arg,
-			 int unset)
+static int apply_option_parse_p(const struct option *opt,
+				const char *arg,
+				int unset)
 {
 	struct apply_state *state = opt->value;
 	state->p_value = atoi(arg);
@@ -4770,8 +4770,8 @@ int apply_option_parse_p(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_space_change(const struct option *opt,
-				    const char *arg, int unset)
+static int apply_option_parse_space_change(const struct option *opt,
+					   const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	if (unset)
@@ -4781,8 +4781,8 @@ int apply_option_parse_space_change(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_whitespace(const struct option *opt,
-				  const char *arg, int unset)
+static int apply_option_parse_whitespace(const struct option *opt,
+					 const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
@@ -4791,8 +4791,8 @@ int apply_option_parse_whitespace(const struct option *opt,
 	return 0;
 }
 
-int apply_option_parse_directory(const struct option *opt,
-				 const char *arg, int unset)
+static int apply_option_parse_directory(const struct option *opt,
+					const char *arg, int unset)
 {
 	struct apply_state *state = opt->value;
 	strbuf_reset(&state->root);
diff --git a/apply.h b/apply.h
index 66ed0c5..010726e 100644
--- a/apply.h
+++ b/apply.h
@@ -107,20 +107,6 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-extern int apply_option_parse_exclude(const struct option *opt,
-				      const char *arg, int unset);
-extern int apply_option_parse_include(const struct option *opt,
-				      const char *arg, int unset);
-extern int apply_option_parse_p(const struct option *opt,
-				const char *arg,
-				int unset);
-extern int apply_option_parse_whitespace(const struct option *opt,
-					 const char *arg, int unset);
-extern int apply_option_parse_directory(const struct option *opt,
-					const char *arg, int unset);
-extern int apply_option_parse_space_change(const struct option *opt,
-					   const char *arg, int unset);
-
 extern int apply_parse_options(int argc, const char **argv,
 			       struct apply_state *state,
 			       int *force_apply, int *options,
-- 
2.9.0

