From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Simplify usage string printing
Date: Sun, 14 Oct 2007 16:01:16 +0200
Message-ID: <20071014140116.GA20970@diku.dk>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <1192282153-26684-3-git-send-email-madcoder@debian.org> <1192282153-26684-4-git-send-email-madcoder@debian.org> <1192282153-26684-5-git-send-email-madcoder@debian.org> <1192282153-26684-6-git-send-email-madcoder@debian.org> <1192282153-26684-7-git-send-email-madcoder@debian.org> <1192282153-26684-8-git-send-email-madcoder@debian.org> <1192282153-26684-9-git-send-email-madcoder@debian.org> <1192282153-26684-10-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 16:07:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih47f-0006w1-1L
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 16:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756332AbXJNOHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 10:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbXJNOHE
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 10:07:04 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:35860 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560AbXJNOHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 10:07:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 2246152C3E9;
	Sun, 14 Oct 2007 16:07:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cT8-LhpWMzDO; Sun, 14 Oct 2007 16:06:58 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 08C557E8045;
	Sun, 14 Oct 2007 16:01:17 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3929C6DFB7A; Sun, 14 Oct 2007 16:01:11 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id D6DDB5B8001; Sun, 14 Oct 2007 16:01:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1192282153-26684-10-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60849>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-branch.c     |    1 -
 builtin-update-ref.c |    1 -
 parse-options.c      |    2 +-
 3 files changed, 1 insertions(+), 3 deletions(-)

 Pierre Habouzit <madcoder@debian.org> wrote Sat, Oct 13, 2007:
 > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
 > ---
 >  builtin-update-ref.c |   71 +++++++++++++++++++++-----------------------------
 >  1 files changed, 30 insertions(+), 41 deletions(-)
 > 
 > diff --git a/builtin-update-ref.c b/builtin-update-ref.c
 > index fe1f74c..eafb642 100644
 > --- a/builtin-update-ref.c
 > +++ b/builtin-update-ref.c
 > @@ -1,59 +1,48 @@
 >  #include "cache.h"
 >  #include "refs.h"
 >  #include "builtin.h"
 > +#include "parse-options.h"
 >  
 > -static const char git_update_ref_usage[] =
 > -"git-update-ref [-m <reason>] (-d <refname> <value> | [--no-deref] <refname> <value> [<oldval>])";
 > +static const char * const git_update_ref_usage[] = {
 > +	"",
 > +	"git-update-ref [options] -d <refname> <oldval>",
 > +	"git-update-ref [options]    <refname> <newval> [<oldval>]",
 > +	NULL
 > +};

 How about something like this to get rid of these empty strings
 that look strange?

	> ./git update-ref -h
	usage: git-update-ref [options] -d <refname> <oldval>
	   or: git-update-ref [options]    <refname> <newval> [<oldval>]

	    -m <reason>           reason of the update
	    -d                    deletes the reference
	    --no-deref            update <refname> not the one it points to

diff --git a/builtin-branch.c b/builtin-branch.c
index fbf983e..d7c4657 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -14,7 +14,6 @@
 #include "parse-options.h"
 
 static const char * const builtin_branch_usage[] = {
-	"",
 	"git-branch [options] [-r | -a]",
 	"git-branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git-branch [options] [-r] (-d | -D) <branchname>",
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index d66d9b5..0cd7817 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -4,7 +4,6 @@
 #include "parse-options.h"
 
 static const char * const git_update_ref_usage[] = {
-	"",
 	"git-update-ref [options] -d <refname> <oldval>",
 	"git-update-ref [options]    <refname> <newval> [<oldval>]",
 	NULL
diff --git a/parse-options.c b/parse-options.c
index c45bb9b..b1d9608 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -181,7 +181,7 @@ void usage_with_options(const char * const *usagestr,
 {
 	fprintf(stderr, "usage: %s\n", *usagestr);
 	while (*++usagestr)
-		fprintf(stderr, "    %s\n", *usagestr);
+		fprintf(stderr, "   or: %s\n", *usagestr);
 
 	if (opts->type != OPTION_GROUP)
 		fputc('\n', stderr);
-- 
1.5.3.4.1166.gf076

-- 
Jonas Fonseca
