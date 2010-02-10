From: Jeff King <peff@peff.net>
Subject: Re: [RFD] Notes are independent: proposal for new notes
 implementation
Date: Tue, 9 Feb 2010 23:51:50 -0500
Message-ID: <20100210045150.GB28526@coredump.intra.peff.net>
References: <201002092105.25636.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 05:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf4YS-0002A4-0H
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 05:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab0BJEvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 23:51:49 -0500
Received: from peff.net ([208.65.91.99]:59297 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab0BJEvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 23:51:48 -0500
Received: (qmail 29871 invoked by uid 107); 10 Feb 2010 04:51:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 09 Feb 2010 23:51:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Feb 2010 23:51:50 -0500
Content-Disposition: inline
In-Reply-To: <201002092105.25636.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139483>

On Tue, Feb 09, 2010 at 09:05:23PM +0100, Jakub Narebski wrote:

> The proposed solution was to use custom merge strategy for notes.  But
> what if the answer was to change implementation, decoupling history of
> notes from each other, and keeping history of each note separate.

If I am understanding you correctly, instead of keeping a commit history
of trees of many notes (one per sha1), we will have a tree of commit
histories, one history per sha1. What problem is this solving?

If I modify commit X and you modify commit Y, we avoid making a merge
commit. But so what? The merge would be trivial, since we did not modify
the same entries. The user never cares that there is a merge commit.

And if we both _did_ edit commit X, both cases result in a merge.

If we both modified X and Y, then you will presumably do the merge for X
and Y iteratively before you can create a new notes tree. Or you could
merge them separately. But why? Why would I want to pull some subset of
your notes (and keep in mind this is a subset of the commits you have
noted, not a semantically different notes namespace), and how would I
even specify which notes were of interest and which were not?

So what is the concrete use case where this helps?

-Peff
