From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix set_work_tree on cygwin
Date: Thu, 2 Aug 2007 22:04:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708022204170.14781@racer.site>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
 <Pine.LNX.4.64.0708021636470.14781@racer.site> <20070802204909.GA2829@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGhre-0006Mx-Cu
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761035AbXHBVF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760387AbXHBVF2
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:05:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:51727 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760517AbXHBVFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:05:25 -0400
Received: (qmail invoked by alias); 02 Aug 2007 21:05:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 02 Aug 2007 23:05:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HlIEQAxkHRFgG1POLVl9aRIwYVhpTRF44vq1SNe
	kNw3eRLFNxuWgg
X-X-Sender: gene099@racer.site
In-Reply-To: <20070802204909.GA2829@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54611>

Hi,

On Thu, 2 Aug 2007, Alex Riesen wrote:

> Johannes Schindelin, Thu, Aug 02, 2007 17:38:37 +0200:
> 
> > On Thu, 2 Aug 2007, Alex Riesen wrote:
> > 
> > >@@ -209,7 +209,8 @@ const char *set_work_tree(const char *dir)
> > >        len = strlen(dir);
> > >        if (len > postfix_len && !strcmp(dir + len - postfix_len,
> > >                                "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
> > >-                       strncpy(dir_buffer, dir, len - postfix_len);
> > >+               strncpy(dir_buffer, dir, len - postfix_len);
> > >+               dir_buffer[len - postfix_len] = '\0';
> > >
> > >                /* are we inside the default work tree? */
> > >                rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
> > 
> > Darn, darn, darn.  strncpy does _not_ NUL terminate.  I keep forgetting 
> > that.
> > 
> > Better use strlcpy()?
> 
> Of course, but it just should not be needed at all: static supposed to
> be zeroed.

Certainly.  But reality outweighs theory, and so I Ack either your patch 
or replacing it by strlcpy().

Ciao,
Dscho
