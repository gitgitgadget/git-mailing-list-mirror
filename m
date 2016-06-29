Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2AE1FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbcF2OOu (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:14:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:59325 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498AbcF2OOt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:14:49 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MbgKD-1b1PfS2duf-00J3ne; Wed, 29 Jun 2016 16:14:43
 +0200
Date:	Wed, 29 Jun 2016 16:14:42 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] commit -C: skip blank lines at the beginning of the
 message
In-Reply-To: <cover.1467209576.git.johannes.schindelin@gmx.de>
Message-ID: <043eafd7ad4128d3a887c224ec6576d96872d1df.1467209576.git.johannes.schindelin@gmx.de>
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3+L/I5Z1Y9uQnaFzr6vmCbOxmMtO97Ghoy7E/tFFOVhTYsZUZbn
 OeN7tjivdukGXxeRDrPLaakpoYwYeV72JNKxl0ncnzpLziZBKpN5OCG61HbmqWyqWHmOKUK
 9UysWbTbo85fJCJdbtUr+KmmOnbnNH5jPgD1OvIU0vN468HooCV+QPPEZtqDTE3ktzkvAit
 R/6jxPYo0ut4EKFomWMuw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:V+JAlf1GlRA=:95qafHebrrNkUgfqikp3Hr
 1pZnGJTBCdoYojyYqbsjI/r1GqHbZIIN515+4SLu/eD3K0Mxr8lnhZgQX+5i3snjRdG/wf8fr
 lf5Z7tZD6SQvI16A5BzQxT1JKdvKHHfaKIhU6Pun9w8eFj3lXjIXxhQaawo+om9hqriyNZv6p
 ORD6TTQf/CCD4Rm/513Y+V/E14SG/ixnjEN9wB8IbV0h29C35H/vk2NWZO9Gt3twQoPkPsI6s
 VQC3WGESTKsT+MAUXb9MrtUq++TyNNsFkNw+mrQgJ2Cs2CTvFc4tzwyhMk1JeUCB2iEVNdQ/p
 43IwY/FuBTewHLe6BM9bkaaUec5Tl0vKHMWvkwkmSV69xvshZC9mOj2wU3AaX94L/bw6J4YNa
 SlAZPkR2jp6rNKTOBqmMMHDtXr6sBrW+P4SsDUyEgnIRJhHKZqeGEArvZ7mwkPpvKA7l4AjlU
 fGt9Nixv32eeDH8WmAzxeHEfB/VEgkmrbHH1V+7TNV22lfF4slp185Who4/g01m2O/NUVlns5
 oTJnM8MHrbBPJ6qfmkQIjuTBQ3/boXyywHNTlWiiu65dXbY2bP45IVT94e1P4r6fCInv+dGOm
 Ot5bZdwQ1OJ9BtPgnOz/5OLJ5NJlRTXYT6N/LaFhR5irXHsdCgkhknG+Evtk72X+7o348eUPB
 8lvDmqK6Y95YQkAcr0IltBaghoOnSuMn+bZYlvXn1fnLVyS2KNwvC7aVyHwmZ0WVCdMY6hgvN
 WoGHyTRz7hs4Mjlb1y3OI3GhPMmclWBKMslPgxH42hdKkAfy7y6MOO857FY1n6TRbDRguAIX1
 3Xxq7Kd
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Consistent with the pretty-printing machinery, we skip leading blank
lines (if any) of existing commit messages.

While Git itself only produces commit objects with a single empty line
between commit header and commit message, it is legal to have more than
one blank line (i.e. lines containing only white space, or no
characters) at the beginning of the commit message, and the
pretty-printing code already handles that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3f18942..1f6dbcd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -715,7 +715,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (buffer)
-			strbuf_addstr(&sb, buffer + 2);
+			strbuf_addstr(&sb, skip_blank_lines(buffer + 2));
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
 	} else if (fixup_message) {
-- 
2.9.0.270.g810e421


