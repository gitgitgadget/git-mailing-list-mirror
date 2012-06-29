From: Jeff King <peff@peff.net>
Subject: Re: Apostrophe at the end of author name
Date: Fri, 29 Jun 2012 13:43:58 -0400
Message-ID: <20120629174358.GB3804@sigill.intra.peff.net>
References: <20120629124122.GG1258@camk.edu.pl>
 <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kacper Kornet <draenog@pld-linux.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Jun 29 19:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkfEl-0000zp-6G
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 19:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab2F2RoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 13:44:03 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:49504
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756117Ab2F2RoB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 13:44:01 -0400
Received: (qmail 14253 invoked by uid 107); 29 Jun 2012 17:44:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Jun 2012 13:44:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jun 2012 13:43:58 -0400
Content-Disposition: inline
In-Reply-To: <robbat2-20120629T170457-788694600Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200819>

On Fri, Jun 29, 2012 at 05:05:31PM +0000, Robin H. Johnson wrote:

> On Fri, Jun 29, 2012 at 02:41:22PM +0200,  Kacper Kornet wrote:
> > I try to import some repositories into git and one of the developers has
> > asked his name to be presented as: Name 'Nick' <email>.
> > However git commit --author="Name 'Nick' <email>" strips the last
> > apostrophe and produces a commit authored by: Name 'Nick <email>.
> > 
> > Maybe the function  strbuf_addstr_without_crud in ident.c should strip
> > the trailing apostrophe only when it removed it also from the beginning
> > of the string?
> Which version of Git? And is it being stripped by git, or one of the
> import tools?

I'm sure it's the most recent one, as strbuf_addstr_without_crud was
only added recently (but it is a refactoring of older code which should
have the same behavior). We had a similar complaint recently that
"A.B.C. <abc@example.com>" has its trailing dot stripped, even though
the internal ones are retained.

Those stripping rules date back to very early versions of git to try to
clean up cruft from gecos or other unreliable sources. I wonder if we
are better off being a bit more liberal.

-Peff
