From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGit: Notice: no parent remote declared for stack
Date: Fri, 11 May 2007 22:47:58 +0200
Message-ID: <20070511204758.GI19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <64de5c8b0704192220j6f5f9493md91a33f537ebb25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rajkumar S <rajkumars@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 22:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmc3J-000837-Q6
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857AbXEKUtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758807AbXEKUtG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:49:06 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60400 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758857AbXEKUtE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:49:04 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B969F5E5DF;
	Fri, 11 May 2007 22:49:01 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 84F311F161; Fri, 11 May 2007 22:47:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <64de5c8b0704192220j6f5f9493md91a33f537ebb25@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46984>

Sorry for the late answer - this mail has been stagnating in my
"postponed folder".

On Fri, Apr 20, 2007 at 10:50:49AM +0530, Rajkumar S wrote:
> I am following another git repository with StGit. In the remote
> repository I am following RELENG_1_2 branch.
> 
> I created the StGit repository using stg clone and then changed to
> RELENG_1_2 branch and did a stg init and edited the
> git/remotes/origin to
> 
> URL: /usr/local/upstream/.git
> Pull: refs/heads/RELENG_1_2:refs/heads/RELENG_1_2

You are not using git 1.5, are you ?  1.5 uses the new separate-remote
layout, which should setup something similar for you.

> 
> When I do an stg pull I get the following error:
> 
> Notice: no parent remote declared for stack "RELENG_1_2", defaulting
> to "origin". Consider setting "branch.RELENG_1_2.remote" and
> "branch.RELENG_1_2.merge" with "git repo-config".
> 
> What should I set branch.RELENG_1_2.remote and branch.RELENG_1_2.merge
> to ?

It will tell git-pull from which remote repository and branch to pull.
In your case, the default remote "origin", is correct, but stgit (and
git) cannot guess the branch to merge from.


> a sample command would be very helpful as I am not very much upto
> speed with git repo-config

If you have cloned this repo to work on it, I suppose what you want is
a patch stack that branches off the remote RELENG_1_2 branch.
git-clone will have already mirrored it locally to
remotes/origin/RELENG_1_2, so you don't need to edit the remote
definition to add it under refs/heads.

Here is an example, the conf for my main stgit branch, forked off
Catalin's master branch.  Note that "branch.master.merge" refers to
the head in the remote repository, not to where it is stored locally.
Also note that branch.master.stgit.pull-policy is only honored by the
development version of stgit (ie. not 1.12.x).

[remote "origin"]
        url = http://homepage.ntlworld.com/cmarinas/stgit.git
        fetch = refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
[branch "master.stgit"]
        pull-policy = fetch-rebase

Best regards,
-- 
Yann.
