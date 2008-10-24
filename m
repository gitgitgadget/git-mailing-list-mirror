From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* ext3: fix ext3_dx_readdir hash collision handling -
 Regression
Date: Fri, 24 Oct 2008 15:35:03 -0700
Message-ID: <7vk5bx1v1k.fsf@gitster.siamese.dyndns.org>
References: <20081022093201.GA2227@gentoox2.trippelsdorf.de>
 <20081023032832.GE10369@mit.edu>
 <20081023063740.GA2438@gentoox2.trippelsdorf.de>
 <20081024000109.GD7842@mit.edu>
 <20081024042851.GA2360@gentoox2.trippelsdorf.de>
 <alpine.LFD.2.00.0810240853310.3287@nehalem.linux-foundation.org>
 <7vwsfx1wnb.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0810241524350.3287@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:36:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtVGb-0007E5-Cb
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbYJXWfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYJXWfL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:35:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbYJXWfK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:35:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 882068F359;
	Fri, 24 Oct 2008 18:35:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 097998F357; Fri, 24 Oct 2008 18:35:05 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0810241524350.3287@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 24 Oct 2008 15:26:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 03AD9D1E-A21C-11DD-8DB8-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99077>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 24 Oct 2008, Junio C Hamano wrote:
>>
>> Subject: allow readdir(3) to return the same entry twice
>
> The thing is, this really is a kernel bug. We have even bisected it (and 
> it hasn't hit any released kernel). The original reporter showed it with a 
> simple "rm -r".
>
> So it really isn't a git bug, even though I initially thought it might be, 
> before I looked closer.
>
> That said, the git patch may be worth it just because two *concurrent* 
> invocations of "git clean" could then cause one (or both) to fail this 
> way.

Yeah, or on perhaps a buggy implementation of readdir(3) on somebody
else's system.  In either case, I just thought it might be a low impact
belt-and-suspenders fix that is worth considering.
