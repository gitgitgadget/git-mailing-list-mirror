From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 06/24] Show usage string for 'git show-ref -h'
Date: Mon,  9 Nov 2009 09:04:46 -0600
Message-ID: <1257779104-23884-6-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Vfl-000393-NI
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbZKIOzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755564AbZKIOzR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:17 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:44620 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbZKIOzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:13 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179619ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l80y3Pt+PyyKjQ4//IrVYT/d5mWF/8xuxBZDilQ31nA=;
        b=NO9hJevR6ubhcrkbihEpNNdf1+kUQDWvNivbK34u3Gh/31G1roMJYDXoxPGHAB7L3L
         UCMJw2dRw3ENN952MxR9ri1s3m4qUR9yT0uoqHDZ83ayRmZcGtY8K+CSZeUSv9lN9HPP
         XK2wR9mH8FjkKszA8JX0SenagaegSU9FJczTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ivo39sgQSka/Df2RU79/48lvbfKDUbxur6Xfaw5M5L/NGU07mI67Oa/hK+Hh9nEB8J
         Ov1EpGTTIR6Hbg0dQE0IZnYMnIA7+Rov5OTnY4WYl//uvjiKIq0TZLZoj0xtCsFECawj
         lmkxakphTFkron9+fpnwFc1+9VPrj1IYeB1HQ=
Received: by 10.216.85.69 with SMTP id t47mr2572350wee.107.1257778518800;
        Mon, 09 Nov 2009 06:55:18 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:18 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132485>

This only changes the behavior of "git show-ref -h" without any
other options and arguments.

"show-ref -h" currently is short for "show-ref --head", which
shows all the refs/* and HEAD, as opposed to "show-ref" that
shows all the refs/* and not HEAD.

Does anybody use "show-ref -h"?  It was in Linus's original, most
likely only because "it might be handy", not because "the command
should not show the HEAD by default for such and such reasons".
So I think it is okay if "show-ref -h" (but not "show-ref
--head") gives help and exits.

If a current script uses "git show-ref -h" without any other
arguments, it would have to be adapted by changing "-h" to
"--head".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-show-ref.txt |    3 +--
 builtin-show-ref.c             |   10 ++++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index f4429bd..70f400b 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -8,7 +8,7 @@ git-show-ref - List references in a local repository
 SYNOPSIS
 --------
 [verse]
-'git show-ref' [-q|--quiet] [--verify] [-h|--head] [-d|--dereference]
+'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
 	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
 	     [--heads] [--] <pattern>...
 'git show-ref' --exclude-existing[=<pattern>] < ref-list
@@ -30,7 +30,6 @@ the `.git` directory.
 OPTIONS
 -------
 
--h::
 --head::
 
 	Show the HEAD reference.
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index c46550c..17ada88 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -7,7 +7,7 @@
 #include "parse-options.h"
 
 static const char * const show_ref_usage[] = {
-	"git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [pattern*] ",
+	"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [pattern*] ",
 	"git show-ref --exclude-existing[=pattern] < ref-list",
 	NULL
 };
@@ -183,7 +183,10 @@ static const struct option show_ref_options[] = {
 	OPT_BOOLEAN(0, "heads", &heads_only, "only show heads (can be combined with tags)"),
 	OPT_BOOLEAN(0, "verify", &verify, "stricter reference checking, "
 		    "requires exact ref path"),
-	OPT_BOOLEAN('h', "head", &show_head, "show the HEAD reference"),
+	{ OPTION_BOOLEAN, 'h', NULL, &show_head, NULL,
+	  "show the HEAD reference",
+	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+	OPT_BOOLEAN(0, "head", &show_head, "show the HEAD reference"),
 	OPT_BOOLEAN('d', "dereference", &deref_tags,
 		    "dereference tags into object IDs"),
 	{ OPTION_CALLBACK, 's', "hash", &abbrev, "n",
@@ -201,6 +204,9 @@ static const struct option show_ref_options[] = {
 
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(show_ref_usage, show_ref_options);
+
 	argc = parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
 
-- 
1.6.5.2
