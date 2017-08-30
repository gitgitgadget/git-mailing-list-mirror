Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12D8920285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbdH3SAy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:00:54 -0400
Received: from mout.web.de ([212.227.17.12]:51170 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbdH3SAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:00:39 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg7I1-1e8CNn1dmX-00NTxh for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:00:38 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 24/34] remote: release strbuf after use in set_url()
Date:   Wed, 30 Aug 2017 20:00:27 +0200
Message-Id: <20170830180037.20950-5-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830180037.20950-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
X-Provags-ID: V03:K0:CLy0x/ZtebUBbPFTDMpWv8GLrKqAdLbn1uBcYSMtZX2BtDARZ5c
 yQ/r4m1uD8zg/PaG09jvR0Q8+MzJeETPiYk6SDkT1OkgMTUeL/egbEE0hOIhAijieBtLgFK
 gLcN5BK9CLcDjBekXOJgGMl/gyfb3UkqnKnZoMzXxxAw5xIi5zwEPJj1IdPAIlfEFaDIubG
 J2WZ2udJCsenFNZJHnySQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5FAhfi9WYOU=:U5MeX/9VxN/87l7x95QDoQ
 KEYf98EDvbCwrrqof23slTJKLeeqz0EifgTWRbF7DCKMc2MiDbqLOgi3+zKjP9rUTxAX1Gsj8
 sYakgJu11q8eLGGnkblhAwvk5D2xULlEu4CYnhBxNM+/zAlNd63pmIGmsmUWcYEoqDbeU5YOI
 tTiTfS95hcyNeMuL576cb8Pux4S02EJH+QfqscDzW2ks32+O5G9+tU+rqjKdWkxws9JTmuI5e
 YiM+vGpQoorZRAvTLz8xhNxnxstIAVn9pw/vLqz8b9g21iOOUtSzLUBiKnBaBkYHKfWIrF4A9
 1oC2ZELJ6TKpVxtCV+3f/XT8NEOs9GrScsHQih4XL/hzHaj9b/PpQ0Nl2+0LhMo7ygDJxqDlo
 he1cpCDDLO1Yu1Pev6+Ae6JGA2pUkTDJnRjo+FI7qLYxTW4YogRlfYzzYMFLQ6tOuJ6K7CTKQ
 ZziH7p5xJ9In+n/XeQtD1EyXTrBu7KNICaUoXV4sSfpSFZvTfhpaVfzyFiw/P9KLQ9v9yaAmx
 oen/K6D4i4e1K7QNZwK4bZhmaH+N1MnQ5xLkuLEkGJV/ZEuiCDQOggx1Kof2OkYXsvLUYg3kt
 gvvClDLmcQo32LOG1FCs2Lytf2zSAjXpEkLNfkVu6oTXzbSKt0phdX3lkzsV+pzhctY2icbEM
 AIFtSGlKg5r248aORngV73FwYXEefrVmhap9GmQ2QNtuqw9amqcPwfLqvB7yqJcKyVkFktC5K
 An5DUG5mAPOo2093v2ah6IZbQvUm7xdHhOuJdTtn/Yi4Td0/IrXSuNQhoG7TcIMcKU8G8YsNC
 +cGCZS98c3wHmXFH4bvnSqf+U2qJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0a56d7da66..33ba739332 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1509,87 +1509,87 @@ static int get_url(int argc, const char **argv)
 static int set_url(int argc, const char **argv)
 {
 	int i, push_mode = 0, add_mode = 0, delete_mode = 0;
 	int matches = 0, negative_matches = 0;
 	const char *remotename = NULL;
 	const char *newurl = NULL;
 	const char *oldurl = NULL;
 	struct remote *remote;
 	regex_t old_regex;
 	const char **urlset;
 	int urlset_nr;
 	struct strbuf name_buf = STRBUF_INIT;
 	struct option options[] = {
 		OPT_BOOL('\0', "push", &push_mode,
 			 N_("manipulate push URLs")),
 		OPT_BOOL('\0', "add", &add_mode,
 			 N_("add URL")),
 		OPT_BOOL('\0', "delete", &delete_mode,
 			    N_("delete URLs")),
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_seturl_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
 	if (add_mode && delete_mode)
 		die(_("--add --delete doesn't make sense"));
 
 	if (argc < 3 || argc > 4 || ((add_mode || delete_mode) && argc != 3))
 		usage_with_options(builtin_remote_seturl_usage, options);
 
 	remotename = argv[1];
 	newurl = argv[2];
 	if (argc > 3)
 		oldurl = argv[3];
 
 	if (delete_mode)
 		oldurl = newurl;
 
 	remote = remote_get(remotename);
 	if (!remote_is_configured(remote, 1))
 		die(_("No such remote '%s'"), remotename);
 
 	if (push_mode) {
 		strbuf_addf(&name_buf, "remote.%s.pushurl", remotename);
 		urlset = remote->pushurl;
 		urlset_nr = remote->pushurl_nr;
 	} else {
 		strbuf_addf(&name_buf, "remote.%s.url", remotename);
 		urlset = remote->url;
 		urlset_nr = remote->url_nr;
 	}
 
 	/* Special cases that add new entry. */
 	if ((!oldurl && !delete_mode) || add_mode) {
 		if (add_mode)
 			git_config_set_multivar(name_buf.buf, newurl,
 						       "^$", 0);
 		else
 			git_config_set(name_buf.buf, newurl);
-		strbuf_release(&name_buf);
-
-		return 0;
+		goto out;
 	}
 
 	/* Old URL specified. Demand that one matches. */
 	if (regcomp(&old_regex, oldurl, REG_EXTENDED))
 		die(_("Invalid old URL pattern: %s"), oldurl);
 
 	for (i = 0; i < urlset_nr; i++)
 		if (!regexec(&old_regex, urlset[i], 0, NULL, 0))
 			matches++;
 		else
 			negative_matches++;
 	if (!delete_mode && !matches)
 		die(_("No such URL found: %s"), oldurl);
 	if (delete_mode && !negative_matches && !push_mode)
 		die(_("Will not delete all non-push URLs"));
 
 	regfree(&old_regex);
 
 	if (!delete_mode)
 		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
 	else
 		git_config_set_multivar(name_buf.buf, NULL, oldurl, 1);
+out:
+	strbuf_release(&name_buf);
 	return 0;
 }
 
-- 
2.14.1

