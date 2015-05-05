From: Jeff King <peff@peff.net>
Subject: Re: multiple source file extensions
Date: Tue, 5 May 2015 15:12:38 -0400
Message-ID: <20150505191238.GC10463@peff.net>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
 <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
 <20150502011100.GB5634@peff.net>
 <CACnwZYdGKcdzgu1=Ysd_pxqeuSBpZu41i1EJBvBi4FqHzvV-Hw@mail.gmail.com>
 <20150505034336.GA25194@peff.net>
 <CAHYJk3TzZd8N6E+=nNi1jR36Zc5A7be8ZPL9jLU7c8uAdQJYBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thiago Farina <tfransosi@gmail.com>,
	Josh Hagins <hagins.josh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 21:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpiGr-0008Jt-W9
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 21:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922AbbEETMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 15:12:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:54403 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752977AbbEETMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 15:12:41 -0400
Received: (qmail 23021 invoked by uid 102); 5 May 2015 19:12:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 14:12:40 -0500
Received: (qmail 9595 invoked by uid 107); 5 May 2015 19:13:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 15:13:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 15:12:38 -0400
Content-Disposition: inline
In-Reply-To: <CAHYJk3TzZd8N6E+=nNi1jR36Zc5A7be8ZPL9jLU7c8uAdQJYBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268415>

On Tue, May 05, 2015 at 07:30:00PM +0200, Mikael Magnusson wrote:

> >> ".*\.[cChH]\(pp\)?"
> >
> > No, pathspecs are globs, not regexps. I think the idea has been floated
> > for supporting regexps, which you would activate something like:
> >
> >   git grep pattern -- :(regexp)$your_regex_here
> >
> > but nobody has implemented it. I'm not sure it actually saves you any
> > typing (besides which, your regexp does not match ".cc", which was in
> > the original).
> 
> Remember that the more bells and whistles you add to pathspecs, the
> less actual filenames can be conveniently tracked by git; *.c will be
> expanded by the shell and passed literally to git, and if git then
> interprets a bunch of stuff again, you could end up with a false
> negative or positive match. Obviously files with * and ? in them are
> already unsupported, try not to add more.

I agree this is a problem, but I think we have already crossed that
bridge, and going forward:

  1. Any new bells and whistles will have to be activated explicitly
     (that's what the ":(regexp)" syntax is).

  2. The ":()" magic is already there, so add it to "*" and "?" in the
     list of obstacles.

  3. There is ":(literal)", "--literal-pathspecs", and $GIT_LITERAL_PATHSPECS
     to turn off all magic.

-Peff
