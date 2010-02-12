From: Eric Wong <normalperson@yhbt.net>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 08:06:20 +0000
Message-ID: <20100212080620.GA31719@dcvr.yhbt.net>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 09:06:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfqXi-0001FY-TZ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 09:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab0BLIGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 03:06:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43993 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839Ab0BLIGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 03:06:21 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 1525A1F4F1;
	Fri, 12 Feb 2010 08:06:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139661>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
> 
> Dscho created a GSoC 2010 idea's page [0] a few weeks ago, but it's a
> bit sad at the moment (only two idea's). Part of the reason Git was
> listed as 'example application' before was our awesome idea list, we
> should live up to that again this year :). If you feel like mentoring
> a summer of code student, or if you have a great idea, please add it
> to the list so that our would-be students have some variety in
> choosing their projects. I just added "A remote helper for svn" [1]
> myself, since I would love to see native svn support in git. Would
> either Daniel or Eric (or someone else of course) be interested in
> being a co- or backup-mentor for this project?

Hi Sverre,

I can't commit to anything, but they're welcome to email me/the list for
guidance.  I've left some notes further down in this email as well...

  It's been a long time since I've had time (or need, since most projects
  I care about have moved to git) to hack on git-svn.

  The git-vcs-* stuff is interesting and a good reason to refactor/redo
  parts of git-svn to work with it.  It's been overdue for a
  refactoring/cleanup for _years_ now.


I can't say SVN (nor the Perl support libraries) are pleasant to work
with.  Things to keep in mind:

* avoid memory leaks by using explicit pools

* avoid memory errors (which are much harder to track down
  wrapped around layers of SWIG/XS/SVN library abstractions).
  We sometimes copy SVN native data types into normal Perl ones
  ASAP to avoid errors/leaks

* inconsistent between different repo types:
  - escaping may be rules are stricter/laxer for some paths
  - error codes aren't consistent

* inability to safely maintain multiple connections to a repo
  in one process

I'm sure I'm missing some things here that my mind just blocked
out entirely...

All of them should be well-documented in the git-svn commit history
and/or comments.

-- 
Eric Wong
