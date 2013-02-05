From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 04 Feb 2013 16:15:47 -0800
Message-ID: <7vmwvjzkcs.fsf@alter.siamese.dyndns.org>
References: <87ehgvua6h.fsf@lifelogs.com>
 <20130204211726.GB13186@sigill.intra.peff.net>
 <87mwvjsqjc.fsf_-_@lifelogs.com> <7vd2wf1yex.fsf@alter.siamese.dyndns.org>
 <87bobzslke.fsf@lifelogs.com> <7vy5f3zlzj.fsf@alter.siamese.dyndns.org>
 <87zjzjr5y4.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 01:16:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2WCs-0003dU-OP
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 01:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572Ab3BEAPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 19:15:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab3BEAPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 19:15:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 063B4BF4C;
	Mon,  4 Feb 2013 19:15:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CTfw9QE68QjiwiTCZ+kAW74+/nc=; b=WqlPmo
	GOkFKsnNmhL4tYj5kZ5tMA6EDEZ3SLmgQP9YvMK6SxbdyfgJrFXqAqkFq/G1kEIh
	aSMd7NEUH1Diw6VpY8lVv7XR0/Qs8+t6Gkq6bmjb+w0rxB4ml5LMIA1Fl4lqfjbi
	giTYPLRd9gwLiGw3PS79VaHplDCRwnxr0X3Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GzmblMoAY1OpwUw/w3o/duEBh+9wSWqs
	voH/9GxcyY3XOafCHM4w/uT39VbJar782QjSgzrXXLvJsKlnFbWvMkT1kUFjQNzf
	knRoy0Pd2gAuQ5vdg9a5hJB3jUDampLUxioavckRViXQBBWHXAMF0vGJ519dU6LH
	t1SjOy/REUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEC17BF4A;
	Mon,  4 Feb 2013 19:15:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70E27BF47; Mon,  4 Feb 2013
 19:15:49 -0500 (EST)
In-Reply-To: <87zjzjr5y4.fsf@lifelogs.com> (Ted Zlatanov's message of "Mon,
 04 Feb 2013 18:54:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31D1B2B4-6F29-11E2-8C5E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215438>

Ted Zlatanov <tzz@lifelogs.com> writes:

> On Mon, 04 Feb 2013 15:40:32 -0800 Junio C Hamano <gitster@pobox.com> wrote: 
>
> JCH> "Sorry we couldn't" sounded like an error messag to me.  If this is
> JCH> a normal exit, then please make sure it is a normal exit.
>
> OK; done in PATCHv4: removed all "Sorry" because they are not abnormal
> exits.  I'll hold PATCHv4 until the below are known.
>
> JCH> The review cycle is not like reviewers give you instructions and
> JCH> designs and you blindly implement them.  It is a creative process
> JCH> where you show the design and a clear implementation of that design.
>
> OK.  I would like you to make the decisions I asked for, though:
>
> - do you want to support backslashed newlines?

What for?  netrc/authinfo is not a line oriented file format at all,
and

	machine k.org
	        	login me
                        password mysecret

is a single entry; you do not need backslash at the end of any line.

Perhaps you are asking something different?

> - do you want me to remove the statement modifiers?

I do not think we are at that "implementation nitpick" level yet.

> - should all die() calls just print to STDERR and exit(0)?

Where "when unhandled, the helper should silently exit with 0" is
expected by the invoker, we shouldn't say anything to error stream,
and exit with zero.  Please leave a comment to make it easy to
understand to the readers that is what is going on there.

If on the other hand it diagnosed an error (not a bug in the
implementation but a misconfiguration on the user's side), I _think_
it should loudly die() so that the user can notice and take
corrective action.

> - do you want to support multiple netrc files, as you and Peff suggested?

I didn't even suggest such thing IIRC---I expected it to iterate
from the most desirable (.authinfo.gpg) to the least (.netrc) and
stop at the first found one.  There may be use cases people use more
than one and expect an entry to be found in any file, but I suspect
that might be more confusing than it is worth.  But I do not care
very deeply myself either way.
