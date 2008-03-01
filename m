From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when not running verbosely
Date: Fri, 29 Feb 2008 23:27:39 -0500
Message-ID: <20080301042739.GX8410@spearce.org>
References: <1204323805-23185-1-git-send-email-mh@glandium.org> <alpine.LSU.1.00.0802292334040.22527@racer.site> <7v1w6vb9w4.fsf@gitster.siamese.dyndns.org> <20080301041005.GA8969@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 05:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVJKi-0002wF-Np
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 05:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbYCAE1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 23:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYCAE1s
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 23:27:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34550 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbYCAE1s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 23:27:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JVJJo-0004at-9N; Fri, 29 Feb 2008 23:27:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5013020FBAE; Fri, 29 Feb 2008 23:27:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080301041005.GA8969@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75607>

Jeff King <peff@peff.net> wrote:
> On Fri, Feb 29, 2008 at 03:50:03PM -0800, Junio C Hamano wrote:
> 
> > Actually, I think this might be a bit more sensible approach.
> > 
> > -- >8 --
> > tests: allow optional clean-up phrase to expect_success/failure
> > 
> > When one test modifies the state of the test repository that the later
> > tests may depend on, you may want to add a clean-up action that is run
> > regardless of the outcome of the main part of the test.
> 
> I think your heart is in the right place with this patch, but I doubt
> that it is going to be all that productive in practice. Most tests
> consist of a long list of commands, and cleaning up properly after every
> possible failure case is going to be a lot of work. And worse, since the
> tests generally _don't_ fail, you have no way to test that your cleanup
> is reasonable.
> 
> So I think we will end up in the case where a few failed tests will
> properly clean themselves up and let further tests proceed, but most
> failures will leave a big question. In other words, what problem have we
> solved?  If tests N and N+k both fail, would you, even with this patch,
> suspect N+k of actually failing, or would you first go and debug test N?
> Is that any different than what you do now?

I agree with Jeff.  It is unnecessary complexity that won't be
tested well enough to be worthwhile.

This is why when tests start to fail I just rerun the specific case
with "-i -v" and let the test stop on the first failure, *fix that
one case* and run again to see if anything else is going to barf.

-- 
Shawn.
