From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Sat, 23 Dec 2006 15:12:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612231510130.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061222221913.GA3071@cepheus> <Pine.LNX.4.63.0612222331581.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612230048350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061223085206.GA2189@cepheus>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-150421181-1166883132=:19693"
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Dec 23 15:12:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy7bo-0000JS-0q
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbWLWOMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbWLWOMQ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:12:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:56291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753151AbWLWOMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:12:15 -0500
Received: (qmail invoked by alias); 23 Dec 2006 14:12:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 23 Dec 2006 15:12:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20061223085206.GA2189@cepheus>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35315>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-150421181-1166883132=:19693
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 23 Dec 2006, Uwe Kleine-König wrote:

> Johannes Schindelin wrote:
> > @@ -127,6 +128,15 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
> >  	while (fgets(comment, sizeof(comment), stdin) != NULL)
> >  		add_buffer(&buffer, &size, "%s", comment);
> >  
> > +	/* And check the encoding */
> > +	buffer[size] = '\0';
> > +	if (!strcmp(git_commit_encoding, "utf-8") && !is_utf8(buffer)) {
> Maybe you could be more generous here.  E.g.
> 
> 	if ((!strcasecmp(git_commit_encoding, "utf-8") ||
> 	!strcasecmp(git_commit_encoding, "utf8")) && !is_utf8(buffer))
> 
> Junio suggested to make this check if i18n.commitEncoding is empty.  I
> didn't check the code to see if this case is included.

The problem is, as I pointed out in another mail, that environment.c sets 
the default git_commit_encoding to "utf-8". This is hardwired, and I have 
no way to check if that was set by the config or not, other than reparsing 
the config myself.

> Gruessle

Hah! You don't use umlauts and ssharp yourself!

Ciao,
Dscho
---1148973799-150421181-1166883132=:19693--
