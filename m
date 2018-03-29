Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE40F1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeC2PTI (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:19:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:36631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeC2PTG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:19:06 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXqaN-1f5GT70Srn-00WnUj; Thu, 29
 Mar 2018 17:18:58 +0200
Date:   Thu, 29 Mar 2018 17:18:57 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 6/9] git_config_set: simplify the way the section name is
 remembered
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <01ae8d501a9c605d16f1ab83212b8fc3bda49f48.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:weYALP5SyJakWmVqrDnExhz2AZLmBIkxx50/rq3kx0RhF18cLjS
 tcFjhJ9kKIw2ZpUIDQmtZjrUpd545XdFJ/4Ru3yoWZQF1MnGqIzBZfT06qKhUOQgc2O1sPb
 B2hFoBYZJMLzpoGPgMf3Q5yX820KTMoYg65JcMtCrepCAYCTkSobOSQICVn4X6mWjxHGgLY
 eFvdnRAZ6IUvShKju3qxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JKBWGw+V8rE=:nZkGXXG2oYjRCPV6prAl/m
 KGy9Y6kvjjYn++w7S5XDx5j42ylKDXtcNVvlu6Mpzem/hg6Z4I1+0TTuGXj4qjC3rpUkIVT+W
 a+qobMoCesG+iix7I5ZZu32doz9x/rRChwfTdSvQXMRUEAgF/gkLW5h2Q3KAYcSrv/b5U7vtg
 UAsl+KOkCaXnZVly2cU2Nvb+WTxvwxnj2WMvOPDq6s2JV9Gsrr/1fzeNLpNy0Aq0Jjrb9/gFt
 y2uHai5KuqCmAp+NfdUJKq5UoxK0rLYBxQHlDBP6IoR9uOOK71ShluvOHdW1HQzbN/XvgnPAt
 jEEmctXjMt75NbRVRxglfVAHvY3niZ52WgTlr/SDTLDGZk4G4riIgNY2qFqSkn0OfScMW09MO
 ooc3Z2mo+zVLZ50dD++N3kqYHa+S0iRyVndg/fsOufdbgM+tOi1EQCm+Lr83xQ9xFiWJujphy
 jYHdC7d4IYJGDQ6MPhwNF9CQqU3//cYwF3GGikOHMsNWHYIhxrgCbhf9Yk2ySS6dcCK510nr+
 UPSrvBYfMhUCBgVHtvslTYfsRPa9yKpCiO6vjo0Hui6y6GmG8PJmd7+9CR20ziQOA4afbB+Dn
 sQOjpyCCPjNQNCF0x1VATnxZetE9hM5XDirb360EoQfly7UaL+BKKtrbVSVKwIunI9T98oGdR
 S6QJgYalkIk9xWNo/RLleItez7YDj37+Kd1eKS+7lmvIsUYqVTwHSRUXMtjGQaLOIZie2peno
 pbw0CkQJQUNeVN0G5AQgW4SNCiOAkJK+7+K25oqCYK1XeFuX5ioPZWhS1Qtrcar0/7kSUF5Y1
 Jem+38+zWvj9n+t2xHFBomKX8ZkQnh0hvBFXbK8mJwNQmf5KoyuEtaabmuoprTciCs5nr4j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This not only reduces the number of lines, but also opens the door for
reusing the section name later (which the upcoming patch to remove
now-empty sections will do).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 5cc049aaef0..d35dffa50de 100644
--- a/config.c
+++ b/config.c
@@ -2486,12 +2486,14 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	struct lock_file lock = LOCK_INIT;
 	char *filename_buf = NULL;
 	char *contents = NULL;
+	char *section_name = NULL;
 	size_t contents_sz;
 
 	/* parse-key returns negative; flip the sign to feed exit(3) */
-	ret = 0 - git_config_parse_key(key, &store.key, &store.baselen);
+	ret = 0 - git_config_parse_key(key, &section_name, &store.baselen);
 	if (ret)
 		goto out_free;
+	store.key = section_name;
 
 	store.multi_replace = multi_replace;
 
@@ -2505,7 +2507,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (fd < 0) {
 		error_errno("could not lock config file %s", config_filename);
-		free(store.key);
 		ret = CONFIG_NO_LOCK;
 		goto out_free;
 	}
@@ -2515,8 +2516,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	 */
 	in_fd = open(config_filename, O_RDONLY);
 	if ( in_fd < 0 ) {
-		free(store.key);
-
 		if ( ENOENT != errno ) {
 			error_errno("opening %s", config_filename);
 			ret = CONFIG_INVALID_FILE; /* same as "invalid config file" */
@@ -2571,7 +2570,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		 */
 		if (git_config_from_file(store_aux, config_filename, NULL)) {
 			error("invalid config file %s", config_filename);
-			free(store.key);
 			if (store.value_regex != NULL &&
 			    store.value_regex != CONFIG_REGEX_NONE) {
 				regfree(store.value_regex);
@@ -2581,7 +2579,6 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			goto out_free;
 		}
 
-		free(store.key);
 		if (store.value_regex != NULL &&
 		    store.value_regex != CONFIG_REGEX_NONE) {
 			regfree(store.value_regex);
@@ -2682,6 +2679,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 out_free:
 	rollback_lock_file(&lock);
+	free(section_name);
 	free(filename_buf);
 	if (contents)
 		munmap(contents, contents_sz);
-- 
2.16.2.windows.1.26.g2cc3565eb4b


