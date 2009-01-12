From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] grep: don't call regexec() for fixed strings
Date: Mon, 12 Jan 2009 14:33:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901121433240.3586@pacific.mpi-cbg.de>
References: <4967D8F8.9070508@lsrfire.ath.cx> <4967DB4A.2000702@lsrfire.ath.cx> <237967ef0901120425x79b7c1a4p238081a99694ae23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2057107379-1231767224=:3586"
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 14:34:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMMvv-0006WJ-DY
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 14:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbZALNc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 08:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbZALNc6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 08:32:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:38416 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751045AbZALNc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 08:32:58 -0500
Received: (qmail invoked by alias); 12 Jan 2009 13:32:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 12 Jan 2009 14:32:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+T30JZUimTRyPM/enLBkNNTxugVdlKWq0wADqh4x
	nhz0sBUgzJoGBd
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <237967ef0901120425x79b7c1a4p238081a99694ae23@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105342>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2057107379-1231767224=:3586
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 12 Jan 2009, Mikael Magnusson wrote:

> 2009/1/10 René Scharfe <rene.scharfe@lsrfire.ath.cx>:
> > Add the new flag "fixed" to struct grep_pat and set it if the pattern
> > is doesn't contain any regex control characters in addition to if the
> > flag -F/--fixed-strings was specified.
> >
> > diff --git a/grep.c b/grep.c
> > index 394703b..a1092df 100644
> > --- a/grep.c
> > +++ b/grep.c
> > @@ -28,9 +28,31 @@ void append_grep_pattern(struct grep_opt *opt, const char *pat,
> >        p->next = NULL;
> >  }
> >
> > +static int isregexspecial(int c)
> > +{
> > +       return isspecial(c) || c == '$' || c == '(' || c == ')' || c == '+' ||
> > +                              c == '.' || c == '^' || c == '{' || c == '|';
> > +}
> 
> Shouldn't this include '*' and '\'?

This is covered by isspecial(): see ctype.c.

Hth,
Dscho

--8323328-2057107379-1231767224=:3586--
