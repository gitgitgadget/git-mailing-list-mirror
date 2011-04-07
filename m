From: Jeff King <peff@peff.net>
Subject: Re: Bug Report: git add
Date: Wed, 6 Apr 2011 20:57:50 -0400
Message-ID: <20110407005750.GC28813@sigill.intra.peff.net>
References: <4D9BA35E.6040204@dcook.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Darren Cook <darren@dcook.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 02:58:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dXt-0004pV-LT
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 02:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020Ab1DGA54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 20:57:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38277
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756680Ab1DGA5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 20:57:55 -0400
Received: (qmail 11753 invoked by uid 107); 7 Apr 2011 00:58:39 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 20:58:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 20:57:50 -0400
Content-Disposition: inline
In-Reply-To: <4D9BA35E.6040204@dcook.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171031>

On Wed, Apr 06, 2011 at 08:18:54AM +0900, Darren Cook wrote:

> PROBLEM: "git add" adds sub-directories without checking to see if there
> is already a git repository already there.

Sort of...

> EXAMPLE OF PROBLEM
> 
> The problem can arise when people are just dipping their toe into git,
> and decide to try it on just one directory, then later expand its use to
> the whole project.
> 
>   mkdir test
>   cd test
> 
>   mkdir settings
>   cd settings
>   git init
>   touch x
>   git add x
>   git commit -m "xx"
> 
>   (time passes)
> 
>   cd ..
>   git init
>   git add settings/
>    (should complain)

If you do "git add settings" (without the slash) it will add the
repository as a submodule.  Which is not the behavior you asked for, but
is at least reasonable. So the real bug seems to me the fact that "git
add settings/" and "git add settings" behave differently.

-Peff
