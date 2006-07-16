From: linux@horizon.com
Subject: Re: [PATCH] array index mixup
Date: 16 Jul 2006 14:12:28 -0400
Message-ID: <20060716181228.25231.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Sun Jul 16 20:12:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2B6j-0005uY-5b
	for gcvg-git@gmane.org; Sun, 16 Jul 2006 20:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWGPSMd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Jul 2006 14:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWGPSMd
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Jul 2006 14:12:33 -0400
Received: from science.horizon.com ([192.35.100.1]:60974 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751119AbWGPSMd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jul 2006 14:12:33 -0400
Received: (qmail 25232 invoked by uid 1000); 16 Jul 2006 14:12:28 -0400
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23954>

> *1* If somebody wants to do this, one thing to watch out for is
> matching up of broken pairs.  If a pair originally broken by
> diffcore-break (because they were dissimilar enough according to
> the option given to -B flag) are merged into one by
> diffcore-rename (because they were similar enough according to
> the option given to -M flag), we should _not_ say the resulting
> pair is renamed.  In general, the threashold for breaking should
> be lower than diffcore-rename to merge them for a sane use, so
> this might be a non-issue in practice, though.

Er... no.  You want to be fairly aggressive when doing both things.
That is, you want to break aggressively so you can look for a better
match elsewhere, but once you've found the best match, you don't want to
be shy about accepting it.

Pulling numbers out of thin air, say break if 1/3 of a file has
changed (66% common), and merge if you have 33% common.  Or maybe
even less.  The point of break then merge is to give you a chance
to find the 90% common file that has a new name.

I always understood that the reason for having two thresholds
is exactly so they can have this relationship, not the opposite
one as you suggest.
