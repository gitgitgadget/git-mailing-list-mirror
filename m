From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: bogus merges
Date: Sun, 11 Sep 2005 12:01:40 +0100
Message-ID: <20050911120140.A8236@flint.arm.linux.org.uk>
References: <59a6e58305090507387d412b3d@mail.gmail.com> <Pine.LNX.4.58.0509050853080.3568@evo.osdl.org> <Pine.LNX.4.63.0509061409180.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 13:04:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEPcI-00065s-KW
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 13:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVIKLBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 07:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVIKLBv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 07:01:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54541 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932467AbVIKLBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 07:01:51 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1EEPag-0005h1-Be; Sun, 11 Sep 2005 12:01:43 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1EEPae-0002PE-T6; Sun, 11 Sep 2005 12:01:40 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.63.0509061409180.23242@iabervon.org>; from barkalow@iabervon.org on Tue, Sep 06, 2005 at 02:28:39PM -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8290>

On Tue, Sep 06, 2005 at 02:28:39PM -0400, Daniel Barkalow wrote:
> On Mon, 5 Sep 2005, Linus Torvalds wrote:
> > On Mon, 5 Sep 2005, Wayne Scott wrote:
> > >
> > > A recent commit in linux-2.6 looks like this:
> > 
> > It hopefully shouldn't happen any more with the improved and fixed
> > git-merge-base.
> 
> Couldn't it also happen if there's stale data in MERGE_HEAD when you 
> commit a normal patch?

I don't think Cogito has the idea of a MERGE_HEAD file.

> The description doesn't look like a merge at all, 
> but rather like a normal patch that inappropriately picked up an extra 
> head. I'd guess he tried to merge something, got a conflict, decided that 
> he didn't really want to do that anyway, switched to a different branch, 
> applied a patch, and committed without noticing the note that he seemed to 
> be committing a merge.

"HE'd" hadn't (please don't use the third person when you're talking about
someone who is being copied on the thread, thanks.)  Look closer at the
two heads (I've cut out the author info):

commit b129a8ccd53f74c43e4c83c8e0031a4990040830
tree 4c40afd836be87166d6d014380262f1baa19694f
parent 6b39374a27eb4be7e9d82145ae270ba02ea90dc8
parent 194d0710e1a7fe92dcf860ddd31fded8c3103b7a
committer Russell King <rmk+kernel@arm.linux.org.uk> Wed, 31 Aug 2005 10:12:14 +0100
    [SERIAL] Clean up and fix tty transmission start/stoping

which was apparantly (but not really) a merge between:

commit 6b39374a27eb4be7e9d82145ae270ba02ea90dc8
tree 09933113cf28f253db1dd539463bdab741d67139
parent 62c592edead3c3a045662595f7ade3c12f133373
parent ed735ccbefaf7e5e3ef61418f7e209b8c59308a7
committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 30 Aug 2005 11:16:30 -0700
    Merge refs/heads/upstream from master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

commit 194d0710e1a7fe92dcf860ddd31fded8c3103b7a
tree da03b56fa4dee221c53af5770492d391f0d09459
parent a68d2ebc1581a3aec57bd032651e013fa609f530
parent 9bbd03758945858c9303f3258b418b94c4ffd735
committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 03 Aug 2005 13:09:43 -0700
    Merge master.kernel.org:/home/rmk/linux-2.6-arm

However, the serial tree (which commit b129a8ccd53f74c43e4c83c8e0031a4990040830
was created in) was last pulled in commit 975f957dc408925805dd8f5aa4217b7eeea2d005.
Following the commit trail, you'll end up at commit
6b39374a27eb4be7e9d82145ae270ba02ea90dc8 above.

commit 975f957dc408925805dd8f5aa4217b7eeea2d005
tree 2198bb72323a016d93c7440c9240bac94a5c0016
parent 2321fbd2b87539edc1fbfc2e186528a1ef93835f
parent 661299d9d0437a0ff72240f3d60016ac3a361a6e
committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 29 Aug 2005 10:34:59 -0700
    Merge HEAD from master.kernel.org:/home/rmk/linux-2.6-serial.git

which was the result of the following merge between the head of the
serial tree and Linus' tree:

commit 661299d9d0437a0ff72240f3d60016ac3a361a6e
tree 765512576314fc3612b503f182b9ae4e60fcf849
parent 05caac585f8abd6c0113856bc8858e3ef214d8a6
parent 41c018b7ecb60b1c2c4d5dee0cd37d32a94c45af
committer Russell King <rmk+kernel@arm.linux.org.uk> Thu, 28 Jul 2005 09:30:20 +0100
    Merge with Linus' 2.6 tree

This was at the head of the serial tree at the time:

commit 05caac585f8abd6c0113856bc8858e3ef214d8a6
tree ac9f8f2cc032281af09200da514257d120510906
parent 241fc4367b3ca5d407b043599ed980304a70b91f
committer Russell King <rmk+kernel@arm.linux.org.uk> Wed, 27 Jul 2005 11:41:18 +0100
    [SERIAL] Convert parport_serial to use new 8250_pci interfaces

So, the question is, if the serial git tree was all happy in the
merge on 29th August (975f957dc408925805dd8f5aa4217b7eeea2d005)
why did the next commit to that tree (being
b129a8ccd53f74c43e4c83c8e0031a4990040830) go wrong when the
previous merge would have been a standard fast-forward operation.

There is _no_ reason why the serial tree would have been wound back
to 3rd August.

> Probably the right thing is actually to clean up more when switching 
> tasks, but it would probably also be worth checking that merges make sense 
> as well.

You might be right except for one small detail.  I don't "switch tasks"
with a single git tree.  I have a set of individual git trees, one per
"task".  They always remain in a clean state due to the way I work:

	- update tree to Linus if Linus tree is a superset of the tree
	- apply changes in patch form to tree and commit each in turn
	- send linus a request to merge

However, occasionally, I update the tree when Linus' tree is not a
superset, as was the case in 661299d9d0437a0ff72240f3d60016ac3a361a6e
above.

-- 
Russell King
