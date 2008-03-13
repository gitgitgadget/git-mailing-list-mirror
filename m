From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/16] solaris portability patches
Date: Thu, 13 Mar 2008 09:15:49 -0400
Message-ID: <20080313131549.GK19485@coredump.intra.peff.net>
References: <20080312212932.GA26286@coredump.intra.peff.net> <7v4pbbys4a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 14:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnIO-0007MJ-IZ
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYCMNPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbYCMNPx
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:15:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1709 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbYCMNPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:15:52 -0400
Received: (qmail 31280 invoked by uid 111); 13 Mar 2008 13:15:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 09:15:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 09:15:49 -0400
Content-Disposition: inline
In-Reply-To: <7v4pbbys4a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77078>

On Thu, Mar 13, 2008 at 12:56:21AM -0700, Junio C Hamano wrote:

> Whew, a huge series.

Yes, sorry to spam you when we are supposed to be freezing. I saw that
Whit was still trying to run the testsuite, and I thought "I'll just
take a quick peek at getting this to run." 16 patches and a half day's
missing day-job work later, you see the result. :)

> I've queued the following for now.
> 
>     [PATCH 01/16] tr portability fixes
>     [PATCH 02/16] t0050: perl portability fix
>     [PATCH 03/16] more tr portability test script fixes
>     [PATCH 04/16] grep portability fix: don't use "-e" or "-q"
>     [PATCH 05/16] remove use of "tail -n 1" and "tail -1"
>     [PATCH 06/16] add test_cmp function for test scripts
>     [PATCH 07/16] t4020: don't use grep -a
>     [PATCH 09/16] t6000lib: tr portability fix
>     [PATCH 10/16] add NO_EXTERNAL_GREP build option
>     [PATCH 13/16] filter-branch: don't use xargs -0
>     [PATCH 14/16] filter-branch: use $SHELL_PATH instead of 'sh'
>     [PATCH 15/16] t9112: add missing #!/bin/sh header
>     [PATCH 16/16] t7505: use SHELL_PATH in hook
> 
> but being this close to -rc0 I do not really enjoy too disruptive
> patches.

A lot of these are "help the test scripts run" and not "help git run."
However, the "help git run" ones are probably nice for Solaris people.
OTOH, most of them probably have xpg4 in their PATH, which helps a lot
(although things like 14/16 mean filter-branch is totally broken for
anyone on Solaris).

I think the ones you dropped make sense. I'll put "try to clean up
builtin-config" on my post-1.5.5 todo. In the meantime, I think it is
only hurting git-submodule users on Solaris who don't have xpg4 in their
PATH.

The t4200 thing is potentially showing a bug in builtin-rerere, so I
think following up on that is worthwhile. I'll see if I can construct a
multi-file test case to trigger it.

-Peff
