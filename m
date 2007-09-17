From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 9/9] Implement git commit as a builtin command.
Date: Tue, 18 Sep 2007 00:16:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709180012420.28586@racer.site>
References: <11890382183913-git-send-email-krh@redhat.com> 
 <11890382242333-git-send-email-krh@redhat.com>  <11890382243290-git-send-email-krh@redhat.com>
  <11890382253220-git-send-email-krh@redhat.com>  <11890382252522-git-send-email-krh@redhat.com>
  <1189038225525-git-send-email-krh@redhat.com>  <11890382262161-git-send-email-krh@redhat.com>
  <11890382264046-git-send-email-krh@redhat.com>  <11890382271931-git-send-email-krh@redhat.com>
  <Pine.LNX.4.64.0709061741370.28586@racer.site> <1190069881.10112.10.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1347126458-1190070980=:28586"
Cc: git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPq7-00079u-1X
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbXIQXRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 19:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753767AbXIQXRJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:17:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:60572 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751726AbXIQXRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:17:08 -0400
Received: (qmail invoked by alias); 17 Sep 2007 23:17:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 18 Sep 2007 01:17:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186hpYk+Zw6sqtryoxc+Y4l44Fk/fQahg3sE6WOKg
	wPdRaYZG4RC6MH
X-X-Sender: gene099@racer.site
In-Reply-To: <1190069881.10112.10.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58496>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1347126458-1190070980=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Sep 2007, Kristian H?gsberg wrote:

> On Thu, 2007-09-06 at 17:59 +0100, Johannes Schindelin wrote:
> > 
> > On Wed, 5 Sep 2007, Kristian Høgsberg wrote:
> > 
> > > -	builtin-runstatus.o \
> > 
> > Better keep it; some people's scripts could depend on it.
> 
> Seriously?  Why don't we remove it and see if somebody yells?  It's more 
> of an implementation detail than most other git commands; if you need 
> status output in your script why wouldn't you just run git status?

git status is deemed porcelain.

Yes, we recently converted a few things to use "git log", which is 
porcelain, too, and I was not happy...

But then, you're right, we could just go and break peoples' scripts, if 
they indeed did not use "git diff" directly.

> > > +struct option {
> > > +    enum option_type type;
> > > +    const char *long_name;
> > > +    char short_name;
> > > +    void *value;
> > > +};
> > > +
> > > +static int scan_options(const char ***argv, struct option *options)
> > > +{
> > 
> > I would not (no longer, anyway) be opposed to replacing the option parsing 
> > in git with getopt(); I hear that it is small enough to keep a copy in 
> > compat/getopt.c.
> > 
> > But let's go forward with builtin-commit; getopt() can come later.
> 
> I don't know.  I think it's a situation much like the string library 
> discussion.  It's a small enough dependency (70 lines!) that there's no 
> gain in depending on an external implementation, and we can tailor it to 
> gits needs as we extend the use within git.  And we can call it gitopt!

Hm.  I liked the semantics of getopt better, but what the heck.

> I'm sending an updated version against Pierre's strbuf changes now. It's 
> a smaller patch set, so hopefully we can get it in soon.

Yes, that would be good.

Thanks,
Dscho

--8323584-1347126458-1190070980=:28586--
