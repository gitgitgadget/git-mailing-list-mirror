From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v3] builtin/merge_recursive.c: Add an usage string and make use of it.
Date: Mon, 30 Aug 2010 00:30:22 -0300
Message-ID: <b58adc6cdfd6a5753fac1dde3371b3745b1f58b1.1283138840.git.tfransosi@gmail.com>
References: <20100830024259.GC4010@burratino>
Cc: jrnieder@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 05:30:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opv50-0002dg-Bg
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 05:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab0H3Dac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 23:30:32 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48876 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab0H3Daa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 23:30:30 -0400
Received: by yxp4 with SMTP id 4so142537yxp.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 20:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=edWwpusR9wgdkSA94ZMAIDjdu19moKLEbyhgGDykGHs=;
        b=R/JivvqLrKaqw+ZR2J38Ot+7730ZE+n7Sw+u2mx45lvisti8M+yQVWD+YI02EB8qQD
         hnfGq9yRWi4htm3avK9/loUZROM0FY7amlnweU95EAcgq1soKCiILUmuuh0tzDB7f2ti
         iX5pl6SaLXhJ77Kv8H2fmpQlWufuxRQ1si8FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Tmqt/xsz7UA3WGVTt1xksFefNDGNMyuve0I4cJIpS59jB63Gl5veM7pKPfzs8ftZit
         ldXiYiQIE+BzoKEF13+JepHi6TL2IpTk9OB4IKRaFwZV0xExr8nY0RSnOSIaQwJfP0qk
         G2GjQjVcAr5MVbcUnRe0mXOpIRfYVhSk0MjeI=
Received: by 10.100.165.11 with SMTP id n11mr3787490ane.217.1283139029490;
        Sun, 29 Aug 2010 20:30:29 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id c19sm11814619ana.2.2010.08.29.20.30.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 20:30:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g3d045
In-Reply-To: <20100830024259.GC4010@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154762>

This improves the usage output by adding builtin_merge_recursive_usage string
that follows the same pattern used by the other builtin commands.

The previous output for git merger-recursive was:
usage: merge-recursive <base>... -- <head> <remote> ...

Now the output is:
usage: git merge-recursive <base>... -- <head> <remote> ...

Since cmd_merge_recursive is used to handle four different commands we need
the %s in the usage string, so the following example:

$ git merge-subtree -h

Will output:
usage: git merge-subtree <base>... -- <head> <remote> ...

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin/merge-recursive.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index d8875d5..3d00adb 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -3,6 +3,9 @@
 #include "tag.h"
 #include "merge-recursive.h"
 
+static const char builtin_merge_recursive_usage[] =
+	"git %s <base>... -- <head> <remote> ...";
+
 static const char *better_branch_name(const char *branch)
 {
 	static char githead_env[8 + 40 + 1];
@@ -29,7 +32,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 		o.subtree_shift = "";
 
 	if (argc < 4)
-		usagef("%s <base>... -- <head> <remote> ...", argv[0]);
+		usagef(builtin_merge_recursive_usage, argv[0]);
 
 	for (i = 1; i < argc; ++i) {
 		const char *arg = argv[i];
-- 
1.7.2.1.95.g3d045
