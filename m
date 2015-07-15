From: Jeff King <peff@peff.net>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 11:57:18 -0700
Message-ID: <20150715185717.GA11146@peff.net>
References: <20150714073035.GA22707@aepfle.de>
 <20150714074508.GE1451@serenity.lan>
 <20150714075955.GA24577@aepfle.de>
 <CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
 <xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
 <CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
 <xmqqy4ihwbdr.fsf@gitster.dls.corp.google.com>
 <CA+55aFw=PJtc7jXLUx+tJhAeVO3vpQjsd+oYW+OwCU20_Qft-w@mail.gmail.com>
 <xmqqtwt5wai9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Olaf Hering <olaf@aepfle.de>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 20:57:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFRrz-0003Ie-4U
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 20:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbbGOS5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 14:57:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:59860 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753285AbbGOS5W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 14:57:22 -0400
Received: (qmail 10066 invoked by uid 102); 15 Jul 2015 18:57:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Jul 2015 13:57:21 -0500
Received: (qmail 18032 invoked by uid 107); 15 Jul 2015 18:57:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Jul 2015 14:57:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jul 2015 11:57:18 -0700
Content-Disposition: inline
In-Reply-To: <xmqqtwt5wai9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273993>

On Wed, Jul 15, 2015 at 11:17:50AM -0700, Junio C Hamano wrote:

> > So this is a suggested change to "-p -m" behavior?
> 
> Not really.  This is a suggested behaviour for "git log -p"; I
> wasn't very enthused by the idea to turn --cc when user said -p
> without telling them what we are doing.  In other words, if the
> users want combined, they should say --cc (and they will get a
> single-parent patch for non-merges with --cc) so there is no reason
> not to do this, as long as we fix --cc so that "git log --cc"
> implies "git log --cc -p".

Like you, I frequently use "--first-parent -m". If I understand your
proposal, a regular "git log" would have the first-parent-diff behavior
of those options, but still traverse other parents.

One oddity of that proposal is that the user ends up seeing any given
change on a side-branch _twice_. Once in the original commit that
introduced it, and once in the merge of the branch. And commit-selection
tools like "git log -Ssome_code" will select both, too, and they'll see
the merge commit along with the original. I can't decide if that's a
good thing or not.

-Peff
