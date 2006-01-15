From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: RFC: Subprojects
Date: Sun, 15 Jan 2006 13:28:58 +1300
Message-ID: <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com>
References: <43C52B1F.8020706@hogyros.de>
	 <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	 <43C537C9.4090206@hogyros.de>
	 <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
	 <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	 <43C951B6.5030607@gmail.com>
	 <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
	 <43C95F69.7090200@gmail.com> <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitzilla@gmail.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sun Jan 15 01:29:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exvlb-0008Gd-Ei
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 01:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWAOA27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 19:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWAOA27
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 19:28:59 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:54563 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750955AbWAOA26 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 19:28:58 -0500
Received: by wproxy.gmail.com with SMTP id i34so850339wra
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 16:28:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V43jEEfVCsE/LX3qRGwKskkCnsr5hp3cgf1bCZ/QZRX9MNytGRptI1fH7mYKkKu2+TzkoH7Ke+NZt8w5+BfcfgLmpU9+akBj3N/iRi+BfFVUFtNi4qhRBU1AWIOGu8j7ZYrP9bIJ86qMZMstsCjsKoHQ9DAAm2UeS63sYcds7pA=
Received: by 10.54.152.13 with SMTP id z13mr2610287wrd;
        Sat, 14 Jan 2006 16:28:58 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Sat, 14 Jan 2006 16:28:58 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14689>

On 1/15/06, Junio C Hamano <junkio@cox.net> wrote:
> > The "get" rule for each sub-project could be something like:
> >
> >       git_sub-project:
> >               mkdir sub-project
> >               cd sub-project
> >               git-init-db
> >               git-fetch <fetch-options> <repository> <refspec>
> >               git-checkout <branch>
> >               $(MAKE) get_sub_components
>
> There lies a drake here --- <repository> is not the same for
> everybody.  It is not a big showstopper dragon, though.

Well, that /little complication/ applies to doing it in git too ;-)
There's no way to tell how the dev doing the top level checkout has
access to the subproject repos.

I am with gitzilla on this one. Let the projects have their own
bootstraping mechanisms, using make, ant or whatever catches their
fancy. One of the great things about git is that it doesn't assume
that it's being used by all the projects in the world -- thanks to
Linus' disregard for arbitrary metadata and to your git-cherry
implementation, it's all about the content -- and so it interoperates
great with Arch, SVN, CVS, etc.

Having intra-git subproject support assumes that the subprojects are
all in git. Heh! That covers  about 0.001% of reality out there.
Per-project bootstraping scripts will use whatever tools they need for
the checkout.

Automating the 'checkout' stage for git subprojects is trivial, and
I'd argue not interesting enough to try and solve within git,
specially when most subprojects are going to be using a different SCM
anyway. And all the *interesting* operations (branch, commit, tag) are
perhaps indeed interesting problems to solve, but definite misfeatures
in a tool that tries to be sane and minimalistic.

IOWs, adding some repo metadata describing subprojects is the wrong
thing to do, just like tracking patches via metadata would be the
wrong thing to do. It's all about files -- which git handles
masterfully.

cheers,


martin
