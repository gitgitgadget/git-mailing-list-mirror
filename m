From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 23:04:54 +0100
Message-ID: <20060221220454.GB5948@steel.home>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> <20060221205618.GA23920@localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:05:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBfd7-0002HJ-R1
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWBUWFG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWBUWFF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:05:05 -0500
Received: from devrace.com ([198.63.210.113]:36109 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964867AbWBUWFE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 17:05:04 -0500
Received: from tigra.home (p54A05C42.dip.t-dialin.net [84.160.92.66])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k1LM4trx075871;
	Tue, 21 Feb 2006 16:04:57 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FBfcs-0000Xs-00; Tue, 21 Feb 2006 23:04:54 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FBfcs-0001ug-Gt; Tue, 21 Feb 2006 23:04:54 +0100
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060221205618.GA23920@localdomain>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16556>

Eric Wong, Tue, Feb 21, 2006 21:56:18 +0100:
> > >  * Eric, thanks for the hint.  I have this four-patch series.
> > >    Could people with perl 5.6 please check them?
> > 
> > Does not work here (ActiveState Build 811, Perl 5.8.6):
> > 
> > $ perl -e 'open(F, "-|")'
> > '-' is not recognized as an internal or external command,
> > operable program or batch file.
> 
> Both "-|" and "|-" forms of open() use fork() internally.  Iirc, fork()
> doesn't work too well on that platform.
> 

AFAICS, it does not exist. There is emulation of it in that active-perl,
though so this works:

    if ( !fork ) { something }

but not "too well" (you have to be carefule not spawn too many (which
is around 50) processes. Perl'll crash otherwise).
