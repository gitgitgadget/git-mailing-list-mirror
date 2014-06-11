From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] docs: Explain the purpose of fetch's and pull's <refspec> parameter.
Date: Wed, 11 Jun 2014 10:24:04 -0400
Message-ID: <1402496644-15633-1-git-send-email-marcnarc@xiplink.com>
References: <xmqq61kfroow.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 16:23:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WujRH-0003gp-8V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 16:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbaFKOXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 10:23:39 -0400
Received: from domain.not.configured ([192.252.130.194]:60503 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755484AbaFKOXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 10:23:38 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 22193617E2;
	Wed, 11 Jun 2014 10:23:37 -0400 (EDT)
X-Mailer: git-send-email 2.0.0.dirty
In-Reply-To: <xmqq61kfroow.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251370>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-fetch.txt        |  4 ++--
 Documentation/pull-fetch-param.txt | 18 ++++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

On 14-06-05 06:12 PM, Junio C Hamano wrote:
> 
>> +	<refspec> parameters are not normally specified on the command
>> +	line, but instead are read from `remote.<repository>.fetch`
> 
> I however am not sure if this is an improvement, especially the
> "normally" part.  Those who respond to a git-pull-request output
> might be fewer than those who send pull requests, but that does not
> mean they are abnormal.
> 
> 	The command line often omit <refspec> parameters when
> 	fetching or pulling from a remote you regularly interact
> 	with, in which case `remote.<repository>.fetch` values are
> 	used instead.
> 
> would be OK, though.
> 
> Later today I'll push out the series on 'pu' after amending them
> with your comments so far.  It would be nice if you can reroll this
> on top of the updated one ("git log --oneline --first-parent
> master..pu" and find jc/fetch-pull-refmap in there).

Here's the reroll.  I used completely different phrasing but I think
I still captured the gist of what you said.

(Apologies for the delay -- I was looking for jc/fetch-pull-refmap on pu,
not jc/fetch-push-refmap on next!)

		M.


diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 629a1cf..8deb614 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -51,8 +51,8 @@ include::pull-fetch-param.txt[]
 include::urls-remotes.txt[]
 
 
-CONFIGURED REMOTE-TRACKING BRANCHES
------------------------------------
+CONFIGURED REMOTE-TRACKING BRANCHES[[CRTB]]
+-------------------------------------------
 
 You often interact with the same remote repository by
 regularly and repeatedly fetching from it.  In order to keep track
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 4bff65b..1ebbf1d 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -12,10 +12,20 @@ ifndef::git-pull[]
 endif::git-pull[]
 
 <refspec>::
-	The format of a <refspec> parameter is an optional plus
-	`+`, followed by the source ref <src>, followed
-	by a colon `:`, followed by the destination ref <dst>.
-	The colon can be omitted when <dst> is empty.
+	Specifies which refs to fetch and which local refs to update.
+	When no <refspec>s appear on the command line, the refs to fetch
+	are read from `remote.<repository>.fetch` variables instead
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
+The colon can be omitted when <dst> is empty.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`;
 it requests fetching everything up to the given tag.
-- 
2.0.0.dirty
