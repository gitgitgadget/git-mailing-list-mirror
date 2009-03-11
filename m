From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] connect.c: remove a few globals by using git_config
  callback data
Date: Wed, 11 Mar 2009 14:28:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111427120.10498@intel-tinevez-2-302>
References: <1236739092-8280-1-git-send-email-kusmabite@gmail.com>  <alpine.DEB.1.00.0903111251160.10279@pacific.mpi-cbg.de> <40aa078e0903110617g60e0d7d0x1e0d94e44ef89f40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2059770444-1236778104=:10498"
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 14:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhOVt-00080q-8Y
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 14:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbZCKN22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 09:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754617AbZCKN22
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 09:28:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:42954 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754355AbZCKN21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 09:28:27 -0400
Received: (qmail invoked by alias); 11 Mar 2009 13:28:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 11 Mar 2009 14:28:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sIn43t4jsuttBSCC1id+x3mAO9EWrBic6voi0EP
	pHou2vhEXCKydc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <40aa078e0903110617g60e0d7d0x1e0d94e44ef89f40@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112928>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2059770444-1236778104=:10498
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 11 Mar 2009, Erik Faye-Lund wrote:

> On Wed, Mar 11, 2009 at 12:52 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> @@ -383,6 +381,8 @@ static int git_proxy_command_options(const char *var, const char *value,
> >>               const char *for_pos;
> >>               int matchlen = -1;
> >>               int hostlen;
> >> +             const char *rhost_name = cb;
> >> +             int rhost_len = strlen(rhost_name);
> >
> > I see that you still calculate the length everytime
> > git_proxy_command_options() is called -- which is for every config
> > variable.
> 
> Actually, the length-calculation is now moved inside the check for
> "core.gitproxy", so it should only trigger for each config variable
> that is "core.gitproxy". Hopefully, this should usually be just once
> ;)
> 
> This change was suggested as a compromise by Junio.

Ah, okay, I am lacking time to read all emails today, so I missed that 
one.

> >> +     git_config(git_proxy_command_options, (void*)host);
> >
> > The (void *) should not be needed.
> 
> Actually, it is - it casts away the const-ness of the string. Removing
> the cast generates a warning on my installation of GCC. Perhaps I
> should have made that clearer by casting to "char*" instead of
> "void*"?

Oh, that's why... Thanks for the clarification!  Now only a space between 
the void and the star, and I am happy!

Ciao,
Dscho

--8323329-2059770444-1236778104=:10498--
