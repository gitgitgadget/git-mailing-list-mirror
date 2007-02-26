From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: RFC: Patch editing
Date: Mon, 26 Feb 2007 14:18:14 +0100
Message-ID: <slrneu5ngm.s8g.siprbaum@xp.machine.xx>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 14:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLfhc-0005cL-RL
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 14:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbXBZNPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 08:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbXBZNPh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 08:15:37 -0500
Received: from main.gmane.org ([80.91.229.2]:33801 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030206AbXBZNPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 08:15:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HLfhR-0003uW-C7
	for git@vger.kernel.org; Mon, 26 Feb 2007 14:15:29 +0100
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 14:15:29 +0100
Received: from siprbaum by magnum.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 14:15:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: magnum.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40621>

Johannes Schindelin <Johannes.Schindelin@gmx.de> schrieb:
> Hi list,
>
> while I was hacking on another issue, I realized just how often I would 
> like to stash away a fix which is unrelated (but often triggered) by the 
> theme of the current topic branch. Or I fix an earlier commit, which is 
> not the tip of the branch, so I cannot --amend it.
>
> My common practice is to commit it nevertheless, and sort the topic 
> branches out later, by cherry-picking my way through the commits.
>
> This is a tedious and error-prone procedure, and I often wished I knew how 
> to use StGIT. But then, StGIT is overkill for me: on some machines I work 
> on, there is no Python installed, I do not really need to have a history 
> on the order and version of patches, and I do not need to preserve author 
> and committer information *1*.
>
> Therefore, I wrote this extremely simple script to sort out the order of 
> commits, and possibly merging some. The script lets you edit the commit 
> list upon start (reordering it, or removing commits), and then works on 
> that list. It has three subcommands:
>
> 	start <base>
> 	continue
> 	reset [-f]
>
> The subcommand "start" takes a base commit (actually, it will take the 
> merge base of HEAD and that base commit) from which to start. It builds a 
> commit list and opens it in an editor. The rows of the list have the form 
> "<action> <sha1> <oneline>". The oneline description is purely for ease of 
> use.
>
> The three possible actions are "pick" (the default), "edit" and "merge". 
> "pick" will just cherry-pick that commit, "edit" will stop after 
> cherry-picking so that you can make a small fixup (in the code or in the 
> commit message), and "merge" will try to apply the corresponding patch, 
> amend the previous commit with the result, and let you edit the combined 
> commit message.
>
> If a patch fails, or "edit" was specified, the loop is interrupted for 
> fixups. Use the subcommand "continue" to restart the loop (the working 
> tree has to be clean, though).
>
> Once there are no more commits to be picked, the original branch is 
> updated to that new tip.
>
> If you decide at some point that you do not want to rewrite the patches 
> after all, you can use the subcommand "reset".
>
> To see which commits were already applied, you can inspect .series/done, 
> and likewise .series/todo for what is to be applied yet. You can even edit 
> .series/todo if you decide on another course of action.
>
> Anyway, it is a relatively short and stupid script.
>

Nice.  I tried it on a simple testcase to just rearrange some commits
and it worked as expected. That was exactly what I was looking for!

I tried for a while stgit, but it seemed like overkill to me and I messed
up my test repo several times, propably because I have done something wrong
so I gave up.

-Peter
