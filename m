From: Jason Merrill <jason@redhat.com>
Subject: [PATCH v2] Documentation: clarify .gitattributes search
Date: Mon, 06 Apr 2009 11:03:36 -0400
Message-ID: <49DA19C8.5010308@redhat.com>
References: <49D96C63.9070200@redhat.com> <7viqlicp1y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030604000803010706010809"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 17:06:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqqOz-0008HO-OC
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 17:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZDFPEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 11:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbZDFPEo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 11:04:44 -0400
Received: from mx2.redhat.com ([66.187.237.31]:59507 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbZDFPEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 11:04:43 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n36F3dFb022335;
	Mon, 6 Apr 2009 11:03:39 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n36F3d0g007799;
	Mon, 6 Apr 2009 11:03:40 -0400
Received: from [127.0.0.1] (sebastian-int.corp.redhat.com [172.16.52.221])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n36F3b8L021509;
	Mon, 6 Apr 2009 11:03:38 -0400
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7viqlicp1y.fsf@gitster.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115844>

This is a multi-part message in MIME format.
--------------030604000803010706010809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
>  (2) also wondered why you were confused to think if your home directory
>      (for that matter, any higher directory, like /.gitattributes at the
>      filesystem root level) that is clearly outside of the project could
>      possibly affect what happens inside a project; and

Because it would be useful if it did; specifically, it would be 
convenient to be able to say that ChangeLog files use 
git-merge-changelog wherever they appear, and not have to repeat that in 
all my projects.  I didn't really expect it, but thought that maybe it 
was designed to work that way.

>  (3) was puzzled why you do not have any patch to description of ignore
>      files (perhaps you do not even a similar confusion on them).

I hadn't really thought about them, but looking at the documentation now 
I see that ignore files have the core.excludesfile config variable to 
provide global ignores; there doesn't seem to be anything analogous for 
attributes.

>  (1) To a long-time git person, "up to the root" is obviously talking
>      about the toplevel of the work tree, not "root of the filesystem",
>      but is it clear to _you_ (or do you think it would be clear to
>      somebody else without much previous exposure to git)?

It seems clear enough, as it would be pointless to say it if it meant 
the root of the filesystem.

>  (2) If not, I think we should come up with a good wording and use that in
>      both.  How does the "toplevel of the work tree" sound for that
>      purpose?

Sure, I'll use that.



--------------030604000803010706010809
Content-Type: text/x-patch;
 name="0001-Documentation-clarify-.gitattributes-search.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Documentation-clarify-.gitattributes-search.patch"

Use the term "toplevel of the work tree" in gitattributes.txt and
gitignore.txt to define the limits of the search for those files.

Signed-off-by: Jason Merrill <jason@redhat.com>
---
 Documentation/gitattributes.txt |    6 +++---
 Documentation/gitignore.txt     |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 55668e3..b762bba 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -60,9 +60,9 @@ same as in `.gitignore` files; see linkgit:gitignore[5].
 When deciding what attributes are assigned to a path, git
 consults `$GIT_DIR/info/attributes` file (which has the highest
 precedence), `.gitattributes` file in the same directory as the
-path in question, and its parent directories (the further the
-directory that contains `.gitattributes` is from the path in
-question, the lower its precedence).
+path in question, and its parent directories up to the toplevel of the
+work tree (the further the directory that contains `.gitattributes`
+is from the path in question, the lower its precedence).
 
 If you wish to affect only a single repository (i.e., to assign
 attributes to files that are particular to one user's workflow), then
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 59321a2..7df3cef 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -31,8 +31,8 @@ precedence, the last matching pattern decides the outcome):
 
  * Patterns read from a `.gitignore` file in the same directory
    as the path, or in any parent directory, with patterns in the
-   higher level files (up to the root) being overridden by those in
-   lower level files down to the directory containing the file.
+   higher level files (up to the toplevel of the work tree) being overridden
+   by those in lower level files down to the directory containing the file.
    These patterns match relative to the location of the
    `.gitignore` file.  A project normally includes such
    `.gitignore` files in its repository, containing patterns for
-- 
1.6.2.2


--------------030604000803010706010809--
