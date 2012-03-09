From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Strange behauviour on Cherry-Pick
Date: Fri, 09 Mar 2012 18:20:12 +0100
Message-ID: <1331313612.21444.46.camel@beez.lab.cmartin.tk>
References: <1331296972-sup-5028@masterkorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Alfredo Palhares <masterkorp@masterkorp.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 18:20:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S63UM-0004iq-5o
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 18:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278Ab2CIRUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 12:20:16 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:51824 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557Ab2CIRUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 12:20:15 -0500
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 9252B46057;
	Fri,  9 Mar 2012 18:20:05 +0100 (CET)
In-Reply-To: <1331296972-sup-5028@masterkorp.net>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192729>

On Fri, 2012-03-09 at 15:11 +0100, Alfredo Palhares wrote:
> Hello, 
> 
> I have a repository[1] with my home files that i keep track off on my machines. 
> Until now ive been having everything in the same branch across all the computers, 
> but now i have a machine that requires diferences on some files.
> 
> So what i did i branched out and keep control the commits i want to the other branch
> trough cherry-picking.
> 

[cherry-pick two commits from 'boobierack' into 'master']

> Back to the boobierack machine:
>   Pull the commits before adding more stuff
>   $ git pull origin 
>   remote: Counting objects: 20, done.
>   remote: Compressing objects: 100% (13/13), done.
>   remote: Total 18 (delta 2), reused 18 (delta 2)
>   Unpacking objects: 100% (18/18), done.
>   From github.com:masterkorp/Home-files
>    * branch            HEAD       -> FETCH_HEAD
>    Merge made by recursive.
> 
>   I got like... OK ? 
>   On branh boobierack
>   $ git log --pretty=format:'''%h : %s''' --date-order --graph -n 6
>   *   4d7b2e8 : Merge github.com:masterkorp/Home-files into boobierack
>   |\  
>   | * 9937a0a : Fancier tmux
>   * | 811355b : Add sup config files
>   * | 9de92a2 : Fancier tmux
>   | * aac85ac : Add weechat config files
>   * | 90a6162 : Add weechat config files
> 
>   And master branch was untouched, i read on recursive merging on man page, but 

The master branch was untouched because you didn't tell git to do
anything with it.

>   i can't even understand why is git using that method in the first place, since 
>   the hashes are diferent and git doesn't care about the diff when fetching iirc.

The diffs between branches don't matter when fetching, but this is only
part of what you are doing here. Pull is fetch + merge and as you
specified a remote and no branch, it took the remote's default branch,
which seems to be 'master', and merged it into your current branch. What
you show is precisely what one would expect to see. Those two commits
that you cherry-picked are on each branch (or rather, their equivalents)
and then you have a merge between that remote and branch 'boobierack'
which you were on when you told git to merge origin's default branch.

This however doesn't seem to be what you were trying to do. What were
you trying to achieve with the pull? It seems to make sense that you'd
want to merge the master branch, as you yourself said that it had
changes that would never get merged back to 'master'.

   cmn
