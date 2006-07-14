From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] urls.txt: Use substitution to escape square brackets
Date: Fri, 14 Jul 2006 16:42:35 -0700
Message-ID: <7v3bd3ois4.fsf@assigned-by-dhcp.cox.net>
References: <11528726881431-git-send-email-alp@atoker.com>
	<20060714215039.GA21994@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alp Toker <alp@atoker.com>
X-From: git-owner@vger.kernel.org Sat Jul 15 01:42:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1XJ6-0000CB-Jx
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 01:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWGNXmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 19:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945918AbWGNXmh
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 19:42:37 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63427 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1945906AbWGNXmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 19:42:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714234236.WNUH2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 19:42:36 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060714215039.GA21994@diku.dk> (Jonas Fonseca's message of
	"Fri, 14 Jul 2006 23:50:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23917>

Alp is right -- the comments in [attributes] section after the
definition do appear in the output, even with asciidoc 7.1.2, so
here is a replacement proposal from me.

The one by Alp is an easy work-around, but I do not want to
worry about potential, unintended, breakages that might be
caused by changing delimited blocks to literal paragraphs (and
it changes the resulting rendering from the original).

-- >8 --
From: Jonas Fonseca <fonseca@diku.dk>

This changes "[user@]" to use {startsb} and {endsb} to insert [ and ],
similar to how {caret} is used in git-rev-parse.txt.

[jc: Removed a well-intentioned comment that broke the final
 formatting from the original patch.  While we are at it,
 updated the paragraph that claims to be equivalent to the
 section that was updated earlier without making matching
 changes.]

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/asciidoc.conf |    2 ++
 Documentation/urls.txt      |   17 +++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 7ce7151..8196d78 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -9,6 +9,8 @@ # the command.
 
 [attributes]
 caret=^
+startsb=&#91;
+endsb=&#93;
 
 ifdef::backend-docbook[]
 [gitlink-inlinemacro]
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 9d2ad46..26ecba5 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,20 +10,21 @@ to name the remote repository:
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~/path/to/repo.git
+- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
+- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
+- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
 ===============================================================
 
-SSH Is the default transport protocol and also supports an
-scp-like syntax.  Both syntaxes support username expansion,
+SSH is the default transport protocol.  You can optionally specify
+which user to log-in as, and an alternate, scp-like syntax is also
+supported.  Both syntaxes support username expansion,
 as does the native git protocol. The following three are
 identical to the last three above, respectively:
 
 ===============================================================
-- host.xz:/path/to/repo.git/
-- host.xz:~user/path/to/repo.git/
-- host.xz:path/to/repo.git
+- {startsb}user@{endsb}host.xz:/path/to/repo.git/
+- {startsb}user@{endsb}host.xz:~user/path/to/repo.git/
+- {startsb}user@{endsb}host.xz:path/to/repo.git
 ===============================================================
 
 To sync with a local directory, use:
-- 
1.4.1.g28ec
