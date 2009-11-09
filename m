From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/24] Retire fetch--tool helper to contrib/examples
Date: Mon,  9 Nov 2009 09:04:41 -0600
Message-ID: <1257779104-23884-1-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:55:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VeI-0002K4-LI
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZKIOzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbZKIOzF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:05 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZKIOzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:04 -0500
Received: by ewy3 with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jg14A6nEnzdO3AfBkRzpOxTg4IV+J02M61rnMq0Kz0U=;
        b=H1ciq6cOJ2jvab8NwNLaFR55Xc//d4fKGeJkcSLh7QdvzywFkzilAqStnZP578YXf/
         EAmnrEDH8mSQu/XVTCTBoF5WHqfyvyO8D6marWSSGPvhUZp+huMsACrdBamOi7Yij7Wl
         ni7MlutOvtAi7V6JxLlmDLgMMdErVY7uQw8r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bQ9FfPahhkQvhBNHeA5sRQ5IN9IQjJyFwseEvsM2zYzBM6vOClRftbnTVkNi39jmmH
         02P9dSn5MLLlJccGMPY1cJtOVTzv6DF4M8VEstbgve+QUa45bRFQERaEN8TF6v5Ucy/4
         aY+RlS23W8Tr4WAvmSZjEdIObdye0Y0A13Kwk=
Received: by 10.216.86.14 with SMTP id v14mr2570263wee.183.1257778508525;
        Mon, 09 Nov 2009 06:55:08 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:07 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132463>

When git-fetch was builtin-ized, the previous script was moved to
contrib/examples.  Now, it is the sole remaining user for
'git fetch--tool'.

The fetch--tool code is still worth keeping around so people can
try out the old git-fetch.sh, for example when investigating
regressions from the builtinifaction.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
See also <http://thread.gmane.org/gmane.comp.version-control.git/65122/focus=65191>.

 Makefile                                           |    1 -
 builtin.h                                          |    1 -
 .../examples/builtin-fetch--tool.c                 |    0
 git.c                                              |    1 -
 4 files changed, 0 insertions(+), 3 deletions(-)
 rename builtin-fetch--tool.c => contrib/examples/builtin-fetch--tool.c (100%)

diff --git a/Makefile b/Makefile
index 5d5976f..c0ba479 100644
--- a/Makefile
+++ b/Makefile
@@ -601,7 +601,6 @@ BUILTIN_OBJS += builtin-diff-index.o
 BUILTIN_OBJS += builtin-diff-tree.o
 BUILTIN_OBJS += builtin-diff.o
 BUILTIN_OBJS += builtin-fast-export.o
-BUILTIN_OBJS += builtin-fetch--tool.o
 BUILTIN_OBJS += builtin-fetch-pack.o
 BUILTIN_OBJS += builtin-fetch.o
 BUILTIN_OBJS += builtin-fmt-merge-msg.o
diff --git a/builtin.h b/builtin.h
index a2174dc..c3f83c0 100644
--- a/builtin.h
+++ b/builtin.h
@@ -48,7 +48,6 @@ extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_fetch__tool(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
diff --git a/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
similarity index 100%
rename from builtin-fetch--tool.c
rename to contrib/examples/builtin-fetch--tool.c
diff --git a/git.c b/git.c
index bd2c5fe..f295561 100644
--- a/git.c
+++ b/git.c
@@ -304,7 +304,6 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
 		{ "fetch", cmd_fetch, RUN_SETUP },
 		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
-		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
-- 
1.6.5.2
