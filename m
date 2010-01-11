From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/6] Documentation: merge: add a section about fast-forward
Date: Mon, 11 Jan 2010 02:39:40 -0600
Message-ID: <20100111083940.GE23806@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
 <20100111021322.GA8480@progeny.tock>
 <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
 <20100111041318.GA9806@progeny.tock>
 <20100111082123.GA23742@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 09:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFoO-0003XE-0T
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab0AKIjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 03:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310Ab0AKIjk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:39:40 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:45974 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab0AKIjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 03:39:39 -0500
Received: by iwn32 with SMTP id 32so4481140iwn.33
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 00:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+9tzknZA9o5bMNq1UoLdNZB4QDDj99O99FSXIKZYqXQ=;
        b=UclsN84Novtm0I212fIg+F1IplIhmQy54Os02OsBfvWp2DBa6Xm4PMGe9dYiXToJgl
         12klu6OJH+WQM8zsBX50z65hAiGLli+eKclUns8UlXlIhyzWgjW6XJ5jsbOpC9CUvs+K
         ZAXg3TsQVbhiKLnYJG4vZNjx+x9JjNZFbnLR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=scBX3FdD7XW3woPIxxSrB7P451Yw64QiYu1VYxIfDBDmMuiSd/GVKudHCqbAIIYLCo
         jlHob77Md0ok7VSz6ZZ7YkjrQkz7CRivVvYa6LIRQQ5FvSyAPQPCncZUQaLGECEWmIu2
         EdWmFDmgNn76uqokporCLkArRgPI/Q+9omEUI=
Received: by 10.231.122.103 with SMTP id k39mr2304107ibr.10.1263199178978;
        Mon, 11 Jan 2010 00:39:38 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm3530090iwn.13.2010.01.11.00.39.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 00:39:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100111082123.GA23742@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136621>

Novices sometimes find the behavior of 'git merge' in the
fast-forward case surprising.  Add a section to the manual to
describe it more thoroughly.

Cc: Petr Baudis <pasky@suse.cz>,
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-merge.txt |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 8950aa4..ec9c6d3 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -82,6 +82,20 @@ the same state that would result from the merge anyway.)
 If all named commits are already ancestors of `HEAD`, 'git merge'
 will exit early with the message "Already up-to-date."
 
+FAST-FORWARD MERGE
+------------------
+
+Often the current branch head is an ancestor of the named commit.
+This is the most common case especially when invoked from 'git
+pull': you are tracking an upstream repository, you have committed
+no local changes, and now you want to update to a newer upstream
+revision.  In this case, a new commit is not needed to store the
+combined history; instead, the `HEAD` (along with the index) is
+updated to point at the named commit, without creating an extra
+merge commit.
+
+This behavior can be suppressed with the `--no-ff` option.
+
 include::merge-strategies.txt[]
 
 
@@ -94,19 +108,10 @@ HOW MERGE WORKS
 A merge is always between the current `HEAD` and one or more
 commits (usually, branch head or tag).
 
-Two kinds of merge can happen:
-
-* `HEAD` is already contained in the merged commit. This is the
-  most common case especially when invoked from 'git pull':
-  you are tracking an upstream repository, have committed no local
-  changes and now you want to update to a newer upstream revision.
-  Your `HEAD` (and the index) is updated to point at the merged
-  commit, without creating an extra merge commit.  This is
-  called "Fast-forward".
-
-* Both the merged commit and `HEAD` are independent and must be
-  tied together by a merge commit that has both of them as its parents.
-  The rest of this section describes this "True merge" case.
+Except in a fast-forward merge (see above), the branches to be
+merged must be tied together by a merge commit that has both of them
+as its parents.
+The rest of this section describes this "True merge" case.
 
 The chosen merge strategy merges the two commits into a single
 new source tree.
-- 
1.6.6
