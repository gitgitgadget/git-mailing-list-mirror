From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/5] git-tag: introduce long forms for the options
Date: Fri, 26 Aug 2011 16:05:12 +0200
Message-ID: <f02e446227a93fff37591f1a866566e6220ce283.1314367414.git.git@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 16:05:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwx2T-0007ZO-18
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 16:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab1HZOFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 10:05:25 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:32820 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755132Ab1HZOFW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 10:05:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ECBCC20814;
	Fri, 26 Aug 2011 10:05:21 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 26 Aug 2011 10:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=wv
	zuS5S3J7Kw5DzeQUXhAfqjsuw=; b=U3+0pU2LhZwj2OtJjIivuCy5T3DxxVqC1T
	4Co4ypRh6G7ft02EqjdXLc1qkYknfnOm1ADCLlWbFC3hngg3N0vjbsIlQHbifO4W
	6Vz6B5qUB86TuJza/myEbIYHOdLCOfDdRPu0a8C+EcjcaBt5gX6Q+40HMGlZYPlw
	Zw1L1Ff/k=
X-Sasl-enc: 2g1PrR0D3rLtaTbgRxX+zNbXnQ1X4HldQLx71+GN1paT 1314367521
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 631F59205E1;
	Fri, 26 Aug 2011 10:05:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <20110825175301.GC519@sigill.intra.peff.net>
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180167>

Long forms are better to memoize, and more reliably uniform across
commands.

Design notes:

-u,--local-user is named following the analogous gnupg option.

-l,--list is not an argument taking option but a mode switch.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-tag.txt |    8 ++++++++
 builtin/tag.c             |   16 ++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index fb1c0ac..c83cb13 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -43,12 +43,15 @@ GnuPG key for signing.
 OPTIONS
 -------
 -a::
+--annotate::
 	Make an unsigned, annotated tag object
 
 -s::
+--sign::
 	Make a GPG-signed tag, using the default e-mail address's key
 
 -u <key-id>::
+--local-user=<key-id>::
 	Make a GPG-signed tag, using the given key
 
 -f::
@@ -56,9 +59,11 @@ OPTIONS
 	Replace an existing tag with the given name (instead of failing)
 
 -d::
+--delete::
 	Delete existing tags with the given names.
 
 -v::
+--verify::
 	Verify the gpg signature of the given tag names.
 
 -n<num>::
@@ -69,6 +74,7 @@ OPTIONS
 	If the tag is not annotated, the commit message is displayed instead.
 
 -l <pattern>::
+--list <pattern>::
 	List tags with names that match the given pattern (or all if no
 	pattern is given).  Running "git tag" without arguments also
 	lists all tags. The pattern is a shell wildcard (i.e., matched
@@ -79,6 +85,7 @@ OPTIONS
 	Only list tags which contain the specified commit.
 
 -m <msg>::
+--message=<msg>::
 	Use the given tag message (instead of prompting).
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
@@ -86,6 +93,7 @@ OPTIONS
 	is given.
 
 -F <file>::
+--file=<file>::
 	Take the tag message from the given file.  Use '-' to
 	read the message from the standard input.
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
diff --git a/builtin/tag.c b/builtin/tag.c
index 667515e..9d89616 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -429,21 +429,21 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
 	struct option options[] = {
-		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
+		OPT_BOOLEAN('l', "list", &list, "list tag names"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, "n",
 				"print <n> lines of each tag message",
 				PARSE_OPT_OPTARG, NULL, 1 },
-		OPT_BOOLEAN('d', NULL, &delete, "delete tags"),
-		OPT_BOOLEAN('v', NULL, &verify, "verify tags"),
+		OPT_BOOLEAN('d', "delete", &delete, "delete tags"),
+		OPT_BOOLEAN('v', "verify", &verify, "verify tags"),
 
 		OPT_GROUP("Tag creation options"),
-		OPT_BOOLEAN('a', NULL, &annotate,
+		OPT_BOOLEAN('a', "annotate", &annotate,
 					"annotated tag, needs a message"),
-		OPT_CALLBACK('m', NULL, &msg, "message",
+		OPT_CALLBACK('m', "message", &msg, "message",
 			     "tag message", parse_msg_arg),
-		OPT_FILENAME('F', NULL, &msgfile, "read message from file"),
-		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
-		OPT_STRING('u', NULL, &keyid, "key-id",
+		OPT_FILENAME('F', "file", &msgfile, "read message from file"),
+		OPT_BOOLEAN('s', "sign", &sign, "annotated and GPG-signed tag"),
+		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
 
-- 
1.7.6.845.gc3c05
