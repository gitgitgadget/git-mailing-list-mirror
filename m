From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Wed, 29 Aug 2012 22:26:18 -0700
Message-ID: <7vzk5dt0g5.fsf@alter.siamese.dyndns.org>
References: <5030F0BF.2090500@alum.mit.edu>
 <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> <7vk3wktiph.fsf@alter.siamese.dyndns.org> <503D973D.8040402@alum.mit.edu> <7vmx1exmde.fsf@alter.siamese.dyndns.org> <503DCFAE.6060307@alum.mit.edu> <7vy5kxwtdo.fsf@alter.siamese.dyndns.org> <503EEDF3.2080202@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Aug 30 07:27:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6xHX-0003CR-1M
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 07:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173Ab2H3F0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 01:26:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038Ab2H3F0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 01:26:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CDAE9B77;
	Thu, 30 Aug 2012 01:26:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gzAX8NfLbcEgTavT34VQncTXVOg=; b=fOj1Kl
	JvR0sQiBvFLa5AFHURCU2aMoXXvfUpQz+Rrfjsci1hBKmZMKsHD3E5qEXLS9rOu5
	UTGqMJJp/ujFDyj8Oj1xP7qkmGxEwt4/pL6Nc2ZD/D0yO76bdOdBdV7oSptI5sXa
	dqnQu8ynHDUlS/KrJpy+22/TQptnMvv2UoBaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BcPrtQqQfB+aEVo1HcUEviKXyNL2jeE9
	bmBw5sfjtZdPjE85KGVPf9OnYtKZ1hzASWRQBF2JasSJjHAPZ9NMWgtbv0g0Dyv5
	ivxKOr0zap3nHCbsXmMSH4ABZUSBE9bbFIrhvbkF3OUNkW4RbcGR5HGh980BVu7V
	qUon2cuY+wk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50A039B76;
	Thu, 30 Aug 2012 01:26:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0BF59B75; Thu, 30 Aug 2012
 01:26:19 -0400 (EDT)
In-Reply-To: <503EEDF3.2080202@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 30 Aug 2012 06:37:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AA3B3B2-F263-11E1-B4C1-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204523>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> By the way, is the use of realpath(3) permissible in git code?
> GIT_CEILING_DIRECTORIES handling could be fixed relatively easily by
> using this function to canonicalize pathnames before comparison.

As long as we can add a compat/realpath.c (perhaps lift one from
glibc before they went GPLv3) for platforms that matter, I do not
see it as a huge problem.  How close is abspath.c::real_path() to
what you need?

> [1] This would be analogous to the inclusion of a space in "trash
> directory.*", which I presume was done to detect space-handling problems
> quickly.

Yeah, understood where you are coming from, and I think I can agree
with where you are trying to go.
