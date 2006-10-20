From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 22:40:29 +0200
Organization: At home
Message-ID: <ehbc7l$kvr$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45390168.6020502@utoronto.ca> <Pine.LNX.4.64.0610201016490.3962@g5.osdl.org> <200610201945.43957.jnareb@gmail.com> <Pine.LNX.4.64.0610201049250.3962@g5.osdl.org> <7v1wp2oi6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 20 22:41:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb1Aq-0002JZ-TE
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 22:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992769AbWJTUk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992771AbWJTUk5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 16:40:57 -0400
Received: from main.gmane.org ([80.91.229.2]:60379 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S2992769AbWJTUk4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 16:40:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gb1AX-0002FF-D5
	for git@vger.kernel.org; Fri, 20 Oct 2006 22:40:41 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 22:40:41 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 22:40:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29535>

Junio C Hamano wrote:

>   2. git-pickaxe -M: blame line movements within a file.
> 
>      This adds logic to find swapped groups of lines in the same
>      file.  When the file in the parent had A and B and the child
>      has B and A, "single diff with parent" would find only one
>      of A or B is inherited from the parent, not both.  This
>      re-diffs the remainder with the parent's file to find both.
> 
>      I used to have heuristics to avoid trivial groups of lines
>      from being subject to this step, but in this version they
>      have been removed, so that we can see the core logic and
>      need for heuristics more clearly.
> 
>      On the other hand, the version I used to have in "pu" gave
>      blame to the first match.  This one tries to find the best
>      match and assign the blame to it.
> 
>   3. git-pickaxe -C: blame cut-and-pasted lines.
> 
>      This adds logic to find groups of lines brought in from
>      existing file in the parent.  We scan the remainder using
>      the same logic as -M detection, but it is done against
>      other files in the parent.
> 
>      There was a heuristic that gave the blame to the parent
>      right then and there when we find a copy-and-paste instead
>      of allowing the parent to pass blame further on to its
>      ancestors; again I removed this heuristics in the reordered
>      series.

The names of options clash somewhat with -M and -C in diffcore,
which detect contents 'M'oving (renaming files), and contents
'C'opying (copying files), where in git-pickaxe -C is still about
code movement, only across files (-M -M or --MM?).

Would git-pickaxe try to do also copy-and-paste within the file,
and across files?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
