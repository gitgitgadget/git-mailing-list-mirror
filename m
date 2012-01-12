From: Yves Goergen <nospam.list@unclassified.de>
Subject: Bug? Git checkout fails with a wrong error message
Date: Thu, 12 Jan 2012 18:44:03 +0000 (UTC)
Message-ID: <loom.20120112T193624-86@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 19:50:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPj6-00058H-CO
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 19:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab2ALSuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 13:50:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:58582 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab2ALSuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 13:50:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RlPix-000507-Nd
	for git@vger.kernel.org; Thu, 12 Jan 2012 19:50:07 +0100
Received: from DSL01.83.171.170.242.ip-pool.NEFkom.net ([83.171.170.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 19:50:07 +0100
Received: from nospam.list by DSL01.83.171.170.242.ip-pool.NEFkom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 19:50:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.171.170.242 (Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188469>

Hi,

I am using Git alone for my local software project in Visual Studio 2010. I've
been on the master branch most of the time. Recently I created a new branch to
do a larger refactoring of one of the dialogue windows. I did the following
modifications:

* Rename Form1 to Form1a (including all depending files)
* Add new Form1

I checked this change into the branch, say form-refactoring. Interestingly, Git
didn't notice that I renamed the file Form1.cs into Form1a.cs and created a
brand new, totally different Form1.cs, but instead it noticed a new Form1a.cs
file and found a whole lot of differences between the previous and new Form1.cs
files. This will of course lead to totally garbaged diffs, but I don't care in
this case as long as all files are handled correctly in the end.

Then I switched back to master to do some other small changes. Nothing
conflicting. Until now, everything worked fine.

Today, I wanted to switch back to my branch form-refactoring to continue that
work. But all I get is the following message:

-----
git.exe checkout    form-refactoring

Aborting
error: The following untracked working tree files would be overwritten by
checkout:
Form1.Designer.cs
Please move or remove them before you can switch branches.
-----

What is that supposed to be? The mentioned file is not untracked. Neither in the
master branch, nor in the form-refactoring branch. It is part of both branches,
but one is not a descendent of the other (because it was recreated on the
form-refactoring branch, if that matters). What would happen if I delete it, is
it gone for good then? I don't trust Git to bring back the correct file if I
delete something now. I did not play with any file at all outside of my
mentioned Git operations, so why should I play around with any file to continue
using Git operations now? Git broke it, Git's supposed to handle it now!

Here's some other input:

There are no uncommitted changes in my working directory. 'git status' doesn't
list anything.

The file in question is not untracked. Right now on the master branch, it has a
green checkmark in Explorer (provided by TortoiseGit) and it has a history as
well. There are more Form....Designer.cs files that don't cause any trouble.

'git clean -f -d', 'git reset --hard HEAD', 'git stash' do nothing and don't
help resolving the issue.

Right now, I cannot continue with my work because I cannot switch branches. Is
there an easy solution to this? Is my Git repository broken, all by standard
operations?
