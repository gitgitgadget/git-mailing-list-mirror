From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --continue?
Date: Wed, 10 Feb 2010 16:04:19 -0500
Message-ID: <20100210210419.GA7728@coredump.intra.peff.net>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJjS-0006xw-Qc
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 22:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab0BJVER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 16:04:17 -0500
Received: from peff.net ([208.65.91.99]:37797 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755714Ab0BJVER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 16:04:17 -0500
Received: (qmail 8335 invoked by uid 107); 10 Feb 2010 21:04:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 16:04:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 16:04:19 -0500
Content-Disposition: inline
In-Reply-To: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139550>

On Wed, Feb 10, 2010 at 09:37:10PM +0100, Sverre Rabbelier wrote:

> At the moment git cherry-pick stands out from the sequencer tools in
> that it doesn't support --continue but requires you to manually supply
> the '-c ...' argument to 'git commit' when there's a conflict instead.
> Is it desirable that we add such an option? And if so, how would one
> go about implementing it?

I think it makes sense. It is perhaps a little iffy to use "continue"
when you are not really continuing on to further cherry-picks (and in a
rebase, continue is not just about resolving conflicts, but about
continuing to the next item in the rebase). Cherry-picks are more like
"am --resolved"[1].

But semantic nitpicks aside, I think "continue" is a good enough name.
The differences between what it means for each command are fairly
obvious based on the command, and there is real value in a user just
having to remember one verb.

-Peff

[1] On the other hand, I usually mistype that as "git am --continue",
which _does_ make sense, since you are applying a sequence of patches.
Maybe "am" should support both.
