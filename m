From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] docs: Explain the purpose of fetch's and pull's <refspec> parameter.
Date: Thu,  5 Jun 2014 11:40:03 -0400
Message-ID: <1401982803-22346-1-git-send-email-marcnarc@xiplink.com>
References: <53908CE3.6080106@xiplink.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 17:40:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsZln-0006hS-QC
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 17:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbaFEPjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 11:39:55 -0400
Received: from domain.not.configured ([192.252.130.194]:14006 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750809AbaFEPjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 11:39:54 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id C341661CA4;
	Thu,  5 Jun 2014 11:39:52 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.dirty
In-Reply-To: <53908CE3.6080106@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250846>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-fetch.txt        |  4 ++--
 Documentation/pull-fetch-param.txt | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

On 14-06-04 06:17 PM, Junio C Hamano wrote:
> 
> Perhaps
> 
>     ... `remote.<repository>.fetch` values are used as the refspecs,
>     i.e. they specify what refs to fetch and what local refs to
>     update.
> 
> or something?

In fact, I like that so much I think it should be *the* description of
the <refspec> parameter.  Much better than just jumping straight into
the syntax.

This patch applies atop your 8/9.  I feel strongly that some kind of
reference should accompany this description, and your new CONFIGURED
REMOTE-TRACKING BRANCHES section seems like a good one for the fetch
variant, but since pull's variant doesn't have that section I just
made it link to fetch's doc.

(Also, I'm not sure if "CRTB" is a good link ID for your new section.)

		M.

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 4a735ab..a4cafa3 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -49,8 +49,8 @@ include::pull-fetch-param.txt[]
 include::urls-remotes.txt[]
 
 
-CONFIGURED REMOTE-TRACKING BRANCHES
------------------------------------
+CONFIGURED REMOTE-TRACKING BRANCHES[[CRTB]]
+-------------------------------------------
 
 You would often interact with the same remote repository by
 regularly and repeatedly fetching from it.  In order to keep track
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 18cffc2..40304c6 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -12,9 +12,20 @@ ifndef::git-pull[]
 endif::git-pull[]
 
 <refspec>::
-	The format of a <refspec> parameter is an optional plus
-	`+`, followed by the source ref <src>, followed
-	by a colon `:`, followed by the destination ref <dst>.
+	Specifies which refs to fetch and which local refs to update.
+	<refspec> parameters are not normally specified on the command
+	line, but instead are read from `remote.<repository>.fetch`
+	configuration variables
+ifndef::git-pull[]
+	(see <<CRTB,CONFIGURED REMOTE-TRACKING BRANCHES>> below).
+endif::git-pull[]
+ifdef::git-pull[]
+	(see linkgit:git-fetch[1]).
+endif::git-pull[]
++
+The format of a <refspec> parameter is an optional plus
+`+`, followed by the source ref <src>, followed
+by a colon `:`, followed by the destination ref <dst>.
 +
 The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
-- 
2.0.0.dirty
