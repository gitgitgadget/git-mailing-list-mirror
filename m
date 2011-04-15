From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH v2 1/2] Documentation: update to git-merge-base --octopus
Date: Fri, 15 Apr 2011 10:34:03 +0200
Message-ID: <4DA802FB.7040506@lyx.org>
References: <4DA47A4D.80909@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 10:40:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAeZV-0008Ju-4K
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 10:40:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab1DOIjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 04:39:51 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43717 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1DOIju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 04:39:50 -0400
Received: by ewy4 with SMTP id 4so684433ewy.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 01:39:49 -0700 (PDT)
Received: by 10.213.19.84 with SMTP id z20mr985338eba.7.1302856788831;
        Fri, 15 Apr 2011 01:39:48 -0700 (PDT)
Received: from [192.168.1.2] (i229113.upc-i.chello.nl [62.195.229.113])
        by mx.google.com with ESMTPS id m55sm1769922eei.15.2011.04.15.01.39.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 01:39:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4DA47A4D.80909@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171596>

1) Unlike plain merge-base, merge-base --octopus only requires at least one commit
argument, and this patch updates the synopsis to reflect that.

2) Add a sentence to the discussion that when --octopus is used, we do expect '2'
as the result.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-merge-base.txt |    6 +++++-
 builtin/merge-base.c             |    3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index eedef1b..a9f677b 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -9,7 +9,8 @@ git-merge-base - Find as good common ancestors as possible for a merge
 SYNOPSIS
 --------
 [verse]
-'git merge-base' [-a|--all] [--octopus] <commit> <commit>...
+'git merge-base' [-a|--all] <commit> <commit>...
+'git merge-base' [-a|--all] --octopus <commit>...
 'git merge-base' --independent <commit>...

 DESCRIPTION
@@ -89,6 +90,9 @@ and the result of `git merge-base A M` is '1'.  Commit '2' is also a
 common ancestor between 'A' and 'M', but '1' is a better common ancestor,
 because '2' is an ancestor of '1'.  Hence, '2' is not a merge base.

+The result of `git merge-base --octopus A B C` is '2', because '2' is
+the best common ancestor of all commits.
+
 When the history involves criss-cross merges, there can be more than one
 'best' common ancestor for two commits.  For example, with this topology:

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 96dd160..4f30f1b 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -23,7 +23,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 }

 static const char * const merge_base_usage[] = {
-	"git merge-base [-a|--all] [--octopus] <commit> <commit>...",
+	"git merge-base [-a|--all] <commit> <commit>...",
+	"git merge-base [-a|--all] --octopus <commit>...",
 	"git merge-base --independent <commit>...",
 	NULL
 };
-- 
1.7.3.1.msysgit.0
