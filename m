From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Wed, 19 Aug 2009 11:58:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908191153550.5594@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302> <4A8AEAF5.6070205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 11:58:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdhw6-0007El-E1
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 11:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbZHSJ6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 05:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZHSJ6U
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 05:58:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:37516 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751569AbZHSJ6U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 05:58:20 -0400
Received: (qmail invoked by alias); 19 Aug 2009 09:58:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 19 Aug 2009 11:58:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BUv00y/gB/jHGa0YI6BLwgkBkpZJQl5sc59qDr4
	IQ7gqWmrSGKVzw
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A8AEAF5.6070205@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126529>

Hi,

On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 18.08.2009 16:11:
>
> > On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
> > 
> > > diff --git a/Makefile b/Makefile
> > > +ifneq (,$(findstring Microsoft Visual Studio, $(INCLUDE)))
> ...
> > > +else
> > >  ifneq (,$(findstring MINGW,$(uname_S)))
> > >   pathsep = ;
> > >   NO_PREAD = YesPlease
> > 
> > This means that gcc is never used when Visual C++ is available?  Hmm.
> 
> Yes it does :)

As you know, I do not own a Windows computer.  On the Windows computer I 
am allowed to use sometimes to test Git and my day-time project, the 
Express edition was installed, but it was never registered, so it is not 
usable, and I would not want to use it anyway.

So this change would break my setup.

> I was actually going to replace it with a USE_MSVC variable check 
> instead though, so you'd rather do 'make USE_MSVC=1'

That's much nicer, especially since you can put that into config.mak.

> > > diff --git a/compat/msvc.h b/compat/msvc.h
> > > index 6071565..a9d5f7f 100644
> > > --- a/compat/msvc.h
> > > +++ b/compat/msvc.h
> > > @@ -10,50 +10,120 @@
> > >  
> > >  /*Configuration*/
> > >  
> > > +#ifndef NO_PREAD
> > > #define NO_PREAD
> > > +#endif
> > 
> > Why?  You now have the stuff in two places.  If you want to keep them 
> > in compat/msvc.h to be able to generate .vcproj files, I'd rather not 
> > have them duplicated in the Makefile.
>
> The changes to the msvc.h where added just keep Frank's vcproj project 
> working. I would have just nuked all that stuff in the msvc.h since the 
> Makefile would just provide it for me anyways..

So maybe you and Frank (and Pau) hash out what you want?

Ciao,
Dscho
