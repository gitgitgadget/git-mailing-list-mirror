From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make :/ accept a regex rather than a fixed pattern
Date: Fri, 18 Jun 2010 10:03:21 -0700
Message-ID: <7vhbl0xoh2.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1005131457350.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 18 19:03:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPeyf-0001OI-EF
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 19:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933739Ab0FRRDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 13:03:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761107Ab0FRRDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 13:03:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ACC33BDCA3;
	Fri, 18 Jun 2010 13:03:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3CEr3pWX8qOd1LoMSeCIkXVG6q4=; b=kNhsj8
	2tIzxT8Um4/CfaT5jZx5CMRpJ8w7pFq3FRePNr1fx3e166b7tswvzteBVw0/csBd
	4JRjQWWP/BvzF3VuU6e3BJ8iQcCNi8uStwNYqJE4v2Cc61MnGz5z31LnPKy/jl2I
	290sqNDbikrcre2fyPbvWF28Tce0SgN1yCoiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QIOl7ZxOPlN4VYMChHA/VLnSwr9sKpaq
	c4G7+mA920hJsCcos/n/l1jIOfRqgkBbM20OhNw4L6kzVb3H0qizUdSa+5aIYDqc
	i4SjNB5qzsV7/A4AceZbZZ/JuegQrnKpzwM1FPrpEZvQtaMzPHxjF3XEbltZge0G
	Ig4++Rq4Pz0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77AE2BDCA1;
	Fri, 18 Jun 2010 13:03:26 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F018BDCA0; Fri, 18 Jun
 2010 13:03:23 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1005131457350.3711@i5.linux-foundation.org>
 (Linus Torvalds's message of "Thu\, 13 May 2010 15\:08\:42 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 692F3DE6-7AFB-11DF-A87E-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149351>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 23 Apr 2010 08:20:20 -0700
> Subject: [PATCH] Make :/ accept a regex rather than a fixed pattern
>
> This also makes it trigger anywhere in the commit message, rather than
> just at the beginning. Which tends to be a lot more useful.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> I'm re-sending, because after having this in my tree for several weeks 
> now, I actually end up still using it. 
>
> I agree that it's still not a wonderful thing, and it's entirely possible 
> that we should strive to use just HEAD in :/ commit finding rather than 
> all refs we can find, but for at least the kernel, I don't care (since my 
> tree tends to have just one main branch anyway, apart from some random 
> testing stuff I keep around).
>
> But even if we want to limit it to HEAD, that would be a separate patch.
>
> I've personally used it for things like
>
> 	git show :/mqueue	# did I apply that 'mqueue' patch?
> 	git show :/akpm		# what was the last patch I got from Andrew?
>
> and while in all cases I could admittedly have done exactly the same thing 
> with something like "git log -p -1 --grep=mqueue" instead, I've used it as 
> a nice shortcut.

I already took this but I actually started hating it.  As I have
merge.summary on,

    git show ':/diff: add configuration option'

almost never hits the commit I am looking for---instead it ends up finding
a merge that merges it.

I however suspect that I would hate it much less after retraining my
fingers to anchor the pattern at the beginning of the line.  But not
yet...
