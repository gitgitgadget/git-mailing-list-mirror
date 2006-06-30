From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Fri, 30 Jun 2006 19:33:38 +0200
Organization: At home
Message-ID: <e83n97$973$1@sea.gmane.org>
References: <Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de> <E1FueYh-0004XE-Fg@moooo.ath.cx> <20060629222009.GA9310@cip.informatik.uni-erlangen.de> <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net> <E1Fw8hS-00023y-FY@moooo.ath.cx> <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net> <E1FwDiI-0007Xp-2s@moooo.ath.cx> <7v3bdnkrfb.fsf@assigned-by-dhcp.cox.net> <E1FwGgm-0006Nc-9a@moooo.ath.cx> <7vejx6k54p.fsf@assigned-by-dhcp.cox.net> <E1FwMPf-0005XA-N9@moooo.ath.cx> <7vpsgqimu7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 30 19:34:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwMsF-00045x-UK
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 19:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804AbWF3Rdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 13:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWF3Rdo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:33:44 -0400
Received: from main.gmane.org ([80.91.229.2]:55184 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932804AbWF3Rdn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 13:33:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FwMs0-00043y-Ue
	for git@vger.kernel.org; Fri, 30 Jun 2006 19:33:32 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 19:33:32 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 19:33:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23003>

Junio C Hamano wrote:

> Matthias Lederhofer <matled@gmx.net> writes:

>> 3. Is --near just another subexpression? e.g. search for foo with
>>    either A or B in the context:
>>    -e foo --and ( --near A --or --near B )
>>    This does not make sense without 1 and 2.
> 
> Ah, interesting.  I was thinking --near to be weaker form of --and,
> but you made it to be a unary predicate (like --not).  That
> would be neater.

I think --near _has_ to be non-symmetric binary operator, i.e. first
argument specifies line to be found, second argument has to be in context
for first line if it is found.

So the above expression would be written as:

  -e foo --near \( A --or B \)


BTW. we can make -e equivalent to --or, and empty (default) operator to
--and, but of course you have to delimit expression from files, i.e. either

  git grep A B C D -- files

or

  git grep -e \( A B C D \) files

which would be equivalent to

  git grep A --and B --and C --and D files

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
