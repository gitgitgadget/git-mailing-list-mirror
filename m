From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH/RFC 4/4] grep: provide option to match line number
Date: Mon,  2 May 2011 13:39:13 +0200
Message-ID: <1028f8b6b8da69b8cb80e39a543b0775bc4d935a.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304318972.git.bert.wesarg@googlemail.com>
 <f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
 <2681b60988c7c4d059f83df368395eca0520012c.1304321122.git.bert.wesarg@googlemail.com>
 <f85d783d43bfe7f9e9f23a10e72e8a2a83033cac.1304321122.git.bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 13:39:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrTT-0000lZ-Vp
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280Ab1EBLj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:39:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33090 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab1EBLjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:39:24 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so4521802bwz.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references;
        bh=qCWFJ2efN3j4a8TnaQLzo6E8XGodCICUfotJJ334Om8=;
        b=KB/CA5Q2GuVngoqeN+Eno4/psaflXdeGEgYxLe8X4bPR1QwP3Dcg4Po+miXMeh+sgF
         7n9k/uV1abHiVp1F8p9pR6m0toqSpoCZnTc18Sx4doEUON/g5fRCC26oGyWlLkBhTys6
         zJY+8B/vuQ5UsQ+Z3iAzYpEqrPphmsZVeTt00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cPHcFlf9fByRtkZAK4vhVs/x/2L+i4qyHyD8v54CS9ihnvG9C3V74uALQbK3lBUbm5
         Kq2GlXY2fOOgASAKNpfP8KELxpH8XCVJ+t5FvyTPJ0xEal2AGx0dRaybqZaa3vE6coLG
         EdBaRyqaHVsc4Dt5Bx8VQY9bZ9cq/bLgvmhI8=
Received: by 10.204.74.218 with SMTP id v26mr5136438bkj.76.1304336363912;
        Mon, 02 May 2011 04:39:23 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de [141.30.68.111])
        by mx.google.com with ESMTPS id f21sm3252477bkd.11.2011.05.02.04.39.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 04:39:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.349.gfeb1a
In-Reply-To: <f85d783d43bfe7f9e9f23a10e72e8a2a83033cac.1304321122.git.bert.wesarg@googlemail.com>
In-Reply-To: <cover.1304321122.git.bert.wesarg@googlemail.com>
References: <cover.1304321122.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172573>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/git-grep.txt |    6 +++++-
 builtin/grep.c             |   10 ++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index d7523b3..05deb58 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 	   [--color[=<when>] | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
-	   [--and|--or|--not|(|)|-e <pattern>...]
+	   [--and|--or|--not|(|)|-e <pattern>|-@ <line>...]
 	   [--cached | --no-index | <tree>...]
 	   [--] [<pathspec>...]
 
@@ -168,6 +168,10 @@ OPTIONS
 	scripts passing user input to grep.  Multiple patterns are
 	combined by 'or'.
 
+-@::
+	The next parameter is a line number. This special pattern matches
+	this line of the input file.
+
 --and::
 --or::
 --not::
diff --git a/builtin/grep.c b/builtin/grep.c
index 10a1f65..8b11c87 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -733,6 +733,14 @@ static int pattern_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int lno_pattern_callback(const struct option *opt, const char *arg,
+				int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, arg, "-@ option", 0, GREP_LNO);
+	return 0;
+}
+
 static int help_callback(const struct option *opt, const char *arg, int unset)
 {
 	return -1;
@@ -816,6 +824,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"read patterns from file", file_callback),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
 			"match <pattern>", PARSE_OPT_NONEG, pattern_callback },
+		{ OPTION_CALLBACK, '@', NULL, &opt, "lno",
+			"match <line>", PARSE_OPT_NONEG, lno_pattern_callback },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
 		  "combine patterns specified with -e",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
-- 
1.7.5.349.gfeb1a
