From: David Kastrup <dak@gnu.org>
Subject: Re: Consistency question
Date: Wed, 15 Jan 2014 14:00:30 +0100
Message-ID: <87ppnt7635.fsf@fencepost.gnu.org>
References: <8761pl8raj.fsf@fencepost.gnu.org>
	<20140115111330.GH14335@sigill.intra.peff.net>
	<871u098ocy.fsf@fencepost.gnu.org>
	<20140115124434.GA27030@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 15 14:00:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Q5E-0001Ry-DL
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 14:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbaAONAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 08:00:33 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:58827 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaAONAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 08:00:31 -0500
Received: from localhost ([127.0.0.1]:57868 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W3Q59-00068J-6c; Wed, 15 Jan 2014 08:00:31 -0500
Received: by lola (Postfix, from userid 1000)
	id 9B5EFDF673; Wed, 15 Jan 2014 14:00:30 +0100 (CET)
In-Reply-To: <20140115124434.GA27030@inner.h.apk.li> (Andreas Krey's message
	of "Wed, 15 Jan 2014 13:44:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240468>

Andreas Krey <a.krey@gmx.de> writes:

> On Wed, 15 Jan 2014 12:40:29 +0000, David Kastrup wrote:
> ...
>> With a single root, "depth" helps a lot.  When looking for a common
>> parent of a number of commits, you first shorten all ancestries to the
>> same size and then you can look for the point of convergence in
>> lockstep.
>
> Hmm, how about traversing from all the start commits downwards
> simultaneously, noting which start you say each commit from, and stopping
> when you have a commit carrying all start labels?

It means that when the start commits are at considerably different
depth, you'll traverse much more material than necessary.

Also you need labels.

> I don't quite see how the same size plus lockstep works out (but the
> 'same size' part is possibly the same as my 'concurrent traversal').

It just equalizes the depth before starting, so you don't need labels:
any common ancestor is reached at the same time by its descendants.

Of course, I conveniently forgot merge commits.  This scheme works out
of the box only with single parenting.  And it works fine without a
common ancestor, too: you just run into a NULL pointer at the same time
when there isn't one.

So, uh, this solution does not really seem to match the problem...

-- 
David Kastrup
