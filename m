From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sat, 09 Feb 2008 20:09:50 -0800
Message-ID: <7vy79t4fld.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
	<alpine.LSU.1.00.0802100110450.11591@racer.site>
	<alpine.LFD.1.00.0802091720010.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO3Wv-0001NQ-S2
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755889AbYBJEKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755887AbYBJEKE
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:10:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869AbYBJEKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:10:02 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D4A9F3383;
	Sat,  9 Feb 2008 23:10:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E4323382;
	Sat,  9 Feb 2008 23:09:55 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802091720010.2896@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 9 Feb 2008 17:22:20 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73308>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The real issue is that it doesn't work. I thought about it, and with 
> multiple roots (which _can_ get merged together) it just isn't something 
> that actually helps.
>
> If you couldn't merge across roots, you could have a "uuid+generation 
> header", but the moment you have multiple roots it actually gets quite 
> complex.
>
> So scratch the generation header.  It's not the answer.

I do not think multiple roots can be helped without going all
the way down to the roots, and I think it can be proven.

> And I do think that we can do it without it. I'm still thinking about how 
> to do it efficiently, but I think I can get there. I just haven't had the 
> time to sit down and really think it through and try out my ideas yet.

Generation number would on the other hand eliminate the issue of
clock skew if heads are connected, and I think it also can be
proven.

Both proofs need the axiom "there is no loop in the commit
ancestry graph", but that is something we already rely on in the
merge-base computation.
