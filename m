From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Mon, 1 Dec 2008 21:48:37 -0500
Message-ID: <20081202024837.GB6804@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net> <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org> <20081108142756.GC17100@coredump.intra.peff.net> <ee2a733e0812011822r4cef6a44ra68d6e84f9e30a90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 03:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7LKm-0008LX-Ag
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 03:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbYLBCsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 21:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbYLBCsj
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 21:48:39 -0500
Received: from peff.net ([208.65.91.99]:3377 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbYLBCsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 21:48:39 -0500
Received: (qmail 8210 invoked by uid 111); 2 Dec 2008 02:48:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 21:48:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 21:48:37 -0500
Content-Disposition: inline
In-Reply-To: <ee2a733e0812011822r4cef6a44ra68d6e84f9e30a90@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102114>

On Mon, Dec 01, 2008 at 09:22:43PM -0500, Leo Razoumov wrote:

> I do not think that having a work-flow different from yours deserves a
> "somewhat insane" label. But let us consider the consequences of

  a) you are responding to a nearly month-old message. Please read the
     rest of the thread where we decide that it is not so insane, and
     that the behavior should be configurable with a default of "warn"
     at least for now.

  b) My comment was not that it is insane simply because it is different
     from mine. It is because it creates a dangerous situation (where
     dangerous implies changes might be silently lost) which requires
     manual intervention to fix, and which the user was given no warning
     whatsoever about. It is a direct response to frequent complaints on
     the list about users getting bit by this.

> (1) Switch target's current branch to something else (prevent a
> conflict) before pushing and then restore it back after the push
> 
> (2) Use git-fetch from the target.

(3) Use git-reset --hard, but set a config variable that says "I know
what I'm doing." You don't even have to do it per-repo, you can do it
per-user.

(4) Push into a non-current branch and merge from the target.

> Method (2) is even worse, because git-fetch provides no control of
> what branches/tags to fetch, it sucks everything in from all branches.
> "git-push", OTOH, can be instructed to be very selective.

Er, what? git-fetch takes a refspec very similar to the ones used by
git-push. The real reason that (2) is not an acceptable solution is that
you can't necessarily connect to the source repo (e.g., it is on your
workstation with no ssh or git server running).

-Peff
