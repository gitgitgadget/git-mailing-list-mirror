From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] stash: reject stash name starting with a dash.
Date: Tue, 18 Aug 2009 16:45:40 -0700
Message-ID: <7vocqc3cuz.fsf@alter.siamese.dyndns.org>
References: <7vbpmcc1sc.fsf@alter.siamese.dyndns.org>
 <1250631523-10524-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-2-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-3-git-send-email-Matthieu.Moy@imag.fr>
 <1250631523-10524-4-git-send-email-Matthieu.Moy@imag.fr>
 <20090818233535.GB6304@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:46:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdYNL-0000TW-HS
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZHRXpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbZHRXpt
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:45:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbZHRXpt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:45:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25E26F381;
	Tue, 18 Aug 2009 19:45:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7HxiVlkA5ik/P+M8wqW26dry0bc=; b=xaXApi
	wdLcdWJU5FZr9UhU7sNPwihYlg9Z0/5MJKAhbns6qmrMPpIl7L+quNcNJ5MIfqaD
	hyI0nWPn9N/SziPaoZJYrtMfuNW+8LLmliWIdlxb88GoJ3hScx6KJ/wXaKw54/mH
	rLDPewR1AOAXXXtxBIjmBTQB82sYOk8QR/Z48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZBeFCb3cLGiMS4kGPyWtHbgChBHm2jU
	A63GXTGd+HxA5Hy5pgXJ6HXyMeENUj4CLDMCV+Szn4/R8+g/LWzthQEWDI66Om6E
	8wneiBQhpjI/lIgnWIjemKu80U10U6GnwUJCdaA+pyGSfKoyAs2cRbulAQZEi3cW
	Qxx6WtgfXgs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E04EBF379;
	Tue, 18 Aug 2009 19:45:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 022D2F377; Tue, 18 Aug
 2009 19:45:41 -0400 (EDT)
In-Reply-To: <20090818233535.GB6304@sigill.intra.peff.net> (Jeff King's
 message of "Tue\, 18 Aug 2009 19\:35\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 406E424C-8C51-11DE-90CF-0D381FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126484>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 18, 2009 at 11:38:43PM +0200, Matthieu Moy wrote:
>
>> This avoids typos like 'git stash save --invalid-option', particularly
>> nasty since one can omit the 'save' subcommand. The syntax
>> 'git stash save -- "-name starting with dash" still allows such stash name.
>
> Aside from the documentation and usage lines, this one is actually
> independent of the other two, and I think makes sense regardless of what
> happens.

Yes, and I'd rather see it near 'maint' even if we were to (mind you, we
won't) reject all changes in 'next' on this program.

>> +test_expect_success 'stash --invalid-option' '
>> +       echo bar5 > file &&
>> +       echo bar6 > file2 &&
>> +       git add file2 &&
>> +       ! git stash --invalid-option &&
>> +       test bar5,bar6 = $(cat file),$(cat file2) &&
>> +       git stash -- -message-starting-with-dash &&
>> +       test bar,bar2 = $(cat file),$(cat file2)
>> +'
>
> Should this actually be "git stash save --invalid-option", since it is
> really testing the actual save option parsing, and not the behavior to
> automatically push options to "git stash save"?

It would be ideal if

	git stash save --invalid-option

failed, while

	git stash --invalid-option should be trapped

and/or

	git stash "--invalid-option should be trapped"

are accepted as valid quickie ways to name a WIP stash before attending to
an unrelated emergency.
