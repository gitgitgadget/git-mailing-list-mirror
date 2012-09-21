From: Jeff King <peff@peff.net>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 19:37:24 -0400
Message-ID: <20120921233723.GA29433@sigill.intra.peff.net>
References: <505C7C80.3000700@workspacewhiz.com>
 <7vy5k370n7.fsf@alter.siamese.dyndns.org>
 <505CB21E.4040607@workspacewhiz.com>
 <7vtxur3zxi.fsf@alter.siamese.dyndns.org>
 <505CCD2A.8020003@workspacewhiz.com>
 <505CD2FA.80200@kdbg.org>
 <505CD7D0.2000505@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 01:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFCmu-0004ek-18
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 01:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab2IUXh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 19:37:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53863 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2IUXh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 19:37:26 -0400
Received: (qmail 11887 invoked by uid 107); 21 Sep 2012 23:37:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 19:37:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 19:37:24 -0400
Content-Disposition: inline
In-Reply-To: <505CD7D0.2000505@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206177>

On Fri, Sep 21, 2012 at 03:10:40PM -0600, Joshua Jensen wrote:

> ----- Original Message -----
> From: Johannes Sixt
> Date: 9/21/2012 2:50 PM
> >The trick is to pipe 'git log' output into another process that reads no
> >more than it needs and exits. Then 'git log' dies from SIGPIPE before it
> >processed all 1000 commits because its down-stream has gone away.
> >
> >For example:
> >
> >   git log --show-notes=p4notes -1000 |
> >   sed -n -e '/^commit /h' -e '/P4@/{H;g;p;q}'
> >
> >(The pipeline keeps track of the most recent 'commit' line, and when it
> >finds the 'P4@' it prints the most recent 'commit' line followed by the
> >'P4@' line.)
> >
> Got it.  I'll try that out now.

I think people have provided sane techniques for doing this with a
pipeline. But there is really no reason not to have --grep-notes, just
as we have --grep.  It's simply that nobody has implemented it yet (and
nobody is working on it as far as I know). It would actually be a fairly
simple feature to add if somebody wanted to get their feet wet with git.

-Peff
