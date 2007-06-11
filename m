From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [PATCH 5/5] Add gitmodules(5)
Date: Mon, 11 Jun 2007 02:04:01 +0200
Message-ID: <op.ttqc4znc9pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXLq-0000iZ-HO
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761099AbXFKABf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761073AbXFKABf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:01:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:21533 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760795AbXFKABe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2007 20:01:34 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1357787ugf
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 17:01:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=bUrnqACxAmfxp7FZrri/GrunY5+/J9jxv9Nao0smW7VEnPfPPvAv9ttzQHr25wpUA6TOCXPe5z84pKBqlc8psnUBqR2gtDL43XlbqfY+534dg3S/iFAUg2S5uxYLzrhokKvvaDy+ZG2NtAKnrZEyAbpIzKqrBMROrMOAwMmDIsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:from:content-type:mime-version:content-transfer-encoding:date:message-id:user-agent;
        b=WX8uiru7U8nN4sBe4kz7KW13zxKChmZuVVuuqrAPJcJAShy7taG88H0xs5kulJbA6Gn7fP8L2+jm9BbZ+m5pxMTdDPGsLpkY+QM8PWkSIzRWOy9/GqzkWBedTOHm6moA43zdJNv1ZVtTuUadhMolz48QzQF1UEm50/292Ebo2JI=
Received: by 10.66.221.6 with SMTP id t6mr4718959ugg.1181520093240;
        Sun, 10 Jun 2007 17:01:33 -0700 (PDT)
Received: from localhost ( [88.88.169.227])
        by mx.google.com with ESMTP id z34sm12463483ikz.2007.06.10.17.01.31
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2007 17:01:32 -0700 (PDT)
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49800>

This adds documentation for the .gitmodules file.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
  Documentation/Makefile       |    2 +-
  Documentation/gitmodules.txt |   62 ++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 63 insertions(+), 1 deletions(-)
  create mode 100644 Documentation/gitmodules.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9cef480..2ad18e0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@ MAN1_TXT= \
  	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
  		$(wildcard git-*.txt)) \
  	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt
  MAN7_TXT=git.txt

  DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
new file mode 100644
index 0000000..6c7d9bf
--- /dev/null
+++ b/Documentation/gitmodules.txt
@@ -0,0 +1,62 @@
+gitmodules(5)
+=============
+
+NAME
+----
+gitmodules - defining submodule properties
+
+SYNOPSIS
+--------
+.gitmodules
+
+
+DESCRIPTION
+-----------
+
+The `.gitmodules` file, located in the top-level directory of a git
+working tree, is a text file with a syntax matching the requirements
+of gitlink:git-config[1].
+
+The file contains one subsection per submodule, and the subsection value
+is the name of the submodule. Each submodule section also contains the
+following required keys:
+
+submodule.<name>.path::
+	Defines the path, relative to the top-level directory of the git
+	working tree, where the submodule is expected to be checked out.
+	The path name must not end with a `/`. All submodule paths must
+	be unique within the .gitmodules file.
+
+submodule.<name>.url::
+	Defines an url from where the submodule repository can be cloned.
+
+
+EXAMPLES
+--------
+
+Consider the following .gitmodules file:
+
+	[submodule 'libfoo']
+		path = include/foo
+		url = git://foo.com/git/lib.git
+
+	[submodule 'libbar']
+		path = include/bar
+		url = git://bar.com/git/lib.git
+
+
+This defines two submodules, `libfoo` and `libbar`. These are expected to
+be checked out in the paths 'include/foo' and 'include/bar', and for both
+submodules an url is specified which can be used for cloning the submodules.
+
+SEE ALSO
+--------
+gitlink:git-submodule[1] gitlink:git-config[1]
+
+DOCUMENTATION
+-------------
+Documentation by Lars Hjemli <hjemli@gmail.com>
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.2.1.914.gbd3a7
