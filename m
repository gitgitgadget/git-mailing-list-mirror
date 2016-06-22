Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D009F1FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 09:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbcFVJlV (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 05:41:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:61967 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbcFVJlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 05:41:14 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MPE7E-1bK2Gv14Ge-004P07; Wed, 22 Jun 2016 11:34:25
 +0200
Date:	Wed, 22 Jun 2016 11:34:24 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] Make the skip_empty_lines() function public
In-Reply-To: <cover.1466587806.git.johannes.schindelin@gmx.de>
Message-ID: <3f1f8a118900c4f572c5f70d1752eda0a48158d7.1466587806.git.johannes.schindelin@gmx.de>
References: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de> <cover.1466587806.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sehff9THqfclyst70NC1NPVUovvETi7zGW6KarLnMAVFVVeP3NU
 3qbLujsehlXsKDL0K0oYypDTFPv3WbcXeQ72LP6LyCk/Dg4B4gv0PL3TMHdcNVxdot6CEWS
 oz2l6UzPhDxuIZbPGHaP0DkrbnS/3aazbG7EU5Kq+6LOUXEzH+WGVIN369dT89E9LLfQQ6y
 cNlnu+annAWRl+AN2apwQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:q+v8gk5vPIU=:fwPWHOm22jl9PksiMCs3OF
 ofNRgiX9NR1fA6brAhOisKBFWB5gHejvyXxdfEvms2fercK2zDt/qSy0w+AUvSQfX4OtWT2O3
 JGKGkTMLQY+36Ox0yzYjrBTSL9Dp7hkRb0nMRkqmHSHi10NHRhd1Vooy+D6fETSIcloNW7izy
 W3VPGxOAqMU0Z7zpREzhqBUQQ4NFKKZ7SqzcwOjnr/GjJIQs//nDX3vWv4qGLjS+cGsECiJhG
 P//60guPRIOLhkseY4YlMBZA/43Yahtt22zLZEqRIxuYUXf6PNl5qKwceFcWQgMOVPNPh5pzw
 dBvN+PCc7Y8U4kF8jysgvjXdf7IvcBkmUYt8nEzeDwv2YKA5YRj1JA+1lzbopA8K0nyCbV4aB
 kt1mEvsWmJ8dTYmFPlEXFCywvvy+dd8pAFMphi5sT4zhgYTmWFmpiAjxPssz1Na7kCP1Lu/6e
 q7mFeOUE4SdrGc4G42yeNQcrjN6Q8v2Dsz3Cd81ZOqZcD2IteRVOToBdXRKfcOtiRuTV24vGH
 9EZS++NPLanpptYFdgfloUC63ojN36mxF85DOtCi1bhtm3MR+rrlc2ZAkImNLQ8J+Vx+F+sbh
 i+qk300yb5yllFeacIk17HEYV2OhEAXvu7cpJyYt7nUh4l/8oQSw+Cl3R38d/+ypOor7LZOAs
 BWE8cFmT4TdMk3pFwVpN1mmn6zmy7ecX3GkKs5Uvl5KJoOitzAG3j40mY5CV/qS3DgEffepGC
 Sz1fhJr8h9TJpyHTLteEC3XFY9qJsXd/0EEgGmYvsIhnFdjLvZTLsRMcCtT8MaaTMwTh2C0CI
 eKbiPfV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This function will be used also in the find_commit_subject() function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 commit.h | 1 +
 pretty.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/commit.h b/commit.h
index b06db4d..fbdd18d 100644
--- a/commit.h
+++ b/commit.h
@@ -177,6 +177,7 @@ extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
 extern int commit_format_is_empty(enum cmit_fmt);
+extern const char *skip_empty_lines(const char *msg);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
diff --git a/pretty.c b/pretty.c
index c3ec430..1b807b4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -516,7 +516,7 @@ static int is_empty_line(const char *line, int *len_p)
 	return !len;
 }
 
-static const char *skip_empty_lines(const char *msg)
+const char *skip_empty_lines(const char *msg)
 {
 	for (;;) {
 		int linelen = get_one_line(msg);
-- 
2.9.0.118.g0e1a633


