From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH] git-push.txt: describe how to default to pushing only
 current branch
Date: Fri, 13 Mar 2009 20:27:31 -0500
Message-ID: <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com>
References: <20090313164941.GA16504@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 02:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiIku-0004EE-VU
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 02:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762411AbZCNBaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 21:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762399AbZCNBai
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 21:30:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbZCNBag (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 21:30:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B47155D30;
	Fri, 13 Mar 2009 21:30:34 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.201.178.103]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 34FE75D2F; Fri, 13 Mar 2009 21:30:31 -0400 (EDT)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <20090313164941.GA16504@sigill.intra.peff.net>
X-Pobox-Relay-ID: B701ECC4-1037-11DE-97D9-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113231>

---
Jeff King <peff@peff.net> writes:
>   git config remote.$remote.push HEAD
> 
> It isn't mentioned in the git-push manpage; maybe a documentation
> patch to give an example using HEAD would make sense?

Here is a patch. It also attempts to document bare 'git push'.

In the resulting manpage the inline commands are not very
obvious (the HTML looks OK though). There is some sort of
formatting in there, but it does not seem to display any
differently from the surrounding text when I use man to view it
on my system.  Would it be better to do something like wrap
double quotes around the inline commands to help readers viewing
the manpage?
---
 Documentation/git-push.txt |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4e7e5a7..fd53c49 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -24,8 +24,8 @@ every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
 
 
-OPTIONS
--------
+OPTIONS[[OPTIONS]]
+------------------
 <repository>::
 	The "remote" repository that is destination of a push
 	operation.  This parameter can be either a URL
@@ -187,6 +187,28 @@ reason::
 Examples
 --------
 
+git push::
+	Works like `git push <remote>`, where <remote> is the
+	current branch's remote (or `origin`, if no remote is
+	configured for the current branch).
+
+git push origin::
+	Without additional configuration, works like
+	`git push origin :`.
++
+The default behavior of this command when no <refspec> is given can be
+configured by setting the `push` option of the remote.
++
+For example, to default to pushing only the current branch to `origin`
+use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
+the ones in the examples below) can be configured as the default for
+`git push origin`.
+
+git push origin :::
+	Push "matching" branches to `origin`. See
+	<refspec> in the <<OPTIONS,OPTIONS>> section above for a
+	description of "matching" branches.
+
 git push origin master::
 	Find a ref that matches `master` in the source repository
 	(most likely, it would find `refs/heads/master`), and update
-- 
1.6.2
