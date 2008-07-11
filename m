From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fixed text file auto-detection: treat EOF character 032
 at the end of file as printable
Date: Fri, 11 Jul 2008 21:40:47 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112136270.8950@racer>
References: <7vabh0d4t9.fsf@gitster.siamese.dyndns.org> <1215794896-31354-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807111940420.8950@racer> <920CBA3F-779D-4861-B447-135690B4E8BD@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 22:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHPR6-0003Ih-V9
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 22:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYGKUkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbYGKUku
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 16:40:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:56659 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751365AbYGKUkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 16:40:49 -0400
Received: (qmail invoked by alias); 11 Jul 2008 20:40:47 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp041) with SMTP; 11 Jul 2008 22:40:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rrH4zuqwrsOlJuh/L2k9hF+Qx3QoYM3gWtRpfWk
	AlY9OhTUav01NK
X-X-Sender: gene099@racer
In-Reply-To: <920CBA3F-779D-4861-B447-135690B4E8BD@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88171>

Hi,

On Fri, 11 Jul 2008, Steffen Prohaska wrote:

> On Jul 11, 2008, at 8:42 PM, Johannes Schindelin wrote:
> 
> >On Fri, 11 Jul 2008, Steffen Prohaska wrote:
> >
> > >From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
> > >
> > >Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
> > >Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> > >---
> > >convert.c |    4 ++++
> > >1 files changed, 4 insertions(+), 0 deletions(-)
> > >
> > >diff --git a/convert.c b/convert.c
> > >index 352b69d..78efed8 100644
> > >--- a/convert.c
> > >+++ b/convert.c
> > >@@ -61,6 +61,10 @@ static void gather_stats(const char *buf, unsigned long
> > >size, struct text_stat *
> > >  else
> > > 		stats->printable++;
> > >	}
> > >+
> > >+	/* If file ends with EOF then don't count this EOF as non-printable.
> > >*/
> > >+	if (size >= 1 && buf[size-1] == '\032')
> > >+		stats->nonprintable--;
> >
> >This is one of the things that are very specific to Windows and should not
> >affect other people.
> 
> Does this mean you are opposed to this change?

Hrm.  Thinking about it again, this _could_ help Unix people who 
collaborate with DOS people.

OTOH it will just hide the fact that text files were committed that 
contain silly characters.

On the third hand, this code path affects only people who set autocrlf.

Well, I guess they asked for it, kind of.

Ciao,
Dscho
