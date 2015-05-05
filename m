From: Jeff King <peff@peff.net>
Subject: Re: multiple source file extensions
Date: Mon, 4 May 2015 23:43:36 -0400
Message-ID: <20150505034336.GA25194@peff.net>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
 <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
 <20150502011100.GB5634@peff.net>
 <CACnwZYdGKcdzgu1=Ysd_pxqeuSBpZu41i1EJBvBi4FqHzvV-Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Hagins <hagins.josh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 05:43:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpTlw-0002BT-51
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 05:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbbEEDnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 23:43:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:54163 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752431AbbEEDnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 23:43:39 -0400
Received: (qmail 8729 invoked by uid 102); 5 May 2015 03:43:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 May 2015 22:43:39 -0500
Received: (qmail 4147 invoked by uid 107); 5 May 2015 03:44:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 May 2015 23:44:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 May 2015 23:43:36 -0400
Content-Disposition: inline
In-Reply-To: <CACnwZYdGKcdzgu1=Ysd_pxqeuSBpZu41i1EJBvBi4FqHzvV-Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268383>

On Mon, May 04, 2015 at 07:12:45PM -0300, Thiago Farina wrote:

> On Fri, May 1, 2015 at 10:11 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, May 01, 2015 at 08:49:14PM -0400, Josh Hagins wrote:
> >
> >> If you're using a recent version of bash, you could enable the
> >> 'globstar' option:
> >>
> >>     $ shopt -s globstar
> >>     $ git grep 'pattern' **/*.{cc,cpp,h}
> >>
> >> Does that work?
> >
> > That will only pick up files that are in the working tree. Which is fine
> > for a stock "git grep" with no options, but would not be right for
> > grepping in the index or an older tree. For that, you can ask git to
> > glob for you:
> >
> >   git grep pattern -- '*.cc' '*.cpp' '*.h'
> >
> Is it possible to do a regex like the following?
> 
> ".*\.[cChH]\(pp\)?"

No, pathspecs are globs, not regexps. I think the idea has been floated
for supporting regexps, which you would activate something like:

  git grep pattern -- :(regexp)$your_regex_here

but nobody has implemented it. I'm not sure it actually saves you any
typing (besides which, your regexp does not match ".cc", which was in
the original).

-Peff
