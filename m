From: Hannu Koivisto <azure@iki.fi>
Subject: git rebase -i (and gitk) problem in Windows/Cygwin
Date: Tue, 07 Apr 2009 17:18:20 +0300
Organization: NOYB
Message-ID: <831vs4im37.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 16:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrC9r-0003ML-Mo
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 16:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbZDGOSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 10:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbZDGOSh
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 10:18:37 -0400
Received: from main.gmane.org ([80.91.229.2]:43356 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbZDGOSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 10:18:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LrC8F-0001j0-7P
	for git@vger.kernel.org; Tue, 07 Apr 2009 14:18:31 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:18:31 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:18:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:CbflB5t/G5/Kt1AZjC4/N8w4st0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115958>

Greetings,

With current git.git (1.6.2.2.446.gfbdc0) built for Cygwin, running
on Windows XP, executing the following commands...

mkdir test
cd test
git init

echo initial > kala.c
echo initial > sur.c
git add *.c
git commit -m "Initial commit."

echo addition >> kala.c
git commit -a -m "Kala addition 1."

echo addition >> sur.c
git commit -a -m "Sur addition."

echo addition2 >> kala.c
git commit -a -m "Kala addition 2."

git rebase -i HEAD~3

...and moving commit "Kala addition 2." right after "Kala addition
1." and marking it to be squashed results to

---8<----------------------------------------------------
error: Entry 'kala.c' not uptodate. Cannot merge.
fatal: merging of trees 787519579d90e45dfee00189985fa8c92f56be8f and 83f124d88764604c7d348e73103168bd98665e56 failed

Could not apply 14eb9c7... Kala addition 2.
---8<----------------------------------------------------

rebase -i used to work fine earlier, but unfortunately I don't
remember which version I used back then (1.6.something).

This problem doesn't occur on Linux with the same git version.

I don't know if it might be related (I suppose it could be because
of that "...not uptodate" message) but I also see the following
behaviour with gitk:

* I change a file in workspace.
* I "Update" in gitk - I see the change.
* I undo the change.
* I "Update" in gitk - I see an empty change.
* "Reload" doesn't help - I still se an empty change.
* I run "git status" on the command line and then select "Update"
  in gitk -> now the change disappears.

-- 
Hannu
