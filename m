From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Add man page for git-show-ref
Date: Mon, 18 Sep 2006 14:32:41 +0200
Message-ID: <20060918123241.GA8238@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 18 14:33:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPIJF-0001Jn-Kj
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 14:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWIRMcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 08:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWIRMcr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 08:32:47 -0400
Received: from [130.225.96.91] ([130.225.96.91]:12446 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S965123AbWIRMcr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 08:32:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 8D684770085
	for <git@vger.kernel.org>; Mon, 18 Sep 2006 14:32:43 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25867-06 for <git@vger.kernel.org>; Mon, 18 Sep 2006 14:32:41 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 95794770037
	for <git@vger.kernel.org>; Mon, 18 Sep 2006 14:32:41 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id EF19D6DFD6D
	for <git@vger.kernel.org>; Mon, 18 Sep 2006 14:30:52 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7B0E662A33; Mon, 18 Sep 2006 14:32:41 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27245>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-show-ref.txt |  136 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 136 insertions(+), 0 deletions(-)

Mostly paraphrasing Linus' commit message ...

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
new file mode 100644
index 0000000..529ea17
--- /dev/null
+++ b/Documentation/git-show-ref.txt
@@ -0,0 +1,136 @@
+git-show-ref(1)
+===============
+
+NAME
+----
+git-show-ref - List references in a local repository
+
+SYNOPSIS
+--------
+[verse]
+'git-show-ref' [-q|--quiet] [--verify] [-h|--head] [-d|--dereference]
+	     [--tags] [--heads] [--] <pattern>...
+
+DESCRIPTION
+-----------
+
+Displays references available in a local repository along with the associated
+commit IDs. Results can be filtered using a pattern and tags can be
+dereferenced into object IDs. Additionally, it can be used to test whether a
+particular ref exists.
+
+Use of this utility is encouraged in favor of directly accessing files under
+in the `.git` directory.
+
+OPTIONS
+-------
+
+-h, --head::
+
+	Show the HEAD reference.
+
+--tags, --heads::
+
+	Limit to only "refs/heads" and "refs/tags", respectively.  These
+	options are not mutually exclusive; when given both, references stored
+	in "refs/heads" and "refs/tags" are displayed.
+
+-d, --dereference::
+
+	Dereference tags into object IDs. They will be shown with "^{}"
+	appended.
+
+--verify::
+
+	Enable stricter reference checking by requiring an exact ref path.
+	Aside from returning an error code of 1, it will also print an error
+	message if '--quiet' was not specified.
+
+-q, --quiet::
+
+	Do not print any results to stdout. When combined with '--verify' this
+	can be used to silently check if a reference exists.
+
+<pattern>::
+
+	Show references matching one or more patterns.
+
+OUTPUT
+------
+
+The output is in the format: '<SHA-1 ID>' '<space>' '<reference name>'.
+
+-----------------------------------------------------------------------------
+$ git show-ref --head --dereference
+832e76a9899f560a90ffd62ae2ce83bbeff58f54 HEAD
+832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/heads/master
+832e76a9899f560a90ffd62ae2ce83bbeff58f54 refs/heads/origin
+3521017556c5de4159da4615a39fa4d5d2c279b5 refs/tags/v0.99.9c
+6ddc0964034342519a87fe013781abf31c6db6ad refs/tags/v0.99.9c^{}
+055e4ae3ae6eb344cbabf2a5256a49ea66040131 refs/tags/v1.0rc4
+423325a2d24638ddcc82ce47be5e40be550f4507 refs/tags/v1.0rc4^{}
+...
+-----------------------------------------------------------------------------
+
+EXAMPLE
+-------
+
+To show all references called "master", whether tags or heads or anything
+else, and regardless of how deep in the reference naming hierarchy they are,
+use:
+
+-----------------------------------------------------------------------------
+	git show-ref master
+-----------------------------------------------------------------------------
+
+This will show "refs/heads/master" but also "refs/remote/other-repo/master",
+if such references exists.
+
+When using the '--verify' flag, the command requires an exact path:
+
+-----------------------------------------------------------------------------
+	git show-ref --verify refs/heads/master
+-----------------------------------------------------------------------------
+
+will only match the exact branch called "master".
+
+If nothing matches, gitlink:git-show-ref[1] will return an error code of 1,
+and in the case of verification, it will show an error message.
+
+For scripting, you can ask it to be quiet with the "--quiet" flag, which
+allows you to do things like
+
+-----------------------------------------------------------------------------
+	git-show-ref --quiet --verify -- "refs/heads/$headname" ||
+		echo "$headname is not a valid branch"
+-----------------------------------------------------------------------------
+
+to check whether a particular branch exists or not (notice how we don't
+actually want to show any results, and we want to use the full refname for it
+in order to not trigger the problem with ambiguous partial matches).
+
+To show only tags, or only proper branch heads, use "--tags" and/or "--heads"
+respectively (using both means that it shows tags and heads, but not other
+random references under the refs/ subdirectory).
+
+To do automatic tag object dereferencing, use the "-d" or "--dereference"
+flag, so you can do
+
+-----------------------------------------------------------------------------
+	git show-ref --tags --dereference
+-----------------------------------------------------------------------------
+
+to get a listing of all tags together with what they dereference.
+
+SEE ALSO
+--------
+gitlink:git-ls-remote[1], gitlink:git-peek-remote[1]
+
+AUTHORS
+-------
+Written by Linus Torvalds <torvalds@osdl.org>.
+Man page by Jonas Fonseca <fonseca@diku.dk>.
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.4.2.1.gca4e

-- 
Jonas Fonseca
