From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a configuration option to control diffstat after merge
Date: Wed, 23 May 2007 22:43:12 +0200
Message-ID: <20070523204312.GD2554@steel.home>
References: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com> <7vhcq32yda.fsf@assigned-by-dhcp.cox.net> <20070523195823.GA2554@steel.home> <20070523200223.GB2554@steel.home> <7v646j2t1e.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 22:43:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqxfz-0005E8-2P
	for gcvg-git@gmane.org; Wed, 23 May 2007 22:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088AbXEWUnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 16:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755148AbXEWUnP
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 16:43:15 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:33867 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbXEWUnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 16:43:15 -0400
Received: from tigra.home (Fa87d.f.strato-dslnet.de [195.4.168.125])
	by post.webmailer.de (klopstock mo47) (RZmta 6.7)
	with ESMTP id H01c4cj4NH4pwX ; Wed, 23 May 2007 22:43:13 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 10B13277BD;
	Wed, 23 May 2007 22:43:13 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E966ED195; Wed, 23 May 2007 22:43:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v646j2t1e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVo8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48173>

Junio C Hamano, Wed, May 23, 2007 22:18:05 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > The diffstat can be controlled either with command-line options
> > (--summary|--no-summary) or with merge.diffstat. The default is
> > left as it was: diffstat is active by default.
> >
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> >
> > I have to explain the implementation a bit: in Windows, every exec is
> > *very* expensive, so I tried to avoid a call to git-config as long as
> > possible. The stupid OS is my reason for this change, actually:
> > diffstat not just takes too long. It also takes a *long* while before
> > the diffstat even starts!
> 
> Even on Linux, if your project is well modularized and your
> workflow is "merge small and merge often" like the kernel is, it
> is not unusual that the final diffstat takes much longer than a
> merge.  But the diffstat is not an eye-candy but is an important
> safety measure from the workflow point of view.

Can't have it on Windows. It makes me prefer git-am to git-merge.

> > @@ -168,6 +169,11 @@ do
> >  	shift
> >  done
> >  
> > +if test -z "$show_diffstat"; then
> > +    test "$(git-config merge.diffstat)" = false && show_diffstat=false
> > +    test -z "$show_diffstat" && show_diffstat=t
> > +fi
> 
> Isn't this hunk wrong?
> 

It is. Will resend in an hour, unless you beat me to it

> if test -z "$show_diffstat"; then
>     test "$(git-config --bool merge.diffstat)" = false && show_diffstat=false
>     test -z "$show_diffstat" && show_diffstat=t
> fi

Thanks!
