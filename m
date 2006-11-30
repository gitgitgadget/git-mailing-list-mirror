X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 17:21:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611301624430.9647@xanadu.home>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
 <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net> <87ejrlvn7r.wl%cworth@cworth.org>
 <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>
 <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org>
 <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 30 Nov 2006 22:21:32 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Worth <cworth@cworth.org>,
	Theodore Tso <tytso@mit.edu>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vhcwgiqer.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32813>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuHD-0004HT-AR for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031558AbWK3WVE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031559AbWK3WVE
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:21:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:7102 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031558AbWK3WVB
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:21:01 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9K00LQXE30X7L0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 30 Nov 2006 17:21:00 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > ...  But let me repeat my last question:
> >
> > Would it make sense for "git add" to do the same as "git update-index" 
> > on already tracked files?  Given the explanation above this would make 
> > 100% sense to me.
> 
> I think this makes sense and what we did in the original "git
> add".

Wonderful! We might be converging to something then.

Because, conceptually, it then becomes much easier to tell newbies about 
the index as follows (this could be pasted in a tutorial somewhere):

  Contrary to other SCMs, with GIT you have to explicitly "add" all
  the changes you want to commit together.  This can be done in a few
  different ways:

  1) By using "git add <file_spec...>"

     This can be performed multiple times before a commit.  Note that 
     this is not only for adding new files.  Even modified files must be
     added to the set of changes about to be committed.  The "git 
     status" command gives you a summary of what is included so far for 
     the commit.  When done you should use the "git commit" command to
     make it real.

     Note: don't forget to "add" a file again if you modified it after 
     the first "add" and before "commit". Otherwise only the previous 
     "added" state of that file will be committed.

  2) By using "git commit -a" directly

     This is a quick way to automatically "add" all modified files to 
     the set of changes and perform the actual commit without having to 
     separately "add" them.  This will not "add" new files -- those 
     files still have to be added explicitly before performing a commit.

  Here's a twist.  If you do "git commit <file1> <file2> ..." then 
  only the  changes belonging to those explicitly specified files will 
  be committed, entirely bypassing the current "added" changes.  Those
  "added" changes will still remain available for a subsequent commit.

  There is a twist about that twist: if you do "git commit -i <file>..." 
  then the commit will consider changes to those specified files 
  _including_ all "added" changes so far.

  But for instance it is best to only remember "git add" + "git 
  commit" and/or "git commit -a".

Doesn't it sounds nice?  The index is being introduced up front without 
even mentioning it, and I think the above should be fairly palatable to 
newbies as well.  Would only lack some enhancements to the commit 
template and the "nothing to commit" message so the user is cued about 
the fact that "current changeset is empty -- don't forget to 'git add' 
modified files, or use 'git commit -a'".

What do you think?

