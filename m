From: "Ron Parker" <rdparker@gmail.com>
Subject: [PATCH] Use symlinks with rsync in core tutorial
Date: Mon, 20 Feb 2006 18:37:23 -0600
Message-ID: <1cf1c57a0602201637g161bbc41x732675573c0b42d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Feb 21 01:37:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBLWy-0001cG-MF
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 01:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161209AbWBUAhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 19:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWBUAhZ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 19:37:25 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:47635 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161209AbWBUAhZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 19:37:25 -0500
Received: by xproxy.gmail.com with SMTP id t12so786567wxc
        for <git@vger.kernel.org>; Mon, 20 Feb 2006 16:37:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t+V1MdBEeyUQowKtJB4OIjNca8w1V6DBiiVy1RuoxMuoQLEW0Eah1PDRD9vJpLaREMH5nT957lbBOs+gvY4PfAuw6Vx5+m9jlCd2+jpfy/sSgJGiHA2eISjBitFJcwuoTV6808H3B1PyiYMOSk7QvOz2xvvDWVcHyw060ojT+P4=
Received: by 10.70.51.19 with SMTP id y19mr4194981wxy;
        Mon, 20 Feb 2006 16:37:24 -0800 (PST)
Received: by 10.70.88.3 with HTTP; Mon, 20 Feb 2006 16:37:23 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16513>

From: Ron Parker <rdp@inthefaith.net>
Date: Mon Feb 20 18:05:39 2006 -0600

* Documentation/core-tutorial.txt: Use rsync -rl instead of -rL.

Signed-off-by: Ron Parker <rdp@inthefaith.net>


---

I think there is a typo in the core tutorial. It appears that symlinks
must be preserved when doing an rsync otherwise HEAD does not point to
the right ref, it becomes a copy of it. If I:

$ rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ .git

Then when IS

$ git-read-tree HEAD
fatal: Not a git repository

is what I get.  However, doing:

$ rsync -rl ...

seems to work. The only noticeable difference is that the second
creates HEAD as a symlink.

  Documentation/core-tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

79ac94c0b7f8e195cf07a51c393115e7d0636069
diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 4211c81..461f845 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -724,7 +724,7 @@ create your own copy of the git reposito
 ----------------
  $ mkdir my-git
  $ cd my-git
-$ rsync -rL rsync://rsync.kernel.org/pub/scm/git/git.git/ .git
+$ rsync -rl rsync://rsync.kernel.org/pub/scm/git/git.git/ .git
 ----------------

 followed by
--
1.2.1
