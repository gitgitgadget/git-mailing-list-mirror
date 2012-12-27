From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "fatal: git-write-tree: error building trees" from `git stash`
Date: Thu, 27 Dec 2012 11:21:47 -0800
Message-ID: <7vlicjl2r8.fsf@alter.siamese.dyndns.org>
References: <1356631626.13818.126.camel@umgah.localdomain>
 <7vsj6rl456.fsf@alter.siamese.dyndns.org>
 <1356634556.13818.136.camel@umgah.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Thu Dec 27 20:22:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToJ1u-00006C-6t
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 20:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab2L0TVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 14:21:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab2L0TVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 14:21:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD681A1A2;
	Thu, 27 Dec 2012 14:21:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUyIN9h/e7oL0EsRvmB3tLXz4+E=; b=Bx2kit
	quoxP5DSREJen00+kI3yl2RTJIZxI8aWfjjBk+61F/+1A4FKnpuTDVyvcs/xqdOx
	4eHPIZsgnLoepfN/vGPnKX1R25bwrb5d2FDrreYBFHmUJlfuC5yZaRs1zFW93SqR
	eBchWBDAPeqxByxsH6HvBcaMcnUc/r7FWBNCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oTs3ypHUHZmpswAoOEJTwXHPnW9Lpfy1
	R6kc2umPI2HN0UcEQeanpbep6HMALBocXSjqpZFS7oMJxb0Pf6sQx4lBzHEc7d4Y
	S43dorCcgv/8EGgP9iwc1ajZEcb5BQAhWyl7slK5m689VGxGCGjvzAE0usjsDZgr
	qvP+KR4RSns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B9EEA1A1;
	Thu, 27 Dec 2012 14:21:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19BA0A1A0; Thu, 27 Dec 2012
 14:21:49 -0500 (EST)
In-Reply-To: <1356634556.13818.136.camel@umgah.localdomain> (Alex Vandiver's
 message of "Thu, 27 Dec 2012 13:55:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A93C8308-505A-11E2-8CAA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212213>

Alex Vandiver <alex@chmrr.net> writes:

> ... "Cannot stash while resolving conflicts" or similar would be
> more understandable to the end user than the above.

Interestingly enough, the "apply" side is protected with this one
liner:

        # current index state
        c_tree=$(git write-tree) ||
                die "$(gettext "Cannot apply a stash in the middle of a merge")"

since 5fd448f (git stash: Give friendlier errors when there is
nothing to apply, 2009-08-11).  I would think something in line with
that change on the "create" side is a welcome one.

Thanks.
