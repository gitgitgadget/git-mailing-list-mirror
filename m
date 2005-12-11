From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: t6021-merge-criss-cross.sh fails on some systems
Date: Sun, 11 Dec 2005 01:33:53 +0100
Message-ID: <20051211003353.GA27207@c165.ib.student.liu.se>
References: <20051210.144235.125914760.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 01:35:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElFAD-0003Tn-MR
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 01:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbVLKAeB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 19:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbVLKAeA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 19:34:00 -0500
Received: from [85.8.31.11] ([85.8.31.11]:39885 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161076AbVLKAeA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 19:34:00 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A39DD40FD; Sun, 11 Dec 2005 01:44:11 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ElFA1-0007E9-00; Sun, 11 Dec 2005 01:33:53 +0100
To: "David S. Miller" <davem@davemloft.net>
Content-Disposition: inline
In-Reply-To: <20051210.144235.125914760.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13478>

On Sat, Dec 10, 2005 at 02:42:35PM -0800, David S. Miller wrote:
> 
> This is really weird, so I started to try and get some diagnostics.
> 
> It doesn't fail on my sparc64 box running debian-testing
> but it does fail on my Ubuntu x86 laptop, a sparc64 box
> running debian-unstable, and an Ubuntu sparc64 system as
> well.
> 
> This is with the current GIT tree.
> 
> I ran the test one step at a time to try and get some diagnostics,
> here's what fails:
> 
> davem@nuts:~/src/GIT/test$ git merge "pre E3 merge" B A
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging
> Nope.
> Merging B with A
> Merging:
> 1f14398f4c69d09ab1a4d53fe096ddec3ea45207 C3
> d1072ae2682fad309c493343c5d77c9897fb6afa B8
> found 1 common ancestor(s):
> 926159b75e3d9b240b1eae36eb1977b095ff2e1a Initial commit
> Auto-merging file
> Traceback (most recent call last):
>   File "/home/davem/bin/git-merge-recursive", line 868, in ?
>     firstBranch, secondBranch, graph)
>   File "/home/davem/bin/git-merge-recursive", line 87, in merge
>     branch1Name, branch2Name)
>   File "/home/davem/bin/git-merge-recursive", line 160, in mergeTrees
>     if not processEntry(entry, branch1Name, branch2Name):
>   File "/home/davem/bin/git-merge-recursive", line 821, in processEntry
>     branch1Name, branch2Name)
>   File "/home/davem/bin/git-merge-recursive", line 212, in mergeFile
>     src1, orig, src2], returnCode=True)
>   File "/home/davem/share/git-core/python/gitMergeCommon.py", line 72, in runProgram
>     raise ProgramError(progStr, e.strerror)
> ProgramError: merge -L B/file -L orig/file -L A/file .merge_file_kDtaE3 .merge_file_K30Hgp .merge_file_frqYIs: No such file or directory
> No merge strategy handled the merge.
> davem@nuts:~/src/GIT/test$ ls
> 
> It looks like maybe some quoting issue?  The call failing above is the
> one in git-merge-recursive which looks like this:
> 
>     [dummy, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
>                            firstBranch, secondBranch, graph)
> 
> Any ideas?

It looks like 'merge' can't be found. The recursive merge strategy
uses 'merge' to do file-level merging. Do you have merge(1) installed?

- Fredrik
