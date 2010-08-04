From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] struct *_struct
Date: Wed, 04 Aug 2010 12:24:29 -0700
Message-ID: <7vaap2fafm.fsf@alter.siamese.dyndns.org>
References: <20100804150843.GA2762@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 21:24:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgjaF-0004X2-FN
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 21:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635Ab0HDTYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 15:24:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306Ab0HDTYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 15:24:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1F35CAAAF;
	Wed,  4 Aug 2010 15:24:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WmlXD8GOxG7UyyNiLAwH+a87IUY=; b=WQmLeV
	uXuwBmK2SOFM9ZyN5hiplPHeC2Xz+LfhWWTuxE/wz8hHkdoPxA8q0MSue7TUTz8O
	onaLSPeY+cjGWJyL/vykwtFnhaDvz8wyQWTyS/qvhhILrrobcXzGnPqFieLFPpFD
	12Lb94V7RXK6UeD5Cd1vTFMKyJgxStR/KatdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZVGFPryPDDCYE8xHUzczpvQRQPariVFJ
	bzYNvcuJkf1ZU+WlrVgX2oULtzk28GC3snxj7mLzJHE7UWduqOTQdMu7C/MKofEP
	K6yP/DcL6R8ZFEmnwijIwv+F9c8/U6EjJAsisjLJU4x5v3ld3qRNXIw5GX92d0w1
	LeSlYtMU84M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFC87CAAAC;
	Wed,  4 Aug 2010 15:24:33 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19923CAAAA; Wed,  4 Aug
 2010 15:24:30 -0400 (EDT)
In-Reply-To: <20100804150843.GA2762@localhost.localdomain> (Jared Hance's
 message of "Wed\, 4 Aug 2010 11\:08\:43 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9785ABA-9FFD-11DF-849F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152597>

Jared Hance <jaredhance@gmail.com> writes:

>     - We use this style in only 3 cases

I think they were early-days inertia between me and Linus.  I hate "struct
foo_struct" (and "typedef foo struct foo") myself and that is why we don't
see many others.

I am personally Ok if you want to give them more sensible names.  Doing
s/_struct$// is a no-brainer for "diff_queue_struct", but I do not think
doing that alone would be a good idea for "cmd_struct" and "dir_struct".

I'd suggest calling the former "cmd_desc", as it is a set of info on a
single command.  "dir_struct" is a table that records a set of paths in
the whole work tree and it is not about a single directory (nor a single
entry in that table, which is "dir_entry"); as such "dir" that sounds too
similar to DIR that is what opendir() returns (i.e. a single directory)
may probably not be a good name for it.
