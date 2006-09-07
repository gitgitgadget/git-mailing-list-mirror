From: linux@horizon.com
Subject: Re: A look at some alternative PACK file encodings
Date: 7 Sep 2006 15:22:30 -0400
Message-ID: <20060907192230.8764.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0609071322010.18635@xanadu.home>
Cc: git@vger.kernel.org, gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 07 21:23:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLPSW-0004lO-Ji
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 21:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWIGTWc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 15:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbWIGTWb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 15:22:31 -0400
Received: from science.horizon.com ([192.35.100.1]:36160 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751437AbWIGTWa
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 15:22:30 -0400
Received: (qmail 8765 invoked by uid 1000); 7 Sep 2006 15:22:30 -0400
To: linux@horizon.com, nico@cam.org
In-Reply-To: <Pine.LNX.4.64.0609071322010.18635@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26651>

> Well... I'm using object type 6 for deltas with offset reference 
> (instead of object type 7 that is delta with sha1 reference).  So 
> there is no extra bit needed and no backward compatibility breakage.

Ah, my apologies!  I didn't realize that you weren't constructing a
whole new pack format, or using a global flag.  In this case,
the overhead is already bought and paid for, so there's no point
to not taking advantage of it.

And thin packs should Just Work, once the builder is taught to
use type 7 objects when necessary.

> There could be of course a new object type which payload is only a sha1 
> that deltas type 6 reference. But that can be introduced at a later date 
> if it turns out to be worthwhile (i.e. the actual saving in real use 
> scenarios is worth the (small but still) added complexity).

In this case, it's only of potential benefit if there is more than
one reference to an object, and figuring it out is almost certainly
more trouble than it's worth.  Deltas usually form long skinny
chains, not high branching factor bushes.
