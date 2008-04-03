From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and
	broken branch imports
Date: Wed, 02 Apr 2008 22:27:43 -0400
Organization: Cobite
Message-ID: <1207189663.17329.27.camel@gandalf.cobite.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <7vprt8838y.fsf@gitster.siamese.dyndns.org>
	 <1207187090.17329.15.camel@gandalf.cobite.com>
	 <7viqyz66b3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 04:28:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhFC0-0007Dn-Sb
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 04:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759835AbYDCC1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 22:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759504AbYDCC1y
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 22:27:54 -0400
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:53223 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758815AbYDCC1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 22:27:54 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id 9B3FEE1A05;
	Wed,  2 Apr 2008 22:27:53 -0400 (EDT)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dw99ejzrbyMj; Wed,  2 Apr 2008 22:27:46 -0400 (EDT)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id 81208DF4C2;
	Wed,  2 Apr 2008 22:27:46 -0400 (EDT)
In-Reply-To: <7viqyz66b3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78724>


On Wed, 2008-04-02 at 19:06 -0700, Junio C Hamano wrote:
> David Mansfield <david@cobite.com> writes:
> 
> > Also, how does the git packaging (non-rpm version) specify and/or
> > guarantee dependencies are at a certain version anyway?
> 
> We cannot really do much with the old cvsimport out in the field, but I
> was wondering more about automatic detection in new cvsimport.
> 
> The way I read 02-cvsps-implement-branch-point-detection.patch, you have
> three cases:
> 
>  - "Ancestor branch:" is not followed by "Branches:" before "Log:"
>    (old cvsps);
> 
>  - "Ancestor branch:" is followed by "Branches:" before "Log:" (new);
> 
>  - "Branches:" without "Ancestor branch:" (new);
> 
> So perhaps your 04-cvsimport-redo-branch-creation-process.patch, instead
> of ignoring what "Ancestor branch:" said, can remember it has seen what
> "ancestor" (which may be a bit off) information it was given, and when you
> see "Log:" (by that time, you either have seen "Branches:" from new cvsps,
> or you didn't see it from old cvsps) you can decide which vintage of cvsps
> it is reading from.
> 
> Or something like that.

Quite right.  And also, one of the failure modes I've found is based on
real abuse of cvs, and the result is that cvsps shows the branch as
occurring AFTER the first commit on that branch.  Anyway, it's all
nonsense and hand waiving after all.  cvsps just creates an illusion
anyway.

But to fix it, I'll need something similar to the code that I removed
anyway, so that will definitely be in the mix when all is said and done.

David
