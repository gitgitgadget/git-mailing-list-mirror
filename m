From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFH] GSoC 2015 application
Date: Thu, 19 Feb 2015 11:32:46 +0100
Message-ID: <vpqzj8ary29.fsf@anie.imag.fr>
References: <20150218191417.GA7767@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:33:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOOPv-0000s4-M9
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 11:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbbBSKdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 05:33:06 -0500
Received: from mx1.imag.fr ([129.88.30.5]:34933 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbbBSKdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 05:33:00 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1JAWjM5025401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Feb 2015 11:32:45 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1JAWkbX009246;
	Thu, 19 Feb 2015 11:32:46 +0100
In-Reply-To: <20150218191417.GA7767@peff.net> (Jeff King's message of "Wed, 18
	Feb 2015 14:14:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 19 Feb 2015 11:32:45 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1JAWjM5025401
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1424946768.21759@S+gdRKx15dcpH6Z/ND0COw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264089>

Jeff King <peff@peff.net> writes:

> I do need somebody to volunteer as backup admin. This doesn't need
> to involve any specific commitment, but is mostly about what to do if I
> get hit by a bus.

If you promise me to try hard not to be hit by a bus and no one else
steps in, I can be the backup admin.

> Where I really need help now is in the "ideas" page:
>
>   http://git.github.io/SoC-2015-Ideas.html

Throwing out a few ideas for discussion, I can write something if people
agree.

* "git bisect fixed/unfixed", to allow bisecting a fix instead of a
  regression less painfully. There were already some proposed patches
  ( https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#git_bisect_fix.2Funfixed ),
  so it shouldn't be too hard. Perhaps this item can be included in the
  "git bisect --first-parent" idea (turning it into "git bisect
  improvements").

* Be nicer to the user on tracked/untracked merge conflicts

  I've had it on
  https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#Be_nicer_to_the_user_on_tracked.2Funtracked_merge_conflicts
  for a while but never got someone to do it.

    "When merging a commit which has tracked files with the same name as local untracked files, Git refuses to proceed. It could be nice to:

    - Accept the situation without conflict when the tracked file has
      the exact same content as the local untracked file (which would
      become tracked). No data is lost, nothing can be committed
      accidentally.

    - Possibly, for fast-forward merges, if a local files belongs to the
      index but not to the last commit, attempt a merge between the
      upstream version and the local one (resulting in the same content
      as if the file had just been committed, but without introducing an
      extra commit). 

    Recent versions SVN do something similar: on update, it considers
    added but not committed files like normal tracked files, and
    attempts a merge of the upstream version with the local one (which
    always succeeds when the files have identical content). Attempting a
    merge for non-fast forward cases would probably not make sense: it
    would mix changes coming from the merge with other changes that do
    not come from a commit."
  
  This shouldn't be technically too hard, but finding which behavior is
  right, where should things be customizeable and what the default value
  for the configuration should be will probably lead to interesting
  discussions. It contains two steps, which is good (all-or-nothing
  projects are much harder to deal with). The biggest drawback is that
  the first item may be simple for a GSoC while the second could be both
  controversial and hard to implement (depending on which solution is
  taken).

> and the list of microprojects:
>
>   http://git.github.io/SoC-2015-Microprojects.html

Here are a few ideas, based on
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

-- >8 --
From 513774754872436ea8b7eea63828b804c6a107e7 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Thu, 19 Feb 2015 10:48:06 +0100
Subject: [PATCH] 2015 microproject ideas

---
 SoC-2015-Microprojects.md | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/SoC-2015-Microprojects.md b/SoC-2015-Microprojects.md
index 8cb6a8f..1abf595 100644
--- a/SoC-2015-Microprojects.md
+++ b/SoC-2015-Microprojects.md
@@ -128,3 +128,45 @@ the user wanted.
 
 Because --graph is about connected history while --no-walk is about
 discrete points.  Cf. $gmane/216083
+
+### Move ~/.git-credentials and ~/.git-credential-cache to ~/.config/git
+
+Most of git dotfiles can be located, at the user's option, in
+~/.<file> or in ~/.config/git/<file>, following the [XDG
+standard](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html).
+~/.git-credentials and ~/.git-credential-cache are still hardcoded as
+~/.<file>, and should allow using the XDG directory layout too
+(~/.git-credentials could be allowed as ~/.config/git/credential and
+~/.git-credential-cache could be allowed as ~/.cache/git/credential,
+possibly modified by $XDG_CONFIG_HOME and $XDG_CACHE_HOME).
+
+Each of these files can be a microproject of its own. The suggested
+approach is:
+
+* See how XDG was implemented for other files (run "git log --grep
+  XDG" in Git's source code) and read the XDG specification.
+
+* Implement and test the new behavior, without breaking compatibility
+  with the old behavior.
+
+* Update the documentation
+
+### Add configuration options for some commonly used command-line options
+
+This includes:
+
+* git am -3
+
+* git am -c
+
+Some people always run the command with these options, and would
+prefer to be able to activate them by default in ~/.gitconfig.
+
+### Add more builtin patterns for userdiff
+
+"git diff" shows the function name corresponding to each hunk after
+the @@ ... @@ line. For common languages (C, HTML, Ada, Matlab, ...),
+the way to find the function name is built-in Git's source code as
+regular expressions (see userdiff.c). A few languages are common
+enough to deserve a built-in driver, but are not yet recognized. For
+example, CSS, shell.
-- 
2.0.2.737.gfb43bde



-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
