From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 22:03:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601102200040.31923@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1136849678.11717.514.camel@brick.watson.ibm.com> 
 <1136849810.11717.518.camel@brick.watson.ibm.com>  <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
  <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
  <1136910406.11717.579.camel@brick.watson.ibm.com>  <7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
 <1136925066.11717.605.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 22:03:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwQeS-0000uv-Bz
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 22:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbWAJVD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 16:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWAJVDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 16:03:25 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:40408 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932636AbWAJVDX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 16:03:23 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AE16CE6024; Tue, 10 Jan 2006 22:03:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 9EE3D955;
	Tue, 10 Jan 2006 22:03:22 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 8026897D;
	Tue, 10 Jan 2006 22:03:22 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 29120141374; Tue, 10 Jan 2006 22:03:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1136925066.11717.605.camel@brick.watson.ibm.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14455>

Hi,

On Tue, 10 Jan 2006, Michal Ostrowski wrote:

> On Tue, 2006-01-10 at 20:55 +0100, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Tue, 10 Jan 2006, Junio C Hamano wrote:
> > 
> > > Michal Ostrowski <mostrows@watson.ibm.com> writes:
> > > 
> > > > git programs exec other git programs, but they also exec non-git
> > > > programs.  I think it is not appropriate to change PATH (via
> > > > prepend_to_path) because this may result in unexpected behavior when
> > > > exec'ing non-git programs:
> > > 
> > > This is a valid concern.
> > 
> > Why? If what is prepended to PATH only contains git programs?
> > 
> 
> 
> If git is installed with prefix=/usr, then that won't be the case.

Okay, so here we have the problem: Two completely different setups. One 
into a standard location on the PATH (which used to be the default), the 
other with a libexec/ directory (which some want in the future). And a git 
wrapper which makes no difference between both.

Wouldn't it make much more sense to have a switch in the Makefile, which 
says *if* we have a libexec/ directory? This switch would decide if we 
ever prepend the path with the libexec/ directory or not.

Ciao,
Dscho
