From: Patrick Doyle <wpdster@gmail.com>
Subject: How to recover a lost commit...
Date: Thu, 11 Nov 2010 11:29:10 -0500
Message-ID: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 17:30:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGa2D-0005kX-DU
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 17:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228Ab0KKQ3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 11:29:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65208 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab0KKQ3l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 11:29:41 -0500
Received: by fxm16 with SMTP id 16so1469666fxm.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=p94kiamMUMpawkp7SLf0zZAoSOIAiRjmXg1hCoVUaSI=;
        b=EOsTZ3TgXUEFeSO1w0EGdSZyB+iTsGvUZQRpS2RBnp3jKpEB95fVkkEoO8MEV/px3J
         ghqLA+XBt4vc9Tx9eBFiOk/lMyX2EUcrxJWSqEt9RaVRkstV63S7HUdWa4UPHpB8VvmN
         7+VAH4IrRCrFPp42MB5hwWKVNqBB69W9IVf7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=On7oovuu1LW7+h8xHaVyDsSlnY+r2siHDrh3GGq57HYGvAf3oh+oS5aPlOGv77CRwr
         bjTSXV8B2JjmjgQrOtV0lSMZ3erfCuY7VToRtnKrUMgZCErVkypvLAaJiD8uVR2E6UpV
         Czp1K8Xo8LLPyNcwvMzcy40H38kFWdahr+dVg=
Received: by 10.223.78.143 with SMTP id l15mr349075fak.30.1289492979328; Thu,
 11 Nov 2010 08:29:39 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Thu, 11 Nov 2010 08:29:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161266>

Help, I'm in a maze of twisty passages all alike...

Background: I just switched our project repository from SVN to git.  I
realized once I completed that that I had some work in progress on my
local machine that I had not checked in.  So I created a branch off of
master, copied the modified files into that branch, checked them in,
and switched back to master, where I did some other work.

Today I want to pick up where I left off with the work-in-progress (on
the "svn_to_git_wip" branch).  What I _really_ wanted to do was to
grab the contents of that branch, dump them into my working directory
for the master branch, and continue as if nothing had happened.  (This
is exactly the use case for which git-stash was created, and I
probably should have used that to begin with.)

So today I flailed around trying a couple of different approaches for
getting the work-in-progress (WIP) branch applied to the master
branch, without an associated commit, because I'm not ready to commit.
 As I was flailing, at one point I switched to the WIP branch, and
tried a rebase, to get it up to date wrt master.

I've just noticed however, that my work in progress, no longer seems
to be there, and I'm at a loss to understand why it disappeared.  I've
tried various checkouts to get it back (the commit containing it was
286f167).  I know I can recover from this by grabbing the original
commit.  I can also recover from this by grabbing the 1/2 dozen files
from the old SVN directory (which I've kept around just because I'm
paranoid like that).

But I'm curious... given the reflog show below... can any of you tell
what I did to myself to shoot myself in the foot?  Aside from "use git
stash next time dummy", is there any way I could have avoided this?

--wpd

$ git reflog
ce11719... HEAD@{0}: checkout: moving from master to svn_to_git_wip
40070a1... HEAD@{1}: checkout: moving from svn_to_git_wip to master
ce11719... HEAD@{2}: ce11719: updating HEAD
286f167... HEAD@{3}: 286f167: updating HEAD
d8c9d02... HEAD@{4}: checkout: moving from master to svn_to_git_wip
40070a1... HEAD@{5}: checkout: moving from
286f167944ee019c07885b3f0fbe46efd2dc68b2 to master
286f167... HEAD@{6}: checkout: moving from master to 286f167
40070a1... HEAD@{7}: checkout: moving from svn_to_git_wip to master
d8c9d02... HEAD@{8}: checkout: moving from master to svn_to_git_wip
40070a1... HEAD@{9}: checkout: moving from svn_to_git_wip to master
d8c9d02... HEAD@{10}: HEAD^: updating HEAD
ce11719... HEAD@{11}: checkout: moving from master to svn_to_git_wip
40070a1... HEAD@{12}: commit: Rebaselined nccov reports based on errmon changes
cb98d3f... HEAD@{13}: checkout: moving from svn_to_git_wip to master
ce11719... HEAD@{14}: rebase: updating HEAD
3638aa3... HEAD@{15}: checkout: moving from svn_to_git_wip to
3638aa3f6e8496b5415ab59bec2a7af07b8ed169
3638aa3... HEAD@{16}: checkout: moving from master to svn_to_git_wip
cb98d3f... HEAD@{17}: checkout: moving from svn_to_git_wip to master
3638aa3... HEAD@{18}: checkout: moving from master to svn_to_git_wip
cb98d3f... HEAD@{19}: checkout: moving from svn_to_git_wip to master
3638aa3... HEAD@{20}: checkout: moving from svn_to_git_wip to svn_to_git_wip
3638aa3... HEAD@{21}: checkout: moving from svn_to_git_wip to svn_to_git_wip
3638aa3... HEAD@{22}: HEAD^: updating HEAD
d8c9d02... HEAD@{23}: checkout: moving from svn_to_git_wip to svn_to_git_wip
d8c9d02... HEAD@{24}: HEAD^: updating HEAD
ce11719... HEAD@{25}: checkout: moving from master to svn_to_git_wip
cb98d3f... HEAD@{26}: checkout: moving from svn_to_git_wip to master
ce11719... HEAD@{27}: HEAD^: updating HEAD
286f167... HEAD@{28}: checkout: moving from master to svn_to_git_wip
cb98d3f... HEAD@{29}: commit: errmon now manages cmp{low,hgh}fal status bits.
ce11719... HEAD@{30}: checkout: moving from svn_to_git_wip to master
286f167... HEAD@{31}: commit: Saving WIP at the time I switched from SVN to GIT
ce11719... HEAD@{32}: checkout: moving from master to svn_to_git_wip
