From: Jeff King <peff@peff.net>
Subject: Re: [BUG] rebase -p loses commits
Date: Tue, 17 May 2011 12:12:34 -0400
Message-ID: <20110517161234.GA21388@sigill.intra.peff.net>
References: <20110516103354.GA23564@sigill.intra.peff.net>
 <7vfwoel6vw.fsf@alter.siamese.dyndns.org>
 <4DD1C277.9070605@sohovfx.com>
 <20110517054432.GC10048@sigill.intra.peff.net>
 <4DD29D4A.8090703@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue May 17 18:12:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMMt0-0003Mz-2m
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 18:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621Ab1EQQMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 12:12:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58124
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367Ab1EQQMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 12:12:36 -0400
Received: (qmail 30071 invoked by uid 107); 17 May 2011 16:14:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 12:14:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 12:12:34 -0400
Content-Disposition: inline
In-Reply-To: <4DD29D4A.8090703@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173812>

On Tue, May 17, 2011 at 12:07:38PM -0400, Andrew Wong wrote:

> > Is it really the first-parentness here that is important to the
> > asymmetry? I thought it was more the fact that "feature" has the merge,
> > but "master" does not.
> To know the fact that "feature" has the merge, don't we need to know
> that "feature" is the first parent of the merge? For example, if "F" is
> the head of "feature" and we're on "*" as a detached head, then we can
> only say "feature" has the merge if we know "feature" is the first parent.

No, if "F" is the head of "feature", then it does _not_ have the merge.
But it's not the merge that is important, it is really the fact that
if we are rebasing "feature" on "master", that "master ^feature" is
empty. IOW, we are already a superset. In this example, though, the
merge is the thing that gives us that superset.

> I agree that the outcome of both should be the same. Junio's patch will
> fix the case when we do "git rebase -p", but the bug will still appear
> as soon as we do "git rebase -p -i", which I think is where the source
> of the problem is. So we should be looking to fix the issue with "git
> rebase -p -i", which will also fix "git rebase -p" too.

Ah, I see. Yes, in that case, we should definitely be fixing "git rebase
-p -i".

-Peff
