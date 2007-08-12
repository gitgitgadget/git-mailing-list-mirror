From: Jeff King <peff@peff.net>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 16:02:58 -0400
Message-ID: <20070812200258.GA13298@sigill.intra.peff.net>
References: <85ir7kq42k.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org> <85abswo9gf.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 22:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKJeX-0003uX-AC
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbXHLUDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbXHLUDG
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:03:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2277 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756161AbXHLUDE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 16:03:04 -0400
Received: (qmail 4893 invoked by uid 111); 12 Aug 2007 20:03:10 -0000
X-Spam-Status: No, hits=-1.2 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 12 Aug 2007 16:03:08 -0400
Received: (qmail 13681 invoked by uid 1000); 12 Aug 2007 20:02:58 -0000
Content-Disposition: inline
In-Reply-To: <85abswo9gf.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55715>

On Sun, Aug 12, 2007 at 09:10:24PM +0200, David Kastrup wrote:

> I'll probably be able to create a Gnus _backend_ for this sort of
> setup (there are even backends for directory browsing: most files

You can somewhat prototype this by just dumping the commits to an mbox
(sorry for the long lines):

git-log \
  --pretty=format:'From %H Mon Sep 17 00:00:00 2001%nFrom: %an <%ae>%nDate: %ad%nSubject: %s%nMessage-ID: <%H@none>%nReferences: %P%n%n%b' \
  | perl -pe 's/References: (.*)/"References: " .  %join(" ", map { "<" . $_ . "\@none>" } split \/ \/, $1)/e' \
  >mbox

Looking at an appreciably large chunk of history means that you will be
very far down in a subthread. mutt, at least, doesn't display this in a
very readable way. But my point is that you are probably better to look
at a couple of different view strategies just by dumping and tweaking
the references relationships (which really only takes about a second for
me on the git.git repository).

Also, have you tried looking at tig (make sure to try a recent version
and use the 'g' command to turn on the graph display)? I think it is
similar to what you are looking for, and I have found it to be very fast
(both in implementation and in usability).

-Peff
