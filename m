From: Jeff King <peff@peff.net>
Subject: Re: Importing all modules in a CVS repo with git-cvsimport
Date: Wed, 19 Mar 2008 16:41:54 -0400
Message-ID: <20080319204154.GA19556@coredump.intra.peff.net>
References: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5E2-000683-Vy
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934564AbYCSUl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758662AbYCSUl6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:41:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2074 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934469AbYCSUl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:41:56 -0400
Received: (qmail 18316 invoked by uid 111); 19 Mar 2008 20:41:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Mar 2008 16:41:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Mar 2008 16:41:54 -0400
Content-Disposition: inline
In-Reply-To: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77543>

On Wed, Mar 19, 2008 at 06:35:36PM +0000, Alex Bennee wrote:

> I'm wanting to import the entirety of a CVS repository into git rather
> than an individual module. However every approach I've tried to do this
> fails as the underlying cvsps tool seems to only be able to deal with
> modules rather than the whole project.
> 
> Is there any invocation I could do that would do the whole import?

What do you want the result to look like? If you have CVS modules 'foo',
'bar', and 'baz', I assume you want a repository with subdirectories
'foo', 'bar', and 'baz'?

In that case, you can create a CVS module that just includes all three:

  cd /path/to/cvsroot
  mkdir all
  cd all
  for i in foo bar baz; do
    ln -s ../$i
  done

and then:

  git cvsimport all

You might be able to do something similar with the CVSROOT/modules file,
but I haven't tried.

-Peff
