From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
 generating message ids
Date: Thu, 24 May 2012 17:08:15 -0700
Message-ID: <7vipflunps.fsf@alter.siamese.dyndns.org>
References: <4FBE2335.2090903@jpk.com>
 <20120524171640.GB3161@sigill.intra.peff.net>
 <7vtxz5wdg8.fsf@alter.siamese.dyndns.org>
 <20120524201553.GA19990@sigill.intra.peff.net>
 <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 02:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXi4y-0005PJ-2f
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 02:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481Ab2EYAIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 20:08:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2EYAIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 20:08:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB8A085F5;
	Thu, 24 May 2012 20:08:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b1YVtwDEaiJKq6/MnXQ747Ikb40=; b=hCYTaF
	zHr31xbypKD07n2sTMFd9M85wudIq+VN5sQ1VNFdfxJZuZLb2CKaHDBkjke4UEyc
	JaWGQp6YGJSyDh2QTVQpHsef2fxJjZSWmfgTLIs6ku45UKEXFsdRGibE74bTPPMw
	hSD8tja+a3oyeGpplDNH7z53yQgi8pW3yiQyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXiZ6VQi8bda5EzqDrByJkCCB52adL0b
	6DG57hdJDuHARKVqnrpPWTrpVCDrnNCam7iYZWEJTKWIu46QGMQxqJwRoarNnYMf
	ksR/6d2oEwi2g7Yb7r3OHfCgPvAzA3gQ7qWf1L3rhEuWIJELgF3fvxodi3BaAXJW
	2yqbUiKb5cI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C286D85F4;
	Thu, 24 May 2012 20:08:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 270D585F1; Thu, 24 May 2012
 20:08:17 -0400 (EDT)
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 May 2012 19:25:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA7A2A06-A5FD-11E1-8323-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198452>

Jeff King <peff@peff.net> writes:

> On Thu, May 24, 2012 at 04:15:53PM -0400, Jeff King wrote:
>
>> > If you mean "why environment and not an API call?", then I would have to
>> > agree.  ident_committer_email() call, that returns a sanitized version,
>> > would have been a natural way to write this, if it were available.
>> 
>> I meant the latter. There is no such call, but I can make one. Let me
>> see how awkward it is.
>
> Here it is.
>
>   [1/7]: ident: refactor empty ident error message
>
> This one is only tangentially related. I was going to touch the message
> more in patch 3, but decided not to (details in that patch).
>
>   [2/7]: ident: refactor NO_DATE flag in fmt_ident
>   [3/7]: ident: let callers omit name with fmt_indent
>   [4/7]: format-patch: use GIT_COMMITTER_EMAIL in message ids
>
> These ones should fix Michael's failing test and restore the original
> behavior.
>
>   [5/7]: ident: rename IDENT_ERROR_ON_NO_NAME to IDENT_STRICT
>   [6/7]: ident: reject bogus email addresses with IDENT_STRICT
>   [7/7]: format-patch: do not use bogus email addresses in message ids
>
> These ones prevent bogus message ids from being generated at all
> (which is an improvement over the previous state).

All looked pretty straightforward and cleanly done.

We might want to further tighten 6/7 to verify user-supplied (i.e. non
default) e-mail for sanity, as I agree with the comment below --- lines of
that patch.

Also the check might want to be further tightened in the RFC 822/2822/5322
sense, but getting it correct will open a huge can of worms; I think the
check in 6/7 is a good place to stop, at least for now.

Thanks.
