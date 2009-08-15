From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by
 casting void* to uintptr_t
Date: Fri, 14 Aug 2009 18:46:46 -0700
Message-ID: <7v8whl7ss9.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home>
 <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de> <alpine.LFD.2.01.0908141714040.3162@localhost.localdomain> <5HEgWEs64y4Ty7FnekstRP8Q71pNi_FTweLbMhYWc6zoZBA4jkJqpQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, nico@cam.org,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Aug 15 03:47:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc8MM-0000IU-Kv
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 03:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbZHOBq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 21:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbZHOBq6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 21:46:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbZHOBq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 21:46:57 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4073DB36A;
	Fri, 14 Aug 2009 21:46:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42E34B368; Fri, 14 Aug
 2009 21:46:48 -0400 (EDT)
In-Reply-To: <5HEgWEs64y4Ty7FnekstRP8Q71pNi_FTweLbMhYWc6zoZBA4jkJqpQ@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 14 Aug 2009 19\:44\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84D8E2E6-893D-11DE-B50E-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125973>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Linus Torvalds wrote:
>> I suspect it might as well be cast to "const char *", and then 
>> hopefully you only need one cast.
>> 
>> So maybe it could be written as
>> 
>> 	data = (const char *) data + len;
>> 
>> instead, and avoid the second cast (because the assignment should be ok, 
>> since it's assigning back to a "const void *").
>
> Yep, that's enough.  It produces an identical binary on all platforms
> except Solaris x86 using SUNWspro compiler.

Casting to "const char *" to tell compilers that we are interested in byte
address differences/increments makes sense to me, but I do not know how to
interpret your last comment.

Do you mean that SUNWspro compiler misbehave with the "cast to char *" and
do you meed your "casting to uintptr_t to explicitly compute byte
addresses as int" to make it behave?
