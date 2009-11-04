From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] use '--bisect-refs' as bisect rev machinery
 option
Date: Wed, 04 Nov 2009 13:52:48 -0800
Message-ID: <7vtyxaez4f.fsf@alter.siamese.dyndns.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org>
 <alpine.LFD.2.01.0911041033530.31845@localhost.localdomain>
 <7veioegko3.fsf@alter.siamese.dyndns.org>
 <200911042226.25599.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:53:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5nmr-0001Ln-4u
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 22:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbZKDVwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 16:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbZKDVwx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 16:52:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932984AbZKDVww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 16:52:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AFD774AA5;
	Wed,  4 Nov 2009 16:52:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZzMStmnDvLFwZJE/aBahM1FrPAg=; b=iC3PMH
	B1sOt4Yq4czxN9EFHAwolqs3lYHnksZNo2Q9cnnMmQ/5E2r+5e9beSMCTUwKMRBm
	3E6aUKRwy1N5Zs1g/5YoWfAL4KWjQ0h+Uv5Fu/q/pgsNzTafysL856h+h70o6ZDf
	v87WeS2BqriOxTEhck/P2G+8DPbcVWMpMd+HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yLzdcP2sBlFZWx2ces/mxgmClNy7kq90
	vX3/TZdNyp5W8aRShYw1fMyB4EFwwnH2k4HHzKALRqOXpNhkUNYUQmtGuCl2s23r
	GzkwaSa1QhtXCKf3tMBSIg/x5PXYCmJ4EtkpZtpTgWXPwLknt3V1g2+11CIyL9Em
	OmmAlCEcfhU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD41074AA4;
	Wed,  4 Nov 2009 16:52:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16A3474AA3; Wed,  4 Nov
 2009 16:52:49 -0500 (EST)
In-Reply-To: <200911042226.25599.chriscool@tuxfamily.org> (Christian Couder's
 message of "Wed\, 4 Nov 2009 22\:26\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 67941658-C98C-11DE-9054-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132158>

Christian Couder <chriscool@tuxfamily.org> writes:

> So to do that you would use "git bisect start ..." and then you could use:
>
> $ git rev-list --bisect HEAD --not $GOOD_COMMITS
>
> to get the commit that you would have to test if the current commit is bad 
> and:
>
> $ git rev-list --bisect  $BAD --not $GOOD_COMMITS HEAD
>
> to get the commit that you would have to test if the current commit is good.

Even in that case, the problem is still about narrowing the set of the
current bisection graph.  If --bisect option implicitly grabs good and bad
defined in the refspace like Linus's patch does, it will give you the same
behaviour of the above two commands, no?
