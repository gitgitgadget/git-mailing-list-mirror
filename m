From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 3/3] Add --oneline that is a synonym to "--pretty=oneline --abbrev-commit"
Date: Tue, 24 Feb 2009 18:59:16 +0900
Message-ID: <20090224185916.6117@nanako3.lavabit.com>
References: <20090224185913.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 11:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbuAo-0005UU-DT
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 11:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754400AbZBXKD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 05:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbZBXKDz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 05:03:55 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58802 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbZBXKDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 05:03:53 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 9AB0911B900
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 04:03:51 -0600 (CST)
Received: from 2293.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 56W3814RY1YJ
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 04:03:51 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ix3S8MVZFI4nDWdLAttr4SpeihRuAt0TgPcWk4/2ZVqXf4K1c1LBYWzAr6CkX+6C42bmvYh7NnKyuqyBwaVjeXI/pLHyfgjZACTKhx3kWUqv5EHVn2lH6Sn5YuPtgVLAvNDBbijH953UAtOKBjHjYhteO2+Av2SN2wcTnyIC0vI=;
  h=From:To:In-Reply-To:References:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090224185913.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111277>

These two are often used together but are too long to type.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/pretty-options.txt |    4 ++++
 revision.c                       |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 6596019..b0ea68a 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -18,6 +18,10 @@ configuration (see linkgit:git-config[1]).
 This should make "--pretty=oneline" a whole lot more readable for
 people using 80-column terminals.
 
+--oneline::
+	This is a shorthand for "--pretty=oneline --abbrev-commit"
+	used together.
+
 --encoding[=<encoding>]::
 	The commit objects record the encoding used for the log message
 	in their encoding header; this option can be used to tell the
diff --git a/revision.c b/revision.c
index 556c319..c4efe5b 100644
--- a/revision.c
+++ b/revision.c
@@ -1147,6 +1147,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+9, revs);
+	} else if (!strcmp(arg, "--oneline")) {
+		revs->verbose_header = 1;
+		get_commit_format("oneline", revs);
+		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--graph")) {
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
-- 
1.6.2.rc1

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
