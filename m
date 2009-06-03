From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 03 Jun 2009 15:02:26 -0700
Message-ID: <7v8wk96knh.fsf@alter.siamese.dyndns.org>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	<20090602213439.GA7584@coredump.intra.peff.net>
	<alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
	<7vfxeidqoz.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
	<7vtz2x6mor.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 00:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MByXa-0001wt-2t
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 00:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbZFCWC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 18:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbZFCWCZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 18:02:25 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47730 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbZFCWCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 18:02:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603220227.XCIO20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jun 2009 18:02:27 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id za2S1b00G4aMwMQ04a2Sh0; Wed, 03 Jun 2009 18:02:26 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=vab_pU7WfN8A:10 a=vn0Xwkm_Dc8A:10
 a=Z4Rwk6OoAAAA:8 a=QHvTi-3oklD9oPFDZyQA:9 a=mQ8aFHxPbI-wua1drrXoOt5710cA:4
 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> (Linus Torvalds's message of "Wed\, 3 Jun 2009 14\:33\:39 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120652>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The original problem was:
>
>  - create new file 'x' in branch 'a'
>
>  - merge branch 'a' into branch 'b', but because of a merge conflict and 
>    confurion in the merge, the merge result doesn't contain 'x' any more.
>
>  - try to find out what happened to 'x' after-the-fact.
>
> Try it. Git really doesn't make it very easy, because git will notice that 
> 'x' didn't exist before the branch either (in branch 'b'), so there will 
> be _no_ sign of 'x' actually going away.

That is true.  The "crude attempt" patch I just sent actually catches
this, but it does not show the lossage of "new" in the "diff/diffstat"
part of the merge, when run with "git log --stat -- x".  Besides, it shows
too many other uninteresting "merged two branches, resolving to lossage of
the path the same way as all the previous merges" to be really useful.
