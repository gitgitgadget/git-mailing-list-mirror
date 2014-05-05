From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-helpers: add documentation for git-remote-hg/bzr
Date: Mon,  5 May 2014 15:23:49 -0500
Message-ID: <1399321429-4426-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 18:38:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi8z-0006KZ-3U
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbaEEUee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 16:34:34 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:38192 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbaEEUed (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 16:34:33 -0400
Received: by mail-oa0-f42.google.com with SMTP id j17so4705346oag.15
        for <git@vger.kernel.org>; Mon, 05 May 2014 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iEAw2mnDD0ix6a640URSxDiMZuRLh7Fdghz0SSK43oc=;
        b=ginCTS1ZlA+1XZPIu8kpaoSXX9wn9u96aR+E4OmLH7ydpv/+2OhsssxGYq2woJHzQH
         2qxTT1c4bkiZR7hR57b+lN0Zv89KTrjrc1YGMRQ954zbHSyshMf1AoqSlFo271xaJTHK
         pIcfYGYQmQbPrR3nKE4ENhQj0eA4hHxe135L2RAECO6XfHk5e93UyryJuJJnOD0SpOlV
         U4Pney9DAOySVFjf8R+PtXv4lQ7XVMawGsEozaHnmut+3kylSNUEHFVCzsyyusVBH8Pv
         jQVsNJFsLfbAgH53Lv1v9033KN8esowgQ9nxh0CG8CC3PuFeklvoM2IbxRv3M2zc68pa
         IVSw==
X-Received: by 10.182.205.226 with SMTP id lj2mr4341239obc.84.1399322072949;
        Mon, 05 May 2014 13:34:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id bj8sm21634692obb.7.2014.05.05.13.34.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 13:34:31 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.25.g15bd061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248144>

Mostly copied from my personal github wiki.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-remote-bzr.txt |  74 ++++++++++++++++++++++++
 Documentation/git-remote-hg.txt  | 121 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 Documentation/git-remote-bzr.txt
 create mode 100644 Documentation/git-remote-hg.txt

diff --git a/Documentation/git-remote-bzr.txt b/Documentation/git-remote-bzr.txt
new file mode 100644
index 0000000..b211e7f
--- /dev/null
+++ b/Documentation/git-remote-bzr.txt
@@ -0,0 +1,74 @@
+git-remote-bzr(1)
+================
+
+NAME
+----
+git-remote-bzr - bidirectional bridge between Git and Bazaar
+
+
+SYNOPSIS
+--------
+[verse]
+'git clone' bzr::<bzr repository>
+
+
+DESCRIPTION
+-----------
+
+This tool allows you to transparently clone, fetch and push to and from Bazaar
+repositories as if they were Git ones.
+
+To use it you simply need to use the "'bzr::'" prefix when specifying a remote URL
+(e.g. when cloning).
+
+
+EXAMPLE
+-------
+--------------------------------------
+git clone bzr::lp:ubuntu/hello
+--------------------------------------
+
+
+NOTES
+-----
+
+Remember to run `git gc --aggressive` after cloning a repository, specially if
+it's a big one. Otherwise lots of space will be wasted.
+
+The oldest version of Bazaar supported is 2.0. Older versions are not tested.
+
+Branches vs. repositories
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Bazaar's UI can clone only branches, but a repository can contain multiple
+branches, and 'git-remote-bzr' can clone both.
+
+For example, to clone a branch:
+
+-------------------------------------
+git clone bzr::bzr://bzr.savannah.gnu.org/emacs/trunk emacs-trunk
+-------------------------------------
+
+And to clone the whole repository:
+
+-------------------------------------
+git clone bzr::bzr://bzr.savannah.gnu.org/emacs emacs
+-------------------------------------
+
+The second command would clone all the branches contained in the emacs
+repository, however, it's possible to specify only certain branches:
+
+-------------------------------------
+git config remote-bzr.branches 'trunk, xwindow'
+-------------------------------------
+
+Some remotes don't support listing the branches contained in the repository, in
+which cases you need to manually specify the branches, and while you can
+specify the configuration in the clone command, you might find this easier:
+
+-------------------------------------
+git init emacs
+git remote add origin bzr::bzr://bzr.savannah.gnu.org/emacs
+git config remote-bzr.branches 'trunk, xwindow'
+git fetch
+-------------------------------------
diff --git a/Documentation/git-remote-hg.txt b/Documentation/git-remote-hg.txt
new file mode 100644
index 0000000..0cceb76
--- /dev/null
+++ b/Documentation/git-remote-hg.txt
@@ -0,0 +1,121 @@
+git-remote-hg(1)
+================
+
+NAME
+----
+git-remote-hg - bidirectional bridge between Git and Mercurial
+
+
+SYNOPSIS
+--------
+[verse]
+'git clone' hg::<hg repository>
+
+
+DESCRIPTION
+-----------
+
+This tool allows you to transparently clone, fetch and push to and from Mercurial
+repositories as if they were Git ones.
+
+To use it you simply need to use the "'hg::'" prefix when specifying a remote URL
+(e.g. when cloning).
+
+
+EXAMPLE
+-------
+------------
+$ git clone hg::http://selenic.com/repo/hello
+------------
+
+
+CONFIGURATION
+-------------
+
+If you want to see Mercurial revisions as Git commit notes:
+
+--------------------------------------
+% git config core.notesRef refs/notes/hg
+--------------------------------------
+
+If you are not interested in Mercurial permanent and global branches (aka. commit labels):
+
+--------------------------------------
+% git config --global remote-hg.track-branches false
+--------------------------------------
+
+With this configuration, the 'branches/foo' refs won't appear.
+
+If you want the equivalent of `hg clone --insecure`:
+
+--------------------------------------
+% git config --global remote-hg.insecure true
+--------------------------------------
+
+If you want 'git-remote-hg' to be compatible with 'hg-git', and generate exactly the same commits:
+
+--------------------------------------
+% git config --global remote-hg.hg-git-compat true
+--------------------------------------
+
+NOTES
+-----
+
+Remember to run `git gc --aggressive` after cloning a repository, specially if
+it's a big one. Otherwise lots of space will be wasted.
+
+The oldest version of Mercurial supported is 1.9. For the most part 1.8 works,
+but you might experience some issues.
+
+Pushing branches
+~~~~~~~~~~~~~~~~
+
+To push a Mercurial named branch, you need to use the "branches/" prefix:
+
+--------------------------------------
+% git checkout branches/next
+# do stuff
+% git push origin branches/next
+--------------------------------------
+
+All the pushed commits will receive the "next" Mercurial named branch.
+
+*Note*: Make sure you don't have +remote-hg.track-branches+ disabled.
+
+Cloning HTTPS
+~~~~~~~~~~~~~
+
+The simplest way is to specify the user and password in the URL:
+
+--------------------------------------
+git clone hg::https://user:password@bitbucket.org/user/repo
+--------------------------------------
+
+You can also use the http://mercurial.selenic.com/wiki/SchemesExtension[schemes extension]:
+
+--------------------------------------
+[auth]
+bb.prefix = https://bitbucket.org/user/
+bb.username = user
+bb.password = password
+--------------------------------------
+
+Finally, you can also use the
+https://pypi.python.org/pypi/mercurial_keyring[keyring extension].
+
+CAVEATS
+-------
+
+The only major incompatibility is that Git octopus merges (a merge with more
+than two parents) are not supported.
+
+Mercurial branches and bookmarks have some limitations of Git branches: you
+can't have both 'dev/feature' and 'dev' (as Git uses files and directories to
+store them).
+
+Multiple anonymous heads (which are useless anyway) are not supported; you
+would only see the latest head.
+
+Closed branches are not supported; they are not shown and you can't close or
+reopen. Additionally in certain rare situations a synchronization issue can
+occur (https://github.com/felipec/git/issues/65[Bug #65]).
-- 
1.9.2+fc1.25.g15bd061
