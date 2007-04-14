From: Jeff King <peff@peff.net>
Subject: Re: [RFD] Strange patch formats (aka tricks with unified diffs)..
Date: Sat, 14 Apr 2007 06:09:23 -0400
Message-ID: <20070414100923.GA6546@sigill.intra.peff.net>
References: <Pine.LNX.4.64.0704121436050.4061@woody.linux-foundation.org> <17951.6252.457936.428919@cargo.ozlabs.ibm.com> <46a038f90704122307i76f96029n75425410bc40ad82@mail.gmail.com> <7v3b34hjdh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704141051350.18846@racer.site> <7vbqhrb7r2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 12:09:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcfCM-0000rM-1o
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 12:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206AbXDNKJ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 06:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbXDNKJ2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 06:09:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4863 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206AbXDNKJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 06:09:28 -0400
Received: (qmail 5169 invoked from network); 14 Apr 2007 10:10:09 -0000
Received: from sigill.intra.peff.net (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 14 Apr 2007 10:10:09 -0000
Received: (qmail 6611 invoked by uid 1000); 14 Apr 2007 10:09:23 -0000
Content-Disposition: inline
In-Reply-To: <7vbqhrb7r2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44457>

On Sat, Apr 14, 2007 at 02:55:13AM -0700, Junio C Hamano wrote:

> One sensible behaviour would be to show exactly the same output
> lines as the regular output, but color-code only the words that
> changed.  E.g (the words are capitalized to illustrate instead
> of colored here):

That works great for highlighting a small change between two very
similar lines (and I think that is one use of --color-words). However,
it's terrible for the other use of color words, which is showing changes
which are not well-adapted to line oriented diffs (such as flowed text).

Try this:

cat >orig <<EOF
this is a paragraph that has
some text in it and is wrapped
at 30 characters
EOF

cat >rewrapped <<EOF
this is yet another paragraph
that has some text in it and
is wrapped at 30 characters
EOF

git-diff --color orig rewrapped
git-diff --color-words orig rewrapped


I think one behavior is best for one situation, and the other behavior
for another situation. Perhaps there is room for two modes?

-Peff
