From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sat, 09 Feb 2008 20:21:50 -0800
Message-ID: <7vd4r54f1d.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
	<alpine.LSU.1.00.0802100110450.11591@racer.site>
	<alpine.LFD.1.00.0802091720010.2896@woody.linux-foundation.org>
	<7vy79t4fld.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 05:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO3i5-0002yp-QC
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYBJEV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYBJEV7
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:21:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbYBJEV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:21:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 45E2036D2;
	Sat,  9 Feb 2008 23:21:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E7E36CF;
	Sat,  9 Feb 2008 23:21:52 -0500 (EST)
In-Reply-To: <7vy79t4fld.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 09 Feb 2008 20:09:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73311>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> The real issue is that it doesn't work. I thought about it, and with 
>> multiple roots (which _can_ get merged together) it just isn't something 
>> that actually helps.
>>
>> If you couldn't merge across roots, you could have a "uuid+generation 
>> header", but the moment you have multiple roots it actually gets quite 
>> complex.
>>
>> So scratch the generation header.  It's not the answer.
>
> I do not think multiple roots can be helped without going all
> the way down to the roots, and I think it can be proven.

Ah, please scratch that comment.  I was puzzled but did not
understand what you meant by uuid+generation.

You are right.  If we cannot tell if we are dealing with
disconnected history, we would always need to play safe and do
the clean-up like what I suggested earlier using merge-base
traversal, which could be costly, and we do not want to pay that
penalty in a connected history, which should be the normal case.

Generation header does not help us detect that case, so it is
not useful.
