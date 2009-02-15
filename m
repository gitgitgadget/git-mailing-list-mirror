From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git diff ignore-space options should ignore missing EOL
  at EOF differences
Date: Sun, 15 Feb 2009 16:17:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151615400.10279@pacific.mpi-cbg.de>
References: <9b18b3110902150609q13333619k98f87a4a36a09030@mail.gmail.com>  <alpine.DEB.1.00.0902151554000.10279@pacific.mpi-cbg.de> <9b18b3110902150713q62a73febs3d76ebf6e0d93c46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, davidel@xmailserver.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 16:18:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYilS-0004eR-Ef
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 16:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbZBOPQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 10:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbZBOPQ4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 10:16:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:50761 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751372AbZBOPQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 10:16:56 -0500
Received: (qmail invoked by alias); 15 Feb 2009 15:16:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 15 Feb 2009 16:16:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18U2fgRyJoUUckMJ1ODvKbmfpoJV76So0c2PIxLHI
	JQ6gWu4qib6s2f
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <9b18b3110902150713q62a73febs3d76ebf6e0d93c46@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110016>

Hi,

On Sun, 15 Feb 2009, demerphq wrote:

> 2009/2/15 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Hi,
> >
> > On Sun, 15 Feb 2009, demerphq wrote:
> >
> >>  t/t4015-diff-whitespace.sh             |   79 ++++++++++++++++++++++++++++++++
> >
> > Phew, you certainly want to make sure that it works...
> 
> Yeah, Exhaustive testing is good. (When it doesn't take hours and
> hours to run :-)

You read my mind.

> >> @@ -33,7 +33,14 @@ extern "C" {
> >>  #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
> >>  #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
> >>  #define XDF_PATIENCE_DIFF (1 << 5)
> >> -#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
> >> XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
> >> +#define XDF_IGNORE_WHITESPACE_AT_EOF (1 << 6)
> >> +/*
> >> + * note this is deliberately a different define from XDF_WHITESPACE_FLAGS as
> >> + * there could be a new whitespace related flag which would not be part of
> >> + * the XDF_IGNORE_WHITESPACE_AT_EOF_ANY flags.
> >> + */
> >> +#define XDF_IGNORE_WHITESPACE_AT_EOF_ANY
> >> (XDF_IGNORE_WHITESPACE_AT_EOL | XDF_IGNORE_WHITESPACE_CHANGE |
> >> XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_AT_EOF)
> >> +#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
> >> XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL |
> >> XDF_IGNORE_WHITESPACE_AT_EOF)
> >
> > As I told you on IRC, I do not follow that reasoning.  Rather, I would add
> > the exceptions to xemit.c, when -- and if(!) -- they are needed.
> 
> Yeah I know you said that, and I *think* I followed all your advice
> (much appreciated by the way) except for that point as I've been
> nailed by inappropriate addition of flags to masks before, and well,
> you know, once bitten twice shy, and patchers perogative and all that
> eh? :-)

I understand that, but IMHO it is overengineered.  I am not really 
convinced that ignore-whitespace-at-sol makes sense, either...

Ciao,
Dscho
