From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] filter-branch: use git-sh-setup's ident parsing
 functions
Date: Thu, 18 Oct 2012 03:54:29 -0400
Message-ID: <20121018075429.GD9999@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072535.GB9999@sigill.intra.peff.net>
 <507FB470.2060404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:59:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOl0v-00031U-Cs
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 09:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab2JRHyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 03:54:32 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37558 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210Ab2JRHyc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 03:54:32 -0400
Received: (qmail 2807 invoked by uid 107); 18 Oct 2012 07:55:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 03:55:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 03:54:29 -0400
Content-Disposition: inline
In-Reply-To: <507FB470.2060404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207977>

On Thu, Oct 18, 2012 at 09:49:04AM +0200, Johannes Sixt wrote:

> > -			s/.*/GIT_'$uid'_NAME='\''&'\''; export GIT_'$uid'_NAME/p
> 
> Didn't you lose the export GIT_$uid_{NAME,EMAIL,DATE} parts somewhere on
> the way?

Yikes, you're right. I didn't even notice, as the test suite still
passes. I can see how the env filter would still be able to see the
variables, but the commit-tree call wouldn't. I guess it happens to work
because we do not test alternate idents in our filter branch tests (IOW,
we are silently rewriting each commit during the filter-branch, but it
happens to have the same identities).

I'll investigate.

-Peff
