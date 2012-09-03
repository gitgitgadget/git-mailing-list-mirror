From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: checkout extra files
Date: Mon, 3 Sep 2012 15:42:11 +0200
Message-ID: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 15:42:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Wux-0001QV-3i
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 15:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab2ICNmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 09:42:12 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34705 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2ICNmL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 09:42:11 -0400
Received: by vbbff1 with SMTP id ff1so5347697vbb.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=12fsFVpQbsPptyRx26IsT568U2F5/otFCnJYgBxQkdk=;
        b=ocEVzklKx8PdbHkqvKATRMvYoJKZnVL64K7IfSCO+kMB54xZAVDWPmnohpnLETFzGR
         sz94E0KDh8v/iC1Ybob4SJANL3pwM1pRouzoqaUIVKtSkTE7RW9A5MtnCY/XO7gx2hhm
         z5plPxTNahG4jWLY9qtoef3HIeV/37pDHaGXK1yqWfvL21e/VrzDIBySzwzWvXHDZ8Ny
         Cx+TGfVtyYX8Q53SL++iMyMYFE6BZrDZUmM0WQylYyAmkuWA6KYv/5LN/xPGZQAvrU8K
         rpo0KBpBXJ2NmIoR/GVUQVrNqS0aCvltMi125p9TA3GI8utBc5+QB/kqQWWQOt45N4Fm
         jY2w==
Received: by 10.52.72.164 with SMTP id e4mr9820914vdv.103.1346679731149; Mon,
 03 Sep 2012 06:42:11 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Mon, 3 Sep 2012 06:42:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204692>

Hello,

the man page of git checkout states:

git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

It updates the named paths in the working tree from the index file or
from a named <tree-ish> ...

This means that for each file denoted by pathspec, git tries to
restore it from the tree-ish.
However, it seems that git does more than this: it restores also files
that are not denoted
by pathspec.
This sequence of commands shows it:

$ mkdir gittest
$ cd gittest
$ git init
Initialized empty Git repository in d:/gittest/.git/
$ touch f1
$ git add f1
$ git commit commit -m "first commit"
[master (root-commit) 94d882a] first commit
 0 files changed
 create mode 100644 f1
$ rm f1
$ git checkout 94d8 -- *
$ ls
f1

Note that the work directory is empty when the checkout is done, and
that the checkout restores f1
in it, a file that is not denoted by the * pathspec.
I guess that this is the intended behaviour, and that the man page
should be updated to tell exactly
what files git restores.

-Angelo Borsotti
