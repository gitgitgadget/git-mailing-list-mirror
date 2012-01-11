From: Soham Mehta <soham@box.com>
Subject: Intriguing error with Git 1.6.3.1: Too many open files
Date: Tue, 10 Jan 2012 18:44:16 -0800
Message-ID: <CALjyegUJ+ZY7g0Lpxqs=gvAyhtYW_a3SNWVybSG4EG3X=ROV9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 03:44:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkoBA-0004IA-Ih
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 03:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756937Ab2AKCoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 21:44:39 -0500
Received: from exprod6og104.obsmtp.com ([64.18.1.187]:37508 "HELO
	exprod6og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756700Ab2AKCoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 21:44:39 -0500
Received: from mail-qy0-f170.google.com ([209.85.216.170]) (using TLSv1) by exprod6ob104.postini.com ([64.18.5.12]) with SMTP
	ID DSNKTwz3lWOZFSRE4CpB2/2d6302ycKhtK2t@postini.com; Tue, 10 Jan 2012 18:44:38 PST
Received: by qcsd16 with SMTP id d16so214311qcs.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 18:44:37 -0800 (PST)
Received: by 10.229.106.152 with SMTP id x24mr8551477qco.2.1326249877261; Tue,
 10 Jan 2012 18:44:37 -0800 (PST)
Received: by 10.229.29.132 with HTTP; Tue, 10 Jan 2012 18:44:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188313>

We use Git (1.6.3.1) exclusively here at Box.

Starting this afternoon, we started getting errors when pushing to one of
the repos. It is a very active, bare shared repo, shared among
multiple developers. The
error is:

*"error: unable to open object pack directory: ./objects/pack: Too many
open files"

Things I tried/observed to resolve it:

1) ulimit -H = unlimited, when run as root (original error seems
misleading?). I also killed other proceses that had some open files, and
brought down the total count of open files (roughly lsof | wc -l) to <1000.

2) I can push to several other repos on the same machine just fine

3) git fsck, git gc, git-branch and git-status return the same error

4) I copied the repo (using scp -r, git-clone failed) to a different
machine, but got the same errors when pushing to it

5) I asked #git and the suggestion was that the repo is somehow corrupt and
I should re-push to it

One more thing worth mentioning: Gerrit (code review) uses the same repo
(lots of stuff in refs/changes)

If the repo is indeed not recoverable, I know how to restore it. But I'd
rather fix this if possible. Wondering if it is worth pursuing and what
might be wrong?

Thanks.
-Soham
