From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Thu, 20 Dec 2007 11:51:50 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712201145390.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
 <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com>
 <20071218222032.GH2875@steel.home> <Pine.LNX.4.64.0712182239500.23902@racer.site>
 <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
 <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
 <Pine.LNX.4.64.0712191334460.23902@racer.site> <7vr6hirx5l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 11:52:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5J0k-00008R-1D
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 11:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969AbXLTKvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 05:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbXLTKvz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 05:51:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:45524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752548AbXLTKvy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 05:51:54 -0500
Received: (qmail invoked by alias); 20 Dec 2007 10:51:52 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp051) with SMTP; 20 Dec 2007 11:51:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iZ1gEx9ci+1wm2MS2X2q0LesVaUJfgIR1jEsARW
	r5cjkiSuU0iYin
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vr6hirx5l.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68991>

Hi,

On Wed, 19 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/cache.h b/cache.h
> > index 39331c2..83a2c31 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -225,6 +225,7 @@ extern char *get_index_file(void);
> >  extern char *get_graft_file(void);
> >  extern int set_git_dir(const char *path);
> >  extern const char *get_git_work_tree(void);
> > +extern const char *get_current_prefix(void);
> >  
> >  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
> >  
> > diff --git a/setup.c b/setup.c
> > index b59dbe7..fb9b680 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -3,6 +3,12 @@
> >  
> >  static int inside_git_dir = -1;
> >  static int inside_work_tree = -1;
> > +static const char *current_prefix;
> > +
> > +const char *get_current_prefix()
> > +{
> > +	return current_prefix;
> > +}
> 
> Didn't you just make libification harder?

Well, yes.

Actually, no:

	- I marked this explicitely not ready for application,
	- it is not entirely clear if a libgit.a user would not want to 
	  set a default prefix, and
	- I decided that I will not be the only one who tries to make 
		  libification easy. ;-)

Ciao,
Dscho
