From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 21:09:02 -0500
Message-ID: <1136945343.11717.638.camel@brick.watson.ibm.com>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	 <1136849810.11717.518.camel@brick.watson.ibm.com>
	 <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
	 <1136910406.11717.579.camel@brick.watson.ibm.com> <43C4075E.4070407@op5.se>
	 <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
	 <1136924980.11717.603.camel@brick.watson.ibm.com>
	 <7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 03:07:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwVOl-0002iQ-R7
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 03:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWAKCHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 21:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWAKCHh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 21:07:37 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:1489 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1161146AbWAKCHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 21:07:36 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k0B29fq4026983;
	Tue, 10 Jan 2006 21:09:41 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k0B27Rk421646;
	Tue, 10 Jan 2006 21:07:27 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k0B27Qu146808;
	Tue, 10 Jan 2006 21:07:26 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k0B34ClC012556;
	Tue, 10 Jan 2006 22:04:12 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k0B27Pm27166;
	Tue, 10 Jan 2006 21:07:25 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14473>

On Tue, 2006-01-10 at 16:42 -0800, Junio C Hamano wrote:
> Michal Ostrowski <mostrows@watson.ibm.com> writes:
> 
> > How about searching for executables in the following places, and in this
> > order:
> >
> > 1. --exec-path setting, if any
> > 2. GIT_EXEC_PATH env var, if set
> > 3. PATH (never modified)
> > 4. Value of ${bindir} at build time
> 


> and then make the rule for git things:
> 
>  1. --exec-path
>  2. GIT_EXEC_PATH environment
>  3. $(gitexecdir)
> 
> in this order.  Non git things should just use $PATH without
> looking at anything else --- as long as a hook script calls a git
> wrapper (i.e. "git foo" not "git-foo") I think things should
> work fine.
> 

The patch that follows implements your suggested search order and
includes suggested Makefile changes.

-- 
Michal Ostrowski <mostrows@watson.ibm.com>
