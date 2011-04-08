From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 8 Apr 2011 18:32:07 -0400
Message-ID: <20110408223206.GA7343@sigill.intra.peff.net>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8KE1-0006lP-6n
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648Ab1DHWcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 18:32:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53390
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab1DHWcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:32:10 -0400
Received: (qmail 6311 invoked by uid 107); 8 Apr 2011 22:32:57 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 18:32:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 18:32:07 -0400
Content-Disposition: inline
In-Reply-To: <7vmxk01izn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171169>

On Fri, Apr 08, 2011 at 03:22:20PM -0700, Junio C Hamano wrote:

> So let's step back a bit.
> 
> How about we'd just add ':/' to make it equally easy to switch between
> "local only" vs "tree-wide" in 1.7.6 release, and be done with it.  We
> don't change the default for any of the commands at all.

Yeah, I am beginning to think that is a sensible route. And it commits
us to nothing, so if we decide much later that a change of default is
sensible, that is still open to us.

> Since more than a year ago, I've been saying that the ideal is to make the
> default not matter:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/133570/focus=133683
> 
> If the default does not matter, why change it?  It just causes us more
> headaches for dubious gain, no?

I'm not sure how much you can achieve the "make it not matter". The
shorthands go a long way, but I still want git to read my mind about
which I wanted to use (and the closest approximation of that, from my
experience, would be a per-repo variable). However, having the
shorthands mean that we can try them out in the real world and revisit
the topic in a year if people still care.

> IIRC, I think the two reasons why we started discussing of "add -u" and
> friends were that (1) some commands default to whole-tree while others
> limit to $cwd --- inconsistency is bad; and (2) when the user wants to do
> a full tree "add -u", there is no way other than counting the current
> depth and typing "../" that many times.
> 
> But when we looked at the current set of commands that limit them to the $cwd,
> we found that "add -u" was the only one that may make sense to switch the
> default, meaning that the "consistency" was not something we would even
> want to shoot for.  For example, we want our "git grep -e pattern" to
> mimic "grep -r -e pattern .".

I am not sure of that. I thought there was interest in full-tree grep
(OK, _I_ had some interst in it).  But the same transition pain
arguments apply there, and we should be able to do "git grep pattern :/"
soon, right?

-Peff
