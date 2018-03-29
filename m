Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B9E1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 15:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeC2PTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 11:19:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:45347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeC2PTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 11:19:17 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LymjL-1eWChZ0n95-01687z; Thu, 29
 Mar 2018 17:19:06 +0200
Date:   Thu, 29 Mar 2018 17:19:04 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 8/9] git_config_set: use do_config_from_file() directly
In-Reply-To: <cover.1522336130.git.johannes.schindelin@gmx.de>
Message-ID: <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aycCASuIyBjEswZpXBYT5WKX3XhrcmHbCit0oiGYUNBeWJfMCDp
 bVQAiIyPKG3ekQ2g1xjkRy1Bdc+yQBxCbgvskXrUYKLK+x6XHAS1alrBruZ7EQLDer6GuFP
 fyrJczxd9NAySrWpqXrTDxhcFTv1+POq18R/vM+NVJfs4LEud6WUgsnLMHsQZUW7z4hHlqa
 elTbI2fyGEciXkX/x6HcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n7lM7EXDWig=:SKFX6eQLpJOqKPd2kDnXCK
 Mu8H4vlDG5IqZlmzgR9MGvxW5mQl0/i5yR5V6rsXf5gGsViqRlk00aL8ugX4o7KX8RNfxnL2e
 QZC5oQ8qyCXLc69Pn0R861epdFSX30eqzYdUd328p3wDBVDJvH1rLSAWJ/nkBgCf+Yvpbq/Fm
 NYgEJ0wrLWPZozI+eIwZk7wsA7E5Odf6J2NEbEgL+tFp7NUIUAVF1t+YldfH+ccchMVqVkMAv
 1t3zvkdZHbsd/1wiaXj2nE6uzhldl35koUP0Pr5cef/YyUV1YTHT9C1JGA9v6D3IJpQL6/IAx
 eqg2b72ugwL0XrqnlYz//bwtXkNyGOgUeeZID7Vvhy69T4dNbQ/EmSNLAOoC/eiGy9dhlr6JD
 o210wvHQmHWcbOOjE69OMFfKAi9BycNcBNkFGOTmAUEg5xeKUbokYaFooM+0gsri9XwV0N1F9
 crQtMfcC4m3rqkM59zEcxGey6GAJ7/ndGNHPTKpnQWsf4AvCdvgVNBDPhTz2ToQ+XHpGq/02x
 rA5aEB+vnAyGW3mCM0yryRZv9aKDsw4/kMdA8cqW3kNCfXXfHPpChYfl5n1xDnmX3un3+1lTQ
 NXd3uUbwELD4Dcib337cxhHKRmJgzgiPOKxxvD1VAQz2wvsaiWCRQw2HslCbwKY1pHg1QFO7V
 3J977NITik0EBKZ+hu2IXEHNyRjKc5OX3dyaYFiXWRHHeEKUNeOOHX1LGqfJF4wFpooDkQH+t
 28NLD3dbI60EQCSsuIpx/XDIOnWAPXQsbpljOJc2oNFwLRzXlu17sXARjBrjoKUp4rC/qQVIs
 Xfs4evIrFh0Fn3yGWHofgGMa7RmBCsCoFjUHsFZCwBFJaxUAVPfp2wxbEUh+3zRIkBKZ2lH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Technically, it is the git_config_set_multivar_in_file_gently()
function that we modify here (but the oneline would get too long if we
were that precise).

This change prepares the git_config_set machinery to allow reusing empty
sections, by using the file-local function do_config_from_file()
directly (whose signature can then be changed without any effect outside
of config.c).

An incidental benefit is that we avoid a level of indirection, and we
also avoid calling flockfile()/funlockfile() when we already know that
we are not operating on stdin/stdout here.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 503aef4b318..eb1e0d335fc 100644
--- a/config.c
+++ b/config.c
@@ -2706,6 +2706,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		struct stat st;
 		size_t copy_begin, copy_end;
 		int i, new_line = 0;
+		FILE *f;
 
 		if (value_regex == NULL)
 			store.value_regex = NULL;
@@ -2739,7 +2740,10 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 		 * As a side effect, we make sure to transform only a valid
 		 * existing config file.
 		 */
-		if (git_config_from_file(store_aux, config_filename, NULL)) {
+		f = fopen_or_warn(config_filename, "r");
+		if (!f || do_config_from_file(store_aux, CONFIG_ORIGIN_FILE,
+					      config_filename, config_filename,
+					      f, NULL)) {
 			error("invalid config file %s", config_filename);
 			if (store.value_regex != NULL &&
 			    store.value_regex != CONFIG_REGEX_NONE) {
@@ -2747,8 +2751,11 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 				free(store.value_regex);
 			}
 			ret = CONFIG_INVALID_FILE;
+			if (f)
+				fclose(f);
 			goto out_free;
-		}
+		} else
+			fclose(f);
 
 		if (store.value_regex != NULL &&
 		    store.value_regex != CONFIG_REGEX_NONE) {
-- 
2.16.2.windows.1.26.g2cc3565eb4b


