From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: No merge strategy handled the merge (git version 1.1.GIT)
Date: Sun, 29 Jan 2006 13:03:44 +0100
Message-ID: <20060129120344.GB4815@c165.ib.student.liu.se>
References: <43DB4D16.6050807@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 13:04:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3BHe-0005Bh-FX
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 13:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWA2MDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 07:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWA2MDq
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 07:03:46 -0500
Received: from [85.8.31.11] ([85.8.31.11]:46237 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750868AbWA2MDq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 07:03:46 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 818E140FF; Sun, 29 Jan 2006 13:16:59 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F3BHU-0007kV-00; Sun, 29 Jan 2006 13:03:44 +0100
To: Roberto Nibali <ratz@drugphish.ch>
Content-Disposition: inline
In-Reply-To: <43DB4D16.6050807@drugphish.ch>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15213>

On Sat, Jan 28, 2006 at 11:53:10AM +0100, Roberto Nibali wrote:
> Hello,
> 
> I've been hacking on some features for IPVS in the Linux kernel recently 
> but abandoned work for 3 weeks. Today I wanted to re-sync with Linus to 
> work in a more up-to-date tree and simply typed (forgot I had previously 
> done work in that tree)
> 
>     git-pull
> 
> in my local repository tree, which resulted in following:
> 

...

> Auto-merging net/ipv4/ipvs/ip_vs_ctl.c
> Traceback (most recent call last):
>   File "/home/ratz/bin/git-merge-recursive", line 915, in ?
>     firstBranch, secondBranch, graph)
>   File "/home/ratz/bin/git-merge-recursive", line 87, in merge
>     branch1Name, branch2Name)
>   File "/home/ratz/bin/git-merge-recursive", line 160, in mergeTrees
>     if not processEntry(entry, branch1Name, branch2Name):
>   File "/home/ratz/bin/git-merge-recursive", line 868, in processEntry
>     branch1Name, branch2Name)
>   File "/home/ratz/bin/git-merge-recursive", line 212, in mergeFile
>     src1, orig, src2], returnCode=True)
>   File "/home/ratz/share/git-core/python/gitMergeCommon.py", line 72, 
> in runProgram
>     raise ProgramError(progStr, e.strerror)
> ProgramError: merge -L HEAD/net/ipv4/ipvs/ip_vs_ctl.c -L 
> orig/net/ipv4/ipvs/ip_vs_ctl.c -L 
> 3ee68c4af3fd7228c1be63254b9f884614f9ebb2/net/ipv4/ipvs/ip_vs_ctl.c 
> .merge_file_uofMwv .merge_file_hcesLs .merge_file_TwtEqw: No such file 
> or directory
> No merge strategy handled the merge.
> 

The problem is that merge(1), which is used for file-level merges,
couldn't be found. Is it installed on your system? If you use Linux,
it is usually found in the "rcs" package in your favorite
distribution.

This have came up a couple of times now, we should probably make this
error message a bit less cryptic. I will send a patch in a separate
mail.

> I'm all for verbosity when it comes to a problem with software, however 
> this output does not tell me much about what I could do to achieve 
> following state:
> 
> 1. Sync my local tree to Linus' tree.
> 2. Merge my changes I've done locally with the resulting tree of 1.
> 

If your repository is in the state that the failed git-pull left it
in, then the following actions should merge your changes with Linus'
tree.

1. Install merge(1)
2. Run 'git reset --hard' (NOTE: Be careful with this command. It will
   revert any uncommitted changes you may have in your working directory!)
3. Run 'git pull'

> Oh, btw, how is git branch -D supposed to work? Isn't there some code 
> missing?

Could you be a bit more specific? Do you mean that there is code
missing in git-branch.sh? What happens when you run 'git branch -D
<some branch>'? It seems to work fine here.

- Fredrik
