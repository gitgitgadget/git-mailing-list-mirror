From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible with
  Git 1.6.3
Date: Fri, 8 May 2009 10:04:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905081003460.18521@pacific.mpi-cbg.de>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>  <1241708714-20326-2-git-send-email-spearce@spearce.org>  <200905080102.44053.robin.rosenberg@dewire.com>  <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>  <7vprekbfik.fsf@alter.siamese.dyndns.org>
  <20090508004741.GU30527@spearce.org> <81b0412b0905080024r211864bfhe7f70acabe0880c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-479720195-1241769877=:18521"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 10:04:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2L43-0002M5-Ct
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbZEHIEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754582AbZEHIEH
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:04:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:59787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756134AbZEHIEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:04:04 -0400
Received: (qmail invoked by alias); 08 May 2009 08:04:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 08 May 2009 10:04:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qx0BpxMbqW+OoZLaMOVBWMlZRVbBzwF5F/Y15uN
	7FOm4CvgGbhJtQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0905080024r211864bfhe7f70acabe0880c6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118581>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-479720195-1241769877=:18521
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 8 May 2009, Alex Riesen wrote:

> 2009/5/8 Shawn O. Pearce <spearce@spearce.org>:
> > --- a/lockfile.c
> > +++ b/lockfile.c
> > @@ -129,11 +129,11 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
> >        strcpy(lk->filename, path);
> >        /*
> >         * subtract 5 from size to make sure there's room for adding
> > -        * ".lock" for the lock file name
> > +        * "..lck" for the lock file name
> >         */
> >        if (!(flags & LOCK_NODEREF))
> >                resolve_symlink(lk->filename, sizeof(lk->filename)-5);
> > -       strcat(lk->filename, ".lock");
> > +       strcat(lk->filename, "..lck");
> >        lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
> 
> There must be at least some deprecation period during which
> also the old .lock lockfiles are considered and created.
> Just imagine someone modifying the ref with an older version,
> which knows nothing about ..lck.

As lock files are only supposed to be created by Git itself, and have a 
maximum lifetime until the end of the process, I think we do not need a 
grace period at all.

Ciao,
Dscho

--8323328-479720195-1241769877=:18521--
