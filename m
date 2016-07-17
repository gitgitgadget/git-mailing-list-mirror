Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA0120195
	for <e@80x24.org>; Sun, 17 Jul 2016 11:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbcGQLAI (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 07:00:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:50947 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbcGQLAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 07:00:05 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MF5C3-1bYu8b0kQt-00GEQ3; Sun, 17 Jul 2016 12:59:58
 +0200
Date:	Sun, 17 Jul 2016 12:59:57 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] fsck: give the error function a chance to see the
 fsck_options
In-Reply-To: <cover.1468752290.git.johannes.schindelin@gmx.de>
Message-ID: <ffad4bc034bdffdfb05a59d08d070d0461b44f8e.1468752290.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de> <cover.1468752290.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:q442cebDtJi/pCHlgtrR6OORH6DhypbxxSANnfqXM4FfEYHtZ05
 Xrh4cu64bpuDUEVtwABIWx2bO64PEdsHGei1p3SOR2cn5DBLRKSLBNUSbialEf4ZCjdm/ev
 wjJOelnc68Qrppmk037nHQRBfehe85G+DPJLNQWSoo2ghppp97uDtLL1kMvRuq22+jKd7Qp
 go3dBRigyDRcm/pXGsosw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:HQ7MU3qSYmY=:Ts6j3c/nwdqs5M/ugWTRnj
 eJgBgujm676uryU7cI60y5XWCzDZc+fFGQ/3qUUVHizrcuBPaGvO6yE0mMRJX9HK+jXk2TuXW
 ZX8GZtv/tM/e6cR6eG2A1QVI5h81ZZJKXczEV8Qquo1+9suBxktNRjVMxPm7INjC1gwQss4qt
 /joodIOtqPWuEKOgBZ3yrpG0w1S8NrNuCaERnWm/rZCWeSQIDaX1JV6CAmql4ApgPn2YBAiSj
 ghBTxDZgqSeR5JVObz+mtASi2ZhtwD3aqwxVg1raUB+Fh2I7zlicagww0IcqlWlmA6gJpdbCp
 5aPTk/PEw0JGSxmMqIQr1yKNi9Ddc5Mm4EzjxnXmErG5JLrn05Y/D7oOisyFIHfKHXuVgUIPz
 3j8vJgZeqDAQTP9ugKC+vSkZA0zew6jyOARrUyQiLvGdy02BFfUCXjoWNUkOjBv3IbaE1JRIi
 y5np4g/ZAkqZDarEmN2X+MQhuuvFJ9ZgWVFL/bYP7DYiXzPrSnb3/da5D/iPiYb4Hyc91z0Ai
 GiKYJ5eGDg+kDtzuyppG/WT9oCevNLXH2GwCkzTkZV47Jrsu6nrILcah+xOWhpmWJwk5lGlKk
 jBDC818FopAs2/qIghXLXLzQpBejJiNzukkmaFVvypvoOVHiL7WKEbe+nxEq8GAxu8Mu7b11i
 kiCgq2sz8iIYCg5byQdtbuvMLz5a7h5uRNwr/KKVpwkNVd7URZOJ7xVHhpEo0D+mY9F4b7ts/
 aLENow2/jHdYKSqmJE+fzfYcJep+6OBFD37f4SFVZREtXiriLxeaKd58Zqac0MPaLO7Cm5nv3
 XcIbzVF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We will need this in the next commit, where fsck will be taught to
optionally name the objects when reporting issues about them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsck.c | 3 ++-
 fsck.c         | 5 +++--
 fsck.h         | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 87df191..6c9d598 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -82,7 +82,8 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct object *obj, int type, const char *message)
+static int fsck_error_func(struct fsck_options *o,
+	struct object *obj, int type, const char *message)
 {
 	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
 	return (type == FSCK_WARN) ? 0 : 1;
diff --git a/fsck.c b/fsck.c
index 6ed90ec..828c5c6 100644
--- a/fsck.c
+++ b/fsck.c
@@ -291,7 +291,7 @@ static int report(struct fsck_options *options, struct object *object,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(object, msg_type, sb.buf);
+	result = options->error_func(options, object, msg_type, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -897,7 +897,8 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 			  obj->type);
 }
 
-int fsck_error_function(struct object *obj, int msg_type, const char *message)
+int fsck_error_function(struct fsck_options *o,
+	struct object *obj, int msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", oid_to_hex(&obj->oid), message);
diff --git a/fsck.h b/fsck.h
index 26c0d41..1891c18 100644
--- a/fsck.h
+++ b/fsck.h
@@ -23,9 +23,11 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, int type, void *data, struct fsck_options *options);
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
-typedef int (*fsck_error)(struct object *obj, int type, const char *message);
+typedef int (*fsck_error)(struct fsck_options *o,
+	struct object *obj, int type, const char *message);
 
-int fsck_error_function(struct object *obj, int type, const char *message);
+int fsck_error_function(struct fsck_options *o,
+	struct object *obj, int type, const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
-- 
2.9.0.281.g286a8d9


